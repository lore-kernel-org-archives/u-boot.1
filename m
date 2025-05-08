Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2F5C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 07:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E4B82A3B;
	Thu,  8 May 2025 09:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WZPXLn+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130488059D; Thu,  8 May 2025 09:29:36 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB4282A4B
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 09:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso702472f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746689373; x=1747294173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ON0OavZR7uXfEwN9WAbv5b7X35fwutu3th3roUEjuEA=;
 b=WZPXLn+VMCLcXklD/jG2trF3T/53Wltx7zFenK8BpgJCm5rq+vpFgZQhqGNznvBovk
 lD4nJJzIzc7NljQBO6fgOq6vcyl9ZzEiCS/yYCWC34xgIYpqZz5w0a1dRNDN+eHROGhi
 LD+NG/R/FwOxuHuORwuAb2CUSM1q/0DjIAKaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746689373; x=1747294173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ON0OavZR7uXfEwN9WAbv5b7X35fwutu3th3roUEjuEA=;
 b=N1m/MJSUE+dchpDhkbI/Gu7HfzGRNGsXZ4r2WuMttcOFzeS7GVDH2R0fo+dcqxBTmf
 bQCUOsTLrafg2zM9aeUDx+RhXAebXA8TbVa1uKHKnAlNs4Ajfzb44yel4lGrSXLrp0OF
 r3146Bj3tbe5ptijVWTZkESUlqFkYaxPu81TAwQGeD5W39M8P89TfC/NFJi+tfwfq3ii
 AqNkSAMgzH3K4tfpyeIbeTYdHh1aR8aHQcMFfYQVrOqUOcmEnLQVqZFNhaaSkVsFXCoq
 npxCCsaD5O+grb0VAALs4QzRBmTRdYLl/T3IzWG3K6CRbXviAg1Y37GbQQhMk29SCg/Y
 L6Tg==
X-Gm-Message-State: AOJu0YzNPbbEZ/rnzrApJiDpqgHEzCpG7yvLDPHaJo7JwYa2PB2hbdzT
 dAIPKM+LP5WRPBtRZWG32KyFgj+FvVnHhMSQ1yilOwy0yAYGi8+Vut6i5w/uXK08voM3AgV7PXs
 kofjmnPdJrQ==
X-Gm-Gg: ASbGncsLe7KukfghQuy4W6feP0a0cYS/QI/Ji14Kh7Te1MqRlq28jDj/JYZfAiooygH
 7l5YWhI3fH26DRYMvBO2Kjl7MEB4CE4YGJpECDk9Nx+Yzs7Em1fAPcXYYhxG/Ly2x0MRLY45N4m
 MNWPqB3MFiUt+pZbNDcMJwbxDhXL0iGdQmqvaKod8NluY/h9757I0sX9knJsefVKJWEfTWowEOZ
 ZAiDuvtFExMcRperq46XcypNrUphWRMQjxMRxImBhY/JZP52Sp5vcZe8Y9LHxMo8R2YnsGeWWGT
 EYbMFWTE6ikCT+i1W2vnwjm8MwjWtHuC3KmEUw==
X-Google-Smtp-Source: AGHT+IEeRSU9EfOd1fR/MeUNxExA6hkdca/unjp50oPAJKJ9cubtaHdzOeBpP4SrexgzjG87KI9Ofg==
X-Received: by 2002:a05:6000:430e:b0:3a0:a463:1480 with SMTP id
 ffacd0b85a97d-3a0ba0eef36mr1553550f8f.46.1746689372699; 
 Thu, 08 May 2025 00:29:32 -0700 (PDT)
Received: from chromium.org ([213.157.19.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0bd6999bfsm774375f8f.46.2025.05.08.00.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 00:29:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/20] patman: Use variables for series ID and title
Date: Thu,  8 May 2025 09:28:34 +0200
Message-ID: <20250508072907.207175-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508072907.207175-1-sjg@chromium.org>
References: <20250508072907.207175-1-sjg@chromium.org>
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

Rather than hard-coding these values in the sample patches, use
variables so that we can refer to these in tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 5ddefc3a9b1..9c7d5d8c381 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -59,6 +59,10 @@ class TestFunctional(unittest.TestCase):
     verbosity = False
     preserve_outdirs = False
 
+    # Fake patchwork info for testing
+    SERIES_ID_SECOND_V1 = 456
+    TITLE_SECOND = 'Series for my board'
+
     @classmethod
     def setup_test_args(cls, preserve_indir=False, preserve_outdirs=False,
                         toolpath=None, verbosity=None, no_capture=False):
@@ -508,16 +512,17 @@ a very nice colour.
 Purple and purple
 Even more purple
 Could not be any more purple''')
-        self.make_commit_with_file('serial: Add a serial driver', '''
+        self.make_commit_with_file('serial: Add a serial driver', f'''
 Here is the serial driver
 for my chip.
 
 Cover-letter:
-Series for my board
+{self.TITLE_SECOND}
 This series implements support
 for my glorious board.
 END
-Series-links: 183237
+Series-to: u-boot
+Series-links: {self.SERIES_ID_SECOND_V1}
 ''', 'serial.c', '''The code for the
 serial driver is here''')
         self.make_commit_with_file('bootm: Make it boot', '''
-- 
2.43.0

