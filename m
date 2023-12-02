Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC23C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 19:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 842A38778A;
	Sat,  2 Dec 2023 20:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="husr9xqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51C98779A; Sat,  2 Dec 2023 20:33:21 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC97787768
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 20:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77d8f9159fbso172417885a.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701545597; x=1702150397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6eVhEAOLlg4RaTJiFhpx+GO8rAJ7n3qA2KFp7Znj9kU=;
 b=husr9xqfVhGMnDi0GlaMielxzkHWMvcNU9yzMWPbygLH82EZy3zHmTijEbUs3Cf3CP
 MbBqKTK57y1UcNudkPF4AdQmQk1NwX5/rNnthiCAgxEjjA2g5yj7H7uQswBN6g3DoPGn
 JQvu0U1T0beqUkd3MpVXlNeq50x6KZB3VZMmFYMEHI6U4MhSr44VCH5/2k+RTNosuz7a
 vN39+TsxkuCQyK3BAi6pv6RIFdfqIK25oA53atyIVaP0Oi2+q7hpdi3SGSXlGL06v7CE
 X2GVRVZ4oX23MiH+x36Sc83Egy8Y9mXwhoVm3ti5R+6JeFjfKvL58+7uhddWHzB5KV9T
 kMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701545597; x=1702150397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6eVhEAOLlg4RaTJiFhpx+GO8rAJ7n3qA2KFp7Znj9kU=;
 b=CORl4YQ0sHjuIyfWyTpldBJt38iwfODjh0vhgrNXeGCZM1GKygQjjYREragylI+CkO
 pC7RC2EuLJtrguz891xXjIitdrjMTU3PFFcRuaAMaI0r8kbh0gAfsN+JM+35S5+K/seU
 8DJAWyT57j4/um3apXO0a35Dr1OPBuZmGB8UiU4nLBvgRyJQShoUu5a5v41wYrHUzkT3
 /Mi220FMq+1rfnIExoAp6KkZ6CwBc4m2y8e8ClYHggAHYa7Odj5Gvk8Gm9EzGBBfkDoR
 iIGms1hyXCigaTGcZ9MLS5teCM+jeNaf7bXUMseZ0GWd81P9TkTphm3oGm+5Z/K56oCs
 NDUw==
X-Gm-Message-State: AOJu0YxlVno8A+TsuSnFAO8ESKkLm0ciNrUs/dkmATpDgeT88GNVenNv
 OumKt1dS4k0jmfjCQ8k8eKpTW8rebOY=
X-Google-Smtp-Source: AGHT+IEkeQRwg53x9hHCxZXdxEcXWcqWNzxPYENnTUcSg1+qapZZQzDG1RRaWNcggQve08gFBTOUCQ==
X-Received: by 2002:a05:620a:1d96:b0:77d:97bc:74b0 with SMTP id
 pj22-20020a05620a1d9600b0077d97bc74b0mr1615740qkn.4.1701545596980; 
 Sat, 02 Dec 2023 11:33:16 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 rf3-20020a05620a8e8300b0077d84ad9744sm2668851qkn.36.2023.12.02.11.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 11:33:16 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Peter Robinson <pbrobinson@gmail.com>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] doc: Replace examples of MD5 and SHA1 with SHA256
Date: Sat,  2 Dec 2023 14:33:14 -0500
Message-Id: <20231202193314.1513224-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Both SHA1 and (especially) MD5 are no longer as safe as they once were for
cryptographic use. Replaces examples which use them with examples using
SHA256 instead. This will provide more-secure defaults for users who use
documentation examples as a base for their own use. This is not too
necessary for non-verified-boot scenarios (since someone could just replace
the checksum), but I wanted to be complete.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 doc/chromium/files/chromebook_jerry.its  |  4 +-
 doc/chromium/files/nyan-big.its          |  4 +-
 doc/usage/cmd/imxtract.rst               |  6 +-
 doc/usage/fit/beaglebone_vboot.rst       | 74 ++++++++++++------------
 doc/usage/fit/howto.rst                  | 40 ++++++-------
 doc/usage/fit/kernel.rst                 |  6 +-
 doc/usage/fit/kernel_fdt.rst             |  4 +-
 doc/usage/fit/kernel_fdts_compressed.rst |  6 +-
 doc/usage/fit/multi-with-fpga.rst        |  6 +-
 doc/usage/fit/multi-with-loadables.rst   |  8 +--
 doc/usage/fit/multi.rst                  | 12 ++--
 doc/usage/fit/sign-configs.rst           |  6 +-
 doc/usage/fit/sign-images.rst            |  4 +-
 doc/usage/fit/signature.rst              | 22 +++----
 doc/usage/fit/update3.rst                |  6 +-
 doc/usage/fit/update_uboot.rst           |  2 +-
 doc/usage/fit/x86-fit-boot.rst           |  8 +--
 17 files changed, 109 insertions(+), 109 deletions(-)

diff --git a/doc/chromium/files/chromebook_jerry.its b/doc/chromium/files/chromebook_jerry.its
index 7505a20535b..02e5e1340f3 100644
--- a/doc/chromium/files/chromebook_jerry.its
+++ b/doc/chromium/files/chromebook_jerry.its
@@ -15,7 +15,7 @@
 			load = <0>;
 			entry = <0>;
 			hash-2 {
-				algo = "sha1";
+				algo = "sha256";
 			};
 		};
 
@@ -26,7 +26,7 @@
 			arch = "arm";
 			compression = "none";
 			hash-1{
-				algo = "sha1";
+				algo = "sha256";
 			};
 		};
 	};
diff --git a/doc/chromium/files/nyan-big.its b/doc/chromium/files/nyan-big.its
index bd412915e95..60bdffbb829 100644
--- a/doc/chromium/files/nyan-big.its
+++ b/doc/chromium/files/nyan-big.its
@@ -15,7 +15,7 @@
 			load = <0>;
 			entry = <0>;
 			hash-2 {
-				algo = "sha1";
+				algo = "sha256";
 			};
 		};
 
@@ -26,7 +26,7 @@
 			arch = "arm";
 			compression = "none";
 			hash-1{
-				algo = "sha1";
+				algo = "sha256";
 			};
 		};
 	};
diff --git a/doc/usage/cmd/imxtract.rst b/doc/usage/cmd/imxtract.rst
index eb64b1cefab..16be60b4aab 100644
--- a/doc/usage/cmd/imxtract.rst
+++ b/doc/usage/cmd/imxtract.rst
@@ -45,14 +45,14 @@ Examples
 
 With verify=no incorrect hashes, signatures, or check sums don't stop the
 extraction. But correct hashes are still indicated in the output
-(here: md5, sha1).
+(here: sha256, sha512).
 
 .. code-block:: console
 
     => setenv verify no
     => imxtract $loadaddr kernel-1 $kernel_addr_r
     ## Copying 'kernel-1' subimage from FIT image at 40200000 ...
-    md5+ sha1+    Loading part 0 ... OK
+    sha256+ sha512+    Loading part 0 ... OK
     =>
 
 With verify=yes incorrect hashes, signatures, or check sums stop the extraction.
@@ -62,7 +62,7 @@ With verify=yes incorrect hashes, signatures, or check sums stop the extraction.
     => setenv verify yes
     => imxtract $loadaddr kernel-1 $kernel_addr_r
     ## Copying 'kernel-1' subimage from FIT image at 40200000 ...
-    md5 error!
+    sha256 error!
     Bad hash value for 'hash-1' hash node in 'kernel-1' image node
     Bad Data Hash
     =>
diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
index a102be187bd..cd6bb141910 100644
--- a/doc/usage/fit/beaglebone_vboot.rst
+++ b/doc/usage/fit/beaglebone_vboot.rst
@@ -145,7 +145,7 @@ Put this into a file in that directory called sign.its::
                 load = <0x80008000>;
                 entry = <0x80008000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
             fdt-1 {
@@ -155,7 +155,7 @@ Put this into a file in that directory called sign.its::
                 arch = "arm";
                 compression = "none";
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
@@ -165,7 +165,7 @@ Put this into a file in that directory called sign.its::
                 kernel = "kernel";
                 fdt = "fdt-1";
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     key-name-hint = "dev";
                     sign-images = "fdt", "kernel";
                 };
@@ -227,8 +227,8 @@ You should see something like this::
       OS:           Linux
       Load Address: 0x80008000
       Entry Point:  0x80008000
-      Hash algo:    sha1
-      Hash value:   c94364646427e10f423837e559898ef02c97b988
+      Hash algo:    sha256
+      Hash value:   51b2adf9c1016ed46f424d85dcc6c34c46a20b9bee7227e06a6b6320ca5d35c1
      Image 1 (fdt-1)
       Description:  beaglebone-black
       Created:      Sun Jun  1 12:50:30 2014
@@ -236,8 +236,8 @@ You should see something like this::
       Compression:  uncompressed
       Data Size:    31547 Bytes = 30.81 kB = 0.03 MB
       Architecture: ARM
-      Hash algo:    sha1
-      Hash value:   cb09202f889d824f23b8e4404b781be5ad38a68d
+      Hash algo:    sha256
+      Hash value:   807d5842a04132261ba092373bd40c78991bc7ce173d1175cd976ec37858e7cd
      Default Configuration: 'conf-1'
      Configuration 0 (conf-1)
       Description:  unavailable
@@ -255,11 +255,11 @@ You can also run fit_check_sign to check it::
 
 which results in::
 
-    Verifying Hash Integrity ... sha1,rsa2048:dev+
+    Verifying Hash Integrity ... sha256,rsa2048:dev+
     ## Loading kernel from FIT Image at 7fc6ee469000 ...
        Using 'conf-1' configuration
        Verifying Hash Integrity ...
-    sha1,rsa2048:dev+
+    sha256,rsa2048:dev+
     OK
 
        Trying 'kernel' kernel subimage
@@ -272,10 +272,10 @@ which results in::
          OS:           Linux
          Load Address: 0x80008000
          Entry Point:  0x80008000
-         Hash algo:    sha1
-         Hash value:   c94364646427e10f423837e559898ef02c97b988
+         Hash algo:    sha256
+         Hash value:   51b2adf9c1016ed46f424d85dcc6c34c46a20b9bee7227e06a6b6320ca5d35c1
        Verifying Hash Integrity ...
-    sha1+
+    sha256+
     OK
 
     Unimplemented compression type 4
@@ -288,10 +288,10 @@ which results in::
          Compression:  uncompressed
          Data Size:    31547 Bytes = 30.81 kB = 0.03 MB
          Architecture: ARM
-         Hash algo:    sha1
-         Hash value:   cb09202f889d824f23b8e4404b781be5ad38a68d
+         Hash algo:    sha256
+         Hash value:   807d5842a04132261ba092373bd40c78991bc7ce173d1175cd976ec37858e7cd
        Verifying Hash Integrity ...
-    sha1+
+    sha256+
     OK
 
        Loading Flat Device Tree ... OK
@@ -303,14 +303,14 @@ which results in::
     Signature check OK
 
 
-At the top, you see "sha1,rsa2048:dev+". This means that it checked an RSA key
-of size 2048 bits using SHA1 as the hash algorithm. The key name checked was
+At the top, you see "sha256,rsa2048:dev+". This means that it checked an RSA key
+of size 2048 bits using SHA256 as the hash algorithm. The key name checked was
 'dev' and the '+' means that it verified. If it showed '-' that would be bad.
 
 Once the configuration is verified it is then possible to rely on the hashes
 in each image referenced by that configuration. So fit_check_sign goes on to
 load each of the images. We have a kernel and an FDT but no ramkdisk. In each
-case fit_check_sign checks the hash and prints sha1+ meaning that the SHA1
+case fit_check_sign checks the hash and prints sha256+ meaning that the SHA256
 hash verified. This means that none of the images has been tampered with.
 
 There is a test in test/vboot which uses U-Boot's sandbox build to verify that
@@ -328,11 +328,11 @@ This tells us that the kernel starts at byte offset 168 (decimal) in image.fit
 and extends for about 7MB. Try changing a byte at 0x2000 (say) and run
 fit_check_sign again. You should see something like::
 
-    Verifying Hash Integrity ... sha1,rsa2048:dev+
+    Verifying Hash Integrity ... sha256,rsa2048:dev+
     ## Loading kernel from FIT Image at 7f5a39571000 ...
        Using 'conf-1' configuration
        Verifying Hash Integrity ...
-    sha1,rsa2048:dev+
+    sha256,rsa2048:dev+
     OK
 
        Trying 'kernel' kernel subimage
@@ -345,10 +345,10 @@ fit_check_sign again. You should see something like::
          OS:           Linux
          Load Address: 0x80008000
          Entry Point:  0x80008000
-         Hash algo:    sha1
-         Hash value:   c94364646427e10f423837e559898ef02c97b988
+         Hash algo:    sha256
+         Hash value:   51b2adf9c1016ed46f424d85dcc6c34c46a20b9bee7227e06a6b6320ca5d35c1
        Verifying Hash Integrity ...
-    sha1 error
+    sha256 error
     Bad hash value for 'hash-1' hash node in 'kernel' image node
     Bad Data Hash
 
@@ -361,10 +361,10 @@ fit_check_sign again. You should see something like::
          Compression:  uncompressed
          Data Size:    31547 Bytes = 30.81 kB = 0.03 MB
          Architecture: ARM
-         Hash algo:    sha1
-         Hash value:   cb09202f889d824f23b8e4404b781be5ad38a68d
+         Hash algo:    sha256
+         Hash value:   807d5842a04132261ba092373bd40c78991bc7ce173d1175cd976ec37858e7cd
        Verifying Hash Integrity ...
-    sha1+
+    sha256+
     OK
 
        Loading Flat Device Tree ... OK
@@ -419,13 +419,13 @@ need to change the hash to match. Let's simulate that by changing a byte of
 the hash::
 
     fdtget -tx image.fit /images/kernel/hash-1 value
-    c9436464 6427e10f 423837e5 59898ef0 2c97b988
-    fdtput -tx image.fit /images/kernel/hash-1 value c9436464 6427e10f 423837e5 59898ef0 2c97b981
+    51b2adf9 c1016ed4 6f424d85 dcc6c34c 46a20b9b ee7227e0 6a6b6320 ca5d35c1
+    fdtput -tx image.fit /images/kernel/hash-1 value 51b2adf9 c1016ed4 6f424d85 dcc6c34c 46a20b9b ee7227e0 6a6b6320 ca5d35c8
 
 Now check it again::
 
     $UOUT/tools/fit_check_sign -f image.fit -k am335x-boneblack-pubkey.dtb
-    Verifying Hash Integrity ... sha1,rsa2048:devrsa_verify_with_keynode: RSA failed to verify: -13
+    Verifying Hash Integrity ... sha256,rsa2048:devrsa_verify_with_keynode: RSA failed to verify: -13
     rsa_verify_with_keynode: RSA failed to verify: -13
     -
     Failed to verify required signature 'key-dev'
@@ -446,7 +446,7 @@ running the mkimage link again. Then::
     fdtput -p image.fit /configurations/conf-1/signature-1 value fred
     $UOUT/tools/fit_check_sign -f image.fit -k am335x-boneblack-pubkey.dtb
     Verifying Hash Integrity ... -
-    sha1,rsa2048:devrsa_verify_with_keynode: RSA failed to verify: -13
+    sha256,rsa2048:devrsa_verify_with_keynode: RSA failed to verify: -13
     rsa_verify_with_keynode: RSA failed to verify: -13
     -
     Failed to verify required signature 'key-dev'
@@ -528,7 +528,7 @@ You should then see something like this::
     U-Boot# bootm 82000000
     ## Loading kernel from FIT Image at 82000000 ...
        Using 'conf-1' configuration
-       Verifying Hash Integrity ... sha1,rsa2048:dev+ OK
+       Verifying Hash Integrity ... sha256,rsa2048:dev+ OK
        Trying 'kernel' kernel subimage
          Description:  unavailable
          Created:      2014-06-01  19:32:54 UTC
@@ -540,9 +540,9 @@ You should then see something like this::
          OS:           Linux
          Load Address: 0x80008000
          Entry Point:  0x80008000
-         Hash algo:    sha1
-         Hash value:   c94364646427e10f423837e559898ef02c97b988
-       Verifying Hash Integrity ... sha1+ OK
+         Hash algo:    sha256
+         Hash value:   51b2adf9c1016ed46f424d85dcc6c34c46a20b9bee7227e06a6b6320ca5d35c1
+       Verifying Hash Integrity ... sha256+ OK
     ## Loading fdt from FIT Image at 82000000 ...
        Using 'conf-1' configuration
        Trying 'fdt-1' fdt subimage
@@ -553,9 +553,9 @@ You should then see something like this::
          Data Start:   0x8276e2ec
          Data Size:    31547 Bytes = 30.8 KiB
          Architecture: ARM
-         Hash algo:    sha1
-         Hash value:   cb09202f889d824f23b8e4404b781be5ad38a68d
-       Verifying Hash Integrity ... sha1+ OK
+         Hash algo:    sha256
+         Hash value:   807d5842a04132261ba092373bd40c78991bc7ce173d1175cd976ec37858e7cd
+       Verifying Hash Integrity ... sha256+ OK
        Booting using the fdt blob at 0x8276e2ec
        Uncompressing Kernel Image ... OK
        Loading Device Tree to 8fff5000, end 8ffffb3a ... OK
diff --git a/doc/usage/fit/howto.rst b/doc/usage/fit/howto.rst
index def12a70f7b..b5097d4460b 100644
--- a/doc/usage/fit/howto.rst
+++ b/doc/usage/fit/howto.rst
@@ -8,7 +8,7 @@ Overview
 
 The new uImage format allows more flexibility in handling images of various
 types (kernel, ramdisk, etc.), it also enhances integrity protection of images
-with sha1 and md5 checksums.
+with cryptographic checksums.
 
 Two auxiliary tools are needed on the development host system in order to
 create an uImage in the new format: mkimage and dtc, although only one
@@ -99,7 +99,7 @@ started by ATF where SPL is loading U-Boot (as loadables) and ATF (as firmware).
                 load = <0x8 0x8000000>;
                 entry = <0x8 0x8000000>;
                 hash {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
             atf {
@@ -112,7 +112,7 @@ started by ATF where SPL is loading U-Boot (as loadables) and ATF (as firmware).
                 load = <0xfffea000>;
                 entry = <0xfffea000>;
                 hash {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
             fdt_1 {
@@ -123,7 +123,7 @@ started by ATF where SPL is loading U-Boot (as loadables) and ATF (as firmware).
                 compression = "none";
                 load = <0x100000>;
                 hash {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
         };
@@ -190,8 +190,8 @@ its contents:
       Entry Point:    0x00000000
       Hash algo:    crc32
       Hash value:    2ae2bb40
-      Hash algo:    sha1
-      Hash value:    3c200f34e2c226ddc789240cca0c59fc54a67cf4
+      Hash algo:    sha256
+      Hash value:    c22f6bb5a3f96942507a37e7d6a9333ebdc7da57971bc4c082113fe082fdc40f
      Default Configuration: 'config-1'
      Configuration 0 (config-1)
       Description:    Boot Linux kernel
@@ -236,8 +236,8 @@ specific to the new image format).
          Entry Point:  0x00000000
          Hash algo:    crc32
          Hash value:   2ae2bb40
-         Hash algo:    sha1
-         Hash value:   3c200f34e2c226ddc789240cca0c59fc54a67cf4
+         Hash algo:    sha256
+         Hash value:   c22f6bb5a3f96942507a37e7d6a9333ebdc7da57971bc4c082113fe082fdc40f
         Default Configuration: 'config-1'
         Configuration 0 (config-1)
          Description:  Boot Linux kernel
@@ -258,8 +258,8 @@ specific to the new image format).
          Entry Point:  0x00000000
          Hash algo:    crc32
          Hash value:   2ae2bb40
-         Hash algo:    sha1
-         Hash value:   3c200f34e2c226ddc789240cca0c59fc54a67cf4
+         Hash algo:    sha256
+         Hash value:   c22f6bb5a3f96942507a37e7d6a9333ebdc7da57971bc4c082113fe082fdc40f
        Verifying Hash Integrity ... crc32+ sha1+ OK
        Uncompressing Kernel Image ... OK
     Memory BAT mapping: BAT2=256Mb, BAT3=0Mb, residual: 0Mb
@@ -302,8 +302,8 @@ modified to take the files from some other location if needed):
       Entry Point:    0x00000000
       Hash algo:    crc32
       Hash value:    2c0cc807
-      Hash algo:    sha1
-      Hash value:    264b59935470e42c418744f83935d44cdf59a3bb
+      Hash algo:    sha256
+      Hash value:    a3e9e18b793873827d27c97edfbca67c404a1972d9f36cf48e73ff85d69a422c
      Image 1 (fdt-1)
       Description:    Flattened Device Tree blob
       Type:        Flat Device Tree
@@ -312,8 +312,8 @@ modified to take the files from some other location if needed):
       Architecture: PowerPC
       Hash algo:    crc32
       Hash value:    0d655d71
-      Hash algo:    sha1
-      Hash value:    25ab4e15cd4b8a5144610394560d9c318ce52def
+      Hash algo:    sha256
+      Hash value:    e9b9a40c5e2e12213ac819e7ccad7271ef43eb5edf9b421f0fa0b4b51bfdb214
      Default Configuration: 'conf-1'
      Configuration 0 (conf-1)
       Description:    Boot Linux kernel with FDT blob
@@ -353,8 +353,8 @@ inspected and booted:
          Entry Point:  0x00000000
          Hash algo:    crc32
          Hash value:   2c0cc807
-         Hash algo:    sha1
-         Hash value:   264b59935470e42c418744f83935d44cdf59a3bb
+         Hash algo:    sha256
+         Hash value:   a3e9e18b793873827d27c97edfbca67c404a1972d9f36cf48e73ff85d69a422c
         Image 1 (fdt-1)
          Description:  Flattened Device Tree blob
          Type:       Flat Device Tree
@@ -364,8 +364,8 @@ inspected and booted:
          Architecture: PowerPC
          Hash algo:    crc32
          Hash value:   0d655d71
-         Hash algo:    sha1
-         Hash value:   25ab4e15cd4b8a5144610394560d9c318ce52def
+         Hash algo:    sha256
+         Hash value:   e9b9a40c5e2e12213ac819e7ccad7271ef43eb5edf9b421f0fa0b4b51bfdb214
         Default Configuration: 'conf-1'
         Configuration 0 (conf-1)
          Description:  Boot Linux kernel with FDT blob
@@ -387,7 +387,7 @@ inspected and booted:
          Hash algo:    crc32
          Hash value:   2c0cc807
          Hash algo:    sha1
-         Hash value:   264b59935470e42c418744f83935d44cdf59a3bb
+         Hash value:   a3e9e18b793873827d27c97edfbca67c404a1972d9f36cf48e73ff85d69a422c
        Verifying Hash Integrity ... crc32+ sha1+ OK
        Uncompressing Kernel Image ... OK
     ## Flattened Device Tree from FIT Image at 00900000
@@ -402,7 +402,7 @@ inspected and booted:
          Hash algo:    crc32
          Hash value:   0d655d71
          Hash algo:    sha1
-         Hash value:   25ab4e15cd4b8a5144610394560d9c318ce52def
+         Hash value:   e9b9a40c5e2e12213ac819e7ccad7271ef43eb5edf9b421f0fa0b4b51bfdb214
        Verifying Hash Integrity ... crc32+ sha1+ OK
        Booting using the fdt blob at 0xa0abdc
        Loading Device Tree to 007fc000, end 007fffff ... OK
diff --git a/doc/usage/fit/kernel.rst b/doc/usage/fit/kernel.rst
index 012a81efead..e56017985b2 100644
--- a/doc/usage/fit/kernel.rst
+++ b/doc/usage/fit/kernel.rst
@@ -25,7 +25,7 @@ Single kernel
                     algo = "crc32";
                 };
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
@@ -59,7 +59,7 @@ For x86 a setup node is also required: see x86-fit-boot::
                 load = <0x01000000>;
                 entry = <0x00000000>;
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
 
@@ -73,7 +73,7 @@ For x86 a setup node is also required: see x86-fit-boot::
                 load = <0x00090000>;
                 entry = <0x00090000>;
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/kernel_fdt.rst b/doc/usage/fit/kernel_fdt.rst
index 8eee13af780..9cc26fb7831 100644
--- a/doc/usage/fit/kernel_fdt.rst
+++ b/doc/usage/fit/kernel_fdt.rst
@@ -25,7 +25,7 @@ Single kernel and FDT blob
 			algo = "crc32";
 		};
 		hash-2 {
-			algo = "sha1";
+			algo = "sha256";
 		};
 		};
 		fdt-1 {
@@ -38,7 +38,7 @@ Single kernel and FDT blob
 			algo = "crc32";
 		};
 		hash-2 {
-			algo = "sha1";
+			algo = "sha256";
 		};
 		};
 	};
diff --git a/doc/usage/fit/kernel_fdts_compressed.rst b/doc/usage/fit/kernel_fdts_compressed.rst
index 0b169c7c27c..b57871da58b 100644
--- a/doc/usage/fit/kernel_fdts_compressed.rst
+++ b/doc/usage/fit/kernel_fdts_compressed.rst
@@ -28,7 +28,7 @@ string to match directly.
                     algo = "crc32";
                 };
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
             fdt@1 {
@@ -41,7 +41,7 @@ string to match directly.
                     algo = "crc32";
                 };
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
             fdt@2 {
@@ -54,7 +54,7 @@ string to match directly.
                     algo = "crc32";
                 };
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/multi-with-fpga.rst b/doc/usage/fit/multi-with-fpga.rst
index 28d7d5d2626..4c7f1bebd5a 100644
--- a/doc/usage/fit/multi-with-fpga.rst
+++ b/doc/usage/fit/multi-with-fpga.rst
@@ -20,7 +20,7 @@ This example makes use of the 'loadables' field::
                 compression = "none";
                 load = <0x10000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -33,7 +33,7 @@ This example makes use of the 'loadables' field::
                 load = <0x30000000>;
                 compatible = "u-boot,fpga-legacy"
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -47,7 +47,7 @@ This example makes use of the 'loadables' field::
                 load = <0x8000>;
                 entry = <0x8000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/multi-with-loadables.rst b/doc/usage/fit/multi-with-loadables.rst
index a0241df96ca..7849cb544f1 100644
--- a/doc/usage/fit/multi-with-loadables.rst
+++ b/doc/usage/fit/multi-with-loadables.rst
@@ -22,7 +22,7 @@ This example makes use of the 'loadables' field::
                 load = <0xa0000000>;
                 entry = <0xa0000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -34,7 +34,7 @@ This example makes use of the 'loadables' field::
                 compression = "none";
                 load = <0xb0000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -46,7 +46,7 @@ This example makes use of the 'loadables' field::
                 compression = "none";
                 load = <0xb0400000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -60,7 +60,7 @@ This example makes use of the 'loadables' field::
                 load = <0xa0000000>;
                 entry = <0xa0000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/multi.rst b/doc/usage/fit/multi.rst
index 2e6ae58c409..e68752b2ad0 100644
--- a/doc/usage/fit/multi.rst
+++ b/doc/usage/fit/multi.rst
@@ -22,10 +22,10 @@ Multiple kernels, ramdisks and FDT blobs
                 load = <00000000>;
                 entry = <00000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
                 hash-2 {
-                    algo = "sha1";
+                    algo = "sha512";
                 };
             };
 
@@ -39,7 +39,7 @@ Multiple kernels, ramdisks and FDT blobs
                 load = <00000000>;
                 entry = <00000000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
 
@@ -53,7 +53,7 @@ Multiple kernels, ramdisks and FDT blobs
                 load = <00000000>;
                 entry = <00000000>;
                 hash-1 {
-                    algo = "md5";
+                    algo = "sha256";
                 };
             };
 
@@ -67,7 +67,7 @@ Multiple kernels, ramdisks and FDT blobs
                 load = <00000000>;
                 entry = <00000000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
 
@@ -104,7 +104,7 @@ Multiple kernels, ramdisks and FDT blobs
                 compression = "none";
                 load = <00700000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
 
diff --git a/doc/usage/fit/sign-configs.rst b/doc/usage/fit/sign-configs.rst
index 6a3df8f2c5b..6d98d44430c 100644
--- a/doc/usage/fit/sign-configs.rst
+++ b/doc/usage/fit/sign-configs.rst
@@ -22,7 +22,7 @@ Signed configurations
                 entry = <0x8>;
                 kernel-version = <1>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
             fdt-1 {
@@ -33,7 +33,7 @@ Signed configurations
                 compression = "none";
                 fdt-version = <1>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
@@ -43,7 +43,7 @@ Signed configurations
                 kernel = "kernel";
                 fdt = "fdt-1";
                 signature {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     key-name-hint = "dev";
                     sign-images = "fdt", "kernel";
                 };
diff --git a/doc/usage/fit/sign-images.rst b/doc/usage/fit/sign-images.rst
index 7d54d702c97..ca7d10fab83 100644
--- a/doc/usage/fit/sign-images.rst
+++ b/doc/usage/fit/sign-images.rst
@@ -22,7 +22,7 @@ Signed Images
                 entry = <0x8>;
                 kernel-version = <1>;
                 signature {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     key-name-hint = "dev";
                 };
             };
@@ -34,7 +34,7 @@ Signed Images
                 compression = "none";
                 fdt-version = <1>;
                 signature {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     key-name-hint = "dev";
                 };
             };
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index 0804bffd1ed..39edba14630 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -93,7 +93,7 @@ Public keys should be stored as sub-nodes in a /signature node. Required
 properties are:
 
 algo
-    Algorithm name (e.g. "sha1,rsa2048" or "sha256,ecdsa256")
+    Algorithm name (e.g. "sha256,rsa2048" or "sha512,ecdsa256")
 
 Optional properties are:
 
@@ -219,28 +219,28 @@ As an example, consider this FIT::
             kernel-1 {
                 data = <data for kernel1>
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...kernel signature 1...>
                 };
             };
             kernel-2 {
                 data = <data for kernel2>
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...kernel signature 2...>
                 };
             };
             fdt-1 {
                 data = <data for fdt1>;
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...fdt signature 1...>
                 };
             };
             fdt-2 {
                 data = <data for fdt2>;
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...fdt signature 2...>
                 };
             };
@@ -291,28 +291,28 @@ So the above example is adjusted to look like this::
             kernel-1 {
                 data = <data for kernel1>
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                     value = <...kernel hash 1...>
                 };
             };
             kernel-2 {
                 data = <data for kernel2>
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                     value = <...kernel hash 2...>
                 };
             };
             fdt-1 {
                 data = <data for fdt1>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                     value = <...fdt hash 1...>
                 };
             };
             fdt-2 {
                 data = <data for fdt2>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                     value = <...fdt hash 2...>
                 };
             };
@@ -323,7 +323,7 @@ So the above example is adjusted to look like this::
                 kernel = "kernel-1";
                 fdt = "fdt-1";
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...conf 1 signature...>;
                 };
             };
@@ -331,7 +331,7 @@ So the above example is adjusted to look like this::
                 kernel = "kernel-2";
                 fdt = "fdt-2";
                 signature-1 {
-                    algo = "sha1,rsa2048";
+                    algo = "sha256,rsa2048";
                     value = <...conf 1 signature...>;
                 };
             };
diff --git a/doc/usage/fit/update3.rst b/doc/usage/fit/update3.rst
index 4ff3950c01e..24235801470 100644
--- a/doc/usage/fit/update3.rst
+++ b/doc/usage/fit/update3.rst
@@ -19,7 +19,7 @@ Automatic software update: multiple files
                 type = "firmware";
                 load = <FF700000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
             update-2 {
@@ -29,7 +29,7 @@ Automatic software update: multiple files
                 type = "firmware";
                 load = <FF8E0000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
 
@@ -40,7 +40,7 @@ Automatic software update: multiple files
                 type = "firmware";
                 load = <FFAC0000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/update_uboot.rst b/doc/usage/fit/update_uboot.rst
index a9288ee6367..811d008d13d 100644
--- a/doc/usage/fit/update_uboot.rst
+++ b/doc/usage/fit/update_uboot.rst
@@ -21,7 +21,7 @@ Make sure the flashing addresses ('load' prop) is correct for your board!
                 type = "firmware";
                 load = <0xFFFC0000>;
                 hash-1 {
-                    algo = "sha1";
+                    algo = "sha256";
                 };
             };
         };
diff --git a/doc/usage/fit/x86-fit-boot.rst b/doc/usage/fit/x86-fit-boot.rst
index 93b73bb9019..9e3e32204d5 100644
--- a/doc/usage/fit/x86-fit-boot.rst
+++ b/doc/usage/fit/x86-fit-boot.rst
@@ -207,16 +207,16 @@ You can take a look at the resulting fit file if you like::
       OS:           Linux
       Load Address: 0x01000000
       Entry Point:  0x00000000
-      Hash algo:    sha1
-      Hash value:   446b5163ebfe0fb6ee20cbb7a8501b263cd92392
+      Hash algo:    sha256
+      Hash value:   4bbf49981ade163ed089f8525236fedfe44508e9b02a21a48294a96a1518107b
      Image 1 (setup)
       Description:  Linux setup.bin
       Created:      Tue Oct  7 10:57:24 2014
       Type:         x86 setup.bin
       Compression:  uncompressed
       Data Size:    12912 Bytes = 12.61 kB = 0.01 MB
-      Hash algo:    sha1
-      Hash value:   a1f2099cf47ff9816236cd534c77af86e713faad
+      Hash algo:    sha256
+      Hash value:   6aa50c2e0392cb119cdf0971dce8339f100608ed3757c8200b0e39e889e432d2
      Default Configuration: 'config-1'
      Configuration 0 (config-1)
       Description:  Boot Linux kernel
-- 
2.37.1

