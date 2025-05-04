Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4872C369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 19:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCBDC80F03;
	Sun,  4 May 2025 21:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sNQ1C1aA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="guLgMdrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703A9812BC; Sun,  4 May 2025 21:43:16 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E5B80EE5
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 21:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZrFSc5NsHz9tMd;
 Sun,  4 May 2025 21:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1746387792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=haTPn1yXh+68MmhRDnv648gPALoNNUa/5MYw4YKiXXw=;
 b=sNQ1C1aAOYLw8/2nlaVvjpbl2kRceuq2oFAge6KxwBRLIdMwC7+ySIhWIAPgRBKS8m1mDD
 aErJmHU+12i76lihciBEf1DONqHj22Ga+/ZZ/x668D6fScRWQZ1HdRavhavGEDpCmo5md9
 D6lqSwpx060BUOW6NBOLK26n3Ie9RE3h//P+38QOmUey2uOis09CyFkpjtD3e5PjYs3KT1
 yfZ7DGJJW2rtzDPpuhY94VGMJpXswWbG92CeW+DejFn2Gi/Vumg0uGCsqu2+0L+v4d/qZY
 0iZ1DG8r+1pn/875oXzJSydPyNiuCrias+dqobQ8CrAWQ2gGhzTNHX5R4wAYcg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1746387790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=haTPn1yXh+68MmhRDnv648gPALoNNUa/5MYw4YKiXXw=;
 b=guLgMdrEMPbfnmWWYMasZ+Zfz08bVpC9XfXLDWS1xWBVEp5LAWzkF+iYXpmT4FEBRIDhJC
 JsEWMvrpTPJtelEI33a7AMmFWO9nIgDHwwBupX9TFtSR14wHh9sBNmU+3fCek+Ax45eRFA
 R6eHVFi9Xkuza71CSIpjoU2BCT9VGZLy7Zi9SoPUdGLr9Rs0Zdm23NQ4q5WzS9aH2fLNBK
 qfvfHbi8lfnmX3931/GUSY9W0Xu1rwEB20ivsea1A/erv0GlKheoGTuPb2RhCsjXkMeWx5
 +6HgNAwkjq35mxo+RIIvfrp8CbNFb0Xy5O2HVxdZer8hXV/gOuVDRWIjdQOd0A==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PULL] u-boot-sh/master
Date: Sun,  4 May 2025 21:42:38 +0200
Message-ID: <20250504194255.167587-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: digjpkx3qbxkr1ypn5ztc5tmfzmczi7f
X-MBO-RS-ID: afca3842a7bce70b041
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

The following changes since commit dcea465e5e299903b889f5f426eac6d6523cbf84:

  Merge tag 'u-boot-imx-master-20250503' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2025-05-04 08:51:43 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to ee58ed41e6e564a70cd25fce5eb7838a3842279c:

  renesas_rzg2l_smarc_defconfig: Enable networking support (2025-05-04 20:25:03 +0200)

----------------------------------------------------------------
Marek Vasut (1):
      net: ravb: Fix RX error handling

Paul Barker (4):
      net: ravb: Refactor out R-Car specific code
      net: ravb: Add optional reset deassertion
      net: ravb: Add RZ/G2L Support
      renesas_rzg2l_smarc_defconfig: Enable networking support

 arch/arm/mach-renesas/Kconfig         |   1 +
 configs/renesas_rzg2l_smarc_defconfig |   6 ++
 drivers/net/Kconfig                   |   2 +-
 drivers/net/ravb.c                    | 173 +++++++++++++++++++++++++++++-----
 4 files changed, 158 insertions(+), 24 deletions(-)
