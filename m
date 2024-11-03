Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80CFE67819
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 00:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4065D88F50;
	Sun,  3 Nov 2024 01:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GY6lyvXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528CD890A9; Sun,  3 Nov 2024 01:29:35 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3120288AAC
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 01:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7eda47b7343so1994600a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 17:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730593771; x=1731198571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HB0bL56wCXMH/06nY0ypfAruNqnyWJSwovtnSWYQ2c8=;
 b=GY6lyvXo+AkEKTtiUSr9qZ3iJ/B4UjzZo7Sgxb2H/4kiCsnnKhykkdvuc1JjbhYusg
 saQ01+5T8h1WsXANb1bPwmgi5WxOlVbUZ3eQ2+uhZ4NS+0y2D0xE4I4Y+LD2r+KahSjH
 8vgQ2yc3FYa8xR0H6PRvl73peHEF2wrsjXT1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730593771; x=1731198571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HB0bL56wCXMH/06nY0ypfAruNqnyWJSwovtnSWYQ2c8=;
 b=JsEpgTzRIBelvpzbfDs8P/Na1q7GgW3czx7NttweVwakjofnlUDHowlFvEds/dBszf
 YcJHir9UuhBzgsAdbv4n1qdxbDDRc52oXjYrCJpVeQoAQ4QZMlKEyUgHNr7O4oqP/Rcc
 Sbq5Crb6jCXAdaKYyd+X/eF3Gfj161VTA4f81h6XvcV75irR2XF2N9/s6G117IDGxuFe
 5tsrM35hSy9zCVJODh5H/pS0F8FRz6lz7Vj6ON5Rx7SfqfOHlaoFqSR90MwZxVY1RwB2
 rTwE2LglrQ5lM3zFFJ3c+d/Sk2oc6CnkE9fY/zbI8p/sKE5HBZ1TfALOXL3UDsN6G2Jw
 G0VA==
X-Gm-Message-State: AOJu0YxwkPItAa8YKuUIno68sxILyERYDFYWZmVK4D/FsvyqQAp+f8e/
 izpoJhpk+e0iQcEhN0lHWTb0ohFs7Z8K0nQZR2Ta3k4jKHOt85QsHUIFFwS5viPxnJbKWbtc7uP
 2iQ==
X-Google-Smtp-Source: AGHT+IG25Qy3YYEymEtErLFrSmhCBerQl4XqaymjX6mV9/MWGCedOX5GywBMAxU6o4LTDh0GFGR26g==
X-Received: by 2002:a17:902:e843:b0:20b:b39d:9735 with SMTP id
 d9443c01a7336-210c6c823dbmr403256235ad.54.1730593770954; 
 Sat, 02 Nov 2024 17:29:30 -0700 (PDT)
Received: from chromium.org ([205.220.129.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211056edc65sm39133335ad.10.2024.11.02.17.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 17:29:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v4 1/9] kernel: Document ALIGN macros
Date: Sat,  2 Nov 2024 18:28:18 -0600
Message-ID: <20241103002828.624931-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241103002828.624931-1-sjg@chromium.org>
References: <20241103002828.624931-1-sjg@chromium.org>
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

Add comments for these macros, so it is clear what they do.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/linux/kernel.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9467edd65ab..e5557257e6f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -35,9 +35,40 @@
 
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
+/**
+ * Rounds a value up to a given alignment
+ *
+ * Note that @a must be a power of two
+ *
+ * Returns the lowest value >= @x which is a multiple of @a
+ *
+ * For example ALIGN(0x123, 8) == 0x128
+ */
 #define ALIGN(x,a)		__ALIGN_MASK((x),(typeof(x))(a)-1)
+
+/**
+ * Rounds a down to a given alignment
+ *
+ * Note that @a must be a power of two
+ *
+ * Returns the highest value <= @x which is a multiple of @a
+ *
+ * For example ALIGN_DOWN(0x123, 8) == 0x120
+ * ALIGN_DOWN(0x120, 16) == 0x120
+ */
 #define ALIGN_DOWN(x, a)	ALIGN((x) - ((a) - 1), (a))
+
+/**
+ * Rounds a value up to a given alignment-mask
+*
+ * Note that @mask must be one less than a power of two
+ *
+ * Returns the lowest value >= @x where the bits set in @mask are 0
+ *
+ * For example __ALIGN_MASK(0x123, 0xf) == 0x130
+ */
 #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
+
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
-- 
2.43.0

