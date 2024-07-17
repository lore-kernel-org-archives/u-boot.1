Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA627C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8BB88AC4;
	Wed, 17 Jul 2024 17:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g0NLZa+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74BBC88A82; Wed, 17 Jul 2024 17:57:29 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DF188A7C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 17:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36798779d75so6274824f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721231847; x=1721836647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dighdidi4dH3DaL1pfykAiB8XYdhKYjUu4SXxSzJjQY=;
 b=g0NLZa+P+Fa0Q+If2djysevFSY0FRsfLSSqDrqx8OPeBPAv+BXQ+w+G/3QT50WwXTX
 KzUy4l1+XVt1eqo1J0q+0BgdZjCREY8oP8PFIdH6qNafrp3qtgGEKsmlIHAxYBkgNNbk
 xduF1HVruZg6yLzoGx5iasS3yvwt/tp4NtbfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231847; x=1721836647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dighdidi4dH3DaL1pfykAiB8XYdhKYjUu4SXxSzJjQY=;
 b=LAfUAi+9fMu/LPR1KeSayGUFbQtV0ZoDbKduIWdeSYuBOfMfBT5gck44Yf0HDV+Ciq
 n7QonSfJbVwK0jWYdVoQI0LnXv9GCzaZA2i6aZlFUh7KQagIBbRmmDju2ecRZ03WazQC
 nPbWHydp4R6BjlF9r0ps/Dh/g0f3G8u+mnrNBGTGfGYhI311bOn3K8Spgr4JtX8XMnu1
 P4BNExsU6OtFILdfkDqOVq8gMFu5jaYEINS6G9soc8Y8yTA3ahZTrUadJdULh82rppcb
 AmnuMpZhJxC+Fuj2S2/qjLjlUeVhh5i+uO3MLxDwhHJ11uS3mVgM9BcCHhP8MF3EjO48
 zpBQ==
X-Gm-Message-State: AOJu0YyrArZVc6Na3V6tO+Gc1zBtsL5jd+UPV9NWcEIw1qQLfcTxSIQw
 JRgH/0FqPIB6OY51250gSZbB9khaY+vSAkFYK9aXuBU+Nx0worLF2Wsk5hr+42IA+euNrumtFcw
 =
X-Google-Smtp-Source: AGHT+IH4ga0ZUvCzhbSx8FhAuU/Qyu+roNpbPgWEUOm1OTHzBP8TCaaVpeZxvD42gLCRxG/6iDG1EA==
X-Received: by 2002:adf:f6c8:0:b0:367:957d:b46d with SMTP id
 ffacd0b85a97d-36831796512mr1615617f8f.66.1721231846915; 
 Wed, 17 Jul 2024 08:57:26 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb877sm12173958f8f.69.2024.07.17.08.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 08:57:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 11/24] qconfig: Move checking directory to the top
Date: Wed, 17 Jul 2024 16:56:59 +0100
Message-Id: <20240717155712.2913651-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717155712.2913651-1-sjg@chromium.org>
References: <20240717155712.2913651-1-sjg@chromium.org>
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

Move this check to the top, so it happens always. The tool should be
run from the U-Boot source directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index 5d6e468d1d8..832e524c25c 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -1528,6 +1528,9 @@ def main():
                 args.scan_source, args.test)):
         parser.print_usage()
         sys.exit(1)
+
+    check_top_directory()
+
     if args.test:
         sys.argv = [sys.argv[0]]
         fail, _ = doctest.testmod()
@@ -1542,8 +1545,6 @@ def main():
     # prefix the option name with CONFIG_ if missing
     configs = [prefix_config(cfg) for cfg in args.configs]
 
-    check_top_directory()
-
     if args.imply:
         imply_flags = 0
         if args.imply_flags == 'all':
-- 
2.34.1

