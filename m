Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD6AF417F3
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 15:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6BD183F59;
	Mon,  9 Mar 2026 16:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PfCyxEVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A6C83F20; Mon,  9 Mar 2026 16:22:59 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FB183BC8
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 16:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 765FC4E425DE;
 Mon,  9 Mar 2026 15:22:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 400765FFB8;
 Mon,  9 Mar 2026 15:22:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CE98C10369BC4; Mon,  9 Mar 2026 16:22:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773069775; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=rlP77A2aLlQ9WvS++weySN96+CaRbnWCcYxrRBkBxdY=;
 b=PfCyxEVGJXE3VPtOuBh3YecFdMfq7YVg4/Oxr8UHyDbPNCkud/+SnduaKhsEqH5js/OvXK
 OoAzOOGmwt2xYqGxQe7Iv/5KEcCv7uJLvg9Aa39Y3bMyQCdj5KSk5MTFxnaxMKJqzY0gqR
 0zF4J0ACLgCiFvjSdjQb9FsDwa+3kAei/MeMalY9lohX1d3WmS4kXOpjm49Lfmvr3ZFs/v
 R9MQ4NzKQ9FIiHxVCLXis1EyKqnaBz2O+TCU5SKDX7/Cqa8nl3hQxg6eooV9ZxLBt0kDt+
 MejSBPaj45B2RMvNTTpNmSiCH+b0BmCLMqxiQR3j/UXeEkiELV+BLOIr8j0m4Q==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 0/4] mtd: rawnand: sunxi: Fixes user data length for H6
Date: Mon,  9 Mar 2026 16:22:47 +0100
Message-ID: <20260309152251.70837-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series introduces the correct usage of user data length for
H6/H616.
If the older SoCs must use a fixed value of 4 user data bytes for each
ECC step, the H6 can have a different value for each step.

In the first round, the behavior was kept as the one used by A10 when in
fact the images in the wild with the vendor kernel are using a different
layout.

The 3rd patch enables using variable user data length for H6/H616.
All other patches are fixes/code cleaning

A similar series is under review for Linux:
https://lore.kernel.org/lkml/20260305100137.2558423-1-richard.genoud@bootlin.com/

Richard Genoud (4):
  mtd: rawnand: sunxi: Replace hard coded value by a define
  mtd: rawnand: sunxi: make the code mode self-explanatory
  mtd: rawnand: sunxi: introduce variable user data length
  mtd: nand: raw: sunxi_spl: remove user data length reset

 drivers/mtd/nand/raw/sunxi_nand.c     | 157 +++++++++++++++++++-------
 drivers/mtd/nand/raw/sunxi_nand.h     |  34 ++++++
 drivers/mtd/nand/raw/sunxi_nand_spl.c |  47 ++++----
 3 files changed, 171 insertions(+), 67 deletions(-)


base-commit: 4f70106beafe30df8b0528a3d8b2543cd48fe241
