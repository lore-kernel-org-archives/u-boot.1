Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89F5CF34B6
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40619884DB;
	Thu,  3 Oct 2024 17:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xRLOKtI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F88487FED; Thu,  3 Oct 2024 17:47:08 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4C288E3F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37ce18b042fso895452f8f.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970424; x=1728575224; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wj69R6ikNoWeeLXnoHmRr+jR91T4/HWFHpytBi3xnWU=;
 b=xRLOKtI7cVGwe6nnE5tty4sTG8JmMgti3zSDIAxagzr1lBZ6NCMlRCNRtA4PE3XMxW
 YXCV1M0KD+h3l/mFZQBRwfdk88EhtxTPfe5aYgPCP43VdK2OVc4hRsP1pvqz8IGOAb8s
 ixnXXnqx4D0PfAuctsKz78mbUsIz2z+WJuY0uApMI3Dz4Ftx9LQX/y+i0ubGiNyRluF8
 G1HEBmTC6AZRUhXyaeivMwUwpRISM41H1J9ijX95AiRWix1YSQn5JABp5otDMT4Dywjk
 7ABvHFYXX1/w49KgaBbhp01TgOKoKT9AauI//o/m000aZ4uQUzL4EzEIzRAali3nXB3u
 zpRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970424; x=1728575224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wj69R6ikNoWeeLXnoHmRr+jR91T4/HWFHpytBi3xnWU=;
 b=nwU6+qfWlWcuA0g7OTBvNVI0sKiAIkLO5dgg43bqNRVr8lPto4ToFMJFTzm9B11dN3
 310En4J7y1uTyKyPwmKQMgjSP9WZitQ9qdYCCANRg05hLNdd4AipjthZ+BNz5ADsMHBG
 dlga8+TtlRw+HwlnYXlCzY4XOJKB+pTJVKpc30YqPZn1Z2oZJEYyj/oE16Hf9W09/YzI
 4Vq20Tu8IMpaZuxDjFGkTf0WuEgRCQOOMVC+dcCIFe1Mzp0uZUTpbviv3fxMa5+wL3KI
 aQVWcGmSeGsylJjgF6TrNLqASnlqaTp0iFB9edEzbs3GDD0RTwGtI/qlpzB4QSMRJJfA
 Rzmg==
X-Gm-Message-State: AOJu0Yzhr0M8Lan7q4wpnL930MciCgvbWA3uglTVCiDB5OiReq5/ozFP
 l6CCMOg3kr/VHLPsaTnZ8ReAlq7u3NGulqoN9oTBlXgLeVIoaUn7Ln3JOQbkDJPTNGi5vPHUHYS
 f0M9uupDd
X-Google-Smtp-Source: AGHT+IF6+jmVMzG+KDCbQOgACHgBJe7OO8QFNt84OEU6J21MEedEXTOcv+tYCg35mnSwShqkx86e0Q==
X-Received: by 2002:a5d:464f:0:b0:37c:d23f:e464 with SMTP id
 ffacd0b85a97d-37cfba0694fmr4393669f8f.38.1727970424248; 
 Thu, 03 Oct 2024 08:47:04 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:02 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v11 14/29] lwip: tftp: bind to TFTP port only when in server
 mode
Date: Thu,  3 Oct 2024 17:46:18 +0200
Message-Id: <c29c2aa6fc0f1a97afff121e2f42abcac5b671f2.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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

The TFTP app should not bind to the TFTP server port when configured as
a client. Instead, the local port should be chosen from the dynamic
range (49152 ~ 65535) so that if the application is stopped and started
again, the remote server will not consider the new packets as part of
the same context (which would cause an error since a new RRQ would be
unexpected).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 lib/lwip/lwip/src/apps/tftp/tftp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index ddfdbfc0c1b..74fc1fbe586 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -454,10 +454,12 @@ tftp_init_common(u8_t mode, const struct tftp_context *ctx)
     return ERR_MEM;
   }
 
-  ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
-  if (ret != ERR_OK) {
-    udp_remove(pcb);
-    return ret;
+  if (mode == LWIP_TFTP_MODE_SERVER) {
+    ret = udp_bind(pcb, IP_ANY_TYPE, TFTP_PORT);
+    if (ret != ERR_OK) {
+      udp_remove(pcb);
+      return ret;
+    }
   }
 
   tftp_state.handle    = NULL;
-- 
2.40.1

