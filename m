Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABBDD3B7F8
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4815883C51;
	Tue,  9 Dec 2025 16:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="Z9OC5dyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA6A83C6C; Tue,  9 Dec 2025 16:55:50 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE2583C39
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-297cf964774so9902175ad.2
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1765295741; x=1765900541; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pl9XYgqRR9c2j67fhuhjmlW5B1zHkFntwtfxF3FB6c0=;
 b=Z9OC5dyucw9Hi8ukzu8tLb0FZi+TqnfgrjBwBWCpc1O2rwHgqaElQUnN1olcG3YZE8
 SllWRlJQUrYr2PjJVDCODpEr85P0u1yKYQNxZPOCRWHBzfyGEVE59aBFN1lZkabB4rCG
 h9bP+sR1ww24JRPINBzemIkWyx0juqzyR8JE/CzavTfUIpExjDvdjvET+JWgWztODN6Q
 HCPjUzK3NwsoObDwg+4G6qSbutyCyxVN2QPOXSt1cdlHHxm0X8ywXEm5/Q1/LNQrlyCx
 SASCjV5aED9gpqV5nQ6dHjiDYUpoBmWH+wyJTKx4e/tnzWXIdX1mWXaBamKZCPGF/mga
 dUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765295741; x=1765900541;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pl9XYgqRR9c2j67fhuhjmlW5B1zHkFntwtfxF3FB6c0=;
 b=Zt7cjD5p8Tv49tpPzVil1ytnR3rohrUid0ORI8+7+BuT/4caZx+aGYSwWwqrLE/v3p
 2a51nd7DTTm4FrA4HoG7eWv1q6Q7bE+fprNsjFE5tBB+Y1XkP8iDdRSiyYf+YZ515MDM
 /um/W3dc/UNwxmq6FKb6mrfcYZYvOcMkQJFQuIo1Ayn7LgYpuKDSK7jGG9Cu63nF18W3
 Xuz27F0KjD8MHST1CgvPwDIutiVQNbQf43LwMMICE2X3Eh8bXH9QacAvPrNt2RQZgwTX
 4dU0sPid26UVV4cmHqbawHsfpbZl8fbl9sHXJhwQjdbzgVy3GCFXbwsfw3lHIrvAH86n
 cfAA==
X-Gm-Message-State: AOJu0YygXPDwz7Usr8rC/915yCU0BCvJ2gVdoh3Uj5ywfTDqpAdmhvOm
 Qemodm9NeuDy/1Dj6ueiXNK6DG8v0nH2aWySFKIyhgcoGLC5vCsiKNe75TlJsUqUBMbt08vayxJ
 CKVe0TQ==
X-Gm-Gg: AY/fxX5u82d9RIylJc5JGDzJ41SWmeSNKTaYepJQQ8iTLVzUpTVhPMh0sZEZp3YLQoB
 LFoDZrd5m6PLXm44CinlXDvQ1c3FzpqJE5mdNUK7Y2q696plMw62l3Kx0il1kd+s3fhPJoLZ0em
 RJMyKAWG4FTJISWdxGWcKJ6ck9mui1wPbOpvFukinapZ6xvFDBxZRTfOkV8W5vAcNwKDImmswLu
 MkfNuPfFpovMjhBPHzNoIfCXsV0DtTye769/pLUsUPWCMZfY1xZbXxNMFAFG+MNGUaJoLaNn2TD
 Nc0SL8AR1Ik5MAj7j88SwWqGxN4mu5/jEl4K+Zf/ae2ahHVXybOKAAfavsUAhQeDti/ibTLJAl7
 AXxKvOEcNEcXy9p7j46lHScF6oGi72BVgJ9u5dL+fWA+6eYcKS8Jpv65PclulrCd4U1HZMFgULO
 FDayfjKQxu+zePuNDghPMjrEL//yQtZjJCYF5N3RaoZiJiACk=
X-Google-Smtp-Source: AGHT+IFrriKqsXiXi3JxOCRFaEJWtEqGlNeVIVC1DTRlioD2Ne8ykJMHElwpLVgA03XryZstjTaGsg==
X-Received: by 2002:a05:7300:6409:b0:2ab:ca55:89be with SMTP id
 5a478bee46e88-2abca5598c0mr3912891eec.5.1765295740485; 
 Tue, 09 Dec 2025 07:55:40 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.12])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11df7552defsm73006944c88.2.2025.12.09.07.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 07:55:40 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
Date: Tue, 09 Dec 2025 07:55:38 -0800
Subject: [PATCH] test: dm: fdtdec: Validate FDT size in unit test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-fdtdec-v1-1-614003860c32@arista.com>
X-B4-Tracking: v=1; b=H4sIAHlGOGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNL3bSUkpTUZF2LNHMLM0OD1MQUEwsloOKCotS0zAqwQdGxtbUAaW8
 SelgAAAA=
X-Change-ID: 20251209-fdtdec-8f78610ead48
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Adriana Nicolae <adriana@arista.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765295740; l=2460;
 i=adriana@arista.com; s=20251030; h=from:subject:message-id;
 bh=5svNdAWoToL7C6qST4BG048RUWCWnSs/+szqDVxqHdM=;
 b=qPEza/DD2oEhRTvnmJNdi9fN91rFNDDHdH+2r7XOto/vaAPsoPzZ6Z8G+eKloLyznGXYJ4PpH
 lPuiofYY+SXBreKELVf6TsN7ItMIV/e8pBlPWNPielf7ZUxKCQoXwm+
X-Developer-Key: i=adriana@arista.com; a=ed25519;
 pk=lII+K3k+wnbGA8lid1LtGpyLz6AegAq0xb4hHGsHZc8=
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

The current FDT decoding tests calculate the memory required
for FDT manipulation by directly adding a fixed margin to
fdt_totalsize(gd->fdt_blob). The static analyzer flagged
"gd->fdt_blob->totalsize" as a tainted value being passed
to fdt_open_into().

Ensure the size is validated by checking that the total size
is within a reasonable maximum FDT limit for unit tests.

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
 test/dm/fdtdec.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index ea5a494612c..495f57234a4 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -14,14 +14,19 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#define FDTDEC_MAX_SIZE  (2 * 1024 * 1024)
+
 static int dm_test_fdtdec_set_carveout(struct unit_test_state *uts)
 {
 	struct fdt_memory resv;
 	void *blob;
 	const fdt32_t *prop;
-	int blob_sz, len, offset;
+	int blob_sz, len, offset, fdt_sz;
+
+	fdt_sz = fdt_totalsize(gd->fdt_blob);
+	ut_assert(fdt_sz > 0 && fdt_sz < FDTDEC_MAX_SIZE);
 
-	blob_sz = fdt_totalsize(gd->fdt_blob) + 4096;
+	blob_sz = fdt_sz + 4096;
 	blob = malloc(blob_sz);
 	ut_assertnonnull(blob);
 
@@ -67,10 +72,13 @@ static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
 	fdt_size_t size;
 	void *blob;
 	unsigned long flags = FDTDEC_RESERVED_MEMORY_NO_MAP;
-	int blob_sz, parent, subnode;
+	int blob_sz, parent, subnode, fdt_sz;
 	uint32_t phandle, phandle1;
 
-	blob_sz = fdt_totalsize(gd->fdt_blob) + 128;
+	fdt_sz = fdt_totalsize(gd->fdt_blob);
+	ut_assert(fdt_sz > 0 && fdt_sz < FDTDEC_MAX_SIZE);
+
+	blob_sz = fdt_sz + 128;
 	blob = malloc(blob_sz);
 	ut_assertnonnull(blob);
 
@@ -138,14 +146,17 @@ static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
 	void *blob;
 	ulong val;
 	struct smbios3_entry *entry;
-	int chosen, blob_sz;
+	int chosen, blob_sz, fdt_sz;
 	const fdt64_t *prop;
 
 	if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
 		return -EAGAIN;
 	}
 
-	blob_sz = fdt_totalsize(gd->fdt_blob) + 4096;
+	fdt_sz = fdt_totalsize(gd->fdt_blob);
+	ut_assert(fdt_sz > 0 && fdt_sz < FDTDEC_MAX_SIZE);
+
+	blob_sz = fdt_sz + 4096;
 	blob = memalign(8, blob_sz);
 	ut_assertnonnull(blob);
 

---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20251209-fdtdec-8f78610ead48

Best regards,
-- 
Adriana Nicolae <adriana@arista.com>

