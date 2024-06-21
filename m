Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ABAC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55239886A3;
	Fri, 21 Jun 2024 21:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHclqIfp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6501888631; Fri, 21 Jun 2024 21:52:45 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569F28864D
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-7ec07f4170bso94585839f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999562; x=1719604362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fo9vpmeruqsgvUynL63jB+IPx2Q2+HTITg+fuAbOBss=;
 b=HHclqIfpG42VKv+HosMGxX7HbNP/Axn/Awvo4ZmiC/7y2pIBQgOUNulcnJc2/UbdS5
 NvIXALTb/PFqt3LuAmjdfC83LzQuP4wzc1/6wwUM+UryS0e1rtVX7J/mljsBwehpMl22
 qf8EjdezbvFjaY81TR7/k+GtbHSMYEclSIc/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999562; x=1719604362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fo9vpmeruqsgvUynL63jB+IPx2Q2+HTITg+fuAbOBss=;
 b=kKJjC+wVisAFxgHeqvz5eQwTAkKC90WxHNXvWGdo5vuGc4B6k2k/QykB3r11e19YJZ
 fxTsxRUmjTTY0lELBszv0Z20DTIn3dru3/vcruiMkViBE+Sep6JyQfBEK96c9mMMheI0
 In9MosCBC8jMmOR2zKsLmB2a0yQWQ9e3JkZ85AbIlBiSaZYtpBLCjqTozvz4qR9BdE7m
 Sf6L9sarInsAIjRqgajxPdIZ+G3xu/WxepVVesWzorcW03UHUr1NqIPh5FL67IX/ulb3
 8hcYPiyJhLMO3PUKLv36H2AVvbjH99qKE+hUy9Qf+jJmI8AW6NBu+0KULGamTgCf34jB
 dZTw==
X-Gm-Message-State: AOJu0YzLV+U96KwPDdUD+FrsWOh9NrWJlZWUPkZ4CnYSTSQyI0oc3CqC
 IQIReowT8SKwD9fV+5eetvrqcviAsScPteIqx5uruHqO3VJndcYgof0isTts6qdWtuo3jjBLIdl
 KC+Vu
X-Google-Smtp-Source: AGHT+IGbksRtGQc7cqq0/lQswJyPK6Z3QjwCrNoDosNjaiba1sEzQTggIQSqgLh8cEsIcSx7pMJ/WQ==
X-Received: by 2002:a05:6602:2dca:b0:7eb:c37d:30e7 with SMTP id
 ca18e2360f4ac-7f13edb273dmr1039880639f.1.1718999561844; 
 Fri, 21 Jun 2024 12:52:41 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 41/43] test: Add a section for closing the connection
Date: Fri, 21 Jun 2024 13:52:02 -0600
Message-Id: <20240621195204.2675252-42-sjg@chromium.org>
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

This can take a while and involve multiple steps (e.g. turning the board
back off). Add a section for it and show the output.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 1b00821c5e9..95096fc123c 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -157,7 +157,10 @@ class ConsoleBase(object):
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

