Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA5CD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9D583EF2;
	Sun,  9 Nov 2025 11:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MSM2eVVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E9F83E8A; Sun,  9 Nov 2025 11:10:29 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA8F83EAF
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8292F409EC; 
 Sun,  9 Nov 2025 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683026;
 bh=0hmFeRxmLNN9LdZV49eb48C/f/YtEJZllSpHqlreNIo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MSM2eVVjRBwK6Ad41O2IDJ2A/CAiu+zwrprL4G7m1NBxKwyDg8HnCTQLMp+gVFQs1
 hI8AcxR33Rlww9u8hk3mhZ+qrcJng5GCCF0/Tmn3yd/AoOLASDoANF7j+ANGiwwvXN
 q1VsIsjZDhk4kBrADAV65u4cjm0wEDy1JhAhoxJbtyuLTxLoU/eZGU4+TeHlePWF02
 GX0mb463EbJ+q/6Psl+FK5Ucnxpr7HKVq27QqSImAbgPzb/wfTsjBuUghU4kjWoHpJ
 8ezVnqw/xU4HKjhps2kdhwOeQbopMhJ/iaSurW2kNLpWR+aXiZRiou4aANfBXEWrlX
 X9erUJRuOLKY37/HSYSf2vRUUuDWFJrNrF9RxBtHMvKpBbdEW0qVT6O9yVDBDiT6D/
 2kE45EtCAwKRYGLaAj9/1WafnJrQK6vPN6r6UZfd4eYlo8IIxTMZFZRKX8NAZy/6Fi
 mvXU8OBbQahAg3ekFqg/naZXO/EJ6QwaiMQpose9a9LnzgpO4qhHZBUaPZdKpEqbWf
 AOwXWBLwVLRqHuU3m/R6RtUIFNamUBRZoQuQi2ajlWY/jwMAA60PHvRCOcAK0g3ted
 2D5xfa6UPSF4LPh86tV3VwRF5ZfCREF4s2GO7u3mhlAunqVJObm4P/chsHzs0pwEBz
 E1oj2ELm3MROsqi37qAUfErk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH RESEND 1/9] test: fdt_test_apply requires
 CONFIG_OF_LIBFDT_OVERLAY
Date: Sun,  9 Nov 2025 11:10:02 +0100
Message-ID: <20251109101010.306268-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

The `fdt apply` sub-command is only available if CONFIG_OF_LIBFDT_OVERLAY
is enabled.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/fdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 96a8488e172..a36f2dcdda8 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1319,6 +1319,9 @@ static int fdt_test_apply(struct unit_test_state *uts)
 	char fdt[8192], fdto[8192];
 	ulong addr, addro;
 
+	if (!IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY))
+		return -EAGAIN;
+
 	/* Create base DT with __symbols__ node */
 	ut_assertok(fdt_create(fdt, sizeof(fdt)));
 	ut_assertok(fdt_finish_reservemap(fdt));
-- 
2.51.0

