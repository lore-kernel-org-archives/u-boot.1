Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1494FC2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54729885EB;
	Fri, 21 Jun 2024 21:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mXTuY0/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E1FA885C5; Fri, 21 Jun 2024 21:52:29 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0312A8856F
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7eb9e7f3da2so99227439f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999545; x=1719604345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxLbNXGoaXJvLvumbBY4pNS0+jFG7Ox/AWRsfxKB3CY=;
 b=mXTuY0/XxqHjO/jcAEUlhH3kk2dPApafJPTzmg6l+8lT2i2WQx+r4kTRJMv62GteOh
 EN1YrszzwNsXBc4sQ3v0syQHgFG5rs3snyjjuq1gXU8NJRblTj/jmXx2buqkc6045wty
 +maSf4v+bwDK9xzuxu7bCjJJeNUHSu9kvN/k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999545; x=1719604345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxLbNXGoaXJvLvumbBY4pNS0+jFG7Ox/AWRsfxKB3CY=;
 b=AJiqUpYtU0nYF93d3xHmeaSEHqoVc4K+GuNQpmNQZ80ZLGiHrkGbHVnUqxw2P01Acv
 XLN4A53pqP8WkckybIzFVrDVVSLERLBhMi1SqroHwbiFPdORqHROQIeg/WHqHcRDmm7G
 TvqSV39vVAvtKyX7pbwbgXWvcqfXXmg4PHD49M0w+nYWfYLpcLz2IFEpz/eHXW0PVYR3
 Yhnq+nxrUUlQ1UBc2YdblaRu1lJ0I6OB+42rEn0sYBxbo6KxC3qagJBbjdQR7vy9wKlR
 8BUl/wd5moyeJ56OvM4m4tvLi6iVCwmCi79YtvBtpusNulfAI5Cnkr/ZSIqftpKMpc00
 Eocw==
X-Gm-Message-State: AOJu0YygY+UfLSoOpC+NS18uV41gFE07m1aC+cbv04x9eLLYf3/a5Db/
 9wgEe8n27eXRxpOO/GFEQ6LOBiPISWwlLok+cpwRs3rbCWAWDnN2f9TBrajdBYSVjBSUshPCPMA
 ehw==
X-Google-Smtp-Source: AGHT+IER48vEHR5yAA+ivsDvInt1J4JIX1YJYxvOg1dsU1lQWPif6rPDLQ9Ug2GjLmhvXpTzn8gWVQ==
X-Received: by 2002:a05:6602:13ce:b0:7eb:8d08:e9de with SMTP id
 ca18e2360f4ac-7f13ee617f3mr1247279939f.14.1718999545635; 
 Fri, 21 Jun 2024 12:52:25 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/43] test: Make bootstd init run only on sandbox
Date: Fri, 21 Jun 2024 13:51:41 -0600
Message-Id: <20240621195204.2675252-21-sjg@chromium.org>
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

Tests for standard boot need disks to be set up, which can only be done
on sandbox, since adjusting disks on real hardware is not currently
supported. Mark the init function as sandbox-only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_ut.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index c169c835e38..58205066ec8 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -470,6 +470,7 @@ def test_ut_dm_init(u_boot_console):
         fh.write(data)
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
+@pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
     """Initialise data for bootflow tests"""
 
-- 
2.34.1

