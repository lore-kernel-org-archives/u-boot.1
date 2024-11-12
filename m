Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33579D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D043D89458;
	Tue, 12 Nov 2024 15:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9g1wNmj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681DA8943F; Tue, 12 Nov 2024 15:13:36 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F3289443
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a6bc0600f9so21180955ab.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420812; x=1732025612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWksPU/Pi5boz6/TPh4bwNk+bYBF3PekZVF4FXCPmIs=;
 b=H9g1wNmjXAxsITQIb8QAI1+/vPaiB7ylPjaViXMn0wAEhnuYqejGi8VkA9ogJ48+Za
 drMj4E81Qm3Ppf4wN77vXRV9OqSA1BmoNpjI6phc0y7Gml69ox4tU63i5TV/H4EJghi6
 u3Z35XhidPEUsE8yE027ZHPkuff2h7NGW4ReM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420812; x=1732025612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lWksPU/Pi5boz6/TPh4bwNk+bYBF3PekZVF4FXCPmIs=;
 b=gPSCSmHH3KHUNLF+9TJHs94ddSxreRb7CrBZ/KZFWKLm1Qqy8UnbXaXkiTOoPO303T
 WSXuNYzRSBeyVeiMcDZdsK2bHsoT8AXOrflw/A51+GsyhIuYpJ9QAUzmnOspLstNEc8S
 Zw7heA/HFs3d10Wqs5QIle1Txb+t/K0wgmNN1Zrd2TGssJ+QcL2qJoroXZAVpC2+Gx1Q
 5T5vbTOResTi2Ak6kG6XTaZOhVvVDyAOqeO5dw6IeiPCsKsMifLYOUq2NnkcBylegZ07
 VumG+irHjHDwu29rfh6+GhooIN9HjVS9kvzwduUzFnQGFAPUQqFSHxr3DVNKiQfNBgAT
 0wXQ==
X-Gm-Message-State: AOJu0Yx+zqklD/S398hpXHR9vojxCZMYBpYcaB0qyqhPZqygV8R8Hpi3
 If0zChSMTbsSg6xuUH7DFthX+8PWgILuIoqV/p/m9zJqvtN2xvTenCnoRPzvmJfyH1+04gRhiL0
 =
X-Google-Smtp-Source: AGHT+IF/6K1PXymXOKsb4MKYwhx1JcCMd8O/3XarnjF2p4rmRzRohYzx4sP0/71AnpdJS6yKVIE4Eg==
X-Received: by 2002:a05:6e02:174b:b0:3a6:c7aa:a2b6 with SMTP id
 e9e14a558f8ab-3a70c7f8cc9mr32332545ab.2.1731420812328; 
 Tue, 12 Nov 2024 06:13:32 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f98932b9sm21275355ab.77.2024.11.12.06.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:13:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v9 01/12] test: Allow signaling that U-Boot is ready
Date: Tue, 12 Nov 2024 07:13:15 -0700
Message-Id: <20241112141326.643128-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112141326.643128-1-sjg@chromium.org>
References: <20241112141326.643128-1-sjg@chromium.org>
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

Note that this does not change pytest, which still (also) looks for the
U-Boot banner. This change merely makes it possible for pytest to
believe Labgrid when it says that the board is ready for use.

In several cases, the board starts up and Labgrid receives some initial
output, then pytest starts and misses some of that output, because it
came in while Labgrid had the console open. Then pytest fails because
it doesn't see the expected banners.

With this change, Labgrid handles getting U-Boot to a prompt, in a
fully reliable manner. Then pytest starts up and can simply start
running its tests.

But, again, this does not prevent pytest from handling a banner if one
is provided (e.g. if not using the Labgrid integration).

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v7)

Changes in v7:
- Rebase on testb series
- Expand commit message

 test/py/u_boot_console_base.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index d8d0bdf9fd4..965832a4989 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -23,6 +23,7 @@ pattern_stop_autoboot_prompt = re.compile('Hit any key to stop autoboot: ')
 pattern_unknown_command = re.compile('Unknown command \'.*\' - try \'help\'')
 pattern_error_notification = re.compile('## Error: ')
 pattern_error_please_reset = re.compile('### ERROR ### Please RESET the board ###')
+pattern_ready_prompt = re.compile('U-Boot is ready')
 
 PAT_ID = 0
 PAT_RE = 1
@@ -200,15 +201,15 @@ class ConsoleBase(object):
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
                 raise BootFail('Bad pattern found on console: ' +
-                                self.bad_pattern_ids[m - 2])
+                                self.bad_pattern_ids[m - 3])
 
         finally:
             self.log.timestamp()
-- 
2.34.1

