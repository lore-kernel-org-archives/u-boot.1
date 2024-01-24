Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3C0C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 11:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFD6387BDF;
	Wed, 24 Jan 2024 12:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AyNjp95c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E997187B6C; Wed, 24 Jan 2024 12:58:18 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D2F87C21
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 12:58:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OBwCfB108718;
 Wed, 24 Jan 2024 05:58:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706097492;
 bh=YbBsZG5fV1CLJ62HRaZc6xuQip6oCOAGprkhMKVD708=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=AyNjp95cFrx7hJhwQBhEceDEgsYNBpzADeE/eZJk+11uokswnYJAl8Za6AzP3wl7f
 HqlW4UqHZNsJiJ6LnKmyz/BOGLifjbxMgg9TRTPmZ8kRXKWOxhMSppLxnQIFWZyt7I
 453nOknGymvmF1QOORbptG48Wp2w00AVLEVdPaEI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OBwCxY006617
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 05:58:12 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 05:58:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 05:58:12 -0600
Received: from [172.24.227.70] (a0503533.dhcp.ti.com [172.24.227.70])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OBudNS115396;
 Wed, 24 Jan 2024 05:58:10 -0600
Message-ID: <4eea1235-9e88-4044-9095-dcded9ad7f74@ti.com>
Date: Wed, 24 Jan 2024 17:28:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: tidss: Use DT property names for parsing nodes
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <u-boot@lists.denx.de>, <agust@denx.de>
CC: <sjg@chromium.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20240124090711.305690-1-devarsht@ti.com>
From: Nikhil Jain <n-jain1@ti.com>
In-Reply-To: <20240124090711.305690-1-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Devarsh,

On 24/01/24 14:37, Devarsh Thakkar wrote:
> Use device-tree node property names for parsing nodes instead of
> indexing as indexing could be different between different SoCs based on
> number of DSS entities available on that particular SoC.
>
> Also correct the video layer naming in driver to match to actual one
> being used in upstream DSS device-tree node [1].
>
> This also fixes AM62x splash screen usage using the latest upstream DSS
> device-tree nodes where hard-coded indexing which driver was using
> before this patch was not matching the correct properties in the DT
> node.
>
> [1]: Upstream AM62x DSS node:
> https://github.com/torvalds/linux/blob/v6.8-rc1/arch/arm64/boot/dts/ti/k3-am62-main.dtsi#L774
>
> Fixes: 5f9f816bb8 ("drivers: video: tidss: TIDSS video driver support
> for AM62x")
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Nikhil M Jain <n-jain1@ti.com>
