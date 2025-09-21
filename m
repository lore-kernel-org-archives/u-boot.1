Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7570ECAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 23:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0C48317B;
	Mon, 22 Sep 2025 01:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wZonmUH/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aVu3kk71";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9050383211; Mon, 22 Sep 2025 01:14:29 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E41082B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 01:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cVMWl0zqpz9tG4;
 Mon, 22 Sep 2025 01:14:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758496467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijM6LFL2TpSpoZQBrKBwCSksycQhFVjXzt+iyncpoco=;
 b=wZonmUH/wdmPCCsgRJcjMqz0hdGZhbiS5fSePm4nzNfX2SW3ZrWFwEOMiO6RivKZQ/skxd
 Wxw9VJsNR1do65DxhfJQ9KFWp0/dN5FokHHmZheNdalaU4QH1g5c83cJ+ugwWiyolESQ5j
 XXlHbgmz6oBfI5lYyjysIWqtI1zW0T1sj9ASaBOKHX4RDSNuehBN0ciPBCJjrc5+Fe3MsN
 7dD3ZGwY9aAXI3x2qxxJBB0NBklKJuM//pnfA6SNcI+g6vXkmCp9NN0b4cD/x/GgxWv9sm
 3jSu1YAT+eUxCq7xR9UIDuATvKxNR4T29Uqj4DaF3njf0nGEVt9hlvmyVOvMGw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=aVu3kk71;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <da4bc010-3014-4411-90da-0a74b2f955ee@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758496465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ijM6LFL2TpSpoZQBrKBwCSksycQhFVjXzt+iyncpoco=;
 b=aVu3kk71u8ZL7jYJ2LkgZywhnkAkzX97qLSzZiPaLzXggF53LciML6UEVTJjR9hrrBXVUB
 cPbMd9r7HCpouHanJo0jUZa0redp9DsuPXv1LLB6fLKgDI/XAGpwOrAGsKnhQK51ZvMwuf
 yk2pJJ4dyPIaGLhvxtPRO6F0VeUsare7IPwJO6N8VzNHhSvSxjKtVuDFFz25j+58V84sh1
 cfHWT10qAyKOzOEiFGv60SqmEo4ELUyGmAbV3cV1XtYAoT7F74Auv1qzJVLK4CjgK3l1iF
 6BUGAwUtNqLQfEQsNDb1TqnreAdHcEHhT6XFU1IGkkybuzBriyfYyylPUd5v0A==
Date: Mon, 22 Sep 2025 01:14:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] [U-Boot, v4, 1/1]net: phy: Add the Airoha EN8811H PHY
 driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de,
 trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
References: <20250914044115.18391-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250914044115.18391-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bbe0027386345198626
X-MBO-RS-META: 8iwdcgjpina3j8p837w9ad8cpb4i8cph
X-Rspamd-Queue-Id: 4cVMWl0zqpz9tG4
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

On 9/14/25 6:41 AM, Lucien.Jheng wrote:

> +#include <phy.h>
> +#include <errno.h>
> +#include <log.h>
> +#include <env.h>
> +#include <malloc.h>
> +#include <fs_loader.h>
> +#include <asm/unaligned.h>
> +#include <linux/iopoll.h>
> +#include <linux/bitops.h>
> +#include <linux/compat.h>
> +#include <dm/device_compat.h>
> +#include <u-boot/crc.h>

Keep the list sorted.

> +#define air_upper_16_bits(n) ((u16)((n) >> 16))
> +#define air_lower_16_bits(n) ((u16)((n) & 0xffff))

As a separate/follow up patch, you could port Linux wordpart.h to U-Boot .
[...]

> +struct en8811h_priv {
> +	int firmware_version;
> +	bool		mcu_needs_restart;
> +	struct led	led[EN8811H_LED_COUNT];
> +};

Use tabs consistently , there is a space before firmware_version , 
replace with tab.

[...]

> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	void *buffer;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_FS_LOADER))
> +		return -EOPNOTSUPP;
> +
> +	ret = en8811h_read_fw(&buffer);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING,
> +				      EN8811H_FW_CTRL_2_LOADING);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE,
> +			    (unsigned char *)buffer);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
> +			    (unsigned char *)buffer + EN8811H_MD32_DM_SIZE);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING, 0);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_FINISH);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = en8811h_wait_mcu_ready(phydev);
> +
> +	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
> +			      &priv->firmware_version);
> +	printf("MD32 firmware version: %08x\n",
> +	       priv->firmware_version);

Can this be log_debug() or debug() , or is this print really needed ?

> +en8811h_load_firmware_out:
> +	free(buffer);
> +	if (ret < 0)
> +		printf("Firmware loading failed: %d\n", ret);
> +
> +	return ret;
> +}

[...]

> +static int en8811h_probe(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv;
> +
> +	priv = malloc(sizeof(*priv));

Use "priv = calloc(1, sizeof(*priv));" and you can remove the memset() 
below, calloc zeroes out the allocated data.

> +	if (!priv)
> +		return -ENOMEM;
> +	memset(priv, 0, sizeof(*priv));
[...]
