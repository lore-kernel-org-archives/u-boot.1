Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D72C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 20:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6E2088569;
	Fri, 21 Jun 2024 22:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nK+mUChb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32DF88059; Fri, 21 Jun 2024 22:46:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27D7B8855C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 22:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7ebc67365e3so91969739f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 13:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719002806; x=1719607606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJatQ67wLsUKufFx8+ZIAVVElx7A/F8+oG5u3y8kT7g=;
 b=nK+mUChbcN8Siaswur2Ju9TxoYF6P9RforgDxuZ5LlzeWVrxwxr0hAffOpI3SEnL0V
 38+0ZmikPT48U7ecxzyUU42QGsrN5XYWEODZ6cNRBJti38vjauDN2fyNjX06gQcysD1c
 lIPBjpknYrl5okJWoNDmToAp8afWqTK6DC34Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719002806; x=1719607606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TJatQ67wLsUKufFx8+ZIAVVElx7A/F8+oG5u3y8kT7g=;
 b=TDwcVjKDqVBQqApgOGtbXaSgPOy9NdCnFh7mmJzNjEn++Cl8MO7o29LFDQ6ScdWqbM
 T9uL5GrGjLdS1PPOr5xFEwlQMTWpf2Lgz5PcYto79r6KwqTdTv3n/SSqIQaKd6nTIRWb
 Lm8sP9KwvNdWnVDvUa5R9xSxKUE2f9qQU37Nm/FpkGxYvzfWGgDleF58VVaakCOVVZJK
 wSG2Fyezb/4s51cKwRnX22V0hIn7rqTz8SyFQK9DX2f5QDBFH7Tgw0Gka6g4UuPXf3HA
 wYCkIBbE0RXA/u+M0dcPcM2vPC+rztNI3Zsw159Q++Szp9o8FftZkY879WzSns/kj4t3
 qEIQ==
X-Gm-Message-State: AOJu0YzIoERxZig1GxnWpqItEPFKXLTL2GwcMI+jlvyAE4t0oWh0wi5F
 moB9pc2XHVPlXvsJiAYkzr9m+JsRsUYbsgMqLBl0tytq1ABijS7LzmxWMpsSQy2TDUyiHz9BCoz
 dew==
X-Google-Smtp-Source: AGHT+IFT9C/VrzdtEeJ18w26UOwCK8FcXnZ+oBrnh66J7opEHGTEzHvBXpofE5ON5dOSHs4NwaVgHw==
X-Received: by 2002:a05:6602:2dd4:b0:7eb:6b58:440e with SMTP id
 ca18e2360f4ac-7f13ee94480mr1120416639f.18.1719002805882; 
 Fri, 21 Jun 2024 13:46:45 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203ec51sm50698939f.53.2024.06.21.13.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 13:46:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/11] buildman: Avoid rebuilding when --mrproper is used
Date: Fri, 21 Jun 2024 14:46:29 -0600
Message-Id: <20240621204632.2706813-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621204632.2706813-1-sjg@chromium.org>
References: <20240621204632.2706813-1-sjg@chromium.org>
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

When this flag is enabled, 'make mrproper' is always used when
reconfiguring, so there is no point in doing it again.

Update this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/builderthread.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index 0a7ff2e083e..c0b1067e3f7 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -700,7 +700,7 @@ class BuilderThread(threading.Thread):
                         job.work_in_output, job.adjust_cfg)
                 failed = result.return_code or result.stderr
                 did_config = do_config
-                if failed and not do_config:
+                if failed and not do_config and not self.mrproper:
                     # If our incremental build failed, try building again
                     # with a reconfig.
                     if self.builder.force_config_on_failure:
-- 
2.34.1

