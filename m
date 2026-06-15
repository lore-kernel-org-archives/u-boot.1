Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E577CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAEEE846B0;
	Mon, 15 Jun 2026 23:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MynAv3WL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oe7j3nNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7364E84884; Mon, 15 Jun 2026 23:47:52 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55216846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gfNyX6YZxz9tBc;
 Mon, 15 Jun 2026 23:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ilj1ojAxGjH1zAcwIuCTJiUZ19xuk3AmvmVaP6qXi+E=;
 b=MynAv3WLrug6F1MQPiOMNQgK4aH1h4ckeJ65W3rQegLFLBDHKbcPchQBGq3hLgFqf3N6kS
 064ZYBob9PndjWPuuA9XzQuNsSmGOnECzfcWfsDZsLsxECiOaHQVM7yq6oIDI9zazdwCy+
 EMO/l5Xo3KbYxsKkumMUvrJ2m+RaZ4W1/844Myz0X9bEMOtrRu0vuFUYgq+fWcaViM6jbf
 S20KVgKdGPBffamo17qsHpUNIgb4VzCnCrwMbTnTQ1cBI4vKyMAsLIdOptGnNRlvR8NywU
 FL0eBqPye6YotU5ny94LbEZP0vvUmF+67zbt1r1d+BHZg5ZmW2lft5ue1gDUJA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781560067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ilj1ojAxGjH1zAcwIuCTJiUZ19xuk3AmvmVaP6qXi+E=;
 b=oe7j3nNfZMlWg8WVwnoewmgIMdgNDLKZrECpeVOZ9heRfpeTwld3ANqzlPk/x74pIXViXQ
 4KeOGTaVhBYcbPqORxWJVuANmbF3tppyxRQweovNf9KVIJ2FqbqN7TEG/xPDoM+ooDZcV2
 gbmzxQ/tuim3uDYS0uB/wBae3g/ZS+5F9/DBeJcGQ9JKx4EnbjqraBVnVquox6Yln8q+GL
 jTH0clmS+yMmLt2U14zT944aJdHpv0eZDAvxGNLNlI8bJ+i8MUPcIgPFLz5rj0t0yqIwIq
 6BpTiO2/ZD6lWfQy9f5J/0F8KXB5OugDvFHKWsjWIwxyjkqAxetz72ZIve3loA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] doc: board: renesas: Document Renesas Geist board support
Date: Mon, 15 Jun 2026 23:47:15 +0200
Message-ID: <20260615214743.35390-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f2a4e34f20071e27de9
X-MBO-RS-META: s6sn3idaxofzrwbzkz9rr9qpbc7w8ymj
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

Document support for Renesas Geist development board
based on Renesas R-Car M3Le (R8A779MD) SoC.

Fixes: c8523795d796 ("arm64: dts: renesas: r8a779md: Add support for R-Car M3Le R8A779MD Geist")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 doc/board/renesas/renesas.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/board/renesas/renesas.rst b/doc/board/renesas/renesas.rst
index fedfeed42e3..3e1afb973d9 100644
--- a/doc/board/renesas/renesas.rst
+++ b/doc/board/renesas/renesas.rst
@@ -120,6 +120,12 @@ Renesas is a SoC solutions provider for automotive and industrial applications.
      - arm64
      - rcar3_ulcb_defconfig
 
+   * -
+     - Geist
+     - R8A779MD (M3Le)
+     - arm64
+     - r8a779md_geist_defconfig
+
    * -
      - Eagle
      - R8A77970 (V3M)
-- 
2.53.0

