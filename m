Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A328F94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7190983C51;
	Wed, 22 Apr 2026 03:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NxJhtdGc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Xmkmqu7e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399B083BC8; Wed, 22 Apr 2026 03:46:26 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F90183936
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:46:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4g0hsC6wTvz9tlV;
 Wed, 22 Apr 2026 03:46:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GrWt0eP60DE40ZOJhaTvS8v3xSdwyNfP0fMZjoeeeU=;
 b=NxJhtdGc9D1Ki/GRWkJM4clLzgNSVOgw+XYkFLeQnebVfA5gd6sI9JxPJ7YEivSW4hWhl+
 PU8mUrcy3SLmszYUR1rXpcCpt0qKAvE3O8y6mTW6KzzUXhT2/zn1Hn+z/pkfmt8Uvn7ci5
 AnUJFIiPbaCsiHVAHltiN+sxMSySD7tlBPlEy52MJM3lOsT+BkBZBih+eakDBgpaZWc52v
 mY6ne6QC55zSwlQrxHEdLWxEcwkTKozIOgWezNyT64yuCgu6NmDa2STVUto5BWuW3yUHRW
 SJvwTNsGnAy70RgYytqi4VpOu0KOCqzeVa2NW0cXb6xfN35QaLeRhiJQQodlCw==
Message-ID: <69ea2021-48e0-4b16-ae97-0d56b85b88d7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776822382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GrWt0eP60DE40ZOJhaTvS8v3xSdwyNfP0fMZjoeeeU=;
 b=Xmkmqu7eiqR+W3Jx8wZJcdNjVZHH749dgV/nfjyuJPHPmd8qGZO/ZyEzw9c1JIgLUediaS
 LYGtDtocny0FF4DMXZ6vHdzZalMoVa7FzPPNCNmDVJ5A52L1s+ab9yMKj5Tq6PZVAfq85f
 uWa+TB2/g7KQj4wqiaBprgWkx9TCl8iQzLXl4nGoEMTIq8tV+HdieAy8ytP7ku/VJbiZF7
 7Iv2QXBjH9HB0ggIJYKWkX6suMISAU5qluNucnzjn7V96991ErxNgAEFo+DMJiX0k92E5r
 CDu/lFdBizAoQjf7aSqJfcRJ0qgMxg1pr0mF39SjzEbqV3sZpSyLOJAUUScqgg==
Date: Wed, 22 Apr 2026 03:14:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] net: phy: fix duplicate eth_phy binding
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260421113445.3834570-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260421113445.3834570-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 62320f5d3d885337870
X-MBO-RS-META: bicnw1h7zponz45s8w8iurtthaujj77g
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

On 4/21/26 1:34 PM, Pranav Tilak wrote:
> When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are enabled,
> eth_phy_binds_nodes() called from eth_post_bind() already binds the
> ethernet PHY node to eth_phy_generic_drv. However, phy_connect_phy_id()
> called via phy_connect() also binds the same PHY node, resulting in
> duplicate entries in the DM tree.
> 
> Fix this by checking at the beginning of phy_connect() whether the PHY
> is already bound via uclass_get_device_by_phandle(). If so, skip all
> generic binding methods.
> 
> Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
> Changes in v3:
> - Moved duplicate binding check to beginning of phy_connect()
> 
> Changes in v2:
> - Move duplicate binding check to caller phy_connect()
> - Update commit description
> 
>   drivers/net/phy/phy.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index d7e0c4fe02d..b1eb5173fe8 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -927,7 +927,12 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   {
>   	struct phy_device *phydev = NULL;
>   	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
> +	struct udevice *phy_dev;
>   
> +	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
> +	if (!IS_ENABLED(CONFIG_DM_ETH_PHY) ||
> +	    uclass_get_device_by_phandle(UCLASS_ETH_PHY, dev,
> +					 "phy-handle", &phy_dev)) {

You can not simply disable the phy_connect() code if DM_ETH_PHY is 
enabled, that will break a lot of users. There has to be some runtime 
check here to determine whether a PHY is already connected or not.
