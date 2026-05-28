Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAC1CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE8B8488B;
	Thu, 28 May 2026 19:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oHrMOuJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563B48341A; Thu, 28 May 2026 19:11:26 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E1884878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e66f966d01so1436650a34.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988283; x=1780593083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tnMu6NUALARGuItDiwQB2LJcM4//x1W5tPh9wPgESI=;
 b=oHrMOuJFYcAyRADVT9CZSWI4TZl4erwW4JnWlGiKG2mytSyEueYSGo5V4cx8dR0PnT
 0xTZafZB5PgOa4Wnw9V5iCTrk2mp/ho6Qdnl11JhE0RVIwmG/hvOcMfWjjI1cXStVcTn
 UtdYQAQW8M6sH4mmp/1pJ02qEwQblrxCFn9WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988283; x=1780593083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1tnMu6NUALARGuItDiwQB2LJcM4//x1W5tPh9wPgESI=;
 b=V7br6BclE6QyAfcrnIVSgSiO/tKZJKsiyfT5048p1vuQFNduyox5lHjimE8nDmQ8y7
 3QDEibwp5SRJpz+bIVMtN0EI5vHBbg589fM0sSYw+C1tl/yi0LeZgKtvFvFm5Vx3wS7g
 rJJgM26bDe/ITcIO5JxcWZvIGfbpXoCw+Sm5DvlgSFcX3o/VXJJe/yl26R4R4GHqbeu+
 6ndXiZApHiZeLcvZYu4qtEqIiCRcMfwWs+1by0EGLgMXR3mbvoJOk1+Oq59UOFPWT3D+
 KDBIZRhcKAXPIdpKcUns7qbDRg8hgnkkEN8qxUrnGbviTKU8tID54R4qsmTIDRjVKp0H
 Oncw==
X-Gm-Message-State: AOJu0Yzm10RSpymTT8un3JEGpRkYOMJNVgRcEIPIVhEre7fYS/YZ5SK6
 S+9WIP6W5Ka6R3J/IAcBd5fKt1JmrZ4AGHLO2N34f5n+LVgggM4j4D46aPbC5wY4Voy9P6Lta73
 NgljH+LWZprI=
X-Gm-Gg: Acq92OE3MrOwrGXASvesZmdw4PfXB3a66dK1dmfsHJDem16QtYL2Rxlq+oOMeMclX7R
 W6u9WAtCQ96twZSjsXX9Yip305RyAf5AMQC6V+xriZDcSEE6Uglyz55TirBERXF+IC9ZiSTpL7N
 why3g0pP7m8ldWN58pY/w7WMSKkaU82JCr5rsANsxlRZ2FI8uYKqG7aSEVocH6oaokA5k7cEtRI
 4DTl1R6XcNOh1iOSm7KxJAlg7WwU6qeCxZeyf+2wY/GybiUD9s2wcmHTUh6i0z7UXnj7EM1UTEE
 92iauup3RATtnu3HhWw3futBFQ5JyMWD9q7H5Zsv4ao8WJbf3tEyp3p114l72uDDlQE5ZjKhnRI
 PwQzMgeBHmnRbu5MlYQqvWbpQHS/R/NpJYaKzsJiJd0xXqD4SftMa0xYrQj0HB7X+Oxb1w/3gKu
 gw/5HHnwhmEDpvJ7j70u7tDMraUe7q7VHj8Qnp/ZQ=
X-Received: by 2002:a05:6830:7306:b0:7db:a8b7:c565 with SMTP id
 46e09a7af769-7e5ff02c891mr17257488a34.20.1779988282827; 
 Thu, 28 May 2026 10:11:22 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 12/22] rockchip: Update rk3399 bootph-tags for VPL
Date: Thu, 28 May 2026 11:10:19 -0600
Message-ID: <20260528171043.910264-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

(no changes since v3)

Changes in v3:
- Unindent bootph tags

Changes in v2:
- Only enable MMC when VPM is in use.

 arch/arm/dts/rk3399-u-boot.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 587eef9504e..8b530401541 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -46,7 +46,12 @@
 	       0x0 0xffa88800 0x0 0x1800
 	       0x0 0xffa8a000 0x0 0x2000
 	       0x0 0xffa8c000 0x0 0x1000>;
+#ifdef CONFIG_VPL
+	bootph-pre-ram;
+	bootph-some-ram;
+#else
 	bootph-all;
+#endif
 	status = "okay";
 };
 
@@ -93,6 +98,10 @@
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

