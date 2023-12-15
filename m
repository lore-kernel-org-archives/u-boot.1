Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907D5C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFCE87B7F;
	Fri, 15 Dec 2023 13:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uYWkRg5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1B487B84; Fri, 15 Dec 2023 13:01:19 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E3687B7C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c2a444311so5984425e9.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702641677; x=1703246477;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wHaiUwnSvhBfw3lIYLX9CkfYB5vCCz9w23aBg0p0hKg=;
 b=uYWkRg5kITmcHC579OssA3HJK8qTvzif42NDc8Nh//6reuKM5ZN3dvPMmRqDgRjfOJ
 ZRSDr8Iyyec5JLmBWAamEBkYsTsmaCEdjfHJH6wNaxVW3EPEvyVASrYBxv7G6mCB92hu
 CCYwd3DNVivNKcKRJwBlW9ukKF/psGH2wG237fbR6CBqd3zpiXMluz6SB8mEA82OEAnx
 JgsW/xjFTCxCf9H4xCLRHv+uWl++ars2rQAsvD+3XEh1w3hxKE70APu/l+t55tG0FuPf
 yj2dPEMv2kzR+NHCz9nbLAnWlM1C2ignlMad8ePIBoAZv5JuLWvhstlG6B1Dyd34E2Bn
 AycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702641677; x=1703246477;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wHaiUwnSvhBfw3lIYLX9CkfYB5vCCz9w23aBg0p0hKg=;
 b=ReuTnYop1Rl3eWzN+loJNgViqdzLlNNeNbK6eWTfC8eeM5UTSuZA+lPsdYTfP0U9HP
 N3a3K7AQN7zLUCX3amOWPV6gY99yth50DCKWYYhDLXbT1/0bHy2Ql4VaJ56ZsDqNYv+e
 5E/HMLMsELRpgTv916V6l/BR8ZS/M2pi2Kmz3QuydhHy36ygJPdmhPMqPH1weD9eyfrX
 PiS8ffpkUa+FbqJuEOiygBogCdjLnwURhkBnqhgZabk7o/rCNMGVoDyyLnagMfmMAfhX
 Ar41YO5Ajwa2SyAzR+AMsfxfT336DwGqlLQtH5bHKGH0YPWDr9tyqMya5Rt2+WhnLwwd
 WGTQ==
X-Gm-Message-State: AOJu0Yx3ENMHAwl0/mXy/UEu+Hym2QcnfBQxNFH30KJ9RmkRvj9Cktlg
 4gtcpldVejHprpUT4f76khb+TbVBHyy0+G3j9ok=
X-Google-Smtp-Source: AGHT+IHRQWJg0riMn+5YboyQ28i8RNhZs3ggg5Q1x8R/WqFXOCpZFnn2LKW/u4lX81NZIbCLn+3/dQ==
X-Received: by 2002:a05:600c:4eca:b0:40c:6137:b27c with SMTP id
 g10-20020a05600c4eca00b0040c6137b27cmr769421wmq.109.1702641676705; 
 Fri, 15 Dec 2023 04:01:16 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 fm14-20020a05600c0c0e00b00407b93d8085sm31200034wmb.27.2023.12.15.04.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:01:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Eddie
 James <eajames@linux.ibm.com>, Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 06/21] bootm: Adjust how the board is reset
In-Reply-To: <20231214165112.2182274-2-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-2-sjg@chromium.org>
Date: Fri, 15 Dec 2023 13:01:13 +0100
Message-ID: <87le9vu12u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Simon,

Thank you for your patch.

On jeu., d=C3=A9c. 14, 2023 at 09:50, Simon Glass <sjg@chromium.org> wrote:

> Use reset_cpu() to reset the board, copying the logic from the 'reset'
> command. This makes more sense than directly calling the do_reset()
> function with the arguments passsed to the bootm command.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> (no changes since v1)
>
>  boot/bootm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 301cfded05cb..8a0dba5074e8 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1140,10 +1140,12 @@ err:
>  	if (iflag)
>  		enable_interrupts();
>=20=20
> -	if (ret =3D=3D BOOTM_ERR_UNIMPLEMENTED)
> +	if (ret =3D=3D BOOTM_ERR_UNIMPLEMENTED) {
>  		bootstage_error(BOOTSTAGE_ID_DECOMP_UNIMPL);
> -	else if (ret =3D=3D BOOTM_ERR_RESET)
> -		do_reset(cmdtp, flag, argc, argv);
> +	} else if (ret =3D=3D BOOTM_ERR_RESET) {
> +		printf("Resetting the board...\n");
> +		reset_cpu();
> +	}
>=20=20
>  	return ret;
>  }
> --=20
> 2.43.0.472.g3155946c3a-goog
