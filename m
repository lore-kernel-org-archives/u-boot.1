Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2396CFC503
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 08:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A098903B;
	Mon, 14 Oct 2024 10:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IsWoDRSN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CrNGKWFb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088438903B; Mon, 14 Oct 2024 10:44:11 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB7088FB9
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:44:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XRrP82Xv0z9sfB;
 Mon, 14 Oct 2024 10:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728895436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIv9e5bLPQFamMOcMXqoy/knLbcEGY4vPo96AorTCVg=;
 b=IsWoDRSNah4jzyAv0mJoVLaQX0RsLC2nDe91KXcpj19OZ9LjIDyLErkcFijF8961YrnFdG
 iFhGNUUl2Y+ZXvVbcD1MU9I0h5RK3tc/7dOyNSkPod6ZZU5KlTXAaW9D+HAZ6x1KQTPjV2
 /wFZncY/hMERNjif01GPoRf3n66ywSSZ5xKL7lScHxPSAVB28VchnX7j0jqMk0YfKljca2
 ASC6Ouaj9DiuRO/6OaSFPB1YInxPXMsUgP3c+pu1T6+8kN57a7NEGcpVHEstSfKtxOB7Xy
 7wMvOrkLZm6tWSEm5hO5ca/Lf+J923N++5LfUJXl5OBPgqMmdgepD47KDtiPUQ==
Message-ID: <3d811dec-d233-4e6d-bcc7-ac07c915e68a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728895434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIv9e5bLPQFamMOcMXqoy/knLbcEGY4vPo96AorTCVg=;
 b=CrNGKWFbhtoWv9qZTT616UvNkHFAP9UPwoIfQ/axDDfz7cCG8yosmQ9XKe58bvFzc1igGc
 cX0Kt1gjYwF8nlYOiP461rkLvbKyjUFGTTvEB4Ce3s7VJHtPVKxsDAVxj2rAVRjtja2xuq
 klb6CpgqxiUPAmnAyOR2lrtcOK9dBU0J01iBIWNOEjuQpXgQQ/vDKyccmVFHv4n+ZeG2Qe
 k4WUBN8tVnRKB9UqkE3UAY5/q4Slb3Kv7jt8cUEqJDpX1Hf0c8ptASr3X5t/eTIZx3GGaG
 m2cyd/W7sjVoBnurWbo63egqd3i+wYjEZvqSMYU+xHcr2WgAHOM3ZAMR1vs7eA==
Date: Mon, 14 Oct 2024 10:43:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] net: phy: Do not do CL22 phy reset before ethernet
 phy driver probe
To: Sky Huang <SkyLake.Huang@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>
Cc: u-boot@lists.denx.de, gss_mtk_uboot_upstream@mediatek.com
References: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241014070611.32040-1-SkyLake.Huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 782a5c4d7bc88af7f90
X-MBO-RS-META: f3jxtccce7wbs5iekszhi91ypuekbmsm
X-Rspamd-Queue-Id: 4XRrP82Xv0z9sfB
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

On 10/14/24 9:06 AM, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Remove unnecessary CL22 phy reset before ethernet phy driver
> probe. Lots of ethernet phys requires driver to load firmware.
> Before that, CL22 phy reset may lead to malfunction.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>
> ---
>   drivers/net/phy/phy.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 716a1d46111..e6fed8c41d7 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -839,8 +839,6 @@ struct phy_device *phy_find_by_mask(struct mii_dev *bus, uint phy_mask)
>   static void phy_connect_dev(struct phy_device *phydev, struct udevice *dev,
>   			    phy_interface_t interface)
>   {
> -	/* Soft Reset the PHY */
> -	phy_reset(phydev);
>   	if (phydev->dev && phydev->dev != dev) {
>   		printf("%s:%d is connected to %s.  Reconnecting to %s\n",
>   		       phydev->bus->name, phydev->addr,

This needs clarification and likely has to be handled differently. 
Removing the reset would leave the PHY in potentially undefined state.

Which PHY is affected by this ?
