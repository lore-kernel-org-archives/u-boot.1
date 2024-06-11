Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEA4C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBD2887DA;
	Tue, 11 Jun 2024 22:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h75GiK00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B158887C1; Tue, 11 Jun 2024 22:02:34 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8790A887B2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3737b250ef9so23344725ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136151; x=1718740951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKh1S8djeXX8dGLZBAmWB3QkCr648dmxKHJXLSrALSg=;
 b=h75GiK00l1W3QqGpCkjQYM7utf17Vi8KVvhWiH2jzwTiZu36AIk/U/1tGWhdpziX2s
 X2NJ2+0e4gSWBoJPvGvG0AZVgnBqskioAJmjthxEoSPA3u6PEyV86SvAFff5BrLBoxSq
 hL+l8GMESv7p/wJtVJbj88ySatFiXHDnR+8Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136151; x=1718740951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKh1S8djeXX8dGLZBAmWB3QkCr648dmxKHJXLSrALSg=;
 b=lxNhFw+Pdm9xvIbHGrNaPen1JDOCMgoIO1cgtc6pG38I3DLoHj77TKTF/zoVKQz01J
 jnnpB+UO6Jinn7WkhCb6wfjj/1NT9lNF6CsuwJSSBxak40VX+OHDMjMHBjlZf3z6I3yz
 FCpfbV2xjq/jss9ozT0cbptscBGSvT0KVfDpujfgp4bl7cyPRxJJnC+v5/GM/Pr08JM6
 lcAgyQBMPYv2+agAi0Z628KHmmJCD42J5skxFVuckz4sAs2O4hjOsHh6Ca1g0Hg7Ovaf
 m5C70qaFQRbx7NL0SE5AsLU/S+lSS/3LMcsDQ6pTZni4JeMOI6eUG841T3euA+xO+9za
 Qy7Q==
X-Gm-Message-State: AOJu0YwJ01UPSelHEOJ3no0KxE0zVZMI9WFUbUhOGXJ80Ylhkb0aDFI4
 ZDgPAPwi4Txqa8w8Aglca9yRVbdl/oT01zJtdaMRpvsr+aGcWegOkO4ESMt110z3+2Kdp6+ISMH
 JmA==
X-Google-Smtp-Source: AGHT+IGST5HWkhcGRRKQw88WzzMuaWG0INrwwsVTPn+sMlHkeq0Kyb7BGL7gXbj5LK2uyWN098DLGw==
X-Received: by 2002:a92:ca4a:0:b0:375:a282:c96b with SMTP id
 e9e14a558f8ab-375a282cc8fmr84131745ab.27.1718136151173; 
 Tue, 11 Jun 2024 13:02:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 21/42] test: Use a constant for the test timeout
Date: Tue, 11 Jun 2024 14:01:35 -0600
Message-Id: <20240611200156.2245525-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

