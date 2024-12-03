Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC710E64A89
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C9198948B;
	Tue,  3 Dec 2024 14:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JejHu6Nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB74D895CE; Tue,  3 Dec 2024 07:29:10 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FA8E895E0
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 07:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29e842cb9b4so381368fac.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 22:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733207347; x=1733812147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IR39IcE9Ua6Alfakih6gELxfwQ7nWGLT15i3YQ1XVOI=;
 b=JejHu6NdCq2uUDv9mIlNX9F/z3VpirkPuuSMlQrQk1RxTG3MrBCFwnY4QAbfYMJ0zJ
 Vn309rq3ZQa0A53fT7oSGRxn0ZRbGQoEPr10NtLgRmw6BFJvaEKJbc2T18ET4hZLp1KB
 MOOkCTbvo/jbCYTB2C4dpA/3xv+NBNqz9pvZPt11hYQQK5yqZj2ZwvfrFHlqtYJykTRp
 QResLbPlaStS+UXpegxLw23tpXtQ5wFtZgFVSaC7xQ8b3O3JjrhWEIvRazk5zJCVsjXe
 U3UVo3Hghy7MVvoKO1ZfmseY9vV/h5jRnh8geSvDQ85zgXi2ZhYC9lbosrjCIsm36+RY
 VMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733207347; x=1733812147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IR39IcE9Ua6Alfakih6gELxfwQ7nWGLT15i3YQ1XVOI=;
 b=jq8yfLP0RLBxGTMYVPiVHJAyug8GCtCWkpTyh12MKKhuCXOqJpW9AblLAqShpEqqE0
 anckDtVdUgqGe1NCUUUQGZqfsbq4GkQBlfzDL8f4V2EQIk1HeYjq00FsGc0eMg/MVMdb
 4eHsc7IHfzDu7p4nxlADAiTA2jZmRVQEVGhUW4yHhQQVgYhx9dElCm4EEgkDR1eJzaNE
 v3rTzyxjTqvJTOtdJXWmFj6h03D8/KuoyYyba3Os7XaTYxmJh9Mhy+6E6B5ckX4GK9vw
 GFgSnLXBOC6OdHP94FzwthbavoCw9uJrsTF2Bqlu2OBSM5z5QOECqhTPC0LNSwOcVPJ/
 eUCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPyb8itYWbvrIiv+RWY6H8V3Izj0qrY+W3BXmYBZIK361YOe/HwCgAYm3BNDxuu30PHqgPEE=@lists.denx.de
X-Gm-Message-State: AOJu0YypY64XUIH3KGC/MiEZJhGoTr17CwF3KkTi6zypYws3oCc2Epj+
 oVIiT49YyYMX/dZ7FMbzU7/zTEsHs098ohSA87FozqTYhqoGoNuZ0MIz2iDgRhjagPOHbJ/DKOA
 T/xePa9+XpJLC4y2L51IuYEuLeAY=
X-Gm-Gg: ASbGnctQs6WQrl13/LWcKc7kUuKXQb/JE9NCM1e5NbnqlRdsYs7C9L2jERBWHy8IzxO
 HQpPjar2oIgSWlq7V1PYLPessrob9dlqQWX6MfGoHH1siAeUaZFyjiaeSYuicyg==
X-Google-Smtp-Source: AGHT+IHuyJ7hQAALqr/ATBvTv4kBE01+cr28x3cLlDSp3XCpBbUILxLHR7Wme9A1BVT+Dcoci5mt0ubAPswxKBf481Y=
X-Received: by 2002:a05:6870:798f:b0:29e:3701:47c3 with SMTP id
 586e51a60fabf-29e8891ba52mr1387182fac.42.1733207347247; Mon, 02 Dec 2024
 22:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20241119032800.14045-1-semen.protsenko@linaro.org>
In-Reply-To: <20241119032800.14045-1-semen.protsenko@linaro.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Tue, 3 Dec 2024 15:28:56 +0900
Message-ID: <CALrBrZ0LB3H9-TDpRvC-CYbAHETTSYkEOSa+yP6Cgr8T-1xY-A@mail.gmail.com>
Subject: Re: [PATCH] configs: e850-96: Disable PSCI reset
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
X-Mailman-Approved-At: Tue, 03 Dec 2024 14:04:42 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2024=EB=85=84 11=EC=9B=94 19=EC=9D=BC (=ED=99=94) 12:28, Sam Protsenko <sem=
en.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> PSCI reset is not implemented in Exynos850 EL3 firmware. Disable it to
> fix the reset in cases where it can be used, e.g. when running EFI
> selftest.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  configs/e850-96_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
> index 5797c6cb1f99..c36196c510c5 100644
> --- a/configs/e850-96_defconfig
> +++ b/configs/e850-96_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=3Dy
>  CONFIG_ARCH_CPU_INIT=3Dy
> +CONFIG_ARM_SMCCC=3Dy
>  CONFIG_ARCH_EXYNOS=3Dy
>  CONFIG_TEXT_BASE=3D0xf8800000
>  CONFIG_SYS_MALLOC_LEN=3D0x81f000
> @@ -9,6 +10,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0xf8c00000
>  CONFIG_DEFAULT_DEVICE_TREE=3D"exynos/exynos850-e850-96"
>  CONFIG_SYS_LOAD_ADDR=3D0x80000000
> +# CONFIG_PSCI_RESET is not set
>  CONFIG_ANDROID_BOOT_IMAGE=3Dy
>  # CONFIG_AUTOBOOT is not set
>  # CONFIG_DISPLAY_CPUINFO is not set
> --
> 2.39.5
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
