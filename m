Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4923ACCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 06:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1A3839CA;
	Mon, 10 Nov 2025 07:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="EEeie9Gz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6241839D5; Mon, 10 Nov 2025 07:01:17 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A464083956
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 07:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 40E50108200; Mon, 10 Nov 2025 07:01:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762754474;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=dcwGjQWrOrbvNXRyqb6SvE1nlFZRO/+nSqlAjNwZr88=;
 b=EEeie9GzIP2ZCuk5Q2cCHGBeFHJjm5i2QUvdlb2deOt7fyDAoPZEaYa7c1N4J52I4aazqf
 bWKAlzTJExuzsfInX6hyD1dpdFbsE5qanW+y6YJvAOGGF6CW3p8abJJQQLoIPevgyh+HcW
 RCv70KRWI6fSanqkZ/xM3sYR2Th+PGBao6uHWpLhkikCbR8nHehvBpcN8UMvPh13HVXK8L
 YjGYuOUJyTIMYTl89LiPAB8aBJ1h3tbUsTzU12Z5yjOVEf5q96NPG9PO2jv+MOWVArKDxD
 7KdUCWm3aFbW8HKKuhHRcTWbySqfn/KIRZP01RJaNxd8Hxtd/cq6M8GnhG0EuQ==
Message-ID: <ddaca8b3-43fa-7687-4d54-bd5bcef256b8@nabladev.com>
Date: Mon, 10 Nov 2025 07:01:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] i2c: samsung: add support for Exynos7 HS-I2C
Content-Language: en-US
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
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

Hello Kaustabh,

On 04.11.25 07:14, Kaustabh Chakraborty wrote:
> Exynos7 (and later) HS-I2C blocks have special interrupts regarding
> various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
> for enabling and handling these interrupt bits.
> 
> Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
> differentiate between the multiple device variants, an enum is
> introduced which is used where difference in implementations exist.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v2:
> - implemented deassertion of interrupt register irrespective of variant
>    (Heiko Schocher)
> - Link to v1: https://lore.kernel.org/r/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
> ---
>   drivers/i2c/exynos_hs_i2c.c | 109 ++++++++++++++++++++++++++++++++++++--------
>   drivers/i2c/s3c24x0_i2c.h   |   7 +++
>   2 files changed, 96 insertions(+), 20 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
