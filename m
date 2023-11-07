Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F09C0032E
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 560C887282;
	Tue,  7 Nov 2023 13:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f6yn8khc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C9287201; Tue,  7 Nov 2023 13:43:05 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE8987210
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:43:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so9296923a12.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699360982; x=1699965782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUzUej0zUlCif1GYnfKK2mII4n0np4hcAlaxboDqsK8=;
 b=f6yn8khcTJgbMDI6lAEgDQsTb5tt37nWSMaJtti9SdHLe7CM2GO9LBBNUIvf0Z+wJj
 Oz2jWDfBMC+bHcGblMmnMq1UT3vb+pcLB1msQvLWsWjbVTDNoRP6xTAT8EOFZg0R4LbK
 qpH5UHf0zfsP9Bd9lzcziTqTK/5mddle8fD85sZz+cMFYa9pBAho58nSwNoARBIRmwdw
 eiTuVrl5/PT29COFQ2R9vQjjfl2VufbLv5yQDunApn4GCWMjxe8hyA3FqkQvpPfoMHAQ
 v/GO57Vxvo99h8DX3CxiLu0o9HpqKPA2+a2hVidHmQmlO0a4ZZuX+tRuotlmsfORbIdj
 I8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360982; x=1699965782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUzUej0zUlCif1GYnfKK2mII4n0np4hcAlaxboDqsK8=;
 b=dIUirla1PZEP+n6ekfoMwZkyH2a+kj1ZuyrIltN7f6CKmjV4taqgt7P3LpecwelMwv
 xunHFzNMWpG7aYTIBnJ9TC5eJ9mz/o6MeNzoJHRe9T9TjBdzC5S6UFg8+bVfz+ACf09B
 nLIMPQksgBySF7Ib0Ou/nbE9J9fA9Ep12Lt4b9IN8lOsPZTWedSszTQiYMVpa3mqS611
 q8EqFslZM5P5nHvDdTUm+KJ2V5nKrqfCYvu9TPfBhQ0FmkogajNynuzFOZ3ZqMp29cbM
 mWLOGExCrE56dSASaolye1/+FUrDNUES77azUGwCt0Xe+Txpovyc0aPbuRsIsn3ECCas
 WWgA==
X-Gm-Message-State: AOJu0Yx50bc6SxqENPt1TIgGf+XO77FFFxRmd97AXYdTURD7RMUQnZad
 KZtacWlovzm4F7UTbE4IVX0=
X-Google-Smtp-Source: AGHT+IExe0m0tBADEH4Mb52uCCKGQaoP6fStJUBtfwo/94s+BC/t7osi9vga4MEmN37/aAHN3UYkBg==
X-Received: by 2002:a05:6402:b2f:b0:531:2b0b:9b8 with SMTP id
 bo15-20020a0564020b2f00b005312b0b09b8mr26045985edb.7.1699360981943; 
 Tue, 07 Nov 2023 04:43:01 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 u16-20020a509510000000b0053e89721d4esm5481831eda.68.2023.11.07.04.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:43:01 -0800 (PST)
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
Subject: [PATCH v1 1/5] fastboot: multiresponse support
Date: Tue,  7 Nov 2023 14:42:37 +0200
Message-Id: <20231107124241.35432-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231107124241.35432-1-clamor95@gmail.com>
References: <20231107124241.35432-1-clamor95@gmail.com>
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
---
 drivers/fastboot/fb_command.c   | 10 ++++++++++
 drivers/usb/gadget/f_fastboot.c | 29 +++++++++++++++++++++++++++++
 include/fastboot.h              |  8 ++++++++
 net/fastboot_udp.c              | 25 +++++++++++++++++++------
 4 files changed, 66 insertions(+), 6 deletions(-)

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
index 741775a7bc..7d8c22b948 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -497,6 +497,25 @@ static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 	do_exit_on_complete(ep, req);
 }
 
+int multiresponse_cmd = -1;
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
+	/* If response is not an INFO disconnect this handler and unset cmd */
+	if (strncmp("INFO", response, 4) != 0) {
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
 
+	if (!strncmp("MORE", response, 4)) {
+		multiresponse_cmd = cmd;
+		fastboot_multiresponse(multiresponse_cmd, response);
+
+		/* Only add if first is a INFO */
+		if (!strncmp("INFO", response, 4)) {
+			fastboot_func->in_req->complete = multiresponse_on_complete;
+		}
+	}
+
 	if (!strncmp("DATA", response, 4)) {
 		req->complete = rx_handler_dl_image;
 		req->length = rx_bytes_expected(ep);
diff --git a/include/fastboot.h b/include/fastboot.h
index 296451f89d..d1a2b74b2f 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -172,5 +172,13 @@ void fastboot_data_download(const void *fastboot_data,
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
index d690787478..ca3278f7b4 100644
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
 
@@ -180,6 +180,19 @@ static void fastboot_send(struct fastboot_header header, char *fastboot_data,
 		} else {
 			cmd = fastboot_handle_command(command, response);
 			pending_command = false;
+
+			if (!strncmp("MORE", response, 4)) {
+				while (1) {
+					/* Call handler to obtain next response */
+					fastboot_multiresponse(multiresponse_cmd, response);
+
+					/* Send INFO or break to send final response */
+					if (!strncmp("INFO", response, 4))
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

