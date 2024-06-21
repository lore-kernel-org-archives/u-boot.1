Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96A79C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178898867A;
	Fri, 21 Jun 2024 21:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RXOiqkHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A20E885F1; Fri, 21 Jun 2024 21:52:43 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D9728863F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-7ec2d71059dso92840739f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999560; x=1719604360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dM6YrwE+qP5ow6Gpq1gzi+w1kof2WrpAO6yQZZKALIw=;
 b=RXOiqkHuY0GQgEnrcfGHPfFjCKLHyKVxAYengwwTjfomK4wwhDGhM7aInN7FgOGOew
 BNPE22+FKagIfm5kzSNq03e4kt3nXOporXCZzz54V5Wc/CM1KbsWxgLcuCwtkmsEgPXo
 JXJg85fn+U00BnZmOcqJYQIjjizkYzy7GRRus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999560; x=1719604360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dM6YrwE+qP5ow6Gpq1gzi+w1kof2WrpAO6yQZZKALIw=;
 b=bShatBf1M6OcS4rAQF2h6Iy+BW+9D8FuAQR+Mbg4YzpOXOIiek9trl3QXK6ie5TOFr
 +CA7UjNHS8mbHL+EPuybkU/WWpTFNxGthWNlkhMc/l0MDoWirU5zBp8Cc+FIf+cT1HVK
 DHVQI+/RFhyN1Qo1lndqO4Ub7eRV0MsLRc2KgVyv1xkWdOJkLhURTLAzOywaDONoAhfq
 eA4+DleRIarsyhVuFnNIk4zpkTTkU+ystP03wMngHWycG/K0f14AeW8WZK8qgNbgLtA2
 eFfL/gnXxxLvXez2fbG8SxdGLDWLQeNXh77LNW3rbwck/y94zvl+AxO05TDVE6fInCcA
 Rt7g==
X-Gm-Message-State: AOJu0YwF1caMiJNClgJca25ycptdD6fjcS8jMVkfJAI5ysitGoQs1c82
 +RiIJe/D6II9l1i4r2H1WtWJV0u7CaCX5gnYjPeKMCxO98NyWAJuh18q4m6Rmw34rep9Z2spN9X
 k4l5W
X-Google-Smtp-Source: AGHT+IE0MSrJfncl3k7fIYdncc1QfVJKLET3+RqS1X5nIrGc/BV1rSISc8HpKpFYCK8f9O2h8nIFxA==
X-Received: by 2002:a05:6602:3f90:b0:7eb:5685:2cd2 with SMTP id
 ca18e2360f4ac-7f13eea7789mr1021910939f.20.1718999559642; 
 Fri, 21 Jun 2024 12:52:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 38/43] test: Fix mulptiplex_log typo
Date: Fri, 21 Jun 2024 13:51:59 -0600
Message-Id: <20240621195204.2675252-39-sjg@chromium.org>
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

Fix a typo in a comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index eda48cd35f7..1b00821c5e9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -97,7 +97,7 @@ class ConsoleBase(object):
         Can only usefully be called by sub-classes.
 
         Args:
-            log: A mulptiplex_log.Logfile object, to which the U-Boot output
+            log: A multiplexed_log.Logfile object, to which the U-Boot output
                 will be logged.
             config: A configuration data structure, as built by conftest.py.
             max_fifo_fill: The maximum number of characters to send to U-Boot
-- 
2.34.1

