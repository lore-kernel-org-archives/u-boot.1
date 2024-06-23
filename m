Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A1C2BD05
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2161488614;
	Sun, 23 Jun 2024 22:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T/OKVC4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51020882E6; Sun, 23 Jun 2024 22:32:36 +0200 (CEST)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41EED882EF
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x141.google.com with SMTP id
 e9e14a558f8ab-375fb45f465so13144905ab.1
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174753; x=1719779553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=T/OKVC4g9pgQ0beqfnTtvNf/fVRQcd0Fzq3DexO+URc48xMlIHFt6Jnt3gIt0wmXYp
 WkLMNJ66/h6b2t7jjiWtk5NTaSu990DppEUVgCmvX5Qx0CDrKbS9qvsb07mUIR/psvLr
 Hdxvt9g3V9eu3y/5yNZeJK4SIngR2NRtzKags=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174753; x=1719779553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mmvPMDULFpobe+S/hFhBfhEVyP0M1BL+LHT2wXM1CZs=;
 b=ZoZfE5p/MXzN2VXM3Ab4mMbE9ATxUTDb00b/5sV7Ex9522wE2VMpFyCBtWG6YbQTM1
 D+exkWX3OhKineufMdX1lHJ3ptP+WQLRCrzjNo4BAZ6YJYQPLMgb1BDK088TA2hJWWsW
 woY2K0EYMmy3dVs1hSJefmZLn77G0VkNGapWykORABo5psVbZYDFmAiRl0+1EdWit5z5
 Nlc3+V1KYIwBQZWESlYmEXcmFlhZdGnuMmJaUssna/zljBZLGPXsTPSMj82nH/nfmj9O
 RdpK/FJF3bd9o7D+9y7LJw76u+lgxKEGpSwz7DdFxNVomGjLwYSIyeDsEhnQ/h7dSkK2
 QQgg==
X-Gm-Message-State: AOJu0Yzg5Yu7mLTr4PEpaNHIFOeRES8NQHsA7Cc8lZEkEiG4OJJZZVOH
 9Ov8KK96+8br75Uqz0am7g7zPWswe1ef0FC5GmuG8VmLQmSTSt4F0fpBKuAhP8k8U+rGVSDWhsx
 BLMsC
X-Google-Smtp-Source: AGHT+IGpqb4MolaMPzZMlM6OaH7KczzfRcBG5BGXicxPjgDCnHzhAbe/IKaY8pMFi+k2z7d8YLHApg==
X-Received: by 2002:a05:6e02:2146:b0:375:a48d:fd98 with SMTP id
 e9e14a558f8ab-3763b34fd3cmr43656005ab.32.1719174752923; 
 Sun, 23 Jun 2024 13:32:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 18/19] test: Add a section for closing the connection
Date: Sun, 23 Jun 2024 14:32:12 -0600
Message-Id: <20240623203213.1571666-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index f610fa9a6f8..b279d95dea0 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -183,7 +183,10 @@ class ConsoleBase(object):
         """
 
         if self.p:
-            self.p.close()
+            self.log.start_section('Stopping U-Boot')
+            close_type = self.p.close()
+            self.log.info(f'Close type: {close_type}')
+            self.log.end_section('Stopping U-Boot')
         self.logstream.close()
 
     def set_lab_mode(self):
-- 
2.34.1

