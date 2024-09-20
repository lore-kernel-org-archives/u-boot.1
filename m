Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47FFCF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17ACF89324;
	Fri, 20 Sep 2024 08:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UEFG6wnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED7A18933B; Fri, 20 Sep 2024 08:03:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246B289329
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so179430766b.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812179; x=1727416979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG2iEQpT6qRzY/eWfMN81JYERjsM+naVtqrVB1W68p0=;
 b=UEFG6wnnzw2Uryeo2M9Upg/tTB03PzcgCLxwySkeagYcMllNx81JL/9iU5zRqP5U/R
 cQ+2UuYuU7XOsquDb6OxlxjDoJodpi1TNJmEKEaZBWSjQ7+76x9y6gDW42boR2BTdsal
 CZcGnUK2MEcub/cyZRb6AFgzXA/6PdceqBhfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812179; x=1727416979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zG2iEQpT6qRzY/eWfMN81JYERjsM+naVtqrVB1W68p0=;
 b=DuAmgZvyXKR08EcqWL8VfKufqM4Sq9OB2i7zk9g5NzAn6ZwkZvO/ZufToQjYz3/TK4
 ognTCPc5zDugFV196AOBTsi84JBNIKsuNiAAIGfAwMcZxgeLJzGaqUA4tc/2gCPCITaV
 3WZcnOPzmleV7ZIOoGAgvcwOC/1+P9J87jPMAuCmAqIYi7Vphbl5F5gt6ZGlEGmqUMp0
 cs/XE0oPu4wDTCfMDbt9qqh2V4mPsVIXpNYp1PuulKFPDxggk3qasUDAdtxBZOWYr07s
 q44+jCv7MivpbDuH8aUeGpgRCPJCSvh7lMlFQyxzPlYd+ksjhVNSyx+8vaHjTQ7zfbW+
 8Utg==
X-Gm-Message-State: AOJu0Yy8BY58Q8AfhTsmgVmKQQKfHOFSw9vy8oRrWstuCDmO3g2q5nDH
 qJPOE0Tde9I/QcOFAPuyqMi07TuNgRh0r0tOQ9u5TnqbvFG5Jzya0IMXGixuXQquk4S/Hw5htnW
 LNKPV
X-Google-Smtp-Source: AGHT+IGV+q3UXNxuWgOxaKyCWioEDKYx7E5DdVYFxwGxUquZ5jtLsst8TdxUXAijJ35sj13nHAMBaA==
X-Received: by 2002:a17:907:c7de:b0:a7a:9447:3e8c with SMTP id
 a640c23a62f3a-a90d4fcc366mr114975166b.3.1726812178942; 
 Thu, 19 Sep 2024 23:02:58 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:02:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Date: Fri, 20 Sep 2024 08:01:36 +0200
Message-ID: <20240920060158.106612-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

When Labgrid is used, it can get U-Boot ready for running tests. It
prints a message when it has done so.

Add logic to detect this message and accept it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 76a550d45a1..882d04cd1e9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -196,15 +197,15 @@ class ConsoleBase(object):
                                     self.bad_pattern_ids[m - 1])
             self.u_boot_version_string = self.p.after
             while True:
-                m = self.p.expect([self.prompt_compiled,
+                m = self.p.expect([self.prompt_compiled, pattern_ready_prompt,
                     pattern_stop_autoboot_prompt] + self.bad_patterns)
-                if m == 0:
+                if m == 0 or m == 1:
                     break
-                if m == 1:
+                if m == 2:
                     self.p.send(' ')
                     continue
                 raise Exception('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 2])
+                                self.bad_pattern_ids[m - 3])
 
         except Exception as ex:
             self.log.error(str(ex))
-- 
2.43.0

