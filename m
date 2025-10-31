Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA95CCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938EB83A03;
	Fri, 31 Oct 2025 16:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SLl0WGll";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FRWzECFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D0383A05; Fri, 31 Oct 2025 16:57:18 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F394A839FD
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cylwq3NGXz9tMH;
 Fri, 31 Oct 2025 16:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761926235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSOfxjmPNpNK2oAOC3x+CT8Nfzc1ACiT4uspLbcjEcI=;
 b=SLl0WGlliyXFgKUBi4SNoBpc2ti+O3UEhNChj9xYBGzQSJ5PeKCPzURa1bXL7ZFwZezi2X
 rnshJwexm2RTUJ0S2X1kgL+/pVYZDXyboJ98+WDS2p98as0tyF8d1xMNxp0iH3ze+7A2X9
 d5ggMpnHTINpvps3FDmD/FHdVHW3WC5bVv7zmz0vObdjLHPj2jLajEqelPTowYXy7aOF/h
 lWYI5HTXa55G1sWFKHFuvMRGEFasXsbmUJCyRuqIuZS4m+XKLXhzw39bEQxIwI+WHGOsxQ
 TPVcTReNCaiksQ5LfTDLjgbHSn/KK7O+YV3Hn/EvPAFDypiLz2aEMoN5hMSemQ==
Message-ID: <9942f1d3-669e-48a6-923a-c2607eafdd02@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761926233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSOfxjmPNpNK2oAOC3x+CT8Nfzc1ACiT4uspLbcjEcI=;
 b=FRWzECFWobh0MuX5MEIZaOMnFxSwpKzE9GnAkFWcsguUnc698HzDL1OU4DGtwFBj+1HUS7
 Bo20fT41no/kPMrm34rEOeQ8Kg0IEg2EnHsOUIERWzYHSPMDabZrNRidYkQzyxiyFoKUyW
 Ygcon2B6/k5/EutwvTlwkkr+3/Q3oACHI13BLFkO/xV6u3s16jvuv4htg5DGFMhYGytjKz
 Tgnhl2U9Ip+fM5hDLf2icGi9qkvDabyIz27jr95YBkveVJF5nJazug5HQV4VSz2QO5n1+V
 sx1yzyEgzvcJBJz/Bd7YuK9gFzhJi/lEB2P8tOy46Z6ne3Akxo5TjGPVYmePgA==
Date: Fri, 31 Oct 2025 16:57:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
To: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251031152348.60571-6-root@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8x7idwdpo75ao3j91ohfs7enc1aeyqkx
X-MBO-RS-ID: da2df2a9f9c0c2b7659
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

On 10/31/25 4:21 PM, Beiyan Yun wrote:
> Aquantia PHYs are being used w/o SPI flash in some routers recently.
> Current firmware loader only attempts to load from FS on top of MMC,
> limiting the use on many devices.
> 
> Removed the old firmware loader, migrate to generic firmware loader to
> allow a wider range and runtime override of firmware source. (e.g., USB).
> 
> Tested on Buffalo WXR18000BE10P with UBIFS.
> 
> Signed-off-by: Beiyan Yun <root@infi.wang>
> ---
> 
> Changes in v4:
> - Split firmware upload helpers change
> - Reorder `aquantia_read_fw`
> - Make `aquantia_read_fw` weak to allow overide
> - Rename exit label in `aquantia_read_fw`
> - Kconfig polish
> 
> Changes in v3:
> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
> 
> Changes in v2:
> - Add support for script based loader
> 
>   drivers/net/phy/Kconfig    |  28 +++++----
>   drivers/net/phy/aquantia.c | 122 ++++++++++++++++++++++---------------
>   2 files changed, 91 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 018be98705a..4a74a0d4e8c 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -1,4 +1,3 @@
> -
>   config BITBANGMII
>   	bool "Bit-banged ethernet MII management channel support"
>   
> @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>   config PHY_AQUANTIA_UPLOAD_FW
>   	bool "Aquantia firmware loading support"
>   	depends on PHY_AQUANTIA
> +	select FS_LOADER
> +	select FW_LOADER
Can you not use the plain FW_LOADER to load the firmware from either 
storage, UBI or Block ? Is FS_LOADER even needed ?
