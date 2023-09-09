Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2595EEEB580
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 04:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3283E8650A;
	Sat,  9 Sep 2023 06:07:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XwnlnZfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F8458650E; Sat,  9 Sep 2023 06:07:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE79986504
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 06:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1694232440; x=1694837240; i=xypron.glpk@gmx.de;
 bh=H/7gYEdujAHqDS3BI5xtY9+9VXAVWaExpZaN16whF+0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XwnlnZfR3ANuvbufx4zmAakgMOY63RhYU7XUjvC/DGsUEmm15LC2upB/3zsDmeFa2LhYlS2
 hy1al8uTPPoemOyhyxM3TgMbl/Ka4dWd6ZE6Nk+qnOdibo+2bgqpwTi3/FecILWNaHIaZsTe0
 vBlanxsbjHF5ajtB9ZCiC+j1SwlOQMEjg6HzeolePQ+WeSIM5wYh0pSPR86uUiU8wlHSiO3i6
 axVi0mMiDsVB+OksGLq844rfjdWK04OzTDZNJD45l+UIi0nklD4q6MDRT2obN4A7uytMTQ03m
 sNzR8f39d1LUfELa/S3hSRQu9qr7jXe75iUl+pBnSKSuDAB3Q8ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3He-1qPOts2U7U-00FWtB; Sat, 09
 Sep 2023 06:07:20 +0200
Message-ID: <849ad57d-2941-4066-870e-0dfcbf938fc6@gmx.de>
Date: Sat, 9 Sep 2023 06:08:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Fix autostart for TPM1.2 devices
Content-Language: en-US, de-DE
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sjg@chromium.org, u-boot@lists.denx.de
References: <20230908203723.5702-1-ilias.apalodimas@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230908203723.5702-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bL7o3khrVUrZGpHyn+xKpazC9JqCZxiHWfWoTuDxiKVMZo/GXZP
 lAcI0PfITfDCcdCTd4VjQGl4xY9e7Ph7aV2z3naYrXo5dCU5Mf2zWxS+C/BUjBfTz8C23hf
 wyslfDxrR/XoGciAFNdHOlww56GSkUN0H9v1d/llU0oa2mzmqIjS1g+bcoQRQZaS9KYPSih
 z2bSZO7WLfV3PR87wfqcg==
UI-OutboundReport: notjunk:1;M01:P0:FH+RwK/dZNk=;op1YyNJ2hKbfnYTLlfPVB2xUFkl
 loyB+qG1cnGT1ZXstGkxAfzi9Q1GX0iI/YVCreOOAI1lZG3bor0Xxgy7RHRKG/VLithCVoOLY
 1Em5p1wrB5jA7vKhnSrHXb/LafhBLSt5hjT5P3xr86pKhVADvp4vOLcRfFag1iUEUlWTfNV25
 y+oQCfOufm/doXKYfo0wgunM1fYfG5V0DSFAXc7enbeygZCGYv8KgsPapwILkxGV4mHnkLGyA
 wzA8kE1mPxk+OJAALoIkkSE+T6I8EeKBNaCyEPveTUdANWIHAUuAEqHYx4YBvbYWUoPFyj8EF
 CsLXXkrviie8G4o+Mb399Z7PYQpY+7RB+pC0wiQIQHkYF+z2K4M0wXEOin5y+s08ZCoCq87bJ
 j/YGmvt50a2Oy6FfV50fQRLStUAPOO1y7nGvjFvaIySSVLo6FILdoUsTafCmhEUG6j08bCm2z
 IQQH0l2xnqrKzpPDNjZ8NQo9NPTqNbB5bCJXinPkUrVNdzS0Y7+8EJE8KNweI6h64+Gd7Do3e
 aiNYRRfzYXWleNU+UxTNKF3Sf7fYOMep/qyxlkxqJOJakGaEJZaJt/Sa8HGejpROBcdpScAme
 pPBUNyttzUbiSZcAbnEz7O7yQfUfAQmoDY44shoZjkeVJSmr7EIpBfB67k7izU4Qd5K8vnoLR
 Ewx+A+mM2KiNXIrmcxNKp3WIAyyUqel+dswQuSkOkajjmwiIMGHEhr+BPzT4FxJZXBeRuDMKo
 6ClrgNw1PjL4WEdw7cwYDBINgM6nKHN4gYhKfLW+pD7F2x4g3/G9ecizowNWtGGU0jemW+jps
 mw0YTbM3DOs/++5BSiN6D35DHR4P3YgwKjaGreaubHWUb6m7o74dZhEi2zFGI6wG5VJbJB2dM
 L9v4mBi59Tq3b7iEnc0QBIc2GZh9AH4bkAQ/ih+bMA/uEFNKh95UZ1kKNdwW0p8Gd7S92fTfp
 nfWHmEngQXYaea6ZRPIUjygFDFM=
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

On 9/8/23 22:37, Ilias Apalodimas wrote:
> On commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command") an
> autostart function was added for both TPM1.2 and 2.0 devices.  Instead
> of correctly wiring the autostart command for TPM1.2 devices that patch
> mistakenly added it on 'tpm init'
>
> Fixes: commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   cmd/tpm-v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
> index 3b95c950cc96..1b1efcd204d2 100644
> --- a/cmd/tpm-v1.c
> +++ b/cmd/tpm-v1.c
> @@ -655,7 +655,7 @@ TPM_COMMAND_NO_ARG(tpm_physical_disable)
>   static struct cmd_tbl tpm1_commands[] =3D {
>   	U_BOOT_CMD_MKENT(device, 0, 1, do_tpm_device, "", ""),
>   	U_BOOT_CMD_MKENT(info, 0, 1, do_tpm_info, "", ""),
> -	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm_autostart, "", ""),
> +	U_BOOT_CMD_MKENT(autostart, 0, 1, do_tpm_autostart, "", ""),
>   	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm_init, "", ""),
>   	U_BOOT_CMD_MKENT(startup, 0, 1,
>   			 do_tpm_startup, "", ""),
> --
> 2.37.2
>

