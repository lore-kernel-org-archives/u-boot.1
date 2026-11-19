Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B0606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uwYqyNsW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C7F281397;
	Thu, 19 Nov 2026 15:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1_GZnXCyQDo; Thu, 19 Nov 2026 15:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 372AA813F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795101655;
	b=e+42nDJFjhUuGasISBreA0GxFxpi+fUG/KFj2NLkM26bLrq3wo5UMEjkQsn9QKKbIFqz
	 qhFcGzBIjKqaUzY2Slm3QdKTH+2RDKhL7wGsrMvV6P4enMauCpgchtbyxVniPo2n4cXS8
	 xHBeWPSTryx6IPMQLhZSTluDpd2DMiFnOmWy/9Up4s8BBXWEbnUO6ZS7nCBO1mTrfLbG5
	 3uoHMv86TCvgVtf/eQvpHGA0JCwSR6GHv9NQyMRe13PEnXvvIVHjKrO8rEO2NJLiCzffk
	 DeNIhK/m0Nb8lPbmPiozOATIa+K3WbDCrKX/hqgauHOSc6WbyuKp2j4skIteyg5ymeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795101655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z8W2fslzbTRer8UG++44JDpf3PXk/eEKfX7VJByD1p8=;
	b=TFo6ssDcMQpq2mGUeLLqAP4915dH22rBO/o1jXvvzZYxzAV3v0FwRhMVQKXAgCnj9Gxn
	 yJSvAWyGAz1AUALbvvx5ag8wYOUvArQheKRDm0C+TTGKKuT9RnGUjwSxm2Yq2ttx500Gw
	 DkrQiwccbu0Ismz5ZgAGbrhJW3ssyY9WyEbY0lqOS78KJS0vp/mtSATlMKmsfzWJBjonn
	 PkAqY2hDU4G49eobSP+gjLLRM3p/roCCyiP3HF100g4k7qFnWajOvquHd2MxFVH49/bT8
	 egd2SeBnoUH8ye/VXrx3uqNwHm9HD7H/e53+1/eCkjfK+G5ILNyM+z9tF0Fy7S65faA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=dave.eu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795101655;
	bh=z8W2fslzbTRer8UG++44JDpf3PXk/eEKfX7VJByD1p8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwYqyNsWAjwPYb+kRi3xgxGInzEeiuRYQzFVwwFHYLRUhhsaAR9eEhKBDYn6Zbr6y
	 Rtk4FJg6PVdHKINrAsP10lZ9O4sru+mhRng8BFTIWnR0+87Kdi6sHzjP6BnViKtBFb
	 PO3uXQhNGlCeNxA0ui5OLeuuNeUlGz9mriW0jT8VfSrVQHgfdHDS4H27DLElQGaywI
	 66yKjLlG56/jAdFDbipOrkUhbiZBNIhNyIl1sKzVE/RaNWv5GClg9kC4vudok4wRlt
	 3Zy/Ag8L+f9sVp3Ceqp+PA0JsamaP+ABCgl9puLpmqHUkMs7I2ZNk6dEgRlka24+E/
	 FGSeqGBQbEklQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 372AA813F1;
	Thu, 19 Nov 2026 15:20:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 794122FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F70281371
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTR_MtvH5AR6 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8378081360
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=31.223.242.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=31.223.242.245;
 helo=mx.dave-tech.it; envelope-from=andrea.scian@dave.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=dave.eu
Received: from mx.dave-tech.it (mx.dave-tech.it [31.223.242.245])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8378081360
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:20:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [192.168.0.244])
 by mx.dave-tech.it (Postfix) with ESMTP id 9000320178;
 Thu, 19 Nov 2026 16:15:35 +0100 (CET)
From: Andrea Scian <andrea.scian@dave.eu>
Date: Thu, 19 Nov 2026 16:15:22 +0100
Subject: [PATCH 1/7] zynq: rsa: verify the SPK against the PPK from OCM
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-b4-zynq-rsa-v1-1-62ed5f983d1e@dave.eu>
References: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
In-Reply-To: <20261119-b4-zynq-rsa-v1-0-62ed5f983d1e@dave.eu>
To: Michal Simek <michal.simek@amd.com>, 
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andrea Scian <andrea.scian@dave.eu>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zynq_extract_ppk() reads the Primary Public Key from the FSBL that the
BootROM authenticated against the eFUSE PPK hash.
zynq_authenticate_part() then overwrote the same two pointers with the
PPK carried in the partition's own authentication certificate, and
verified the SPK signature with that.

The chain was self-signed: an image signed with any PSK/SSK pair,
carrying its own public keys in the certificate, is accepted on a part
with RSA_EN burned. Confirmed on hardware (XC7Z020, RSA_EN and PPK hash
burned).

Keep the OCM PPK in dedicated word-aligned buffers, filled by copy
rather than pointed at, require the certificate's PPK to match it and
verify the SPK against the OCM copy only.

Fixes: 37e3a36a5475 ("xilinx: zynq: Add support to secure images")
Signed-off-by: Andrea Scian <andrea.scian@dave.eu>
---
 board/xilinx/zynq/cmds.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index d8eff203a56..f63a3e55410 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -42,8 +42,18 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define WORD_LENGTH_SHIFT	2
 
-static u8 *ppkmodular;
-static u8 *ppkmodularex;
+/*
+ * Primary Public Key, copied out of the BootROM-authenticated FSBL in OCM by
+ * zynq_extract_ppk(). It is the root of trust for every partition this
+ * command verifies. It is a copy rather than a pointer into OCM, so that
+ * nothing a partition is later copied over can change it.
+ *
+ * zynq_calc_inv() and zynq_pow_mod() read the key as u32 words, and U-Boot
+ * runs with alignment checking enabled (SCTLR.A), so a u8 array that the
+ * linker happens to place off a word boundary would data-abort.
+ */
+static u8 ocm_ppk_modular[ZYNQ_RSA_MODULAR_SIZE] __aligned(4);
+static u8 ocm_ppk_modularex[ZYNQ_RSA_MODULAR_EXT_SIZE] __aligned(4);
 
 struct zynq_rsa_public_key {
 	uint len;		/* Length of modulus[] in number of u32 */
@@ -78,10 +88,9 @@ static void zynq_extract_ppk(u32 fsbl_len)
 
 	ppkptr += ZYNQ_RSA_MAGIC_WORD_SIZE;
 
-	ppkmodular = (u8 *)ppkptr;
+	memcpy(ocm_ppk_modular, ppkptr, ZYNQ_RSA_MODULAR_SIZE);
 	ppkptr += ZYNQ_RSA_MODULAR_SIZE;
-	ppkmodularex = (u8 *)ppkptr;
-	ppkptr += ZYNQ_RSA_MODULAR_EXT_SIZE;
+	memcpy(ocm_ppk_modularex, ppkptr, ZYNQ_RSA_MODULAR_EXT_SIZE);
 }
 
 /*
@@ -205,9 +214,19 @@ static int zynq_authenticate_part(u8 *buffer, u32 size)
 
 	signature_ptr += ZYNQ_RSA_MAGIC_WORD_SIZE;
 
-	ppkmodular = (u8 *)signature_ptr;
+	/*
+	 * The authentication certificate carries its own copy of the PPK,
+	 * which arrived with the image under verification. It must match the
+	 * PPK from OCM, and it is never the key the SPK is verified with:
+	 * that would make the chain self-signed.
+	 */
+	if (memcmp(signature_ptr, ocm_ppk_modular, ZYNQ_RSA_MODULAR_SIZE) ||
+	    memcmp(signature_ptr + ZYNQ_RSA_MODULAR_SIZE, ocm_ppk_modularex,
+		   ZYNQ_RSA_MODULAR_EXT_SIZE)) {
+		printf("PPK_MISMATCH\n");
+		return -1;
+	}
 	signature_ptr += ZYNQ_RSA_MODULAR_SIZE;
-	ppkmodularex = signature_ptr;
 	signature_ptr += ZYNQ_RSA_MODULAR_EXT_SIZE;
 	signature_ptr += ZYNQ_RSA_EXPO_SIZE;
 
@@ -223,8 +242,8 @@ static int zynq_authenticate_part(u8 *buffer, u32 size)
 	signature_ptr += ZYNQ_RSA_EXPO_SIZE;
 
 	public_key.len = ZYNQ_RSA_MODULAR_SIZE / sizeof(u32);
-	public_key.modulus = (u32 *)ppkmodular;
-	public_key.rr = (u32 *)ppkmodularex;
+	public_key.modulus = (u32 *)ocm_ppk_modular;
+	public_key.rr = (u32 *)ocm_ppk_modularex;
 	public_key.n0inv = zynq_calc_inv();
 
 	status = zynq_rsa_verify_key(&public_key, signature_ptr,

-- 
2.50.1

