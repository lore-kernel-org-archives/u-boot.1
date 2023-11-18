Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4906C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 18:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A0886BFA;
	Sat, 18 Nov 2023 19:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=fastmail.com header.i=@fastmail.com header.b="bhuAqGHm";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="BIcxBEVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C92870E3; Sat, 18 Nov 2023 19:44:38 +0100 (CET)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DC087006
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 19:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaredbaur@fastmail.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 192A05C01AF;
 Sat, 18 Nov 2023 13:44:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sat, 18 Nov 2023 13:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1700333069; x=1700419469; bh=73Tpal9j78
 DAXeeZ2CTwURv2kc46vElElnVKOIqVXXE=; b=bhuAqGHmq7oicuXrP1QSX3jhLF
 +YhpZwyW4XKNSuK/b3QGsUNbEAOJ0LkmCy9ti6RGk2uxakwK4+V7qFVzR0bKBQBY
 eIg/gv5J6U7ae/KePjtaMi+NFVynut4b1WlaQJpdYacU4Zgsla5DrF8cI1rkHggv
 LnArqNic6Be2AcgyGzaTnmRpslmlsTt05IXh0J35djKmeq6HBECTbMAguvNo3dNF
 Wu+0i4cPCwiasyvluDqpB9+RXaevzKTNIcdpIwpYFz6yKvbG1sUpTheSQurO8lJ5
 0aWAlhyWU4RYx5ZyDS9V6T64m1S4nzCbB2lDkosyGqe7G9Y04uOgWJLa2VIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1700333069; x=1700419469; bh=73Tpal9j78DAX
 eeZ2CTwURv2kc46vElElnVKOIqVXXE=; b=BIcxBEVjxaNCVqAxsxAmpZsnmyyNJ
 clEKNw9pzfPYqr1rcBsMFq2Rebwgu5QgYXyDdcAIMxzP154iQ3SH7pYrjMAh2Fxh
 4HwsPBeOWe708QX2PRyw55YZayxWKzAfAE+lPupQtsW/Aerjov0CPyY8yooHMX7C
 3mxyDHIqZAyrxgoM+Osv+zk8l4BmIKjFjvGyx6aky7q0P1mm4vbb1A4ZlRdU5tW6
 gcn7vETrpZDK+3ywyxtToZaXFWnprYVEo1QJyyo/LnMOMY6xviX7MbhTQxAflZQU
 fyeXf+vFpI+rMFxlnVVg0ErIdHb6DbfAGi/Ga4ZURdWsZJ6OqmdUks4Lw==
X-ME-Sender: <xms:DAZZZcDm0mczUgnIVeC59BvF5letpVmTIluNknUUEnBaJWKw-12h6A>
 <xme:DAZZZejbEjF-rUdE7qmHt3HtVxKpljTiOE4tOHi-hi_jeCNvKChgjNZbuUP6NqNN6
 YnnJ5nq572LUqqpd00>
X-ME-Received: <xmr:DAZZZflp2rcWfk4XVPCJPHlavw9A3uyVc81Tf8EwSRH7LUweQNGDbNJ8IcWe645eiCdrA83T_SKeYnZZHXjPeDho6e9UoLoqfKOX8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegvddgudduhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
 dtredttdenucfhrhhomheplfgrrhgvugcuuegruhhruceojhgrrhgvuggsrghurhesfhgr
 shhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtjedvieegjefhteetffevge
 fhhfdugfeugeelfeetheetvdefheejvefgudeiueenucevlhhushhtvghrufhiiigvpedt
 necurfgrrhgrmhepmhgrihhlfhhrohhmpehjrghrvggusggruhhrsehfrghsthhmrghilh
 drtghomh
X-ME-Proxy: <xmx:DAZZZSxBpGdMGjgE8dbEqAYmplOeiiG1XDCOSVUI8UnXVYnW8ufecQ>
 <xmx:DAZZZRQMUSyrI4V1XPaZlqphcQ9b35B9IRJHlL2T4s388p0UiIESMw>
 <xmx:DAZZZda4sqrakOnfkFIBn5PQ4Xcysj2ml5o_wOn93cLoRcavGzAp0g>
 <xmx:DQZZZS5tQ3sPj4J0h5E1vbhNB9mWUP5AonkJXltiEbE2xC8EpfceEg>
Feedback-ID: i1961441c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Nov 2023 13:44:28 -0500 (EST)
From: Jared Baur <jaredbaur@fastmail.com>
To: u-boot@lists.denx.de
Cc: Jared Baur <jaredbaur@fastmail.com>
Subject: [PATCH 0/1] Fix DFU updates on the zynqmp platform
Date: Sat, 18 Nov 2023 18:44:19 +0000
Message-ID: <20231118184426.2808502-1-jaredbaur@fastmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Nov 2023 19:47:00 +0100
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

When using DFU alt info via EFI capsule updates on an Ultra96 V2 board,
`dfu_alt_info` is automatically set to write a `boot.bin` file to the SD
card when in SD boot mode and not using multiboot. After the update is
applied, the board reboots and does not come back up. When writing an
upper-case `BOOT.BIN` file to the SD card instead, the board updates and
comes back up successfully.

Jared Baur (1):
  Write upper-case BOOT.BIN to zynqmp MMC

 board/xilinx/zynqmp/zynqmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.42.0

