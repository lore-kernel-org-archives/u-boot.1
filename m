Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0816FC36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF69C81F0B;
	Fri, 28 Mar 2025 16:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mycg2O7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394D082012; Fri, 28 Mar 2025 16:36:20 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E162481F7E
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-854a68f5a9cso184147839f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176176; x=1743780976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SljPLue9x+4THljuxukTomKvCKXNMiElldFsXDO10aA=;
 b=Mycg2O7fw8CXTwn2bhM+UZo6G66VxmFWkpXL83k/5LAXwPWIHTgQngYAlY0UVWh2bG
 Wgsk7Ccm+YuwbgTQeWY46xJSAwOfoZaseplK53lE/ScvTAii/9EmVDCX5juQScQpZzPs
 q07ZVazrNwDHt3bAk61iPiPB5ZGny+RifrlF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176176; x=1743780976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SljPLue9x+4THljuxukTomKvCKXNMiElldFsXDO10aA=;
 b=Xm69+fs9du9NBOPLcPiO7xTaU5Qjw8tIspIMpmM2B2ZmjGN739DkQr8zPtIexZGD32
 IirzMc1m+38epdFenR/CcOOUqjm/kV/CcuCbQDk3XXHXnf3Zpbea4kdzI+jeDt20Cngn
 pGjzHhOttb9nigvyqyyXBM3jEH7F6Npa9OxwJ1AowKZbdP+BXix4L8usssBrIeWvcAmo
 RorRJTL1/Xr8KO+awZ7VcaUVrjK9ivn37FyIcrgyp4JRur+32xm5m7mn1UbHbypIrzeo
 QjGMF1DLtSVwFfwfkUDXMc8AchTxol14/KXUl81J0sxthrp/sES39PsQi3AoxMLQmywd
 bq8Q==
X-Gm-Message-State: AOJu0YwQCG7KV2O5qdE+Do9nP68NjcgVYjflMqGO+u62PeAPJqx46wyd
 02363iTiMQMQxYsNwj5buYqMjtdcHEv+alK1m+1d76PM8DyrCn7fb6a72P6P/ysCCSY4046SNbU
 =
X-Gm-Gg: ASbGncv1nXiimFUtSbFx1weNMnnE2ubMl51xZ+LgOWYqk+FbafZtj7dxI/BUAGK8xZu
 x4TEyHrXk76ATCkEvvr8l2StHuKGLcqNG7qHcc+JeL649bvAOWTLTrfXQmW5OpT/XCxfkWnD3/F
 wSqWI06XWTssjqWsGNi12FRZHR8zypw1nZ+QTg1RpQ5B6YUpx73AiFhNU9S3ONiTPBxtt6OLws6
 BQIARwSDE62VqQC0NuPyN2jebpqzUJupLKZ4J57eK0oxvs+43KytqwnSXntvWNblgSFzc875X8i
 joOHdTuowxdS6kZstd6U2cUGhwSOei5+K+Zu/nQyLx+nPPlpIkafktF5G0VP3kijs92uakAD7oL
 FrpAYXg==
X-Google-Smtp-Source: AGHT+IGCoS3QnAl/1W04HG6S8DUa3Sfj5JF9QYT+QztqF3+tcrdlGEIdiiSgBqpvhTwtqFuxMpZS4w==
X-Received: by 2002:a05:6602:6a88:b0:85b:48e7:14fd with SMTP id
 ca18e2360f4ac-85e82197d29mr1104874439f.14.1743176175843; 
 Fri, 28 Mar 2025 08:36:15 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 18/31] rockchip: Update rk3399 bootph-tags for VPL
Date: Fri, 28 Mar 2025 09:34:58 -0600
Message-ID: <20250328153522.3555472-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

When VPL is in use, memory init happens in SPL, so there is no need to
include the DMC device before that. Adjust the tags to save space.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Only enable MMC when VPM is in use.

 arch/arm/dts/rk3399-u-boot.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 81a3c6fc972..c3d0da62c8f 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -71,7 +71,12 @@
 	       0x0 0xffa88800 0x0 0x1800
 	       0x0 0xffa8a000 0x0 0x2000
 	       0x0 0xffa8c000 0x0 0x1000>;
-	bootph-all;
+#ifdef CONFIG_VPL
+		bootph-pre-ram;
+		bootph-some-ram;
+#else
+		bootph-all;
+#endif
 	status = "okay";
 };
 
@@ -118,6 +123,10 @@
 };
 
 &sdmmc {
+#ifdef CONFIG_VPL
+	bootph-pre-sram;
+	bootph-verify;
+#endif
 	bootph-pre-ram;
 	bootph-some-ram;
 
-- 
2.43.0

