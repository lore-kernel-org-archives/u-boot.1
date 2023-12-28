Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D2CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 18:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57D6C879E9;
	Thu, 28 Dec 2023 19:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nxr30tYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281A387B01; Thu, 28 Dec 2023 19:02:19 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CB287A24
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 19:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e7be1c65dso2990453e87.3
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703786536; x=1704391336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/7nIXEtXr0tT37tdyDEAdtwYEWCpaz7ODmuC1pkxAQ=;
 b=Nxr30tYVugU9RFRUPQuD7wjbNZlf1CQoOEZxdWJ++LbnMNp6TzPD3AscW5/O1yOdMP
 lpR4Y6klLNzRFVACO9g8apTjjaiDryzlv2sXhOk05WS8O3/c0CSYPjtbgcmC6+ySfApf
 FtSf4/F/tO6X5izXeP4a1+lFBu4/q4suEwLnGTf87hJhGSe53QKZjaFzbVumS5hOzgBC
 nEarNWGg7gkTv+t8aqJhw8CA0GkrjY19K+nuE7h1DL+t0sZpkviZeHVffmWsaqXeCjCf
 nQpTrpIH5X+sukWUV3lurMhI4HzE9+Djqr7neAPWfmBYAIBiIzDCy+FhtowHB3vq+Tk5
 JpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703786536; x=1704391336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y/7nIXEtXr0tT37tdyDEAdtwYEWCpaz7ODmuC1pkxAQ=;
 b=uzdHyUi/ukmFgF+JwC8MOQX1YZqPtHrpYUMCiVzHFAl9Cqh8JK76RNkrVG0UHTMxGu
 gXnFoEkzHRQL3Jcxc3Eahs8w8EaAaA+KSa6Ihrl7kdzTB3z5UFqsra7j17rVLim4alQU
 ZJnPQqC6nBCJoT5cn5KL+59lTEl6R3jhewF2D8NFznO/Qjqulq5haIXrpvxjouq23EzY
 MIutCpzumD0iWfRKHbzSPVLsN8MMWdkEfNydQ5yrCEz2SDFk3GdiLxisCBPfLjer0dOx
 mfmO2Z1cm2+s/CvLJh6zxg15PlFy9qsiFerz+eaeBua/PjGebD8UHIoL3M/6LZdhKWFE
 m8WA==
X-Gm-Message-State: AOJu0Ywa3Kg8FO/lgWzKJ7ZDsI9UzHZtc0JTdds25Lz0amfxB74OTvy3
 2eowTqQ24AsHuTNt3fwcdXI=
X-Google-Smtp-Source: AGHT+IGkdVsmbqmDYJTHHDM8qbp4L+RxZ6aOI5hzd9zHj9gPInR2mJyGoiBTC4q2/2Gq97HuLcTOBA==
X-Received: by 2002:a05:6512:318d:b0:50e:7922:c2ac with SMTP id
 i13-20020a056512318d00b0050e7922c2acmr2886940lfe.58.1703786535503; 
 Thu, 28 Dec 2023 10:02:15 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 s4-20020a056512314400b0050e6b04a5b2sm1955101lfi.251.2023.12.28.10.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:02:15 -0800 (PST)
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
Subject: [PATCH v6 1/6] fastboot: multiresponse support
Date: Thu, 28 Dec 2023 20:01:49 +0200
Message-Id: <20231228180154.50473-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228180154.50473-1-clamor95@gmail.com>
References: <20231228180154.50473-1-clamor95@gmail.com>
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

