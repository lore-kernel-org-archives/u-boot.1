Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0D4C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 21:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B361180BDB;
	Wed, 29 Jul 2026 21:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pq04p0F57JnV; Wed, 29 Jul 2026 21:52:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA8E380F5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785361940;
	bh=lyu+DFUDVAoC9QBD1QiDXC/B1UxHwJ+c5yzmWZo9kaE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z6wkiGPYzfpY2PT2kQdRpWTFhNXuoyjUny6u5ApwdRfJTOuyjDcvLLJ9le6tmQ9kz
	 CsYbAUTcOIUOoCFuWtIPvjRnYBs2BRMOXxUs+LW9DvyRJbwMNpvmGPkFC1oTaO51LG
	 GzmzK8pginRRqbXEfX6TBA4m5YJbNcxdqQDVhoCWKBWJergExj9zu3KxEjAAb0Yfyt
	 lAJ0I8hJFrpn7bNL6i95HNEyANIHKiy6x7zGX955igvZgiSCNh6ed1+gL9Yw6lzmje
	 NsFgBeDGHX7iNbY7df0Xz4QFJa/0UFwrs/3QyMcTukVea32egwAsWaxPhpTPvADWUM
	 JT1FQyIAxalqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA8E380F5D;
	Wed, 29 Jul 2026 21:52:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2581B28E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0307980ED9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FbHC4_mdtOYm for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 18:25:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E26B580A9B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E26B580A9B
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E26B580A9B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 18:25:37 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so133843966b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785349536; x=1785954336;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lyu+DFUDVAoC9QBD1QiDXC/B1UxHwJ+c5yzmWZo9kaE=;
 b=cj9rh2xBC6/htogUlsFOfUEaZQINBEXP4vlmA0I9V6o/VMSyff8Fjm3HQ+0MAZ96yb
 cFmsoYlmUt0kxga7FLmCtK0yLgCs6WT8vJbeyxQPszAbGEIZHqMj4ZRhZo1lJTMP2GoK
 JDqUONYtjCNhoIlABvr7556Eabv0S9rnBlc/J2Px4Ihc/XFji2kw0La+MN7fa8F5YwWH
 DqB6Spqm9PnM02aeyBHEBsF8SLeCF5tzviMDE7cdqLmrKyE9Lyfbf5EPX5fIm8BNlNYx
 WvAoHsUyMue54j2s33HkBslHtYuRvCistnE74KbA21cv6exORLVw33U/0ERIi5lMMjrj
 xL7A==
X-Gm-Message-State: AOJu0YxZzcb+0Xz04dWygiwSZE6DZ/prmbXl567BdMTuXcrCpvnlRLz7
 Z22FHDYR9z5KbIkfwyPxHDst7YRZkQrlkdjuzLVaNddIduMPbFFO881XJsVVWepHCiI=
X-Gm-Gg: AR+sD13PxHcugtysOCrhwC3Va63vReRXffL9cITy6eizX6Epi6DZd1X7VuthyZeWusj
 FXU2G4OrfVzcnCzFPmg4HMu7CVuVaWlrN1Hf75sHO00FKeT2jy8FCE/kClkxpBJa9q5pRrezSj+
 Txyx67K67EiZS8/Ng8KgNITo8iFbswAcTfDSBtMY7W0lmkQOh8k8vGqoIxSHTOL4SZHylsEg8k2
 BQ7cvu+GtcgqpVnJmE0ezs4qznl4pKQvjpsn+uUpSyPZSfVuRNY6uqUcilj0rgsJO8XDjGJKK3t
 6srNwFQWRossHamLNMsrJJ8W93DXI9abb06Pbr1xv97NKckImyPetfjUfAbvyf8EodB6aTXyuTM
 Hp42NDZZj3cHtYgAfRMFxWNisxN8xSlw4hPFKboGrCx0pxuovX9cZ2fSao2almJML1Nd35eB20m
 IzRZTIzifEARgv2xPNAjjHV02egXsivhuYU6eHMnHyfl7qAUGoqxgx6rWqA47ypUuo5Ed6ZthjK
 jIfqjiqjYyR6TaBvniBD4w+6U5ebbk2zqB1LBXZ1sraObyJVDa4SQ==
X-Received: by 2002:a17:907:a0c8:b0:c16:9ef6:b7da with SMTP id
 a640c23a62f3a-c1f727be1bdmr400516366b.59.1785349535850; 
 Wed, 29 Jul 2026 11:25:35 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f0047bee160d2cc76b5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:47be:e160:d2cc:76b5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83f4dd91sm145977866b.39.2026.07.29.11.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:25:35 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 29 Jul 2026 20:25:23 +0200
Subject: [PATCH v4 2/2] test: tpm: check malformed capability and OIAP
 responses are rejected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-tpm-trunc-resp-v4-2-5dd1a634ea4d@byteray.co.uk>
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
In-Reply-To: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Jul 2026 21:52:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785349536; x=1785954336;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lyu+DFUDVAoC9QBD1QiDXC/B1UxHwJ+c5yzmWZo9kaE=;
 b=m+36ZdDCY+vZtSDFcLHzJlMX119ej/uA7V8B0L9v6Lr/o/tGYeeqOr1T6Fr3Lwlujk
 glph++kICdjhsU5aE94cp2bQBLzPwg+p1iTXL5pjIdv4qmHX1wbuSUQGhPz7rq6/q/x5
 PjRbeoJhHquU2+g0cfSMMb7DGfZbjENRiTECzSH71gAgG7DDcM8zfUZ12OlF3JWoO8Kg
 7h+P1ryhtPh8T7uOhuAOO+FVfSNEkBBq4TS62t8P1P9k0fzCZxijPk7rjmdnBmpK7/y4
 ucrH2XH7RrD6LBteonbphCz2+HxExmrI5yfoMekogRFjWsTYkndAW/AzL5+TtUhKGCta
 LsHw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=m+36ZdDC
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

The length of a TPM reply comes from the device and cannot be trusted to
be well-formed. Add DM tests for the malformed replies that the length
checks reject.

For TPM2 GetCapability: one reply too short to hold its header, and one
advertising more data than the caller's buffer holds. The sandbox emulator
gains two test-only capability properties that produce them; the short
reply is caught by the length check in tpm_sendrecv_command(), the
over-long one by the caller's buffer bound.

For the TPM1 OIAP helpers tpm1_load_key2_oiap() and
tpm1_get_pub_key_oiap(): a reply too short to hold the auth trailer that
their length arithmetic subtracts. The emulator answers OIAP with a zeroed
session and both commands with a truncated reply, so the length check
rejects them before the subtraction underflows. These paths need
CONFIG_TPM_AUTH_SESSIONS, enabled here in the sandbox config.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 configs/sandbox_defconfig      |  1 +
 drivers/tpm/tpm2_tis_sandbox.c | 28 ++++++++++++++
 drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
 include/tpm-v2.h               | 10 +++++
 test/dm/tpm.c                  | 88 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 136 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..db26b6813de 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -394,6 +394,7 @@ CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
 CONFIG_TPM=y
+CONFIG_TPM_AUTH_SESSIONS=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_TEST_FDTDEC=y
diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index 50e308e7116..1fae0fc6ce1 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -542,6 +542,34 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 		property_count = get_unaligned_be32(sent);
 		sent += sizeof(property_count);
 
+		/*
+		 * Test hook: reply with a truncated (header-only) success
+		 * response so the response parser can be exercised against a
+		 * reply too short to hold the data it promises. Honoured for any
+		 * capability so the check can be tested on a path without a
+		 * capability-specific length bound.
+		 */
+		if (property == TPM2_PT_SANDBOX_SHORT_RESPONSE)
+			return sandbox_tpm2_fill_buf(recv, recv_len, tag,
+						     TPM2_RC_SUCCESS);
+
+		/*
+		 * Test hook: reply with a success response advertising more
+		 * property data than a single-property request can hold, to
+		 * exercise the caller-buffer bound in the parser.
+		 */
+		if (capability == TPM2_CAP_TPM_PROPERTIES &&
+		    property == TPM2_PT_SANDBOX_LONG_RESPONSE) {
+			*recv_len = TPM2_HDR_LEN + sizeof(u8) + sizeof(u32) +
+				    sizeof(u32) + TPM2_PROPERTY_NB *
+				    sizeof(struct tpms_tagged_property);
+			put_unaligned_be16(tag, recv);
+			put_unaligned_be32(*recv_len, recv + sizeof(tag));
+			put_unaligned_be32(TPM2_RC_SUCCESS,
+					   recv + sizeof(tag) + sizeof(u32));
+			return 0;
+		}
+
 		switch (capability) {
 		case TPM2_CAP_PCRS:
 			break;
diff --git a/drivers/tpm/tpm_tis_sandbox.c b/drivers/tpm/tpm_tis_sandbox.c
index d7341062b31..1f63e60cbaa 100644
--- a/drivers/tpm/tpm_tis_sandbox.c
+++ b/drivers/tpm/tpm_tis_sandbox.c
@@ -226,6 +226,15 @@ static int sandbox_tpm_xfer(struct udevice *dev, const uint8_t *sendbuf,
 		*recv_len = 12;
 		memset(recvbuf, '\0', *recv_len);
 		break;
+	case 0x0a: /* TPM_ORD_OIAP: hand out a zeroed auth session for tests */
+		*recv_len = TPM_HDR_LEN + sizeof(uint32_t) + 20;
+		memset(recvbuf, '\0', *recv_len);
+		break;
+	case 0x21: /* TPM_ORD_GetPubKey: truncated reply, for the length check */
+	case 0x41: /* TPM_ORD_LoadKey2: truncated reply, for the length check */
+		*recv_len = TPM_HDR_LEN;
+		memset(recvbuf, '\0', *recv_len);
+		break;
 	default:
 		printf("Unknown tpm command %02x\n", code);
 		return -ENOSYS;
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index 4f5082f2234..648dfa2aec8 100644
--- a/include/tpm-v2.h
+++ b/include/tpm-v2.h
@@ -43,6 +43,16 @@ struct udevice;
 #define TPM2_CAP_PCRS 0x00000005U
 #define TPM2_CAP_TPM_PROPERTIES 0x00000006U
 
+/*
+ * Sandbox emulator test hooks: a TPM2_GetCapability for these properties makes
+ * the emulated TPM reply with, respectively, a header-only response and one
+ * advertising more property data than a single-property request can hold. They
+ * let tests drive the response parser with a reply shorter or longer than the
+ * data it should carry, as a tampered or faulty TPM on the bus could.
+ */
+#define TPM2_PT_SANDBOX_SHORT_RESPONSE	0x00ffffff
+#define TPM2_PT_SANDBOX_LONG_RESPONSE	0x00fffffe
+
 /* Definition of (UINT32) TPM2_PT Constants */
 #define TPM2_PT_GROUP			(u32)(0x00000100)
 #define TPM2_PT_FIXED			(u32)(TPM2_PT_GROUP * 1)
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 87c5c416daa..eb6e55c3ab0 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -6,6 +6,8 @@
 
 #include <dm.h>
 #include <tpm_api.h>
+#include <tpm-v1.h>
+#include <tpm-v2.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -197,3 +199,89 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
+
+/*
+ * A TPM sits on a bus a physical attacker can reach, so its responses cannot be
+ * trusted to be well-formed. Check that a reply too short to hold its header is
+ * rejected by tpm_sendrecv_command(), rather than parsed with an underflowed
+ * length.
+ */
+static int dm_test_tpm2_get_capability_short(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[64];
+
+	ut_assertok(get_tpm_version(TPM_V2, &dev));
+	ut_assertok(tpm_auto_start(dev));
+
+	ut_assert(tpm2_get_capability(dev, TPM2_CAP_PCRS,
+				      TPM2_PT_SANDBOX_SHORT_RESPONSE, buf,
+				      sizeof(buf), 1));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm2_get_capability_short, UTF_SCAN_FDT);
+
+/*
+ * Check that a GetCapability reply larger than the caller's buffer is rejected,
+ * rather than copied past the end of it.
+ */
+static int dm_test_tpm2_get_capability_long(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[16];
+
+	ut_assertok(get_tpm_version(TPM_V2, &dev));
+	ut_assertok(tpm_auto_start(dev));
+
+	ut_assert(tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
+				      TPM2_PT_SANDBOX_LONG_RESPONSE, buf,
+				      sizeof(buf), 1));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm2_get_capability_long, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(TPM_AUTH_SESSIONS)
+/*
+ * A TPM1 OIAP reply carries an auth trailer that is subtracted from a
+ * device-controlled length. Check that a LoadKey2 reply too short to hold that
+ * trailer is rejected, rather than parsed with an underflowed length.
+ */
+static int dm_test_tpm1_load_key2_oiap_short(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 key[8] = {0};
+	u8 auth[20] = {0};
+	u32 handle;
+
+	ut_assertok(get_tpm_version(TPM_V1, &dev));
+	ut_assertok(tpm_init(dev));
+
+	ut_assert(tpm1_load_key2_oiap(dev, 0, key, sizeof(key), auth, &handle));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm1_load_key2_oiap_short, UTF_SCAN_FDT);
+
+/*
+ * The GetPubKey OIAP helper subtracts the same auth trailer from the same
+ * device-controlled length. Check that a reply too short to hold the trailer
+ * is rejected, rather than parsed with an underflowed length.
+ */
+static int dm_test_tpm1_get_pub_key_oiap_short(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 auth[20] = {0};
+	u8 pubkey[8] = {0};
+	size_t pubkey_len = sizeof(pubkey);
+
+	ut_assertok(get_tpm_version(TPM_V1, &dev));
+	ut_assertok(tpm_init(dev));
+
+	ut_assert(tpm1_get_pub_key_oiap(dev, 0, auth, pubkey, &pubkey_len));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm1_get_pub_key_oiap_short, UTF_SCAN_FDT);
+#endif

-- 
2.43.0

