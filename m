Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC3C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7176583A5C;
	Wed,  6 Aug 2025 16:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NYpg0kQU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WSGTde2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C28BD83A36; Wed,  6 Aug 2025 16:47:51 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CBAC83A5A
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bxtSN2K7kz9tB8;
 Wed,  6 Aug 2025 16:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8jXW5lyeoOIo1RaOSj6evWFC4b2BBT6PMwVJAwQsKc=;
 b=NYpg0kQUaqyll90UfitIqCRNeazYP94EGzdJ9gV4ADlSH/L3e0gHLvcIvoeXPvbQmECX+N
 zSda0uUgoLZjxdflxRPxiiBnTleL0AKdaVi5SriYYsvdqZGS/b2QxaqqNqbf+deFITzOnu
 ULlP9pQdFH6YXnIJWTyNgtWc8VB2JKmTWBSInROEy5N+kL7boek30AvGuvkEuOlkPgukgT
 /d12UMtL/H5DZtEYkvyfzWuzOW495ESDORqCcDHx9M5V4es7zU12cOKRa1wjLNsFjzXcEu
 F9YN8W9PW+NTnGkKY463q53wCkymebwWwy4tDybixJHkB0tfBqHZFSzSeDPTBQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=WSGTde2W;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754491666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8jXW5lyeoOIo1RaOSj6evWFC4b2BBT6PMwVJAwQsKc=;
 b=WSGTde2WUov2fkhsrnFJA72g3ScBRvqi7PffsaZ+mBCZgygs+ZmDstiDGKJjyM9Ds4kEpa
 bZkt83oZ8dqjtDvl/6dODbwlYcxeMLzaoSnx+N2uN9spKUPDf+PCbQ/zwHCaZqhHVRa55N
 DcAGq35TEaTcoDG6/CLEloaLzbpUYeY2G8xu7X5mI9s/FQ/5FYAaqL+uivCFMGBVSW5eB2
 dLvbSbF76qKPMZ1Ln9FycAZT0KPtBm5xSjnuxQN9L9akSJYiPh9R0T8oJnGV1X1rmohkLk
 43q7Y6wBJI7v742StNH3QgR7qRgf0IKTzp9C8YgZYkz3368c0VJg1IZUl6BViA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] arm64: renesas: r8a779g3: Enable Winbond SPI NOR
 support on Retronix R-Car V4H Sparrow Hawk board
Date: Wed,  6 Aug 2025 16:47:14 +0200
Message-ID: <20250806144727.7006-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250806144727.7006-1-marek.vasut+renesas@mailbox.org>
References: <20250806144727.7006-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e27bd752c9d663072d4
X-MBO-RS-META: hipn7w9xxzgfi4en5n6qirppmsfin61d
X-Rspamd-Queue-Id: 4bxtSN2K7kz9tB8
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

