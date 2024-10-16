Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0325D1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2EF88FED;
	Wed, 16 Oct 2024 12:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iqcmbf1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABB68900B; Wed, 16 Oct 2024 12:05:03 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FCC88FF1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f8490856so3392520e87.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073095; x=1729677895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faheA9ipuCMxyKpZyBroaFBcMuTa6BH6eUOSG4QJjNo=;
 b=Iqcmbf1iKDzvEvw/v8jhyQRJ090j9hxCOjyg8nX4rxF89o1kwSG7Z6g7E5H5zOqeH9
 C0/a68sd6erL7iGPfn3bfQpmxgq/E/aZCuQqwPG29Y4qVQlOQikrONvOO893r+lUVF9p
 f1wWgISPWlQAe+YARKVnd3xWfeN8ThqGmFeQP0gj6drITkyQ1VYWArTHVg9BT3cEx6nD
 Df8EGnzQDgifvcdHv/VxmbrX2jYKufGNt33MauYREnQbrxr2UutcF+JkKqz4a89KcSyh
 xO8FLbw4cUV4NzTKI35f/rEFdS/cXn8jBbQuKGGAKw90w/RcaK7FLvJSDxihN/mabWed
 BP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073095; x=1729677895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faheA9ipuCMxyKpZyBroaFBcMuTa6BH6eUOSG4QJjNo=;
 b=ViclFH3Idnq9l9KTCaeUI0w4KTtWnQ5YtGatDG3qFUfTVKQ/fF0ONo8UzwRzQm/UTY
 EAnj6nXl17x2LtFkn4sbIvhi/KoUL9nRyyRh/XfphVh3A4nsJ7OssOfOX5yICbJ9u0j0
 xfVggMoWujrf5o5+YxyjNiR5hkHh7LAlEVChXOTY7QB0NoGzyudyMEwycRYpZg3iWeYn
 6L3fmBNedB9DdaFLaC/s8AiRpkE0Ze9rBiFCzbsaTzlMahZPTKDLY7DeG3A8eEuzcKGX
 St9lUeG4koApo1tlzhyYkUROqZTb6QlZw70S41RYrH8o6u+1cqGYlK7PuETems4LC90H
 DByQ==
X-Gm-Message-State: AOJu0YzjFeXPBPDIEWSGVC8TCfvKOnGqFzIAKG2zOILcoFX34cLUBgBG
 Ny0YbbUrykGOjINM2uPxe6XarhvFxm/G2wU1H0tHX8/cdJ8Q7hmGbxaEL4MWhr1yeLF9BRLQGy9
 5Xb6oqbQW
X-Google-Smtp-Source: AGHT+IFjQ2tDOh2zPnRIlttObrmCv05m0nGkVUsBORQ1RMerKTzJBdF+PVDewGKJawekRvDzQTwmBg==
X-Received: by 2002:a05:6512:114f:b0:535:6992:f2cb with SMTP id
 2adb3069b0e04-539da586e45mr8919786e87.42.1729073095199; 
 Wed, 16 Oct 2024 03:04:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:04:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v13 10/21] net: lwip: tftp: bind to TFTP port only when in
 server mode
Date: Wed, 16 Oct 2024 12:04:04 +0200
Message-Id: <5484ceb32b3ddbe7cafd997a45cfddec5c8acbbd.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

Submitted upstream: https://savannah.nongnu.org/patch/?10480

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

