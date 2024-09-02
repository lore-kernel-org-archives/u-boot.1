Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEEACA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 12:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D06F88A3C;
	Mon,  2 Sep 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XtFa9K6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFF588C19; Mon,  2 Sep 2024 14:59:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF9888847
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 14:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bc19e94bdso19546805e9.3
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725281977; x=1725886777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0/ry+ojZem+NTxvGgSSZu/nQchgSRoEANAxsdwDpC/0=;
 b=XtFa9K6Ysn0bW4ZK/VE0eLZctz6veiUiRXtEvZmjerf6fJOZcFp8He47gnrk39xVPp
 hFC5LafGWBQCoSmwVNZkUFKfZA9KQ+ibLv/nKeHnieHGkSg722JBpNzC8zUDmrZ7RbE0
 Wf626jlHvTTzjSZQpHn7CCTEWk+YjGTjrjjLC8U/TUlZkymMwgyTXiE+TtjYCXuJX8x7
 VT/M/5ZMeTRm9JZNVjARZWdqWTks2RekykG1iBxNxbtb7mQCB4fdd24kW6eCKx16EVNG
 GAhvBgCZb6J2L4cMFcKa91z9QrlEhWlOW+Z17IfOR+h0G6CdpHYX6bT0lN+uIRrHnXQo
 CpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725281977; x=1725886777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0/ry+ojZem+NTxvGgSSZu/nQchgSRoEANAxsdwDpC/0=;
 b=VQ32ToLQbL82j2ab8nCCN6VJvefVapnXO97GtuzVqnkjg4fb0keEbilAjEQk/rHevd
 tcPJcF2odlcBtiWhamnqt1DrZPew5kat+uIAu3aRKBoGI5Ui9LCnZxL2BAt6ZpFEXctH
 +b8nHoGpbimgzuV5hTKxiMR5EZDeHBh0EMNhsH7RV9hMsty1hb5wzEfJvOuESeSZH//c
 ACfKvYM1GFGIrY65Wdl8CASDjHSDwCoahxT81+JyW8ARZvL4pvux+DaiF3798+lvTDcz
 q47A0j2FMfoGvPhgMxfoJ9MkbF0detnx+I+Yz6F0Vm5eGpAslkcGEEqtt6LUR5oFS35N
 sKQQ==
X-Gm-Message-State: AOJu0YxP+3lACDNhuEIovXBEE+KFFZtwJk4/lavZdY2TEgyxSPrcpLp8
 1/3aQvM41Bl060kyJ4i3kXI69Y3EFRkYrinwbgroFKhFZnxOIkIbq5DooMT0L5TxpCqSfqINZUL
 OpCyTxA==
X-Google-Smtp-Source: AGHT+IHKUYF9rKRc48LPGrFEOOOiaVSnycHZRPqEPjYc3kpqNfr62Zf6zAXo5nQJN0GDacTsEZRXSA==
X-Received: by 2002:a05:600c:4fd3:b0:428:1007:6068 with SMTP id
 5b1f17b1804b1-42bb01fb0e4mr119722675e9.34.1725281976627; 
 Mon, 02 Sep 2024 05:59:36 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ef7e109sm11304424f8f.67.2024.09.02.05.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 05:59:36 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] net: guard call to tftp_start() with #if
 defined(CONFIG_CMD_TFTPBOOT)
Date: Mon,  2 Sep 2024 14:59:16 +0200
Message-Id: <20240902125917.119941-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

net_auto_load() cannot call tftp_start() if CONFIG_CMD_TFTPBOOT is
disabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/net.c b/net/net.c
index d9bc9df643f..35961ba1c7d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -334,6 +334,7 @@ void net_auto_load(void)
 		net_set_state(NETLOOP_SUCCESS);
 		return;
 	}
+#if defined(CONFIG_CMD_TFTPBOOT)
 	if (net_check_prereq(TFTPGET)) {
 /* We aren't expecting to get a serverip, so just accept the assigned IP */
 		if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
@@ -345,6 +346,7 @@ void net_auto_load(void)
 		return;
 	}
 	tftp_start(TFTPGET);
+#endif
 }
 
 static int net_init_loop(void)
-- 
2.40.1

