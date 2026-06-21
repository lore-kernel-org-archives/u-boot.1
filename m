Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5272DCD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA301848DC;
	Sun, 21 Jun 2026 10:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rSjNLrf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB3084844; Sun, 21 Jun 2026 10:19:28 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 379E3849BA
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-176-006-085-155.176.6.pool.telefonica.de
 [176.6.85.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9483B3F1E4; 
 Sun, 21 Jun 2026 08:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782029964;
 bh=GNa5Lqk6MlMcSKMl5xCvXxxIiflIZSi7xrvsapjGCpo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=rSjNLrf1FhafAJdQkfmVegEk1EpZ3o4Q7YvVVHYSH5uKWjAR3nwfg3esYeCDTnATi
 cztVZWMGgyGo0Zn4KaSxFcGRgsxZZY0rZ0KzlpFd0eOCOfBkEjT8xzxMHu0oLoMJof
 25UYWExNUkhuJi427azuZM8Wi1+dx15FFyVa4nUWW7MppQitsv8kUy0V/0L2Fa7O1v
 cM078FQ1PM3O46avSiRhvuNjSW9wv87My5UeNlV3/iBKtBqmiOPgGL3f2JjMCf6IZ4
 hK9zBF70e7spV8bOdXAtOWAWSSveVjlHXN53ZBqpS+XBJnU34rYU2J8/5NEHQlUb2M
 SZfSKPaXSoAn19nTE0hfnGUq5CIDb2pmptPIiS1cXny6prDYEG8YkIW0X4smfWn5ds
 1s0NSvkpoQIv/FR/LWBUq/OWFajcFItIFcPWVj4cGhKPmwAM9zEo3Py8gI2I4vrIGg
 nsRyIXNY+8g/VO7hY1wSZWNatdvGWuGYi59gs4pBCZGYBeZhaBvfyZuLG6mZrpqgHO
 Ocote3XAeoubogwUstx1B63sOjoh6ZWvoXztN399vv9NzIJz2eqIoAxIRPYC6zqDDx
 I3LnKbTMYC3bUPhFdN00eCt3JR5+fe2/1JWMjbKoeTZfFaAK55wjhsDXzSIZh6TJ4b
 FCPxKaqNpTGfWCENw/BWzZ9c=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 10/11] qfw: fix RSDP ext_checksum recomputation
Date: Sun, 21 Jun 2026 10:19:14 +0200
Message-ID: <20260621081915.19154-11-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
References: <20260621081915.19154-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
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

