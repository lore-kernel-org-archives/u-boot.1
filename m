Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FE4C25B74
	for <u-boot@archiver.kernel.org>; Sun,  2 Jun 2024 12:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF3B87F4B;
	Sun,  2 Jun 2024 14:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="lNRxNTnu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L6CFzqEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB4587F8C; Sun,  2 Jun 2024 14:51:11 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8573787F33
 for <u-boot@lists.denx.de>; Sun,  2 Jun 2024 14:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VscDD1nPMz9ssS;
 Sun,  2 Jun 2024 14:51:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717332668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ika7qRsJm4pHItpQlAQarBkP1nmD4zOEXn6VQkVNV4U=;
 b=lNRxNTnu1w6IGe1fJE/be8RAsvacvyQdQHI1Ng/avCwSIo5jM2RDcRnIDrfzs+ds0TFO1B
 x0wLxMb08H5Ydasx19LXrzVBetuaJ1guw2uUaWWifDOUvFxBvNh6iNtUUMcLETFcECYeLK
 YDVXWqtVMzlxCrI2Ptch9XkUjQ0bgALswU0g7YaA8m55m+zvdC7QLRPUIVAXs4NYRYKJjH
 +hI/1kw2sXeInO5UN80HwUk5z0gsyFvph5PEZ++ZZv6/qx0hHtmvGBhWOR7YZqQQRl7v1G
 27UQ/siV0i4TkQ6CQIeo1tOsEY9GT544iA3piif6bOLAeDcXD69XFT1qn8qjuw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717332666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ika7qRsJm4pHItpQlAQarBkP1nmD4zOEXn6VQkVNV4U=;
 b=L6CFzqEHko+rYfAsR1h8xZ3J5+h//s83SUTVrQNabIqwJ+j20bH15MBY+o5BQoTWT62ceh
 8O/kfHq262aXSALgpl8TNvHZy16W9D5VADTlou5GdkqoG29pea1sXPHiY9J+ffLkZYYJDm
 i3/XIstUXf4BJH4x5NukXS5ZiRv5cTgDOl59COpE7XZ7x29KIeXuWYgC7ldK21Jj9tTILj
 vRPoN9LdGyjo1ANhOTGkWimn5kJY67728SbrKDsamnxGs1ClMISKApXgi9Q6A6yhORmX+M
 Z2WAWXdq+tsAfX64pFNOfBrf2Nw8xOid/d6KajsJVSZFHvusVlvXfgeFoNdO0A==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>
Subject: [PULL] u-boot-sh/master-cleanup
Date: Sun,  2 Jun 2024 14:50:14 +0200
Message-ID: <20240602125047.12374-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fkfimkdcgimanbkd5mqwmenb65o9f1jo
X-MBO-RS-ID: 1861ad6697c5592f380
X-Rspamd-Queue-Id: 4VscDD1nPMz9ssS
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

The following changes since commit ea722aa5eb33740ae77e8816aeb72b385e621cd0:

  Merge branch '2024-05-29-assorted-small-fixes' (2024-05-29 11:21:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup

for you to fetch changes up to ecfa301911405f9ebc27677f6d26fcd43309ed36:

  configs: rzg2_beacon: Realign ENV location and offset (2024-06-02 02:30:01 +0200)

----------------------------------------------------------------
Adam Ford (2):
      renesas: beacon-rzg2m: Add Marek to MAINTAINER file
      configs: rzg2_beacon: Realign ENV location and offset

Marek Vasut (2):
      ARM: dts: renesas: Remove leftovers after OF_UPSTREAM conversion
      ARM: dts: renesas: Reserve space in 64bit R-Car DTs

 arch/arm/dts/salvator-common.dtsi        | 1104 ------------------------------
 arch/arm/dts/salvator-x.dtsi             |   29 -
 arch/arm/dts/salvator-xs.dtsi            |   85 ---
 arch/arm/dts/ulcb-audio-graph-card.dtsi  |   85 ---
 arch/arm/dts/ulcb-audio-graph-card2.dtsi |   26 -
 arch/arm/dts/ulcb.dtsi                   |  509 --------------
 board/beacon/beacon-rzg2m/MAINTAINERS    |    1 +
 configs/rzg2_beacon_defconfig            |    3 +-
 dts/upstream/src/arm64/Makefile          |    4 +
 9 files changed, 7 insertions(+), 1839 deletions(-)
 delete mode 100644 arch/arm/dts/salvator-common.dtsi
 delete mode 100644 arch/arm/dts/salvator-x.dtsi
 delete mode 100644 arch/arm/dts/salvator-xs.dtsi
 delete mode 100644 arch/arm/dts/ulcb-audio-graph-card.dtsi
 delete mode 100644 arch/arm/dts/ulcb-audio-graph-card2.dtsi
 delete mode 100644 arch/arm/dts/ulcb.dtsi
