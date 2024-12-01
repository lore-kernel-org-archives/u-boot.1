Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1990DD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 126DD8962A;
	Sun,  1 Dec 2024 16:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dG+rJh9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C385889621; Sun,  1 Dec 2024 16:28:28 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CC68947E
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a790d6e782so14476535ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066903; x=1733671703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2LqPv014y4s1wGwJyI2v2gsP8yl7TTG1JhCd8sfcM8=;
 b=dG+rJh9MQiIaOhZdLeT8imuuBpBhPu3Rm0gmDkCFj6Ajp/n2Dqul1AIz8PD2QvWZkb
 K7Q19tYnM/8bP3RHP/4O+bK3wSVrUvT+WYkfEpRHfQiRr6bWBsJhI/RrEjgNuQijiDPJ
 hFECFjs2dXOefwaJpJb7sqmPnCKnYBywkhsi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066903; x=1733671703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2LqPv014y4s1wGwJyI2v2gsP8yl7TTG1JhCd8sfcM8=;
 b=KKqqC8eSNvx798C4I6xoNPUVMMrJ84UfwxIpezLTxjMbfSBp3vJWPft0PwVV92MyxJ
 y0RIkx9tOd13gEBFCoV7TbHM8qcMRldpzs1MDBAlSUveoo5B54Z8IiQ2Bv6GgcaxvQca
 KUt5w6c8AUI0PJnRVbWtpIe7RYJX6jTka6TPURsEM4zZ1MmZeRMLGdqTVOF1Y5aJd7gM
 gB1X3TjYFPQ9MNRKP0k/KVoDUbfrgkYr1rhSc8gsbVavbAg3ixnVaVSkOFqZynxoc/Y4
 GwkGOX1HkMkroZe7yIPg1kC3TxvTE63hkkae4oAA4aPEj/86eWgP75hkNTP8u4qft/36
 k9Yg==
X-Gm-Message-State: AOJu0YxjjEZj1/ut/K/+9er0SMmDdCVz1o5Vpi/5KCjI2QOU/8eVmajP
 yyTqeZ1GIGL2KT8O4ou0bpqBxEYm4JGtJl3ifcyEjp89hbTReJbXsFsJSa/EiB/TZj+mO4FILSk
 =
X-Gm-Gg: ASbGncvuNpgOJigUoKBtFfelq0dxBCHc9H/DXa10VggvMwm5Q1GLMC1ULIZmBTtV76r
 sQiE+RxACYK8yVvPfbUIg8KpbWYjnJw9/e2EGd4/3I5YRlYweHyTfVcxurrmVYhdw2nZ8Me1eab
 54Qm9aoq8dDBVmwMzz/W4mNrvXknOvaHR9d6W3UXAikBw/SsJzNcTNJGssWa44p1uxAAIYakZgu
 ONxhD0skHBVdhgEUP7RB6wM/cQrUcydqJ6RKqCpdOgm
X-Google-Smtp-Source: AGHT+IGUny+L+MS+u+TIEPsfZMdTnBadT0IC5TYI8qU0Tl32xE44gwBM3mroaymBnjjDfawPxkGt6Q==
X-Received: by 2002:a92:ca0e:0:b0:3a7:c378:3bab with SMTP id
 e9e14a558f8ab-3a7c5445d3amr208009425ab.0.1733066903193; 
 Sun, 01 Dec 2024 07:28:23 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dcb33esm1690307173.57.2024.12.01.07.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:28:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v5 1/9] kernel: Document ALIGN macros
Date: Sun,  1 Dec 2024 08:28:03 -0700
Message-ID: <20241201152815.1668093-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152815.1668093-1-sjg@chromium.org>
References: <20241201152815.1668093-1-sjg@chromium.org>
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

Changes in v5:
- Use kerneldoc style for macros

 include/linux/kernel.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9467edd65ab..08388f922be 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -35,9 +35,40 @@
 
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
+/**
+ * ALIGN() - Rounds a value up to a given alignment
+ *
+ * @x: value to be rounded up
+ * @a: alignment factor. @a must be a power of two
+ * Return: lowest value >= @x which is a multiple of @a
+ *
+ * For example ALIGN(0x123, 8) == 0x128
+ */
 #define ALIGN(x,a)		__ALIGN_MASK((x),(typeof(x))(a)-1)
+
+/**
+ * ALIGN_DOWN() - Rounds a value down to a given alignment
+ *
+ * @x: value to be rounded down
+ * @a: alignment factor. @a must be a power of two
+ * Return: highest value <= @x which is a multiple of @a
+ *
+ * For example ALIGN_DOWN(0x123, 8) == 0x120
+ * ALIGN_DOWN(0x120, 16) == 0x120
+ */
 #define ALIGN_DOWN(x, a)	ALIGN((x) - ((a) - 1), (a))
+
+/**
+ * __ALIGN_MASK() - Rounds a value up to a given alignment-mask
+ *
+ * @x: value to be rounded up
+ * @mask: mask to apply, must be one less than a power of two
+ * Return: lowest value >= @x where the bits set in @mask are 0
+ *
+ * For example __ALIGN_MASK(0x123, 0xf) == 0x130
+ */
 #define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
+
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
-- 
2.43.0

