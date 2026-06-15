Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D376ECD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 10:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17484846B0;
	Mon, 15 Jun 2026 12:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="T+5Zxcko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB8A84704; Mon, 15 Jun 2026 12:56:22 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 43593846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 12:56:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1AE1328D;
 Mon, 15 Jun 2026 03:56:14 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.125.22])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 64CA63F905;
 Mon, 15 Jun 2026 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781520979; bh=TruRF9Ce/yRiN/FGK/OygN2/op4u1mXW1iTo9RI1Cu8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T+5ZxckoAL+BePijGlxZ2g2oY2oU2V8ebRCsf8xAOneQ3IsFaRy1Hih5C28UA8pf5
 QEGlW/75hSoN+orJzzSzjckidtOOJmeHA0dmauzMeenIor/zD7uH9ruW3W9bKNUz9z
 M+X2nQddavuEPNXoRzVjnhUI9m5MecvxPXHdgC4Y=
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH v2] efi_selftest: fix guid comparison
Date: Mon, 15 Jun 2026 12:56:15 +0200
Message-ID: <20260615105615.61271-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611092926.578977-1-vincent.stehle@arm.com>
References: <20260611092926.578977-1-vincent.stehle@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The `loaded image' efi selftest is comparing protocol GUIDs with the wrong
polarity.
This can be verified on the sandbox, where two protocols GUIDs are
retrieved by the test from the image handle in the following order:

1. Loaded Image Device Path Protocol GUID
2. Loaded Image Protocol GUID

The test matches on the first GUID, while it is in fact looking for the
second one; fix the comparison polarity.

Fixes: efe79a7c0de0 ("efi_selftest: test for loaded image protocol")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Alexander Graf <agraf@csgraf.de>
---

Changes for v2:
- Continue using memcmp() and not guidcmp()
- Keep the Loaded Image Protocol GUID definition
- Fix Alexander's e-mail address

 lib/efi_selftest/efi_selftest_loaded_image.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_loaded_image.c b/lib/efi_selftest/efi_selftest_loaded_image.c
index 5889ab12617..e0668f60ebd 100644
--- a/lib/efi_selftest/efi_selftest_loaded_image.c
+++ b/lib/efi_selftest/efi_selftest_loaded_image.c
@@ -60,8 +60,8 @@ static int execute(void)
 	efi_st_printf("%u protocols installed on image handle\n",
 		      (unsigned int)protocol_buffer_count);
 	for (i = 0; i < protocol_buffer_count; ++i) {
-		if (memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
-			   sizeof(efi_guid_t)))
+		if (!memcmp(protocol_buffer[i], &loaded_image_protocol_guid,
+			    sizeof(efi_guid_t)))
 			found = true;
 	}
 	if (!found) {
-- 
2.53.0

