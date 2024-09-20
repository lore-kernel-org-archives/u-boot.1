Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D613CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402D389364;
	Fri, 20 Sep 2024 08:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/z7i8ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FCA989347; Fri, 20 Sep 2024 08:03:17 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900E6890EC
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so217852166b.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812192; x=1727416992; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RA+IK6furIdHpwKyxL6ZnfkZ/RC/QHx1NGwdCVA3AY4=;
 b=F/z7i8lstEYXCSUC1ZHDeS6jS3eVYf9Kf/oSgZMt9GoIU8c9NFWoy9MZkPyPcZwIi2
 V+qCR34Amfk2goXfk7s7lmU6XbqV3bfdTgBgy6J8oszXyhVhbH5WASJoyNX2W/GdsPzS
 O+DNjetsoKZoDUkZNJM4r9oqo2bRghcnsqY8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812192; x=1727416992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RA+IK6furIdHpwKyxL6ZnfkZ/RC/QHx1NGwdCVA3AY4=;
 b=CArQVGgGZYP4diP3LBjdK+SBnbsYKif5k07QVN9lplTTULwI4+KcHyGHmVB3aLfNlW
 pOjrJnfLeatc+QjDeI+jEo0+CmcwCGOeUl+otVSzB0X+KqLt4OtD6RfmfBJ5PltSspcg
 t8Hx3Peuu42pChcWO4ym40BvfzJztJ/0JoCaJPaMHoozmepcjJ/t22+YRYBXtgq2vDE8
 kLTBbkCJOYyaU8jecjXa/QNGd0BkxRtCJ6bDKN184P0dTP2TutjrKG1o5Hg0fZtdNX2v
 37oXXBzP4By4LvAXX4HNf6jMYBl/vYK51MDAU8agUTr4Xdmef/R84ibNVmO33jzCILtD
 oiSQ==
X-Gm-Message-State: AOJu0YzEMc6bVLB/+pLzdxwtvBpsgHSvSgJrouEvaTRT8ypi67l5Dg+i
 Ti1UoYj/IgZnpDzCBlkdM1UWZ1BIJwMVJu+dtHj5REr/n9idm8K8yZeZCeS0Z2cdYvLPOrzqR/s
 37SNyybU=
X-Google-Smtp-Source: AGHT+IEHISF7QatKETm+8cjJa31ORvTz3Y75NLxisyaU4EaRv4BYma4s8MRIzerzzfm4VIdcDuEaUA==
X-Received: by 2002:a17:906:d7e4:b0:a8d:4d76:a760 with SMTP id
 a640c23a62f3a-a90d5005e9cmr109386766b.35.1726812191777; 
 Thu, 19 Sep 2024 23:03:11 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 13/19] test: Improve handling of sending commands
Date: Fri, 20 Sep 2024 08:01:48 +0200
Message-ID: <20240920060158.106612-14-sjg@chromium.org>
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

We expect commands to be echoed and this should happen quite quickly,
since U-Boot is sitting at the prompt waiting for a command.

Reduce the timeout for this situation. Try to produce a more useful
error message when something goes wrong. Also handle the case where the
connection has gone away since the last command was issued.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 35 ++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index bcba68f0aac..e2e78179555 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -31,6 +31,7 @@ PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
 TIMEOUT_MS = 30000                  # Standard timeout
+TIMEOUT_CMD_MS = 10000              # Command-echo timeout
 
 # Timeout for board preparation in lab mode. This needs to be enough to build
 # U-Boot, write it to the board and then boot the board. Since this process is
@@ -300,22 +301,28 @@ class ConsoleBase(object):
 
         try:
             self.at_prompt = False
+            if not self.p:
+                raise BootFail(
+                    f"Lab failure: Connection lost when sending command '{cmd}'")
+
             if send_nl:
                 cmd += '\n'
-            while cmd:
-                # Limit max outstanding data, so UART FIFOs don't overflow
-                chunk = cmd[:self.max_fifo_fill]
-                cmd = cmd[self.max_fifo_fill:]
-                self.p.send(chunk)
-                if not wait_for_echo:
-                    continue
-                chunk = re.escape(chunk)
-                chunk = chunk.replace('\\\n', '[\r\n]')
-                m = self.p.expect([chunk] + self.bad_patterns)
-                if m != 0:
-                    self.at_prompt = False
-                    raise BootFail('Bad pattern found on console: ' +
-                                    self.bad_pattern_ids[m - 1])
+            rem = cmd  # Remaining to be sent
+            with self.temporary_timeout(TIMEOUT_CMD_MS):
+                while rem:
+                    # Limit max outstanding data, so UART FIFOs don't overflow
+                    chunk = rem[:self.max_fifo_fill]
+                    rem = rem[self.max_fifo_fill:]
+                    self.p.send(chunk)
+                    if not wait_for_echo:
+                        continue
+                    chunk = re.escape(chunk)
+                    chunk = chunk.replace('\\\n', '[\r\n]')
+                    m = self.p.expect([chunk] + self.bad_patterns)
+                    if m != 0:
+                        self.at_prompt = False
+                        raise BootFail(f"Failed to get echo on console (cmd '{cmd}':rem '{rem}'): " +
+                                        self.bad_pattern_ids[m - 1])
             if not wait_for_prompt:
                 return
             if wait_for_reboot:
-- 
2.43.0

