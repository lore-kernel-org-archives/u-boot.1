Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F202C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 21:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B3B87E63;
	Fri,  2 Feb 2024 22:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FTvvO6h6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F39C487E63; Fri,  2 Feb 2024 22:27:47 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CE987DFC
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 22:27:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40fb7427044so5102065e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706909265; x=1707514065; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TzgyOY/urQcgO9+tXlmpqy0ShqBb/RN6o4Lpn3O0mc8=;
 b=FTvvO6h62gVzniLtPQKYl8Rs84B1OwM/86Yj1PfptP4cyw/iaDBBOztQLk41N72Slg
 1dltXYsCXPOwH3cOR6gwzYguz3hNGVUqHOrA7vPMkA/Y9H0sPibiwI1OpmQoWWWBxtvS
 C5ew4Y48zls0NUEu+wo80d4Vvv5CJlQmYGAlGdpaUXRcWf67/zN7MWnb2wt5+VbpAQZT
 xYSRvSySqfVJOzk+A5qdBmpVTuqv+ZSJ5xGzQeNtcupnKEnmKeIyP64A0rn41ZpeiDOc
 bvQeMLgtFkWJdhf9SQPkOG5qy588OUPc8sXV7ixQo6tvQAUZXA3T3qDjYled3tWSg4le
 EOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706909265; x=1707514065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzgyOY/urQcgO9+tXlmpqy0ShqBb/RN6o4Lpn3O0mc8=;
 b=BVd/anxDt7FVPAaWG7/itWG0Bb9G0sNKGjxfIsbu+YQtdz7bxQl2dUF7cw5gqMiSer
 CjFH3jOGBO6GsLLewOfAhYQoAg76KmbmPozAfR4pP67ZO5XtindUXnPBoYGa4Ry0n2vB
 qhSD8BFjI3/stOxPyLTneaYqZ1QteXcoeq6KGZhfB7r3GICmb+/ljOuDUmnfTphIUZFA
 9l4rrGWQxPaDCHmrEooM6BNm61wLfGeVX/B2T9GE3jPcYGZ01v7aXnwox3/t/a0LP08K
 sw2w16wbRjsSQ4KBQBlC8z2EQ9TZKUr3eQcxsxFpkeaFluo4rdJj5JkeWzMj2nKmsWCx
 o7pA==
X-Forwarded-Encrypted: i=0;
 AJvYcCVgh3C/DV8pNd84YgOX0IB0gqu48+HO4vdrpceUSlqE74pdM9fMy7i0o2x83s5UziyATvxV7cHIheVFEe3bkk3zaeV1og==
X-Gm-Message-State: AOJu0YzV94FYUplywY25ESjJ1TamP8uRKegvTd9omEOhiQ3qZVp3DCTg
 8QN0AfnzipNr9TtE+Fo0F+G0+L+fHxxk2K8UN8x7oTMd8A7fUWeuAA2fWeod6ei0wXH8ZADFdy1
 e5YtzvBSIZ2WAQ/bVqwdVGYTY4rc=
X-Google-Smtp-Source: AGHT+IEf5l95/UQ/IdYqgyAyWK6glhXcnMR0x9FIrnFS9zWIvVcaC4cBMKF/4u9o8DKsOg63zpW7p/dCkFPCygD5P/c=
X-Received: by 2002:a5d:43ce:0:b0:33b:1a51:733c with SMTP id
 v14-20020a5d43ce000000b0033b1a51733cmr3585792wrr.6.1706909264746; Fri, 02 Feb
 2024 13:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20240131173204.100407-1-jpaulo.silvagoncalves@gmail.com>
In-Reply-To: <20240131173204.100407-1-jpaulo.silvagoncalves@gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Fri, 2 Feb 2024 22:27:32 +0100
Message-ID: <CAByghJZzuFaw1yZ8gRKxBJKNZ8WcHztje+E+okQJ-ZjUx1N1Sg@mail.gmail.com>
Subject: Re: [PATCH] toradex: tdx-cfg-block: add 0086 i.mx8m mini sku
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Jan 31, 2024 at 6:32=E2=80=AFPM Joao Paulo Goncalves
<jpaulo.silvagoncalves@gmail.com> wrote:
>
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>
> Add new product id 0086 Verdin iMX8M Mini DualLite 2GB IT.
>
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> ---
>
> Hello,
>
> The change was based on u-boot-imx/master-next because of [1].
>
> [1] https://lore.kernel.org/u-boot/20240122200930.673447-1-jpaulo.silvago=
ncalves@gmail.com/
>
> Best Regards,
> Joao Paulo Goncalves
>
>  board/toradex/common/tdx-cfg-block.c | 1 +
>  board/toradex/common/tdx-cfg-block.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/board/toradex/common/tdx-cfg-block.c b/board/toradex/common/=
tdx-cfg-block.c
> index 3f2f6b94391..4a7de5483d2 100644
> --- a/board/toradex/common/tdx-cfg-block.c
> +++ b/board/toradex/common/tdx-cfg-block.c
> @@ -156,6 +156,7 @@ const struct toradex_som toradex_modules[] =3D {
>         [83] =3D { "Apalis iMX6Q 1GB",                     TARGET_IS_ENAB=
LED(APALIS_IMX6)     },
>         [84] =3D { "Apalis iMX6D 1GB IT",                  TARGET_IS_ENAB=
LED(APALIS_IMX6)     },
>         [85] =3D { "Apalis iMX6Q 2GB IT",                  TARGET_IS_ENAB=
LED(APALIS_IMX6)     },
> +       [86] =3D { "Verdin iMX8M Mini DualLite 2GB IT",    TARGET_IS_ENAB=
LED(VERDIN_IMX8MM)   },
>  };
>
>  struct pid4list {
> diff --git a/board/toradex/common/tdx-cfg-block.h b/board/toradex/common/=
tdx-cfg-block.h
> index b783537ce76..021cc21b5e2 100644
> --- a/board/toradex/common/tdx-cfg-block.h
> +++ b/board/toradex/common/tdx-cfg-block.h
> @@ -111,6 +111,7 @@ enum {
>         APALIS_IMX6Q_NOWINCE,
>         APALIS_IMX6D_IT_NOWINCE,
>         APALIS_IMX6Q_IT_NOWINCE, /* 85 */
> +       VERDIN_IMX8MMDL_2G_IT,
>  };
>
>  enum {
> --
> 2.34.1

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+48 666 108 041
http://ua.linkedin.com/in/iopaniuk
