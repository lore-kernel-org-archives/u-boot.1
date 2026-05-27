Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E08CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206EF844CF;
	Wed, 27 May 2026 14:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KyWz2d8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C288464D; Wed, 27 May 2026 14:17:08 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD58F8056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gQTBn0ydvz9v8y;
 Wed, 27 May 2026 14:17:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779884225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayElQ64k5B2yz98Bu+U0LWtz69RljwHE51VcnvKSOL8=;
 b=KyWz2d8ELysiI9jLDMJBjOP+5MSdxm+9As+yh/SFhev9VpRcq+jXFtruRhTXBSoAIzgDzV
 6GP1S9d8tZcWuLp5Tf3BOWq7rSiw1JDS4lrqxGE0FZ2qAorOxhUNOcM7G4vT3JVQDTSdrq
 FKPaPLcajBZySXErVb7bUzmurSPVJR0W+ttvAhe8B3yizJAFoqIU0PiT2bzMmNt/HHheA3
 JMJVnhWQF0/UUkS0MMXWYxeMWFPQNJUVscSMBnpmXwTWLsNP2Zj/+mAP+x8LAZVIf7EWc2
 scqj6A1UK/BwJ7h62I13S2bygFMRIBEIcsmw17FH5CNach1DkIkkEyj6XnesZA==
Message-ID: <771367f7-23df-4e4d-872e-b2ea4e2b1e1e@mailbox.org>
Date: Wed, 27 May 2026 14:17:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] phy: marvell: comphy: Use dev_read_addr_index_ptr()
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Peng Fan <peng.fan@nxp.com>
References: <20260526-devfdt-phy-v1-0-908ff621dea4@nxp.com>
 <20260526-devfdt-phy-v1-2-908ff621dea4@nxp.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20260526-devfdt-phy-v1-2-908ff621dea4@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 5q4re1y8y6p61eax5ugnnpz1eywxyps7
X-MBO-RS-ID: 6ab2b2e11d2599f303d
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

On 5/26/26 08:39, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use dev_read_addr_index_ptr() which supports both live device tree and flat
> DT backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/phy/marvell/comphy_core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/comphy_core.c b/drivers/phy/marvell/comphy_core.c
> index b074d58f9f6..0ab5f9a3f0a 100644
> --- a/drivers/phy/marvell/comphy_core.c
> +++ b/drivers/phy/marvell/comphy_core.c
> @@ -84,11 +84,11 @@ static int comphy_probe(struct udevice *dev)
>   	int res;
>   
>   	/* Save base addresses for later use */
> -	chip_cfg->comphy_base_addr = devfdt_get_addr_index_ptr(dev, 0);
> +	chip_cfg->comphy_base_addr = dev_read_addr_index_ptr(dev, 0);
>   	if (!chip_cfg->comphy_base_addr)
>   		return -EINVAL;
>   
> -	chip_cfg->hpipe3_base_addr = devfdt_get_addr_index_ptr(dev, 1);
> +	chip_cfg->hpipe3_base_addr = dev_read_addr_index_ptr(dev, 1);
>   	if (!chip_cfg->hpipe3_base_addr)
>   		return -EINVAL;
>   
> 

