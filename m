Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA0CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:50:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A5A870F3;
	Sun, 12 Nov 2023 04:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAzkG8p+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C4986FB0; Sun, 12 Nov 2023 04:50:39 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CF9D87036
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedb8so120973939f.3
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699761021; x=1700365821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RACsVToEfGqspWYjfd+/yjXZ6SO6w8EanEfKtWtbO0w=;
 b=jAzkG8p+2wIACo5SbgKrtQQXfxcDVFjRlDzWr3MlmRJr16w3d5HFD19U1yR4wEQg6p
 4LFSIDBOpsXXzyf2dPOMINrDW4snpsDVU1tvBvIeHpNkyCddck1YczUcpCqobLEQqNli
 Q453GETc4A0PvMxu0C+CJJUjkBYlZ34cppzxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699761021; x=1700365821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RACsVToEfGqspWYjfd+/yjXZ6SO6w8EanEfKtWtbO0w=;
 b=Kp4l+XQuYhjvdWC62kTmIf23L8Yrsv0ymDkzWkP7M+MkS6+XE4f7pQAQvqiHQosPko
 QLMbVKhyS4Yh5lqtgaMGuAcQHnySmKHaYOzY4qPLVTkeWEoCbJGYv3vXCp5Gruak8nm0
 QNckIi432Wtt8YKfDpYyNvAkMg0nfQyF1cAuKY2femCMuQhmFM8aqKRuL7ZBMLIVr2/2
 abECluA38EyxFSt0mtJrtklVpQxcFZyMmV4i1yPp1Irg8nILdQ/vnniDZ3uBX8JM2hbM
 QnIBPeo20Dxv2+Ffz0HRzHEwPwjVHBeI4nQDNsR9fDyIR6dkKjBdSBzYhw0UlIe6iQvZ
 2TOQ==
X-Gm-Message-State: AOJu0YwYLRtSYpH9+wyPZlOFuIEC17CB53Ko7kVIHvIxwAWF1AhltzQE
 fK4vkb8zs2TOmT1G2RxE6U7EFBFqQVn5aP0x5LNT/A==
X-Google-Smtp-Source: AGHT+IFW+t5h21FWXxFWfFCyC6tbG+g59jIifzorfuYB7NqKrkcdH0UsWTrTFFU++iUwpUTmnNSvSQ==
X-Received: by 2002:a6b:5f14:0:b0:792:6cb2:e92c with SMTP id
 t20-20020a6b5f14000000b007926cb2e92cmr4198418iob.3.1699761021524; 
 Sat, 11 Nov 2023 19:50:21 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a056602305000b007791e286fdbsm817864ioy.21.2023.11.11.19.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 19:50:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 2/5] image: Show the load address when decompressing
Date: Sat, 11 Nov 2023 20:49:54 -0700
Message-ID: <20231111204954.v2.2.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112035001.103897-1-sjg@chromium.org>
References: <20231112035001.103897-1-sjg@chromium.org>
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

The destination address for decompression (or copying) is useful
information. Show this to the user while booting, e.g.:

   Uncompressing Kernel Image (no loading done) to 2080000

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/image.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 88b67bc3a199..675b5dd77f94 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -415,15 +415,20 @@ void image_print_contents(const void *ptr)
  * @type:	OS type (IH_OS_...)
  * @comp_type:	Compression type being used (IH_COMP_...)
  * @is_xip:	true if the load address matches the image start
+ * @load:	Load address for printing
  */
-static void print_decomp_msg(int comp_type, int type, bool is_xip)
+static void print_decomp_msg(int comp_type, int type, bool is_xip,
+			     ulong load)
 {
 	const char *name = genimg_get_type_name(type);
 
+	/* Shows "Loading Kernel Image" for example */
 	if (comp_type == IH_COMP_NONE)
-		printf("   %s %s\n", is_xip ? "XIP" : "Loading", name);
+		printf("   %s %s", is_xip ? "XIP" : "Loading", name);
 	else
-		printf("   Uncompressing %s\n", name);
+		printf("   Uncompressing %s", name);
+
+	printf(" to %lx\n", load);
 }
 
 int image_decomp_type(const unsigned char *buf, ulong len)
@@ -448,7 +453,7 @@ int image_decomp(int comp, ulong load, ulong image_start, int type,
 	int ret = -ENOSYS;
 
 	*load_end = load;
-	print_decomp_msg(comp, type, load == image_start);
+	print_decomp_msg(comp, type, load == image_start, load);
 
 	/*
 	 * Load the image to the right place, decompressing if needed. After
-- 
2.42.0.869.gea05f2083d-goog

