Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD1D10F9969
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 18:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FABB838BB;
	Wed,  8 Apr 2026 20:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HuBZRjMq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oMNa4s8c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7424D83CF5; Wed,  8 Apr 2026 20:14:40 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E68083693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 20:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4frWRy00ysz9vDT;
 Wed,  8 Apr 2026 20:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775672078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lebOXzcoYUNHnocebMECVrADU+ybFkve7oYLGawvFNY=;
 b=HuBZRjMqpyGNe7KGzge1QCPHuWnrTgLIKJ3AXi1Z6lwbNkhSHr58lXUEjUxYdzgCdGy3wp
 mZIGB9dU3ttqxWcTSZmstLwt8UH6X5bHuzAyGhPPZrTqASGiFGzcfMr46KEHx4lV0wFEot
 0pPwcF6ReZngzMh5YwDNfLkRF5XkZeuOhXJdky+gcEfZEsJE4SlDWccbtBpqziCAgxFMDm
 2yqEM1P+AAfIYDfgaegcpWN+EQE3MtMFpJFwimAMZOVBvNJVuWSWAGFW4nZXYDf4kgQkJh
 Ysjk42IUeOgWVIfDPY2lGiHgRgCZ2sUDprWbzccbaL4VG3J+sk4A6Sptm0J5NA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=oMNa4s8c;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ffade924-420d-48e6-a49c-b2cb2673c94e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775672076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lebOXzcoYUNHnocebMECVrADU+ybFkve7oYLGawvFNY=;
 b=oMNa4s8c/jeII9bEzHmnmmLSXOPizMqXStH/vKl63n9Emz52i2VeZkPR76xg4RaWToVS3g
 Yz0NAjS3D+wAGnYMPXN/qwj3hPMKmJbf6jnPWJEV0f6DAhL+HdzJl/6HYoz9uXZfhbqKrW
 JYRWUBxBGyZQghX4AM9urdILv7RvjsRukeQCeHVRbZ/a26nJ8mVSQ58IbyydJ1M3Gsl0sx
 54N3OQKuEpBrGWtN5SjIKauimOWF/Wje2tmwSp+nIgZYZS+zRMjIRSlhfHCwn5vnzE3yod
 wOBKT0ODf+jzhfqwkSvdPjIYmGS3Y2sN16t8GvORelw8QTDCpUfgnaBavtIfIA==
Date: Wed, 8 Apr 2026 18:31:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: phy: fix duplicate eth_phy binding
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Yao Zi <me@ziyao.cc>, "SkyLake.Huang" <skylake.huang@mediatek.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260408085844.2942463-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260408085844.2942463-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qp49da8rq6d4sjakrhkh6jw3usk6oubc
X-MBO-RS-ID: 46119afbf9d8d92e560
X-Rspamd-Queue-Id: 4frWRy00ysz9vDT
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

On 4/8/26 10:58 AM, Pranav Tilak wrote:
> When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are enabled,
> eth_phy_binds_nodes() called from eth_post_bind() already binds the
> ethernet PHY node to eth_phy_generic_drv. However, phy_connect_phy_id()
> called via zynq_phy_init() -> phy_connect() cannot attach to the already
> bound PHY device and creates a second instance, resulting in duplicate
> entries in the dm tree:
> 
> Fix this by guarding the phy_connect_phy_id() call in phy_connect()
> with uclass_get_device_by_phandle() to skip re-binding if the PHY
> node is already registered in UCLASS_ETH_PHY.
> 
> Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
> Changes in v2:
> - Move duplicate binding check to caller phy_connect()
> - Update commit description
> 
>   drivers/net/phy/phy.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index d7e0c4fe02d..cfca8328f1c 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -938,8 +938,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   #endif
>   
>   #ifdef CONFIG_PHY_ETHERNET_ID
> -	if (!phydev)
> -		phydev = phy_connect_phy_id(bus, dev, addr);
> +	if (!phydev) {
> +		struct udevice *phy_dev;
> +
> +		if (uclass_get_device_by_phandle(UCLASS_ETH_PHY, dev,
> +						 "phy-handle", &phy_dev))
> +			phydev = phy_connect_phy_id(bus, dev, addr);
Shouldn't this binding check be closer to the beginning of phy_connect() 
? Basically check whether the PHY driver is already bound at the 
beginning, and if so, you are done. I don't think that test is specific 
to CONFIG_PHY_ETHERNET_ID, is it ?
