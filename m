Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E13FC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467C287CAC;
	Mon, 12 Feb 2024 08:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N0bExnbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D7787CB8; Mon, 12 Feb 2024 08:05:23 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5419A87C1F
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a3ca40db065so43507066b.2
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 23:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707721520; x=1708326320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ct/R1lvDgiwWCN+266/11t4MPuuC+3rik3QCNle7Bb8=;
 b=N0bExnbIoR8o00+JMEOO1mmMAoM31ae1Sz2ZTYss2BYlU9Bich+w4faFum4r/TEzYa
 VMJXTO7kLlO1VTftF63R23hrfkmBm/zvaBNv1LJeSdMuK3XVOBoG9rhnOkTfr5LUCrec
 o087pe85MvrO0dSkTZz5H04ZxT4k+xbgz5KAPN4nt4bbvHbDzmvhF6Wy8p1eMl1ye5+o
 nzB+03jhoqjM5a7uHzycgbPa6gQET4wx8A36tMtDrY8tAG9/rDmDVrA051f925xpEGeR
 3MABbG4BHz5+hHXIcEtS2A+Y2tmVXS9fDfhEYG776zqGXyBZoZBv7Di6Ta83znUqKFvD
 iC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707721520; x=1708326320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ct/R1lvDgiwWCN+266/11t4MPuuC+3rik3QCNle7Bb8=;
 b=JiTcVtlVTS6wWvFgShOQJJ0fpEh7cDiKp1JIcaZthi6QpygmJr9UloMB0LvIcjjPBB
 wc/f9ELwYz9Lcpvs2chfdkMB9RbVy/2cTDAQKt9K/vdbqzYPBCewDNav6VzHrmvyBI5q
 FF/Ggb+n/fupVs2+zhKJRBXYxqS+km63BW2kN8Kco95saKsD2lcWkKr0ppcKNVNDnIzX
 dON0TV3ImRk8FsohxOXECZ5Jjpx4CxuMUbDUV1GPpLfp0PDZDF4uPCVuDcS0+RZGI59T
 zvt/To0uiWwnEm4C4W/m/e9oK/MfNgJSYSHt0uMOrltysXaj8WPEuxBvQkdbvjsSV6oY
 TtsA==
X-Gm-Message-State: AOJu0YzwZyK9lCPRNiByob/uBT8AtLPDw8TyN3kOIPZOx9fId8AYx4SM
 /p5ShJ9NekIbW7yAJXlKhII9MJgAeYDIvCy9rulo0tFBo1gTijV04/7OX32F9Yo=
X-Google-Smtp-Source: AGHT+IEyQ86hjQdh08D7DxAzOPjGWS2yKpHqy1luYQGllYj+Rna2Pt9iHY+0+5aLUSa4qKieDpFgyg==
X-Received: by 2002:a17:906:168d:b0:a39:e059:e632 with SMTP id
 s13-20020a170906168d00b00a39e059e632mr4018118ejd.3.1707721520716; 
 Sun, 11 Feb 2024 23:05:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXBpvSw3u9oNx+ktVP2hPHedSJpbPqycnqjqoug3GQPOFs0sDdLiVOH6Iau0b/JyW1TXCXen7vEL5R6c64/agpwrHVkFqCdAhrkT/8GMygbmDmcPzFZ9VAM9BmbEYbhjA9E/dBglLn5GPAVOTbFTWgavlwyNQvTibecxK/8h+yxUCMSXElhYi4+1jYh26Msw2exWuNM8UAdQaRfajkUz+iBenscbaMkaVmme/SuRM4qIL3K9ggTjbEw98kOjT8wV3rNdpqs5A==
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 g19-20020a170906521300b00a3bb098ffcbsm3547518ejm.89.2024.02.11.23.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Feb 2024 23:05:20 -0800 (PST)
Date: Mon, 12 Feb 2024 10:05:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ivan Khoronzhuk <ivan.khoronzhuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/7] common: avb_verify: don't call mmc_switch_part
 for SD
Message-ID: <b457cb25-ea09-4e27-85aa-0e97a5aa7fe0@moroto.mountain>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
 <20240209192045.3961832-2-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209192045.3961832-2-igor.opaniuk@foundries.io>
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

On Fri, Feb 09, 2024 at 08:20:39PM +0100, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@gmail.com>
> 
> mmc_switch_part() is used for switching between hw partitions
> on eMMC (boot0, boot1, user, rpmb).
> There is no need to do that for SD card.
> 

Is this a clean up or a bugfix?  What are the visible effects for the
user?

regards,
dan carpenter

