Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A490DC369C2
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B66558210D;
	Sun, 20 Apr 2025 13:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="tVoahEkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DC582054; Sun, 20 Apr 2025 13:58:25 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AF6820EB
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: df70d0cc-1dde-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id df70d0cc-1dde-11f0-8ec8-005056994fde;
 Sun, 20 Apr 2025 13:59:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=tKXbFkwmPQwavWr1sj+1HQk3dAnGpeUPBYJhC73eOO4=;
 b=tVoahEkGX0sCsqaOosEl1/AmhuMqpT8YWMa+9bg2cFrbQSDmUkGhZoozwrXghI39PhQ/lBNPVLXNu
 qX7Eyk1sKz2Ig6DsJmqT0zzzebNlK31gFcnj1/r3KOZzICq+DaEOJ8lyxASI7B+GmH3VuuXZImPOBP
 bu2P7PsslMdh0HWQ=
X-KPN-MID: 33|XyWu2yR35dVG5M3rmHcEfeq2vRuLalgQ3Dceji8jnQrEzkD/a6P2YCnurb4Ke3P
 K6soAJCfnT8ealN992YJ3jA==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|l1CqXeWL/s3EkHtosrCJ06mL9vTJeXG5SGkBsj2o+ijLasb03/VuYCyL+wsFXh8
 8svkxMLw/E68iOCwkY0XtNg==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c223874d-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:22 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 4/6] arm: apple: rtkit: Add OSLog buffer support
Date: Sun, 20 Apr 2025 13:58:06 +0200
Message-ID: <20250420115808.94272-5-kettenis@openbsd.org>
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

This will work for u-boot itself, but needs a special workaround in the
MTP driver for Linux handoff to work.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/mach-apple/rtkit.c | 69 ++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index 5e8e282ec0e..d294ee09350 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -19,6 +19,7 @@
 #define APPLE_RTKIT_EP_SYSLOG 2
 #define APPLE_RTKIT_EP_DEBUG 3
 #define APPLE_RTKIT_EP_IOREPORT 4
+#define APPLE_RTKIT_EP_OSLOG 8
 #define APPLE_RTKIT_EP_TRACEKIT 10
 
 /* Messages for management endpoint. */
@@ -47,6 +48,11 @@
 #define APPLE_RTKIT_MGMT_EPMAP_REPLY 8
 #define APPLE_RTKIT_MGMT_EPMAP_REPLY_MORE BIT(0)
 
+#define APPLE_RTKIT_OSLOG_TYPE GENMASK_ULL(63, 56)
+#define APPLE_RTKIT_OSLOG_BUFFER_REQUEST 1
+#define APPLE_RTKIT_OSLOG_SIZE GENMASK_ULL(55, 36)
+#define APPLE_RTKIT_OSLOG_IOVA GENMASK_ULL(35, 0)
+
 #define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
 #define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
 
@@ -66,6 +72,7 @@ struct apple_rtkit {
 	struct apple_rtkit_buffer syslog_buffer;
 	struct apple_rtkit_buffer crashlog_buffer;
 	struct apple_rtkit_buffer ioreport_buffer;
+	struct apple_rtkit_buffer oslog_buffer;
 
 	int iop_pwr;
 	int ap_pwr;
@@ -98,6 +105,8 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 			rtk->shmem_destroy(rtk->cookie, &rtk->crashlog_buffer);
 		if (rtk->ioreport_buffer.buffer)
 			rtk->shmem_destroy(rtk->cookie, &rtk->ioreport_buffer);
+		if (rtk->oslog_buffer.buffer)
+			rtk->shmem_destroy(rtk->cookie, &rtk->oslog_buffer);
 	} else {
 		if (rtk->syslog_buffer.buffer)
 			free(rtk->syslog_buffer.buffer);
@@ -105,6 +114,8 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 			free(rtk->crashlog_buffer.buffer);
 		if (rtk->ioreport_buffer.buffer)
 			free(rtk->ioreport_buffer.buffer);
+		if (rtk->oslog_buffer.buffer)
+			free(rtk->oslog_buffer.buffer);
 	}
 	free(rtk);
 }
@@ -112,16 +123,8 @@ void apple_rtkit_free(struct apple_rtkit *rtk)
 static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct apple_mbox_msg *msg)
 {
 	struct apple_rtkit_buffer *buf;
-	size_t num_4kpages;
 	int ret;
 
-	num_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg->msg0);
-
-	if (num_4kpages == 0) {
-		printf("%s: unexpected request for buffer without size\n", __func__);
-		return -1;
-	}
-
 	switch (endpoint) {
 	case APPLE_RTKIT_EP_CRASHLOG:
 		buf = &rtk->crashlog_buffer;
@@ -132,13 +135,31 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 	case APPLE_RTKIT_EP_IOREPORT:
 		buf = &rtk->ioreport_buffer;
 		break;
+	case APPLE_RTKIT_EP_OSLOG:
+		buf = &rtk->oslog_buffer;
+		break;
 	default:
 		printf("%s: unexpected endpoint %d\n", __func__, endpoint);
 		return -1;
 	}
 
+	switch (endpoint) {
+	case APPLE_RTKIT_EP_OSLOG:
+		buf->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg->msg0);
+		buf->dva = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg->msg0 << 12);
+		break;
+	default:
+		buf->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg->msg0) << 12;
+		buf->dva = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg->msg0);
+		break;
+	}
+
+	if (buf->size == 0) {
+		printf("%s: unexpected request for buffer without size\n", __func__);
+		return -1;
+	}
+
 	buf->dva = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg->msg0);
-	buf->size = num_4kpages << 12;
 	buf->is_mapped = !!buf->dva;
 
 	if (rtk->shmem_setup) {
@@ -157,10 +178,18 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 	}
 
 	if (!buf->is_mapped) {
-		msg->msg0 = FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, APPLE_RTKIT_BUFFER_REQUEST) |
-				FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, num_4kpages) |
-				FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA, buf->dva);
-		msg->msg1 = endpoint;
+		/* oslog uses different fields */
+		if (endpoint == APPLE_RTKIT_EP_OSLOG) {
+			msg->msg0 = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE,
+					       APPLE_RTKIT_OSLOG_BUFFER_REQUEST);
+			msg->msg0 |= FIELD_PREP(APPLE_RTKIT_OSLOG_SIZE, buf->size);
+			msg->msg0 |= FIELD_PREP(APPLE_RTKIT_OSLOG_IOVA, buf->dva >> 12);
+		} else {
+			msg->msg0 = FIELD_PREP(APPLE_RTKIT_MGMT_TYPE,
+					   APPLE_RTKIT_BUFFER_REQUEST);
+			msg->msg0 |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, buf->size >> 12);
+			msg->msg0 |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA, buf->dva);
+		}
 
 		return mbox_send(rtk->chan, msg);
 	}
@@ -193,6 +222,20 @@ int apple_rtkit_poll(struct apple_rtkit *rtk, ulong timeout)
 		}
 	}
 
+	if (endpoint == APPLE_RTKIT_EP_OSLOG) {
+		msgtype = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg.msg0);
+
+		if (msgtype == APPLE_RTKIT_OSLOG_BUFFER_REQUEST) {
+			ret = rtkit_handle_buf_req(rtk, endpoint, &msg);
+			if (ret < 0)
+				return ret;
+			return 0;
+		} else {
+			/* Ignore */
+			return 0;
+		}
+	}
+
 	if (endpoint == APPLE_RTKIT_EP_IOREPORT) {
 		// these two messages have to be ack-ed for proper startup
 		if (msgtype == 0xc || msgtype == 0x8) {
-- 
2.49.0

