Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CA2CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B34F84869;
	Mon, 15 Jun 2026 23:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DqhcqAjR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LThSRM+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DE28484C; Mon, 15 Jun 2026 23:47:54 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D2F8484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gfNyb1Lmlz9v9j;
 Mon, 15 Jun 2026 23:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRtHYQ83EQ1W+8smkPN2G8bA8Rj2U7X8XgqSG1dEFf4=;
 b=DqhcqAjR+cX9bdw1XF4mTAC+1WzBUtKcVmVVH1scaLHtoRk4OElssQEGnLnARd3lWe0NZR
 h0FjLVeFDZ3iNx5yPwtFoF1z7Ndepb0kQe14dyDz1kNeUDZ4ZuLvB1eSmuXKmrTfOAUpmh
 Z7YIucJotcp+m0SpxC5L0nGNBrF5AzZE6deFTAJuvhOIXt3op3PKNr+guceZCY7dd/H1G2
 mgO8dvPhvq1ReXUzCp3npu+Xn82PtV8ZavFcioEXG4cH31bT8tGxD8Pop5K1OnhNi7fhO+
 9F/FzgVm/udfe5z0tVIWGl+oYKWnUSrjxobIybUINLZc8mrGxY8Tewt03U43Dg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=LThSRM+j;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SRtHYQ83EQ1W+8smkPN2G8bA8Rj2U7X8XgqSG1dEFf4=;
 b=LThSRM+jJL4GARwD83BxN+zCMG60vW0670JGQ9g3tpkI7KVDJblcZYHh+bbeTsGSFzXMPj
 XqQheiBAfI2DTYS7cTHD2RMgEkHWTN4zVS7rWyZ95cLKzfAksoHlgUtszHrxWWgRDPZjse
 a/FwVxkR58JA4Q+MMx4a70WUjnAqcbgxQWg/vCF9+ck951ZiGHL1fSnxorGkQd/pfI0y42
 DHi34LEZh39sT7LWOEzlbXj1VfcNZ6N4UH+2Gc4spGE91DVgkm10dw+AWqQDNSwsE6omII
 KmffrHVtXAFn8lUiPeShJ9JAm0plVJjZj86vaLqVx9OdNgbwIEcuiwqeG9FgiA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] doc: board: renesas: Document Renesas Ironhide board
 support
Date: Mon, 15 Jun 2026 23:47:17 +0200
Message-ID: <20260615214743.35390-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260615214743.35390-1-marek.vasut+renesas@mailbox.org>
References: <20260615214743.35390-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: skun5huqcgjg1sohcndnjgkqyi9z8fos
X-MBO-RS-ID: 0b7cbc7ba164d7b7099
X-Rspamd-Queue-Id: 4gfNyb1Lmlz9v9j
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

Document support for Renesas Ironhide development board
based on Renesas R-Car X5H (R8A78000) SoC.

Fixes: cf71963778ee ("arm64: dts: renesas: Add Renesas R-Car X5H R8A78000 Ironhide board code")
Fixes: 9d47a5a4d560 ("arm: renesas: Add Renesas R-Car R8A78000 X5H Cortex-M33 RSIP port")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index 453186fb106..6702d5879b5 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -198,6 +198,18 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - arm64
      - r8a779h0_grayhawk_defconfig
 
+   * - R-Car Gen5
+     - Ironhide (Cortex-A720AE application core)
+     - R8A78000 (X5H)
+     - arm64
+     - r8a78000_ironhide_defconfig
+
+   * -
+     - Ironhide (Cortex-M33 RSIP boot core)
+     - R8A78000 (X5H)
+     - arm64
+     - r8a78000_ironhide_cm33_defconfig
+
    * - RZ/G2 Family
      - Beacon EmbeddedWorks RZ/G2M SoM
      - R8A774A1 (RZ/G2M)
-- 
2.53.0

