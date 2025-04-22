Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47D6C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 15:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6418E80F6B;
	Tue, 22 Apr 2025 17:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745335174;
	bh=1tOnwRXUlJzGxzZ5kgVWqJBfCCN7CQMskvQNd7VGsAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LvbaT4/P+urlGU4hk9GYkJbtqpPnPBW9gLldh9p8w+1tmebYBGTF4H/188oBmImLS
	 iio50zFW8VC1QSpdon6G7qTCtYen7ebCr59Gb2KYUbNF+EEZS7YLRRrhqSDd1JE75b
	 ZhcYLCt4IqVLOlnu8lEn4rMXLPZVfPw5Nmy2h+DNhQuQ4SrjFi0Ho6+8RyuqcglnK1
	 bXLUDabK4Y1+MN/KjJjSyG5ypyRnS1Z9yQudXDlnXkbJuRhH6IcRIlZIsHPoPXaUgP
	 29U/vYZ9H/KAO8W2tlsp0jsTYVei6Q+RDS2OHZi67z25VeXO0V8VbrlQufp5ApSzE8
	 M2mQiyhLyO4FQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F91281E25; Tue, 22 Apr 2025 17:19:33 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1866A80F03
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 17:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="J6FaSOwg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EE7D61039EF35; 
 Tue, 22 Apr 2025 17:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745335170;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=1tOnwRXUlJzGxzZ5kgVWqJBfCCN7CQMskvQNd7VGsAY=;
 b=J6FaSOwgq51CY8IMTnKTeFX2skRkvvwcrYF95JjwTn1I/hRXEjQLH9n0q9sMecC8ezXZQ0
 pZkQrJCmBkhecNppWzz5YDW/RoHhDNsFtgwDcqwCcKuB+YRyVvLuZ4ZDtGD7wUjmLE9UqM
 6XVUXTLxJpOpdfGvPNHR3ajtXF+dmpJjIw0zb83BXrkOkKIqK3zCJ8/qoIlWqKzqlCmxEU
 Rsk1zjtLOGG4G75Qx2sdWl6042Dnr36rFzaG2bUi9Kz/FytMmS6rlh0FXzYqk7XghkG/CP
 SiAki/4IDC+YR/4nHJ4btT/BKpC6fg0E6cPKtfkl5ge4NRfagLylLXgiHIw2Sw==
Message-ID: <c111d6f8-d32a-74f5-c1f4-05649e0bc860@denx.de>
Date: Tue, 22 Apr 2025 17:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 3/4] i2c: omap24xx_i2c: support CONFIG for repeated
 start in DM_I2C xfer
Content-Language: en-US
To: Aniket Limaye <a-limaye@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 virag.david003@gmail.com, w.egorov@phytec.de, j-keerthy@ti.com,
 u-kumar1@ti.com
References: <20250422101957.1949448-1-a-limaye@ti.com>
 <20250422101957.1949448-4-a-limaye@ti.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250422101957.1949448-4-a-limaye@ti.com>
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

On 22.04.25 12:19, Aniket Limaye wrote:
> Repeated Start Condition (Sr) can be used to transfer multiple i2c msgs
> without sending a Stop condition (P). So far, the driver default was to
> always send a Stop condition after every i2c msg.
> 
> Add support for a config option (CONFIG_SYS_I2C_OMAP24XX_REPEATED_START)
> to disable sending the Stop condition by default. If this config is
> enabled, Stop condition will be sent only if explicitly requested in the
> msg flags OR if it is the last msg in the transfer.
> 
> Consequently, handle the Repeated Start condition (Sr) in the next msg
> by not calling the wait_for_bb() check since it will simply timeout in
> the absence of a stop condition (BB will be 1 until Stop is programmed)
> 
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
> 
> v2:
> - fixup code formatting and comment blocks
> - CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
> - Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-3-a-limaye@ti.com/
> 
> ---
>   drivers/i2c/omap24xx_i2c.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

Applied to u-boot-i2c master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
