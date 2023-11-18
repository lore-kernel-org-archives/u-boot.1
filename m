Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00645C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617F88708B;
	Sat, 18 Nov 2023 22:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RGtpMbso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8D787134; Sat, 18 Nov 2023 22:57:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7620386FE4
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9CB2C3F278; 
 Sat, 18 Nov 2023 21:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700344652;
 bh=0UJQJrcF5bmyeAkE4OnuQuonvmVvakOeugY2XPHrsI0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=RGtpMbso8M7yw6Lp35febk9zP5HcPQibQy/77A7ZCE44WxiGbja2B9f6YeOkiV12m
 1WL8wayRcwjHat1v632NkoM6mp8jj4XBhpQqPy79pxo4Serh6TjQvbXTC4gb5VFkTF
 cdCc9m/JbONnDT4Q66xlf3HtvuLD4mwaDboHyHiCZ8zc+RoRsjmuLNesj1HdJXg4HJ
 kkWmtz5Wk8wDsm360LQSu2+lRJpTBMNBA5tdpGFSou3nD8lfHjXppK3TR1y0f+Ehc6
 OYyx7+EUgYWwbhhm3tTH2aB0nPTpMefcZkLDxNYwY23L4dpgqc4L0Xs9Zf/Y8u2DYB
 Ecp2GRuhOVi4Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] acpi: consider XSDT in acpi_find_table()
Date: Sat, 18 Nov 2023 22:57:25 +0100
Message-Id: <20231118215727.95086-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The RSDT table is deprecated and does not exist on all systems.

By preference scan XSDT for the table to find. If no XSDT table exists, try
to use the RSDT table.

Provide a unit test for acpi_find_table().

v2:
	Consider that map_sysmem(0, 0) != NULL.
	Add unit test.

*** BLURB HERE ***

Heinrich Schuchardt (2):
  acpi: consider XSDT in acpi_find_table()
  test: unit test for acpi_find_table()

 lib/acpi/acpi.c | 20 ++++++++---
 test/dm/acpi.c  | 96 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 4 deletions(-)

-- 
2.40.1

