Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DB606A332
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DuXCp9k1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVFWNxA1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4970B40674;
	Mon, 23 Nov 2026 09:21:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TeFg1G0W-r5e; Mon, 23 Nov 2026 09:21:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D7A14061F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795425701;
	b=Z2zEN0nXYHo4oSooW43kke0OnKlK4FmAqKID2qXU6aXD490iBgabOak8OJa7FQD2lSbL
	 5QkMYZbZ07KFIDLuaWVv80WUXBfVMBmVFKqcwXiWzOOCxmmb/xMzYcWddrXXrfBaxtI+C
	 +sc/rrz0Bl2v6h7arWcGJ51Waa+H8+LslObxif7Y35l0xyxGyRwVnKms1bgBULtYSPr3M
	 M4Oj1tx5/R2I5SfQDZ2Bcn2Sp0fppLTdRc5BlxVAEqnYQwZza4ydLqR+Rtbqlp2aOP6K2
	 2J3zYhk5LMRpG9F2d5AzQwbyrwmEu3hSvpTwwsadyBhnG/QiUXPhCbvfAvoUUQy0TUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795425701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bJP/CPH5zrub3+aV6asA66bt4mUji6T6mfoJLN9Obc0=;
	b=Vl08QkD2MWDCt+ptXbIkNE2c7aNNoV7AFeBk3baxZTF14gVe5TgrE/nEOY+vyQ4LPpCV
	 dQZvjoWGjd2cPSilQAxaRmg81mtPUMOORtPS/GHGU+y1XIGRGCzoWVyWvKOZgeLsNOLMz
	 LozhlEZ15EBU9zkrLxxA9+cQlwdEUZzoFNTa7NgjZCxKRQb+Ug2hT006ZaZXLVVWknGE1
	 ANvNpV2KDl4EyFJFy3ScYZARd3a/bqe596uKmfRwxajexkF4r2XKnxsCKBMFznI3PbdA+
	 WZy2E4FjlppFcZVWUxYY5RK0m4naeYWyck5/PUo3pulMGBXgBVf5k7fZX04BCdHyIJg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795425701;
	bh=bJP/CPH5zrub3+aV6asA66bt4mUji6T6mfoJLN9Obc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DuXCp9k1BqdfGXMcMcAUiXkVXkcskq2YT8eNWsSZG+Pw2g3kH/ssDZRcf+HiQJrP5
	 HJ7T/kfpVnPi1ccuuNnEWJRvoPGcg5P9tGdGDBLmRMVo4bK8M+Jom5Tm7b9ikVMn3O
	 ESM3xYSHsNvxVjp2Zx/W+r1T6PbuLtEtBKGPQj9Qq5yApRFjMScBZnOePNetzATyoq
	 TJIFK6kM6zQbCKbbtQta7m4JSdEr1by8vYpHJNCmXI3Kq5n+tEKX8GszRCw2yofyZh
	 NrXWFK93inJTO5J9SM3OWGaZNAF+TxEpr3Kji0mVlPyKVNv6pwLUpi7YtYZDP8ST46
	 czqceE1mzLYog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D7A14061F;
	Mon, 23 Nov 2026 09:21:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 22518260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 141FB606F5
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rh758AwxEEL7 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:21:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EFD1C606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f35; helo=mail-qv1-xf35.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IVFWNxA1
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EFD1C606B0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:21:38 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-9213eb1f3a7so25923806d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 01:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795425697; x=1796030497;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bJP/CPH5zrub3+aV6asA66bt4mUji6T6mfoJLN9Obc0=;
 b=IVFWNxA11DWtlDjz9ZGZmo5K+Sbq0E5rbC1/cENTBpBmNgT5dWpWYpMsG06WfitUny
 bjeYPFP+hQGuNPQ9HT9iSgKJwNOxNdIRGJrY3IMYSRznf5+nbvHqbcH7nO8lwnV0L2Ll
 Li9O3tV+Frd1wFRXLusNVkP8Clfs/oTSXBbkkh11jt29q8050EarR7F5jBWnyVsFLK+T
 93iKNLw2j06UX708JOKKdV4b9ml8rVK+dtYsefa+s/NwZtbc/n09Bmo2kLuXLqFKXza3
 VrTzshW+8Q30QTzxrR2jsRkRwttlYmhnalhbgTMoRe7Qw162+gyocAUn9DkMdfdAzz8v
 NSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795425697; x=1796030497;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bJP/CPH5zrub3+aV6asA66bt4mUji6T6mfoJLN9Obc0=;
 b=dg/J2dkPCJ6vdO7c7wfGB+OoSDMlTXtGZ6IF9m/RLtPjqbRcPNPngmuK7g/UxfBcUl
 yu2vNqmiW8uFvRABvWAmSfy2yhCoryMrkKgiGdU4KpfS92qLFljjYMs55bYCRJHl5Prb
 yZrsoa2QzpTeqM+nypQkn5YLfeUDmoLTAkak6U1VR6y9W5nPwGUroNkRS0NfatCSrKP9
 I8BoOSVTe0rFcXOYbzYBr+wenSAic/lxm3guf2MoRVyc8Y6o9Jpj1JOD3fMJcXqCxXY4
 S0E+2CYCM+1BJ6q9smcedtKEIBs6eQJ2lGtFlc5/xUBdAmeSWZRHI8SgHfRysqlfcmKT
 LSvQ==
X-Gm-Message-State: APuU4Z8Z3nj94e1PuC03FEqmaXsgFB5RnrqXe8bBcq8nKqFO2VOxdhdc
 nmUeeD79t7xlKw4A/5dVAW1BdO5/LSAqn0D57ZJg03+TDKjWv7YqXnGCIjXPpAlHN5lRiyfjcYJ
 e2xoQgrIaW39DAh2d40pCE7uclQNlUI8hYMj4qMY=
X-Gm-Gg: AZFdTZcWZQyOEbxzQQ+7YA8LHh/SFu5U597Dysy0XL3Fu2jp7P6GFMzs8eh3sFHbyv+
 vPFwXdopDoSku+dFypNAOylriprgd2peB6CnCQo7HaaJKO4tqgSgtrA8DqO1uoc9yPqKauIRr6b
 /ZaRLcTVxVOXH7v6uLIhxn5Q6S71Je9tm4waNcdNB5kEr2nDGKBTsuOPCkDYuTtSBalH5PwUCUt
 bevELpdLZUGe9rHgGO6GG8H0uzJ2uaU440hYL9sOJ4iz2dEJKQ+IXxZpcs7AnIaXcUHg+LIRgKl
 uYPoonJUQHB7N4PQjXqwWKOHUu+We9wshd4aGf99VO1TN8F6OvpZUDJ3RInMpkpYSPdNNRMB2+N
 h+FXLVtZXV/MTvNKh3e6Q+WS+Rqch0rYFH3+2tSmrwKR/4j1IqQ8vFAHRP+mI5MXGcgOHPjzumD
 6OASbpPzbx10LPNkBIjwSVnfOcFMlQWaSLk/ei10ky+s26Ju0XlIp36/CIuZxL2QdR7EhrKDxQ4
 wA9/52qsFWl1RMMjuC52UR8c8kM+ZuISjQ=
X-Received: by 2002:a05:6214:318b:b0:921:1042:c46e with SMTP id
 6a1803df08f44-92134b32b0cmr189859796d6.33.1795425697462; Mon, 23 Nov 2026
 01:21:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123052301.473945-1-hs@nabladev.com>
In-Reply-To: <20261123052301.473945-1-hs@nabladev.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 23 Nov 2026 09:21:25 +0000
X-Gm-Features: Aa3M54pfk5h2D27Uu5VUJSSXCcQ4SXaj5l1-Lc2Ycq_Gqb8wN0M1uYQ3NIFBa_A
Message-ID: <CALeDE9PYCb7NV4ME=LxJBY1myS7Wq2BeXgmrYkMg8A6KOwfaqQ@mail.gmail.com>
Subject: Re: [PATCH v1] Update maintainers and get_maintainer.ignore
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: multipart/alternative; boundary="000000000000eb00cd0660ee1ec9"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000eb00cd0660ee1ec9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 at 05:23, Heiko Schocher <hs@nabladev.com> wrote:

> Dinesh has left Altera (Info from Alif Zakuan Yaslami) and
> has not changed yet his email address.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
 Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

> ---
>
>  .get_maintainer.ignore | 1 +
>  MAINTAINERS            | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> index 76b816a4d56..ed350dc4d2b 100644
> --- a/.get_maintainer.ignore
> +++ b/.get_maintainer.ignore
> @@ -1,3 +1,4 @@
> +Dinesh <dinesh.maniyam@altera.com>
>  Pali Roh=C3=A1r <pali@kernel.org>
>  Simon Glass <simon.glass@canonical.com>
>  Simon Glass <sjg@chromium.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6edf740a9ce..33af5ed3075 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1137,8 +1137,7 @@ T:        git
> https://git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git
>  F:     drivers/i2c/
>
>  I3C
> -M:     Dinesh <dinesh.maniyam@altera.com>
> -S:     Maintained
> +S:     Orphan
>  T:     git https://git.u-boot-project.org/u-boot/u-boot.git
>  F:     cmd/i3c.c
>  F:     drivers/i3c/
> ---
> base-commit: e578056c766d653270b14557c2a9d8daec414c17
> branch: maintainerupdate
>
> --
> 2.55.0
>
>

--000000000000eb00cd0660ee1ec9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Nov =
2026 at 05:23, Heiko Schocher &lt;<a href=3D"mailto:hs@nabladev.com">hs@nab=
ladev.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Dinesh has left Altera (Info from Alif Zakuan Yaslami) and<br>
has not changed yet his email address.<br>
<br>
Signed-off-by: Heiko Schocher &lt;<a href=3D"mailto:hs@nabladev.com" target=
=3D"_blank">hs@nabladev.com</a>&gt;<br></blockquote><div>=C2=A0Reviewed-by:=
 Peter Robinson &lt;<a href=3D"mailto:pbrobinson@gmail.com">pbrobinson@gmai=
l.com</a>&gt;</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
<br>
=C2=A0.get_maintainer.ignore | 1 +<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 3 +--<br>
=C2=A02 files changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore<br>
index 76b816a4d56..ed350dc4d2b 100644<br>
--- a/.get_maintainer.ignore<br>
+++ b/.get_maintainer.ignore<br>
@@ -1,3 +1,4 @@<br>
+Dinesh &lt;<a href=3D"mailto:dinesh.maniyam@altera.com" target=3D"_blank">=
dinesh.maniyam@altera.com</a>&gt;<br>
=C2=A0Pali Roh=C3=A1r &lt;<a href=3D"mailto:pali@kernel.org" target=3D"_bla=
nk">pali@kernel.org</a>&gt;<br>
=C2=A0Simon Glass &lt;<a href=3D"mailto:simon.glass@canonical.com" target=
=3D"_blank">simon.glass@canonical.com</a>&gt;<br>
=C2=A0Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org" target=3D"_blank"=
>sjg@chromium.org</a>&gt;<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 6edf740a9ce..33af5ed3075 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1137,8 +1137,7 @@ T:=C2=A0 =C2=A0 =C2=A0 =C2=A0 git <a href=3D"https://=
git.u-boot-project.org/u-boot/custodians/u-boot-i2c.git" rel=3D"noreferrer"=
 target=3D"_blank">https://git.u-boot-project.org/u-boot/custodians/u-boot-=
i2c.git</a><br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/i2c/<br>
<br>
=C2=A0I3C<br>
-M:=C2=A0 =C2=A0 =C2=A0Dinesh &lt;<a href=3D"mailto:dinesh.maniyam@altera.c=
om" target=3D"_blank">dinesh.maniyam@altera.com</a>&gt;<br>
-S:=C2=A0 =C2=A0 =C2=A0Maintained<br>
+S:=C2=A0 =C2=A0 =C2=A0Orphan<br>
=C2=A0T:=C2=A0 =C2=A0 =C2=A0git <a href=3D"https://git.u-boot-project.org/u=
-boot/u-boot.git" rel=3D"noreferrer" target=3D"_blank">https://git.u-boot-p=
roject.org/u-boot/u-boot.git</a><br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0cmd/i3c.c<br>
=C2=A0F:=C2=A0 =C2=A0 =C2=A0drivers/i3c/<br>
---<br>
base-commit: e578056c766d653270b14557c2a9d8daec414c17<br>
branch: maintainerupdate<br>
<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000eb00cd0660ee1ec9--
