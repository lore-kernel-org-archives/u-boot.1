Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E848C5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7531A8396F;
	Wed, 28 May 2025 10:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bkfnHHGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2975382FE7; Wed, 28 May 2025 10:25:56 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07D5B8395B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3dc9e7d10bdso10471715ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420752; x=1749025552; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3HEDv23zzkfTw+znsCPEw5RL2S2KdL7HnXzykeAQ9w=;
 b=bkfnHHGjRLltZ9VvqoW72Tv7LjwbQdhHIkzPuKBwRZeRnQw2w13FDaB59fy/XINHg6
 84D9fM8iKivGbQycWEDSx5H+AKASFF6Mk2U4i+w1E86RNWDPdsYgQclnhi9HidDxIzW/
 dwCDqylq6h9L00w05Xdnql6vVx+9rgQLaXDgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420752; x=1749025552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3HEDv23zzkfTw+znsCPEw5RL2S2KdL7HnXzykeAQ9w=;
 b=hMt2iPcc4vltPsgrgkI3ltVOXZUktnfKqVslxt4CYawta15qBZybsR78JBT5mdXjBI
 XJyKkn3MNOLt6vaXOAyeH6UbyyDjGQ5nnrpoIDkuwcm8ZgiMNN5myLlDiBOjQ5PulJva
 /rv4dljD793W5GaWQ0lwC3NLozJsiWps77fhyzglQu45P5xXvW9LDW1GGv67EjbVzy8c
 s08SXCE4GHbtGoloffkjWeSEpx52Tay9KN5Lgb+T/MBAsbwuoIt8J3hEkhQRbrJXKiZK
 fxEMhqNurLMqDxvC7s2MjEf3YfUgs3zJoFNhC9ToQTqZ60A15OSA3Y6SIjPYJGoIp496
 ymZw==
X-Gm-Message-State: AOJu0YykrV1uCioMUtA0dyZO6yHH4KFO/rZdB5T40f6dOHEPySpeP/st
 Xl3t8g62ISYd44gASDDAPspr4CDQPQry5twYH+S+OwOwSt9wfZoJRFbtdwbUeXmVzwbcfnSMg4N
 LGlHI0XVsebU=
X-Gm-Gg: ASbGncs1oY31G40c4kg+JQPM9oVbyzQmyXFlUIvtMwP0iBvrIPQKvj3UZ/wWs1A1bWo
 OJ2yxxoNdbkq38XJbjDgSaaLEaMe1owh8cltMEkJywmOvhAduPvxy+ajVVRg/WB4EdtCNw5hnTn
 sNTdzC9RDfu/pFrCzK/SZeapVZeP6JTxBlffuHemu8PIlfKWWgfF0xaylw+TO0ABcRwUOKLbBAZ
 au3Sihr9DUM1K2uCu0SD0Npm9ckNvFhPlY7osH9h9d8llllLiws9UchT6zzSkEnapDcwi0g+iyR
 9pM22167xKr8xiO8H27eKjhMStwaf/5k1qn4JFePN35SzQEWDdvYCwVFuOTb6KTYmxsO8VfGj6v
 8HMKNwcDMPvHR
X-Google-Smtp-Source: AGHT+IEAhiPLjloVjODXXFFNV9yHIAzawF8s4N17NUwO3xrguA474J5GSgXBwPfN2i6Z5V79wLjKXw==
X-Received: by 2002:a05:6e02:1a28:b0:3dc:857c:c61a with SMTP id
 e9e14a558f8ab-3dc9b6e58demr133548845ab.17.1748420751689; 
 Wed, 28 May 2025 01:25:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/27] scripts: Update build-efi to allow showing the QEMU
 cmdline
Date: Wed, 28 May 2025 02:24:31 -0600
Message-ID: <20250528082520.152391-6-sjg@chromium.org>
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

Add a -v option for verbose output. For now this just shows the QEMU
cmdline before starting it. This allows the user to start it separately,
perhaps tweaking the args.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/build-efi b/scripts/build-efi
index fb6575a89a6..4eb3a76d1a2 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -25,6 +25,7 @@ from build_helper import Helper
 # pylint: disable=C0413
 from u_boot_pylib import command
 from u_boot_pylib import tools
+from u_boot_pylib import tout
 
 
 def parse_args():
@@ -61,6 +62,8 @@ def parse_args():
         help='Select OS release version (e.g, 24.04) Default: 24.04.1')
     parser.add_argument('-s', '--serial', action='store_true',
                         help='Run QEMU with serial only (no display)')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Show executed commands')
     parser.add_argument('-w', '--word', action='store_true',
                         help='Use word version (32-bit) rather than 64-bit')
 
@@ -152,6 +155,7 @@ class BuildEfi:
         cmd += '-m', mem
         cmd += '-nic', 'none'
         cmd += extra
+        tout.info(' '.join(cmd))
         command.run(*cmd)
 
     def setup_files(self, build, build_type, dst):
@@ -202,5 +206,8 @@ class BuildEfi:
 
 
 if __name__ == "__main__":
-    efi = BuildEfi(parse_args())
+    args = parse_args()
+    tout.init(tout.INFO if args.verbose else tout.WARNING)
+
+    efi = BuildEfi(args)
     efi.start()
-- 
2.43.0

