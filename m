Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF45CCF9F0
	for <u-boot@archiver.kernel.org>; Sat,  1 Nov 2025 06:49:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A4D83AC5;
	Sat,  1 Nov 2025 07:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="dCvaZk+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEB083A27; Sat,  1 Nov 2025 07:49:29 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511B783AA7
 for <u-boot@lists.denx.de>; Sat,  1 Nov 2025 07:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9DE3F1097FE; Sat,  1 Nov 2025 07:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761979767; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=JC+yK1bjFxyFRFKtS+ni3akBkK7yMGPzZHAXJu5lrA8=;
 b=dCvaZk+2RHnKbSK0FQXlio96sogZTreYhG4qshFONvDBgfJf69UFaJq8sF7wFEHCssgAHC
 TghzblIu1WBOn1mtnLAK7iAk/70mgAPVGOlJnGpe7T+qKH5AScL08jimmKRANAWB2argPu
 h6VpGUyo1Dl4QTPkAkx8gCUE/Qxikuzau+9F7WiL/CGhyrobZfZMKEkvBho/gZF9DaDIc7
 yQIRUCyGy+nnVh3LAEvULMlBSgnJetdmS0Bg1Q562hqPblxXwZxtdsnjVo1KcullSiCV/v
 7z0yU3jTkh/8RRWZZ1eT/VZbpTO3J/hRvJ6YrmDDnnyHWSXdyUoKXSQH/Eo1IQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/5] tpm2: add sm3 256 hash support
Date: Sat,  1 Nov 2025 07:49:06 +0100
Message-Id: <20251101064907.5037-5-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20251101064907.5037-1-hs@nabladev.com>
References: <20251101064907.5037-1-hs@nabladev.com>
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

 cmd/tpm-v2.c     |  1 +
 include/tpm-v2.h | 12 ++++++++++++
 lib/tpm-v2.c     |  4 ++--
 3 files changed, 15 insertions(+), 2 deletions(-)

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
index 5b21c57ae42..0fea35e5ae0 100644
--- a/lib/tpm-v2.c
+++ b/lib/tpm-v2.c
@@ -686,10 +686,10 @@ int tpm2_get_pcr_info(struct udevice *dev, struct tpml_pcr_selection *pcrs)
 
 	pcrs->count = get_unaligned_be32(response);
 	/*
-	 * We only support 4 algorithms for now so check against that
+	 * We only support 5 algorithms for now so check against that
 	 * instead of TPM2_NUM_PCR_BANKS
 	 */
-	if (pcrs->count > 4 || pcrs->count < 1) {
+	if (pcrs->count > 5 || pcrs->count < 1) {
 		printf("%s: too many pcrs: %u\n", __func__, pcrs->count);
 		return -EMSGSIZE;
 	}
-- 
2.20.1

