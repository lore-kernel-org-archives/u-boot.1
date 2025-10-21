Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EDCCCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FDDA835C6;
	Tue, 21 Oct 2025 22:28:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FR9vAIIZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E72F802C1; Tue, 21 Oct 2025 22:28:32 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2434B82B20
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c28559bb45so2955008a34.0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761078508; x=1761683308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3f1kS8CbDFlea/Xfdg4KJVTxbsr89We4WRFpyHfDZbU=;
 b=FR9vAIIZUxk880uxj73opq0pTp1JkDVAo9VfIX6B8bn9YgInI5SUNmW5BUkHrLUzi7
 SqRfpWuPIRFlOqSIPnNhlCVQBbgWU07VEpaWLXhCw49gyvqpdKPe8oKHuk/N5QN7aJa/
 M0X7GJzAVg+SM6fpksNMO22+L/O359tA3GNwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761078508; x=1761683308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3f1kS8CbDFlea/Xfdg4KJVTxbsr89We4WRFpyHfDZbU=;
 b=STVn0jes02dtGkkPWu5RLYAW/Kql0OwXRSoA+rnwD0Wo8T2/3L3t8vcA+nOdbyULNq
 nDBMQ5xDhrciU0I8gV+dkGEl8Gf20BQrnD34NC3ODwi4UoQsqbyWUHi7MDjUH1LZYaRo
 NoMT6OIZTV31VcxL2B3oz3aaUZ6UmPctJKKl1bMEsOgppK5gF7FnH+PuBe4pmBCbtMaB
 7oQ0uRy+hvB72RwVc/4p3xyWmDDTxPP8eU6EEYwk9xaGDz97OYTFiBRy2P+jV/TLUjQP
 CKG3wkUv8A83CkY3zz0NX+1nE8p9XI2czpXDxNOHs0aDIhm+KjhsGbNDhwWz4tT+Dzzs
 1jaQ==
X-Gm-Message-State: AOJu0Yw0iwyVOl8CwtoA62Iw+2OwdJn3mggxcqZY8dNwaX8WSRFLJ4Fd
 QGwwlCA4yr0ZKvqeckP4tA0In0BpkCoTglPLtcYmZjRiiAdZxNjrNbxldiNqqLXnWoCb15dn9cU
 k+O1CzTVFMw==
X-Gm-Gg: ASbGncsxKmN6BfpWuTzfhgTo4lJTYurjVB1KQ5Afxs9d/n3kPw05lP48ChgCbvpIzTr
 Z4yQLMo8Mct+OnjFCi65kAg+aa7pmZEi+NdoIVS78llALRlYWmPI4c4K0etCExZo9UNYtPYk4bw
 RyzKLDiuALb5rnOAG1RuRZ9TDMTbiUb964qhCJcmKVb8VVl8BnzrMZiiPfYInNk0mXF6FPztTNl
 cjJOOcRCyLmgeNp2jjNK94qKZkYNT7cifjUrBgHDa+OrlK0dJtiuhB2Zsw8DWKfE2GCFE0n7t/t
 TLWILPx+jF+l9YJ9XvPgXT2uLP+BDbEYneEMXNEahwEwMhzukeYacDZsH3oc9rovepQncE1nA9O
 L3fyrpfhXe80qquVTofCHjVmrQrw5ebgswM7U2DF7mbZFnkrh0NTNb+t+pBEIbE4gndFOo6Xd0G
 MkOhB2Qg3iwv5HIQ9RopinTf+XHmnjs9YOkFwpItyH8w==
X-Google-Smtp-Source: AGHT+IHclV7RGfohtsB/N11yV3iCvcuSjqCM8HtqVK0AsZE0GlVi7O4w1jNuvUHwraXVygSiaCywtg==
X-Received: by 2002:a05:6830:82e1:b0:7c1:1250:8acd with SMTP id
 46e09a7af769-7c27cd47d11mr10418638a34.35.1761078507574; 
 Tue, 21 Oct 2025 13:28:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ef0besm3930194a34.20.2025.10.21.13.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:28:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/3] doc: usage: Add general rule for `$?`
Date: Tue, 21 Oct 2025 14:25:32 -0600
Message-ID: <20251021202820.1272414-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021202820.1272414-1-trini@konsulko.com>
References: <20251021202820.1272414-1-trini@konsulko.com>
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

For nearly all commands in U-Boot the '?' variable is handled the same
way with 0 meaning success, 1 meaning failure and -1 meaning invalid
usage. Explain this in the general rules section of the cmdline
documentation (with a link to a counter example) and then remove the
redundant wording from most commands. We retain a section about the
return value in a number of places where we are doing something such as
always returning a specific value or we have useful additional
information to go along with the normal return codes.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 doc/usage/cmd/armffa.rst      | 5 -----
 doc/usage/cmd/bdinfo.rst      | 5 -----
 doc/usage/cmd/bind.rst        | 5 -----
 doc/usage/cmd/blkcache.rst    | 6 ------
 doc/usage/cmd/cat.rst         | 5 -----
 doc/usage/cmd/cli.rst         | 5 -----
 doc/usage/cmd/cls.rst         | 5 -----
 doc/usage/cmd/cp.rst          | 6 ------
 doc/usage/cmd/cpu.rst         | 6 ------
 doc/usage/cmd/cpuid.rst       | 5 -----
 doc/usage/cmd/dmareset.rst    | 6 ------
 doc/usage/cmd/ebtupdate.rst   | 6 ------
 doc/usage/cmd/fatinfo.rst     | 6 ------
 doc/usage/cmd/fdt.rst         | 5 -----
 doc/usage/cmd/font.rst        | 6 ------
 doc/usage/cmd/fuse.rst        | 6 ------
 doc/usage/cmd/gpio.rst        | 6 ------
 doc/usage/cmd/host.rst        | 6 ------
 doc/usage/cmd/i3c.rst         | 6 ------
 doc/usage/cmd/imxtract.rst    | 6 ------
 doc/usage/cmd/loadb.rst       | 5 -----
 doc/usage/cmd/loadm.rst       | 7 -------
 doc/usage/cmd/loads.rst       | 5 -----
 doc/usage/cmd/loadx.rst       | 5 -----
 doc/usage/cmd/loady.rst       | 5 -----
 doc/usage/cmd/msr.rst         | 5 -----
 doc/usage/cmd/mtest.rst       | 5 -----
 doc/usage/cmd/optee.rst       | 5 -----
 doc/usage/cmd/part.rst        | 6 ------
 doc/usage/cmd/pause.rst       | 6 ------
 doc/usage/cmd/pinmux.rst      | 6 ------
 doc/usage/cmd/pwm.rst         | 6 ------
 doc/usage/cmd/saves.rst       | 5 -----
 doc/usage/cmd/scmi.rst        | 7 -------
 doc/usage/cmd/setexpr.rst     | 7 -------
 doc/usage/cmd/size.rst        | 6 ------
 doc/usage/cmd/smbios.rst      | 5 -----
 doc/usage/cmd/sound.rst       | 5 -----
 doc/usage/cmd/source.rst      | 6 ------
 doc/usage/cmd/temperature.rst | 6 ------
 doc/usage/cmd/tftpput.rst     | 5 -----
 doc/usage/cmd/unbind.rst      | 5 -----
 doc/usage/cmd/wdt.rst         | 5 -----
 doc/usage/cmd/wget.rst        | 5 -----
 doc/usage/cmdline.rst         | 6 ++++++
 45 files changed, 6 insertions(+), 245 deletions(-)

diff --git a/doc/usage/cmd/armffa.rst b/doc/usage/cmd/armffa.rst
index 4f41e3393fda..dbe4d5bc8425 100644
--- a/doc/usage/cmd/armffa.rst
+++ b/doc/usage/cmd/armffa.rst
@@ -90,8 +90,3 @@ Configuration
 -------------
 
 The command is available if CONFIG_CMD_ARMFFA=y and CONFIG_ARM_FFA_TRANSPORT=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) on failure.
diff --git a/doc/usage/cmd/bdinfo.rst b/doc/usage/cmd/bdinfo.rst
index a21fbc83ccf6..a139c9d855c0 100644
--- a/doc/usage/cmd/bdinfo.rst
+++ b/doc/usage/cmd/bdinfo.rst
@@ -115,8 +115,3 @@ Configuration
 -------------
 
 The bdinfo command is available if CONFIG_CMD_BDI=y.
-
-Return code
------------
-
-The return code $? is 0 (true).
diff --git a/doc/usage/cmd/bind.rst b/doc/usage/cmd/bind.rst
index 67a0405bab53..d2bef15508d0 100644
--- a/doc/usage/cmd/bind.rst
+++ b/doc/usage/cmd/bind.rst
@@ -99,8 +99,3 @@ Configuration
 -------------
 
 The bind command is only available if CONFIG_CMD_BIND=y.
-
-Return code
------------
-
-The return code $? is 0 (true) on success and 1 (false) on failure.
diff --git a/doc/usage/cmd/blkcache.rst b/doc/usage/cmd/blkcache.rst
index 0329261ba9af..764a4903ca05 100644
--- a/doc/usage/cmd/blkcache.rst
+++ b/doc/usage/cmd/blkcache.rst
@@ -69,9 +69,3 @@ Configuration
 -------------
 
 The blkcache command is only available if CONFIG_CMD_BLOCK_CACHE=y.
-
-Return code
------------
-
-If the command succeeds, the return code $? is set 0 (true). In case of an
-error the return code is set to 1 (false).
diff --git a/doc/usage/cmd/cat.rst b/doc/usage/cmd/cat.rst
index b22dc6184a27..fa70e5f6a093 100644
--- a/doc/usage/cmd/cat.rst
+++ b/doc/usage/cmd/cat.rst
@@ -45,8 +45,3 @@ Configuration
 -------------
 
 The cat command is only available if CONFIG_CMD_CAT=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the file is readable, otherwise it returns a non-zero error code.
diff --git a/doc/usage/cmd/cli.rst b/doc/usage/cmd/cli.rst
index 23e5ee7a902e..97de5331d1b2 100644
--- a/doc/usage/cmd/cli.rst
+++ b/doc/usage/cmd/cli.rst
@@ -70,8 +70,3 @@ compiled::
     modern
     => cli set old
     Want to set current parser to old, but its code was not compiled!
-
-Return value
-------------
-
-The return value $? indicates whether the command succeeded.
diff --git a/doc/usage/cmd/cls.rst b/doc/usage/cmd/cls.rst
index 828276742b9b..b8fa335079ea 100644
--- a/doc/usage/cmd/cls.rst
+++ b/doc/usage/cmd/cls.rst
@@ -22,8 +22,3 @@ Configuration
 -------------
 
 The cls command is only available if CONFIG_CMD_CLS=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success and 1 (false) on failure.
diff --git a/doc/usage/cmd/cp.rst b/doc/usage/cmd/cp.rst
index 434dfedfc2b7..7bf2f468421b 100644
--- a/doc/usage/cmd/cp.rst
+++ b/doc/usage/cmd/cp.rst
@@ -79,9 +79,3 @@ Configuration
 The cp command is available if CONFIG_CMD_MEMORY=y. Support for 64 bit words
 (cp.q) is only available on 64-bit targets. Copying to flash depends on
 CONFIG_MTD_NOR_FLASH=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the command was successfully,
-1 (false) otherwise.
diff --git a/doc/usage/cmd/cpu.rst b/doc/usage/cmd/cpu.rst
index 8b0b7d5a6991..705fb2dd6913 100644
--- a/doc/usage/cmd/cpu.rst
+++ b/doc/usage/cmd/cpu.rst
@@ -93,9 +93,3 @@ Configuration
 -------------
 
 The cpu command is available if CONFIG_CMD_CPU=y.
-
-Return code
------------
-
-The return value $? is set to 0 (true) if the command is successful,
-1 (false) otherwise.
diff --git a/doc/usage/cmd/cpuid.rst b/doc/usage/cmd/cpuid.rst
index cccf9262ed4d..568c7e86ca15 100644
--- a/doc/usage/cmd/cpuid.rst
+++ b/doc/usage/cmd/cpuid.rst
@@ -25,11 +25,6 @@ Configuration
 
 The cpuid command is only available on x86.
 
-Return value
-------------
-
-The return value $? is 0 (true).
-
 Example
 -------
 
diff --git a/doc/usage/cmd/dmareset.rst b/doc/usage/cmd/dmareset.rst
index ab06979251be..56180595363e 100644
--- a/doc/usage/cmd/dmareset.rst
+++ b/doc/usage/cmd/dmareset.rst
@@ -47,9 +47,3 @@ Configuration
 
 The dmareset command is only available if CONFIG_CMD_C5_PL330_DMA=y in
 "Shell scripting commands".
-
-Return value
-------------
-
-If the command succeeds, the return value $? is set to 0 (true).
-If an error occurs, the return value $? is set to 1 (false).
diff --git a/doc/usage/cmd/ebtupdate.rst b/doc/usage/cmd/ebtupdate.rst
index 22415ee07b43..5102e6090a49 100644
--- a/doc/usage/cmd/ebtupdate.rst
+++ b/doc/usage/cmd/ebtupdate.rst
@@ -64,9 +64,3 @@ Configuration
 
 The ebtupdate command is only available if CONFIG_CMD_EBTUPDATE=y and
 only on Tegra 2 and Tegra 3 configurations.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if everything went successfully. If an
-error occurs, the return value $? is set to 1 (false).
diff --git a/doc/usage/cmd/fatinfo.rst b/doc/usage/cmd/fatinfo.rst
index 2e05ab8becee..e5a89f37ba66 100644
--- a/doc/usage/cmd/fatinfo.rst
+++ b/doc/usage/cmd/fatinfo.rst
@@ -46,9 +46,3 @@ Configuration
 -------------
 
 The fatinfo command is only available if CONFIG_CMD_FAT=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the partition is a FAT partition.
-Otherwise it is set to 1 (false).
diff --git a/doc/usage/cmd/fdt.rst b/doc/usage/cmd/fdt.rst
index 71a9fc627e55..493ed895bc78 100644
--- a/doc/usage/cmd/fdt.rst
+++ b/doc/usage/cmd/fdt.rst
@@ -66,8 +66,3 @@ address and expand it to 0xf000 in size::
     Working FDT set to 10000
     => md 10000 4
     00010000: edfe0dd0 00f00000 78000000 7c270000  ...........x..'|
-
-Return value
-------------
-
-The return value $? indicates whether the command succeeded.
diff --git a/doc/usage/cmd/font.rst b/doc/usage/cmd/font.rst
index 44a04f5d075e..a1860466ac1b 100644
--- a/doc/usage/cmd/font.rst
+++ b/doc/usage/cmd/font.rst
@@ -54,9 +54,3 @@ Configuration
 -------------
 
 The command is only available if CONFIG_CONSOLE_TRUETYPE=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) if the command completes.
-The return value is 1 (false) if the command fails.
diff --git a/doc/usage/cmd/fuse.rst b/doc/usage/cmd/fuse.rst
index 42c6e209f992..50cf5a4b6578 100644
--- a/doc/usage/cmd/fuse.rst
+++ b/doc/usage/cmd/fuse.rst
@@ -168,9 +168,3 @@ Configuration
 
 The fuse commands are available if CONFIG_CMD_FUSE=y.
 The fuse writebuff command is available if CONFIG_CMD_FUSE_WRITEBUFF=y.
-
-Return code
------------
-
-The return value $? is set to 0 (true) if the command is successful,
-1 (false) otherwise.
diff --git a/doc/usage/cmd/gpio.rst b/doc/usage/cmd/gpio.rst
index 4b0dc2716e57..0159d3478c2d 100644
--- a/doc/usage/cmd/gpio.rst
+++ b/doc/usage/cmd/gpio.rst
@@ -127,9 +127,3 @@ Configuration
 
 The *gpio* command is only available if CONFIG_CMD_GPIO=y.
 The *gpio read* command is only available if CONFIG_CMD_GPIO_READ=y.
-
-Return value
-------------
-
-If the command succeds the return value $? is set to 0. If an error occurs, the
-return value $? is set to 1.
diff --git a/doc/usage/cmd/host.rst b/doc/usage/cmd/host.rst
index a70a432b6f2b..672d8f2112bc 100644
--- a/doc/usage/cmd/host.rst
+++ b/doc/usage/cmd/host.rst
@@ -111,9 +111,3 @@ Unbind a device::
     => host info
     dev       blocks label           path
       1         2048 fat             1MB.fat32.img
-
-
-Return value
-------------
-
-The return value $? indicates whether the command succeeded.
diff --git a/doc/usage/cmd/i3c.rst b/doc/usage/cmd/i3c.rst
index 922fa3ea37c0..f49fcd4e7663 100644
--- a/doc/usage/cmd/i3c.rst
+++ b/doc/usage/cmd/i3c.rst
@@ -129,12 +129,6 @@ Configuration
 
 The ``i3c`` command is only available if CONFIG_CMD_I3C=y.
 
-Return value
-------------
-
-If the command succeeds, the return value ``$?`` is set to 0. If an error
-occurs, the return value ``$?`` is set to 1.
-
 Note
 ----
 
diff --git a/doc/usage/cmd/imxtract.rst b/doc/usage/cmd/imxtract.rst
index 235d15e445b0..1621a4a68b22 100644
--- a/doc/usage/cmd/imxtract.rst
+++ b/doc/usage/cmd/imxtract.rst
@@ -76,9 +76,3 @@ Configuration
 The imxtract command is only available if CONFIG_CMD_XIMG=y. Support for FIT
 images requires CONFIG_FIT=y. Support for legacy U-Boot images requires
 CONFIG_LEGACY_IMAGE_FORMAT=y.
-
-Return value
-------------
-
-On success the return value $? of the command is 0 (true). On failure the
-return value is 1 (false).
diff --git a/doc/usage/cmd/loadb.rst b/doc/usage/cmd/loadb.rst
index 4f9a52c793f3..9e6a41e7fa04 100644
--- a/doc/usage/cmd/loadb.rst
+++ b/doc/usage/cmd/loadb.rst
@@ -66,8 +66,3 @@ Configuration
 -------------
 
 The command is only available if CONFIG_CMD_LOADB=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) on error.
diff --git a/doc/usage/cmd/loadm.rst b/doc/usage/cmd/loadm.rst
index 005840a27bb0..722690be2c57 100644
--- a/doc/usage/cmd/loadm.rst
+++ b/doc/usage/cmd/loadm.rst
@@ -43,10 +43,3 @@ Configuration
 -------------
 
 The command is only available if CONFIG_CMD_LOADM=y.
-
-Return value
-------------
-
-The return value $? is set 0 (true) if the loading is succefull, and
-is set to 1 (false) in case of error.
-
diff --git a/doc/usage/cmd/loads.rst b/doc/usage/cmd/loads.rst
index 0a2ac14acfe8..278d17850d75 100644
--- a/doc/usage/cmd/loads.rst
+++ b/doc/usage/cmd/loads.rst
@@ -92,8 +92,3 @@ Configuration
 
 The command is only available if CONFIG_CMD_LOADS=y. The parameter to set the
 baud rate is only available if CONFIG_SYS_LOADS_BAUD_CHANGE=y
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/cmd/loadx.rst b/doc/usage/cmd/loadx.rst
index 661b36723c32..50182eaa9d3b 100644
--- a/doc/usage/cmd/loadx.rst
+++ b/doc/usage/cmd/loadx.rst
@@ -73,8 +73,3 @@ The command is only available if CONFIG_CMD_LOADB=y.
 Initial timeout in seconds while waiting for transfer is configured by
 config option CMD_LOADXY_TIMEOUT or by env variable $loadxy_timeout.
 Setting it to 0 means infinite timeout.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/cmd/loady.rst b/doc/usage/cmd/loady.rst
index 8367759471e3..8d21d7c32679 100644
--- a/doc/usage/cmd/loady.rst
+++ b/doc/usage/cmd/loady.rst
@@ -70,8 +70,3 @@ The command is only available if CONFIG_CMD_LOADB=y.
 Initial timeout in seconds while waiting for transfer is configured by
 config option CMD_LOADXY_TIMEOUT or by env variable $loadxy_timeout.
 Setting it to 0 means infinite timeout.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/cmd/msr.rst b/doc/usage/cmd/msr.rst
index 04ee52cc1c75..8bb1212cdc17 100644
--- a/doc/usage/cmd/msr.rst
+++ b/doc/usage/cmd/msr.rst
@@ -38,11 +38,6 @@ Configuration
 
 The msr command is only available on x86.
 
-Return value
-------------
-
-The return value $? is 0 (true).
-
 Example
 -------
 
diff --git a/doc/usage/cmd/mtest.rst b/doc/usage/cmd/mtest.rst
index e01f2a6d575e..a5705076af7a 100644
--- a/doc/usage/cmd/mtest.rst
+++ b/doc/usage/cmd/mtest.rst
@@ -62,8 +62,3 @@ Configuration
 -------------
 
 The mtest command is enabled by CONFIG_CMD_MEMTEST=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
index 46c569a105fd..caefdceeb7b6 100644
--- a/doc/usage/cmd/optee.rst
+++ b/doc/usage/cmd/optee.rst
@@ -63,8 +63,3 @@ Configuration
 -------------
 
 The optee command is enabled by CONFIG_OPTEE=y and CONFIG_CMD_OPTEE=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index e7f6e54ecea4..72f5d8b8de74 100644
--- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -223,9 +223,3 @@ This shows looking at a device with multiple partition tables::
             type:	ebd0a0a2-b9e5-4433-87c0-68b6b72699c7
             guid:	a0891d7e-b930-4513-94da-f629dbd637b2
     =>
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the command succededd. If an
-error occurs, the return value $? is set to 1 (false).
diff --git a/doc/usage/cmd/pause.rst b/doc/usage/cmd/pause.rst
index 6cdd83d31636..b55825f5d93a 100644
--- a/doc/usage/cmd/pause.rst
+++ b/doc/usage/cmd/pause.rst
@@ -48,9 +48,3 @@ Note that complex prompts require proper quoting:
     
     Usage:
     pause [prompt] - Wait until users presses any key. [prompt] can be used to customize the message.
-
-Return value
-------------
-
-The return value $? is always set to 0 (true), unless invoked in an invalid
-manner.
diff --git a/doc/usage/cmd/pinmux.rst b/doc/usage/cmd/pinmux.rst
index 30c5eb16a689..c066db1770cb 100644
--- a/doc/usage/cmd/pinmux.rst
+++ b/doc/usage/cmd/pinmux.rst
@@ -90,9 +90,3 @@ Configuration
 -------------
 
 The pinmux command is only available if CONFIG_CMD_PINMUX=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the command succeded and to 1 (false)
-otherwise.
diff --git a/doc/usage/cmd/pwm.rst b/doc/usage/cmd/pwm.rst
index 522acb5afa33..6f7daba0736d 100644
--- a/doc/usage/cmd/pwm.rst
+++ b/doc/usage/cmd/pwm.rst
@@ -83,9 +83,3 @@ Configuration
 -------------
 
 The ``pwm`` command is only available if CONFIG_CMD_PWM=y.
-
-Return value
-------------
-
-If the command succeeds, the return value ``$?`` is set to 0. If an error occurs, the
-return value ``$?`` is set to 1.
diff --git a/doc/usage/cmd/saves.rst b/doc/usage/cmd/saves.rst
index b380a4feb6f0..d429eeceddf2 100644
--- a/doc/usage/cmd/saves.rst
+++ b/doc/usage/cmd/saves.rst
@@ -84,8 +84,3 @@ Configuration
 
 The command is only available if CONFIG_CMD_SAVES=y. The parameter to set the
 baud rate is only available if CONFIG_SYS_LOADS_BAUD_CHANGE=y
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/cmd/scmi.rst b/doc/usage/cmd/scmi.rst
index 9591cdc07a5a..c6e80a56a603 100644
--- a/doc/usage/cmd/scmi.rst
+++ b/doc/usage/cmd/scmi.rst
@@ -119,11 +119,4 @@ Configuration
 The scmi command is only available if CONFIG_CMD_SCMI=y.
 Default n because this command is mainly for debug purpose.
 
-Return value
-------------
-
-The return value ($?) is set to 0 if the operation succeeded,
-1 if the operation failed or -1 if the operation failed due to
-a syntax error.
-
 .. _`SCMI specification`: https://developer.arm.com/documentation/den0056/e/?lang=en
diff --git a/doc/usage/cmd/setexpr.rst b/doc/usage/cmd/setexpr.rst
index 5bc37ae50fc0..96894a2754f6 100644
--- a/doc/usage/cmd/setexpr.rst
+++ b/doc/usage/cmd/setexpr.rst
@@ -147,10 +147,3 @@ Configuration
 * The *setexpr gsub* and *setexpr sub* sub-commands are only available
   if CONFIG_REGEX=y. For an overview of the supported regex syntax,
   see :doc:`test`.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the operation was successful.
-
-If an error occurs, the return value $? is set to 1 (false).
diff --git a/doc/usage/cmd/size.rst b/doc/usage/cmd/size.rst
index 306fcba0ba4a..42e2dec6323c 100644
--- a/doc/usage/cmd/size.rst
+++ b/doc/usage/cmd/size.rst
@@ -35,9 +35,3 @@ Configuration
 -------------
 
 The size command is only available if CONFIG_CMD_FS_GENERIC=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the command succeded and to 1 (false)
-otherwise.
diff --git a/doc/usage/cmd/smbios.rst b/doc/usage/cmd/smbios.rst
index 1ffd706d7dee..3c98795698e7 100644
--- a/doc/usage/cmd/smbios.rst
+++ b/doc/usage/cmd/smbios.rst
@@ -86,8 +86,3 @@ Configuration
 -------------
 
 The command is only available if CONFIG_CMD_SMBIOS=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success, 1 (false) otherwise.
diff --git a/doc/usage/cmd/sound.rst b/doc/usage/cmd/sound.rst
index 97d610f3745c..4474ce954202 100644
--- a/doc/usage/cmd/sound.rst
+++ b/doc/usage/cmd/sound.rst
@@ -56,8 +56,3 @@ Configuration
 -------------
 
 The sound command is enabled by CONFIG_CMD_SOUND=y.
-
-Return value
-------------
-
-The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
diff --git a/doc/usage/cmd/source.rst b/doc/usage/cmd/source.rst
index 0de5f33390e7..bd585f374140 100644
--- a/doc/usage/cmd/source.rst
+++ b/doc/usage/cmd/source.rst
@@ -188,9 +188,3 @@ The FIT image file format requires CONFIG_FIT=y.#
 The legacy U-Boot image file format requires CONFIG_LEGACY_IMAGE_FORMAT=y.
 On hardened systems support for the legacy U-Boot image format should be
 disabled as these images cannot be signed and verified.
-
-Return value
-------------
-
-If the scripts is executed successfully, the return value $? is 0 (true).
-Otherwise it is 1 (false).
diff --git a/doc/usage/cmd/temperature.rst b/doc/usage/cmd/temperature.rst
index 945bc8204ac7..d5ea1196f452 100644
--- a/doc/usage/cmd/temperature.rst
+++ b/doc/usage/cmd/temperature.rst
@@ -45,9 +45,3 @@ Configuration
 -------------
 
 The *temperature* command is only available if CONFIG_CMD_TEMPERATURE=y.
-
-Return value
-------------
-
-The return value $? is set to 0 (true) if the command succeeded and to 1 (false)
-otherwise.
diff --git a/doc/usage/cmd/tftpput.rst b/doc/usage/cmd/tftpput.rst
index 351c9faa38b9..214c7777da6f 100644
--- a/doc/usage/cmd/tftpput.rst
+++ b/doc/usage/cmd/tftpput.rst
@@ -83,8 +83,3 @@ after which an ACK response is required. The window size defaults to 1.
 
 If CONFIG_TFTP_TSIZE=y, the progress bar is limited to 50 '#' characters.
 Otherwise an '#' is written per UDP package which may decrease performance.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success and 1 (false) otherwise.
diff --git a/doc/usage/cmd/unbind.rst b/doc/usage/cmd/unbind.rst
index 1ae9c1b172c1..5a165cfee230 100644
--- a/doc/usage/cmd/unbind.rst
+++ b/doc/usage/cmd/unbind.rst
@@ -91,8 +91,3 @@ Configuration
 -------------
 
 The unbind command is only available if CONFIG_CMD_BIND=y.
-
-Return code
------------
-
-The return code $? is 0 (true) on success and 1 (false) on failure.
diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
index f48b8840907d..711b74d20dab 100644
--- a/doc/usage/cmd/wdt.rst
+++ b/doc/usage/cmd/wdt.rst
@@ -73,8 +73,3 @@ Configuration
 -------------
 
 The command is only available if CONFIG_CMD_WDT=y.
-
-Return value
-------------
-
-The return value $? is 0 if the command succeeds, 1 upon failure.
diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 8feda0248b20..e6c42f967b9b 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -184,8 +184,3 @@ CONFIG_WGET_CACERT=y (for the wget cacert command).
 TCP Selective Acknowledgments in the legacy network stack can be enabled via
 CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
 Acknowledgments are enabled by default with lwIP.
-
-Return value
-------------
-
-The return value $? is 0 (true) on success and 1 (false) otherwise.
diff --git a/doc/usage/cmdline.rst b/doc/usage/cmdline.rst
index 58240c5279cd..cb353975eb82 100644
--- a/doc/usage/cmdline.rst
+++ b/doc/usage/cmdline.rst
@@ -55,6 +55,12 @@ General rules
    command will cause "run" to terminate, i. e. the remaining
    variables are not executed.
 
+#. The variable `?` will be set as the return value of any command. These
+   values are 0 on success, -1 on a usage related errors, i. e. invalid syntax
+   and 1 on any other error. Any exceptions to this are documented by the
+   specific command, i. e. :doc:`cmd/for` sets this based on the last command
+   run within the loop.
+
 Representing numbers
 --------------------
 
-- 
2.43.0

