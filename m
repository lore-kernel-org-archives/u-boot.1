Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC6EC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0D180540;
	Mon,  3 Feb 2025 18:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHGHIlgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B028780725; Mon,  3 Feb 2025 18:43:24 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EDDF800D7
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3eb9ba53f90so1386951b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604601; x=1739209401; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7mHQuKYuD5A/fpiOxndJQpYTOigxDpGzePmVZqnmHk=;
 b=YHGHIlgCFJxhbiNzsFV3RPoi+kvkHwa1/B288rccWcuBYE0akrT9Kq5CrImZ/ORzk9
 0FpbmUhP6x4vwbcwnOMCl8A1ZmzXr10e6WW2vlLDuItYeBVlH31iYBXOXtWNX8oVoODN
 Mzmt9XJ1guMnl8M3cR6ytvedeAYGyC6HyZ0Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604601; x=1739209401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7mHQuKYuD5A/fpiOxndJQpYTOigxDpGzePmVZqnmHk=;
 b=ICK0jkjAudEyNWfR0ju2izixQ6tcjV4+x6EqfBzAS1+gWdeNPQzHqnPSsR9+1O29Cw
 zClB+aIwE0EVl8Q1BvZKz6AUdPZ73ORDppcopMrswv3jSR1BpQZLckljjRUPP4L1h6SA
 Gwjy/o5Pdegdr1UA8HKmGlab3fI0I/JxqVGCTLzYMK3ybA5kK9+NHrjlKTpu3yurDreu
 1nVLvWlVdBrKdDZIQYL5kkHh9BuHWM1huCShdxlJeqJU2InKEuTaCrg2AY7ZcWxpb17/
 zodd/1tfVX5p9q89zJ7qS5bOnB6A2ZnmoYShWcRPMBvcK4vmRrFshAfzMDlUsHOlzaoI
 8yHQ==
X-Gm-Message-State: AOJu0Yw0IQqhOeCL7mr5g10p9aeEF3p1dVy7/LqCPadYC4wOLE/zXBf1
 YGBYjchK6HgwZMIcjTefClWBFgRIYQlW/jMhWBjii+/jPub3dFQkF1T0wyEgFZG3n+t132OmkJs
 =
X-Gm-Gg: ASbGnct/7jqTbKx2Ignx6HmlwkgWOzc4FhXa88gMh8VoJykY3VH+/MArCnCYZLcYyFS
 0erXRHsHzxgZGyJSPSalmG3pWRCwIUY48v4wNfl5DlKtOiFyTPuqkiFeiaMphS6+baL/gzd6GZ/
 7MNnj3Cfx1FiVbq0uxbRLbiG3bQ/LA4swnlIU8rbwHJin1e1iigVnpTnH/VuH5dUGnY1RzncWYX
 0W7Q8ilAGwriLIk+wUL5TEs425o8ahiJ8Rey3vo4ef9ClrEMUFo8fkAChQ5mg3jR125CxFceaYo
 L4WYIXKvFaV9i5ijFnb7ifI0maaUvjmmsQ5gHR8g5FXR3of/5oB9
X-Google-Smtp-Source: AGHT+IGGAbZygB70ej1aMl8WSd/z1pv8AghmfV2ryj+aYofx/NMHk72fzO+sPjwcZm76bGTCzKzdhA==
X-Received: by 2002:a05:6808:1c07:b0:3e3:c411:adf0 with SMTP id
 5614622812f47-3f323a8d143mr15346763b6e.21.1738604600772; 
 Mon, 03 Feb 2025 09:43:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/32] scripts: Update build-efi to support building U-Boot
Date: Mon,  3 Feb 2025 10:41:59 -0700
Message-ID: <20250203174245.1331464-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Build U-Boot by default, so we can select the correct board and make the
process of trying different boards less error-prone.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/build-efi.py b/scripts/build-efi.py
index 495817bc064..3a1bf180ade 100755
--- a/scripts/build-efi.py
+++ b/scripts/build-efi.py
@@ -48,6 +48,8 @@ def parse_args():
         epilog='Script for running U-Boot as an EFI app/payload')
     parser.add_argument('-a', '--app', action='store_true',
                         help='Package up the app')
+    parser.add_argument('-B', '--no-build', action='store_true',
+                        help="Don't build (an existing build must be present")
     parser.add_argument('-k', '--kernel', action='store_true',
                         help='Add a kernel')
     parser.add_argument('-o', '--old', action='store_true',
@@ -229,6 +231,15 @@ class BuildEfi:
                 time.sleep(0.5)
                 command.output(*cmd)
 
+    def do_build(self, build):
+        """Build U-Boot for the selected board"""
+        res = command.run_one('buildman', '-w', '-o',
+                              f'{self.build_dir}/{build}', '--board', build,
+                              '-I', raise_on_error=False)
+        if res.return_code and res.return_code != 101:  # Allow warnings
+            raise ValueError(
+                f'buildman exited with {res.return_code}: {res.combined}')
+
     def start(self):
         """This does all the work"""
         args = self.args
@@ -237,6 +248,9 @@ class BuildEfi:
         self.tmp = f'{self.build_dir}/efi{bitness}{build_type}'
         build = f'efi-x86_{build_type}{bitness}'
 
+        if not args.no_build:
+            self.do_build(build)
+
         if args.old and bitness == 32:
             build = f'efi-x86_{build_type}'
 
-- 
2.43.0

