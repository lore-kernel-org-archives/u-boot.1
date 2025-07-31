Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C06BC87FD2
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 21:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 412EA839B7;
	Thu, 31 Jul 2025 23:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=agorria.com header.i=@agorria.com header.b="jfYfILRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7336C8393E; Thu, 31 Jul 2025 21:47:43 +0200 (CEST)
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org
 [IPv6:2001:67c:2050:103:465::209])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B6B8380F
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 21:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=agorria.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ion@agorria.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4btKP70nd8zB0Fv;
 Thu, 31 Jul 2025 21:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agorria.com; s=MBO0001;
 t=1753991259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3pPG8CCYKPnat7H8VbwNXPYdwGY5oA07pJtB1ue+ACk=;
 b=jfYfILRFToehM0MCm81Y7qIHkvvsqU1z/dQlLuvD5B0IUHGkUZLreI5EJ9AIqa5ll4YHPC
 VWixl0XWV71poaPWEkQwmM5XGeBemOb7I2twQ2DsZP7jj/99jRacITW4G7hSi1Uk1NSZtm
 QcYbyMbGwf2rYNDBb/CFfHyNz87APYHTUGo6CFttC46eCg4WrdvH4NUtaLcLhCsY6I4MYG
 uxmWsLJ6o4q4l7cLf9HltO1BH5ii+npkeThjjussaqwMRYvMF7MjbCfPYL7bjALTkPNsvk
 j6pzcSvXgAmlrPF+l8zMIc3YHHNb7PLGDbf13Zl3TAULk/KzH1lH//2b/K6CTw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ion@agorria.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ion@agorria.com
From: Ion Agorria <ion@agorria.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] Tegra20: add Samsung GT-I9103 and SGH-i927 support
Date: Thu, 31 Jul 2025 21:47:30 +0200
Message-ID: <20250731194731.287715-1-ion@agorria.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4btKP70nd8zB0Fv
X-Mailman-Approved-At: Thu, 31 Jul 2025 23:50:52 +0200
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

This commit adds support for Samsung Galaxy R (GT-I9103) and
Captivate Glide (SGH-i927) Tegra 2 powered phones.

Ion Agorria (1):
  board: samsung: add Samsung Galaxy R (GT-I9103) and Captivate Glide
    (SGH-i927) support

 arch/arm/dts/Makefile                       |   2 +
 arch/arm/dts/tegra20-samsung-bose.dts       | 119 ++++++
 arch/arm/dts/tegra20-samsung-n1-common.dtsi | 428 ++++++++++++++++++++
 arch/arm/dts/tegra20-samsung-n1.dts         | 184 +++++++++
 arch/arm/mach-tegra/tegra20/Kconfig         |   5 +
 board/samsung/n1/Kconfig                    |  13 +
 board/samsung/n1/MAINTAINERS                |   9 +
 board/samsung/n1/bose.config                |   6 +
 board/samsung/n1/n1.env                     |  16 +
 configs/n1_defconfig                        |  92 +++++
 doc/board/samsung/index.rst                 |   1 +
 doc/board/samsung/n1.rst                    |  51 +++
 12 files changed, 926 insertions(+)
 create mode 100644 arch/arm/dts/tegra20-samsung-bose.dts
 create mode 100644 arch/arm/dts/tegra20-samsung-n1-common.dtsi
 create mode 100644 arch/arm/dts/tegra20-samsung-n1.dts
 create mode 100644 board/samsung/n1/Kconfig
 create mode 100644 board/samsung/n1/MAINTAINERS
 create mode 100644 board/samsung/n1/bose.config
 create mode 100644 board/samsung/n1/n1.env
 create mode 100644 configs/n1_defconfig
 create mode 100644 doc/board/samsung/n1.rst

-- 
2.50.0

