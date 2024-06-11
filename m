Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41E9C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2580887C0;
	Tue, 11 Jun 2024 22:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwaF4/tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28F57887B4; Tue, 11 Jun 2024 22:02:33 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA7888730
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso25283865ab.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136149; x=1718740949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcQmcXiYKGIPan3cCnjiFgcA5e7cuV+KxudUtOwwAbI=;
 b=jwaF4/tpRFcntjO+WCJ8N2mBw1/Q22+yxopai4rvCMDZ0yN+u8jeTwqMLe0hSrpp7s
 i6NgwMfdjaLGFq1rjb5jEf7dyCc+xlLB8tTAgQ+lZr8dK/2OHW8TsBIKoUW9NTnAdqXF
 4W+kopMphzfqry+Jie7x106GckRPFC//qJ0m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136149; x=1718740949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xcQmcXiYKGIPan3cCnjiFgcA5e7cuV+KxudUtOwwAbI=;
 b=WroRK4kHu2kNXlGsCTGXYEI2A+XOHi4psotkSKSEAgHVTFFTp2iEXNwPjXFg7uuPq4
 bRfGwcF7895O+p93C8cPgLj2lOb3d4l/f2bR6ERDW/bniqWb1vBejy6sx72GC4qG4vWt
 0ELw0K4tIWF2U0wnmgjVB0oZjsCaleXd0zcgsk4y4iab4blHDpjdywvvUwUmuYbMdLTL
 jrAepHgnhhXODEzmcvSzVve96FwuaUfxRPYa3flX2O+KRskZVNp/r7SK1zzyU39zvL6G
 69k9hOlhH4HPsme3C/2CUuUzL8FnVRzhZqCXTtcSa+FnctL7hDy97kXwdY0dL1xuFdG/
 m9lg==
X-Gm-Message-State: AOJu0YyMIcVClXj69H1+Aw3idP8lCdd9/zwEty3suulIIAJr1XeEVzy6
 2vdFV/CsxQ24unA9l4Cl84mgI0KSRTS4lUgPyGfdZ20ecve9QBhgQkumSlLJCLISVsT9dl1R76o
 UeA==
X-Google-Smtp-Source: AGHT+IEHUmuyUIHRQ0MpYcLAZmHnui8TT5OywSJGYQOVAEnx/0CQnZ2tv7RpZgHwGWTDhdj59XPV1A==
X-Received: by 2002:a92:c241:0:b0:375:a48d:fda1 with SMTP id
 e9e14a558f8ab-375a48e0215mr78102685ab.2.1718136149588; 
 Tue, 11 Jun 2024 13:02:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 19/42] test: Allow signaling that U-Boot is ready
Date: Tue, 11 Jun 2024 14:01:33 -0600
Message-Id: <20240611200156.2245525-20-sjg@chromium.org>
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

When Labgrid is used, it can get U-Boot ready for running tests. It
prints a message when it has done so.

Add logic to detect this message and accept it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 3e01be11029..e230caf37e1 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -22,6 +22,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -170,15 +171,15 @@ class ConsoleBase(object):
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
2.34.1

