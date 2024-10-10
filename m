Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFE6CED611
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 00:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0901788EBA;
	Thu, 10 Oct 2024 02:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UKjBr/Rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A353C88AE4; Thu, 10 Oct 2024 02:29:20 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBBE88E65
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 02:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71578c14972so245020a34.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 17:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728520157; x=1729124957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9FrvZQSegdNxBS17p4p6iqsz9KrC1iSpvS+jMYKvjkE=;
 b=UKjBr/Rbvxe1K3HeN33Ykk0WCINGNY2yxBjeZkXqQaKtlaYXyt/TdL9F854NAlAxGg
 XBfRzH0LWxE7TlqxA7wkgf0wTDi8LeA2D50ePMJa2glehn7PDz0jaG3TGQkCEOaWMSfH
 7HEdIDMz37CIp1zDMBPQzciQBZgl11k9CTWgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728520157; x=1729124957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9FrvZQSegdNxBS17p4p6iqsz9KrC1iSpvS+jMYKvjkE=;
 b=k8/qZJF2TLqQhbM6o0bvBU3iVhDh/CMVeZfL+3M2yH20RwOaYwVve5OZXCgBQAOkSE
 L4e7wpz59lweDct5Y/jOvIeEO7SYVmMbvVLx7ZP2n8Q/nzh7nuhPFcJtqefWVX55qMS/
 NyMaQ+EPqr2UA8T5pqN2tKz4EJm1apNXks8gleFGE9NOcCORxVY8EpoRHfH8ZlgoJESg
 enBvRQwF2tYZNqyV3injJvFcYitMHoxeJW6Ps+L0BgCz0Hz4hv6WI9FysJXtezW8Y2Cp
 9yHR524M46UXbXf+kjXi4+0DdyoAiVbnAgkOsZwI+c+3SP8pk6zc/bPZNmwU+qe/QLgZ
 kaPQ==
X-Gm-Message-State: AOJu0Yzj2/sLR1MUqVNcR2uLI76ZpyTAtYWMHV0KzOW/viWlr9xELKLY
 ZhVzl05W3DXkS76Ii6onRT/gWXx3EkyRciyVoF0ZOCpXS3ym1UWh/AEexv88c9AgMVOeS7V272U
 iEw==
X-Google-Smtp-Source: AGHT+IHUJGaAmSDwc8ER+LkMRxnTiPGjcxUQ2ZIWa59va2cvjM9IsQS/GwnXtMDi0dJMXUSg286VQA==
X-Received: by 2002:a05:6830:4887:b0:710:e92e:53ad with SMTP id
 46e09a7af769-716a4216074mr2825979a34.26.1728520157108; 
 Wed, 09 Oct 2024 17:29:17 -0700 (PDT)
Received: from chromium.org (c-73-153-3-119.hsd1.co.comcast.net.
 [73.153.3.119]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-717cfed7536sm9073a34.2.2024.10.09.17.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 17:29:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v7 1/8] test: Use a constant for the test timeout
Date: Wed,  9 Oct 2024 18:28:58 -0600
Message-ID: <20241010002907.19383-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010002907.19383-1-sjg@chromium.org>
References: <20241010002907.19383-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 76a550d45a1..4d6cf3f95a4 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -26,6 +26,9 @@ pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ##
 PAT_ID = 0
 PAT_RE = 1
 
+# Timeout before expecting the console to be ready (in milliseconds)
+TIMEOUT_MS = 30000
+
 bad_pattern_defs = (
     ('spl_signon', pattern_u_boot_spl_signon),
     ('main_signon', pattern_u_boot_main_signon),
@@ -422,7 +425,7 @@ class ConsoleBase(object):
             # Reset the console timeout value as some tests may change
             # its default value during the execution
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             return
         try:
             self.log.start_section('Starting U-Boot')
@@ -433,7 +436,7 @@ class ConsoleBase(object):
             # future, possibly per-test to be optimal. This works for 'help'
             # on board 'seaboard'.
             if not self.config.gdbserver:
-                self.p.timeout = 30000
+                self.p.timeout = TIMEOUT_MS
             self.p.logfile_read = self.logstream
             if expect_reset:
                 loop_num = 2
-- 
2.43.0

