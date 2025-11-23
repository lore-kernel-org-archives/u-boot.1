Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B2ECFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B4683C4B;
	Sun, 23 Nov 2025 23:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BnpWHLYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0830983C30; Sun, 23 Nov 2025 23:58:27 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2889783B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5B25E409BF; 
 Sun, 23 Nov 2025 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938678;
 bh=rI6waMrUsI9dizG/3C8A9kpgvvL32q/oHcukMQIvQIw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BnpWHLYlaEybWtuUZBTTqVGWDUdcdmeIX3gyJUuwqo2D9zZObE4N1P5sTuMVhww04
 Y1gJkhrNbN5S+EPahjHmXup34xpOZSVai8UuE6nEfuGRgXo9coMOjz0nZt4QAGPMVq
 0kvMFJug93pv74qppWhkSbgOKYOQj8bcEkaweHqHxKoCA2KfoOHd8DQGYHZjUZyeKL
 GoOy8QLRce12Qdouk+9Gnqz/utGcC10Nrp+nUChYnnw0jaX6Ds0ciUEvK7Odh9QDtJ
 reRWrzvxSYYxjieX7z/5TOXXtpd+i7cnt2MZBa82ZkdrPGjWpZ1fRqLZRLSu4ytNXR
 XG2NL3nelPFmeqnE/bgZKZGWNWcHxdrfyVFj2oLlKZlzekPfX2TSHtwdjqSiyj1F6E
 bGiGx/rt8WblfMfKVs1DYBkmFsr4KavpLSw0J6qaXtEYcGs1yOiBiQ3xpQ9SH7qqvj
 /s6smbtcjtbg1kFpH9d5QUdcgniv7jF+xWw/HtW2Rrcj58s9cNy/nQztZIV9pm4C0U
 SxHyGQf4boRG+ULlCW+6q88uYcznbeMS4rP4grTQmGAuPA3yDzZ/8dYRBdTc+MVMBT
 QVVcnpAqfjG4bB11q6enevHS341IKoKEc4TcSTeMKvZdPkbk7NPwHV9nISNdoLFjMF
 PqOlI9LDdmxN7TuD6A8c+sx0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 06/19] test: bdinfo: correct expected X86 arch info
Date: Sun, 23 Nov 2025 23:56:58 +0100
Message-ID: <20251123225711.227016-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

Skipping to the line starting with tsc reaches the tsc_base output not the
final tsc output.

Expect all the X86 specific lines in the bdinfo output.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 9ffa0d3cdd5..2f3a65996e7 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -216,8 +216,25 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	}
 
 	/* Check arch_print_bdinfo() output */
-	if (IS_ENABLED(CONFIG_X86))
-		ut_check_skip_to_linen(uts, "tsc");
+	if (IS_ENABLED(CONFIG_X86)) {
+		ut_check_console_linen(uts, "prev table");
+		ut_check_console_linen(uts, "clock_rate");
+		ut_check_console_linen(uts, "tsc_base");
+		ut_check_console_linen(uts, "vendor");
+		if (!IS_ENABLED(CONFIG_X86_64))
+			ut_check_console_linen(uts, " name");
+		ut_check_console_linen(uts, "model");
+		ut_check_console_linen(uts, "phys_addr in bits");
+		ut_check_console_linen(uts, "table start");
+		ut_check_console_linen(uts, "table end");
+		ut_check_console_linen(uts, " high start");
+		ut_check_console_linen(uts, " high end");
+		ut_check_console_linen(uts, "tsc");
+		if (IS_ENABLED(CONFIG_EFI_STUB)) {
+			ut_check_console_linen(uts, "efi_table");
+			ut_check_console_linen(uts, " revision");
+		}
+	}
 
 #ifdef CONFIG_RISCV
 	ut_check_console_linen(uts, "boot hart");
-- 
2.51.0

