Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C1C5B572
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 14:20:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1068A406F9;
	Sun, 16 Aug 2026 14:20:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPqZjnqfq8v2; Sun, 16 Aug 2026 14:20:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B016406AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786890002;
	bh=mzw8ECEEK8Vl51VCTdac7JWlKsLYGrfEo63xDUjiXl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yUe30zPxZiWCXpXG+KnlzGgewOmEZRzeakA69y3h0xplnn5zIkiyM1yvJ5khIBxrL
	 WpgtEpLbTI6MeLIMjHigl4HJWqeenUyRcNL0GhW5L2l2lg8hxGuPvSN8b5dBgtknqW
	 MhZGolcDLsCPZ4o4SIWQJ1CqxJxPqzYay9nGO3/GvQlYot4EnG0Nv/mLp0VqjF7Jod
	 iHT91NFRZ84RydeiIKGstfVW9ByUBMYJlntdQGM7IPLyt7ybRooFz0LUyDIDBvKkvs
	 bTG1s2+F1BAXqxNbLc08xHzj7Cdc2uHaslvP/IeRKpXaCvwlrJ9HJpvIrQqM4st4h2
	 hDa1utOZEo07A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B016406AE;
	Sun, 16 Aug 2026 14:20:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B7EF4337
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 04:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA14C60642
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 04:15:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TrSkksJtyulW for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 04:15:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E98B06062B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E98B06062B
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Yq+FPHWZ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E98B06062B
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 04:15:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E04F5415CA;
 Sun, 16 Aug 2026 04:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A5C1F000E9;
 Sun, 16 Aug 2026 04:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786853736;
 bh=mzw8ECEEK8Vl51VCTdac7JWlKsLYGrfEo63xDUjiXl4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Yq+FPHWZOb44EQ+3OSWovk4LC1aQGLvVY4ICpG6p94OhC2v4LNjACraFkS574mdYb
 k316/RhvGPpB7lxadrW1P4/Gbjhl+d5YDtAlJ2clRCgQSk0HNP+m9Yhh6v83Vdcats
 fa3ZG9pXpcYhDPwWkE6ALKclNHCVVueN2MGCgAU0uLytVhCuuP0wIvcPFAYAD/18Pv
 6jIleg/O1Ow3h6Is/eKV94VR18MNddJNvLaV+l9RY6duOEtjD6Mp0U789cbr5sFGgl
 2mMkZby0geePgX3kAidCVsumOyahWF6/PbetuDeLiA/Kqf6RMrm1a2zsHxyjUnQfUf
 p+XfDB5n4hBqg==
Date: Sun, 16 Aug 2026 04:15:34 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
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
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v8 06/11] dts: k1: add SD card support in u-boot overlay
Message-ID: <20260816041534-GKB318749@kernel.org>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
 <20260802-m4-v8-6-e916643205f3@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802-m4-v8-6-e916643205f3@riscstar.com>
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:20:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Eric,

On 00:40 Sun 02 Aug     , Eric Chung wrote:
> Add the SDH0 controller node and its pinctrl groups to the u-boot
> overlay. The upstream DTS only contains the eMMC node; the SD card
> controller (sdhci@d4280000) and its MMC1 pinctrl configuration are

The kernel side has added SD card support, can you sync first before
adding more into the overlay?

> missing. Place the new node inside the storage-bus via path-based
> merge so it inherits the dma-ranges from the parent bus.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---

-- 
Yixun Lan (dlan)
