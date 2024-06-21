Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7A4C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4837388641;
	Fri, 21 Jun 2024 21:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6ASKmP5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDD68857E; Fri, 21 Jun 2024 21:52:36 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF7FB885FE
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ea0b5e0977so97694439f.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999552; x=1719604352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjl01oo/zYgNsESARtjMuhhXIjsgTRhjuyoEbdCHLeY=;
 b=n6ASKmP5iKb4a/wfDMEp5YjKFub0Q6mVgr9BRr3AoJ39LydffpxjEdckfE/9pRionc
 mqG6Mh+bedAZSwJkvLX5G7IsJAqXcKJDqtVLIRsw6JcN+sF5xzmr+MHGR/6YhUpnlnd3
 +thRIYmeVpgyzU1Ex30/3KDmf5XeD6AH8Wj/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999552; x=1719604352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjl01oo/zYgNsESARtjMuhhXIjsgTRhjuyoEbdCHLeY=;
 b=J6xPK+oMAiHmnm7GgBZjpuqe4XJCfv3ILr2xhsv3yvTOkJNnV2+RKsapFhChA/DhRj
 J1dzmyCrWr4noOpdrXo9G9ZXSg707uxRqeNc0JQOF3gQ9lHb9bvPckl6urdEB0USWngy
 hU5kaSouSD9xnUN4p3rR//RfbHGYj8AlX92uN2rIPsRm3dCgXEq0IZ99wMrBjh/pxRes
 yafGSaiBk8161Q8JRgDTrMGEeGz2RDvIqD+CfzUZENgaTntm3UKKQosfhoTotWAQc+p1
 cAk00v57cUb/FjNDPgTrLGxL95NNw+50Z00dqOsMBaamDaB+1iH72iV166dkDYXWlskx
 O7uA==
X-Gm-Message-State: AOJu0Yyd/atHiDnNA9qTkBgcfy7U14Z+lezLjSvlpNmVs7guBIRSoCpi
 qSHTM507h2EN8+hbRV1AHu7mX7VgsyiURhuLXrRJGNZAniukSF5urNX0R0/pydFR2uD0d0D2+Dn
 CAQ==
X-Google-Smtp-Source: AGHT+IG1c3gjLxjheSuiBx78HCsRBvggh1tkZtjxMw0dyn0SBgXRTf/jEPixv8dEeukcDnaSJvva4A==
X-Received: by 2002:a05:6602:2c8d:b0:7eb:8a0f:1f32 with SMTP id
 ca18e2360f4ac-7f13ee68305mr1118884739f.15.1718999552482; 
 Fri, 21 Jun 2024 12:52:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 29/43] test: Check help output
Date: Fri, 21 Jun 2024 13:51:50 -0600
Message-Id: <20240621195204.2675252-30-sjg@chromium.org>
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

The current test doesn't check anything about the output. If a bug
results in junk before the output, this is not currently detected.

Add a check for the first line being the one expected.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_help.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_help.py b/test/py/tests/test_help.py
index 153133cf28f..2325ff69229 100644
--- a/test/py/tests/test_help.py
+++ b/test/py/tests/test_help.py
@@ -7,7 +7,11 @@ import pytest
 def test_help(u_boot_console):
     """Test that the "help" command can be executed."""
 
-    u_boot_console.run_command('help')
+    lines = u_boot_console.run_command('help')
+    if u_boot_console.config.buildconfig.get('config_cmd_2048', 'n') == 'y':
+        assert lines.splitlines()[0] == "2048      - The 2048 game"
+    else:
+        assert lines.splitlines()[0] == "?         - alias for 'help'"
 
 @pytest.mark.boardspec('sandbox')
 def test_help_no_devicetree(u_boot_console):
-- 
2.34.1

