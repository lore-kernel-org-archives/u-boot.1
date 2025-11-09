Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A54CCFA1A
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 18:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BBD83EF8;
	Sun,  9 Nov 2025 19:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qDMTtETL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dLo8BiKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E967E83EF8; Sun,  9 Nov 2025 19:37:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0EA183EEF
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 19:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d4M3Z4XDNz9sqF;
 Sun,  9 Nov 2025 19:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762713450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtdLhmotCzr5QDVMNBtPBh9S0WBT03IBp9u0+xK/pvs=;
 b=qDMTtETLpFUFZ0e/jK4u2Mnlb1AU/Gh3NmWQS1bz3OGj7AU1OdNwtr69GlZGZy+4NIqeyp
 vEGo8SaU43mZ7jTynndgJ7YhixIDmE4ePemNIZK2Eyjw5zX0C9Hur34N0vRD64PGQzRkOM
 tjX5xsfJV7okmHTVB8r/jVDVodf6pchqYx92GmA5iIc5bUh4IyY6f+xtBOd5bSkAdCVuLD
 N1DMW6O1JujZTBgpNu0CVR9ZWPdqPokWNONWkvkBFQiAiCrVLe05fPgfRxwVFyQqnzM9H/
 MhYJJgW3BPrb9m8nj/Yd7piWS6MMzqdOGjVBTTV8LOr/MRflpJf+9A6zwXYutA==
Message-ID: <83d8df11-d27f-47d7-86d7-073bfe72b627@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762713448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtdLhmotCzr5QDVMNBtPBh9S0WBT03IBp9u0+xK/pvs=;
 b=dLo8BiKXFhIxNhUKo/s8S0fcizfa0vluqu46z/tURRVVwHqsuzW+SvixP1EkRVn+UnYqwJ
 cP0CX15BBBrWkcYIsGXka+/Py1HkCP8/tdnBVQdKKWvt3KEPCXIB6CjS4IPqUCdv1MXheX
 YYdSRAyqjmObGtY4GEk29Acf9BVljQDhkfzraD/zf0e4XPTurqjqVZLuSVlCJMgICz+cqM
 H5FDhKgoPf3/3n+RxffdT4PNBG6gLnEBLGeSE6JCE3Q/K6Z3nzmGH37e7JWg5LJkioztXz
 lPhYYdKvhunYkVcXRk/vV9Uc7XDE0O/a0nlivvEQ9oJJ6eLVtFXq5REYicUpyg==
Date: Sun, 9 Nov 2025 19:37:23 +0100
MIME-Version: 1.0
Subject: Re: [U-Boot, v5, 1/1]net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, trini@konsulko.com,
 joe.hershberger@ni.com, marek.vasut+renesas@mailbox.org,
 rfried.dev@gmail.com, jerome.forissier@linaro.org, ansuelsmth@gmail.com,
 weijie.gao@mediatek.com, SkyLake.Huang@mediatek.com,
 romain.gantois@bootlin.com, s-vadapalli@ti.com, u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org,
 ericwouds@gmail.com
References: <20251109163735.44320-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251109163735.44320-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6150d9f41a43c025751
X-MBO-RS-META: mbxtgxq61tmrqb55u6xxm3khttfytug8
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

On 11/9/25 5:37 PM, Lucien.Jheng wrote:

[...]

> +#define AIR_EXT_PAGE_ACCESS		0x1f
> +#define AIR_PHY_PAGE_STANDARD		0x0000
> +#define AIR_PHY_PAGE_EXTENDED_4		0x0004
> +
> +/* MII Registers Page 4*/

4[SPACE]*/ ... missing space before *

> +#define AIR_BPBUS_MODE			0x10
> +#define AIR_BPBUS_MODE_ADDR_FIXED	0x0000
> +#define AIR_BPBUS_MODE_ADDR_INCR	BIT(15)
> +#define AIR_BPBUS_WR_ADDR_HIGH		0x11
> +#define AIR_BPBUS_WR_ADDR_LOW		0x12
> +#define AIR_BPBUS_WR_DATA_HIGH		0x13
> +#define AIR_BPBUS_WR_DATA_LOW		0x14
> +#define AIR_BPBUS_RD_ADDR_HIGH		0x15
> +#define AIR_BPBUS_RD_ADDR_LOW		0x16
> +#define AIR_BPBUS_RD_DATA_HIGH		0x17
> +#define AIR_BPBUS_RD_DATA_LOW		0x18

[...]

> +static int air_buckpbus_reg_write(struct phy_device *phydev,
> +				  u32 pbus_address, u32 pbus_data)
> +{
> +	int ret, saved_page;
> +
> +	saved_page = phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +	if (saved_page < 0)
> +		return saved_page;
> +
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE,
> +			AIR_BPBUS_MODE_ADDR_FIXED);
> +	if (ret < 0)
> +		goto restore_page;
> +
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
> +			upper_16_bits(pbus_address));
> +	if (ret < 0)
> +		goto restore_page;
> +
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
> +			lower_16_bits(pbus_address));
> +	if (ret < 0)
> +		goto restore_page;
> +
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
> +			upper_16_bits(pbus_data));
> +	if (ret < 0)
> +		goto restore_page;
> +
> +	ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
> +			lower_16_bits(pbus_data));
> +	if (ret < 0)
> +		goto restore_page;
> +
> +restore_page:
> +	if (ret < 0)
> +		printf("%s 0x%08x failed: %d\n", __func__,
> +		       pbus_address, ret);

Can you use dev_err(phydev->dev, "%s..... here ? The struct phy_device 
has access to udevice and with dev_err(), you will get automatic device 
instance identifier in the print (useful if you have multiple PHYs).

> +	return phy_restore_page(phydev, saved_page, ret);
> +}

[...]

> +static int en8811h_wait_mcu_ready(struct phy_device *phydev)
> +{
> +	int ret, reg_value;
> +
> +	/* Because of mdio-lock, may have to wait for multiple loads */
> +	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +					EN8811H_PHY_FW_STATUS, reg_value,
> +					reg_value == EN8811H_PHY_READY,
> +					20000, 7500000, true);
> +	if (ret) {
> +		printf("MCU not ready: 0x%x\n", reg_value);
> +		return -ENODEV;

return ret; should be fine here ?

> +	}
> +
> +	return 0;
> +}
With those fixed:

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thank you for your hard work !
