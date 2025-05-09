Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FF6C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 14:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B7B582905;
	Fri,  9 May 2025 16:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cbv2hzQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A82838283E; Fri,  9 May 2025 16:54:50 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E9E682162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 16:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so259213366b.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746802488; x=1747407288; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XfNo97Y2vUh1mNuzhn8H62v5uzS0daCd/HHZy0JqZDc=;
 b=cbv2hzQwO5WwdsQUsakaw/Y5aWlFwPxFRc9HfEZGF5vX06F4Pb3tAqjor7DyMZeC+L
 gYJKXD/lHg7Fu4cDGc29GrXWQVr3MZCdokN6J2N1Gbo23UHHrqCD3AbyLj17gpqaudt5
 bAQb6tKXWhk8At+5FBhShCezFVTb9j2a2La5szkKqa+uvcrfiE9NXGLZpASeJF6JSwf+
 mS2M1tgFxo6dDuxyVTUvOUqjP7mTQfEmBLo2gjxIJXZnW1GcJ0E6w+9GBMn6SDktFNpc
 JPvAxS9CKnB4cooF8COamvNaVLLbAKizb9Tex+T4FyGlTSSJVDOKaPWbRf1j5QY5TopP
 tF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746802488; x=1747407288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfNo97Y2vUh1mNuzhn8H62v5uzS0daCd/HHZy0JqZDc=;
 b=fZHVUrbEMKb1cQqvTjC05gNlFin+rYoqMZsAFbVyIwQ0VKeQDuldTBJV3bScBAugCS
 bQaPwpmWuuTIyF81wWJjcIZpm83no0ty3C1hglHzjBm3QZB8xhgx9Sfz78Z4lqGHnRn2
 4d/XUEuB0PKwHnivq5eYUjRU9QaGKGBz2vh+8T8cK2jfQNouR5HKq97PT4mSTk8LNivU
 iVBD8J1lD/sTJyDZCroJ3LAY7M9116Rhjr0KTiB4XfMOM+UXAF5Rgmz8WvvxihxWwaaY
 xTJNA3olYXPAgNMP+0IlPW1aul0Acco9BN5Kidc+10O9ztY0S7a7IM93BuihL0Mf4WN6
 cfWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx6GZQtWXE1l+KgpaJxcrQQdnMBe8dJ3L7+NBoARibxxh4alS6OUllf6njA/00GFKln2Jxcvo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2kyxyAM/0N/Ht77aUdujH3ATk9sTYrSF/J+jcaa8dTOVQRnL2
 MFZ8FmGP2i4mAz0+7E99Yh/oaSw4+ZiozvVNdksOmIY0wAcI7uwpWBBwr01gj6I=
X-Gm-Gg: ASbGncsb6SuNfiBflyHF4FRvP/7vFCNCxAA3ngn3BoIRfMQEAegTBMEfwZaIc5D+fbx
 7kjEfYHPFE87uOZVceQ0uiYtYSjwi5UCJOGqSt3aXelTAjFarvEVafpB5XYltJi6jgH/dztx8Sl
 Z0nmur0kH7W1Roc24HBXeQEIQBU0ERAqRKcZZ+Qu4Ez5MyQ1yeSzULuCjtsetybBU7u7ypUgukE
 l8eaCcd10F2HsBseDJmA1SxxNT2c9020vHykMsvXqT0yLUmMmslOil0ZHhKTU9rzclETes+Fwx5
 J323LsadMVRQHakeTUst7A6VmwRNofxmf2faTb25Pf/qk4lKRkngFzVHkjSbHg==
X-Google-Smtp-Source: AGHT+IF1HlkELbFKLwFH1PL1voYyge6/GfiDwgdbeJJU+xYpO6DJgSMXBxmo/yEXzuGRPulvlQgWig==
X-Received: by 2002:a17:907:1b1c:b0:ac2:7a6d:c927 with SMTP id
 a640c23a62f3a-ad2192d4b63mr369296766b.50.1746802487552; 
 Fri, 09 May 2025 07:54:47 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:5efa:1605:27a6:f66])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21b0f67e7sm149903566b.1.2025.05.09.07.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 07:54:47 -0700 (PDT)
Date: Fri, 9 May 2025 16:54:43 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Enable AUTOBOOT_KEYED support
Message-ID: <aB4XFmFxBj30x5U6@linaro.org>
References: <20250508103238.230608-1-sumit.garg@kernel.org>
 <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe44fd2a-f16e-4f84-affa-3f9fbbbbdc9b@linaro.org>
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

On Fri, May 09, 2025 at 12:45:20PM +0200, Casey Connolly wrote:
> On 5/8/25 12:32, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > When debug serial port isn't connected, it is at least reported on RB1
> > that autoboot gets interrupted. It is probably due to random characters
> > on the UART RX line when disconnected. Lets try to fix this inconsistent
> > behaviour via enabling AUTOBOOT_KEYED such that the autoboot gets
> > interrupted only when the <SPACE> key gets pressed.
> 
> Honestly I'd much rather fix the bug in the UART driver, maybe it's broken
> pinctrl?
> 
> The older UART driver (for msm8916) had a similar but that Stephen was able
> to fix with better configuration.
> 
> Anyhow, this is a sensible enough workaround if nobody wants to look into
> GENI...
> 

Well, the main fix I did for that isn't related to the UART driver at
all, it's simply adding bias-pull-up for the RX pin so that it isn't
left floating when UART is not connected.

For RB1, qcm2290.dtsi &qup_uart4_default currently has bias-disable for
both RX and TX pins. So please try applying bias-pull-up + bootph-all
for the GPIO that belongs to RX.

For details, please see the following patch series for MSM8916:
https://lore.kernel.org/linux-arm-msm/20250422-msm8916-console-pinctrl-v2-0-f345b7a53c91@linaro.org/T/

Thanks,
Stephan
