Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F13FCD37AC
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 17:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D23DB84659;
	Wed, 13 May 2026 19:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pGqBWkyi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h09gTc9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E93518467C; Wed, 13 May 2026 19:51:25 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE3883FB0
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 19:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gG1Gy0wRKz9t9v;
 Wed, 13 May 2026 19:51:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778694682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQRy5ZnggZnguDha9Zg/iIyWxmnL0IUH90CyzUW7IK8=;
 b=pGqBWkyi+L8S41jgLghppENn0pNu195dbMFu96qR2198ziEcZ46Uiuu/sEJXIslWsDWXku
 qIL5+1OT64OJfAUj2HVs0/9IXRVfROwrgLOAsukivdJtD9d3BL10RIZcU6mWJZyROCItRg
 WHAMddwh+ZC5CqwljrY4WHDAqPmgZl1tym77fIObcxiOCBM3UG/gojgBsodGWlfLWCUlHi
 ix/y54weDiC4ySKitn666hej5LfBlLptTuuJ/G3R+tAzh9S+HB06V5Oe3gHPX/HSZabQ71
 1nJleNExhkgWLz5nB/j4lVIGTnYlVQjtxdqYSvt5xCxPCrovsujfn56OGIgezw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=h09gTc9F;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5f8a52d8-765b-4a52-96b3-1258558bd500@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778694680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQRy5ZnggZnguDha9Zg/iIyWxmnL0IUH90CyzUW7IK8=;
 b=h09gTc9F4gr8M3kUvDo1Q5qLtflqVwz0k9OPI/XhTNxhAsmDcnqUn3JNjXiFSq/rZykgHF
 fVIybd7s1lGCIKxAMCMt2F1mNZHL5/qs1/XVjVI5A3yfRfzHMX3BkEKvEqXo+ESjKaKrb9
 k1i0LPzqRTtu52U6Ck8rjgR78ummfvElfgoEUR/kCWfUpLMxhnhTEVpQrwRg1eD+xLzjnB
 qwgfIvYNf2hOJx+po1RW39FNPVYQUyViJ2G6c8tves2fNY7i7wIgY4yv4/AsQ0Kl6hGOWd
 bXd4BdD2kH7caS7kjIWyuZrmZqn5MQFq4pOFhGT1sWTyWogEhCky48W5BD5HdQ==
Date: Wed, 13 May 2026 15:38:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] net: phy: fix duplicate eth_phy binding
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 "SkyLake.Huang" <skylake.huang@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20260513133344.1288865-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260513133344.1288865-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: dn15a4t57aefc6apnmmbywhmz1nj65fy
X-MBO-RS-ID: ec3cabd3d6a5297728e
X-Rspamd-Queue-Id: 4gG1Gy0wRKz9t9v
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

On 5/13/26 3:33 PM, Pranav Tilak wrote:
> When both CONFIG_PHY_ETHERNET_ID and CONFIG_DM_ETH_PHY are enabled,
> eth_phy_binds_nodes() called from eth_post_bind() already binds the
> ethernet PHY node to eth_phy_generic_drv. However, phy_connect_phy_id()
> called via phy_connect() also binds the same PHY node, resulting in
> duplicate entries in the DM tree.
> 
> Fix this by checking at the beginning of phy_connect() whether the PHY
> is already bound via uclass_find_device_by_phandle(). If so, skip all
> generic binding methods and fall through to phy_find_by_mask(). Also
> assign phydev->node from the already bound DM device.
> 
> Fixes: 68a4d1506109 ("net: phy: Bind ETH_PHY uclass driver to each new PHY")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
> Changes in v5:
> - Use int ret instead of bool phy_bound and goto out
> 
> Changes in v4:
> - Removed IS_ENABLED(CONFIG_DM_ETH_PHY), use runtime check via
>    uclass_find_device_by_phandle()
> - Fix indentation of binding methods block
> - Assign phydev->node from the bound DM device's ofnode
> 
> Changes in v3:
> - Moved duplicate binding check to beginning of phy_connect()
> 
> Changes in v2:
> - Move duplicate binding check to caller phy_connect()
> - Update commit description
> ---
>   drivers/net/phy/phy.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index d7e0c4fe02d..7d698f00c09 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -24,6 +24,7 @@
>   #include <linux/delay.h>
>   #include <linux/err.h>
>   #include <linux/compiler.h>
> +#include <dm/uclass-internal.h>
>   
>   /* Generic PHY support and helper functions */
>   
> @@ -927,6 +928,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   {
>   	struct phy_device *phydev = NULL;
>   	uint mask = (addr >= 0) ? (1 << addr) : 0xffffffff;
> +	struct udevice *phy_dev;
> +	int ret;
> +
> +	/* Skip binding if PHY already bound by eth_phy_binds_nodes(). */
> +	ret = uclass_find_device_by_phandle(UCLASS_ETH_PHY, dev,
> +					    "phy-handle", &phy_dev);
> +	if (!ret)
> +		goto out;
>   
>   #ifdef CONFIG_PHY_FIXED
>   	phydev = phy_connect_fixed(bus, dev);
> @@ -947,9 +956,13 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>   		phydev = phy_connect_gmii2rgmii(bus, dev);
>   #endif
>   
> +out:
>   	if (!phydev)
>   		phydev = phy_find_by_mask(bus, mask);
>   
> +	if (phydev && !ret && !ofnode_valid(phydev->node))
> +		phydev->node = dev_ofnode(phy_dev);
Is the !ret test necessary in this conditional ?
