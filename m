Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECFCC531F7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00F3960AB3;
	Thu, 23 Jul 2026 15:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D7b5EKBl3Lwf; Thu, 23 Jul 2026 15:14:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AB8C60AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819657;
	bh=56CRmjaFKDQph6IvlUzNeR0Qdv9RxIseWZmsNxiayXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SHEDz3TOGSKL0wd5ReAYWEy6BGmOhq8VyE0pBP2ckB8y+cXe6nCm9Iy6j3BQ7n3aw
	 KiG3yYMiMETGhL/JnSRTbLGuT0BGNW4iO7ZsOII0lFsgaIybfI+z+dvpSO8AVxwck+
	 a4p5TICl10uovYL0LiiS5MiZws/qxAraZVp4Xx3K9/hmmRgyNOp9o0bx+SyluYyyHb
	 whA+udUXUnOo/0KqykvGJ5gCHUxiyGT4pvELu7XVKpZCtCWu9YJzN0Doke6dq8D2FW
	 LVRrOAER6de9tjx/bLl03a9DYPBfl+v5N+12y66FatlbKMAIsjrmnpSHIsMybn8qTt
	 AwEM4SrceG3gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AB8C60AB7;
	Thu, 23 Jul 2026 15:14:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C0D6490
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 79ECD608F7
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BVhYs15ndFIg for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:01:46 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2C723608ED
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C723608ED
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C723608ED
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:01:46 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6986578d8c0so1094494a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815304; x=1785420104;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=56CRmjaFKDQph6IvlUzNeR0Qdv9RxIseWZmsNxiayXc=;
 b=L4riqf7JSKPWNtkT8jas0Wb7kdlt03iVqs/8GzxmyWGIOE8F9HRq+eQWhoyI14GUXk
 vk0MBQdZPL0BbDl8drV1HOXsaC5pBTR+gEla/uoi8AfeakNgRGnIPzKG2nQsJCBOFpwv
 591eo5rfclc4li/igGD3qB6JRFgiFsjhJf5X+BngScyW3no7HgBEibMojQMpVRd8OShe
 01+0pK2IsqE8dW1xvfw8Cqmc3bB/3EQriyWOhRgIY86EDeHxfvtfD94hlxuAdi6bneBr
 BIsZvsKy4HNMRTOyZwAqGQ27UbiDrdNLJa95Zh1c/ZiGkvIDOM8uBvhjZLUuROIypIin
 ztGQ==
X-Gm-Message-State: AOJu0YzA0Q8S4hPoY5q9HkBkoLW+ZBQa7Uc2heoPMQXWfY63yBy2PXrx
 RjUkgkS2l37ap78amGb0T0KsKLyKpfwUs6VdgH9SKDHpmfi4drNvhPERMCwGntnFx3Q=
X-Gm-Gg: AR+sD12tL27bjBq+FpMtQF56W9gNVXXJffu0PLluL4ghm7B84kUBV3VlJ8rEt5v++4V
 XtK3rT6yRY5ro0AD/cb6BEjU7vkz+jgj+vb+w61D+P1vB3r7S6aDXh4tQrZbBfaMChp4Sa03nyi
 lktPLHdjunBB1biG0mHkbbr3kLY4kc5ttTPnlUfruHdA/0COi/kfJ/wJOi9R71kR8OUDOtAfXM3
 tyzv1VqYq86YVzS4aQgRxltZgS5Wx2z4MPJ6VOL6yfDkohXkugfbNkT64dvWTL7jqj9ZdMzRfF/
 do9CpLlYFd8Fxi074MpjUX/sG/tBhrK6GFl4pyT6ROpu91BMeNBWKHF+trEiM0t5gU3B4IExmgZ
 elM+97oi1CFeAxTuSSSNENwUQB4217DRFDNmrcUn70B/QRRRid7z0w3PjI0TxBSiN/wu05N5v7B
 9P+22ph7H/4YzdstyfIP8MGDo4LH3kMmYp8p39aW9+9mqrL//NGZMqLU9gCqI4XDdk2wM0VJcjB
 +6NrA==
X-Received: by 2002:a05:6402:4289:b0:698:be4d:ca2a with SMTP id
 4fb4d7f45d1cf-69f69c69aa6mr1430240a12.15.1784815303944; 
 Thu, 23 Jul 2026 07:01:43 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2137178a12.4.2026.07.23.07.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:01:43 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Date: Thu, 23 Jul 2026 16:01:29 +0200
Subject: [PATCH 2/2] test: tpm: check malformed capability responses are
 rejected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-tpm-trunc-resp-v1-2-72a54ac30f4f@byteray.co.uk>
References: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
In-Reply-To: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Andy Fleming <afleming@freescale.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 15:13:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784815304; x=1785420104;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=56CRmjaFKDQph6IvlUzNeR0Qdv9RxIseWZmsNxiayXc=;
 b=shed1/1p+KLbPbHiA8DXou4LKAFllLfYbGUe/uLfh+P2+F4ikOhMwFrfiI0SmXCj/h
 Tk7phpazkpI1VnySRUZ60dM/IhOHqlaOSWtYMyw0g5ZG4w+sf9zrEhQ902GGPjOC7dfX
 kBB8J7b4uXgWrEiX4LHyfzPnNqUNuVh+vlNNyvfSr4MlCBYTU5OBMtabPvad7aaYmyx9
 8H2++dxK7quqZm36kD7nU7EJyPa47o566VlJUuWLgQgkfdZ7iulp9GPK8yR0ZHUKeCK9
 fYuCicHhfO7yd0XsKJ9U60EufdsiFPnzPyr9DqZ4YhqGRkLWgN62CA2QyXEK3+rtCggi
 442Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=shed1/1p
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
these replies, and two DM tests ask tpm2_get_capability() for them and
check the call is rejected instead of parsing past the end of the reply or
past the caller's buffer.

Signed-off-by: shj <shahriyar@byteray.co.uk>
---
 drivers/tpm/tpm2_tis_sandbox.c | 27 +++++++++++++++++++++++++++
 include/tpm-v2.h               | 10 ++++++++++
 test/dm/tpm.c                  | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/tpm/tpm2_tis_sandbox.c b/drivers/tpm/tpm2_tis_sandbox.c
index 50e308e7116..9205781fafc 100644
--- a/drivers/tpm/tpm2_tis_sandbox.c
+++ b/drivers/tpm/tpm2_tis_sandbox.c
@@ -542,6 +542,33 @@ static int sandbox_tpm2_xfer(struct udevice *dev, const u8 *sendbuf,
 		property_count = get_unaligned_be32(sent);
 		sent += sizeof(property_count);
 
+		/*
+		 * Test hook: reply with a truncated (header-only) success
+		 * response so the response parser can be exercised against a
+		 * reply too short to hold the data it promises.
+		 */
+		if (capability == TPM2_CAP_TPM_PROPERTIES &&
+		    property == TPM2_PT_SANDBOX_SHORT_RESPONSE)
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
index 87c5c416daa..a8645cd1601 100644
--- a/test/dm/tpm.c
+++ b/test/dm/tpm.c
@@ -6,6 +6,7 @@
 
 #include <dm.h>
 #include <tpm_api.h>
+#include <tpm-v2.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -197,3 +198,43 @@ static int dm_test_tpm_autostart_reinit(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_tpm_autostart_reinit, UTF_SCAN_FDT);
+
+/*
+ * A TPM sits on a bus a physical attacker can reach, so its responses cannot be
+ * trusted to be well-formed. Check that a GetCapability reply too short to hold
+ * the data it advertises is rejected, rather than parsed with an underflowed
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
+	ut_assert(tpm2_get_capability(dev, TPM2_CAP_TPM_PROPERTIES,
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

