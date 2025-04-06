Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F260DC3600C
	for <u-boot@archiver.kernel.org>; Sun,  6 Apr 2025 13:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0F7282AAF;
	Sun,  6 Apr 2025 15:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iDOAimBk";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="caUQCmv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B475582B00; Sun,  6 Apr 2025 15:30:46 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8982682AAA
 for <u-boot@lists.denx.de>; Sun,  6 Apr 2025 15:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZVtWm2CN3z9v7H;
 Sun,  6 Apr 2025 15:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1743946244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mFUjgx/Lf6VGKSm31WZj24K2skP7ZyCA6zW1hzXRKo=;
 b=iDOAimBkdws7nvJUVlHrs0ny/nhS1OlSf1JW487/46sFNO1PVO9PkD3mNDFOcC2PVaumv0
 XD8txEgcGU9q+JUT9RHI5bpwQsHx3b+bp3jV+nYUh9612Us7omaIiHBHWIOa/U0zCJpy0u
 oqVj0J1DbvHcrcV1h6xZXyhVVYn0KUzcbmNAidyx2zeB8fXzvm6JZ4AIvAg7dOqKjB2+U1
 uXOAaQ3I0PWHL/B119vQl9SLe4G3e+o3IeQeWh84VsuGhffbyW8tmB6JYAKRqdLbElEnS4
 H7mvb/I0rbOwVhZNt1EEpuTiLnAKyvIpamP/Q24BuC+dPkCyX+/2MTT2Mzg+VA==
Message-ID: <eacd3b66-0262-4bde-9b91-6ca7eea789fe@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1743946242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mFUjgx/Lf6VGKSm31WZj24K2skP7ZyCA6zW1hzXRKo=;
 b=caUQCmv79am3lnv+512DmaMjja4LeUvlnfij1Ll92c+IsHvTYMy9woJjpZUL6aQ19/aHvv
 WfHHNrMI9JSpozLpBgSlTIDzsMYSbC1xd9K6LgIFfI3TYBAgVwpZNB+rm5FFnTYu42sFul
 NeZe+TTlDZPU2KwnstreULBQBPpHkd+9z+NEjymD+yWnkJ5FfRuNvCYKVbCTtSVzxZjxYv
 MDQVdTmSG3moMxz0OMvkxog/fAbjciSzyVdiTsuJWvdtjYNpAKlzxvIbYgMzBwSiilpeQj
 GtErBcVC8LDpGKg+5BBoklRBdfj8qo1LyRHXsw+22bg8HE3AzTGThA2tcXDrCA==
Date: Sun, 6 Apr 2025 15:30:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
References: <20250406130244.19496-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250406130244.19496-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 128aea79077b5e46836
X-MBO-RS-META: thxkz48doe9o3rppgqo8fnc6cya4x831
X-Rspamd-Queue-Id: 4ZVtWm2CN3z9v7H
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

On 4/6/25 3:02 PM, Lucien.Jheng wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Based on the Linux upstream 8811 driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> The MD32 FW is currently stored in eMMC partition 1 on Banana Pi BPI-R3 Mini,
> and it is loaded from there.

If this is ported from Linux, please include Linux commit SHA from which 
this is ported.

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3132718e4f8..5b4cf30b0a3 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -79,6 +79,40 @@ config PHY_ADIN
>   	help
>   		Add support for configuring RGMII on Analog Devices ADIN PHYs.
>   
> +menuconfig PHY_AIROHA
> +	bool "Airoha Ethernet PHYs support"
> +
> +config PHY_AIROHA_EN8811H
> +	bool "Airoha Ethernet EN8811H support"
> +	depends on PHY_AIROHA
> +	help
> +		AIROHA EN8811H supported.
> +
> +choice
> +	prompt "Location of the Airoha PHY firmware"

Can this do the same thing as Aquatia PHY and load the PHY firmware from 
filesystem on block device instead , using the blk* or fs* commands ? 
Then the hard-coded filesize and co. won't be necessary.

If you need board specific loading override, implement __weak default 
loading from file on filesystem by default (see what Aquatia does) and 
then override the loading function on board or architecture level.

U-Boot really needs a proper generic firmware loader, because this 
firmware stuff keeps showing up more and more, but I cannot ask you to 
write one only because of this PHY ... but if you are up for a challenge ...

[...]
