Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F07CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33510846A7;
	Tue,  9 Jun 2026 09:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EWevMXlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CCA7846D3; Tue,  9 Jun 2026 09:32:06 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5583FEC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 1A0991FEA7;
 Tue,  9 Jun 2026 09:32:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1780990323;
 bh=7nJHLS3tZeDKtzww7sC+Mm7vUodpogKGbQbh0w5Jvqk=; h=From:To:Subject;
 b=EWevMXlGD01y520SXWBH0vzklme5LL3rStjTjHdnBfDmBRHZu04jUHzHKzg25osOf
 +84H0IMMCiFLFSjBnwWD62C3dKeZM2W04mo/arLidcUVkUyXlGl9AZzcxhcFYqC+rP
 GV+RWgSzLPdBy9iJWPFS0v8meiz2l0NUAStM2T9FkP2+VfAcxoKYceaviiTj+Erzu7
 tQFF3J6Y+6qVT3LDFygjLln1aw6FlcyZ9WeoMtidbnPFL0nf/cohYfDR9C+zPQ90NN
 EBlqCaaXRm9jqdwF/iB8HX5M5ZkDqLDJChBnKkvVUYxnbBfv6zGrnK2Tcd+650ixNn
 qrl+CJbv9cBkQ==
Date: Tue, 9 Jun 2026 09:31:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 01/13] imx8m: Imply DM_THERMAL
Message-ID: <20260609073143.GA19526@francesco-nb>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
 <20260609-imx-misc-v2-1-58e1665d55ae@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-imx-misc-v2-1-58e1665d55ae@nxp.com>
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

On Tue, Jun 09, 2026 at 04:36:18PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> CONFIG_IMX_TMU depends on CONFIG_DM_THERMAL, so when selecting IMX_TMU,
> DM_THERMAL should also be selected.
> 
> Update i.MX8M based defconfigs.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

