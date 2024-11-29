Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF15D729E0
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 14:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3730F8932A;
	Fri, 29 Nov 2024 15:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kSt4Gqr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44C2C89021; Fri, 29 Nov 2024 15:47:51 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2296C893D0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 15:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e1721716so114298f8f.3
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 06:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732891668; x=1733496468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JVdDTznftY0MFtNMazEI8OUGmsYrwC3NO7GV6GFWTDo=;
 b=kSt4Gqr3S0eABXqP552RfB4Ot/TR90ju/gjn/pTVz+Q63/LbnmZlmX3OGnENxWGRnB
 c8d3sNpH5/JBXt3aU9fRzMXE6CmC8n0iNHywmucSpu1bCDkZKqdcRNU3CxbUGB69FA/M
 phpV6kDXwZvZ5QEsBJpIk6UEEhycO7vMOWv+5gYXlWmfm5VQyC/CGbHltguiFt/lWhSo
 Wi82/305xPTmp18Gc9AzadixFCIJTJUVdISwWV0CeZ8yCiw0gVtCe0hYbwaNFbiXPV1e
 o8OmKwWmKzQlkqAs/nydAcJbZ0Ua9T5fl6oZCviI3hLk5MOajd64qexQBfld8hemlnG6
 ElBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732891668; x=1733496468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JVdDTznftY0MFtNMazEI8OUGmsYrwC3NO7GV6GFWTDo=;
 b=aj7UqdrPSFxApg7S48PwH/m/QU+kkFgE3Fc5p6dgjFLpzy57o6iLyRpVi8vcSyzg52
 8NknP+0OCfoyjUsq+H3IwN3rwxk+JFDN9Kbnto9xfMYUAcNrtupS/lbfQkBMU5BghX3X
 3pPV4gmEBO9hFBjHA7k+lITO/EqLOKG3eoMArK0/hVWpMVWZlLtm2IIAqURocJSpYrWA
 jIoeFZ0W39vPOvCJowj1XsgpqlcEjb9hDgQoAjQGNZOQeNMbQUf13ewujXKT9m5nJ9Hc
 3CWFR0oJq8Hs50ACjMOIF5MB1aXnkQ42hbe85ztjn+GquDn93RcBgKnd4x1his0O5Qaf
 ZsRA==
X-Gm-Message-State: AOJu0Yz/TgwxbIreCFtmFlzKzfuCC/SboU3chMAGMUWIV2zjUzLl9Vav
 3jZ5o/1b7Mhx1utHNLT4BekjpAy9BcZ8HZ1XncVdjw+H1ktuu9BSTaaQWsfIsxtZ/3vqN/XgYAb
 oxzU=
X-Gm-Gg: ASbGncuLJ8ox3eS+EzhlMYrPIdHPMe6unqrB/GoJgcuI4sxFvQ2yQmc2c29csVngOsS
 YpJ7rHaRRTm6iUPS6HUTxD2rofNBn6JG+61GITlI4UmqE95SbRPNqJ3DUaHCCI28g40EHkwIn89
 BrZ75XARjUe7/1nfT4Bqa5/WxQ4Yx1MG807Paswfj9eZecZbexv/obEs0FfUULOSwu/4dY9Vp8+
 kE517cSwezy0Fnze9mOsSYweRh5Nq3fV7yVJo/O0XLSRqjxYDYXRbKh9FM=
X-Google-Smtp-Source: AGHT+IEpYM7fG0e99kkTSu0fDBwZ+lirvjIZTKkItxDYvarl2o4TcxLEKW4oMTt7yslJPNm5csfrog==
X-Received: by 2002:a5d:64e7:0:b0:381:f604:3d55 with SMTP id
 ffacd0b85a97d-385c6ef479dmr10389644f8f.52.1732891668376; 
 Fri, 29 Nov 2024 06:47:48 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2e1bdsm4760309f8f.9.2024.11.29.06.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 06:47:48 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] net: tftpput: reset timeout_count when an ACK is received
Date: Fri, 29 Nov 2024 15:47:32 +0100
Message-ID: <20241129144733.779043-1-jerome.forissier@linaro.org>
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

timeout_count is never reset once a tftpput transfer has started. If for
whatever reason timeouts occur frequently, but the server keeps replying
nonetheless, the transfer may be needlessly aborted.

Reset timer_count on reception of an ACK to avoid this situation.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/tftp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tftp.c b/net/tftp.c
index 704b20b4ff8..8d54a83d9c2 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -478,6 +478,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	case TFTP_ACK:
 #ifdef CONFIG_CMD_TFTPPUT
 		if (tftp_put_active) {
+			timeout_count = 0;
 			if (tftp_put_final_block_sent) {
 				tftp_complete();
 			} else {
-- 
2.43.0

