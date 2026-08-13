Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A99CC5CFCF
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 16:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5011812CE;
	Thu, 13 Aug 2026 16:00:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ob_ox52ZTW3X; Thu, 13 Aug 2026 16:00:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AED71812B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636851;
	bh=iVBVz5DHPE4pwg8+nbBVpwKoTVuGQArg3Zv7tCeme7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0qjwrJkbFOPa3k9MEB5lkl1bTNz4SDXLUAmy/lAdy6yyCVnA7OVwpRBjmtWAoNs17
	 lNBTP//dZNMUqRfDp7GI7lDbp36zLgNPunzKTZQor5vc4D6RadAANV2i9LbxiIYC/Z
	 zaNVc/H6M6M5yLlicBNwi/ZP/4la2TjO5Jfm7iZ05kYtfCnNj2wbM7Gzmlt5IlgAGL
	 dLZ24LOZfL+38Lv5N7br1e6XnV6JGOxxd6un6wNtWeiXfbdyI/CDacg9j6Wd/9e24b
	 Im0w/rbkeVcZCtPs7f36THh4WkO6F7MjfP5fIRXCfmun/1FoyuvKb+8Humps3Oddys
	 H0iDUm5V+O8ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AED71812B7;
	Thu, 13 Aug 2026 16:00:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D98C388
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1FE24812A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyqGMn4UyAXU for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:58:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 03D7081285
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03D7081285
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03D7081285
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:58:55 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so3493377a12.2
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636734; x=1787241534;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iVBVz5DHPE4pwg8+nbBVpwKoTVuGQArg3Zv7tCeme7Q=;
 b=YksNtTR2rCFiFvKI7MnGNJjh/zO1UK9DWDPFIVw1cCMErOD8mdN4BWRP2cGJIBBw4c
 /jWjQahnRpwBauiEA9QZzDTjzfB1Px5+dxLkWJgmx2U83qgZhjzT7Ubmgq5a1ClUmRsi
 Qslh2Mr7P7Xluqn+MFrrRF2oZ0SBOB4Tq8uWgTA4UMhLXtKrQ2m4P9JYyAenyBiQPjAj
 z4o5GdOxJTVHlRFQ3pRquZUCSV4ALWmVuYlauVOEdnIXOdM+MzkCmTi+rOUljOysav76
 IDR0h0REdLpFN17nJ1mezO5ofihy0y3auwB/1I3//4VgabW+h0niv+FCzW71jOtsSmc7
 6+yg==
X-Gm-Message-State: AOJu0YyItr7h8QUB34yazDeM+fj2alE1ASynQXMvW7TKRJWD8d+9dx2e
 ikBSEZdpfceBjgcyF4yrwRD49z78qk6wwINkbt6lQtuDowY5TDDlcVn9ySdwh0FTMDA=
X-Gm-Gg: AR+sD13dPAT2RrkMhQQmJLA+b+rXKkn10ZiDpVD4cRQ+YjsmccavhvAEK/4buTcZyQ6
 pAE3DxtK+HYf9VOiw/eNKBDvQTe0b8/6Vn+hJf9Fh87t157T2+sceYE4ixAfw9ly8TGi2/U+nDR
 sQZVfn26J4RWMy8vNwAxk9y66hk0i3zN28Zl2/i0ltP86ZF9a05/S0S99UoUEz9+++gjVeRly4m
 Kt4SKBC6m4SDHcNuoSP3BbNb+D4qIs5S/VrzF8oPbxQpNpNCR6hIkCefi8SU9VG8+V7HHrj48KQ
 hb0mrF5WaO23KUxtTYZw3/JcdLTkn0ts27yXxZBD9f9I0+WGujKv+X8Jp4D0WewlOYXAY2WIziE
 7WWTX6DvTjeXEaoUcl0+fcO93iaBbxi7hEZAHcjhj7Q1zdfTaqREgPMoBlR/mo7dtHreINLrOz4
 WGMWCekgsLygIe69BGrkY26S0hCpy5jiylcZZcxxdfs/9zCMVWFvdf+qlDc403bnhDDZzf85K0Y
 qv5+H/TuFHmH1o13mvoUpkth+tUNSbR6r3Y9Orvi2GjtolmlvqK
X-Received: by 2002:a17:907:a48:b0:c0b:e9c1:93a7 with SMTP id
 a640c23a62f3a-c210904488fmr324902866b.29.1786636733683; 
 Thu, 13 Aug 2026 08:58:53 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21233a12e6sm9087366b.12.2026.08.13.08.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:58:53 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:58:44 +0200
Subject: [PATCH v5 2/2] test: tpm: check malformed capability and OIAP
 responses are rejected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-tpm-trunc-resp-v5-2-153b492a3256@byteray.co.uk>
References: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
In-Reply-To: <20260813-tpm-trunc-resp-v5-0-153b492a3256@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 16:00:48 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636734; x=1787241534;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iVBVz5DHPE4pwg8+nbBVpwKoTVuGQArg3Zv7tCeme7Q=;
 b=VqU6XPyoiNX+3ZJ9K06sDgSoygpgLqb+e2y0DXcTvk3QuEzCI4wXV8mkOBLBdO/dqv
 AjYKAMgCHbJZQLz62ZAHIvrEmp1TvsYqvZFtNJgzeMV93QV3LHAsAp+kOmVEah3PagZy
 FLKTvi5Jntmr9P1279Eze3WYF6AVWp+gSrMJ5/QsoQxCNGh62858isd0C5Aige3sG6Yn
 jcQFq66q8vkKEYhWl3yez3EsDGMS9rMGa7SWyu7pzVUeLoaxB3dzd/jLKADvY0sE6KQq
 vBVDFjuVxLeQrHlk+CvyGIQ7xNfyhgp2wH2I3mqRkSR6pfrIWDqMKk/zZSIr8FfjnjEz
 CLPw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=VqU6XPyo
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 configs/sandbox_defconfig      |  1 +
 drivers/tpm/sandbox_common.h   | 10 +++++
 drivers/tpm/tpm2_tis_sandbox.c | 28 +++++++++++++
 drivers/tpm/tpm_tis_sandbox.c  |  9 +++++
 test/dm/tpm.c                  | 89 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+)

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
diff --git a/drivers/tpm/sandbox_common.h b/drivers/tpm/sandbox_common.h
index f423c50ec50..c3f6e15703a 100644
--- a/drivers/tpm/sandbox_common.h
+++ b/drivers/tpm/sandbox_common.h
@@ -14,6 +14,16 @@
  */
 #define TPM_HDR_LEN	10
 
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
 /* These are the different non-volatile spaces that we emulate */
 enum sandbox_nv_space {
 	NV_SEQ_ENABLE_LOCKING,
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
diff --git a/test/dm/tpm.c b/test/dm/tpm.c
index 87c5c416daa..7fc58355739 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -6,9 +6,12 @@
 
 #include <dm.h>
 #include <tpm_api.h>
+#include <tpm-v1.h>
+#include <tpm-v2.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
+#include "../../drivers/tpm/sandbox_common.h"
 
 /*
  * get_tpm_version() - Get a TPM of the given version
@@ -197,3 +200,89 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
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

