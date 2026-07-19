Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D86C44512
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 17:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D299D8494B;
	Sun, 19 Jul 2026 19:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="F9UNQrDI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227C384A12; Sun, 19 Jul 2026 19:13:13 +0200 (CEST)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA317842FC
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 19:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784481187; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mB2kWR4tD/9bELuI4A2Qm0cDFMUcKNQnlArAwCH2JWFZ4v6AM18s0HWNZNoXouZEyK0b6leSMlVntBtqwxJHEXikWrpXG4NjQZjZIKG5cbVyP4eMsXsLIjZTIs+voUWJZkXihKrqgRvweEuZm9f4no/V5Y5M6ekWVPxfpMV4HUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784481187;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=br+5uuOb8lMSOdOoK0gymAz1ijvCwEcEjeIs0e7wjv0=; 
 b=lZOUfjbsIvidzui0gLtlNZ0Gdio+Q+oIqs0m++lkYjT0ev1dEv6VeJOOpY2L429wyYudIgP2Ysst+n3ckBp5aIkEVbHQE7g8eLt8XqQf88piu+CZL97T2Hm2FuwoCvWX288jkzq/C0y/ZVHzSKCWwxsT8TfLvgr+Isoe3dxe6Ck=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784481187; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=br+5uuOb8lMSOdOoK0gymAz1ijvCwEcEjeIs0e7wjv0=;
 b=F9UNQrDIp3WsKsitrCXcEPjIuzXoQsAQkvUlBzrsZtafm9zZJx8DW8RcZtz1RXCM
 3kul9JGELoac5RqNK+x1pily1CeWaQddHD8sedrmfIsrZAtAGq7zjd2Pjy73awasn3Q
 PJMl5TJ91pl7aLLayYuEO1PhFi4UL7DaEYodBJi8=
Received: by mx.zohomail.com with SMTPS id 1784481184936744.9744413580735;
 Sun, 19 Jul 2026 10:13:04 -0700 (PDT)
Date: Sun, 19 Jul 2026 17:12:51 +0000
From: Yao Zi <me@ziyao.cc>
To: Eric Chung <eric.chung@riscstar.com>, u-boot-spacemit@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
Message-ID: <al0Fk8JyfYhu5b9y@pie>
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-3-dbd01185f911@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-m4-v4-3-dbd01185f911@riscstar.com>
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

On Tue, Jul 07, 2026 at 11:21:44PM +0800, Eric Chung wrote:
> Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
> manage multi-block read/write operations. This allows the MMC
> core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> CMD12 sequence, reducing command overhead and improving I/O
> performance on multi-block transfers.

From the description, it seems CMD23 support isn't essential for MMC
support on SpacemiT K1? If so, it might be helpful to separate MMC
core changes into another series, and focus on basic support only. A
smaller series is easier to track and review.

> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Regards,
Yao Zi
