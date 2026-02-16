Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CD3E7BDBC
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 13:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B19283AAB;
	Mon, 16 Feb 2026 14:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gLdihYWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B72383C6C; Mon, 16 Feb 2026 14:35:56 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F32B80FA1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 14:35:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 0F36CC17858;
 Mon, 16 Feb 2026 13:36:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DE410606CF;
 Mon, 16 Feb 2026 13:35:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 14E2410369131; Mon, 16 Feb 2026 14:35:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771248951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=etat9lP7rW9Gl7Jn6TftKzj7b2B8HYIRUdk/vU1Y9jE=;
 b=gLdihYWuq1j4bfwBsagMQzI4YE3FEO16OuqD8TZftEoYXidf1ngCG8muaJF8rEy/5K3jYP
 agaZB9tIjUNV9DCCMqqy/O4NYSIlG9j+53Iaxp6EavYX/6PsChbzIBZhTffqpeY8KCtRlR
 L73hz49OaukFZUEgkgWk29Tccs3Qhjs7XD6OuHcnxQQSwmHcOPCMBn4u63GKl1Pb4nm08M
 Mr4lhsSz2kd2fy245r9uTcBqCBx4jTZZInc6pX6uPUcHPA0mn94nue+pHCFichB9TGgZts
 /jHHA08EDtb+rD6Aj7xawEaCtJU/iLlS5s2SZ1dVzfHkzb1IdHpGV7DxiOnwHA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v3 0/6] Add support for fwumdata
Date: Mon, 16 Feb 2026 14:35:30 +0100
Message-Id: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACIdk2kC/23NwQ6CMAyA4VchOzuzDibIyfcwxgzWyRJhZhtTQ
 3h3B140emnyN+nXiXh0Bj2ps4k4jMYbO6TINxlpOzlckBqVmnDGBQArqUYZRodnfR97JYOkohK
 sUjtAUDlJZzeH2jxW8nhK3RkfrHuuHyIs2zeWxi8WgTKqhABRKCyA5YfG2nA1w7a1PVm4yD8I+
 EfwREiViJLrBsv9NzHP8wvfp6U99QAAAA==
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3
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

Add a new fwumdata tool to allows users to read, display, and modify FWU
(Firmware Update) metadata from Linux userspace. It provides functionality
similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
metadata, change active/previous bank indices, modify bank states, and set
image acceptance flags. Configuration is done via fwumdata.config file.

Made a few change to mkfwumdata tool along the way.

Here is an output example

$ ./fwumdata -l
FWU Metadata:
	Version:            2
	Active Index:       0
	Previous Index:     1
	CRC32:              0x1f21ff7b
	Metadata Size:      120 bytes
	Descriptor Offset:  32
	Bank States:
		Bank 0: accepted (0xfc)
		Bank 1: accepted (0xfc)

	Firmware Store Descriptor:
		Number of Banks:       2
		Number of Images:      1
		Image Entry Size:      80
		Bank Info Entry Size:  24

	Images:
		Image 0:
			Image Type GUID:  65ae85ad-1fb3-0b46-8c5d-285543aa6eab
			Location GUID:    51513491-da07-2a4f-9bea-375ea53b1b5c
			Banks:
				Bank 0:
					Image GUID:  cb2df442-f929-6a44-a374-672d92eb2aa7
					Accepted:    yes (1)
				Bank 1:
					Image GUID:  a839a18f-395c-484f-83b8-0354077c8f9f
					Accepted:    yes (1)
Changes in v3:
- Rebase on master.
- Link to v2: https://lore.kernel.org/r/20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com

Changes in v2:
- Fix a small offset mistake in last patch

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (6):
      tools: gitignore: Add mkfwumdata to the git ignore file
      tools: Reorganize mkfwumdata tool into fwumdata_src directory
      tools: mkfwumdata: Improve error message specificity
      tools: mkfwumdata: Add bank count validation for FWU metadata v2
      tools: Add support for fwumdata tool
      tools: mkfwumdata: Remove dependency on fwu_mdata.h header

 MAINTAINERS                           |   7 +-
 doc/develop/uefi/fwu_updates.rst      |   4 +-
 doc/fwumdata.1                        | 222 +++++++++
 tools/.gitignore                      |   2 +
 tools/Kconfig                         |   9 +-
 tools/Makefile                        |   4 +-
 tools/fwumdata_src/Kconfig            |  19 +
 tools/fwumdata_src/fwumdata.c         | 854 ++++++++++++++++++++++++++++++++++
 tools/fwumdata_src/fwumdata.config    |  33 ++
 tools/fwumdata_src/fwumdata.h         | 138 ++++++
 tools/fwumdata_src/fwumdata.mk        |  10 +
 tools/{ => fwumdata_src}/mkfwumdata.c | 106 ++---
 12 files changed, 1315 insertions(+), 93 deletions(-)
---
base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
change-id: 20251107-feature_fwumdata-58508d61e1d3

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

