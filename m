Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46357C46CD2
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 01:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01672880E7;
	Sun, 28 Jan 2024 02:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iEgZ/Kc1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dHGwO9Qx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B318813D; Sun, 28 Jan 2024 02:21:44 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF0D88093
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 02:21:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4TMtts58scz9sST;
 Sun, 28 Jan 2024 02:21:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706404901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y9zfO2nbbVvUrIJlvI2L1EicTxhG/pfvOP7+R4S51JI=;
 b=iEgZ/Kc1gM5K+gHe0oWDsDk9FTI/9ZNU2MRMkdoycloNicKYNhlXEb+vVDfP+UEjiDTLuB
 zHx+OPGSdlSMFNBYXnKTFyirzAAahovZ9RCtE4alIv2VN2loIac76htgyH0tp7JfGeagH9
 0aMMBCKnCLG6PdrCw4awQaHOiCkHGXO7LmFZJwhfEDiIuDkPcezqB2uCjMzTZmHJCq7UJZ
 +Xk9gFkVIX8fz6JPYiBPHVd1G0mDLIpbvMAR2Ndms3Nnj/Cl2tBZq0od1qgv+TTx+vrC70
 tB/BKUBfKrp8BziyRSTls0DH3s8cCtZj5kz+Qugw5S/RKumcm2zhQn77TFyCng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1706404899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y9zfO2nbbVvUrIJlvI2L1EicTxhG/pfvOP7+R4S51JI=;
 b=dHGwO9QxYTS4fIGHzLXry8btgVieZohxI/li05ELpl/YuRJcMV1qqRbS6sAG4e7Tqy0J0J
 zquAfwcn1UNmNtbtk8U3PyvbcXbLkoUdAeFqSFw8z0gOO+gOlqPPKfMEbb075lBkGUkoYk
 Ao9HyY0UfNgJO2MacrxqQ+ZN3sLJlvRKmqdeUg+g9pQ1yQjGWcb+8bbBqe1i4AvYOCyB0+
 ULagWaWigOT4Gh6aZIQQwhppfR2DCYw762BWoIIwpaov0lsTeZjgm4EAytlLIODN/EFQ3C
 3gCrCv5xnQcDN5DWu2JcvRrq7TguF1dGoVd7CNaEe/x0OGncK31/2x8crbsQ8g==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master-cleanup
Date: Sun, 28 Jan 2024 02:20:50 +0100
Message-ID: <20240128012125.60127-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e047d1c2b8409ff94eb
X-MBO-RS-META: rf98ek4wzo3migrwokcxmeia6cpe31c8
X-Rspamd-Queue-Id: 4TMtts58scz9sST
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

The following changes since commit fea3efb757f7a9c6831c023cb456f9fa5fd0278e:

  Kconfig: boot: Imply BOOTSTD_DEFAULT when BOOTSTD_FULL=y (2024-01-19 18:30:08 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master-cleanup

for you to fetch changes up to 8a725c610675846b380d865ad68c2295cf15782e:

  ARM: renesas: whitehawk: Drop extra leading space (2024-01-27 20:17:04 +0100)

----------------------------------------------------------------
Marek Vasut (4):
      clk: renesas: Drop include common.h
      pinctrl: renesas: Drop include common.h
      ARM: renesas: Drop include common.h
      ARM: renesas: whitehawk: Drop extra leading space

 board/renesas/alt/alt.c                 | 1 -
 board/renesas/alt/alt_spl.c             | 1 -
 board/renesas/alt/qos.c                 | 1 -
 board/renesas/blanche/blanche.c         | 1 -
 board/renesas/blanche/qos.c             | 1 -
 board/renesas/draak/draak.c             | 1 -
 board/renesas/falcon/falcon.c           | 2 +-
 board/renesas/gose/gose.c               | 1 -
 board/renesas/gose/gose_spl.c           | 1 -
 board/renesas/gose/qos.c                | 1 -
 board/renesas/grpeach/grpeach.c         | 3 ++-
 board/renesas/koelsch/koelsch.c         | 1 -
 board/renesas/koelsch/koelsch_spl.c     | 1 -
 board/renesas/koelsch/qos.c             | 1 -
 board/renesas/lager/lager.c             | 1 -
 board/renesas/lager/lager_spl.c         | 1 -
 board/renesas/lager/qos.c               | 1 -
 board/renesas/porter/porter.c           | 1 -
 board/renesas/porter/porter_spl.c       | 1 -
 board/renesas/porter/qos.c              | 1 -
 board/renesas/r2dplus/r2dplus.c         | 1 -
 board/renesas/rcar-common/common.c      | 1 -
 board/renesas/rcar-common/gen3-spl.c    | 1 -
 board/renesas/rcar-common/v3-common.c   | 2 +-
 board/renesas/salvator-x/salvator-x.c   | 1 -
 board/renesas/silk/qos.c                | 1 -
 board/renesas/silk/silk.c               | 1 -
 board/renesas/silk/silk_spl.c           | 1 -
 board/renesas/spider/spider.c           | 1 -
 board/renesas/stout/cpld.c              | 1 -
 board/renesas/stout/qos.c               | 1 -
 board/renesas/stout/stout.c             | 1 -
 board/renesas/stout/stout_spl.c         | 1 -
 board/renesas/ulcb/cpld.c               | 1 -
 board/renesas/ulcb/ulcb.c               | 1 -
 board/renesas/v3hsk/cpld.c              | 1 -
 board/renesas/v3msk/cpld.c              | 1 -
 board/renesas/whitehawk/whitehawk.c     | 3 +--
 drivers/clk/renesas/clk-rcar-gen2.c     | 1 -
 drivers/clk/renesas/clk-rcar-gen3.c     | 1 -
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774b1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a774e1-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a7790-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7791-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7792-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7794-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 1 -
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77970-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77980-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779a0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779f0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 1 -
 drivers/clk/renesas/r9a06g032-clocks.c  | 1 -
 drivers/clk/renesas/rcar-cpg-lib.c      | 1 -
 drivers/clk/renesas/renesas-cpg-mssr.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a7790.c   | 1 -
 drivers/pinctrl/renesas/pfc-r8a7791.c   | 1 -
 drivers/pinctrl/renesas/pfc-r8a7792.c   | 1 -
 drivers/pinctrl/renesas/pfc-r8a7794.c   | 1 -
 drivers/pinctrl/renesas/pfc-r8a77951.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a7796.c   | 1 -
 drivers/pinctrl/renesas/pfc-r8a77965.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77970.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77980.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77990.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a77995.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a779a0.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a779f0.c  | 1 -
 drivers/pinctrl/renesas/pfc-r8a779g0.c  | 1 -
 drivers/pinctrl/renesas/pfc.c           | 1 -
 drivers/pinctrl/renesas/pinctrl-rza1.c  | 1 -
 77 files changed, 5 insertions(+), 78 deletions(-)
