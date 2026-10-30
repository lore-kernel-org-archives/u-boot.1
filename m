Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038D6606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XlLfIo0k;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=XU3TrBqB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C90D640CEB;
	Fri, 30 Oct 2026 16:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id urEVIEi1Q-h6; Fri, 30 Oct 2026 16:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CB30640CE4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376550;
	b=hyg7Nm3pTaexEB7yFKuBqOKXO0dzVAZ6HIF+DKIs8i/zwb2xVForWxeQeYM8VCjBfAmV
	 9SD8jqb/4ACvbcxXSy1yf05Is7SFiM2B2AIsS3JCW/fmbYI2bbA0XPXWeK8aAK4gUzq6s
	 RLzN4ah4QC16DNHvZ+dTSrnXZZd+b/XvSlF/UWDo10Chla+KrypbUntdzpXnAFjhk9h8g
	 UPmzIkKLnyx7gbcLF8XgYDd+hOQqHiaecSvAe7MlW8lfroqMXL9Z8KncfLvM31y5vyoVu
	 NSqw7k7mYq8qYJHnJ1GV/5z6c0UFFvwDD8Ev/RP9vpyrPBIiNO7jHC4Nqk5IVlYPT/g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5Vlyb76dw3b3q+KCenGP+CiaptkkfMhOiG8ACAeaPTY=;
	b=HYxGRLSKopboJAdPmnigtVCbblWydOm8pF7pHety22nfdnj9VhKrCeH7Gdz8/Skn+K3E
	 UCpDYDsfCBA8Rt8/5cKYbjG4+rUOmtGw6ImSyS156GybcA8BhOHldoixdsUn1G0UP+q7N
	 K+rP0CRBteDmRlZTiXlxeGkwPClyaBFefOhs1ADibTG9/862zNzHE06zbHLINAQOCr7TY
	 KBXpOYL/U2exyupbiNSMAeL0fyf4SdVtSEKtQw3mtFCVHMEk7fq0Gn/+XBv76+9oX0EvT
	 1Zj0GXAupvgGTLPML9na+8vsYqGl5+wHbSKTAaHJ1h7YT0eBls358P8O6jJ2g6Ra6AQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376549;
	bh=5Vlyb76dw3b3q+KCenGP+CiaptkkfMhOiG8ACAeaPTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XlLfIo0keMK7W1sRWbAmp5HAPo+izYoHYrbuT3rW9PX/NYghgv5A+pOYnxbb07YNN
	 36gFMk20sAVb7/AidLLQPkbv6j27JBmORslMkSaofcQmYmdGHwfysUvAR2xEuME/Ry
	 wPY3dz4mXGBiLgNNlVr91gZ+Q84Sn223FOTiLsHyXEsOHRsltEJfpoD9PaiSR7mA1b
	 QKHZ6PG/3ing3/3CGXMdDaRBTpRSNvHKlxmHXuBV/niXRUv/uzj1hMBgO/ko6kRX/o
	 iTiL1i35NOciJPmDYnbrWFnEGrIbmQnfPq/D120zgruFIUzs67W1CHP9e7BpeVio1F
	 UbCSgsbdWBpDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB30640CE4;
	Fri, 30 Oct 2026 16:09:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6F172AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7987981C56
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Te64Eo2SCa-p for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FC0D816E7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793376547;
 b=V2Py+5qaur3W37LTN/ePdqyhhtCjIyWKHCxIN8Tvc40pJPcVGYmNx0DYT2lNCoPHC6xO
 r9l7xhCFTBYfF1cKnil/mTVMuOCrtNwZ9xRX6vJtfBiFWkPYBX+CIpe0oHWjx8sa7yNJc
 N/98oxScvTI8mtZxbYZCUelrIUghtCBQFl8asPw7CgV+m8PmgMa07YJ9vUCVl6BnMeESf
 jjznaliE3u/ndgrxlYK1GGhcCeQ6wHHpA59YYKMrwcwEa9hp6bW6MBBjiajCw9QATWIXY
 U2qtSiymrbUaQEhwfh6ybCXzZlSuOE0sP2YpfwvrSzRo41r8s54msBFdeid4CsIKuYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376547;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=5Vlyb76dw3b3q+KCenGP+CiaptkkfMhOiG8ACAeaPTY=;
 b=FSGWnAJmvsWyLwb0Nd0JXtIOi6nLdgHCjbWBbcYP4nJzSDk8a6msTaauNtTtnai/XFcU
 UMp6+naMjwEOr6XxqOjijVZZZuJBO3LK8O2Q2upigxKQjl69QEPU+VQHc9wXd0hf+lZIm
 yY0yuTJBy4Tdl609j6/7QmMyrXEbG4sRO8rXG27Grw6J2TAJi8xyPHJYcUEgm74YlqxCE
 fLc+J8nsKer9AIgaIC3fquwIxb5zDz+CBCp6XbwOLZViMJBm20rfbamPrXmjHUpNVaYAS
 LADVxAC04kVjYvdLIBmFrzgS/AcWyC5Psf9nq2xC21Nomv08BVOkXb5kTqRXEK9KkUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XU3TrBqB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::2;
 helo=mail-yx2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=XU3TrBqB
Received: from mail-yx2-x02.google.com (mail-yx2-x02.google.com
 [IPv6:2607:f8b0:4864:41::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FC0D816E7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:09:06 +0000 (UTC)
Received: by mail-yx2-x02.google.com with SMTP id
 00721157ae682-8b0fa446a94so2613557b3.1
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793376546; x=1793981346;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Vlyb76dw3b3q+KCenGP+CiaptkkfMhOiG8ACAeaPTY=;
 b=XU3TrBqBG6eBI23pS0jkUvbUD8IGypR+crPUI/nBPFaSNP90KKKGiln2tAzy1QZiWC
 dnDDmWMNSXNtgn3pNu0zqIzb3Crnz+d23fUMfXj7yQJN1ONWED8NaB1cnU3Vlpjsstpp
 xoLtFl/bFIgnHs8ik9uaaZe5G9N2MYBm6sBwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793376546; x=1793981346;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Vlyb76dw3b3q+KCenGP+CiaptkkfMhOiG8ACAeaPTY=;
 b=alUb8dzN1MLCQKIvoQ58bwzRtcsdjmpOzchfGHU+zDm/onFdOq1F83gm6Rm+FWVBmC
 wux2owm/wDohP78g55QlwYbUG051KH9LjEtwHOqxt1s49q6Fl8MKvlVpWO0nsfOgNMIo
 7qkZ+ptWAtoLI/FodORN5WcG+9QX17OZORIqyxMDy2lLQVu6k2Bud+2bUyWd4ZlVgpDL
 anhaKRMZM0eCURKL06WkaJDJsLUGtWsyN+kyec6y8ACPavxadaQSixYIQOupi1P2mc9+
 hXWuq6ramvYoAbdVYSjeX/LADAdb3H4I5n/WZJU54fixDdrkPMk9aRzEG4Rs+VhnPCc5
 uc1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2/jdVPnKHIAeXZ+8ENbengZ0z0YAZBVotJIBnndJoFWStifRZKFdExsRvSXfNphPw9kZAuiQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIP/mMOIlotQH+30yTO2e2310hZhIQ6xgqgxHKrbgV64T7plmB7
 yCky7yRaMjttdNReaGBnlnuiBz2ztEN229HN/uG4iYBFstTgx1+brx8aJr7sZWml6ZE=
X-Gm-Gg: AYBFou0I+phEF2aMmx7ANfxZqaCGNojJ5F1QiV590onmD2JZBoNf8XjhNrnfQRqkd+B
 Dj58aj4QQXQn+Zccmz8aKb9cMbzEkgJ9tayuRcCJS1HfmfhkbR7RiHlbbUAEc/cosbrn/gGoN5p
 Re/08+NZVgXGR99lGS3+Is7xGwEgucYfoUqzAFhD+094ZQqXYzkKDJn8FkPU8AZZDIh0zxGDHIt
 YbWe0Hy1iNOxBPWh5/5ZukJ6z2s4cybzwm5GSKjnjBRxblHppgudyJrUgc8+pt0s8Qj2pGRwF6L
 vzmydL7EtSf0iMBS7vDw4XzLCbycTyuGqN/ZIhuSRNqu/67f/726zdzaErib13/vwTc0tYXOvro
 JW7Ar2Emw1QyRReVW91uoeRpRC5KYlgDmmmJ5XSLJ6u/iPPuPKaENgzNGH4zdV2TRZCLDEm4yS/
 eGGyvdD2BW844WhNQVSI74bOI14sPZKK31oZ11PiUwVl2GFDMxhwupaxZ/gn4pbCCNrIQDk6Qkg
 Nex46i1XX1HLElBAqG1IK4g2bzhasd+XPXEXLMA/cY9n02uRlTUb2Hvm8JIrey6bAovs8c7/kJG
 ufnLXYEN/+/YpjPjZI26EyuME2RXExwWDM8A6JxxQ7CR9OjzlpoQXPao3XBMJVVkw0t6Ci2pcrP
 QdwgYQOUIBPRgilkxTa+Ci9swXzJTqVtngJaJBSWQhvdiyQTkBVaQLjEpoL4OOE1PtwLbzP6Ym4
 BI6OMjYYEzV38sSCEG78Wu4/3uWh3hiDw=
X-Received: by 2002:a05:690c:4:b0:8b0:95a7:37e2 with SMTP id
 00721157ae682-8b2b676b882mr13813267b3.80.1793376545528; 
 Fri, 30 Oct 2026 09:09:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b704e62esm10814487b3.3.2026.10.30.09.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:09:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:09:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
Cc: ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 Michael.Srba@seznam.cz, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: Re: [PATCH v1] mach-snapdragon: Add EFI fallback for reading FIT
 overlay identifiers
Message-ID: <20261030160901.GB3309461@bill-the-cat>
References: <20261030061542.2727273-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="25P73Jc0nvQrhLt7"
Content-Disposition: inline
In-Reply-To: <20261030061542.2727273-1-sumit.dhami@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--25P73Jc0nvQrhLt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:45:42AM +0530, Sumit Singh Dhami wrote:

> Read the VendorDtbOverlays EFI variable when the vendor_dtbo environment
> variable is unavailable. Use the EFI-provided overlay identifiers during
> FIT multi-DTB configuration matching.
>=20
> Move QCOM FIT multi-DTB selection to EVT_POST_PREBOOT so EFI variables
> can be initialized successfully before they are read.
>=20
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
> This patch extends the FIT multi-DTB support introduced by Aswin Murugan's
> series: https://lore.kernel.org/u-boot/20261012170754.1606314-1-aswin.mur=
ugan@oss.qualcomm.com/
> ---
>  arch/arm/mach-snapdragon/board.c             |   6 -
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 175 +++++++++++++++++--
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  18 --
>  3 files changed, 161 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/=
board.c
> index 9bfb7183241..055ef6b8221 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -453,11 +453,5 @@ int board_late_init(void)
>  	/* Configure the dfu_string for capsule updates */
>  	qcom_configure_capsule_updates();
> =20
> -	/* Try FIT multi-DTB selection if enabled */
> -	if (IS_ENABLED(CONFIG_QCOM_FIT_MULTIDTB)) {
> -		if (qcom_fit_multidtb_setup())
> -			log_debug("FIT multi-DTB selection not available or failed\n");
> -	}
> -
>  	return 0;
>  }
> diff --git a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c b/arch/arm/mach=
-snapdragon/qcom_fit_multidtb.c
> index 45423910d34..40f660b453b 100644
> --- a/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> +++ b/arch/arm/mach-snapdragon/qcom_fit_multidtb.c
> @@ -27,6 +27,11 @@
>  #include "qcom_fit_multidtb.h"
>  #include "qcom_hwdetect.h"
> =20
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#include <efi_loader.h>
> +#include <efi_variable.h>
> +#endif
> +
>  /* GPT partition name containing the FIT image */
>  #define QCOM_FIT_PARTNAME	"dtb_a"
> =20
> @@ -60,6 +65,10 @@
>  #define PROP_FDT               "fdt"
>  #define PROP_DATA              "data"
> =20
> +#if CONFIG_IS_ENABLED(EFI_VARIABLE_FILE_STORE)
> +#define QCOM_VENDOR_DTBO_EFIVAR_MAX_LEN	256
> +#endif
> +
>  /**
>   * struct overlay_entry - Gathered overlay FDT image info
>   * @name: Overlay image name in the FIT

Neither of these guards should be needed.

> @@ -1029,5 +1168,13 @@ cleanup_fit:
>  	if (fit)
>  		free(fit);
> =20
> -	return ret;
> +	if (ret)
> +		log_err("FIT multi-DTB selection not available or failed\n");
> +
> +	return 0;
>  }
> +
> +/* Try FIT multi-DTB selection if enabled */
> +#if CONFIG_IS_ENABLED(QCOM_FIT_MULTIDTB)
> +EVENT_SPY_SIMPLE(EVT_POST_PREBOOT, qcom_fit_multidtb_setup);
> +#endif

Why is this guarded by itself? It should either be by the function
that's also guarded, or EVENT should be select'd. Seeing that we're at
around line 1100 now, possibly some file split and broken up, too,
first.

--=20
Tom

--25P73Jc0nvQrhLt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTBHQAKCRAr4qD1Cr/k
Cvs/AP99klvKy+L2OeUAyNju8ZYU9NMD4MBxEUWbH7pTWVCLEwEAm6J73Cb74K2P
XhoxGDnPihDGb1rQeVO9cE9BQz/k4QM=
=25vD
-----END PGP SIGNATURE-----

--25P73Jc0nvQrhLt7--
