Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31517C369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4418205B;
	Sun, 20 Apr 2025 13:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="NoM1tgHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F104820B7; Sun, 20 Apr 2025 13:58:18 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69BD82054
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: ce7c5eda-1dde-11f0-a9b6-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id ce7c5eda-1dde-11f0-a9b6-00505699b430;
 Sun, 20 Apr 2025 13:58:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=fgmbU/kUsYQeWDbtD1x5l9lLL5qoWrgpTDQefwsr5SA=;
 b=NoM1tgHs7m4QaMmP3CPkxWMoXvSZ9nv8dBzSC7KJ5kUtMwDAv3//BBeKHPolK0os+RIPbNOI0gr1c
 CeHz7KnGtxd6iNWV+Xug0Ox7o+niYbSAYOEHxtlGSn+rU7PKI4wxDJNOtEzObXZpA/io9Lm2MK5qVW
 SPVCl/gDNmA3mqc8=
X-KPN-MID: 33|lcBgb+fYwhIVY7ElEFL3aCi8QDqmrmGvLBc6nr1/+G4MJQq2x7ZWQi36ig/5jkY
 aJHi/YZV/7vZyMwDo+Gfr8Q==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|atsaFn2cmE4wzaoOYDtHf0AG7tmjdeMA1T+daIXsvbfTmiGVPhjE83Q6nVpZVT2
 OKCCuHHFLQHdRdmsl8eFNEA==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id bdc07331-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:15 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 1/6] arm: apple: rtkit: Add support for AP power & syslogs
Date: Sun, 20 Apr 2025 13:58:03 +0200
Message-ID: <20250420115808.94272-2-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hector Martin <marcan@marcan.st>

This is required for MTP to work properly

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/include/asm/arch-apple/rtkit.h |   2 +
 arch/arm/mach-apple/rtkit.c             | 148 ++++++++++++++++++------
 2 files changed, 112 insertions(+), 38 deletions(-)

diff --git a/arch/arm/include/asm/arch-apple/rtkit.h b/arch/arm/include/asm/arch-apple/rtkit.h
index eff18ddb9d2..b795215feb7 100644
--- a/arch/arm/include/asm/arch-apple/rtkit.h
+++ b/arch/arm/include/asm/arch-apple/rtkit.h
@@ -26,4 +26,6 @@ struct apple_rtkit *apple_rtkit_init(struct mbox_chan *chan, void *cookie,
 				     apple_rtkit_shmem_destroy shmem_destroy);
 void apple_rtkit_free(struct apple_rtkit *rtk);
 int apple_rtkit_boot(struct apple_rtkit *rtk);
+int apple_rtkit_set_ap_power(struct apple_rtkit *rtk, int pwrstate);
+int apple_rtkit_poll(struct apple_rtkit *rtk, ulong timeout);
 int apple_rtkit_shutdown(struct apple_rtkit *rtk, int pwrstate);
diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index b8f4771e5e7..433ffb259ee 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -36,6 +36,7 @@
 
 #define APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE 6
 #define APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE_ACK 7
+#define APPLE_RTKIT_MGMT_SET_AP_PWR_STATE 11
 
 #define APPLE_RTKIT_MGMT_EPMAP 8
 #define APPLE_RTKIT_MGMT_EPMAP_LAST BIT(51)
@@ -64,6 +65,9 @@ struct apple_rtkit {
 	struct apple_rtkit_buffer syslog_buffer;
 	struct apple_rtkit_buffer crashlog_buffer;
 	struct apple_rtkit_buffer ioreport_buffer;
+
+	int iop_pwr;
+	int ap_pwr;
 };
 
 struct apple_rtkit *apple_rtkit_init(struct mbox_chan *chan, void *cookie,
@@ -150,6 +154,75 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 	return 0;
 }
 
+int apple_rtkit_poll(struct apple_rtkit *rtk, ulong timeout)
+{
+	struct apple_mbox_msg msg;
+	int ret;
+	int endpoint;
+	int msgtype;
+
+	ret = mbox_recv(rtk->chan, &msg, timeout);
+	if (ret < 0)
+		return ret;
+
+	endpoint = msg.msg1;
+	msgtype = FIELD_GET(APPLE_RTKIT_MGMT_TYPE, msg.msg0);
+
+	if (endpoint == APPLE_RTKIT_EP_CRASHLOG ||
+		endpoint == APPLE_RTKIT_EP_SYSLOG ||
+		endpoint == APPLE_RTKIT_EP_IOREPORT) {
+		if (msgtype == APPLE_RTKIT_BUFFER_REQUEST) {
+			ret = rtkit_handle_buf_req(rtk, endpoint, &msg);
+			if (ret < 0)
+				return ret;
+			return 0;
+		}
+	}
+
+	if (endpoint == APPLE_RTKIT_EP_IOREPORT) {
+		// these two messages have to be ack-ed for proper startup
+		if (msgtype == 0xc || msgtype == 0x8) {
+			ret = mbox_send(rtk->chan, &msg);
+			if (ret < 0)
+				return ret;
+			return 0;
+		}
+	}
+
+	if (endpoint == APPLE_RTKIT_EP_SYSLOG) {
+		/* Ignore init */
+		if (msgtype == 0x8)
+			return 0;
+
+		/* Ack logs */
+		if (msgtype == 0x5) {
+			ret = mbox_send(rtk->chan, &msg);
+			if (ret < 0)
+				return ret;
+			return 0;
+		}
+	}
+
+	if (endpoint != APPLE_RTKIT_EP_MGMT) {
+		printf("%s: unexpected endpoint %d\n", __func__, endpoint);
+		return -EINVAL;
+	}
+
+	switch (msgtype) {
+		case APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE_ACK:
+			rtk->iop_pwr = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg.msg0);
+			return 0;
+		case APPLE_RTKIT_MGMT_SET_AP_PWR_STATE:
+			rtk->ap_pwr = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg.msg0);
+			return 0;
+		default:
+			printf("%s: unexpected message type %d\n", __func__, msgtype);
+
+			/* Just ignore it */
+			return 0;
+	}
+}
+
 int apple_rtkit_boot(struct apple_rtkit *rtk)
 {
 	struct apple_mbox_msg msg;
@@ -157,7 +230,7 @@ int apple_rtkit_boot(struct apple_rtkit *rtk)
 	int nendpoints = 0;
 	int endpoint;
 	int min_ver, max_ver, want_ver;
-	int msgtype, pwrstate;
+	int msgtype;
 	u64 reply;
 	u32 bitmap, base;
 	int i, ret;
@@ -276,46 +349,37 @@ wait_epmap:
 			return ret;
 	}
 
-	pwrstate = APPLE_RTKIT_PWR_STATE_SLEEP;
-	while (pwrstate != APPLE_RTKIT_PWR_STATE_ON) {
-		ret = mbox_recv(rtk->chan, &msg, TIMEOUT_1SEC_US);
+	rtk->iop_pwr = APPLE_RTKIT_PWR_STATE_SLEEP;
+	rtk->ap_pwr = APPLE_RTKIT_PWR_STATE_QUIESCED;
+
+	while (rtk->iop_pwr != APPLE_RTKIT_PWR_STATE_ON) {
+		ret = apple_rtkit_poll(rtk, TIMEOUT_1SEC_US);
 		if (ret < 0)
 			return ret;
+	}
 
-		endpoint = msg.msg1;
-		msgtype = FIELD_GET(APPLE_RTKIT_MGMT_TYPE, msg.msg0);
-
-		if (endpoint == APPLE_RTKIT_EP_CRASHLOG ||
-		    endpoint == APPLE_RTKIT_EP_SYSLOG ||
-		    endpoint == APPLE_RTKIT_EP_IOREPORT) {
-			if (msgtype == APPLE_RTKIT_BUFFER_REQUEST) {
-				ret = rtkit_handle_buf_req(rtk, endpoint, &msg);
-				if (ret < 0)
-					return ret;
-				continue;
-			}
-		}
+	return 0;
+}
 
-		if (endpoint == APPLE_RTKIT_EP_IOREPORT) {
-			// these two messages have to be ack-ed for proper startup
-			if (msgtype == 0xc || msgtype == 0x8) {
-				ret = mbox_send(rtk->chan, &msg);
-				if (ret < 0)
-					return ret;
-				continue;
-			}
-		}
+int apple_rtkit_set_ap_power(struct apple_rtkit *rtk, int pwrstate)
+{
+	struct apple_mbox_msg msg;
+	int ret;
 
-		if (endpoint != APPLE_RTKIT_EP_MGMT) {
-			printf("%s: unexpected endpoint %d\n", __func__, endpoint);
-			return -EINVAL;
-		}
-		if (msgtype != APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE_ACK) {
-			printf("%s: unexpected message type %d\n", __func__, msgtype);
-			return -EINVAL;
-		}
+	if (rtk->ap_pwr == pwrstate)
+		return 0;
 
-		pwrstate = FIELD_GET(APPLE_RTKIT_MGMT_PWR_STATE, msg.msg0);
+	msg.msg0 = FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, APPLE_RTKIT_MGMT_SET_AP_PWR_STATE) |
+		FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, pwrstate);
+	msg.msg1 = APPLE_RTKIT_EP_MGMT;
+	ret = mbox_send(rtk->chan, &msg);
+	if (ret < 0)
+		return ret;
+
+	while (rtk->ap_pwr != pwrstate) {
+		ret = apple_rtkit_poll(rtk, TIMEOUT_1SEC_US);
+		if (ret < 0)
+			return ret;
 	}
 
 	return 0;
@@ -326,6 +390,12 @@ int apple_rtkit_shutdown(struct apple_rtkit *rtk, int pwrstate)
 	struct apple_mbox_msg msg;
 	int ret;
 
+	if (rtk->ap_pwr != APPLE_RTKIT_PWR_STATE_QUIESCED) {
+		ret = apple_rtkit_set_ap_power(rtk, APPLE_RTKIT_PWR_STATE_QUIESCED);
+		if (ret < 0)
+			return ret;
+	}
+
 	msg.msg0 = FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, APPLE_RTKIT_MGMT_SET_IOP_PWR_STATE) |
 		FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, pwrstate);
 	msg.msg1 = APPLE_RTKIT_EP_MGMT;
@@ -333,9 +403,11 @@ int apple_rtkit_shutdown(struct apple_rtkit *rtk, int pwrstate)
 	if (ret < 0)
 		return ret;
 
-	ret = mbox_recv(rtk->chan, &msg, TIMEOUT_1SEC_US);
-	if (ret < 0)
-		return ret;
+	while (rtk->iop_pwr != pwrstate) {
+		ret = apple_rtkit_poll(rtk, TIMEOUT_1SEC_US);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.49.0

