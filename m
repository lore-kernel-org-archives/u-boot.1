Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B0ACD6E50
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 14:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31AF8844CF;
	Fri, 29 May 2026 16:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="vGUOj/wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF0D84671; Fri, 29 May 2026 16:30:17 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212B380087
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 16:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from L30177.local (unknown [78.241.44.80])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2846F5FF95;
 Fri, 29 May 2026 16:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1780065014;
 bh=kLQ6uqVpOmhmdPzoMD71XTfqAy1TtDCVwpUfEAhGFIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vGUOj/wpxnT+2IEiGX0jd2rB+L3zKZOzbd1qfQOgnfiJ2ca+EkP1BX9twvQe4PCmG
 H/PxUvIs1rOD7Q0zh55fFhscwzSVquMHLVhL+QyCCCe8KjPd0HvW2DZenCYyKNP50o
 oldIgLbPT5BTzp+QBgJXczywEPlzh+XG5mRMWLmUqF68BZJgX3VeqWmmp8VHxONycr
 nFZHEb0vNrcY3KFNEPPl0W2SEurDKPSztl9qiS5CghVo6rTfXl8P9SRY4pJE/57g7q
 /I31aX5XWxejWWLmfmRCaFk8sG7O5fM9lEH0ijve7J5uupjq7SpH1roGTpIZy7meHs
 gfUblpC210rbw==
Date: Fri, 29 May 2026 16:29:58 +0200
From: Vincent Jardin <vjardin@free.fr>
To: trini@konsulko.com, vigneshr@ti.co
Cc: u-boot@lists.denx.de, christoph.reiter@evk.biz, dlechner@baylibre.com,
 flaviu.nistor@gmail.com, jeyu@issi.com, miquel.raynal@bootlin.com,
 yangshiji66@outlook.com, ssunkkan@gmail.com, trini@konsulko.com,
 vigneshr@ti.com
Subject: Re: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Message-ID: <ahmi5u70Ik5h5fBP@L30177.local>
References: <20260510222140.603755-1-vjardin@free.fr>
 <20260520150032.1904130-1-vjardin@free.fr>
 <5a74856d806a4dabad4055498c2c1420@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a74856d806a4dabad4055498c2c1420@infineon.com>
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

Hi Tom, u-boot's contributor,

> > base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
> > branch: for-upstream/spi-nor-gd55lb02gf
> 
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>

This is a one-line new-chip addition (without driver changes),
the patchwork delegates to jagan and SPI-NOR maintainer block
(Vignesh R) both appear quiet:
Tom, would you mind picking it up directly ?

https://patchwork.ozlabs.org/project/uboot/patch/20260520150032.1904130-1-vjardin@free.fr/

Thanks,
  Vincent
