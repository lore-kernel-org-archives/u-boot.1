Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91482D5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 05:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F5D80077;
	Tue, 16 Dec 2025 06:13:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="TOc8aT5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A92800AB; Tue, 16 Dec 2025 06:13:27 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0803B8003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 06:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5B3E109743; Tue, 16 Dec 2025 06:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1765862001;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=qoH3Md8h4+zfQx2/MLAVwfcos2n3BglsK8zojOUlcvA=;
 b=TOc8aT5EVbepYs4PabfzKMq3Lncz21U/bo1cVg87PexGxC7Sq3258Q9WCjFCiCZB41GHUD
 rtYrICSCyn4DgWbPTggPROBgUcdOtdRpuXGY/X+00KBDLGjRZubYKLcRPQb1CPc3uL1BMc
 a7GG+nIw2Gk1Y/l9T26nWk3Wo4/jCfHGOqaeRf12r8FZbtfhr/iadyDt/LmsZqsc8jMcru
 2gcHYA3YE1fg0gKmEXnB9pts4XollwXgBYJcjHVVPvAljVzd/X1Ai1wdrAhSNDf9+zlUr8
 C2uPpSedO4xEuGkg3quGZqii5355xyXlK7+oAJqC5qyHFMb601wsD5LlSzqzcQ==
Message-ID: <91048638-cb53-75b1-d247-fa0b807212bf@nabladev.com>
Date: Tue, 16 Dec 2025 06:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: samsung: add support for Exynos7 HS-I2C
Content-Language: en-US
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
 <35799dc588baf60d670d18435f1deea0@disroot.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <35799dc588baf60d670d18435f1deea0@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Kaustabh Chakraborty,

On 15.12.25 19:37, Kaustabh Chakraborty wrote:
> On 2025-11-04 06:14, Kaustabh Chakraborty wrote:
>> Exynos7 (and later) HS-I2C blocks have special interrupts regarding
>> various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
>> for enabling and handling these interrupt bits.
>>
>> Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
>> differentiate between the multiple device variants, an enum is
>> introduced which is used where difference in implementations exist.
> 
> Bumping this series for visibility.
> 

It is in my patchwork ToDo list, so I pick it up, when 2026.01
is out. Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
