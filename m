Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605CEE92FDD
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 20:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4D883EF5;
	Mon, 29 Dec 2025 21:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="IZxV4zOb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j7mOQTFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C18083EF9; Mon, 29 Dec 2025 21:55:02 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92CCA83E21
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 21:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dg7l72R82z9tDR;
 Mon, 29 Dec 2025 21:54:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767041699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9tIWdl3z4VbPK3xT5m0tZg2D1WHiNuGcifjV6vazGoM=;
 b=IZxV4zObzCeSDb/gvOpdLhf7GKDtvZ6Z2x/ib4C7X7QMLD3kStMH8vryQsryc2Or8WRkD+
 4bbHdh33JF7CLMMsMWfY/VintHVP7RUYLiBQv9bjex1noSFrKoj2BQ8vSt+diOIulYJ4AC
 6aASeAMdkA8ASJTBGRWSWkwHfizS2eReGtDnI1YhaCPWJKjPyT/kP4c5FbL6tSPd1NvN2n
 r8hHoze0UBrF3dUb3cdwGGci/M7McuU12Ubhlv0iJtEvnUFG3ppfFB2fgG7j3RvQ8zeusX
 d4bolvYp8QlFUwhvhsQPTX0m3PYjASzdwxUwuzl0/wENaOo4wgQRCPGnfR9N0Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=j7mOQTFw;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767041697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9tIWdl3z4VbPK3xT5m0tZg2D1WHiNuGcifjV6vazGoM=;
 b=j7mOQTFw/3mFEnudpLYg3JqRKXSr5qRs36mozK967IZKz8zTQ+PTzhcDDsUoTYAtbRYlOa
 qMmueup+70abwZoDV4pW7vKRVO4L6j+ENwjXVrRG80DTemv9lK1tyy1bwdAhwR21Jn4lbN
 3XCriNdW/zynYLEG4/Oi4a754pXCTbEQxKIqnSJwFG/qtwC45CMzJ/wExd9rZhYN8wMMkd
 SMXyGhPfw4dnEUStPTB7fT3iye1Sr7f+kXMdBnzgzFVkreocLtw63Y3DY9zAvP0EZtLeic
 AMRyiFRJbUPtIobAYFSJ4vwmzbN716UE5K7wG0FFRVHSJct3e8voBeiPtupujw==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PULL] u-boot-sh/master
Date: Mon, 29 Dec 2025 21:53:59 +0100
Message-ID: <20251229205431.89734-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 34wydtxx4sdkr3kbp5mt67pkdbq3unqj
X-MBO-RS-ID: 6b9cf343ce0ec59b890
X-Rspamd-Queue-Id: 4dg7l72R82z9tDR
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

Fix R-Car D3 ability to boot Linux kernel. This is for 2026.01 .

The following changes since commit 56cac250b0839ddbad1311d3ca4231f532b5aadf:

  Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-12-23 11:17:37 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to 06df1a5072af74039732dee631c810dd8cd3471c:

  clk: renesas: Do not disable realtime modules on R8A77995 D3 (2025-12-29 20:47:53 +0100)

----------------------------------------------------------------
Niklas Söderlund (2):
      clk: renesas: Do not enable MSTP4 extra modules on R8A77995 D3
      clk: renesas: Do not disable realtime modules on R8A77995 D3

 drivers/clk/renesas/r8a77995-cpg-mssr.c | 24 ++++++++++++------------
 drivers/clk/renesas/renesas-cpg-mssr.c  |  3 ++-
 2 files changed, 14 insertions(+), 13 deletions(-)
