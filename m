Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59D0606C966
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0JfM5SMV;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Xo3GCLmI
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99B7860788;
	Fri, 20 Nov 2026 18:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Aw8EoLAG1Wl; Fri, 20 Nov 2026 18:13:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D535060748
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795198411;
	b=SFriX9nVdks2RYsmoOJu7nlb/kOxebAuQixBmT3ppEMXm+toUPVDlQJxLeehO5meSvFP
	 eUqml9YCIKZTutJ9im8I3p44UHGaKrAeNEAdpb1FsJS6BJV3xJjZareceWvuSLKKFNFnO
	 G9YbunWZ5sF2SkSoXD+dpDhwn2Z269wyjsox+q4SLaiDu51peTjynlbui888Lm1XT6lGY
	 57cI41gdZHiXX2+ypKCxYgR27AHKKHm8sKEyeZCNN0/tSg7EOEkvA9ve/WnA26R9DWS33
	 cu3wen4lATmXSUOF2OSxzruJgx6wux6qwygf4SqIhodG33iUd182tsKGTiLyueZVguQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UZ6Z5o6gxETINA/UfqBW8NYvCu4fPdTkaEuvXanOdmg=;
	b=ZAhi1w8ZceCF+cIiXFiEVHgv33Ys2eV5theg4Za8mLa1qlu9PD56YxvfS+IsjNZl7Cik
	 pfqBEzRviQb5VZgjqmGkz1oJ/9G2u54FRZzXD2P6fX9/7EBQ55WAwyGQZ1fkcvlo3GRjc
	 EXyBjtV2OIYJMvtLvxBNF28RRzs72Gd7Mog6dHzy77WWeCLs+TIzDI3qhAhRWpdD3P3CP
	 fU9U2/HvBxFnOBRckvgfzYrWOvd/tIPiM7bMcu4YizWU+Q8b3HUCiU0ldv317fpdA20RL
	 i63f0Yn9dJukZ0b5jr8SZ60sgqroMvswlZ/2BfJWW5OdaO1SWET2P7lylmDzdfwU1sQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795198411;
	bh=UZ6Z5o6gxETINA/UfqBW8NYvCu4fPdTkaEuvXanOdmg=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0JfM5SMVETc0MtD0HwX5xx3s7BjFtzNUrbT8MsEtdu38roLtl2jpampATBSbwEEYj
	 IOAPZFHB8PEyypXRqcerN8YGkYTr9ao1N+/aiuvdTKhBtct6N9+ltQtNsMNMhSnhKr
	 sFN+YVqwJuYm5CuXBffIGIrqilScPLFFWnxIZcCzDLtL2v7Nw4Q5DIGxZvxbSYFpJI
	 d5ftRsGyetDhc4zzV/fg5WW8Z9XRI6G0GtZIB9fxAjxxYsx/lei8WktIuOhnlK4pNs
	 J7nXhmS+wkosd/GiyiqxvZt37KACLD/g9gYdzX41oWL09TjgSWtQ01mEfYIccy9uhN
	 x2IeDW+3uH3sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D535060748;
	Fri, 20 Nov 2026 18:13:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 97B44498
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88FDE40AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzXtdAy4MD-J for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 18:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A9750400A2
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7779e6c3c=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=Xo3GCLmI
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9750400A2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 18:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1795198408; x=1826734408;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=UElFKAN9i4dKz1K8H8bYavg+U3lj8AkoyyMSTzrHxu4=;
 b=Xo3GCLmIEaVo18q5e9LhVjZdD2ShnQeSk9PXoMxIAGBUhJRKtegR64w0
 uMt66gjzYrrU5hURNt7Jr0aGOGeXnZwYlpxs2GIiGQPmKKv+iUnRFdqy9
 dXb+HdUea2K66DNlXa69sQN1rkeq39/Cz2Yw4Hm5/JePmCNpJNfBN6yXH
 RKYKee6r01aXJ9jxVAeptvkn8oZO9DtKQls/BoXnjhuqyOS/Rbcbpj6s2
 8buEFEwzESBrE0p+T4BjMjd/LL0HIpCfAjTegIfaK7v1u5FS3GWqR3Wrv
 Mpc3elDqeLkCZPpgisVG6p+iLla6rQRsB4TD214Q58DkZ64pNrvFLSuvB g==;
X-CSE-ConnectionGUID: 8nm+aKeJSma9GVHlIIo2mQ==
X-CSE-MsgGUID: UCJjal82SIuv//MVhAbFuw==
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="67070703"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Nov 2026 11:13:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 20 Nov 2026 11:13:24 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 20 Nov 2026 11:13:23 -0700
From: Charles Perry <charles.perry@microchip.com>
Subject: [PATCH 0/6] Add support for PHYs on external MDIO bus to GEM
Date: Fri, 20 Nov 2026 13:12:59 -0500
Message-ID: <20261120-add-macb-support-for-dm-mdio-v1-0-d344297d5b44@microchip.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqDMAwA0F+RnBewtVPxV8YO1cSZQ21JtyEU/
 93i8V1egcwqnGFqCij/JUvcK8yjgWXz+4dRqBpsa3tjbIueCINfZsy/lKJ+cY2KFDCQRLTd6GZ
 ybvDDE2qRlFc57v71Ps8LsMl5nW4AAAA=
X-Change-ID: 20261120-add-macb-support-for-dm-mdio-2384bd447a75
To: <u-boot@lists.u-boot-project.org>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Nathan Whitehorn <nwhitehorn@pa.msu.edu>, Conor Dooley
 <conor@kernel.org>, Romain Caritey <romain.caritey@microchip.com>, "Mame
 Maria Mbaye" <MameMaria.Mbaye@microchip.com>, Charles Perry
 <charles.perry@microchip.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

The goal of this series is to make it possible to connect a PHY that is NOT
connected to the internal MDIO bus of a GEM. This is a common case on
PIC64-HPSC/HX as the GEM does not have the internal MDIO bus and rely on an
external one.

This doesn't work currently as the code calls macb_mdio_[read/write]
directly with no regards to the phylib abstraction layer.

Speaking of phylib, I've noticed that CONFIG_PHYLIB is always defined for
configs using CONFIG_MACB since the former is selected by the later. Patch
1 removes all the CONFIG_PHYLIB #ifdefs.

I then remove most of the calls to macb_mdio_[read/write] in favor of
the phylib equivalent with the exception of macb_phy_find() which I believe
is necessary on some SAMA platforms that don't declare their PHY and just
grab the first one.

Finally, a call to dm_eth_phy_connect() is added if CONFIG_DM_MDIO is
available that will grab a possibly external PHY. If that fails, the
phy_connect() code path resume as before.

I've tested this on PIC64-HPSC/HX where the GEM doesn't have the native
MDIO for the CONFIG_DM_MDIO code path. I've also tested on various sama5,
sama7 and sama9 boards for the native MDIO code path. Conor also tested on
Polarfire.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
Charles Perry (6):
      net: macb: remove CONFIG_PHYLIB guards
      net: macb: check the return status of phy_config()
      net: macb: remove open coded phy_startup()
      net: macb: parse the phylink status instead of reading status registers
      net: macb: remove useless read in macb_phy_init()
      net: macb: use dm_eth_phy_connect() if CONFIG_DM_MDIO is enabled

 drivers/net/macb.c | 168 ++++++++++++++---------------------------------------
 1 file changed, 44 insertions(+), 124 deletions(-)
---
base-commit: c1958b5f6cce03956d309ce422b5d9f819955d4a
change-id: 20261120-add-macb-support-for-dm-mdio-2384bd447a75

Best regards,
-- 
Thanks,
Charles

