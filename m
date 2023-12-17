Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913C3C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 16:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56D8D87CC1;
	Sun, 17 Dec 2023 17:36:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VADsthRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1AA87CA1; Sun, 17 Dec 2023 17:36:42 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A887987C9E
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 17:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35d67aa6951so8538015ab.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 08:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702830999; x=1703435799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3PkzhxIi4+fq3rDE7+/HI/4m7VHcmTn0a+o+Veb7a7I=;
 b=VADsthRwL3FNKgB4I/bPS0Vgq91e4W4PlGbmqLuJCw4gtHKidIFwLNww5XL5aTgMXI
 XAAbgp5gXLaMzC19N0r5IIBSjq9jE7rDSwlDD0bunPOlFfysRqIgxoN+pcMNVl18urjh
 b1JznDPCRPfoLw12te0ucie6L5+l4+PEkZiiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702830999; x=1703435799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3PkzhxIi4+fq3rDE7+/HI/4m7VHcmTn0a+o+Veb7a7I=;
 b=aWjV0VuuXa+BFkBAE/GKNYScNIrxkYhdNeL5UtPhPofS90sBz/cDHUFndMIf+WT3sR
 2nM2o9BvKp7sL+dDIIvSCk/xPPTkyYXU08C2JgKDejiUIoqLPttK1oNVp3WmjoNdXlMt
 gkdgUdHYrZatCFgQJAcXt1LTWiuac33FXPw6JqoayoJISX0t4s3F3XYuGPdfl3d0tUWV
 mmPHNXRMlAM+KE3U/8vNrV7OYhLz8rGCiAmv5CXwEbW3if8mKXBYJq9cO+fSqwSoshol
 UZDj4Xce08uJ8zY7kqbSZOl0QEBQ3FYfCEwcFu9eBkHzRCsrUmh+Fb5f9o6wqP59GWPo
 zyEA==
X-Gm-Message-State: AOJu0Yx+VMZkT4Z+1Ll2q0wDTPQw/CLC7UglE3qSYBYUKEZXPc5wvmrr
 w6R7Za09trPIw0sPm179NeKRkvcPU5iXfcazOzzs4Q==
X-Google-Smtp-Source: AGHT+IEAbWNngU+UCvhsT1/gKWRTU7tAc9VNfVzuaAaWuMEP1RVtMXBfpafzAshU+alQDgSHtMHt5g==
X-Received: by 2002:a05:6e02:1a05:b0:35f:aa70:687b with SMTP id
 s5-20020a056e021a0500b0035faa70687bmr804376ild.20.1702830999068; 
 Sun, 17 Dec 2023 08:36:39 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ei10-20020a05663829aa00b00466917fbfc4sm4925770jab.71.2023.12.17.08.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 08:36:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 06/10] fdtgrep: Simplify code to inverting the match
Date: Sun, 17 Dec 2023 09:36:19 -0700
Message-ID: <20231217163627.2339802-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231217163627.2339802-1-sjg@chromium.org>
References: <20231217163627.2339802-1-sjg@chromium.org>
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

The code to invert the match in h_include() is a bit convoluted.
Simplify it by using disp->invert only once.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index a6cdc326709d..b06a1a7a8384 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -634,14 +634,8 @@ static int h_include(void *priv, const void *fdt, int offset, int type,
 			inc = 0;
 	}
 
-	switch (inc) {
-	case 1:
-		inc = !disp->invert;
-		break;
-	case 0:
-		inc = disp->invert;
-		break;
-	}
+	if (inc != -1 && disp->invert)
+		inc = !inc;
 	debug("   - returning %d\n", inc);
 
 	return inc;
-- 
2.43.0.472.g3155946c3a-goog

