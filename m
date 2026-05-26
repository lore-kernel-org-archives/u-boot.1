Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1C3CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4292784875;
	Tue, 26 May 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="YfuH+ul3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8634D84881; Tue, 26 May 2026 14:40:55 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DD7284839
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:40:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=4faZL93gGPdz21v8uRY/fWufxtZK0C0G1LFqstbvo1c=; b=YfuH+ul3lmFGiBPWF9uo3Lsssz
 EEAfy3RdqWXchq8PKcaOLu8XheIALB63EFTD2QutzQFbEEW0Osrk2PbsZEcqb0Vd97kZNXTUfCZNA
 C925qxhnNMHrwskBB7Jm3elAuDu3ruZTH9g4H8FbaNIr4uF/H8cf57sKxCtpGCjEi/E4A0Kl30qFz
 Gp6Qbfnch+ZjwYwKQ58PY+xAmtFSKD0Uh1Fs/5ql7YDfFl01j1Co9L1LZ2VgLJslQ5lC80JHacLPt
 oKkGAZOrTTU5g3gOQbzA9Du/En1pYOkZjK2U/R1YAG4PRBtAF5lxNenawZ5bBnxeldV24UXBjmxpt
 w3GpBrlA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5X-000PIt-2L; Tue, 26 May 2026 14:40:51 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wRr5W-000B1h-2Y; Tue, 26 May 2026 14:40:51 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Subject: [PATCH v2 0/6] TQMa7 eeprom sysinfo driver
Date: Tue, 26 May 2026 14:40:38 +0200
Message-Id: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
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

CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13229

Note: I got a strange unrelated error in test_ut in a previous CI run, where
dm_test_rtc_dual() returned -EINVAL, causing the test to fail. It passed in the
next run so I suppose its a race condition, but I didn't look further into it.
Link: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13228&view=logs&j=db15d90c-51e5-5ca3-902e-4c5d558bba82&t=64917d2e-7acb-5ec4-6136-40fc146da71a

Alexander Feilke (2):
  arm: dts: tqma7: integrate tq,eeprom sysinfo driver
  boards: tqma7: call tq-sysinfo setup

Nora Schiffer (4):
  sysinfo: uclass: use sysinfo_priv size for per_device_auto
  sysinfo: add sysinfo_get_and_detect() helper
  sysinfo: tq_eeprom: new driver
  board: tq: common: add sysinfo helpers

 MAINTAINERS                                   |   1 +
 arch/arm/dts/imx7s-tqma7-u-boot.dtsi          |  20 ++
 board/tq/common/Kconfig                       |   6 +
 board/tq/common/Makefile                      |   1 +
 board/tq/common/tq_sysinfo.c                  |  32 +++
 board/tq/common/tq_sysinfo.h                  |  15 ++
 board/tq/tqma7/tqma7.c                        |   3 +
 configs/tqma7_common.config                   |   1 +
 .../sysinfo/tq,eeprom-sysinfo.txt             |  36 ++++
 drivers/sysinfo/Kconfig                       |   8 +
 drivers/sysinfo/Makefile                      |   1 +
 drivers/sysinfo/sysinfo-uclass.c              |   2 +-
 drivers/sysinfo/tq_eeprom.c                   | 203 ++++++++++++++++++
 include/sysinfo.h                             |  25 +++
 include/sysinfo/tq_eeprom.h                   |  24 +++
 15 files changed, 377 insertions(+), 1 deletion(-)
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h
 create mode 100644 doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

-- 
2.34.1

