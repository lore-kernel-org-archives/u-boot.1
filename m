Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ED8CF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 22:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179E488FDE;
	Mon, 14 Oct 2024 00:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wsfX4FKU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VgVYfvqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BF089069; Mon, 14 Oct 2024 00:51:41 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0638288EAE
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XRbFk52vLz9sX2;
 Mon, 14 Oct 2024 00:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728859898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4M5dSdyuqDPn6p4vD9RGjrfSjTS24PYxder4u7WCOpE=;
 b=wsfX4FKUxuWxNMNtppfGvEF/dZHfn+fAthwS0AnQLsJIkHor5RvqfyfgdksJzIADdAXyq1
 p07ikx9FaMFk1VknOHAkJiBsRpMrrYYc6w2gGX0tKfcfpeTyUWWDENCPY4+/CWYcKOu4U9
 aQTk36F3FZfMXNNYyF7/bei/Hg1+RzrgD4MS9Iuns7wiskgqYQ0mxjZMax9k3/Y7j9VKlN
 VI2l+K4dFzxjvq4APV9nY9Ps3KHz+IOfxwourJTKBhQ3jsXH0ek2pjnIux9iiGibFW8nDL
 0o9NP+NhvTOB2j9WPfU15MIRfYoji2p/szN9AaKVpqDTjr4VX3Sc8ByAl91GDQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1728859896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4M5dSdyuqDPn6p4vD9RGjrfSjTS24PYxder4u7WCOpE=;
 b=VgVYfvqE8LQHO5KKDQueHX9CvWLyqufU4CW3kmOO9LuXktYN+JS+FvSZ9YMd4AR4cddo4G
 5F9kSX+q6ZxnBPCsoTPRrZ6fO+gJDUew2gW1KHjLPRwok+PGTbvx5Ph2rnNWvyt0mTIN89
 uOcAafe1rejNywiwkI7uYEdJTMB//TNSPqeufFVAFdjziQGMQREiuPdCXwkThaSYjEMsAu
 AxiYh22q8Fr3YRQCetVeMQlmzDimTgLDlHoxcNFpa6C6EDixHj+tMzUyZKcpwRq81tm1Tq
 1K9HC3RP+rcAr+Zix60jlDR1DAppS0sG5eUD6umcK1+kkCUjD9704qUceGl2LQ==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PULL] u-boot-sh/master
Date: Mon, 14 Oct 2024 00:51:07 +0200
Message-ID: <20241013225123.427552-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ce8658e1c0216c91efc
X-MBO-RS-META: 437tp7o9tpy4r4s6yeu8twxki51ixxz8
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

The following changes since commit 47e544f576699ca4630e20448db6a05178960697:

  Merge patch series "Tidy up use of 'SPL' and CONFIG_SPL_BUILD" (2024-10-11 12:23:25 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-sh.git master

for you to fetch changes up to edcb15c583bf259bc27db1e7073fc79784be8bf7:

  clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.10.9 (2024-10-13 23:21:26 +0200)

----------------------------------------------------------------
Marek Vasut (7):
      sh: cache: Fill in invalidate_icache_all()
      pinctrl: renesas: Synchronize R-Car R8A779G0 V4H PFC tables with Linux 6.10.9
      pinctrl: renesas: Synchronize R-Car R8A779H0 V4M PFC tables with Linux 6.10.9
      clk: renesas: Synchronize R-Car R8A779A0 V3U clock tables with Linux 6.10.9
      clk: renesas: Synchronize R-Car R8A779F0 S4 clock tables with Linux 6.10.9
      clk: renesas: Synchronize R-Car R8A779G0 V4H clock tables with Linux 6.10.9
      clk: renesas: Synchronize R-Car R8A779H0 V4M clock tables with Linux 6.10.9

 arch/sh/cpu/sh4/cache.c                 |  11 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c |  31 +-
 drivers/clk/renesas/r8a779f0-cpg-mssr.c |  12 +-
 drivers/clk/renesas/r8a779g0-cpg-mssr.c |  18 +-
 drivers/clk/renesas/r8a779h0-cpg-mssr.c |  64 ++-
 drivers/pinctrl/renesas/pfc-r8a779g0.c  | 830 ++++++++++++++++++--------------
 drivers/pinctrl/renesas/pfc-r8a779h0.c  | 219 +++++++--
 7 files changed, 755 insertions(+), 430 deletions(-)
