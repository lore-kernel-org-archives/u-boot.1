Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ACEEE4987
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 09:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1848789266;
	Wed, 11 Sep 2024 11:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tHbAjfCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7839C89254; Wed, 11 Sep 2024 11:58:56 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BCB8923F
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so17757225e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048734; x=1726653534; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+kKclKOdggmvQLqu7epBFwPbgxjPaxHLYxPdceOudQ=;
 b=tHbAjfCCbF1fxSkwIt5lHG91PyB60hyIxoFEPHeL5cujVFxkTxIWW4OuT/XKWJiwSu
 HTuxJThKZ1Oc2VuoLELOpcCiWzQYIvBXJKkcm6BBe7iC4ejgOxCTVZvPfkZqHo5Umlwu
 Ax4GtmKDo2hEX6166CK6IGA225P/bUfT4+ObWW1oAEPeTd8Xr9qirOwiV2GOHdUX/yJg
 hjkv26ekb4zN8RuSuhttui0GPYjLUudGN1YCwgcMaC/xxYx1bYbI0j8VzOLBw5SQKSlY
 IThK267iPvYDEJEfAQaCEJhyVwVmvbAIrCrF2arNZenziG5OpNmj8+g4EwNOzX4Mw2Sy
 QzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048734; x=1726653534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+kKclKOdggmvQLqu7epBFwPbgxjPaxHLYxPdceOudQ=;
 b=BN9aogRikSoqMDoj55egQM2snnXMKsMSmgQP0064C1DnogqBFd9ggja4bJrhI7n4A7
 lDOWjbNzEo39L2ffZj2glKhV4x0xKqDCg05/BkgnNb9GYMa8Rs3dWYQ79N5sL+PTB4V/
 e69RfptsFQHxvWvMGYUIUWfgtO6NgXI+OypMye/pU0Sz6ymthU2t1VTDnONALRNg8HPs
 nxVTG842Tll08Qx38NGGaANh6dTLyA9T02S4Eff8nnbW8GKY0PC+fZBs/MDSOnhfBF8R
 yyfXMdnZGLlQGkeeZ6ucHt0HG077G3lbCA9p2XooOgcDn3qqyJNo3R9r/vgAMNeHOT3k
 +GQg==
X-Gm-Message-State: AOJu0Yza4yB7oDokoPvJKwwQVV8rpHSBIwayOtdycSLg5iqJVZ50+0eB
 YcTkL7W3MEDGKU1rg3VkQtbXN2PHyHB/ywBmpoCKxcWs16L2zJT/bafuSTAzT9OkzvkwKO2CNcp
 UJZhg/g==
X-Google-Smtp-Source: AGHT+IGWmODcaUfHFw8KLGyJAwGoNsAqtap7YeliXeEk5ehCnAAPQvD2Xn7ux4M/iDJApbaNtWzhJw==
X-Received: by 2002:a05:600c:3505:b0:42c:b950:680b with SMTP id
 5b1f17b1804b1-42ccd32def2mr18513405e9.20.1726048733758; 
 Wed, 11 Sep 2024 02:58:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v4 06/15] net: wget: removed unused function wget_success()
Date: Wed, 11 Sep 2024 11:58:19 +0200
Message-Id: <b5f87a420883cf1b1557202e13a2f08c1734132a.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

wget_success() is used nowhere so remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 net/wget.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/wget.c b/net/wget.c
index 4a168641c65..6ebf9bca0d8 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -196,13 +196,6 @@ void wget_fail(char *error_message, unsigned int tcp_seq_num,
 	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
 }
 
-void wget_success(u8 action, unsigned int tcp_seq_num,
-		  unsigned int tcp_ack_num, int len, int packets)
-{
-	printf("Packets received %d, Transfer Successful\n", packets);
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
 /*
  * Interfaces of U-BOOT
  */
-- 
2.40.1

