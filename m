Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD5EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F92864B4;
	Tue, 22 Aug 2023 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M9li/V1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3A3864BB; Tue, 22 Aug 2023 14:10:45 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580AB864C0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so41838365e9.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692706242; x=1693311042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ml3+TIYmWD5dL0OI3ZIP6fpYXFr+Y0RJGu8mlhZDFmI=;
 b=M9li/V1avnaggUJvKj1zJVENkmlw5Oafv3ym2Zju5yuwdVigKgAIJGm13bBFEX5xmF
 foLyguFZs71rHbBPPPnLhMbrwivAJ8eX8YGa+Z/RJ8zcWaKyj5Oum2Nz9Cbth1uvrPaZ
 +Pq6h/l7O30bR9c/35NMaYVJJG/8+Q0YWHpwkx8PxHFVyDDHoIVF0slH6JVkidWmAk7W
 /SOqwJQBVLSvLFkTvUsF9OkvLQD8RvWar+pP7gpz7SIffOcvwmNZJcTmZSeohpcoOqvT
 bkGlSX2YWaidSGCU/WeDPdjyv9fYf2O4Bxt3dWo9gYrAySKRfykDXTSY1pqB0Thz4mLD
 iGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692706242; x=1693311042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ml3+TIYmWD5dL0OI3ZIP6fpYXFr+Y0RJGu8mlhZDFmI=;
 b=Zgo18hJN/+ebGVe1AdUOGLDine+3zmCMtbSj12h863AJoScgFtWNq8UyuvtaJ/1K7o
 GZspp5Xit2una2YRlD9TSjzUItb1dD52f78xtogVGzCHIOohAid5nBISvDbOQbIwmQj2
 7GTPUTixY195DfwQr3WkOtzgah826uU67LUTx3UebGYlHnWdWiqK7xYrzVeczQG1n3F0
 gbuwsLS5iQ0cf8IE6ILsP8IdqrAZEAuCtMoUO3YzwDBOSejyWD8yNUiWab2YZlITH/83
 bJj0cH0mV9oIbkgfH3LTJ3vdmUGkuSPUOHBmtFzpD6CwIiAY8JQssNi+KWBxZ0C7sDjN
 QyHg==
X-Gm-Message-State: AOJu0YyfzGDj24gE69jyclCNe0S+/rCv8OB5BePaS0l8QcDVhlS4uHsP
 emNGeyPsouz4JdXPryij/JARzBnFiJg=
X-Google-Smtp-Source: AGHT+IE1aM54Y0pkIDTMAkEcbsW4A+pVZHPqiOSfnVN3iCSXVl14xSP7lCLHS5WjbMJ2IxbBP38Fsw==
X-Received: by 2002:a7b:c009:0:b0:3fe:1cac:37d7 with SMTP id
 c9-20020a7bc009000000b003fe1cac37d7mr6643915wmb.10.1692706241505; 
 Tue, 22 Aug 2023 05:10:41 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffac2000000b0031753073abcsm15704611wrs.36.2023.08.22.05.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 05:10:41 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v2 1/7] qfw: Add WRITE definition
Date: Tue, 22 Aug 2023 15:10:19 +0300
Message-Id: <20230822121026.1007105-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
References: <20230822121026.1007105-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

The QEMU fw_cfg device supports writing entries as well. Add the constant
define for it so that we can leverage write functionality later.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

(no changes since v1)

 include/qfw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qfw.h b/include/qfw.h
index 42798fea7db4..d3aaa4d54efc 100644
--- a/include/qfw.h
+++ b/include/qfw.h
@@ -70,6 +70,7 @@ enum {
 #define FW_CFG_DMA_READ	(1 << 1)
 #define FW_CFG_DMA_SKIP	(1 << 2)
 #define FW_CFG_DMA_SELECT	(1 << 3)
+#define FW_CFG_DMA_WRITE	(1 << 4)
 
 /* Bit set in FW_CFG_ID response to indicate DMA interface availability. */
 #define FW_CFG_DMA_ENABLED	(1 << 1)
-- 
2.40.1

