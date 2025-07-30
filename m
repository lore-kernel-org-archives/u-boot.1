Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBDBC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 10:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5D781E13;
	Wed, 30 Jul 2025 12:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WrTVhb7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7AD81F6B; Wed, 30 Jul 2025 12:11:49 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 502C4803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 12:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b7886bee77so2825555f8f.0
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 03:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753870306; x=1754475106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=18wQUVS55t8PM9HLH1/6kP897FflXA4hroXx3zPVOmk=;
 b=WrTVhb7JgfODeDx4tr3Dc/GdhK2Y3yode0yGU5leyn4sVFjjCAXfPrQnSrQSoB3E9l
 Obaz2VV8fvkTQoRskBM1xPW8N1WZRzYJcxVzd9n4+vgsOQytvu6BVEbRidtk/izxQpUJ
 5tv80Cg4YDGQdrS5podl0B+R7sCFYxS2U2MOXltPoztRsFLIPnt3r1gGb6PLZXCyenvq
 PifIVdDvnx9wbF25AuWg2h8tf7elGYzRI7rTB6N/HNYhL8KtRQna1DfZ5I75rXQeE8nk
 BpkMt4qJvPsw9IXLdlXcAPcU0gzQ/Eqi0ZsEkFqQR/AFGvMaDxnf2HeszuA1vLtAnIeW
 2/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753870306; x=1754475106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=18wQUVS55t8PM9HLH1/6kP897FflXA4hroXx3zPVOmk=;
 b=R4fHNh1Ajg6UaXvKa7l3+Kp5p/2vgcNUS4X3m0pw2oHkBftotKn0di2pRIJ7SFo9CI
 pVYuVEWdJIM5dqSWDoQdrZ6SLn/bob4nnniLj99POhlyb8fbBb06xpnQgWv3oajM6PUG
 MpiPCwDvj9PT+HTg2dXu+6JchRpvNNrrMIoWz5rU8Cv0a0WfGnetESgvBJBlqKBwOyos
 GDbzKwmMz205ax4pvPW3YRpe81OACG+A4Us/aSWaqzZpc3lZduuJMCeea1sQr7y0fV+8
 2Qd0TBQhH7B9BWNTHjCOYCAJkOwYOqDxc9tpuDgtV16RVHeiCtAPPXmSKN+1GcCOb/uf
 T7Bw==
X-Gm-Message-State: AOJu0YyZ96s0+thU/rhdLBpCN4b2joPb1rMz0D5WTK3rG589gLmFnG3m
 nOrnHOT4iDXx3BbRPIMzVQ0WSjjMo9RYEP8wlIG15sSxoM0yZXaMxRElQln07OSR0rwHuOP00y6
 +8hYyP/uInw==
X-Gm-Gg: ASbGnculiwX39j/7ApCR12pG1Ectgn6hrF7ZeUlQa0HiWGJ7+vxKYXRWXNGMhfIJSaI
 UDYdl4NY7424awh1+ao7KrTgLWMGovl1CTObUxda5D9icw5T/oQSbD0YCi7e6ZQoHLUeLzKek3u
 DkSEvROUAju2HfdYbIFB2mKSrXK0H2JurfK5trglt1jiTm4Mo1p16bOsKZA0p7ZA/uhRQzNSAWh
 9xU0Ess8A1TSscO/QT5IHvGgNRn8BAGWaHIwwrs4lxvaxHS2hnFH4hzmUVILO7/ZwBGDWYK8nRE
 4Y8A/eMUxZHckAypj9sszwJcekfFIPgqF9eqjxCeyVoW0ErzwsPLNdlL0LoGWVbz4uJgVSJjJuw
 76ik/lXII/tIG6WqRefN2HucAI6PcEoE=
X-Google-Smtp-Source: AGHT+IF2fBnBq+RdTI75WI0Oa9hR+lOCxp2Qj0iBzr6qTpRwnj5stNjRKlZo6NfezXqtZB4X7k0ILQ==
X-Received: by 2002:a5d:5d0c:0:b0:3b7:75e8:bd17 with SMTP id
 ffacd0b85a97d-3b794fe4f05mr1829687f8f.8.1753870306518; 
 Wed, 30 Jul 2025 03:11:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:943a:6bdf:fddf:44a6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b795fa0890sm1946396f8f.39.2025.07.30.03.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 03:11:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] lwip: provide a sntp_format_time() function
Date: Wed, 30 Jul 2025 12:11:31 +0200
Message-ID: <20250730101136.1504730-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Provide a trivial implementation of sntp_format_time() to fix a build
error when CONFIG_LWIP_DEBUG=y:

lib/lwip/lwip/src/apps/sntp/sntp.c: In function ‘sntp_format_time’:
lib/lwip/lwip/src/apps/sntp/sntp.c:283:10: error: implicit declaration of function ‘ctime’ [-Werror=implicit-function-declaration]
  283 |   return ctime(&ut);
      |          ^~~~~

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 lib/lwip/u-boot/arch/cc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/lwip/u-boot/arch/cc.h b/lib/lwip/u-boot/arch/cc.h
index f91127ac565..92476db7502 100644
--- a/lib/lwip/u-boot/arch/cc.h
+++ b/lib/lwip/u-boot/arch/cc.h
@@ -47,4 +47,12 @@
 void sntp_set_system_time(uint32_t sec);
 #define SNTP_SET_SYSTEM_TIME(sec) sntp_set_system_time(sec)
 
+static inline const char *sntp_format_time(time_t t)
+{
+	static char buf[29]; /* "(time_t)" + 20 digits max + \0 */
+
+	snprintf(buf, sizeof(buf), "(time_t)%llu", t);
+	return buf;
+}
+#define sntp_format_time sntp_format_time
 #endif /* LWIP_ARCH_CC_H */
-- 
2.43.0

base-commit: a8f20bb6650df56d2600cda2c66f9349df9e49c8
branch: lwip-debug-fix
