Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA23D1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C103F83E85;
	Tue,  2 Dec 2025 18:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="K6B0lHB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B8E83E9A; Tue,  2 Dec 2025 18:28:51 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E16E283E85
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id DEA96C16A21;
 Tue,  2 Dec 2025 17:28:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE700606D6;
 Tue,  2 Dec 2025 17:28:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 15F3C11918119; Tue,  2 Dec 2025 18:28:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764696524; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=D45Br6PnMVFJMX3W3Wi7C8nITHnF8B5UNw0+oIIx/XM=;
 b=K6B0lHB74ZVkBJ5DnHe4bfAPS1Qi4sL8+pNgVATxqEml8cIL4eeWqMeR5lNudzvAlEB/wP
 V1uUzlik3PcT9Bir3/XfVjRlp4qfTjLU10OQ/VrCGGt3bLLQPuiiczDG2E+w2A+su3nrrh
 ChgRULa9BP93IYbxDh/38RJLYO73mjgXJ23fZUFyKcbydvj7HKfmj2raHYQJkPYxvhdZ4k
 tKJm366AVkdGKomq29RBE18AIhpaTTpH5eARubKDmYK5X5+oGCuPvBQ/AdQrdKAJUYmdnR
 hErxWCYK5jHt+QXDEWAf8qUhVzZlG/IpvGI9TuP0b78FKTpmeCBl3u9F97jgaw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH 0/6] Add support for fwumdata
Date: Tue, 02 Dec 2025 18:28:25 +0100
Message-Id: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALohL2kC/x3MQQqAIBBA0avErBOcwpKuEhGSY80iC80KorsnL
 d/i/wciBaYIXfFAoJMjbz4DywKmxfiZBNtsqGSlEGUrHJkjBRrdlVZrDiOUVlLbBgltDTnbAzm
 +/2U/vO8HOjMg2mIAAAA=
X-Change-ID: 20251107-feature_fwumdata-58508d61e1d3
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
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
 tools/{ => fwumdata_src}/mkfwumdata.c | 105 +----
 12 files changed, 1314 insertions(+), 93 deletions(-)
---
base-commit: 31bf4a1c308773895a8e7ea047b3cea037e4c922
change-id: 20251107-feature_fwumdata-58508d61e1d3

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

