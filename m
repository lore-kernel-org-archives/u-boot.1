Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE8FFF887E
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 01:27:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E66A8490D;
	Thu, 30 Apr 2026 03:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="HdATjE0O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0724C8491D; Thu, 30 Apr 2026 03:27:10 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47E0084903
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 03:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1777512422; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iEzb+wfqIdWqrRPUSNsgFOhH5gDaY59YDx1sSpL/Seg8wf98o+z6Ssw0xy+NPUvP6Fo6G/eTcB+/z8u3lyZHYXEB/3oKdMn3Ag+P5ZvHSIHSDMXixAh2uQJtu3eqsezay5W/tuTioWddfT503L28CJ+xGp+RDNSWPp1rTI2cfqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777512422;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VBlZ3y+T/a3VGdJDmVV27lh6eU9EAVLJYna3swzJws4=; 
 b=SgMC6fF2T6ECcLG13vCwIKb6NZd8JdfhJtPkDRfRLCyU9zicLW52CgAgD3k84Myf129Z1+I/DHAKEQgU17BrloIymDxwS+JB6YEngbe1AJcU0iZtxGPA8XUBYVeh+J9UYb0JxHBya8G7IQQZ0PjnayaeHp33q+DwLSaVOBccwA8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777512422; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=VBlZ3y+T/a3VGdJDmVV27lh6eU9EAVLJYna3swzJws4=;
 b=HdATjE0OKXctbO/cvzq5YbT/meIcgzAr/v+4Soo+bHt22wcXua1RovleoBE6Z/vK
 xos6G6Laxeu772r49ANw8huTvfuwICwFgeGS3udwWkeDw8pw57gX0bz6iuyZbVVMbk0
 3Vhtb1zGWN5esoNPPYpk0YZFfpl6/poxmEQyTVFI=
Received: by mx.zohomail.com with SMTPS id 1777512419223597.8061706984317;
 Wed, 29 Apr 2026 18:26:59 -0700 (PDT)
Date: Thu, 30 Apr 2026 01:26:38 +0000
From: Yao Zi <me@ziyao.cc>
To: Conor Dooley <conor@kernel.org>, Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com,
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de,
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream
 folder
Message-ID: <afKvzj0yoJ85-5VI@pie>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
 <20260429-glare-anybody-16c98d01184e@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-glare-anybody-16c98d01184e@spud>
X-ZohoMailClient: External
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

On Wed, Apr 29, 2026 at 08:48:39PM +0100, Conor Dooley wrote:
> On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
> > From: Raymond Mao <raymond.mao@riscstar.com>
> > 
> > Import k1-pinctrl.dtsi from upstream folder.
> 
> Why doesn't the platform just use the upstream dts directly?

AFAIK, U-Boot's reset driver for SpacemiT K1 predates land of the
kernel side driver, and follows a complete different (and to me,
broken since it combines completely unrelated MMIO regions) ABI.

U-Boot's version,

	reset: reset-controller@d4050000 {
		compatible = "spacemit,k1-reset";
		reg = <0x0 0xd4050000 0x0 0x209c>,
		      <0x0 0xd4282800 0x0 0x400>,
		      <0x0 0xd4015000 0x0 0x1000>,
		      <0x0 0xd4090000 0x0 0x1000>,
		      <0x0 0xd4282c00 0x0 0x400>,
		      <0x0 0xd8440000 0x0 0x98>,
		      <0x0 0xc0000000 0x0 0x4280>,
		      <0x0 0xf0610000 0x0 0x20>;
		      reg-names = "mpmu", "apmu", "apbc", "apbs", "ciu", "dciu", "ddrc", "apbc2";
		      #reset-cells = <1>;
		      status = "disabled";
	};

Kernel's version,

	syscon_apmu: system-controller@d4282800 {
		compatible = "spacemit,k1-syscon-apmu";
		reg = <0x0 0xd4282800 0x0 0x400>;
		clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
			 <&vctcxo_24m>;
		clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
			 "vctcxo_24m";
		#clock-cells = <1>;
		#power-domain-cells = <1>;
		#reset-cells = <1>;
	};

	(and many other independent system-controller nodes, each for a
	 distinct MMIO region)

I suspect we have to deal with the difference before switching to
upstream devicetree, since I2C controllers introduced in this series
do depend on resets.

Regards,
Yao Zi
