Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D0C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9332D60895;
	Tue, 28 Jul 2026 13:00:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IJXgOVrHyXBJ; Tue, 28 Jul 2026 13:00:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29F79608D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243606;
	bh=kZk9+drPI6jUBWnA4HnSkTBoJtWv8b3psNucIeVDCxU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1Dr6f/z+AXLrD11Sq4N/q6mXe9+Io8GxNhC7qBlQKfT2xmHxISpF3F+MrghjXNPLE
	 u5djbK/+50zRKQQVr66+lGi/iX0+DgRYZ2ElxaFrc069wwjpC4qhGQXQBVOVx3jGka
	 +Ufy9nPhy0m0b9mqsFI3f4tGUFsvM7RvymObXpPru4iI02UKE87CpUi2U/I/JBUTRt
	 KcgqrCwIsuX0r4LTRGHhLJ+qK1QH71SbxpV9+7HzADr3jpqzyFoD3sH9ds32If1jqz
	 YMeKyop43U3Wk+oyGe/XBFfAWsdnTOWEyq3hXVrZ34556EabWxwpzgjn2RdY2vDOZ0
	 0y/RiQwc7RnAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F79608D9;
	Tue, 28 Jul 2026 13:00:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52B8036E
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39002607F3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sbrhcoRj5KGt for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 07:38:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 42EE5607AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42EE5607AD
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 42EE5607AD
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 07:38:11 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69fc856b00eso2668493a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 00:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224289; x=1785829089;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kZk9+drPI6jUBWnA4HnSkTBoJtWv8b3psNucIeVDCxU=;
 b=r0XZY4+oNkfzZC99Xq46c9bh7OD3yADTFHQ/52fZfw7KFDOqYzucUkP9e38TQVytMp
 QW51cPZAHHajU/JTHKxR4205SSGMJG5FOC/z4JAO35PSwjpk8bloDLX7LxQPXjFQmyTl
 zU695ozqSLYYH92JfXBIn/Dw66Vpt7UfrXphFyMwCVuNWhk4aSl99BcBMrCPjYlPT1kK
 jb7cs0rgp0j4AWDAQ8PskAedb8hhZUwQzIbCsupUV+ytvoEeMHKjBm7loOYCwvURrNte
 B3QGfCmBjAtMjUBAd6A55nJb0HGk6uwB+Ml1Pek0lcAloo34nz/8rSkOP6d9IXO2fJVZ
 /oKQ==
X-Gm-Message-State: AOJu0YzMqzc5VR1U0rwDGNBra/Ac5ZZ2dXKygAjeEuWBOBfxGTO9EuWW
 AcB0g9skxC/XYQukDVrEdDpNLzegQDeDCeEk/B1czXuxD+Ujq70k4aYCkYLBcSYE08o=
X-Gm-Gg: AR+sD12Cw6bILXJ1Ie7zuvh6YETtXe+YzXw6Bn69/O84I8qrYoAxN6WXIdg3OuenP9g
 HlKGm6PPlrGYMAkMMwYAA/amoMNqdYe/9kBN83YBNiFCYInbIqSetdpjm74Gs1L5VHeu7MNPWlC
 n7ygXQz9mxPyt87zTfzw/2f8kJ3lI9D0Snb/ZFPqKJg4/OkwmF2hGIshpZS78Bz9kE7o4CGcEs8
 6KWi170DP5Cz+xNgj5VuqSnFFr08VePJWSyOc/o5zO5JdNXmES0I9lwD4Hd1GdQ0Vr2kmIOXqvd
 vUOHPD91E+1gtJtQ/Te4mRu1kqJh/RnX7NIgOj69yeEd61+aCpidZGTzNS4okj4fBnjURZ8Oxcn
 1lL9WOhyNaWjurZl38KUCkKOGgQ3tPa8jtAen7+OK40yjLHXjubAts9FG3jXNUcc4s/eyVRxyxu
 0JAStj5FBU2+sSa0pYjqIHQUAk/htC21IFCOEIYaIJXheXA19OYJa58NrnQSMAtit2uqQ=
X-Received: by 2002:a05:6402:280f:b0:699:8397:55ec with SMTP id
 4fb4d7f45d1cf-6a0349bc5f1mr516359a12.7.1785224288884; 
 Tue, 28 Jul 2026 00:38:08 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb50bcfdcsm3654045a12.3.2026.07.28.00.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 00:38:08 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 09:37:54 +0200
Subject: [PATCH v3 2/2] test: tpm: check malformed capability responses are
 rejected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-tpm-trunc-resp-v3-2-8e20bcfb64c5@byteray.co.uk>
References: <20260728-tpm-trunc-resp-v3-0-8e20bcfb64c5@byteray.co.uk>
In-Reply-To: <20260728-tpm-trunc-resp-v3-0-8e20bcfb64c5@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785224289; x=1785829089;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kZk9+drPI6jUBWnA4HnSkTBoJtWv8b3psNucIeVDCxU=;
 b=qxka1XN6aL3td5SlhwQN979rx7pGO7WFRAVY75KAEr0U+9DL8gLkktt/b8hjqcBByr
 MPGEuvK7xn5zx170Rs4kbykyKwo/xyd7TqHigoEbK6clURU0/prLJGSpxShrXDSKX4+D
 8Sb1tjwce13oOvdhixSXClgEAGQxo0DRiv6uD1M4gwBiKDanmfij8FI+L13FqsMba2a6
 ubJt3zJs4G3t5Sh8bVaPlUpNS0TriyDuDueCm2Xg3tpqSkB83uZTAha9uOgThSNAr8CM
 fdvRrL1jzXwWPbBPoKuqpEhiwTl1jM6Z4B3Y5S6WPDJ6JsntPzNracuj8akDZRomBkHG
 2X/A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qxka1XN6
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
be well-formed. Add tests for two malformed replies: one too short to hold
the data it advertises, and one advertising more data than the request can
hold. The sandbox TPM emulator gains two test-only properties that produce
these replies. One DM test drives a PCRS query with the truncated reply, so
the only thing rejecting it is the length check in tpm_sendrecv_command();
the other drives a properties query with the over-long reply, caught by the
capability-specific buffer bound.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 drivers/tpm/tpm2_tis_sandbox.c | 28 ++++++++++++++++++++++++++++
 include/tpm-v2.h               | 10 ++++++++++
 test/dm/tpm.c                  | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

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
diff --git a/include/tpm-v2.h b/include/tpm-v2.h
index a776d24d71f..8bcc4caeb06 100644
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
index 87c5c416daa..45690dc56b3 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -6,6 +6,7 @@
 
 #include <dm.h>
 #include <tpm_api.h>
+#include <tpm-v2.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -197,3 +198,44 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
+
+/*
+ * A TPM sits on a bus a physical attacker can reach, so its responses cannot be
+ * trusted to be well-formed. Check that a reply too short to hold the data it
+ * advertises is rejected, rather than parsed with an underflowed length. A PCRS
+ * query is used so the only thing guarding the copy is the length check in
+ * tpm_sendrecv_command() (the properties query has its own extra bound).
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
+				      TPM2_PT_SANDBOX_SHORT_RESPONSE, buf, 1));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm2_get_capability_short, UTF_SCAN_FDT);
+
+/*
+ * Check that a GetCapability reply advertising more data than was requested is
+ * rejected, rather than copied past the end of the caller's buffer.
+ */
+static int dm_test_tpm2_get_capability_long(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	u8 buf[64];
+
+	ut_assertok(get_tpm_version(TPM_V2, &dev));
+	ut_assertok(tpm_auto_start(dev));
+
+	ut_assert(tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
+				      TPM2_PT_SANDBOX_LONG_RESPONSE, buf, 1));
+
+	return 0;
+}
+DM_TEST(dm_test_tpm2_get_capability_long, UTF_SCAN_FDT);

-- 
2.43.0

