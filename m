Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CC2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2BB8754A;
	Sun, 12 Nov 2023 01:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HPObMvYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E43786B75; Sun, 12 Nov 2023 01:45:53 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947E88701C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7ad501cb1f9so127761239f.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699749945; x=1700354745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RACsVToEfGqspWYjfd+/yjXZ6SO6w8EanEfKtWtbO0w=;
 b=HPObMvYV43NnN7xhz76Jbukp5R1F0OkYRzVALaZC+R1Bmayy7BPRgVtjAmY7Msu07q
 Bw7E/QDPwqmI2o02ySgdRPXqWMK7yhpLPNrVfBhjvbr64hPXz6e6tmLSQoHBTvNC2gQq
 vaVDKbjWF7lpemYLYSldJkFUYfbaxjefdTLdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749945; x=1700354745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RACsVToEfGqspWYjfd+/yjXZ6SO6w8EanEfKtWtbO0w=;
 b=R6T62C26daB5g7G3iv42EwAEy7tCOQWosUNFzFdtO6FYLDjVqS+f8dfwpKq59RNz9i
 y2pPu6Pn5sPp4dypMyaq/Gjp7UlKz9pewj1J7sWii445ck1jZFzn7sFaKldtZoYhHbWN
 0R7Qdt4Tdb2BlKgo7+YkhSCIkJTjle5v1lTTWh/3vY2HLf0eQJyEBvX2EeKlHvYivPq7
 HKxe5ZHjW4ANcYMV+w6y1fkcW/mZ/YRHPq8rbZBgXiK7y5FydOIv4y4yX4U/8uyifWjq
 Kg4ryh3dPjEaS+TOvhHuCSFTmC56i5Pse3AwYKt78CohEw98Am/4/nCbc60yxGGxcdTm
 trpw==
X-Gm-Message-State: AOJu0Yz1NN+2dUBaO/Rs2yaGPIi/Yor1TmBSt5i1Y6HcTK1fi3b7eHOE
 E2cyLv+A98tk27q4LYyd5RhlbqxIPU+atM3WXWrTeA==
X-Google-Smtp-Source: AGHT+IGDURCfoRpGnlrUNiZsVVC8BKhl05BZiNo0eVmBmOy/a1/fnW8WhcY1CKgUKaIR4DtQypZzXw==
X-Received: by 2002:a6b:d314:0:b0:790:fcc2:6e9c with SMTP id
 s20-20020a6bd314000000b00790fcc26e9cmr3775551iob.12.1699749945589; 
 Sat, 11 Nov 2023 16:45:45 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5ec111000000b00785cfdd968bsm765277iol.5.2023.11.11.16.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:45:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 3/4] image: Show the load address when decompressing
Date: Sat, 11 Nov 2023 17:45:34 -0700
Message-ID: <20231111174533.v2.3.Ie1c352a32eff905cf333491bf3d7d315e25e3f31@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112004539.80982-1-sjg@chromium.org>
References: <20231112004539.80982-1-sjg@chromium.org>
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

