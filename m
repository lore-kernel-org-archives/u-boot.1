Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345C4C52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 02:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C2E88ACB;
	Thu, 22 Aug 2024 04:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SNhk2o5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875DB88C94; Thu, 22 Aug 2024 04:56:43 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B9A88C88
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 04:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f9339e52cso13920539f.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724295400; x=1724900200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=SNhk2o5dlPqEzxAZo/NnKb2m0zSzCYZESFS1+4Ba8WS3X/crN8DdyQas7ApKoz3VFT
 REUHfsqxmhyqlLlapWzfcly9KUYN+uW4UOy7CNihhLsYc9B/WDZMwTq9ieR5cJ5tU5km
 YMot3C7brgTuow95AzgWVGZftTfVbAVh3DaDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724295400; x=1724900200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9juF+I+9ovyAkMk+tiDodeaUhfhyT4QIvN8cdNOkH8k=;
 b=Hu7pbX6r+xvQoOjWgPkWBjlI3m45B84FiTqiOQXc1T4VyEn9kb/hgT9SfCK0dTbuYh
 +SrLv/q/VKHbVSzkQ8QvA1ppSMVtgWSP6TYTizaXcz2Fk2H94cKYc8+qfw7SD4bltd3p
 A+73dG+V+7uzoSRH1BJGcNypDDfcgUV4vAmjdBDToYbwQ/L6tNQbwD5Ed9FWM91Ra1U4
 +5byBN1aLzW1FHEprR9/6dNyjAhJKIt177oTgQfkCj1oFljId5VYPlLDwDhCKiCH/0dR
 YGmtmo2ToOzmr2rKNU5q9vcjo8yYXsr9PCgMLpcuc4b1xOiWgkrTUbxMMXq3HmUI5xod
 nAnw==
X-Gm-Message-State: AOJu0YyeQR+ycKVzEQhJByZe8O4SUS2ls+XCltX3yvm8eTcdaFT2dROH
 T0IRZbCKO87BeJgEDVaMFblzZImwHspu4rDzyTEXZCveei/8jAQr///8iG93JxxSo+mSrTMYCxs
 =
X-Google-Smtp-Source: AGHT+IHgct1IDAeioYiyVQxBUo/hK7nl4V/PQbbC828trPU3/CbnS8YTp5lf+pIRzAq/Hjj91acmbw==
X-Received: by 2002:a05:6602:3410:b0:81f:75bf:6570 with SMTP id
 ca18e2360f4ac-8252f432b40mr555404039f.5.1724295399895; 
 Wed, 21 Aug 2024 19:56:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f200a0sm209403173.27.2024.08.21.19.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 19:56:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 01/19] test: Allow signaling that U-Boot is ready
Date: Wed, 21 Aug 2024 20:56:13 -0600
Message-Id: <20240822025631.1838434-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822025631.1838434-1-sjg@chromium.org>
References: <20240822025631.1838434-1-sjg@chromium.org>
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
2.34.1

