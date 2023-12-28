Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176AEC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 09:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9C6879E5;
	Thu, 28 Dec 2023 10:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c0iOrJPw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52A91879D8; Thu, 28 Dec 2023 10:03:04 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9012879A3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso36351311fa.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703754180; x=1704358980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/7nIXEtXr0tT37tdyDEAdtwYEWCpaz7ODmuC1pkxAQ=;
 b=c0iOrJPwZKPJAdvasapy1DKt+jfCQR4QLZ1LIJTjvyg8/gjnRznPOaMRQ4FNz9N04w
 /opSQvNi+Vqm6yhFVM+CSd+Qp+e+G89HsH+pf3d16PuRGUar86h5CIxrE+FPm4Ke+Qo6
 WQt+FMfHRftHf2S41sC4G4wznR5AGNygckLWjI0Ds3rEIzaADqpHQb2d3vB0wcbvneJU
 qDfybLF0zhUsXM01JiSiZEE7maYZZ2sQnBN6AC6GY3Gk0W3YVqbrp+4dKbyuRLeO1a7Y
 +Klo08Urh79VjnUezVSrSPGqD7UGLF+v/XWEuCHXF6vDBaeeT+8ckRfzWFNsLpppWg5J
 ydhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703754180; x=1704358980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/7nIXEtXr0tT37tdyDEAdtwYEWCpaz7ODmuC1pkxAQ=;
 b=sx8JsnItZxiqmbKmA+3W0srCPqowyfp9QoNUUf5MnfzSzpavT013L75NXkHhD0z5//
 ZcSHyp5E46zw8enG9AGZGadbAFKJy+fqR3h68Ji/ydfRTRkPQW/HgOip2IRC1iL/zRr2
 3A345yjQHjcPi6EU55Gn3z1rqYWFz9PR1taBKeNV5jDWoUR/WMeCPZtb0plv6wrBWGMj
 qhsz7f5lkiXwhWmvgajWhfocIthHDFZ76VT/o2KIxTXGoTNJFDXA1N1TjkHMAt2515i+
 biFiJ/HXbVP3V6i1xMw8MKEebYub3oE5i0LaEEjoOnNRoJI+ro1nKAcgmTh+RIMVezBh
 D0Lw==
X-Gm-Message-State: AOJu0YyjQ6QtqR7EivOxm7HrhlxBPRt/Vw4ARUWYxRQJtllAHfaWCJdI
 Cfx46poweUVcZ0El3qPYfP8=
X-Google-Smtp-Source: AGHT+IHA0XIgHWnNHSAbIk2WXFteTZeaq7ZzQah5XN3GGTCumlTpX2Os4ZU7ueA0b7fm2nR/jJry/Q==
X-Received: by 2002:a2e:9898:0:b0:2cc:9882:4cb5 with SMTP id
 b24-20020a2e9898000000b002cc98824cb5mr4576442ljj.45.1703754179796; 
 Thu, 28 Dec 2023 01:02:59 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 n18-20020a2ebd12000000b002ccabe13852sm2475708ljq.85.2023.12.28.01.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 01:02:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 1/5] fastboot: multiresponse support
Date: Thu, 28 Dec 2023 11:02:36 +0200
Message-Id: <20231228090240.18011-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228090240.18011-1-clamor95@gmail.com>
References: <20231228090240.18011-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Currently u-boot fastboot can only send one message back to host,
so if there is a need to print more than one line messages must be
kept sending until all the required data is obtained. This behavior
can be adjusted using multiresponce ability (getting multiple lines
of response) proposed in this patch.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/fastboot/fb_command.c   | 10 ++++++++++
 drivers/usb/gadget/f_fastboot.c | 29 +++++++++++++++++++++++++++++
 include/fastboot.h              | 18 ++++++++++++++++++
 net/fastboot_udp.c              | 29 +++++++++++++++++++++++------
 4 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 5fcadcdf50..ab72d8c781 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -5,6 +5,7 @@
 
 #include <common.h>
 #include <command.h>
+#include <console.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fastboot-internal.h>
@@ -152,6 +153,15 @@ int fastboot_handle_command(char *cmd_string, char *response)
 	return -1;
 }
 
+void fastboot_multiresponse(int cmd, char *response)
+{
+	switch (cmd) {
+	default:
+		fastboot_fail("Unknown multiresponse command", response);
+		break;
+	}
+}
+
 /**
  * okay() - Send bare OKAY response
  *
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9f322c9550..09e740cc96 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -497,6 +497,25 @@ static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 	do_exit_on_complete(ep, req);
 }
 
+static int multiresponse_cmd = -1;
+static void multiresponse_on_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	char response[FASTBOOT_RESPONSE_LEN] = {0};
+
+	if (multiresponse_cmd == -1)
+		return;
+
+	/* Call handler to obtain next response */
+	fastboot_multiresponse(multiresponse_cmd, response);
+	fastboot_tx_write_str(response);
+
+	/* If response is final OKAY/FAIL response disconnect this handler and unset cmd */
+	if (!strncmp("OKAY", response, 4) || !strncmp("FAIL", response, 4)) {
+		multiresponse_cmd = -1;
+		fastboot_func->in_req->complete = fastboot_complete;
+	}
+}
+
 static void do_acmd_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	/* When usb dequeue complete will be called
@@ -524,6 +543,16 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 		fastboot_fail("buffer overflow", response);
 	}
 
+	if (!strncmp(FASTBOOT_MULTIRESPONSE_START, response, 4)) {
+		multiresponse_cmd = cmd;
+		fastboot_multiresponse(multiresponse_cmd, response);
+
+		/* Only add complete callback if first is not a final OKAY/FAIL response */
+		if (strncmp("OKAY", response, 4) && strncmp("FAIL", response, 4)) {
+			fastboot_func->in_req->complete = multiresponse_on_complete;
+		}
+	}
+
 	if (!strncmp("DATA", response, 4)) {
 		req->complete = rx_handler_dl_image;
 		req->length = rx_bytes_expected(ep);
diff --git a/include/fastboot.h b/include/fastboot.h
index 296451f89d..59cbea61ec 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -14,6 +14,16 @@
 
 #define FASTBOOT_VERSION	"0.4"
 
+/*
+ * Signals u-boot fastboot code to send multiple responses by
+ * calling response generating function repeatedly until a OKAY/FAIL
+ * is generated as final response.
+ *
+ * This status code is only used internally to signal, must NOT
+ * be sent to host.
+ */
+#define FASTBOOT_MULTIRESPONSE_START	("MORE")
+
 /* The 64 defined bytes plus \0 */
 #define FASTBOOT_COMMAND_LEN	(64 + 1)
 #define FASTBOOT_RESPONSE_LEN	(64 + 1)
@@ -172,5 +182,13 @@ void fastboot_data_download(const void *fastboot_data,
  */
 void fastboot_data_complete(char *response);
 
+/**
+ * fastboot_handle_multiresponse() - Called for each response to send
+ *
+ * @cmd: Command id that requested multiresponse
+ * @response: Pointer to fastboot response buffer
+ */
+void fastboot_multiresponse(int cmd, char *response);
+
 void fastboot_acmd_complete(void);
 #endif /* _FASTBOOT_H_ */
diff --git a/net/fastboot_udp.c b/net/fastboot_udp.c
index d690787478..6fee441ab3 100644
--- a/net/fastboot_udp.c
+++ b/net/fastboot_udp.c
@@ -42,16 +42,15 @@ static int fastboot_remote_port;
 static int fastboot_our_port;
 
 /**
- * fastboot_udp_send_info() - Send an INFO packet during long commands.
+ * fastboot_udp_send_response() - Send an response into UDP
  *
- * @msg: String describing the reason for waiting
+ * @response: Response to send
  */
-static void fastboot_udp_send_info(const char *msg)
+static void fastboot_udp_send_response(const char *response)
 {
 	uchar *packet;
 	uchar *packet_base;
 	int len = 0;
-	char response[FASTBOOT_RESPONSE_LEN] = {0};
 
 	struct fastboot_header response_header = {
 		.id = FASTBOOT_FASTBOOT,
@@ -66,7 +65,6 @@ static void fastboot_udp_send_info(const char *msg)
 	memcpy(packet, &response_header, sizeof(response_header));
 	packet += sizeof(response_header);
 	/* Write response */
-	fastboot_response("INFO", response, "%s", msg);
 	memcpy(packet, response, strlen(response));
 	packet += strlen(response);
 
@@ -91,6 +89,7 @@ static void fastboot_udp_send_info(const char *msg)
 static void fastboot_timed_send_info(const char *msg)
 {
 	static ulong start;
+	char response[FASTBOOT_RESPONSE_LEN] = {0};
 
 	/* Initialize timer */
 	if (start == 0)
@@ -99,7 +98,8 @@ static void fastboot_timed_send_info(const char *msg)
 	/* Send INFO packet to host every 30 seconds */
 	if (time >= 30000) {
 		start = get_timer(0);
-		fastboot_udp_send_info(msg);
+		fastboot_response("INFO", response, "%s", msg);
+		fastboot_udp_send_response(response);
 	}
 }
 
@@ -180,6 +180,23 @@ static void fastboot_send(struct fastboot_header header, char *fastboot_data,
 		} else {
 			cmd = fastboot_handle_command(command, response);
 			pending_command = false;
+
+			if (!strncmp(FASTBOOT_MULTIRESPONSE_START, response, 4)) {
+				while (1) {
+					/* Call handler to obtain next response */
+					fastboot_multiresponse(cmd, response);
+
+					/*
+					 * Send more responses or break to send
+					 * final OKAY/FAIL response
+					 */
+					if (strncmp("OKAY", response, 4) &&
+					    strncmp("FAIL", response, 4))
+						fastboot_udp_send_response(response);
+					else
+						break;
+				}
+			}
 		}
 		/*
 		 * Sent some INFO packets, need to update sequence number in
-- 
2.40.1

