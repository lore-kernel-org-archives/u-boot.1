Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7447ACCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 05:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C4DF83B23;
	Tue, 11 Nov 2025 06:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="PhZuA72x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8107183B1B; Tue, 11 Nov 2025 06:48:45 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B2983AEC
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 06:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8306710A4E8; Tue, 11 Nov 2025 06:48:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1762840121; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=wWItPzadFt140VH90PDFlCtYi3zrc0JDqnWVp0QqZIw=;
 b=PhZuA72x5gb0Mc3KTBUXFnN+bVDX6xZO/MFUpSl9jiF7rrmNgFJ1XdfTEG6wGQI4dIU6sY
 DD+0aP0vT5kShbeqIApobvCdu8BjRia71QXhg/GDRx4jFNe9YOoDY5jOFsbG6On2YcwfmM
 jkDpwByinMKMcClcfltyHk+9ffq7SlDreYx+RgMRVGsydg8O6eom+5d88kjtIDVnS0wq1K
 7UfRtE17qkg0Hkms+m+SL3l4dWykt0r1Aik9UrW5Zy785boaKr96JUqL1PXVm/OiD8fya3
 MCDvt/xUepVgO1kwYghBZEkg/SBXyBI1NV0HubEQvkvbUK3d7fUXB4ws+XqicA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] tpm2: add sm3 256 hash support
Date: Tue, 11 Nov 2025 06:48:11 +0100
Message-Id: <20251111054813.1966-5-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251111054813.1966-1-hs@nabladev.com>
References: <20251111054813.1966-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

add sm3 256 hash support, so TPM2 chips which report
5 pcrs with sm3 hash do not fail with:

  u-boot=> tpm2 autostart
  tpm2_get_pcr_info: too many pcrs: 5
  Error: -90

Signed-off-by: Heiko Schocher <hs@nabladev.com>

---

Changes in v2:
add comments from Ilias
- use ARRAY_SIZE(hash_algo_list) instead of a fix number
  in tpm2_get_pcr_info() for the count of supported hashes
  in U-Boot.
- add SM3 hash in tpm_tcg2

 cmd/tpm-v2.c     |  1 +
 include/tpm-v2.h | 12 ++++++++++++
 lib/tpm-v2.c     |  4 ++--
 lib/tpm_tcg2.c   |  9 +++++++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/cmd/tpm-v2.c b/cmd/tpm-v2.c
index 346e21d27bb..847b2691581 100644
--- a/cmd/tpm-v2.c
+++ b/cmd/tpm-v2.c
@@ -589,6 +589,7 @@ U_BOOT_CMD(tpm2, CONFIG_SYS_MAXARGS, 1, do_tpm, "Issue a TPMv2.x command",
 "        * sha256\n"
 "        * sha384\n"
 "        * sha512\n"
+"        * sm3_256\n"
 "    <on|off> is one of:\n"
 "        * on  - Select all available PCRs associated with the specified\n"
 "                algorithm (bank)\n"
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index f3eb2ef5643..a776d24d71f 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -345,6 +345,18 @@ static const struct digest_info hash_algo_list[] = {
 		false,
 #endif
 	},
+	{
+		"sm3_256",
+		TPM2_ALG_SM3_256,
+		TCG2_BOOT_HASH_ALG_SM3_256,
+		TPM2_SM3_256_DIGEST_SIZE,
+#if IS_ENABLED(CONFIG_SM3)
+		true,
+#else
+		false,
+#endif
+	},
+
 };
 
 /* NV index attributes */
diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
index 5b21c57ae42..f443b738f82 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -686,10 +686,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 
 	pcrs->count = get_unaligned_be32(response);
 	/*
-	 * We only support 4 algorithms for now so check against that
+	 * check against the supported algorithms in hash_algo_list,
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs->count > 4 || pcrs->count < 1) {
+	if (pcrs->count > ARRAY_SIZE(hash_algo_list) || pcrs->count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index c314b401d0b..d41228f75a9 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -12,6 +12,7 @@
 #include <u-boot/sha1.h>
 #include <u-boot/sha256.h>
 #include <u-boot/sha512.h>
+#include <u-boot/sm3.h>
 #include <version_string.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
@@ -143,6 +144,12 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
 			sha512_finish(&ctx_512, final);
 			len = TPM2_SHA512_DIGEST_SIZE;
 			break;
+#endif
+#if IS_ENABLED(CONFIG_SM3)
+		case TPM2_ALG_SM3_256:
+			sm3_hash(input, length, final);
+			len = TPM2_SM3_256_DIGEST_SIZE;
+			break;
 #endif
 		default:
 			printf("%s: unsupported algorithm %x\n", __func__,
@@ -319,6 +326,7 @@ static int tcg2_replay_eventlog(struct tcg2_event_log *elog,
 			case TPM2_ALG_SHA256:
 			case TPM2_ALG_SHA384:
 			case TPM2_ALG_SHA512:
+			case TPM2_ALG_SM3_256:
 				len = tpm2_algorithm_to_len(algo);
 				break;
 			default:
@@ -431,6 +439,7 @@ static int tcg2_log_parse(struct udevice *dev, struct tcg2_event_log *elog,
 		case TPM2_ALG_SHA256:
 		case TPM2_ALG_SHA384:
 		case TPM2_ALG_SHA512:
+		case TPM2_ALG_SM3_256:
 			len = get_unaligned_le16(&event->digest_sizes[i].digest_size);
 			if (tpm2_algorithm_to_len(algo) != len) {
 				log_err("EventLog invalid algorithm length\n");
-- 
2.20.1

