Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE44C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B447588610;
	Fri, 21 Jun 2024 21:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dasmHu+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5274B885FD; Fri, 21 Jun 2024 21:52:31 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44016885AE
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ebdb5d9915so88327139f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999548; x=1719604348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=dasmHu+6fKWeZWzXKCXu/zGrWIGNXfT1WH2gKxYG+c+ziQsBblHjkIwsMPeSnNnupW
 nCm1OV6AMIZGVS6Jatln6jVAZ7Y01unSNJ22OmQFGeeXbaPSDyEm87avNcsXOY8sZd2B
 rLxFVILIxkwezw5mcoG2tOVWv61T3KNXraCGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999548; x=1719604348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLCrRj6pAlFRGjImJoweM//OdBLyyEKrzNSfFlyshSE=;
 b=HTy+fBAGBw+oAjWwhSH11MYOEHItaUBSlTtmm5vep+QCdRCGrrU4oU/qQJ/uthK43Z
 Yei/8S0eszE4spbR835Kgj79+Go6u9oSVaqnHXlAhfruHWxoh0CnMyAwgrdmlvrf9B+m
 VnfMkhyXuzmpo7TPYXxqOcw5O5QBF+X35jNaAIukXB4AFfgc0ti9PQszTfpFeyFXZdtO
 yd+P1e6icg0/RpANT6Fn6Wdyki1anB6W3obLTWtKCzxnJ+koUexAlkhvCsjyRObCt4Jq
 7MfCe4o14DbKI9GvyRixLXaujpVUqm6oYT3m77lPAm12lBNoE6NCTy4J72YGy1ZimCfb
 ZoKg==
X-Gm-Message-State: AOJu0YwDVhEaCzIREq7ZD4VXCPCUEF76VyU4f5ZInIsUPgzrFoEdjLsG
 lJYM3UdJ7JxxxAO1bYlNecnD0lo9F9EM5kKFBJZEU0n/uO2DK5RVcgk0eULgE3dqjiqcz8rIFAo
 RFw==
X-Google-Smtp-Source: AGHT+IFEClDkM/YGvsw1B+eWlIGio/X1qkiewavSLRFOtSVTDw/TKcaPi1HcsLJrCMXlTkzJ98LiJQ==
X-Received: by 2002:a05:6602:1583:b0:7eb:7c8d:dee1 with SMTP id
 ca18e2360f4ac-7f13ee135e8mr1077640239f.11.1718999547859; 
 Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/43] test: Release board after tests complete
Date: Fri, 21 Jun 2024 13:51:44 -0600
Message-Id: <20240621195204.2675252-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

When a board is finished with, the lab may want to power it off, or
perform some other function. Add a new script which is called when tests
are complete.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_exec_attach.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/test/py/u_boot_console_exec_attach.py b/test/py/u_boot_console_exec_attach.py
index 8dd8cc1230c..5f4916b7da2 100644
--- a/test/py/u_boot_console_exec_attach.py
+++ b/test/py/u_boot_console_exec_attach.py
@@ -70,3 +70,13 @@ class ConsoleExecAttach(ConsoleBase):
             raise
 
         return s
+
+    def close(self):
+        super().close()
+
+        self.log.action('Releasing board')
+        args = [self.config.board_type, self.config.board_identity]
+        cmd = ['u-boot-test-release'] + args
+        runner = self.log.get_runner(cmd[0], sys.stdout)
+        runner.run(cmd)
+        runner.close()
-- 
2.34.1

