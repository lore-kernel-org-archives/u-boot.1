Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96833CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 08:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF1084C19;
	Fri,  8 May 2026 10:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lbrqPHqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A185D84BD1; Fri,  8 May 2026 10:48:53 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4FF84BD1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 10:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=nRk4cVd3UquyUfZg8hTFZqJrVOIh7IXqX9P6EH2tehI=; b=lbrqPHqv0hvVqJnM/9i52/6hJc
 wZFVMo4i7+zsHVTmjmxI5hTFtcxrcbdwWUJON0fOKV1+7eEMJj11rpmNencZ6zU/Fzvq2ZUnpytOW
 MDzfqlPBOUDNvwV3Mw+eiLvYq+/vZguniOBPRNh2FFY9H7JVgUSm0kNOPnspbGt+ZKCURiKS0LZMG
 ZiENPPB5t4+XEfutCmfw8eAM/C2CI4I5e+pNlqfnMYf51uPY/89jYBPkeaD3CmQZ3EhI0cENQL7Dm
 8KJ7bjhGaUxxkVylpAF88A7+1EYZO0B2lDXh55p7KNycesdDP7ckBQQ7nGJZzHAu+xanN8Jp6zxJU
 NPuDglrA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt8-0009ZR-1N; Fri, 08 May 2026 10:48:50 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wLGt7-000KsG-1i; Fri, 08 May 2026 10:48:50 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/6] TQMa7 eeprom sysinfo driver
Date: Fri,  8 May 2026 10:48:28 +0200
Message-Id: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
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

Alexander Feilke (1):
  boards: tqma7: integrate sysinfo_tq_eeprom driver

Nora Schiffer (5):
  sysinfo: uclass: use sysinfo_priv size for per_device_auto
  sysinfo: add sysinfo_get_and_detect() helper
  sysinfo: tq_eeprom: new driver
  sysinfo: add IDs for RAM size and variant
  board: tq: common: add sysinfo helpers

 arch/arm/dts/imx7s-tqma7-u-boot.dtsi |   7 +
 board/tq/common/Kconfig              |  27 ++++
 board/tq/common/Makefile             |   4 +
 board/tq/common/tq_sysinfo.c         |  32 ++++
 board/tq/common/tq_sysinfo.h         |  18 +++
 board/tq/tqma7/tqma7.c               |   4 +
 drivers/sysinfo/Kconfig              |   8 +
 drivers/sysinfo/Makefile             |   1 +
 drivers/sysinfo/sysinfo-uclass.c     |   2 +-
 drivers/sysinfo/tq_eeprom.c          | 223 +++++++++++++++++++++++++++
 include/sysinfo.h                    |  24 +++
 include/sysinfo/tq_eeprom.h          |  24 +++
 12 files changed, 373 insertions(+), 1 deletion(-)
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h
 create mode 100644 drivers/sysinfo/tq_eeprom.c
 create mode 100644 include/sysinfo/tq_eeprom.h

-- 
2.34.1

