Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4227DC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCC18205A;
	Fri, 28 Mar 2025 14:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BBcO1Feh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFC981EC5; Fri, 28 Mar 2025 14:07:53 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A354981E5A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85b3f92c866so35160339f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167268; x=1743772068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ypoRIDd8JyfcfOWXR2uwl6yHuinv0JUpedZx2EP4Po=;
 b=BBcO1FehX/eF2EC8O4UYWoq/xZSgxvdFNWmpR+pmFT2MHnLCJO7v9crkqJtj0+QMBl
 eh5PWVPRbmQxmuK2ut3LCcep0r99xLxoaj9pzpddvBn19q5YG8zG93COS22ZXFJm5crP
 Pz0x0PbOMLAY2EppJ0O2cvLV0SOHNYbVU5hWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167268; x=1743772068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ypoRIDd8JyfcfOWXR2uwl6yHuinv0JUpedZx2EP4Po=;
 b=US1Q1JHHxlvNUGxvkP5pmWug+6bc+s7PU7VXEzL7tBSTWJT/SfmphyESi3nVrVJuBI
 ztbAT+hJ52YdFVqDxj5cHIM6d8YJ/qX5VKNF1NC8MgkAkFMbVqqrxJ/51s8ncEq5SOhx
 +uyFLVw5+sP34B0Z18KEiTNu7q3tFnAX1vFMS2B4Q1OA//dJP/JA3Q75O9JCWPbnVpNk
 IUf2rTCHFYVn7Oxb9B3cm5BdTzpLgIqfsdpodb++9DUSY2aFuMRlZSTO41r3TfRzV/i8
 tRji6EwYrrOZWWi2/zvOxoil75l5P3lDJd/rrkBqsmrOYNMgpGw10xwkFrRgz3V8hMpK
 po5w==
X-Gm-Message-State: AOJu0YyQ025isJ60hCZpRAsrxtwycwwpLx8qRgykIC1Oq0d8vXuh1F+O
 qn2jkUv65i0k+HThGKIRFMVdnGviZAafCnmbKdCrO18OoqDh8E8DbfpiDvQdIy2xDQGTIMd4pgg
 =
X-Gm-Gg: ASbGncsTF8hgNGuHnUQcYEno1sM2L8WQTJTedU2+S7Dkc0SktL/vzDoXC5Xp1kYO5I7
 9ZKOQFCr+2BGBjxddxWvg05OJ5DPuhjIc+cQY+Lcqbm5+he/y1/tru7uEmo6VcZ/gQ575+XwHFc
 qTAkIrQVteg6ULGhc1N4cQARRrt7osGRou+hHOWWymMIUPfetS7b+0r/sAUYrp+5EZoQ2CzgpOc
 t+qJ7+NmVAIIGsfTDfCgmGjaS4ofwwPOQSvp13BE0KrxCTlVlvgw/q/zx9cE4vFtjqVxN8930Hy
 PguttU020+XthdRP670+YfDtjlgPJvSRFWJw2C9NmJX0FdtCL4xmGVJjBiTJ3P04EPcmObckn9N
 8Xo+q0alc3U+v4xi9
X-Google-Smtp-Source: AGHT+IHzojHh6Mi83IfYmS2HlyYeTjIMVz+MYQVnjAEuJQRkhJ+HWTBuJfUwBOJ6fawm2Nr4lhKBYQ==
X-Received: by 2002:a5d:9856:0:b0:85e:8c1b:1bec with SMTP id
 ca18e2360f4ac-85e8c1b1c78mr437003539f.0.1743167268384; 
 Fri, 28 Mar 2025 06:07:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/56] vidconsole: Avoid kerning against an unrelated
 character
Date: Fri, 28 Mar 2025 07:06:03 -0600
Message-ID: <20250328130713.2612648-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

When the cursor position changes, kerning should not be used for the
next character, since it can make the first displayed character shuffle
left or right a bit.

Clear the kern character when setting the position.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c  | 2 ++
 drivers/video/vidconsole-uclass.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 2e3e6f07112..6d2c2c2e177 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -490,10 +490,12 @@ static int console_truetype_backspace(struct udevice *dev)
 
 static int console_truetype_entry_start(struct udevice *dev)
 {
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
 	struct console_tt_priv *priv = dev_get_priv(dev);
 
 	/* A new input line has start, so clear our history */
 	priv->pos_ptr = 0;
+	vc_priv->last_ch = 0;
 
 	return 0;
 }
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 6ba62ec348e..f1b2d61bd8f 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -127,6 +127,9 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
 	priv->xcur_frac = VID_TO_POS(x);
 	priv->xstart_frac = priv->xcur_frac;
 	priv->ycur = y;
+
+	/* make sure not to kern against the previous character */
+	priv->last_ch = 0;
 	vidconsole_entry_start(dev);
 }
 
-- 
2.43.0

