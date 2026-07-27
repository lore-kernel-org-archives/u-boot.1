Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429FCC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:14:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5680440782;
	Mon, 27 Jul 2026 17:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwRP2WZmuQqh; Mon, 27 Jul 2026 17:14:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 21A3740741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785172473;
	bh=5c5DW8N4lYtV1DC72gjA6aNx+LydmqV4F4qLGmGR90Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cRdKV42dEzvRfUt4k4hTa5ETTc1oXEwwMd92R1rhrzgVL21mL8SKE48yjDNWNpW+T
	 IOOvt/XQgCF2zEzcrIZBQngQxD2beH1BaXYSTPjeLfgfPFPw4RLyiBrBeAOg1xaj4k
	 ypTCIEX01ADqB7N2dISH3RH9r5WGQm/IpGroQsCAuO72KqO0gaHukTilZ8udpFH+RC
	 WLxatRycwYBz4hAIdFJmo+KjK+jZzZEJA2rMPOa3p+bjyn2lOClHbmO1ZWhtepTR1v
	 e5lRAWx0SyxkUnGHInaESqzU8vltHHhTY74wM8l/LHTLh8vGfgOP/A1H85F9uOtEja
	 ch45gMhJ50+7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21A3740741;
	Mon, 27 Jul 2026 17:14:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCCEB350
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD934400AC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqijYYbV2ooo for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:14:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B31AC40055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B31AC40055
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B31AC40055
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:14:28 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3021962f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172466; x=1785777266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5c5DW8N4lYtV1DC72gjA6aNx+LydmqV4F4qLGmGR90Y=;
 b=A4pnNzbSC7wODDEcFVD7hY+hCwrcJgcJu44tDxuygLKUA96mQUBwQ2LNrnElzT4rHu
 cQZ3qRF3y3HCWcETEgpZuZIsAC1r/GzqUOJ6x/GFPYerf1N7qxtkuzyCyq81zbqrOdge
 N1cXWV7fhWpPLL72rFBTCtY3TyN5Ub3ib/vtxqqWRp11HyPqPTGHpB7Undx9aDj5EDSv
 WYit7e9w1eKeCuyBctCX/QdraGE9U5aUGKhYP+1kMSLLc1WmHHK7lXc98Ptg4BvQxPZR
 z3KnzHezXbHbzBOD2m6kKTLvFzhpqcirQzop+fsa0VlNsdTZI4AjvAUX9zOJmTTZcppu
 TrxA==
X-Gm-Message-State: AOJu0YyPDlNH5Gp9DLeRyc7K4B3X+JOnuRHGomjcQFavIjVYDNSAgsKh
 C59KJFxVRAyyc6aRYo0eA43F4WFJOhVwAWkloG5GntaLX5eca2YNWbvW
X-Gm-Gg: AR+sD12GOE9EAnRrAYOR4lBD7J1DbT3E2IXp+uT0/L8N8bcxFmDaHyjLmwCzadecF+H
 9jnvyslkyN7Th/B8Q8Ju0KVSN8kx6hbji3rf/sNvhNDcg1ZVuHR+H7myhN0iw1rDEJTF8SzxjUP
 bx+S7bpX6ZFw8fYFFkaX6lGfxf2x+D7JBIoFwZcgEHe+NL2Oo4/ZR+Q7KtnEYE1K2RZYmHRHaxt
 sHv9orQ1QKzChsZ5SaILo6GAbWwYKCnO5MaBdBy/QSS7+V792vVpsEsuAsRnoTIdd//Z7d0gCHK
 sOQZT0EYZdQm+Dv6JLrIXgyKXvyWIWazLVp9PVOpnt1BwsKsYLpRKz9OD5mCP/HGQO+cmoon59v
 AhYPo5HXgTbuBz1jTHh2zln+HcnUz6MAyd4ChadmfvOHP5qk1+MxHVKiKJuOjS1HGCxjuaSaLrq
 XFDtVQ13rpLidYy/zFWSwXuzAFrE1i/1RABfSaG4Z9fagoZAdHyrJp9CcRx91SroVF41s9Hw==
X-Received: by 2002:adf:e198:0:b0:47f:93a1:1126 with SMTP id
 ffacd0b85a97d-47f9feb5dd0mr12380128f8f.61.1785172466469; 
 Mon, 27 Jul 2026 10:14:26 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm55287391f8f.7.2026.07.27.10.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 10:14:26 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 27 Jul 2026 19:14:13 +0200
Subject: [PATCH 1/4] avb: make the AVB root key source pluggable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-avb-root-key-pluggable-v1-1-7e27b2b92cc0@gmail.com>
References: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
In-Reply-To: <20260727-avb-root-key-pluggable-v1-0-7e27b2b92cc0@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785172466; x=1785777266;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5c5DW8N4lYtV1DC72gjA6aNx+LydmqV4F4qLGmGR90Y=;
 b=JIBtqrJEXhbIKlrvpS86SBNxM0kXfhXhqn3g4aCLB+82NXGjdVX6GYw/kPmau4/knS
 97mHF0Me0mfXl/FIL0ArOjEAvNHM9tyf6cxZ2Nv9VIWKNQkifajGzBlADGo3YNlEzhLh
 fremEZqqgiV2tJZ9hNRqcgbS0hJEfNBH4NbWjWZ93AcfjWCnrZDkcF9QlKHb4cVt4rMl
 zNOwxOHiLcAGHFQd2CWqUABrUhYEkVQXYMB/Z+kOnZTujxDQZ+xEeUZO71U2mavBY9pA
 02UmDpItND8BFmrnYvfvrKsf+V3Ga9Xqsy02EJ7PKJ/v1ldo5BE7XC3y0ZZxPKy8MC8Y
 59Yg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JIBtqrJE
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

AVB's whole chain of trust reduces to a single public key, and that key is
currently hard-coded in U-Boot as the AVB reference/test key, whose private
half is public. That is fine for bring-up but unusable for a locked
product, which must anchor its root of trust in something an attacker
cannot swap out -- a hash fused into the SoC, a secure element -- rather
than a blob compiled into the bootloader.

Make the source of the trusted key digest selectable so a board can decide
where its root of trust lives, without touching the verification logic and
with any lookup failure treated as untrusted. The built-in key remains the
default, so existing users are unaffected; the sources a production device
actually needs are added in the following patches.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 common/Kconfig       | 18 ++++++++++++++++++
 common/avb_verify.c  | 36 +++++++++++++++++++++++++++++++++---
 include/avb_verify.h | 19 +++++++++++++++++++
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 345be4b8ca1..654e78b7b7a 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -881,6 +881,7 @@ config AVB_VERIFY
 	depends on MMC
 	depends on PARTITION_UUIDS
 	depends on FASTBOOT
+	select SHA256
 	help
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
@@ -904,6 +905,23 @@ config AVB_BUF_SIZE
 	  AVB requires a buffer for memory transactions. This variable defines the
 	  buffer size.
 
+choice
+	prompt "Source of the trusted AVB root public key"
+	default AVB_ROOT_KEY_BUILTIN
+	help
+	  Selects where validate_vbmeta_public_key() obtains the trusted root
+	  key digest that the vbmeta signing key is compared against. This is
+	  the root of trust for the whole AVB chain.
+
+config AVB_ROOT_KEY_BUILTIN
+	bool "Built-in key hard-coded in avb_verify.c"
+	help
+	  Use the avb_root_pub[] blob compiled into U-Boot. By default this is
+	  the AVB reference/test key and is intended for development only;
+	  replace the blob for production use.
+
+endchoice
+
 endif # AVB_VERIFY
 
 config SCP03
diff --git a/common/avb_verify.c b/common/avb_verify.c
index 76c523fd0ba..7c6baa33ed8 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -11,7 +11,9 @@
 #include <part.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
+#include <u-boot/sha256.h>
 
+#if CONFIG_IS_ENABLED(AVB_ROOT_KEY_BUILTIN)
 static const unsigned char avb_root_pub[1032] = {
 	0x0, 0x0, 0x10, 0x0, 0x55, 0xd9, 0x4, 0xad, 0xd8, 0x4,
 	0xaf, 0xe3, 0xd3, 0x84, 0x6c, 0x7e, 0xd, 0x89, 0x3d, 0xc2,
@@ -118,6 +120,7 @@ static const unsigned char avb_root_pub[1032] = {
 	0xe1, 0x74, 0xa1, 0xa3, 0x99, 0xa0, 0x85, 0x9e, 0xf1, 0xac,
 	0xd8, 0x7e,
 };
+#endif /* AVB_ROOT_KEY_BUILTIN */
 
 const char *str_avb_io_error(AvbIOResult res)
 {
@@ -654,14 +657,26 @@ static AvbIOResult validate_vbmeta_public_key(AvbOps *ops,
 					      public_key_metadata_length,
 					      bool *out_key_is_trusted)
 {
+	u8 key_digest[SHA256_SUM_LEN];
+	u8 trusted_digest[SHA256_SUM_LEN];
+	AvbIOResult rc;
+
 	if (!public_key_length || !public_key_data || !out_key_is_trusted)
 		return AVB_IO_RESULT_ERROR_IO;
 
+	/* Default deny: only flip to trusted on a positive digest match. */
 	*out_key_is_trusted = false;
-	if (public_key_length != sizeof(avb_root_pub))
-		return AVB_IO_RESULT_ERROR_IO;
 
-	if (memcmp(avb_root_pub, public_key_data, public_key_length) == 0)
+	/* Digest of the key embedded in the (untrusted) vbmeta. */
+	sha256_csum_wd(public_key_data, public_key_length, key_digest,
+		       CHUNKSZ_SHA256);
+
+	/* Digest of the trusted root key from the configured source. */
+	rc = avb_read_root_key_digest(ops, trusted_digest);
+	if (rc != AVB_IO_RESULT_OK)
+		return rc;
+
+	if (avb_safe_memcmp(key_digest, trusted_digest, sizeof(key_digest)) == 0)
 		*out_key_is_trusted = true;
 
 	return AVB_IO_RESULT_OK;
@@ -1040,6 +1055,21 @@ free_name:
 }
 #endif
 
+/**
+ * ============================================================================
+ * AVB root key digest providers (selected via CONFIG_AVB_ROOT_KEY_*)
+ * ============================================================================
+ */
+#if CONFIG_IS_ENABLED(AVB_ROOT_KEY_BUILTIN)
+AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
+{
+	sha256_csum_wd(avb_root_pub, sizeof(avb_root_pub), digest,
+		       CHUNKSZ_SHA256);
+
+	return AVB_IO_RESULT_OK;
+}
+#endif
+
 /**
  * ============================================================================
  * AVB2.0 AvbOps alloc/initialisation/free
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 5d998b5a302..66655aab871 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -47,6 +47,25 @@ enum mmc_io_type {
 AvbOps *avb_ops_alloc(int boot_device);
 void avb_ops_free(AvbOps *ops);
 
+/**
+ * avb_read_root_key_digest() - get the SHA-256 digest of the trusted AVB
+ * root public key
+ *
+ * This is the root of trust for AVB: validate_vbmeta_public_key() hashes the
+ * key embedded in the (untrusted) vbmeta and compares it against the digest
+ * returned here. The provider is selected via CONFIG_AVB_ROOT_KEY_* and, for
+ * CONFIG_AVB_ROOT_KEY_BOARD, may be overridden by a SoC/board specific strong
+ * definition (e.g. reading a hash fused into OTP).
+ *
+ * @ops: AvbOps, contains AVB ops handlers (needed by the TEE provider)
+ * @digest: output buffer of AVB_SHA256_DIGEST_SIZE bytes
+ *
+ * @return:
+ *      AVB_IO_RESULT_OK on success (@digest populated)
+ *      any other AvbIOResult fails verification closed (key not trusted)
+ */
+AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest);
+
 char *avb_set_state(AvbOps *ops, enum avb_boot_state boot_state);
 char *avb_set_enforce_verity(const char *cmdline);
 char *avb_set_ignore_corruption(const char *cmdline);

-- 
2.53.0

