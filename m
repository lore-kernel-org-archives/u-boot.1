Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9116F46101
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB1484114;
	Mon, 23 Mar 2026 14:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LL0vpl/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90B784099; Mon, 23 Mar 2026 12:05:22 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1EDE83DB6
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=charles.cc.zhang@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43b41b545d9so24097f8f.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 04:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774263920; x=1774868720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ziKbpuE/iBLkQ1ZrvFIdlxs8qx5h46mrrTY+AS0WOfE=;
 b=LL0vpl/ufXQ6g0wVPYfMXFP0ligg27te4wnwpgapbVZFEIN3MKLHxkAfEdJLqWxgQ9
 1QwBhefLW5mRx7+TZblLJx7PLNzwHBT+oy3mSMVRo+4Wr6BEgzJ5jDccdvjErMBCvOiI
 p99YSiXqLyVCs4YY//ZlHys5yBQng0tesIJWVsuFVWyZGWkDE7kzq+tVU5apj16AvIaj
 6hRWN3vMH1SZm7S5RMNvNbBSCDPSW37hgMGBVrNzo8Wu2z+k1NLleszkPuUwpQIx13Tp
 X+gKMfm/+KnThdC/Shmlz6Nx3EVxtqKFYmhvXoZhg8QkqSEUAeTTHHcxu2DGBM4ddO/O
 lTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263920; x=1774868720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ziKbpuE/iBLkQ1ZrvFIdlxs8qx5h46mrrTY+AS0WOfE=;
 b=kG+90rGrxWE3jaTon2MF24sSmQJFsbVwnrsTkekMQ6yqkT4hZY6v4vJO2CuAWz5oRY
 qgiDzxafYFxIekUrtEBWzV1FgPOpHqBalMvFtjh3v4jYG2TcwlhSusN6sMJ0R4ItC6bw
 wXoihARwBfi1C+2pply8Hy5QNwd8Sy2oNcYWdyUTqsO34f8DZSJQTfvn/7xvdlYdWyZv
 +dIT1VP7PCMlWxo6lvD2J+NTKlTxSgek5Ycz0ceOZQecMjwLWRCB+X+8nxXOAayUXB7r
 32zKTJARAqkvPnGP2PVmX7pA4hYvZItNnc5sPDxMCEuucspN8BoqrKc7ATQO9fq36sVG
 8Ydw==
X-Gm-Message-State: AOJu0YyeYdb6FxbzGF0GesZXWZSFgU/pVZwRQ5dC9ue6aBgmQrJ9ijJl
 ASeuQnJJ+Sxtx/owwPrMU3fDM/brXc85edTIn+nbB9iuJ+ncL7xy/y6Z
X-Gm-Gg: ATEYQzzMB1ftuYkkLg869P0HN18tsUWjUgRDlMDWh4tk6ewvCnz7JLmaSGkS8BXE2xr
 FQTzbYl3lSVLXxQFdjsJ9cA43KiHIW9uQjgDVUPPsrjzrg7dFatuhsSrY2r6WGaXnjminxI5pQC
 wHpbdq3Z7oxlij0HdQ4Fq4dJh9Fy4Z55is/yeQE5h9BEK3LI70VSJrn1EjrUtbaXWgFUhq015u/
 SmwC0yKE+qvlacnTFbNL73ZnOBZsYm5Tmt51+MfBZF+HyDTdxJ1QfnvAJnYcny22YqAWMP3S0XF
 II1nwDerxaXKqvmejB8bHgCZ0sWMSphH8fCotpnsaG99aIDFmLtfPrNj/qVXnrKs/Kidm9yHIeA
 n9eHYslxZ8O1dCJGag+qBQynlAM/U63AUODFhrykaTJt+1l0JcvIeHzACeZDC28bx1caOWhy0zM
 BMOPoTMkSAdPukninFMs3Nr08s1QFL9xal6MaMAf8r3Q==
X-Received: by 2002:a05:6000:1845:b0:43b:3cea:ddc2 with SMTP id
 ffacd0b85a97d-43b6427cdd3mr18310330f8f.47.1774263920009; 
 Mon, 23 Mar 2026 04:05:20 -0700 (PDT)
Received: from SMLLTUK00006.sml.com ([77.91.218.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703343sm29532861f8f.19.2026.03.23.04.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 04:05:19 -0700 (PDT)
From: Chencheng Zhang <charles.cc.zhang@gmail.com>
To: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yannic Moog <y.moog@phytec.de>, Leonard Anderweit <l.anderweit@phytec.de>,
 =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>,
 Chencheng Zhang <charles.cc.zhang@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] net: tftp: fix malformed option string parsing
Date: Mon, 23 Mar 2026 12:05:16 +0100
Message-Id: <20260323110516.84423-1-charles.cc.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Mar 2026 14:24:52 +0100
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

When formatting the TFTP options (tsize, blksize, windowsize), the
code previously used sprintf() with embedded null bytes (%c). Because
sprintf() returns the length excluding the terminating null byte,
subsequent sprintf() calls overwrote the required null separators.

This caused the options to be concatenated into a single malformed
string (e.g., "tsize0blksize1468") which breaks strict TFTP servers
like atftpd, causing them to reply with empty packets or drop the
connection.

Fix this by explicitly using strcpy() for the option names and manually
advancing the pointer to ensure the null bytes are preserved.

Signed-off-by: Chencheng Zhang <charles.cc.zhang@gmail.com>
---
 net/tftp.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 5f2e0a2bc06..5a8094791ab 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -355,20 +355,29 @@ static void tftp_send(void)
 		debug("send option \"timeout %s\"\n", (char *)pkt);
 		pkt += strlen((char *)pkt) + 1;
 #ifdef CONFIG_TFTP_TSIZE
-		pkt += sprintf((char *)pkt, "tsize%c%u%c",
-				0, net_boot_file_size, 0);
+		/* Write "tsize" + \0 */
+		strcpy((char *)pkt, "tsize");
+		pkt += 6; /* 5 chars + 1 null */
+
+		/* Write the value + \0 */
+		pkt += sprintf((char *)pkt, "%u", net_boot_file_size) + 1;
 #endif
-		/* try for more effic. blk size */
-		pkt += sprintf((char *)pkt, "blksize%c%d%c",
-				0, tftp_block_size_option, 0);
 
-		/* try for more effic. window size.
-		 * Implemented only for tftp get.
-		 * Don't bother sending if it's 1
-		 */
-		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1)
-			pkt += sprintf((char *)pkt, "windowsize%c%d%c",
-					0, tftp_window_size_option, 0);
+		/* Write "blksize" + \0 */
+		strcpy((char *)pkt, "blksize");
+		pkt += 8; /* 7 chars + 1 null */
+
+		/* Write the value + \0 */
+		pkt += sprintf((char *)pkt, "%d", tftp_block_size_option) + 1;
+
+		if (tftp_state == STATE_SEND_RRQ && tftp_window_size_option > 1) {
+			/* Write "windowsize" + \0 */
+			strcpy((char *)pkt, "windowsize");
+			pkt += 11; /* 10 chars + 1 null */
+
+			/* Write the value + \0 */
+			pkt += sprintf((char *)pkt, "%d", tftp_window_size_option) + 1;
+		}
 		len = pkt - xp;
 		break;
 
-- 
2.34.1

