Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF46C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE204885BF;
	Fri, 21 Jun 2024 21:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fmALs/S9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2AD28857F; Fri, 21 Jun 2024 21:52:29 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F6D885B3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7eba486df76so74195239f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999546; x=1719604346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCz8NCt1Hzx5joBNfdmCQ0X1id4UaWgSf5o9/sz8zMU=;
 b=fmALs/S9mFARtQuf9vKjgAdmE64roi30JdfluqFDj6QXb/zvzPxd6bepVcaroJEKHy
 sMNU7/gOQ0OQdGE3sWoHhmSK9c+6N/MNWUwCMcEqRvFCNKQR5kqPvMfxi/0BnHojzKI8
 BrxrI6YJ38bNRQF5AIlPCjlWJWHDdYuVCN1Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999546; x=1719604346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCz8NCt1Hzx5joBNfdmCQ0X1id4UaWgSf5o9/sz8zMU=;
 b=bOlYcAJUjq5tvZxt/DxsyptKgNb3tSIksM5TzXUVyPpgfSE+AFzkfTCzPjfmT+3b2F
 vPb1D+g4JAD12+ptZLsAmTeWGfZhtMSE5tHAfWDXrCuL3EAA0/lcICC1tVHSv37GA9Nx
 xpmXDmXn7e9sUWDdLbaJbC6S4PSSsC8WgiTQYpriq3c8MRQkXDL35QoEyyPjiAKsucqw
 wPVr8rxzXQfPwripEu/jmVBv5FD0s/snIF3aQxZeW8UWqNWRRYW8VYnJ6ddCXklY2eTD
 QXa9DkzakErsxoFIkiEVUUSPtPWaLQzIycb4tqBKj9R65zGtw3fdKwuM5CB350Y/eTbB
 7kGg==
X-Gm-Message-State: AOJu0YzpFrlEoEJFTJV7cCP8qm8nr6kYCYfWOux1P6mQ4zw9Pwur2wRC
 zDIjZUWB96Xx0XEqcJ1cmYw6NCuezdSxsZ4+jJPeyoMxoyafLFJm4dQmtD2gAXTbjuMcAC1OUmB
 UMw==
X-Google-Smtp-Source: AGHT+IGMqmBBtAJxn3u8RhjojeXCwL1SeD6yi0JlByvX+t3vgjjL2wpLOfuQMGubnS2qZwH9V7Ivpg==
X-Received: by 2002:a05:6602:1547:b0:7ec:19d:41e with SMTP id
 ca18e2360f4ac-7f39abcd1edmr47339039f.7.1718999546400; 
 Fri, 21 Jun 2024 12:52:26 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/43] test: Use a constant for the test timeout
Date: Fri, 21 Jun 2024 13:51:42 -0600
Message-Id: <20240621195204.2675252-22-sjg@chromium.org>
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

Declare a constant rather than open-coding the same value twice.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index e230caf37e1..e4f86f6af5b 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -27,6 +27,9 @@ pattern_ready_prompt = re.compile('U-Boot is ready')
 PAT_ID = 0
 PAT_RE = 1
 
+# Timeout before expecting the console to be ready (in milliseconds)
+TIMEOUT_MS = 30000
+
 bad_pattern_defs = (
     ('spl_signon', pattern_u_boot_spl_signon),
     ('main_signon', pattern_u_boot_main_signon),
@@ -397,7 +400,7 @@ class ConsoleBase(object):
             # Reset the console timeout value as some tests may change
             # its default value during the execution
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             return
         try:
             self.log.start_section('Starting U-Boot')
@@ -408,7 +411,7 @@ class ConsoleBase(object):
             # future, possibly per-test to be optimal. This works for 'help'
             # on board 'seaboard'.
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             self.p.logfile_read = self.logstream
             if expect_reset:
                 loop_num = 2
-- 
2.34.1

