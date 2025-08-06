Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06673C87FCB
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F6884284;
	Wed,  6 Aug 2025 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oNR/BIgP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MI0wtBwe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D1CB83721; Wed,  6 Aug 2025 16:59:21 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A34383A5E
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bxtjf74w1z9tVZ;
 Wed,  6 Aug 2025 16:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754492359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84HZZ3xURaI6oATkWSfv3QSbSlrOot6eqBD/Dc342ak=;
 b=oNR/BIgPQMgfg4kVH+28BG3XoXqhONEQ+yNdlVLvKNK2D1DqR0xVEapvrvMmWr5DvGlEjV
 vEqgN+2jNBLZxcaxhz095tQtsloH6JqwURTEmFywBE5/U79nf9NOtBTKiycTFNRsk2P7HV
 e5GlGivD84GFFMvA/MezMBctVuG6hyKDZs8WP44k+2ICvwwnzti51jh2nuuERvxI2Rnm7T
 bdDSZ3UH2BIaJHFYbtYBZONnbq2AOOaUXBf1LqiOpbLxUx/iZ57exlddz51pi0FzYVJ9jJ
 9iZOcSDclVCKH/qpjHhOM1u9j9qZVab1xXUQ+IpNnPGBGepMmRaM6kEYR0kGwQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754492357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84HZZ3xURaI6oATkWSfv3QSbSlrOot6eqBD/Dc342ak=;
 b=MI0wtBwepL0GTv4szsjUYVTy9OY9vWodBXs2tYtEBwU4L3QQfqSYP+wrEEZDRgxZGFLrW0
 dMwt1YvJbWfCtB7Gl0VQDzNtjIT08lxSvcRhkCL3PjY7+qwClDUVOdLougk72dcFB61e9v
 5+e6oL7vvslhrgNjaD3q/kYkJt13R2uNrmiXDnI6jrhBxHoluyk1dQq6ZEZeaaLq+Bn+PD
 qKBOqPxZFT24byneb1CZJyWP2GuegAuCo8GVsDagrLmvEDSeI1wlujaB5NYCBHnQs9Rzb5
 JZEsa8xbF+lugl+0rThWM8zhdA39t4JsEUe/ouuEXaUKum4EzjaAv7IDRokR9g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] arm64: renesas: r8a779g3: Enable Winbond SPI NOR
 support on Retronix R-Car V4H Sparrow Hawk board
Date: Wed,  6 Aug 2025 16:58:54 +0200
Message-ID: <20250806145903.8996-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250806145903.8996-1-marek.vasut+renesas@mailbox.org>
References: <20250806145903.8996-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 5f8fe731c4168596dc3
X-MBO-RS-META: wnhmemgmqykjyyfgf53rs3eeoqn3xdf3
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
V2: No change
V3: No change
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

