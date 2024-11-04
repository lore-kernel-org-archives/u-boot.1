Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32543D1CA07
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 22:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948C688F14;
	Mon,  4 Nov 2024 23:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TrkvHyQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CBF388F0C; Mon,  4 Nov 2024 23:46:04 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7781588D29
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 23:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83a9ca86049so173334239f.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730760360; x=1731365160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GkejL3D1kj/14ZBU97aYXLqujLRgHMh9ge7doZQ/Xpc=;
 b=TrkvHyQW0/43yMNfT0S15oAtRKt8yhd2eKbVtN+PJePIe3uBb8KVVA3TAX7/tsS45i
 BSdz4LB02ywxEE5w6jAwju2E5vlRunbnlJoW1FvgHct7c8YrxXxvdsU9xpmmHofFJpwK
 bDlHLAWNupVcRgCP/4VzJGNjZ+DE/tIBDAD+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730760360; x=1731365160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GkejL3D1kj/14ZBU97aYXLqujLRgHMh9ge7doZQ/Xpc=;
 b=KRGavVnp71isNR31QCVoYH+H6o/8iLkekO7W6KvaIbzc/2FjT/BHG4tIU2aMjfMAc8
 zPiPEwfCeBpPmKuqB9FFlVe22/5BWE6D+QaGgcmKVcDu1oUXoOwqahRBk0NZvSwqIeFJ
 2a0DkFiGCQePIKMwxb0Xt/xNBm2MQSqk9IW63yINAooeFQCmvS3IJUI8UzgnMi0DyQV1
 ciabSzPfQTabqAEThyyv0qr5YUbU9wl7i6gWgn4gTuKOPr3Hm1z47WD3Vd+SQd+SaqdH
 +6JLHkJWNscTJlwVJ7EsMRJYsKBKbBBvw5Vf3F03lO/jvY0IQzR3OZf/AxJyDn773Nhc
 TFPw==
X-Gm-Message-State: AOJu0Yyb5F7a6AIRGQwDMTzD0g3+gOEBYepqd7nvRHl/dN5VPQxaG2rx
 EBfm3aNgb408LcSgQRHp1CU6ihNaL82vDT1F1JnB82iH/y6vmhrA4uL7NZ5QNiPlUTbqxr9B4AM
 =
X-Google-Smtp-Source: AGHT+IGDHnPWM0dkB7g6gQzGPS7Gm9tkpGEwOwklp6w0D9N+1Qft30U3zCWCvxcNzIVUw7muVUeXjA==
X-Received: by 2002:a05:6e02:2407:b0:3a6:bf1a:17d5 with SMTP id
 e9e14a558f8ab-3a6bf1a1e61mr95766315ab.0.1730760360618; 
 Mon, 04 Nov 2024 14:46:00 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6a97b009csm25535945ab.4.2024.11.04.14.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 14:45:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH v8 01/11] test: Allow signaling that U-Boot is ready
Date: Mon,  4 Nov 2024 15:45:28 -0700
Message-ID: <20241104224550.677442-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104224550.677442-1-sjg@chromium.org>
References: <20241104224550.677442-1-sjg@chromium.org>
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
2.43.0

