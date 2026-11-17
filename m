Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A2606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nhkPbwE3;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NoFoXOH5
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D27A40889;
	Tue, 17 Nov 2026 16:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lPyCsCVDodrD; Tue, 17 Nov 2026 16:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E39554088F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794931707;
	b=WNSwGbJ4w+zGJI+D//jmeCWX8556FudKP2NCJbo1gEbyZ95HmYlGiVZ7Gg2mwpFsQiYZ
	 83zlhYDuYPiwv1xBglpqrXXrKGbpiuP7Ig703KXnIyWyTUbrKXd+8c0cXDlDKkjMAgd8U
	 b+bwA/0VIpNtScfA1yW7RGY9YX1BFo3hJytG75UL7MepDV50RQJcNBKCl0vGuipsOgQii
	 bZ/cv3TH9zEyLIMP+sI7VqMw9W1cGKjwQpl/g8HQB7/fVyhAdWiHXSQBKm8kd5lJrmpI4
	 PhdoIwltc8GM0pJSAaOEhK/yOZbcVXJSfw7UBd7lxq/FvcJXhpdJL9ErsvcJOiDn5/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794931707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NDsr8MORLUXCI4MuE6aaEXD/3sQVUGurF9iK3InUGK4=;
	b=qjT+H/1JLxQH5++8fnbwJWTKs/qrQld1w/lNJIXa+nYBsWysuK0BVh0q7QEfqlaKuDf9
	 0Hz6TTh8gtkjxcEw4+Yo4Whon9QBJlaAwDL07HXoT8zARyAYszoh+W35voLJXQ6uVMVjw
	 ZqGGI46zZGvLB5/7QlT7MtqHZ27Hr+EA42fhY9yO/qSBqyTRy1XwXsVDY9npz89c2denH
	 cA4vkjBT2t7rDgmzehdLKSAmxi3BxCU5dsqGNg+tjHRpzTsLBG3nF7SCT1etfKd7Ndoj6
	 GHF9w2heKEg2jIWgj8tx9JqhNyVUGJhJ1ZhAJodbp3rX9zonnpqBkI0w97Y+utrVxvg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794931707;
	bh=NDsr8MORLUXCI4MuE6aaEXD/3sQVUGurF9iK3InUGK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nhkPbwE3aOlkkRN2ZXAJR2S40a2m1aGOkUsNqJ4Jgj37a0ALWsGa09Fi7mdL7z9ow
	 UDBQ4PGZ5gEVRYwE/av/u/QNvF7v3I91yn6U2NNuGunG2nTpR8KNCFVxRxIhTpk3K6
	 QPG/+jkFJf9vJAbc6cPS5QOjkqmHaMigBI0wFSTImEt2ZejLEMnOd5X8jwCXvwmQiC
	 HHK7JucrV1O+wJesEsznRlzNz+VfaOj9vX17Ck5dZ3/nzHnfjQI+VZVOquawkfeZjN
	 2eW7m2VWOFVbB9FqYEiizxpwxzuIMmglE9mUmoc8YIT7gOZzk187AXqD37pgaom1iq
	 6GaMyGxHr8bAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E39554088F;
	Tue, 17 Nov 2026 16:08:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CE3304A0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BFE134037A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:08:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5gHJhnIjmTMX for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 16:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CCB264035D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2d; helo=mail-qv1-xf2d.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=NoFoXOH5
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CCB264035D
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 16:08:22 +0000 (UTC)
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-91eb449364cso68144316d6.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794931701; x=1795536501;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NDsr8MORLUXCI4MuE6aaEXD/3sQVUGurF9iK3InUGK4=;
 b=NoFoXOH5B/rmprbl4aZtZEK54LMD3edYJU4MkkS+5d1E3KeRH4G6d09E2wZjUIKeqG
 iIYICD8Qmq0/6ouLKY2FQvjRzpV8w2B3SuBQ2SYGwq4Rt3RrSvXZgI4Ft8zsZhs15OYp
 vZyxGlufkW48o9SRzyX8Wg0bhxrMwzZOwE6uXfPAj8xjQ8VsKZ6w/h+K3HarvV94fw/7
 wzrLWzEYQgoHSwdBZNuKkmYo71IlQLBlFKoHU+WGtGsrQ5BLXDYZ3HmaGQCU5kJyT/Uv
 TE9/LLcSKSRBLYnR+AS81WG4x0qujWu1BiBQu3ilTK6ni2eHDWMxwv0wuPZu1z4Llp4G
 8+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794931701; x=1795536501;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NDsr8MORLUXCI4MuE6aaEXD/3sQVUGurF9iK3InUGK4=;
 b=RiN2KSgbx0IsObL2mJu0GuqRYCct++CK0LeFtFcLt1D+qDBhLx7zIs2RIzId5Qw/Td
 vgOjsDZW7bTuDB40fstgNoxsOGef88w30oB+Gs1lW++6n8X0l+oOLeRJ3OQY/Qn2t7+n
 JJQbNcNw74Pqg/YMfl8JIOPwZzGo3m6iDulu8DkF5CFxYGxK02UH0KdvpNFzXpVLAFMN
 Xe5DEowl/1/6GZ1N61Ulnm8BmAhBmvzxlZP9NkGoqbz0KKo9P4+fNZaYn57+Dsh15bRD
 vwerUL4WLVRGDBDrGFJAeA+M/nLkDMN9W81ajz+2o+/X4vOwRgRm/+89nRTaYgauGDQA
 K1hA==
X-Gm-Message-State: APuU4Z85bV+V0z7TqzVnCAfQ5t7WOQhJz1a6qSRdPcNVoN2QJ9A4ZDrP
 +f7VHKfwMymrUpZz8x+mlTW05LuKuLrrdOvb0wNjacNnYzTqpuXqbLYMEchCA24CFZ0N3G2MMYe
 c+1iBoZi4qTVWYwemRcDn69ByMPz3ynDcpg==
X-Gm-Gg: AZFdTZe+XAJJuJfvVpfFKJc0qxG6YUoPA/9T+HYrU5iYi7q+YtZeKbPkEsI1yDDsl8D
 F3U4OuFRTphoqM/RplGk9Zk/FLb0ApsVHtWSpc9o/g2eOK+WyYXTkSihWNBTZTdgb2sE+QHxhNj
 DJ2aPS36sCjmr4NYiqqhuooaVgUoVEVg82vUlYYTqauZvD7Ol5i6gLKbWJR2mn6+3/Y68c3aDKg
 RUcjmD1V/qf/6Tit+JW0vxoQHFRd6KXwo6gHNODpdqZ8Uj6goGJEqFWu03eskSuq1sN2mEYKCQL
 lLKabBTzllzASH/jw8GuTiyLF5dVd6C2vDaWyuPCajjKX/SPSbqcMJaWv0Im/QPyPQ8Nuyf10hC
 buPNqBnJtZRGNzK28vOZHGSan9YpHtGH0mA1bcji5axKafpdL4QMTzEf6hrbPbo4zRCA6Q6sI29
 dY0v5WFnIS91ceMra5AXzRDUSNT71AJitFnfPY8w2imKgEcnP9aa0DrSL6dl7mS/UkUvWAcOyco
 JFrHLiPMhb/xfNC2PCR1MSJ5kFAuvL9xp0=
X-Received: by 2002:a05:6214:e86:b0:921:1008:f356 with SMTP id
 6a1803df08f44-9211008f50emr14927156d6.8.1794931701320; Tue, 17 Nov 2026
 08:08:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111093212.3390778-1-pbrobinson@gmail.com>
 <20261113145107.GA1199710@bill-the-cat>
In-Reply-To: <20261113145107.GA1199710@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 17 Nov 2026 16:08:07 +0000
X-Gm-Features: Aa3M54o9FDHKN9hNUBBxn5FRlvZ7IHpI1UwXmgW5CIL3CvROzK6fsTy2pFPph4A
Message-ID: <CALeDE9ONicupsLsf69DKA9vgi-a=xyr5CKYZMc7Bg86Z5Kyj8g@mail.gmail.com>
Subject: Re: [PATCH] disable VBE by default
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000074124806607b1a4d"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000074124806607b1a4d
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Nov 2026 at 14:51, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Nov 11, 2026 at 09:32:09AM +0000, Peter Robinson wrote:
>
> > The VBE protocol needs explicit device support and as
> > such isn't particularly useful by itself without that,
> > it also adds size and the potential of an attack vector
> > so devices that wish to use this protocol should
> > explicitly opt in to it like all other large features
> > in U-Boot.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  boot/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/boot/Kconfig b/boot/Kconfig
> > index 8fcdc36c931..556e868a5f4 100644
> > --- a/boot/Kconfig
> > +++ b/boot/Kconfig
> > @@ -720,7 +720,6 @@ config BOOTMETH_QFW
> >  config BOOTMETH_VBE
> >       bool "Bootdev support for Verified Boot for Embedded"
> >       depends on FIT
> > -     default y
>

What you mention below looks like two different things:


> This needs to be default y if SANDBOX so CI still passes, due to all the
> tests.


The above makes sense.


> I'd say we need to update the tests except for all the numbering
> issues that's likely to uncover and that we'll be dropping VBE as the
> follow-up step.


Due you mean this as a follow up? Do you have a link to what you're
referring to?

--00000000000074124806607b1a4d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 13 Nov =
2026 at 14:51, Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@kon=
sulko.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Wed, Nov 11, 2026 at 09:32:09AM +0000, Peter Robinson wrote:<=
br>
<br>
&gt; The VBE protocol needs explicit device support and as<br>
&gt; such isn&#39;t particularly useful by itself without that,<br>
&gt; it also adds size and the potential of an attack vector<br>
&gt; so devices that wish to use this protocol should<br>
&gt; explicitly opt in to it like all other large features<br>
&gt; in U-Boot.<br>
&gt; <br>
&gt; Signed-off-by: Peter Robinson &lt;<a href=3D"mailto:pbrobinson@gmail.c=
om" target=3D"_blank">pbrobinson@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 boot/Kconfig | 1 -<br>
&gt;=C2=A0 1 file changed, 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/boot/Kconfig b/boot/Kconfig<br>
&gt; index 8fcdc36c931..556e868a5f4 100644<br>
&gt; --- a/boot/Kconfig<br>
&gt; +++ b/boot/Kconfig<br>
&gt; @@ -720,7 +720,6 @@ config BOOTMETH_QFW<br>
&gt;=C2=A0 config BOOTMETH_VBE<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Bootdev support for Verified Boot=
 for Embedded&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on FIT<br>
&gt; -=C2=A0 =C2=A0 =C2=A0default y<br></blockquote><div><br></div><div>Wha=
t you mention below looks like two different things:</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
This needs to be default y if SANDBOX so CI still passes, due to all the<br=
>
tests.</blockquote><div><br></div><div>The above makes sense.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;d say we n=
eed to update the tests except for all the numbering<br>
issues that&#39;s likely to uncover and that we&#39;ll be dropping VBE as t=
he<br>
follow-up step.</blockquote><div><br></div><div>Due you mean this as a foll=
ow up? Do you have a link to what you&#39;re referring to?=C2=A0</div></div=
></div>

--00000000000074124806607b1a4d--
