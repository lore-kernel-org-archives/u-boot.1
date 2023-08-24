Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F155C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD2EF8642B;
	Thu, 24 Aug 2023 14:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SjcE9HqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AA4886430; Thu, 24 Aug 2023 14:44:37 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E94A86427
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf0b24d925so44842475ad.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692881072; x=1693485872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AseP7eNnoXdiDP73451n80NQSCVBSAEbxZS0CLRLZ0w=;
 b=SjcE9HqWhrIO+q7Thvz3JVT+6+tfhVELeq1QuYxhOzvzf7Q1DI8fHzcVHCMqAv/A+7
 rd/STU7K+4/mWztXLsaNAbiJS0E6IVoXPVZ6HtfGiApreWpORM2QG81KGqmlbcpB31Nv
 XAFz9Ek8FSEQ300ea+E874kB74TWGOgYCHNzb2mVFHNG23h05ki0TlSEPqsAYA5aWdlO
 5sLjfok34hV9Oz9p/9Y7lUypMm+qzYy79JPwLnj+q6daNMwzzqCCSSat5k6YAyVXTH8q
 fZobibSZ40A9PuXGt5gnFI8tjt5x8fCMEmJgRI6XhOI6uQH1PjbW++iUXbmyidml7qDi
 gYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692881072; x=1693485872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AseP7eNnoXdiDP73451n80NQSCVBSAEbxZS0CLRLZ0w=;
 b=DCHJgm8uDOr5NOrjvHnV8YHWGEDysFuiD0wOX0OwBPceKRRXtvf1JN8dFYlMevBGlh
 G2oj8JLmt3E4kndxDujpP6l5MiLd6tiZQuGEWnEmbrf/Psx4ocr1eM1KnpDMVwVskB7z
 EfeyevhleICOCszA0pWRZJmTpLer0QK5DzwxoXK8xSyijmnIzMavUQeIZA8kTfIOlj0f
 DfWUPfiM8AVyHBy+W1pg5jIPhpe44rsSaHmSdJttWUT72Zj3KiR8i0dduRKYMsRDrAyM
 RKSO/9D3/xF5vr8EWV88QW3u5xWF/+/sXAZP3GaU1I5rdtNYhgRKJ/SztI/Pnv9juhfL
 CmAQ==
X-Gm-Message-State: AOJu0Yz+82tHgdMT5pmUcT8rO/e6FFQqRGfh/WOFF9j5Mlt5z/T/1sI8
 +L6ZX3doquiDgfJtgDwaranefALL8oyjIOt4Oho=
X-Google-Smtp-Source: AGHT+IHyR2evR14l3gCs9AmBYh80RmJsEWxvL1pZzpIrVhzvRoc371wacHO0Ne65ywwGMWt5tP1X+g==
X-Received: by 2002:a17:902:c101:b0:1bf:6cbc:6ead with SMTP id
 1-20020a170902c10100b001bf6cbc6eadmr11153790pli.22.1692881072524; 
 Thu, 24 Aug 2023 05:44:32 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.170]) by smtp.gmail.com with ESMTPSA id
 bh2-20020a170902a98200b001b9cea4e8a2sm12671634plb.293.2023.08.24.05.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 05:44:32 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: rfried.dev@gmail.com, sjg@chromium.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] doc: board: sdm845: Explicitly add boot.img flashing command
Date: Thu, 24 Aug 2023 18:14:20 +0530
Message-Id: <20230824124420.1665748-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 doc/board/qualcomm/sdm845.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
index 71879c2a6e..08e1c353c5 100644
--- a/doc/board/qualcomm/sdm845.rst
+++ b/doc/board/qualcomm/sdm845.rst
@@ -149,7 +149,9 @@ Steps:
 	mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
 	--output boot.img --pagesize 4096 --base 0x80000000
 
-- Flash boot.img using db845c fastboot method.
+- Flash boot.img using db845c fastboot method::
+
+        sudo fastboot flash boot boot.img
 
 More information can be found on the `DragonBoard 845c page`_.
 
-- 
2.34.1

