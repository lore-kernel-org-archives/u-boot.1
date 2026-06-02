Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB385CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F280984867;
	Tue,  2 Jun 2026 13:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iycf87Ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4923784855; Tue,  2 Jun 2026 13:58:15 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F274D84855
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:58:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=a4+TIRjfz6gY1OiksnGIQurPfJiFnLDEEljF3b5sgjg=; b=iycf87Ue2xcsHn/c7b0JxTdhm7
 uWSQLpQewBdhR3PbVRKFRD65H2LkOpoWk65SSfvXd5X15Yi3tO20aa4WbnQJH9lYHtIPusk9NaOBG
 hscUf4L1l7+h/N3ROwB68uqIeMUQj4N+5UOdaTTmOddzS8JDVwYyF5h/9ldQy0igwwRcw5ebDKiuP
 VNIhrnZZAwITwj4YeFrLp4+ajn3te8ZtK08iMKAeid7wycOCpD3k291yyyp2dYwnV4mFTIZ0Tqjbr
 FGsGQHaPwHUREM82cofSPu7kA7pVTB/AoQoxfldUxypMhwoN6yskjpixXHNhnRRIqPzyEaPHbvua4
 zQf2uDXw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl5-000Lhp-0c; Tue, 02 Jun 2026 13:58:11 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl4-000J89-0J; Tue, 02 Jun 2026 13:58:10 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 0/7] TQMa7 eeprom sysinfo driver
Date: Tue,  2 Jun 2026 13:57:48 +0200
Message-Id: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Integrates a new tq_eeprom sysinfo driver that reads & prints board
information during boot.

This is the basis for additional patches that will be sent along with
updates of the TQMa6 in the near future, including support for multiple
indexed sysinfo devices and VARD (variant detection) data for newer TQ SOM's.

changes in v2:
- add documentation for tq,eeprom-sysinfo dt-bindings
- use nvmem-cells instead of hardcoded offsets
- unified `tq_eeprom_serial_len` for old and new format
- replace XPL guards with $(PHASE_) in Makefile
- remove (yet) unused sysinfo IDs SYSID_RAM_SIZE and SYSID_RAM_VARIANT
- remove (yet) unused Kconfigs

changes in v3:
- fix fixed-layout compatible in dts
- use return value ret in sysinfo_tq_eeprom_detect
- remove unneeeded depends on !SPL_BUILD from Kconfig
- separate nvmem-layout commit to be dropped once upstream patch is accepted and
  synced. Msg-ID of V1: 20260527093719.160777-1-Alexander.Feilke@ew.tq-group.com
- commit message improvements
- docstring improvements

changes in v4:
- add return code to tq_common_sysinfo_setup
- add missing headers
- sysinfo_get_and_detect
  - de-inlined function into sysinfo-uclass.c
  - shorten description slightly
  - add test case to test/dm/sysinfo.c [1]

[1] https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13250&view=ms.vss-test-web.build-test-results-tab&runId=365307&resultId=101177

Alexander Feilke (3):
  arm: dts: tqma7: add eeprom nvmem-layout
  arm: dts: tqma7: integrate tq,eeprom sysinfo driver
  boards: tqma7: call tq-sysinfo setup

Nora Schiffer (4):
  sysinfo: uclass: use sysinfo_priv size for per_device_auto
  sysinfo: add sysinfo_get_and_detect() helper
  sysinfo: tq_eeprom: new driver
  board: tq: common: add sysinfo setup helper

 MAINTAINERS                                   |   1 +
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi          |  20 ++
 board/tq/common/Kconfig                       |   5 +
 board/tq/common/Makefile                      |   1 +
 board/tq/common/tq_sysinfo.c                  |  37 ++++
 board/tq/common/tq_sysinfo.h                  |  15 ++
 board/tq/tqma7/tqma7.c                        |   6 +
 configs/tqma7_common.config                   |   1 +
 .../sysinfo/tq,eeprom-sysinfo.txt             |  36 ++++
 drivers/sysinfo/Kconfig                       |   8 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/sysinfo-uclass.c              |  12 +-
 drivers/sysinfo/tq_eeprom.c                   | 203 ++++++++++++++++++
 include/sysinfo.h                             |  17 ++
 include/sysinfo/tq_eeprom.h                   |  24 +++
 test/dm/sysinfo.c                             |  16 ++
 16 files changed, 402 insertions(+), 1 deletion(-)
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h
 create mode 100644 doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

-- 
2.34.1

