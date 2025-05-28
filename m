Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5097EC5AE59
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D63083965;
	Wed, 28 May 2025 10:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OqrSRhxW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD82A82FE7; Wed, 28 May 2025 10:25:50 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8B38395B
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3dc6b2a8647so11803315ab.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420747; x=1749025547; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcyrJwvC5uvbjdzrCC+C89XB+BJxyuVGFi4I2nRhcq8=;
 b=OqrSRhxWdhhTy4QQnebuZMCDZJDXMT5SnnyCr997onlCt2URNkm226S99KwtMiUxe7
 gqc5DGl+Z9QWNk/DSWSGMPKwQv4HZw9YCdwmCDJXSFtOz1ebvRjRDOoJu2UgElBzq9JF
 xIOxhsacxZBPhk8xfUd4fN2fxNfYizfNNUwFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420747; x=1749025547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcyrJwvC5uvbjdzrCC+C89XB+BJxyuVGFi4I2nRhcq8=;
 b=KcCPiV4n4MM2w8RZPOlmSWXKq2wCIg0ukiUrgOdbVD3UzQldlOB68RnDhT4whjz8y2
 oq48aGiw1zsstfTa/lY8Edb0+OtqOOEPHhVR5uPiCixeGUaOjOqGDBEe3poxICS6TsZI
 VnGcW4p6cb3vkNkJf8gn0xiaEn2P/jU/W42h/KS0MDLF1EMzy1GBRM4lbimtyO4Sspr3
 NPeXc7TZYQsK5DzsfwNYKfVQaBghtIxwBvS4MaeCfc+t+GKZFSQ3QTaqknmgqXDWt++f
 1nwA4GPPDpc37HP2HMORx8Ljn1qtSono7MoL68bUDYhb8h4bdERco6Q7NCwlEkVyQEz9
 QN+A==
X-Gm-Message-State: AOJu0YydO3xF80VQnv/lOgN+B3mV0/Ku5KLKHvCLsT3YClgjJPPhux98
 aZdtAzpG//UECM+Rn3qnhfrtidsFN2MET9jam10GGpPSpp2AUQ6yJd+gVjQm97GNOnwdIsR3NXr
 pRwIgoSnK
X-Gm-Gg: ASbGncs02VV+xN8Y2fjn1jurqNjJmse77MbBF3MYxYqA33QJjJcwY7VAk8fNMmtulF1
 T9/ZVGtCtgn1zltK3rOCM5/KonFDy/+mf5DYFA2NDRtr8/YfmZUQnxq9rJBWacLLP15BZ19k3Aa
 LS+9SBHTsO9bekKpzYEh5u7VAM36mUZK8mERab0mgCAScXSv36A/IT7dvPv57HsCQ4BsbLvQ8mR
 kvgS2eQ7oiacfsZ4hkM75wEo2oLvNgC+Kyq8uZBFnS7Qc26nbIBkfs3Nmbqv8xM/W2QzXDulFYa
 mGzeTrWcvxAJzzZWlxeX57P7tRFgYrFJ+n9z5VipEFi9K4MYxjA0tXiKZ4eTttPn4nOImghcwTt
 SAQYuB4C/DtR/
X-Google-Smtp-Source: AGHT+IH9MT/zaGFFVtEZYY9Hp9E9fy87ykPkOXcm+he2f1KFZCYDBCJmECFwG8zDmvH8e24DQ651Jg==
X-Received: by 2002:a05:6e02:3301:b0:3dc:7ba2:7a39 with SMTP id
 e9e14a558f8ab-3dc9b773bb0mr168512505ab.20.1748420746759; 
 Wed, 28 May 2025 01:25:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:25:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/27] scripts: Update build-efi to support kvm
Date: Wed, 28 May 2025 02:24:29 -0600
Message-ID: <20250528082520.152391-4-sjg@chromium.org>
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

This is a useful feature when booting the EFI app, so add this option to
the build-efi script too, matching the same option in build-qemu

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-efi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/build-efi b/scripts/build-efi
index 443a5ca4908..4f0457e973c 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -40,6 +40,9 @@ def parse_args():
                         help='Run on ARM architecture')
     parser.add_argument('-B', '--no-build', action='store_true',
                         help="Don't build (an existing build must be present")
+    parser.add_argument(
+        '-k', '--kvm', action='store_true',
+        help='Use KVM (Kernel-based Virtual Machine) for acceleration')
     parser.add_argument('-K', '--kernel', action='store_true',
                         help='Add a kernel')
     parser.add_argument('-O', '--old', action='store_true',
@@ -112,6 +115,9 @@ class BuildEfi:
                 extra += ['-device', 'virtio-gpu-pci']
             extra += ['-serial', 'mon:stdio']
             serial_msg = ''
+        if self.args.kvm:
+            extra.extend(['-enable-kvm', '-cpu', 'host'])
+
         print(f'Running {qemu}{serial_msg}')
 
         # Use 512MB since U-Boot EFI likes to have 256MB to play with
-- 
2.43.0

