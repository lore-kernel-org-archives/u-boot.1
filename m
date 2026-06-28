Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5DAC43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 08:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F69684A1C;
	Sun, 28 Jun 2026 10:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g5PvSLbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FFAF84866; Sun, 28 Jun 2026 10:28:20 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF68C848F3
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 10:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box
 (dynamic-046-114-110-002.46.114.pool.telefonica.de [46.114.110.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5BBB142099; 
 Sun, 28 Jun 2026 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782635297;
 bh=93VsNwgUtotuXS0i9vUw0d/EOQqmnRzSxSI/QnDqAMc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=g5PvSLbtx72MQwMLds2fwKnzfJyPPvXm5daypuZxVrLMUWcySSVYoKxfs1yFkp7eJ
 v1LqHVwZ6EQTIZoApmCe769pmlvV1TcJDH6JDtqpeBm0boDUeqyJqKMKsv3uNbzgFK
 bZV6g+Jkd5Gb4KVTMPgxmZM7kflEVk3r0XVu3NBgUUgMcEGmXw45SW3f9izo5QIehW
 SBB2we0caXTf3UWKkInxEkh+FIVXU/UFx+oY4OueeK1EHCAzOk9Ef6KupnHNVgtJ0E
 kyO/y6SdfU8S0YvGdu6UH6H7kiEyn3TzK8kgpawpFmfkMDVPbocJTkttOT0kaj7f/j
 0T6Ndrxtg6nrTpeEguOngL3QwsRBq1p36ulfnhkij1nw6bCZN0GARIwiZUJ+2ATed/
 7C2QJ5OWyKjvrvj+QxVQY75GmnlI+Pe+JcMnoOpJUeDm/5VSTAxrgpcRqEgMz63Yx/
 VRdc7dTrhpE1Fm8v1azjZUfO3QBNwe4RNm8lKQ/rekvXGk39BvG+1Jw8iqDyL3vOkb
 lHdT/3gL5RaVKvCUVPVldoNz4qLBM2o/5SJhBWWrdaEUXybTBKgEnH6nQKJDLrQwND
 F4hfnYDpXq+gUp3UzAKgiVlHKAEnMu0n2XmxDjL+KBZLzhII1sDzvqxLGDHZ3Uf0UH
 1KHZ0/NlTmUYlBwnIkmQBNKs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 10/11] qfw: fix RSDP ext_checksum recomputation
Date: Sun, 28 Jun 2026 10:28:08 +0200
Message-ID: <20260628082810.175862-11-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

table_compute_checksum() returns the value that makes the byte sum of
the buffer zero. If the ext_checksum field already contains a non-zero
value (as QEMU's firmware-provided RSDP does), adding that existing
value into the sum produces an incorrect complement. Zero the field
before calling table_compute_checksum() so the calculation starts from
a clean state, matching the pattern used in acpi_write_rsdp().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	no change
v2
	new patch
---
 drivers/misc/qfw_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/qfw_acpi.c b/drivers/misc/qfw_acpi.c
index 721f42ecbc3..afa3b820395 100644
--- a/drivers/misc/qfw_acpi.c
+++ b/drivers/misc/qfw_acpi.c
@@ -265,6 +265,7 @@ out:
 	struct acpi_rsdp *rsdp = ctx->rsdp;
 
 	rsdp->length = sizeof(*rsdp);
+	rsdp->ext_checksum = 0;
 	rsdp->ext_checksum = table_compute_checksum((u8 *)rsdp, sizeof(*rsdp));
 
 	gd_set_acpi_start(acpi_get_rsdp_addr());
-- 
2.53.0

