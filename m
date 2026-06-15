Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B44CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D44A8488B;
	Mon, 15 Jun 2026 23:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hZV2HhzC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fZaT0dBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8249846A4; Mon, 15 Jun 2026 23:47:52 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8D45846CF
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gfNyZ2nQpz9tSn;
 Mon, 15 Jun 2026 23:47:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/46Mgp77kkVhFIq9q5aldciag/cwoCpv0H9qfw3XBCA=;
 b=hZV2HhzCTrHz04OMXvA8prV6FTKyD/5+ic3JLZqEYlkU0DV2ZBSOLIYKXJQ2j9qguDqoED
 w4m98mxuePacyC26NF+Ue5HwJYas/XKx2DUAKjtO9vQsBXJErcS5crjwFe4xhGlxRMeMBn
 isd4SGwaonsuuMjC/QcgZ1TEhxZU1otqZ512WqMvVFE2QkBtXlODBHNpfP8btJndv6lsdc
 2ZmRUht8QeRzH9f2FcbaEQJoMdymxxinSzyZXaw6/xmVN+hKyDg2eKGb6N8TQeDZxjMtvb
 MBG4X3W6nXAiIm/Xvq6Ka4Ds2ChH6V/n6O8qgMTxhYZWzJJ70Qc3D/lR+5ZzdQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/46Mgp77kkVhFIq9q5aldciag/cwoCpv0H9qfw3XBCA=;
 b=fZaT0dBU2OTlGXpVcQtwHMOy56YZFblYLWeijNVDHm8vXIp3KfwZj/pi1/zFqhHb+Dj3vL
 2tcPZO2FeRmLh2ZhQxnL/YZeMV8+/Lg/nK2RO+o1WFKCPspElIwB24wUkGUAw1d+ctVfQ5
 1m9huzvGNs6aqueApiofCUlKaSMSRcuq2nnn2U9rFu1pqjw6OhSpDVahwnaTS98NGxnMKa
 fhxor/txi0Y8OcZQ8WMedvnrqkuMqvrXwHKtS3xdHVEtnOEvVBmD3fww0sUIk8iI6s92WC
 OD9GvVdZy71GKsXRa3wy+zS/mDIim+mK3S65r9BWP5znLij++oNGuAC+oGeONw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/3] doc: board: renesas: Document Renesas Gray Hawk board
 support
Date: Mon, 15 Jun 2026 23:47:16 +0200
Message-ID: <20260615214743.35390-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260615214743.35390-1-marek.vasut+renesas@mailbox.org>
References: <20260615214743.35390-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d1doz3zxapqauektnhqbkbhc5yqk5fpk
X-MBO-RS-ID: c878cbc10c31ae6705a
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

Document support for Renesas Gray Hawk Single development board
based on Renesas R-Car V4M (R8A779H0) SoC.

Fixes: 53066deccbed ("ARM: renesas: Add Renesas R8A779H0 V4M Gray Hawk board code")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 3e1afb973d9..453186fb106 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -192,6 +192,12 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - arm64
      - r8a779g3_sparrowhawk_defconfig
 
+   * -
+     - Gray Hawk
+     - R8A779H0 (V4M)
+     - arm64
+     - r8a779h0_grayhawk_defconfig
+
    * - RZ/G2 Family
      - Beacon EmbeddedWorks RZ/G2M SoM
      - R8A774A1 (RZ/G2M)
-- 
2.53.0

