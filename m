Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A56CD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 03:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29FBE8464D;
	Wed, 13 May 2026 05:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iqcqN0jn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UeRxRPfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 854528469F; Wed, 13 May 2026 05:04:36 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31BB84255
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 05:04:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gFdbk3fFgz9vPP;
 Wed, 13 May 2026 05:04:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778641474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4PabsRts/fuL9pr6MLLMUPSDf+U0hHAsT2VHqWMR18=;
 b=iqcqN0jnyg8qYRD7+J2kL1LrtPxv2IBaM2jhPdk9LwFUnFlGQQqBu+sUeBNf0/Q9yQfAST
 WgI7p32iCIQT1no6uWMrbU4fUYEswvhGiSfWs//k+IkMhUhZKUbgIvkbkN7dmOSlcefzCQ
 8Qs5oqXOu3mZKnjmhoMVi+xIJ7ATbpPjAWBpYH27FcZD+QYyTE54Utau/Kx9APpv6+fXap
 0wM33x9/RYjaJ/CUZrh4kNEcMrVSo/Mu63j3EU4ucbcSSBClDXlFa3cdr0Tnv9u7UHlLaS
 7m7FBL2qY6Huvy0MOIEONo9eCid5gOz3nWDJ9JGrk4IK/siMi6oU+sQDY5ncng==
Message-ID: <758b77b6-1be5-4563-9688-75ee457abe60@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778641472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4PabsRts/fuL9pr6MLLMUPSDf+U0hHAsT2VHqWMR18=;
 b=UeRxRPfg+Or6JLfRnLFpbtA/IiUhMFvV4xYoIvuiQYh65GGtzVOkgJClx2S15V+OjXHkOU
 JXP+6YV5Po/3y2C7XDZ9mVaHESyFmzG22q93dbrC7SkE4r8G6139G4VY6GPlRsI6gWoTJG
 2Cd1l4GUiQ8VYh0/p3nJ5BKXBxHz3MLh7w0a9RWvUl12yeujkIcXnVY2hVpx21FcZGCKIH
 Z2zNzMve6bKcDydj25YNf0OHMEfLh/3Lo+nXFbkvPzi8Jo/jpLNjhQxJz7yDBtL8LODutm
 M56htbCRpymtiK+1aDScmLM4ViJEqF8a1mDSPa9jvCKjoAlfohY1XkTiKk7GUQ==
Date: Tue, 12 May 2026 21:13:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4] net: phy: fix duplicate eth_phy binding
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260512122440.677784-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260512122440.677784-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9z57bjwes8iwwbjjeaz841fz66tz4ohq
X-MBO-RS-ID: cedb27ede88a09bc5c3
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

On 5/12/26 2:23 PM, Pranav Tilak wrote:

[...]

> @@ -927,29 +928,40 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   {
>   	struct phy_device *phydev = NULL;
>   	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
> -
> +	struct udevice *phy_dev;
> +	bool phy_bound;
> +
> +	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
> +	phy_bound = !uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
> +						       "phy-handle",
> +						       &phy_dev);
> +	if (!phy_bound) {

The double negation is not needed, simply use int data type .

Also, try "goto exit" ...

>   #ifdef CONFIG_PHY_FIXED
> -	phydev = phy_connect_fixed(bus, dev);
> +		phydev = phy_connect_fixed(bus, dev);
>   #endif
>   
>   #ifdef CONFIG_PHY_NCSI
> -	if (!phydev && interface == PHY_INTERFACE_MODE_NCSI)
> -		phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
> +		if (!phydev && interface == PHY_INTERFACE_MODE_NCSI)
> +			phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
>   #endif
>   
>   #ifdef CONFIG_PHY_ETHERNET_ID
> -	if (!phydev)
> -		phydev = phy_connect_phy_id(bus, dev, addr);
> +		if (!phydev)
> +			phydev = phy_connect_phy_id(bus, dev, addr);
>   #endif
>   
>   #ifdef CONFIG_PHY_XILINX_GMII2RGMII
> -	if (!phydev)
> -		phydev = phy_connect_gmii2rgmii(bus, dev);
> +		if (!phydev)
> +			phydev = phy_connect_gmii2rgmii(bus, dev);
>   #endif
> +	}

exit:

This may simplify the patch .

>   	if (!phydev)
>   		phydev = phy_find_by_mask(bus, mask);
>   
> +	if (phydev && phy_bound && !ofnode_valid(phydev->node))
> +		phydev->node = dev_ofnode(phy_dev);
> +
>   	if (phydev)
>   		phy_connect_dev(phydev, dev, interface);
>   	else

[...]
