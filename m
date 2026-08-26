Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D211C61DBE
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 11:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 141A180BA2;
	Wed, 26 Aug 2026 11:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AhZ1vKn3bdqv; Wed, 26 Aug 2026 11:04:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787742279;
	bh=BVRS6R5EF9nuJohXgr/VHEE0JYMtFv99oxrxbReTJD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=phQCaUM5hay1HxcCmzGynHphebN2K3SDREbPGkRnhwP6lhgmZ7M97DboH8nA0QINm
	 IJO4uTNjvh4z0iSjCmmU/FH9wohkRwTryj+Vx9vhCUBDi+qMQlrylv/WTHJJzlr/t8
	 zIR1zA5NSdICH7fo28CsxvPQM9lLw6PF60dU4GNyESbSruNsTQ/uNSfXrbst3VytcO
	 QMJEXDL3/2TrsC738UvMoVkL62hPAKnlgNEDxad4baeACer9mGfRkzrLXh+pxONwQP
	 HqF+Py39+QL1ysGdb7mgJVzsvjD+7dEmX/C5Qbt+Y+WCpzHbMkaF7FZ6E78gVL4wri
	 JdLYFr+3ZC86A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EF5080B99;
	Wed, 26 Aug 2026 11:04:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4227F230
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 287F980B99
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7Bh8a7p6Upg for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 11:04:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p7naPind
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5083980B97
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 11:04:36 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66d0c8d0d6eso748683d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 04:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787742275; cv=none;
 d=google.com; s=arc-20260327;
 b=hYk0P1O8KD+z4niY6eEobtblKpazGHLHZ1lYi+ctwML7k7OJRZU1Ri3OtRUnxSuYUc
 udtIVD+BTUTvVtFXmoBUws/Yke06DTcnR/1Za4WVuzVuiSIORhjYKYchRoOJuYDy2GET
 8MoTD+2bBPYE8Gj0Ekuf+/gVvYo4v/MDZN18ZF0DJ9+6aps2kaqf8X+G5ONa20tYIqnW
 iXHKDHgEJH9M8a8cjvt1/zvJKkoWsA91179YVI/RF57/u00B+yEmNW8xwp51RqPCDJze
 N0Cw4OwPC3gbCdeSZk0mGqUTd8JlZpRLpmTVp7FGksJV1rf5pIK/RSTjWEomY07dwwps
 GDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BVRS6R5EF9nuJohXgr/VHEE0JYMtFv99oxrxbReTJD0=;
 fh=+3P6d+dg3SRe0ESje8SXPVI5omHHCBVbtS5Fmn93KlA=;
 b=jVvT80rr4RCcxPU9e1NNBx23xxkRpX2JTRSu4Fh0MnIC1BT8UWwy4exHsMTiOGMRC3
 lem0tl3w3tUBBnh1PQC93DCgxL8lhb+tpEmmrtUT3UWDgo2Abp7I8w45Hg4c8wZEuzzU
 A5jg73FKGhCvulGJyug5YX7Fz+wz+3vWPANe/cAMLjz9q0u1mgrfgQDblXHVZOHvBHMe
 1Ea7/kCxJf09I5zgRmRttflcajoagkBHjBim4FeCrLzbeuKCcqX676jH7XWi9tINAEP2
 m2E18NMhcRhx5Kcc5+VRLSODeNE6XyaZwgGyW0C8XOzRhI/91NwMu1rJrKrL8qExSS7i
 c5kw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787742275; x=1788347075;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BVRS6R5EF9nuJohXgr/VHEE0JYMtFv99oxrxbReTJD0=;
 b=p7naPindru4YRjivGup86MAPhuXUM/69ZkvkZHPWc13SLY5Gm0ny6X/gZ2Gkozm9B2
 14bEo435/ESl76wq3OTRfP5F7LGFAJ43tMbjfmUW8wCsLTeKKs3+3nLLZ9ePvUa4FoCV
 ypAbaVIDeiB2giOt1ho7+Yd1T2ydxcGPcsKf4rYkR6mep9OVZD1R68Vwu78mnW9Al3al
 uZZ+PPy0JjIy31V1X5rWHhoW7PpqiYATP5Qtgw7JNV43XvI4rDdxkRwwZmtJCmdRGkEw
 nhpYZvQNm8OYs521WOyg4CPhv9S5RxSM2NZbE18EoNUDocDYVyQFrlved9QpZi/VD86u
 q7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787742275; x=1788347075;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BVRS6R5EF9nuJohXgr/VHEE0JYMtFv99oxrxbReTJD0=;
 b=VCXk5uYA5QOhNe5Haj8nAuCQS2ojVf3Qn0MkwLyxSiuo5iPOwJg9rPFBg+y8FZKgnb
 2BSB4AsbrKFuo8QVBfNl2Eh7t7k8KhUmgc0WJuq+3yrchCOoCxixCkf1kQNvEC8vNELV
 QnUqB57q3W03sqriZCSYJJH0lj7GFjZf7fgQTcLjYShbNCd5YDWh4zoH99Jcu52mY9xx
 YijBr0t6WtxiBQZSbGjx1yrpjrQzkNajmrK9unGjcnxQxBv3Gd352iCk4gfjA33fqYbM
 Th1Y7J+bRB9EJ7SlM0UZ+Zm9Qn9xMRTXKcxauAm3lPR8nolfvz6a1kifRt1qBvWZTa4M
 I2eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhKkJYRGtWkjiL9N9rpPPkVTeSn54cOnOgYqnuyr6mxxVtolyAPggBEYyIasLNZAvNAYHR/DA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lx9cn9qd8wvgcroTEFaIWzB1suj9cHXZeGGwWvgtLhvyq4nYuo
 F/EyJnZrrHem9/DqrkomIbPkZAVvetq27cq2TAtEAPQ7NqaarBTSBiXWpl2rkgxG/zy08UxoG+l
 EyMQ2upt8+xxAp+XjCq1r1Y3dz4hmylOm0fOHpP5oxg==
X-Gm-Gg: AR+sD12S/ZWrGlgwKuaNskqcYtiJ4Zqx2KCFzRZKaA+dO/2mihGM0BVtNr2zsXmPExV
 h8rvkD9T/kg+hYA5+MSekl0ALCr/DLFa+Cp1UwQVdGAl3EEDuauWI668sWk7b2PZJPOe0W/3ThQ
 7ZixIq3JQLCJU59SRryp6Cv/c698/8uSqQ77JaCUWKkF/XZ8xZ+D3+FoeZEAKxxc7ExSrvekZ9w
 NYxE0z/z1rxeWeLbbYVPZdmkZNpkAI824t+DIIawfkydgXCReY3/bhri3mvx6fAK6AgQd/YVm4w
 T0qnMFz2VcEYHU2SvVS569gt9PzyHNSRC/8ck5wg5iT97TR2JKJV0Ned0AKeT/KgaB6J+CFMECN
 HcNM8WYX624vTcSay90DkJ9pMsHYWv5Wog8bvmwufoYI6adkVUv0uYgRZlXh7ajlFggRf9LH9Ng
 1hRoENEyl8NKmMyft87F9rbfBrwzy3QeY/nEKut1qK1zN0H7A5xhhwSefmkZtfht9J8P+KyU1EB
 ziFjtMgP6M+oyoHylJdpQGKKmIpul/8WrwQWN0YuigGdy046Q2HO6sm4R/RDmKoQXNEUJvjZQPJ
 2mpFcas9IXz0Cf/Mafs3zrxism5Q+99wIw+pdUy4WUMUcYL/IquRc1L3l3kf42s4udW7pJrNHJ0
 c8g2jP93OTJG3lLsvkWkX3/5eiuB0a/fi40LjiGJPTSg=
X-Received: by 2002:a05:690e:439b:b0:66c:e8ad:7bef with SMTP id
 956f58d0204a3-66d2df088f7mr248405d50.30.1787742275210; Wed, 26 Aug 2026
 04:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260820072645.9884-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 14:03:58 +0300
X-Gm-Features: AcwNN1W3qUz-7lyyVMtJFI5Vuet14qXvLRG2RiqwhthXF5JA492dE6Jzjfauzak
Message-ID: <CAC_iWjKNt6T=p5P_UOr-6GR4SryhYR+3KooPUK0ozSPexG=EqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: build mkeficapsule for
 CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Linus Walleij <linusw@kernel.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="00000000000043a3d90659f12fd0"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--00000000000043a3d90659f12fd0
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 10:26, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> Currently we build mkeficapsule by default even if we don't have EFI
> capsule support enabled. This adds a host GnuTLS build dependency.
>
> Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=y.
>
> tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=y.
> Hence distro packages like Debian's u-boot-tools will still contain
> mkeficapsule.
>
> Reported-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>

 Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  tools/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/Kconfig b/tools/Kconfig
> index ef33295b8ec..e151b30217e 100644
> --- a/tools/Kconfig
> +++ b/tools/Kconfig
> @@ -108,7 +108,7 @@ config TOOLS_SHA512
>
>  config TOOLS_MKEFICAPSULE
>         bool "Build efimkcapsule command"
> -       default y if EFI_LOADER
> +       default y if EFI_HAVE_CAPSULE_SUPPORT
>         help
>           This command allows users to create a UEFI capsule file and,
>           optionally sign that file. If you want to enable UEFI capsule
> --
> 2.53.0
>
>

--00000000000043a3d90659f12fd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 20 Aug 2=
026 at 10:26, Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchardt=
@canonical.com">heinrich.schuchardt@canonical.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Currently we build mkefica=
psule by default even if we don&#39;t have EFI<br>
capsule support enabled. This adds a host GnuTLS build dependency.<br>
<br>
Only build mkeficapsule by default if CONFIG_EFI_HAVE_CAPSULE_SUPPORT=3Dy.<=
br>
<br>
tools-only_defconfig explicitly selects CONFIG_TOOLS_MKEFICAPSULE=3Dy.<br>
Hence distro packages like Debian&#39;s u-boot-tools will still contain<br>
mkeficapsule.<br>
<br>
Reported-by: Linus Walleij &lt;<a href=3D"mailto:linusw@kernel.org" target=
=3D"_blank">linusw@kernel.org</a>&gt;<br>
Signed-off-by: Heinrich Schuchardt &lt;<a href=3D"mailto:heinrich.schuchard=
t@canonical.com" target=3D"_blank">heinrich.schuchardt@canonical.com</a>&gt=
;<br></blockquote><div><br></div><div>=C2=A0<span style=3D"background-color=
:transparent">Reviewed-by: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apa=
lodimas@linaro.org">ilias.apalodimas@linaro.org</a>&gt;</span></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0tools/Kconfig | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tools/Kconfig b/tools/Kconfig<br>
index ef33295b8ec..e151b30217e 100644<br>
--- a/tools/Kconfig<br>
+++ b/tools/Kconfig<br>
@@ -108,7 +108,7 @@ config TOOLS_SHA512<br>
<br>
=C2=A0config TOOLS_MKEFICAPSULE<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool &quot;Build efimkcapsule command&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0default y if EFI_LOADER<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default y if EFI_HAVE_CAPSULE_SUPPORT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 help<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This command allows users to create a UE=
FI capsule file and,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 optionally sign that file. If you want t=
o enable UEFI capsule<br>
-- <br>
2.53.0<br>
<br>
</blockquote></div></div>

--00000000000043a3d90659f12fd0--
