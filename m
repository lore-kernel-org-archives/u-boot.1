Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2646EC282EC
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECAA81B42;
	Thu,  6 Mar 2025 01:28:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h9Amu6V1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A8381273; Thu,  6 Mar 2025 01:28:26 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DF181951
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85aec8c95c4so9492539f.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220840; x=1741825640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSORi2Dvb/PKydP1L3PPYj+vaDWbvXTVVVoBoxub4PI=;
 b=h9Amu6V1T1MGgIIyR6NdeiYZztQgKOHqWbItc8hUyGVRuzVw4jY2sU+Lu2D+WrVlFh
 ZId5LLdanQ6S9G2ZqmWwEv+4SO710RJAgeiyN1lhBy6n86bInshJUSPs4lyOksm8PIu0
 mapYar3ASAIZsmxOPrfeAC5/ANNcmRf8JvlU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220840; x=1741825640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wSORi2Dvb/PKydP1L3PPYj+vaDWbvXTVVVoBoxub4PI=;
 b=MYj6VdNuomgGCNiHczHAgCxmu28MCWhzQYbqSEmPx42bSp/SzdggGETZqdIostgjPI
 G44h6wPrHwlQ220Sy2w7J5PKEJVi2Bov00R/5R87oIBWbrp51VnnlhanuXarzr4aEPZ3
 jvp8VC79MXcHXXELEmptHe7JWdK/7hky85u+fPahZchJdb/nFLaU98JUezftcJQY24Cm
 RpO/rOdsYqy+WuXOKlnVAnQGL0PYhSJP1uXle795lshxLw5Og85f2mMhvCOF878LpXlC
 L/TDrXQSK2cA3GAhZLQCbFzciywNRoEW+LmWc+oMiNHQoUv689KhslwxBKKj9BqYuI9H
 HXHA==
X-Gm-Message-State: AOJu0YwDmvfkgyiqwUFZb4yPslav/FYp7Am8TTLzYRxNZUopxRbQjc5E
 npQpaG0TpZ2PnKMJ+qXzCWfixOm/py/xVpgML0wP4THWIfXN+UVE2y9WggByS4wGmO4XL+PoHA0
 =
X-Gm-Gg: ASbGncuMW2lmg8ib1HPKy+3O4fiCmsCj83oA66x6aa4mO1mpM/1mYLyjT6iMIpYlTrm
 tYkU7TSdVw6zgXiGOyfxXXLviofELpjOE9JdRDvamozjNpr2iX4b6TeYEriwtBjUy3deFg4qOib
 /U7Uw/s99om8/AWKmS/eP2/cw9RJ2B24T3JHCuWW3A45qxqWKcLzT0o3gJLdRv0fY0jh6rqI+qh
 pU6DYcXVlOdMUUZtgmhSzMgdNSsJIybuMzOHZW4wWeYlNS8uoTo7z+OLOiC3KVfUPA8lMLbqV1l
 SZfVOxEeWy3d2omNq4ltq9AyUL4LBbxUaVmg6AzVEHdm7LeqLvVoC22FfwzXXdXknM8+oYV1opQ
 tU7x1oQ==
X-Google-Smtp-Source: AGHT+IEAgM+ghIOS+tqd5jQ9tdBMGgnne3qkp7IbON00oUDQexLRqi1VGS120zar+WIn07CzrhyuSw==
X-Received: by 2002:a05:6602:b97:b0:85a:dcc4:d763 with SMTP id
 ca18e2360f4ac-85aff8bc8f7mr630800139f.7.1741220840323; 
 Wed, 05 Mar 2025 16:27:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:27:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v5 20/29] boot: pxe: Refactor label_run_boot() to avoid cmdline
Date: Wed,  5 Mar 2025 17:25:14 -0700
Message-ID: <20250306002533.2380866-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

Adjust the remaining call in this function to use the bootm API. This
will allow PXE to work without the command line.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Use ramdisk address for the initrd_addr field, not kernel address

 arch/x86/lib/zimage.c | 27 +++++++++++++++++++--------
 boot/pxe_utils.c      | 14 ++++++--------
 include/bootm.h       |  9 +++++++++
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 145ba0b8ea0..ba7a008fec7 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -432,27 +432,38 @@ int zboot_go(struct bootm_info *bmi)
 	return ret;
 }
 
-int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-		   ulong base, char *cmdline)
+int zboot_run(struct bootm_info *bmi)
 {
-	struct bootm_info bmi;
 	int ret;
 
-	bootm_init(&bmi);
-	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
-	ret = zboot_load(&bmi);
+	ret = zboot_load(bmi);
 	if (ret)
 		return log_msg_ret("ld", ret);
-	ret = zboot_setup(&bmi);
+	ret = zboot_setup(bmi);
 	if (ret)
 		return log_msg_ret("set", ret);
-	ret = zboot_go(&bmi);
+	ret = zboot_go(bmi);
 	if (ret)
 		return log_msg_ret("go", ret);
 
 	return -EFAULT;
 }
 
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
+{
+	struct bootm_info bmi;
+	int ret;
+
+	bootm_init(&bmi);
+	zboot_start(&bmi, addr, size, initrd, initrd_size, base, cmdline);
+	ret = zboot_run(&bmi);
+	if (ret)
+		return log_msg_ret("zra", ret);
+
+	return 0;
+}
+
 static void print_num(const char *name, ulong value)
 {
 	printf("%-20s: %lx\n", name, value);
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 37306f37009..c606da9e96b 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -585,10 +585,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *kernel_addr, char *initrd_addr_str,
 			  char *initrd_filesize, char *initrd_str)
 {
-	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	struct bootm_info bmi;
 	ulong kernel_addr_r;
-	int zboot_argc = 3;
 	void *buf;
 	int ret;
 
@@ -601,14 +599,14 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 		return ret;
 
 	bmi.addr_img = kernel_addr;
-	zboot_argv[1] = kernel_addr;
+	bootm_x86_set(&bmi, bzimage_addr, hextoul(kernel_addr, NULL));
 
 	if (initrd_addr_str) {
 		bmi.conf_ramdisk = initrd_str;
-
-		zboot_argv[3] = initrd_addr_str;
-		zboot_argv[4] = initrd_filesize;
-		zboot_argc = 5;
+		bootm_x86_set(&bmi, initrd_addr,
+			      hextoul(initrd_addr_str, NULL));
+		bootm_x86_set(&bmi, initrd_size,
+			      hextoul(initrd_filesize, NULL));
 	}
 
 	if (!bmi.conf_fdt) {
@@ -642,7 +640,7 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	/* Try booting an x86_64 Linux kernel image */
 	} else if (IS_ENABLED(CONFIG_CMD_ZBOOT)) {
 		log_debug("using zboot\n");
-		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
+		ret = zboot_run(&bmi);
 	}
 
 	unmap_sysmem(buf);
diff --git a/include/bootm.h b/include/bootm.h
index d174f18ac18..465577a66f5 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -315,6 +315,15 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
  */
 int bootm_process_cmdline_env(int flags);
 
+/**
+ * zboot_run() - Run through the various steps to boot a zimage
+ *
+ * @bmi: Bootm information, with bzimage_size, initrd_addr, initrd_size and
+ * cmdline set up. If base_ptr is 0, then bzimage_addr must be set to the start
+ * of the bzImage. Otherwise base_ptr and load_address must be provided.
+ */
+int zboot_run(struct bootm_info *bmi);
+
 /**
  * zboot_run_args() - Run through the various steps to boot a zimage
  *
-- 
2.43.0

