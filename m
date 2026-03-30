Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05ADFB3CE6
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 09:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF3C83D17;
	Mon, 30 Mar 2026 11:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SXZqnqyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A0683DA7; Mon, 30 Mar 2026 11:17:29 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A52083C5E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 11:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 8D63B228D5;
 Mon, 30 Mar 2026 11:17:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1774862246;
 bh=2AvTNsMUkssACoKTD9gaB2BwBgjanBTfiBfq9k6N2xM=; h=From:To:Subject;
 b=SXZqnqytPFK8B/bQ0onMZDjtUAMdGPRWeU0s3mKEZeVlfC5vkzYJ8n0hvIJRv3QDb
 fAEeZaS43MP0D/AbRrpBpVNGKnqzJTa/3MorqNVNF6YeTXZamKdlbJLxtdWrUMEF6c
 HXLIGoDEZDsOPBYASM0D3iAFtntgOgB29t+7QdWuWQugTPwQoqyzrt/XyibSRMrWht
 UAvZAQPnCv6+nwzsemYS1ymTACGGOCDEA5m6lqOWCko16ZUdoo3USpMw2MJuPlEwr+
 lxBz+FqF1ZvDWL0/5S4BttyjBdVLdGx3gfLgVzYP8H3NS9WbWDGxl/YPhXPAI/bQVO
 cnRJLKBvCQNEg==
Date: Mon, 30 Mar 2026 11:17:22 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 0/2] imx95-toradex-smarc: Migrate to OF_UPSTREAM and
 enable GPIO_HOG
Message-ID: <20260330091722.GA28093@francesco-nb>
References: <20260330-smarc-of-upstream-v1-0-c5b8cab32a22@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-smarc-of-upstream-v1-0-c5b8cab32a22@toradex.com>
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

On Mon, Mar 30, 2026 at 09:59:40AM +0200, Franz Schnyder wrote:
> This patch series migrates to OF_UPSTREAM to receive automatic device 
> tree updates for the Toradex SMARC iMX95 and Enable CONFIG_GPIO_HOG
> to apply gpio-hog definitions in the device tree.
> 
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

