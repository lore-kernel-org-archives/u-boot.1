Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D745DC7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2179F889D1;
	Thu, 29 Aug 2024 00:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QGNwBfyS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C11A889ED; Thu, 29 Aug 2024 00:09:02 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253998862E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-39f37387c21so2517895ab.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724882932; x=1725487732; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=QGNwBfySu4HageLUWGVMUmoHEe9pTxHkZePpw1P+i7InLhMwnimF+mU7OCGpsy3BqQ
 Wp/XH9XGla29phkKdOMWOFSO2+ZWwKkwGyaiBgcraVMi5sVm7gUxAVTX3YuhJbra1mFO
 yfFSxzWJPX4kOPAts2qnJmwU4OlLKbOgoyNF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724882932; x=1725487732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=KmZ88ItsyCeUR9EDlezRmKXS46eEgOeFND0e1X1O0yGDKLGxw0F/11w3dnX1i/cVtv
 OVPbeATLtI3Wmya81qK17ADqNP/fL4WGH30/QeJA6oZrp6kaHJkibggpmCq7LMoCEFOq
 lUXz8UH4UJ2gHBRWkKJWr8bCR0uxmVAGzoulY3ShL/fQO9v86Z4FOWVx+jG0vCVCfYD7
 4Ij0ESKatqYqJxscTcj0BvtkKnY9p6K34541g50hE8B6mPd+5mikSs3T0+ZPgsdNfTj8
 8mGnUOEHjNx92AklDLCDHZ0UXyXghlmSI8SvxRVS63ITnH7RHVvsTU+yG1Q0LexLEGk1
 p6mg==
X-Gm-Message-State: AOJu0Ywu/Wgle8w0VewifyokHuA9Hfg3J28YlcTXEd3NM+XO/IROgFZN
 IW1pHXQCYTda5FxNFhbPwSawfjav43dFiz2n85mWHy0j0fD53rQ3eXQbGFsJk8ECPZ4xwBv8xMs
 =
X-Google-Smtp-Source: AGHT+IEAf4C7/CXzWYh1JAm/5m3JLFK1hrKdJJwBOh5rLjHkiuwsljuagEtUXJQ4fa6gGGv8jSpYTA==
X-Received: by 2002:a05:6e02:170c:b0:39d:286c:5b74 with SMTP id
 e9e14a558f8ab-39f378b7c00mr12960815ab.28.1724882931732; 
 Wed, 28 Aug 2024 15:08:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f38e683c1sm838105ab.19.2024.08.28.15.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:08:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 02/20] test: Use a constant for the test timeout
Date: Wed, 28 Aug 2024 16:08:28 -0600
Message-Id: <20240828220846.1205813-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828220846.1205813-1-sjg@chromium.org>
References: <20240828220846.1205813-1-sjg@chromium.org>
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
index 882d04cd1e9..9cc0af66356 100644
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
@@ -423,7 +426,7 @@ class ConsoleBase(object):
             # Reset the console timeout value as some tests may change
             # its default value during the execution
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             return
         try:
             self.log.start_section('Starting U-Boot')
@@ -434,7 +437,7 @@ class ConsoleBase(object):
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

