Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AEEC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 19:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311AF877D1;
	Mon, 27 Nov 2023 20:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bAQokIcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C1E877D0; Mon, 27 Nov 2023 20:52:27 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EE8D877D1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 20:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67a4645fdc3so7587666d6.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701114742; x=1701719542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwM5JEIQQQ9wVVTxLLOEmIJseg/lwNVcDSP2Rcen4yU=;
 b=bAQokIcf30haBWOkJEansJvf34N+ijEFS5Bb43l5dsM8ipsOh7CQp+rSHn2DTCPOuc
 viNlyzM3tx/rwsj6ZMV4bpCtALVJ4lcLuyWoStzejjZa9udTTZ61K/16iK+rsqmUjQVl
 SOH86N5gAvUFb8QGkbFkoGJNvcwmG0z5s3b5ycb/Wwj9M7P8xHC3qULoqg7AJ4ljsrZM
 FdRPRzsoFyap/OUZSoje3vD6SF0ObMWluHDzQwhKyiCeO1Dxf1dmlrsLJzdvs2BofD82
 OiP50vY7Y4jZzZvPp/02Ms87xn0WYd/KDzIf+oJBS/oyehYC0p9HgQUBtIMc5vv3O8yx
 CUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114742; x=1701719542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zwM5JEIQQQ9wVVTxLLOEmIJseg/lwNVcDSP2Rcen4yU=;
 b=RkUh64GTynPdzMgW6MNmZu7EZ0XYnpTYZWPxtotV6WPF6D3+pgU1hny6DLNr3t3rA6
 +qMIVpv+pOHm9ol4m2aSd07O8QhQtis90DBE8/zZLkTEdRzBN5iXcqCO8p5rJ6aOYkTZ
 NyfTX+sqIEG1mQjPEKEsvBcAmY5VqhA7mCp9btLNHe2P2X9TUYG8tEvztRRqa986tA7E
 PviHH7ux9569DgwTrhrJ0aZONdoBvvxBtwFkOrQtjYkCwfnfop3hBwqEqI+VukPsxFyv
 kmhs00Ra6bQ2c+bp6+ossw9ULPb+15ri0O/B0CJGxWJYt9R4/SDEYbnJb7RI4L4KxV4G
 IENA==
X-Gm-Message-State: AOJu0YyKm9qr73hz0OhoO6zWYvcpJ8ExrL4oNUDCvOZnB8S16YkMS0Ls
 F/WU+6WdYmFTt2nHxFaA94UzODarBLFfchP1Vxn7mg==
X-Google-Smtp-Source: AGHT+IGdeHsreYIvPW9D7DKrEnx+QM0zrEGaMvIKq0tFEkEpOCb6s+8rzqRDrjk76iQiZ9BGmtqx6Q==
X-Received: by 2002:a0c:e950:0:b0:67a:35f5:bdea with SMTP id
 n16-20020a0ce950000000b0067a35f5bdeamr7572456qvo.43.1701114742791; 
 Mon, 27 Nov 2023 11:52:22 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ad45106000000b0067a2061fc21sm3087047qvp.101.2023.11.27.11.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:52:22 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de,
	ilias.apalodimas@linaro.org,
	sjg@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Nikhil M Jain <n-jain1@ti.com>,
 Baruch Siach <baruch@tkos.co.il>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 04/18] bloblist: Set version to 1
Date: Mon, 27 Nov 2023 11:50:15 -0800
Message-Id: <20231127195029.90951-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127195029.90951-1-raymond.mao@linaro.org>
References: <20231127195029.90951-1-raymond.mao@linaro.org>
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

From: Simon Glass <sjg@chromium.org>

The new bloblist for v0.9 has version 1 so update this value.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Update the bloblist alignment to align to FW handoff spec v0.9.

 include/bloblist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/bloblist.h b/include/bloblist.h
index 30441f922b..d70a7bad2e 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -74,7 +74,7 @@
 #include <mapmem.h>
 
 enum {
-	BLOBLIST_VERSION	= 0,
+	BLOBLIST_VERSION	= 1,
 	BLOBLIST_MAGIC		= 0x6ed0ff,
 
 	BLOBLIST_ALIGN_LOG2	= 3,
-- 
2.25.1

