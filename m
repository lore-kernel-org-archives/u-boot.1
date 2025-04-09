Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE68C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 17:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C9A838EC;
	Wed,  9 Apr 2025 19:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJjccdrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43255838D4; Wed,  9 Apr 2025 19:17:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32132838CC
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 19:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso52316025e9.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744219057; x=1744823857; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YhPWz1zU0k7vq2o/GLz6wanM7+ZfomvcNWlU0131ndE=;
 b=WJjccdrU1HA5brysOjRuUAqaIJ8wI0fIk1uzr9m5uvEWQ7XVLNjM8wQZqkqtY/JrnY
 gNCj9AVcRD8l68l+93mjdaIgM37I663bUm+W0THPNzHlYD2j4YYRMTsBkBUS0b3mQx6O
 rkiISDqdmJlF6CpmXfN1Iwn6zK8ybhqfOQhPgEPDsT/KM894IZxjxptHON4I6VdESt/S
 Ukq0yPO6n5XDnSkqc/ov7mue4JBjUoyx2Fk4fR6Krm9ZKeJ6NYqsyl+BFU7gpRN2aVE3
 da8KmECscCq3xQBOiqYoS+dx57jpgyeZOKVFutgSu6JzdMcnKf0FELb0ybLVv1zr2kvK
 8x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219057; x=1744823857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhPWz1zU0k7vq2o/GLz6wanM7+ZfomvcNWlU0131ndE=;
 b=Auhmp03SSqqrlDvgijEtJpPN3juiZuq14NBFylLFz+kcx3/tc2lGCSsYBY6S/xdOnN
 HNZb+vY1pcHYhYnTSi7gss4Z+yL8LxLamx3J797GK1cY5dVcMNfwGSU3SDcXOmR6vtQJ
 YaFhVjskaBHf6ONv/DYAuX1zTvf7sjSsI0KmGVaHAsHlM5e8+FShoSjlQD7TNXm21zaY
 5D9hZFafI8NRkqlkFI9eF5yUu/J3OZRpgIGQAPOzL8uWlpgKYIVUjPNRoyUvvMLBMweG
 83CR/6gbJYq4dTrJl8ONpB1Mnmt/FYAstqdbtEOLeEvUlUEjTv6yzuESm5w6sXQrWjBU
 WOLA==
X-Gm-Message-State: AOJu0YwmzUTVGB8sHGPG0PKsjVWcIxQbGEaFdrLlDcVCOJT4J3mjk2qm
 O9iHa4u+LxsklRUXNkHGPNtFT7cGlp6q/a8+HfTV1qsMTMxfD469WCW3FpOFprVUat8XkFCs8+Z
 gLTk=
X-Gm-Gg: ASbGncsm7bS0vA98w16NaNoodCoM05EcaXoxuJBqjE1AYCsTvvM7pHwoD7xGFo6g0GQ
 nKs6oG8j65OzZUTZC0N7WtF9j4T2p8guHwg1IXPZ+eGt80tjZwuQzznSHejI0CjuhOI+waKhZ2i
 zsWd5Uj7Qc/JXWf4Fb14O5+A21vtHa4cIK2jtb0mg+z0QZtFZUXVSE2VYiu92HnDw6yPq2P0VcM
 gy5oW0TogSGRnMj8Uv8ARO5dovCtkoO4vA6CUlPL787w1zttkMSx3wg5m4ZYDlp41IU2dAZNGWk
 xKxCL81YODDJJ+WN0j6NgokzyDXceD7vGcKXd2GOkJPF+Qma+RTWF0F/EjtRxkYTgzZ11Y9FVlh
 fngg38Q==
X-Google-Smtp-Source: AGHT+IF5PYhL+SgVfRWQySsgJK6aLFDLZRrDklKbqjk+wN6dPJajEigKAzVY0+RLtPgCqkGVHLkZNQ==
X-Received: by 2002:a05:600c:1e26:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43f1fe16701mr35489425e9.8.1744219057305; 
 Wed, 09 Apr 2025 10:17:37 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c817dsm21916455e9.23.2025.04.09.10.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 10:17:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 09 Apr 2025 19:17:24 +0200
Subject: [PATCH 1/6] event: signal when livetree has been built
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GJfBWxPn1dAIKuP0Hxc2/0HOkPVH9R5cPjBDOpCQCOA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn9qutNawb+71LkOu93kV3wsbzJzuM2vRtcyYSp
 Le1h5MIotSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/arrQAKCRAFgzErGV9k
 tgiAEACUdEgjAB5Qr4vTG9l9aPJrOP6jssZgUYHxd3dd8Aj+hLadJQWhinwE1nTkwYmERYJSAx5
 ixjjyrnW0Ug+m7HZwn5n40X6qpMmE+G3YKDS+Ej15nJb3HkgU3wAVCfwANHePtRXi8NBls33LXT
 kWRHGWuYvtwZEaEg729lLGDnJPsPmcw6gsCGmlEhnsTMdqyPCnSZjxdbR1gF1L0XUiOAODlIfEK
 fJQyt4w+9E6AEhrSnBVizUj9Me+yhyvCZfoTAaU7iKmEWaB7nRqkIbw7qLHsAGG5XGNjBQYl3mM
 /c+tzTRewHGlPbG3f+4ADcTM6ArC0t2Bk5F9Q2ruDuqJ77wyueH73x69m6+kqWnF6PH9XS4HU6X
 uSW6AOe5cINroyNIjVUDtxrvSxK4IXzRpcox/6AEvfTPpgTTxG8pqY4fRdX99tae4+GIwV7oJ8P
 xgl4uU4x0VsC7U6aWdAS59rpvOSVyAda0DESA5b1Zyta9xr1AG8PYTKt3fuMC55eFT/jqUbhv9K
 5zW5BhLMixL4+0BoupMqzLCC0gapoMBHIMucCnOLTPsdSBdemt9qMcBSzwIUcWSyGxot8s29RJV
 rRMo86pd8Jk0v5bNR66uQnQx4Yyd+WNKNuVbk9iErdk7WsP5P4vI9VhcG1Bn4brwmqG3IUD8gVY
 R9+7g3+r1u6fP6g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

OF_LIVE offers a variety of benefits, one of them being that the live
tree can be modified without caring about the underlying FDT. This is
particularly valuable for working around U-Boot limitations like lacking
USB superspeed support on Qualcomm platforms, no runtime OTG, or
peripherals like the sdcard being broken (and displaying potentially
worrying error messages).

Add an event to signal when the live tree has been built so that we can
apply fixups to it directly before devices are bound.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/event.c  | 3 +++
 include/event.h | 9 +++++++++
 lib/of_live.c   | 3 +++
 3 files changed, 15 insertions(+)

diff --git a/common/event.c b/common/event.c
index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
--- a/common/event.c
+++ b/common/event.c
@@ -47,8 +47,11 @@ const char *const type_name[] = {
 	"ft_fixup",
 
 	/* main loop events */
 	"main_loop",
+
+	/* livetree has been built */
+	"of_live_init",
 };
 
 _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
 #endif
diff --git a/include/event.h b/include/event.h
index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
--- a/include/event.h
+++ b/include/event.h
@@ -152,8 +152,17 @@ enum event_t {
 	 * A non-zero return value causes the boot to fail.
 	 */
 	EVT_MAIN_LOOP,
 
+	/**
+	 * @EVT_OF_LIVE_INIT:
+	 * This event is triggered immediately after the live device tree has been
+	 * built. This allows for machine specific fixups to be done to the live tree
+	 * (like disabling known-unsupported devices) before DM init happens. This
+	 * event is only available if OF_LIVE is enabled and is only used after relocation.
+	 */
+	EVT_OF_LIVE_INIT,
+
 	/**
 	 * @EVT_COUNT:
 	 * This constants holds the maximum event number + 1 and is used when
 	 * looping over all event classes.
diff --git a/lib/of_live.c b/lib/of_live.c
index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
--- a/lib/of_live.c
+++ b/lib/of_live.c
@@ -10,8 +10,9 @@
 
 #define LOG_CATEGORY	LOGC_DT
 
 #include <abuf.h>
+#include <event.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <of_live.h>
 #include <malloc.h>
@@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
 		return ret;
 	}
 	debug("%s: stop\n", __func__);
 
+	event_notify_null(EVT_OF_LIVE_INIT);
+
 	return ret;
 }
 
 void of_live_free(struct device_node *root)

-- 
2.49.0

