Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB025C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 12:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1AE8385B;
	Tue, 22 Jul 2025 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nszyVR5A";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="O6PlLn2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083D483865; Tue, 22 Jul 2025 14:57:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2DD8339C
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bmckD2Ln2z9sFB;
 Tue, 22 Jul 2025 14:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753189060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuzHkMF+9L68Idhw0l7HBvPEprH+qrpYzrpvmfdAEFs=;
 b=nszyVR5AeZMbRuXmfRZ3Z1XA6uWtjMuMHp3A8p9zsDBqlr4buQwCCczJ0HgzUI8Q6De+KX
 jnW1QTW7rYnWGuVg9uxfKvNdozn4oxCCF5y+DKtExbMqRiMv2XXUj8vA8TyhE4x5jcN5k9
 heJJtQ697J8JI1LXs5pe5QT7mayouiHI12aXrOuL3u7lvATVBRStl0KYtili7U9fICS3C+
 9Mz5c2KuJ8tnr/LkcROxs9fU9xrl/JbrpDLBhy34zwm2SSyxCMKpvVpODBC0OBW3eG6iox
 fMtMcOnKChQmO2JRNbQpZyEyAYmClZuBhKYb+gDa3qImiLSGojI104C0wjR71w==
Message-ID: <6d6759e3-1ebe-4e60-bac3-93f1b40aa726@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753189058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OuzHkMF+9L68Idhw0l7HBvPEprH+qrpYzrpvmfdAEFs=;
 b=O6PlLn2heWDBrbilbwsHUa1gGKceHA9dTVtd4XTHpVp8ZnzXmiqhzggClp4N9/WU6c7Cjj
 7Hu+Ncc3QRK2vgPUzYcCtjo0W/wyND5VoasYqP06+8aSr2H2wu5iavzrRGu9tlkXuOmUrU
 gYv6KR3OvHQv5Bomha/sed9gYz/hiqaYq9hmcvm7nWoSv3YCvxrY2Fz6TDcAy/sqWryQz+
 Xl550olpUC3zsx65Vdqacyz6kIKQEtbJKC4Ly8SsgjVlHzr9R2b5pe3mV+D8682lIOMGXe
 ZbjGelsgUvkY7U+NpWqCn3Md6y8YWER88grFEye5ec9AfcUvcIrEqdqVW5XO5A==
Date: Tue, 22 Jul 2025 14:57:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] net: phy: Support overriding Auto Negotiation timeout
 with env variable
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 marek.vasut+renesas@mailbox.org, jerome.forissier@linaro.org,
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, alexthreed@gmail.com,
 skylake.huang@mediatek.com
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, praneeth@ti.com, nm@ti.com,
 srk@ti.com
References: <20250722060554.352952-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250722060554.352952-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 717bb95c099e41a7160
X-MBO-RS-META: n7f51fgu9a8wzbb1c9fhytz91fk14zkj
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

On 7/22/25 8:05 AM, Siddharth Vadapalli wrote:
> The Auto Negotiation procedure between two Ethernet PHYs consists of
> determining the best commonly supported parameters among Speed,
> Duplex Mode and Flow Control.
> 
> The time taken for this procedure is not only dependent on the local
> PHY used, but also on the link-partner PHY.
> 
> While a timeout can be specified in the form of a "CONFIG" on the basis
> of the local PHY present on the device, since the timeout also depends
> on the link-partner PHY, it might be necessary to modify the timeout.
> 
> To avoid rebuilding the bootloader for a given device, just because it
> may be connected to various link-partner PHYs, each with a different
> timeout, introduce an environment variable named "phy_aneg_timeout" and
> override "CONFIG_PHY_ANEG_TIMEOUT" with "phy_aneg_timeout".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 7598b469c16 Merge tag 'u-boot-dfu-next-20250703' of https://source.denx.de/u-boot/custodians/u-boot-dfu into next
> of the next branch of Mainline U-Boot.
> 
> Patch has been tested on J784S4-EVM validating the following cases:
> 1. PHY Auto-Negotiation performed with "phy_aneg_timeout" unset.
>     CONFIG_PHY_TIMEOUT with a value of 4,000 takes effect.
>     => Auto Negotiation succeeds
> 2. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 10,000.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Higher value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation succeeds
> 3. PHY Auto-Negotiation performed with "phy_aneg_timeout" set to 2,000.
>     "phy_aneg_timeout" overrides CONFIG_PHY_TIMEOUT.
>     [Lower value than default specified by CONFIG_PHY_ANEG_TIMEOUT]
>     => Auto Negotiation times out
> 
> Test Logs:
> https://gist.github.com/Siddharth-Vadapalli-at-TI/697eadcbb26786435df48a834c968375
> 
> Regards,
> Siddharth.
> 
>   doc/usage/environment.rst | 8 ++++++++
>   drivers/net/phy/phy.c     | 6 +++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index bb6c351b441..7447bb85d3e 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -335,6 +335,14 @@ netretry
>       Useful on scripts which control the retry operation
>       themselves.
>   
> +phy_aneg_timeout
> +    If set, the specified value will override CONFIG_PHY_ANEG_TIMEOUT
> +    which defaults to 4000. The default value of CONFIG_PHY_ANEG_TIMEOUT
> +    may be sufficient for most use-cases, but certain link-partners
> +    may require a larger timeout due to the Ethernet PHY they use.
> +    Alternatively, the timeout can be reduced as well if the use-case
> +    demands it.
> +
>   rng_seed_size
>       Size of random value added to device-tree node /chosen/rng-seed.
>       This variable is given as a decimal number.
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index e6fed8c41d7..0f5c9685b59 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -9,6 +9,7 @@
>    */
>   #include <console.h>
>   #include <dm.h>
> +#include <env.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <net.h>
> @@ -243,6 +244,9 @@ int genphy_update_link(struct phy_device *phydev)
>   	if ((phydev->autoneg == AUTONEG_ENABLE) &&
>   	    !(mii_reg & BMSR_ANEGCOMPLETE)) {
>   		int i = 0;
> +		char *s = env_get("phy_aneg_timeout");
env_get_ulong("phy_aneg_timeout", 10, CONFIG_PHY_ANEG_TIMEOUT);
