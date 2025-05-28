Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935EAC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066778398D;
	Wed, 28 May 2025 10:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAo2jkSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF478839AC; Wed, 28 May 2025 10:26:12 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B26483995
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7300069c447so2007791a34.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420769; x=1749025569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8eyPWMaNg5wxtHX5+ykFW6d2HQ9mD2NLbXzC2BfBLY=;
 b=JAo2jkSgO0h9lfBGDn/BkqoeuMAgoDI1GTwftAiUPaZjon6O97ewUEQ/NZ1zRLs8CJ
 ecCMRSClYeo9DO0/C+2Nf4oG/uHgxA2dZTWFv4fQJ0qIrsos8eGJ1Rlg5LOA6VNen6Ie
 EdxONNMhjfxUNKzR3Z7G9Rvvs2PnAMTKE3wuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420769; x=1749025569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8eyPWMaNg5wxtHX5+ykFW6d2HQ9mD2NLbXzC2BfBLY=;
 b=YAS5csSNDV1UKpbOXeWCQW+VUUVaBjaNY/grLCdhGn/mYIU4SzzxJkch3NrK7Sp3jZ
 A30tW211PZge+53FarIF68LzpDSYXTjWgAdidck38aibROC/6YjhQvFCwqkA6xqNt9ny
 YOfeKUpNqodxWh6TNvA7Vc7rVdeq7dWhHvA+sPnP7V3cJvKl3rbYN9sIOahoKHe1nvvD
 1yTucE9bY7fJzT5GlNo5LM0HG7+2+HgW4NF2uSSf5HrAn/mszq4yy1a6b8uxjqBr7KsK
 ee0l60RtcMAmJomHvlyGTJ3Gw5ofTbWPMm74pDWc7DrzIGQWQDNVrS9kVTJh6hc93k15
 fdoQ==
X-Gm-Message-State: AOJu0YziYcAkueOzKvEE1xWFvjLXNfQyJbF1lutx4jHmZjgK77x/HEOz
 1H0xM5cuj7GUlnPlp7pTBxKHzL8wZe4JaIBQ1Y/ERUwAfXKO70j7MPH3VnHwLSRnMpJrphzStWV
 6wl7MsIWX
X-Gm-Gg: ASbGncvtBuQn6nDTpubOAm9UHOndl8ITnwP0hKxkIxWCvvXN97VRpIOv+LTuCT7UB6a
 lmmgF9Q7fPc4ov3l9GgrMddd1q3fFdMJtIymSCgkxXsdQ/BLoFOi2bpRFZYdf4I9E7A+FPF4Ese
 HkuwZGs5hjYL734+YE+ESN/yGl/ByG/RAlHDO6SCp+HLPu8MXlNqdLMKK+DuCTpSBfLeUqFf0Z0
 ffEY/BDVZX5BswHGOMiPe5tjUAWNSBbNwJyGp0HcKhdXyGOxQB5X8qtwMHudKNs0s8QFNoPuR71
 wIKmxERWxe5j/vYZJ8J2zNTxJBnZYO46upmBqwpiffM70OABr3V21Xq6SfefjA+mz1pJVEMRkT3
 1ZwaOlliBGQgoWGwEdZzdlwE=
X-Google-Smtp-Source: AGHT+IENKVKL6Pqvi9JymRNy9DbBy3/n5xbU+6Jsk18319MZm24gGJax6jKBDZzDZZFA1CveuxMoDA==
X-Received: by 2002:a05:6e02:1747:b0:3dc:787f:2bc8 with SMTP id
 e9e14a558f8ab-3dc9b6fc498mr176386125ab.12.1748420757122; 
 Wed, 28 May 2025 01:25:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/27] scripts: Update build-efi to support debugging with QEMU
Date: Wed, 28 May 2025 02:24:33 -0600
Message-ID: <20250528082520.152391-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Add a -g option to tell QEMU to stop and wait for gdb to connect.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/build-efi b/scripts/build-efi
index 5a6eef450d4..33702953c32 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -44,6 +44,8 @@ def parse_args():
                         help="Don't build (an existing build must be present")
     parser.add_argument('-d', '--disk',
                         help='Root disk image file to use with QEMU')
+    parser.add_argument('-g', '--debug', action='store_true',
+                        help="Run QEMU with gdb")
     parser.add_argument(
         '-k', '--kvm', action='store_true',
         help='Use KVM (Kernel-based Virtual Machine) for acceleration')
@@ -162,6 +164,9 @@ class BuildEfi:
         else:
             mem = '512'
 
+        if self.args.debug:
+            extra.extend(['-s', '-S'])
+
         cmd = [qemu]
         cmd += '-m', mem
         cmd += '-nic', 'none'
-- 
2.43.0

