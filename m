Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39638C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE4187DCA;
	Tue, 30 Jan 2024 15:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="XwnKX0v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F74D87DE9; Tue, 30 Jan 2024 15:16:04 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8586287DE9
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rUou2-000748-Je; Tue, 30 Jan 2024 09:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=cDe8BiTYjAtzajkZcOS+epW3kLCt1a1x2hqEp5mUu2g=; b=XwnKX0v93zvoyvhQFDij
 T+fO+KZsmbbQP2wYC5g6MzCb1RLPsUmhJ8r79+2O7w9Xu+Ipu4dzd9r/a9EXKkhy6dPHCCezhhQD2
 6UYBDNVVc/VsENuMpWXlr20a/3C6mSUpZARMqW+dfXsIZEekAI7w2ODq4eTGel+5KmjsNdrN7X0MF
 GKCLhJ2nYYPuOv/R5GLHhSV7jAlxwcfVlPUyefnkyE/XUAS523AdQGdB2EEOikfocMpQa0U57YH+j
 OW3AQZNjFsDEoAzxjPXdLrhRO4quxt7v6pUS5xxjeOJ85pItbxutcgvYsh7r0PL4YaIK4ssxjOV+C
 ijHaUIAHNqr1iA==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Stefano Babic <sbabic@denx.de>,  Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,  Tom Rini
 <trini@konsulko.com>,  Peng Fan <peng.fan@nxp.com>,  Ye Li
 <ye.li@nxp.com>,  Jacky Bai <ping.bai@nxp.com>,  =?utf-8?Q?S=C3=A9bastien?=
 Szymanski <sebastien.szymanski@armadeus.com>,  u-boot@lists.denx.de,
 upstream@lists.phytec.de
Subject: Re: [PATCH] imx9: clock: Fix board_interface_eth_init for FEC
In-Reply-To: <20240130124337.497748-1-primoz.fiser@norik.com> (Primoz Fiser's
 message of "Tue, 30 Jan 2024 13:43:37 +0100")
References: <20240130124337.497748-1-primoz.fiser@norik.com>
Date: Tue, 30 Jan 2024 15:15:48 +0100
Message-ID: <87cyti52ln.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 30 Jan 2024 15:20:20 +0100
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


Hello,

> Fixes: d5eae216d833 ("net: dwc_eth_qos: Add board_interface_eth_init() for i.MX93")
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

I confirm that it fixes Ethernet connection when using FEC as a primary
port on the phyBOARD-Segin-i.MX93.

Tested-by: Mathieu Othacehe <m.othacehe@gmail.com>

Mathieu
