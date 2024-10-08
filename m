Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A31CEF14A
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 09:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2A6881C1;
	Tue,  8 Oct 2024 11:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="huh3X29/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF3A287042; Tue,  8 Oct 2024 11:47:10 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94E2E881E7
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 11:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so55566995e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 02:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728380828; x=1728985628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NxtKwgin+dTec8jNMnqOB2+d2mCQlec9BZDvKDdZslU=;
 b=huh3X29/lek7kQkyNeqyDhWt1fWMRYBF3I48D+HIwFP43PVifXNd1UZpSuSjXS0ypc
 u6GgV2PDZoUitz3TWvEX4K9Acb16+hPUhXiXheLsYcZDjCDEyXk/jgYTmAh69Eesfq1O
 PWQ7hSCO4dYUfYQdJL6cyry0x0JLY6tADngZ2wLeSxprrIn0RRMZ5JqAKbDOX0gDVy/q
 Qdl/bQTooYfTopQ5FG0NdcxuYjP9lMQrpEdirqTth1ZD/DBLSdruz+EjW3C5QfG3QsWp
 tkBzyzqoDiRNnVE2P+0BISv4keN61oC923BuvD+W6up7P5vmzBap6D0XMHO0RzU54vfS
 PQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728380828; x=1728985628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NxtKwgin+dTec8jNMnqOB2+d2mCQlec9BZDvKDdZslU=;
 b=HTsxj3hkn0axmpkjLXvpo2KS8/d4wIrw9L3RLYdRAbYVjtXrtjfqHkRv50V6cg+fjC
 TPhMVXaRzP9GztlEDP+8uctd88VX3AmnMB6lCVFG9OHLpvlFn8sEu0iCvYdir+dMavhg
 R9jy5jHEQvFf5b78TjX88H++KOTnL2rc+Ekc3z0DJzLgYLNveJNmwFmUX5HGNEWeOo9C
 LfWXR1uUxzY1I0ig7NdF4dSQtuxVRibbd3GspMHVrd3yvzMGcxZNk1IkpF6qYh3oFWPh
 OX4DsuSvvYUC0X2OoTJifC99wmSdtWS2DHHLWHDBjIXYoIIqer8qEKjQrJjOWbCWVZyC
 gykg==
X-Gm-Message-State: AOJu0Yxi2wMx/4CTPDdr2apKzA/im/4yQbHJN7zNOwg0qQC/YOV7hPo6
 22pUCs6MrY0pc7IogzN3/Tm5/OMdVjLGoGuzdnUYNvKHsTR+OdEbglGCvOaV4KKMD/ADnJcaFkn
 PcMSolw==
X-Google-Smtp-Source: AGHT+IFlVM9eMmged3ltIRGH91VBaJ6v5ngaBzN2SxlqaaFujfNFqxWIwtJM5NaKnWJgTpGkEn/w8Q==
X-Received: by 2002:a05:600c:3b08:b0:42c:b63e:fea6 with SMTP id
 5b1f17b1804b1-42f85ae927fmr122652725e9.22.1728380827741; 
 Tue, 08 Oct 2024 02:47:07 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d1c8:3266:1994:6cca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b44374sm120927805e9.30.2024.10.08.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 02:47:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH] net: wget: check strict_strtoul() return value
Date: Tue,  8 Oct 2024 11:46:46 +0200
Message-Id: <20241008094646.4052174-1-jerome.forissier@linaro.org>
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

Check the return value of strict_strtoul() when processing the
Content-Length header as recommended by Coverity [1].

[1] https://lists.denx.de/pipermail/u-boot/2024-October/567050.html

Reported-by: Coverity (CID 510464)
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 net/wget.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/wget.c b/net/wget.c
index b4251e0f293..a3821495e03 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -256,7 +256,12 @@ static void wget_connected(uchar *pkt, unsigned int tcp_seq_num,
 				content_length = -1;
 			} else {
 				pos += sizeof(content_len) + 2;
-				strict_strtoul(pos, 10, &content_length);
+				if (strict_strtoul(pos, 10, &content_length) < 0) {
+					wget_loop_state = NETLOOP_FAIL;
+					wget_fail("wget: bad Content-Length\n", tcp_seq_num, tcp_ack_num, action);
+					net_set_state(NETLOOP_FAIL);
+					return;
+				}
 				debug_cond(DEBUG_WGET,
 					   "wget: Connected Len %lu\n",
 					   content_length);
-- 
2.40.1

