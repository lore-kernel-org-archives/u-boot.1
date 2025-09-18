Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7E2CAC59A
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 16:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 575848309A;
	Thu, 18 Sep 2025 18:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iNjo2Jpm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="V+BiUXKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9550C8319C; Thu, 18 Sep 2025 18:49:58 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FC982C84
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 18:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSM7R4Wq8z9sTg;
 Thu, 18 Sep 2025 18:49:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758214195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SRLpgQySas7TfYbPQHh8cenKSadaY6HHy0SouT4Y2Uo=;
 b=iNjo2Jpma6/7hV13zSewKPTTAB41bcHK4ZQULCKs9Gj7YWJLoiv63luS9mc+jCGY7ilhof
 zFN0x3ZMYFWh0FQcd+rTolbyFzPOwjGEGJG2UwM7k3GrrIajdcelCWg/usPPfTYiAdTZEJ
 uVPySdihv9jHsQAT3qVEeonDP0JaOETG0JfYdMEXVa+FzeSvuvyCZ+chHTDeny1g88vyVg
 fIAPJPLhi33M2I+7LYJHPJgIQJrkqURAlj2DMe/gb4AgdZAU7ETCm5BYbL68IUSFg1oSSe
 o2AS91aSnOjyy85n880HJ8idG1IsIaJbslJQjxZvNNzhr0ZqtGMIJYziMPKEdA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758214193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SRLpgQySas7TfYbPQHh8cenKSadaY6HHy0SouT4Y2Uo=;
 b=V+BiUXKpQb7sXO4aNQUfDlu4s404plc1W7V9SJJh4QInqOlCHPhm7VDOrAA5CHmeoc7xQS
 fObbu3BMo6XfS5bb124pTUe1+hSM60xdFXI9TeDLYRg5bB7FzI6ng3dj4yq+f3pOFv1zYe
 toVdg+O5rAL7U5MKTC52ZYlJ70w0gNEW1e3r2pLTBw0kEcPlX0qev6qhqqF7f3UQwxkzs7
 fLFbQ5inhG6rlIZaQlvIBourDNwjGou2Br7PPUSfNfPKPeR5NKWkB+k9c7GNQ/Wg+WkP+n
 RT+tHoc8hD3ud68tvjUhutMsR12BAfGw9Md8av9XpKPFdSxTrK6tG0AoC1foFg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: Add MIDR entry for Cortex-A720
Date: Thu, 18 Sep 2025 18:49:19 +0200
Message-ID: <20250918164936.25592-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: aj886qp674saqbq9yxp5hnc8ye5cgkdb
X-MBO-RS-ID: 4b18736f077dbf1fa14
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

Add MIDR entry for Cortex-A720 core.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/armv8/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index e906fdf1bf1..d8f0e16dadd 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -11,6 +11,7 @@
 #define MIDR_PARTNUM_CORTEX_A73		0xD09
 #define MIDR_PARTNUM_CORTEX_A75		0xD0A
 #define MIDR_PARTNUM_CORTEX_A76		0xD0B
+#define MIDR_PARTNUM_CORTEX_A720	0xD81
 #define MIDR_PARTNUM_SHIFT		0x4
 #define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
 
@@ -40,3 +41,4 @@ is_cortex_a(72)
 is_cortex_a(73)
 is_cortex_a(75)
 is_cortex_a(76)
+is_cortex_a(720)
-- 
2.51.0

