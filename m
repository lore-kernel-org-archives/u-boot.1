Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32315C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 06:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489F1806D8;
	Tue, 11 Mar 2025 07:35:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741674930;
	bh=Wb7D69dKp7Z00rwrrMqvy2JF8m/Atx/QV4UO2bLFpok=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=TcAAVnX54xHmgihaVnek99wHwnsMbHEzZDmo8Nz4eAgZZmZKhj3/kIx+sQ9EFotLi
	 IkBxW97kucLd5RpVNWFO5EmJ74fmd18InLG97Gkw3z0VO2nAoIt87jRdk8q6RLhWoC
	 DjWTzcrrEfh/Th0ILa0eIuLiAgwjh3N8CpCbU6dq2BcebEuF7uxTuYTjAU3yHm7n8A
	 EcCOtzaxI25fOmOCjZz/JU9Cc+oXlYad/0PGG/f8h3Xw8PaIkakbIL13DpT3fwNIKE
	 F5/oG3aoq7JexruQI2lZBz0/pKV+aJGJ0iwIkov4+8Xz2rFtbsljn21nPRb9+89lTX
	 1cf2hhJhg7MxQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D8D80F92; Tue, 11 Mar 2025 07:35:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F3280FB9
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 07:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="eyI14j/C"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 394FD1020C491; Tue, 11 Mar 2025 07:35:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741674924;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Wb7D69dKp7Z00rwrrMqvy2JF8m/Atx/QV4UO2bLFpok=;
 b=eyI14j/CHIJ9v7mSaTvuzYmXNevwMdbH2sVaCGcDvjxexEqFE27Ray1IHYCux3D3YLwUXN
 fYrUtWL32s6T46KhAJ/bjR/kf8i5a+lOlHRIuMqhq6jWU5m8bho6TnQoe/g1WLfUGQRi0+
 ZAf33kJ0j4uPpp6Mmr/rddL7eHFpnK38tjggKMvH2teEbTC4txV0XftenpCsDtzwdAwO2j
 WL6dFbLi78qTjN86sCElBfOrOm29DIyWw3utqlQQS6KRr/Ow5S/GFE+kg/6rL2QqbE4fQV
 72nYd7V7fOXSZ7PjMfN/WFpWcIEGj44TR5XillIC6Ua4vfBsWEqBGYtfgvDY+w==
Message-ID: <53069110-553e-c73b-c050-3b23e5328d8f@denx.de>
Date: Tue, 11 Mar 2025 07:35:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/4] drivers: i2c: Kconfig: Add
 CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, stefan.agner@toradex.com, w.egorov@phytec.de,
 j-keerthy@ti.com, u-kumar1@ti.com
References: <20250310103702.1464782-1-a-limaye@ti.com>
 <20250310103702.1464782-5-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250310103702.1464782-5-a-limaye@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Aniket,

On 10.03.25 11:36, Aniket Limaye wrote:
> Add a Kconfig option to disable sending Stop conditions between multiple
> i2c_msgs within a single xfer. Enable this config by default for ARCH_K3
> platforms.
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-4-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/Kconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)


Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
