Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C32C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 824C582AE9;
	Sat, 10 May 2025 13:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lcvA/hO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E23D82B34; Sat, 10 May 2025 13:06:28 +0200 (CEST)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A776E82952
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x543.google.com with SMTP id
 4fb4d7f45d1cf-5faaddb09feso5555436a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875185; x=1747479985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BGsiJuX92LdYxZtzQhcnUa+wXwpr6pI7PyYIlP4RcZk=;
 b=lcvA/hO+IMJqFvueUVHIat6yhKHWBsHuRz8DBnVTpFmHVzlV1m/o2buKc6abZ9awBL
 3yWHOtfaBMZThxOZmL8ku7UMSwa6n7Bdai0R1KTRY/KYC9s4O6iDI1zKnTMJJMCSA9mI
 gbxcHjPnNn8VEyRDTyS+YRpXzCpy8BFJsnaN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875185; x=1747479985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BGsiJuX92LdYxZtzQhcnUa+wXwpr6pI7PyYIlP4RcZk=;
 b=YCvHn+dhG5IkCaoHxjojlH7AZJkStvZk+oa3nKoNS+cAs8+KqlmoMPluzhkWyx9kaF
 LiXbeBFnNpA9D8oezGQfyFdTlmHsZFmI/NGsXHIZxJYSCMNpseYiQJkZcHpz0kQOYcSa
 WXVKeSUk1y8aYJ8etooRo1BhFTggMIzQWHgaj6KWYaaMN4KPzu7u3nDrivIbPaPS5UGT
 falot9enWrQaVF6gXrrhnaWzZzuFxhK00EKI10GQDx5JhwusRLAlrLCFGC1ivrie8CpK
 eQRfBcAVxfwls+WjxBnEpbdd8O7AYAaJ1zGi1HZLLEyFs/UU9fzpee5a2t3/FRFvsPBs
 dGqQ==
X-Gm-Message-State: AOJu0YxyTg/t8UvXY/nwyAgMPGGppF20oDp+CxTFA0/1wrv2xmJz+UNO
 Kpx+OFhDQ2OtFC/uFZmxCYi/eK3SXTFh8ZKTG2AIh0vLvNkOS0Yfr5yarXCk0SpyrE6GWWKJ6E7
 biID8Tk1a6z62
X-Gm-Gg: ASbGncsbSf7qIREAurj+AzjMFaKzHqJw0qUZUSAylaqf5m/TlmoiFva3mXXuq0/Owt5
 QNLYYEADi0GAZpiHVjnTBcvumtXyr2xeoIbvhZa/mZCP2/0L9wasg0j6Ob+Qu0KjXYtI8sLmAdk
 i6IzVveZHjbOC/EQTlTFOfqb3QbQOnagHLhGNa7ey6ze62vc5Y4K0BV4i6KnRrpNXIBSfoe10d9
 sf4mZL9mKmUXAfqVj+u/0U+lhqZnUEGaKZ5RwOF2ZB1+eubY/xWqB+ST/BEj6k9vLNlaKCt2qAu
 B5yVfB/2F/Cjpw4ARIArp0ht5qGGAI4qbVz5VAe5+0qQr4Y=
X-Google-Smtp-Source: AGHT+IH5EEBBniXIAzwqXA1P6G01IjUfWWIjOxaJvKbWjNGgdhNB6I1TiZDdmq8NAGVG1PamBSNJ7A==
X-Received: by 2002:a17:907:3905:b0:ad2:409f:fe7c with SMTP id
 a640c23a62f3a-ad2409fffd4mr60762266b.42.1746875185099; 
 Sat, 10 May 2025 04:06:25 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/25] patman: Update send function to return whether it sent
Date: Sat, 10 May 2025 13:05:14 +0200
Message-ID: <20250510110535.1453745-22-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Indicate whether 'git send-email' was actually called, so that we don't
bother waiting for patchwork to receive our series if it wasn't.

The 'git send-email' seems to always return a code of 0 even if nothing
was sent, so we cannot use clues there. Ideally we would watch the
output to determine which patches were sent and which not, but that is
left for another day.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/send.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/patman/send.py b/tools/patman/send.py
index 009ea6bab5f..08a916aff1a 100644
--- a/tools/patman/send.py
+++ b/tools/patman/send.py
@@ -87,6 +87,9 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
             reply to cover-letter or first patch in series)
         smtp_server (str): SMTP server to use to send patches (None for default)
         cwd (str): Path to use for patch files (None to use current dir)
+
+    Return:
+        Git command that was/would be run
     """
     cc_file = series.MakeCcFile(process_tags, cover_fname, not ignore_bad_tags,
                                 add_maintainers, limit, get_maintainer_script,
@@ -109,6 +112,7 @@ def email_patches(col, series, cover_fname, patch_files, process_tags, its_a_go,
             print(col.build(col.RED, "Email would not be sent"))
 
     os.remove(cc_file)
+    return cmd
 
 
 def prepare_patches(col, branch, count, start, end, ignore_binary, signoff,
@@ -169,6 +173,9 @@ def send(args, git_dir=None, cwd=None):
     Args:
         args (argparse.Namespace): Arguments to patman
         cwd (str): Path to use for git operations
+
+    Return:
+        bool: True if the patches were likely sent, else False
     """
     col = terminal.Color()
     series, cover_fname, patch_files = prepare_patches(
@@ -181,8 +188,10 @@ def send(args, git_dir=None, cwd=None):
     ok = ok and gitutil.check_suppress_cc_config()
 
     its_a_go = ok or args.ignore_errors
-    email_patches(
+    cmd = email_patches(
         col, series, cover_fname, patch_files, args.process_tags,
         its_a_go, args.ignore_bad_tags, args.add_maintainers,
         args.get_maintainer_script, args.limit, args.dry_run,
         args.in_reply_to, args.thread, args.smtp_server, cwd=cwd)
+
+    return cmd and its_a_go and not args.dry_run
-- 
2.43.0

