Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0DCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF55F84659;
	Wed, 27 May 2026 11:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="SK/7WAe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC4E0846B4; Wed, 27 May 2026 11:52:27 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80028056B
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=XmUJZdVtFYtlbx5UHtPLPOj159x6xFMjWU68TEUFl8Q=; b=SK/7WAe3s/8Eysf7teCdLyQae9
 H9MH3q4CgBIQ16Osf4WBQ5pU1yP4w0WJ1Nfu49IY2MB+Uq9I7U7VpSH1VECfGyL+FSVPTWbwbCjTy
 lXDZNDd/mg/1xjfHhY5fb2Kwiwc1bOeQ0nWcKFvubAgqsuHBMoTDJXs9b3D626v738XuftEN8SB0a
 wgaJYgiU2luDdVbfuubSDQKztYL7jI/NNzNCENnsrjivCZb63CVMDIBANZzEi2oR5BVV8IjHzvcUI
 O5xz4SjXA3bm1tN1l/9zawO+BxOslGu6qabaC5yOOZxnJj+GQKn5N3rFDC1dh/fgUL+J/xMIiYmgX
 3HjFfnGA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw4-0002RS-0c; Wed, 27 May 2026 11:52:24 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw3-000JXI-0u; Wed, 27 May 2026 11:52:23 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 0/7] TQMa7 eeprom sysinfo driver
Date: Wed, 27 May 2026 11:51:16 +0200
Message-Id: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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
 15 files changed, 376 insertions(+), 1 deletion(-)
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h
 create mode 100644 doc/device-tree-bindings/sysinfo/tq,eeprom-sysinfo.txt
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

-- 
2.34.1

