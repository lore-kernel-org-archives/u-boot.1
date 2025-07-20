Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C229EC83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 20:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5239382FCA;
	Sun, 20 Jul 2025 22:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YefKTt6k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qaSm3opC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A4B58303B; Sun, 20 Jul 2025 22:00:49 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A773682DA1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4blZCM22XGz9stH;
 Sun, 20 Jul 2025 22:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uZwNN93Jv34dk3m0DxSFhNmoPBE/s4M1RO664dY3Lg=;
 b=YefKTt6kDKj0poG9viACJcgLZrnc+RxJ0iPTxxVC8uTH4pZxhO4QB/FBGAIstZ9+IA60VZ
 66VUPDsfj/fsgy8bj8L5azcNdkhYXeET2S/dtBtm2NH1oS63t40HQvHelPtkhybYFOWL3e
 Af+ReHXjDFyTEijPmVeeWujjsknK3+wrLN7w+KgTRPCfSLTIMdPp7DCqGNzirJaXwM2D2q
 dtmu0yrVwYU2aiYSWEygbubUAtcniFOMon0YgDs7J7bYuSHMORZePcsvrDeqhwEUxjgdS/
 ENTl3wGCJ+D98CVy/IjXMrtQIOdUWJOTyyAOMcbNZP5zK2O8EyjwLdyA1V0vew==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=qaSm3opC;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753041645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7uZwNN93Jv34dk3m0DxSFhNmoPBE/s4M1RO664dY3Lg=;
 b=qaSm3opCx+FFvqXb/ixoW/lxGOEY+VV4mvuWn+6w1OekBJXGPBnfdQbsSMig02RBFZHxcw
 423Fw+RfW1c+mHUCuH2bplhLgTuXr8Qe0IUNp5oktsroDFwQoFlYkCKlTHkY52/RbMQ5FF
 0j7zCHw6s0lmmL7BDEndnKBa8UIdVm4Sq5NzytDLukj1YKpMVFyJ2zH78MpsftiJD2pnVz
 FUXyAv9avtz3vOQ51SYdggvcINqxZVFb1LGb7pkDaJw/IfWBQeJmP3v1DcTk++/wo7AQ52
 2EFX4STNwgb7wOiha0fceqWF6CQiPQdhe7lIFUdjFygO91TmjtBow0GATBWmjQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm64: renesas: r8a779g3: Enable Winbond SPI NOR support
 on Retronix R-Car V4H Sparrow Hawk board
Date: Sun, 20 Jul 2025 21:59:44 +0200
Message-ID: <20250720200003.414120-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250720200003.414120-1-marek.vasut+renesas@mailbox.org>
References: <20250720200003.414120-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 82d07f72523a1d2fbef
X-MBO-RS-META: 4zawyq9pthy9fdcyti9r885mz86f5qu9
X-Rspamd-Queue-Id: 4blZCM22XGz9stH
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

Enable support for Winbond SPI NOR on Retronix R-Car V4H Sparrow Hawk board,
this is required to support W77Q51NW on new board revision EVTB1 operational.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/r8a779g3_sparrowhawk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/r8a779g3_sparrowhawk_defconfig b/configs/r8a779g3_sparrowhawk_defconfig
index 9aa8dc83317..bb8d110dc0d 100644
--- a/configs/r8a779g3_sparrowhawk_defconfig
+++ b/configs/r8a779g3_sparrowhawk_defconfig
@@ -33,6 +33,7 @@ CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
+CONFIG_SPI_FLASH_WINBOND=y
 
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
-- 
2.47.2

