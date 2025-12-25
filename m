Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C69EE7AD44
	for <u-boot@archiver.kernel.org>; Thu, 25 Dec 2025 15:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F0B84372;
	Thu, 25 Dec 2025 16:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cMdVdjCI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BD384375; Thu, 25 Dec 2025 16:37:27 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13BBB84371
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 16:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f584ab62c6so2771977fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Dec 2025 07:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766677044; x=1767281844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7FKp5ax4YBNkiSBfKTM7AwrAThK6Ycz7jEyRteP2rd0=;
 b=cMdVdjCI6pru744JOqX/MK2GdgapoZXlMMi2a2KXTwZCtz+NHkY5oTF5hTiPftWWD4
 xBOfiIlbvCC+LzYxi2/kK23JGSs7kChgy4taml9NEDQEFNyw+j9LrUfw3AQtOwDls1sZ
 XRS3yX3a1oXM47aGeq0Qz/+HPRIXj3slw74Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766677044; x=1767281844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FKp5ax4YBNkiSBfKTM7AwrAThK6Ycz7jEyRteP2rd0=;
 b=WOXxpG8QFo2lQxiDBjXd4T1bfAkL0Xc0raWgn85ZK0ezpCKNc9klb6JcqOlNSMBgjX
 Gfl1InmuyIDjyYWkiWFW/xM3TW30+t5ySNUvzYU2lbeqjRO7VhrDAswQJ7VmWgM42ZwM
 zeiF4kE3it3N9T90vVpYnHJk+ZATawxnp2ti+Vo+aEtEzpKl9C29pop6w+yrMNeQcRqH
 1efllTsL4Z6Ekg1Zwo3Ov56+78FsvgEihWsZWTGdidrjiIvZxQAsgXpUk8ZriVzkQh1b
 99s++eSCqkD1FI+3BVk0F1I+wODlWBKigoUCmtMqcYq88nqQX3DD71tN88UgoB1h7HTy
 uwuA==
X-Gm-Message-State: AOJu0YyBQfUWZ03chXI/PwOAYEsDai6/XrjvzLJqMPyT7TFPGfzMICX3
 XZ79zvlz7Wb/zNFU4X38NY8USsNizH80GbveeMLzWA4Iu/+hYZ9w64k9J/gEe/YUi/yFNjTtD0R
 oA7HikNE=
X-Gm-Gg: AY/fxX6w1T51282O9agZCdPakl9br8CW56K9DJ96g6FMTuf1F7GsPxrhfGso32WaSLh
 C8uUTHfwI+b4kQe+QkP90d1DDJ33amH13wPfTAziUO9/DuLqu5zNHuV+Ln0YGY+VtFDvajGtiu8
 epd4EV/G/5E5WXVQtd4GRvhhUMcVtAYgZpt+X7+IQ7HZdrkaOlAtyX0q4h+Ce3IF/kBuNUVw9r8
 Xf3MX4bmoBoRqO2TmbwuF6cmoUQR4g0EI/sFYh2NMgn3G5wpctYiGnaw7ELf7rTJIc0zENCdamE
 gWxAwbmRTuov/aaFiBbMAtKBaRr23wBp5BD8wckNTpxPHaZA9puPTcHgW+pBnd1bS3sPwlqHrs5
 9HIQbqwkbeuL8tw2ej9biwEEK6lHJRJzZCluw6YD2U+4LdJmO6KFARTDxtQDpllIm+ZrVsOfAKu
 X2EbdwLLwoAQZkUhjwYhbkQKAmmliip99hYtn+x9NfKBASMfYgi1vE
X-Google-Smtp-Source: AGHT+IGde6AZj3Irdh2vdxqLEtZXh+G8C6wqhP00W/jxj+fwXcSDYnuwISgVjzc+ASo72TRu2quQiw==
X-Received: by 2002:a4a:e602:0:b0:65d:bee:4c7 with SMTP id
 006d021491bc7-65d0eb1f940mr6361106eaf.42.1766677043718; 
 Thu, 25 Dec 2025 07:37:23 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f6eb26fsm12473073eaf.14.2025.12.25.07.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Dec 2025 07:37:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: tftpput: Rework to exclude code from xPL phases
Date: Thu, 25 Dec 2025 09:37:21 -0600
Message-ID: <20251225153721.1217202-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Given how the support for CONFIG_CMD_TFTPPUT is woven through the
support for the tftp protocol we currently end up including "put"
support in xPL phases, if enabled. This in turn can lead to size
overflow on those platforms as xPL tends to be constrained. To resolve
this, use "CMD_TFTPPUT" in the code to check for both CONFIG_CMD_TFTPPUT
being true and not being in an xPL build phase.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 net/tftp.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 3b0f4cd2006e..78ec44159c1b 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -22,6 +22,15 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/*
+ * We cannot use the 'tftpput' command in xPL phases. Given how the
+ * support is integrated in the code, this is how we disable that support
+ * in xPL.
+ */
+#if defined(CONFIG_CMD_TFTPPUT) && !defined(CONFIG_XPL_BUILD)
+#define CMD_TFTPPUT
+#endif
+
 /* Well known TFTP port # */
 #define WELL_KNOWN_PORT	69
 /* Millisecs to timeout for lost pkt */
@@ -95,7 +104,7 @@ static ushort	tftp_windowsize;
 static ushort	tftp_next_ack;
 /* Last nack block we send */
 static ushort	tftp_last_nack;
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 /* 1 if writing, else 0 */
 static int	tftp_put_active;
 /* 1 if we have sent the last block */
@@ -183,13 +192,13 @@ static void new_transfer(void)
 	tftp_prev_block = 0;
 	tftp_block_wrap = 0;
 	tftp_block_wrap_offset = 0;
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 	tftp_put_final_block_sent = 0;
 #endif
 	led_activity_blink();
 }
 
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 /**
  * Load the next block from memory to be sent over tftp.
  *
@@ -329,7 +338,7 @@ static void tftp_send(void)
 	case STATE_SEND_WRQ:
 		xp = pkt;
 		s = (ushort *)pkt;
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 		*s++ = htons(tftp_state == STATE_SEND_RRQ ? TFTP_RRQ :
 			TFTP_WRQ);
 #else
@@ -372,7 +381,7 @@ static void tftp_send(void)
 		s[0] = htons(TFTP_ACK);
 		s[1] = htons(tftp_cur_block);
 		pkt = (uchar *)(s + 2);
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 		if (tftp_put_active) {
 			int toload = tftp_block_size;
 			int loaded = load_block(tftp_cur_block, pkt, toload);
@@ -437,7 +446,7 @@ static void tftp_send(void)
 		net_set_state(NETLOOP_FAIL);
 }
 
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 static void icmp_handler(unsigned type, unsigned code, unsigned dest,
 			 struct in_addr sip, unsigned src, uchar *pkt,
 			 unsigned len)
@@ -476,7 +485,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 		break;
 
 	case TFTP_ACK:
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 		if (tftp_put_active) {
 			timeout_count = 0;
 			if (tftp_put_final_block_sent) {
@@ -578,7 +587,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 
 		tftp_next_ack = tftp_windowsize;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 		if (tftp_put_active && tftp_state == STATE_OACK) {
 			/* Get ready to send the first block */
 			tftp_state = STATE_DATA;
@@ -854,7 +863,7 @@ void tftp_start(enum proto_t protocol)
 			tftp_block_size_option = TFTP_MTU_BLOCKSIZE6;
 	} else {
 		printf("TFTP %s server %pI4; our IP address is %pI4",
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 	       protocol == TFTPPUT ? "to" : "from",
 #else
 	       "from",
@@ -888,7 +897,7 @@ void tftp_start(enum proto_t protocol)
 	}
 
 	putc('\n');
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 	tftp_put_active = (protocol == TFTPPUT);
 	if (tftp_put_active) {
 		printf("Save address: 0x%lx\n", image_save_addr);
@@ -911,7 +920,7 @@ void tftp_start(enum proto_t protocol)
 
 	net_set_timeout_handler(timeout_ms, tftp_timeout_handler);
 	net_set_udp_handler(tftp_handler);
-#ifdef CONFIG_CMD_TFTPPUT
+#ifdef CMD_TFTPPUT
 	net_set_icmp_handler(icmp_handler);
 #endif
 	tftp_remote_port = WELL_KNOWN_PORT;
-- 
2.43.0

