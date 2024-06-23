Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43219C2BA18
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5CD88582;
	Sun, 23 Jun 2024 22:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cw5eAoEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840DB8854A; Sun, 23 Jun 2024 22:32:24 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D99B882E6
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so209064339f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174741; x=1719779541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=cw5eAoEqjF7nPp7oiS+gYQCzVVYWMHuZsWhPfMjlaimxP2iCyipEpkR7MmLnGosX8W
 5FtICIVF6v+OMN1nYs07BTiSLy8IKofv3c74aL6NMr+umjwUg+dBXhn4SPCaombjdfYV
 wRkoSWOp59r0naZd7mKrO0QWoUe46Cu6qWlzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174741; x=1719779541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bYXyQsRqtsBnO3GE7g5g2m/2vv435FQ3x/HtVb7x2JY=;
 b=riWR5ODOXd9qZ0oPTJnAkU2ASHm0rXZSIzhBqeTutndE09zx88Q/Rz4rTsdsE/w5Kk
 QsrsFcwYsil0jICNd3eFDDjrl3tdP40+JT4buYPnuQR2+X4zmhdF7FIoi1oI6XBMQ2uc
 f7qnIooAf+o8EVwIXEG0Bpjlmdzl0Xl/52BIU3wfZRyIz4bLF+QVlE6jFSJwG8U47F9b
 /NgTjnhlqmn5k6k6M1S5qMEp/8fdXR3gQtY56XLpiH7k3+3P6AlO/nFErVx/D+WqZSaP
 toBYX1ME/Flro6cyres06VcwNzLuQ6uIMnSO2GrNToUghzU6Ft3KNiqpkhfN2F4hTYre
 Eo8Q==
X-Gm-Message-State: AOJu0YyTGesDUA60IASmgsTFRLc7NWNp8AG6ZnBy/VFIR7aMzEJ+b+ca
 TWkQHJamYCQzxU/UmbfXYK+3ihXvYhl9kZ+jyBHMaXDGSiq+N0iaCPJllHV/0qfuR7sMRqaUROJ
 WCQ==
X-Google-Smtp-Source: AGHT+IGBxHiHA53fh9jrpEzTxNgkkiafYqCNPAuGv8TGqsiARzyjVmY+SLGxy5aLz2c8IvjwhAplmw==
X-Received: by 2002:a05:6e02:15c5:b0:375:9dd4:d693 with SMTP id
 e9e14a558f8ab-3763f59c2c7mr42960745ab.3.1719174741015; 
 Sun, 23 Jun 2024 13:32:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3763374634asm12016765ab.52.2024.06.23.13.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:32:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v3 02/19] test: Use a constant for the test timeout
Date: Sun, 23 Jun 2024 14:31:56 -0600
Message-Id: <20240623203213.1571666-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203213.1571666-1-sjg@chromium.org>
References: <20240623203213.1571666-1-sjg@chromium.org>
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

