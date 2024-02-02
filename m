Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72731C47DB3
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A296887C6A;
	Fri,  2 Feb 2024 13:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aYYOA7De";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A6987C6D; Fri,  2 Feb 2024 13:29:18 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4A487C69
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 13:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0DA2462563;
 Fri,  2 Feb 2024 12:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301EBC43390;
 Fri,  2 Feb 2024 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706876953;
 bh=yrDSyXuAellJdubNUxWwU8avyaR+mQbZcsuoXighl9g=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aYYOA7DeoBL/AZje60QWi7yVfOCPWw0po68jrTzsbLfAfddgV2nsF6r1LQitoV3eh
 fw0d+9I7zEYmVTTURSRgkAyXYC+w6OL0WkVNpX7cjjcXmjfZ/7GH0We2/epETuSyXA
 rE+8ZG8oChq7SasJStREhWVTN1uCsMmtGFHXOWCvc123bSvu9DmzCwxdSLe6OPZm2d
 5Oufs8edvh2bY5wpH1JE6T4ju8qzzFgVmJSDhVc2yMc5KYOWFLYHh47XmDuG35FTyJ
 lPZp/4uZqOVjVeZmwkR0fv0loCORvamgCKdzfkONELAYflUWWn5A3UXFPLWbAarACu
 GTqkNqjspe1Vw==
Message-ID: <44fdf099-1810-447b-9f25-ecc6c9629a6a@kernel.org>
Date: Fri, 2 Feb 2024 14:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] net: ti: am65-cpsw-nuss: Remove incorrect RGMII_ID
 bit functionality
Content-Language: en-US
To: Ken Sloat <ken.s@variscite.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>
Cc: Nate Drude <Nate.D@variscite.com>, Eran Matityahu <eran.m@variscite.com>
References: <AS8PR08MB79915B184330438FBFE664DAEC432@AS8PR08MB7991.eurprd08.prod.outlook.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <AS8PR08MB79915B184330438FBFE664DAEC432@AS8PR08MB7991.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 01/02/2024 22:17, Ken Sloat wrote:
> The CPSW implementations on the AM6x platforms do not support the
> selectable RGMII TX clk delay functionality via the RGMII_ID_MODE bit as
> the earlier platforms did. While it is possible to write the bit,
> according to various TI AM6x datasheets, reference manuals, hardware
> design guides and TI forum posts from TI, this bit is "not timed, tested
> or characterized. RGMII_ID is enabled by default."
> 
> The driver implementation today however, will incorrectly set this bit
> whenever the interface mode is in RGMII_ID or RGMII_TXID. Since
> disabling the delay (bit=1) is not supported by TI, this bit should
> always be written as 0.
> 
> See:
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1211306/am625-enet1_ctrl_rgmii_id-_mode
> https://www.ti.com/lit/pdf/spruiv7 (Rev. B Figure 14-1717)
> https://www.ti.com/lit/gpn/am625 (Rev. B Figure 7-31 Note A)
> https://www.ti.com/lit/an/sprad05b/sprad05b.pdf (Rev. B Section 7.4)
> 
> Signed-off-by: Ken Sloat <ken.s@variscite.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
