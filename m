Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DDFC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9D0460BB6;
	Fri, 24 Jul 2026 14:02:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGHfrQ06AHSM; Fri, 24 Jul 2026 14:02:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0508860B8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901743;
	bh=q7zHv394E9nx6mkv5gWVNdySr57tA2lRupy3PKZajfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hMWjfNne1NfYX3xT9rbEG5jBOcDMxphSoJ8jE5MV8WS2z/H6UKEtNqeDXW+r5VrIi
	 S5sm1TZ4THEQZOMRLkRTKqbo+C4h1/mnE/wSIp8zmw6XWoLezBHs6mVBgEDSsawlVO
	 KreSciHXJr91cSDPSMe59lDHhQLdK4UXy/csmv62LRea47lxWSG/utSkEAiRuZcud3
	 Ofp4fUCdi5pE2T3S4QKmNdns3JtRi+884psx3em5p2aHNCbiVuqMlE9EBUwn9okECf
	 tscRbexvEzL+XT+SBYzcd8QZbigcSl3G177IcTiynrrZ8TY/GegD0w7BcyeEw6UGkt
	 vQnQJydmreMgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0508860B8B;
	Fri, 24 Jul 2026 14:02:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3988B347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A88D80972
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pWrMIw9BsKu0 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:34:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 09F5A80744
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 09F5A80744
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 09F5A80744
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:34:28 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15f020a223so39567566b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889267; x=1785494067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q7zHv394E9nx6mkv5gWVNdySr57tA2lRupy3PKZajfA=;
 b=KRJSuhHS992Wqh5ao3bCA2OuwY4wSxFSssz/NY3tX3RmDHv+XxJBy+f2STIqP8ncoF
 9PJarEEv18vYtfL94MoZ73MVKXtYHiSU4go0BLNLOe2snBsAfDM103d+BU6mpZkKAnTH
 2RG2O1sBGjWETmvoMZeMxPrCFcNFpFK+JRNaOZq3eKzXUg6MnReyrQrHfLYBr6adMOg6
 EEPDoUXlZHJmQtYI79/2Y7lYS5hOHfRa1zXNMqrOIaGsmFaUORcYYCTumXWePpveWvJn
 15y/tFZd7vv+/lz0smRTPAsnqqZK4pjLrmUDjUmyN3HEMfQ8nOZI7E6p8LfaFBebadwI
 FeHA==
X-Gm-Message-State: AOJu0YzQfqsFoMiObx7ujABlQ7XGdjNM4iF9+VaoHB86Vr4xhNWh0Sso
 W1S5100hshGbq+nCwglYEPtxiyyCraTYjNITDPEg/FyyDHS+ruv11CJFTJRGC+2IYc9L1b4WmvX
 fYNbbpyo=
X-Gm-Gg: AR+sD13FnbDPNBtShLIbDeozWUbL5vqqwZvKZ09PjKq/WrxPjSynv4fvQd7oAMoqz6T
 7N++84AtNpBd65w8j3CExfGJ/kzBe4asYpSiaEBV/n7YQI8X1OmlWBuLAIeXCswC1bNBr6Dbcyp
 t+E51ZKJIlc5CK9ZtYlUOvXW/QCxZFkFtui7VOpzJbbvQWVlgQ4W8AwiIQ3IXvGC050KTd+jLqa
 aGp5SbwOAB6v3Nlvfyggzrec39D1v2wDtBcD128jnoHY5PLiuqLdRne2F2xAzcmkjNBjLLf42M8
 LbxDT5CWF9I7ihKXuJmBK7Senv7pE7yQJrgL+qy459fyi4v1z83nkoxdggX8cLDlcLfDugUQ/Sn
 FFpGjBLmC1tocojtWIvOCVjSZP1cu7i/FTkApYU99FqrBA/MXTNQUDthrxeRDp54Fapz/u0Qj6+
 k4priLQh7oM1FzjGMN0GUUG7Au9lJMDuAdgYwUlxZAB3TrSRYm8IhhkN4XJHeMbWzlvKo=
X-Received: by 2002:a17:907:1c94:b0:c1c:200e:ecfc with SMTP id
 a640c23a62f3a-c1c50d95dc3mr317331866b.58.1784889266889; 
 Fri, 24 Jul 2026 03:34:26 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0011f41ca2fcfee2bf.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:11f4:1ca2:fcfe:e2bf])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69f345b1decsm2957563a12.4.2026.07.24.03.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:34:26 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Fri, 24 Jul 2026 12:34:15 +0200
Subject: [PATCH v2 2/2] test: tpm: check malformed capability responses are
 rejected
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-tpm-trunc-resp-v2-2-381857e959f6@byteray.co.uk>
References: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
In-Reply-To: <20260724-tpm-trunc-resp-v2-0-381857e959f6@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Reinhard Pfau <pfau@gdsys.de>, Che-Liang Chiou <clchiou@chromium.org>, 
 Dirk Eibach <dirk.eibach@gdsys.cc>, Tom Rini <trini@konsulko.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784889267; x=1785494067;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q7zHv394E9nx6mkv5gWVNdySr57tA2lRupy3PKZajfA=;
 b=mahPeaUc0VRmd00njy/lls7O9fBpNY6ULzBwm99UJ/6hLOun4wCUgoUOC7eWjB5vBd
 c9mTOyNRNfnFHG8EDTMFrXVNRpVY5HRFWZ0uoq50krUcwG8EMwyt76tSBauCvfW8dbhv
 mYqjHJqqS06Ba8/tC9R/Go0FGiPSkxwYUWnvCDtGOokwhkRymsF3Wb3AGMhLKlmaagqd
 zstt8iRPUGV5osrhOCuh7E4XHcCkOgqrrN0YWsN75JMZrQ42yNBlThGLSoUJEenSqm8Q
 W+H0KDG6Az4kkneWe7o+D8Lukb5WgWHVCPgl/zLQPJvHK68iEdKNRcn+4nUS7pfYg51O
 3kFw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=mahPeaUc
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

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
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

