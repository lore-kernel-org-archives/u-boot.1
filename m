Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B18DCEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F45D88E7A;
	Wed,  9 Oct 2024 16:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bgRws23l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24E5288EA7; Wed,  9 Oct 2024 16:50:29 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D57988FB7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so60592f8f.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485425; x=1729090225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=faheA9ipuCMxyKpZyBroaFBcMuTa6BH6eUOSG4QJjNo=;
 b=bgRws23lKbR75/ovfck3D53lnjMIZykTyboy7LIWDdxyrAtUPodr5CD0yicZvezROH
 x4jG62dnyLi6XDeAnXtYJYGZp/ojRORuC8h1Br4cDMdZ1GslhekvqdYZQAKi/uX87HAL
 bQdzxSHAALxK3J9v4UoDRA6gibGLIrky7VHS0cA1ejhi7xNt+Ut3Q3gNYiTFVZrcfamM
 2b3Ivyl3YRSGBQZGhUwwC80RKzHClLQpu/T4ot4CV41ennT7WllWKn/Zf2F+CSDPiZgy
 gRI/226IY4+RD1HCgA6pV5lMV3EuxEbC+pwR1KtUCOMB8QAcQUx3Mwnt9URnpNBNtNaL
 oe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485425; x=1729090225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=faheA9ipuCMxyKpZyBroaFBcMuTa6BH6eUOSG4QJjNo=;
 b=BS9XVipVq0vQVxeM7vPVxD/gNn+SKre5oGiBLoGEvDsr3iGH0KJJVlim+guEx06sFn
 42JnaSAJ6YkWf+eb6nL8b5mWGpNrsfbeS9Hy2Tqgz8Gn9aYnwltHVBnzQlE3VJSxC8ul
 mcAS3WQcU11xT5MmVJsRJtwKc4XgdDXmLnevouGFiNuwLvCxglirK0h9EkfFKQ/szHbO
 1mPtVSGARAkRpNjwWBiqBfN87RkNENV6U7c+WHFVYc/SP2NwSjfIdVWLNDpUsra8zOfv
 Bx6LQlbvsjzT5oT9BBWjJ9PaEDtvjLUVbY//j8Twwrnj0qvuvlRecxYb5FVNYldwnWsQ
 NY8g==
X-Gm-Message-State: AOJu0YyqOP2iEDWVdWgWGrU8CjsmX/avmV+rsBKXYIcALKdLS0l2dX/j
 5QZy9PlyjAPZcdsilH01T/F0+Lj5544+0K6q5pzNrIKv2sfCyu1CbiQOXgBhqd285DM1+/XAR2H
 lNjIOYTmL
X-Google-Smtp-Source: AGHT+IFDbl+9XqLijKQoKTAVPXITiQYyueA+t48V8IZaxuEWEsVI0jIdIrAz09qPQY30HStebFz1jQ==
X-Received: by 2002:adf:ed46:0:b0:37d:3196:76c1 with SMTP id
 ffacd0b85a97d-37d3a9f218bmr1544111f8f.25.1728485424669; 
 Wed, 09 Oct 2024 07:50:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v12 10/21] net: lwip: tftp: bind to TFTP port only when in
 server mode
Date: Wed,  9 Oct 2024 16:49:51 +0200
Message-Id: <1cd53e876ddbc1aac935987aadcba566843abb67.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

