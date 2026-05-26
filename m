Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D0CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 13:10:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7B88484C;
	Tue, 26 May 2026 15:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XOp3LhdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C4084875; Tue, 26 May 2026 15:10:10 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9E7C8484C
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 15:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-439a7e828b1so8910856fac.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779801007; x=1780405807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=claXXVcEwoLoKs+cu+8KIRhmJ2efXjYfqyrHMrs7osQ=;
 b=XOp3LhdYb0jVEKso3s5z/+ryPqxd1WAUsWzyCreWs+vQDPmV8EGBGDMC2mCqzbPDz7
 bDQF5v6eTto1b8mAY5EGJa81usbmhhM5c73HVPbTmtifjMv2GLX9zPcWwfWrE5TMJDqZ
 hHBFYq8woxWYXgvCX30wJuM9AxJUqzDzBbIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779801007; x=1780405807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=claXXVcEwoLoKs+cu+8KIRhmJ2efXjYfqyrHMrs7osQ=;
 b=foK5H3hG/0Jm1UfVeVnO94vAKYpBWLgs1MeGqETNobVbQyGyj1PUpwCEKLQA/F3qhh
 RHr7ucszzvEwsoPP84xtQBlPOA40GNUgdvdO5yT84Iv0EVVRBXa4i+Yu+5uyNDGnepQR
 HZGJLQ61zCxwU6IX+G4NkoJZORsxgJXM++Ld7GBCUbimq6hn8vtMIt2tLINaV6CtMjdh
 /v6c6QugJXjPvN2CY7wek8y30G5FznOd7+HsJ4E5okF/7n116XK2zqIs67/DuwSYd2tY
 eIw/Xv0lJRgn2rYB8SsVLDSilE3Bq3EMY373XG0MuTiHsY+6a9iSojhagtz1GGNOXnq+
 zUYQ==
X-Gm-Message-State: AOJu0YwQHy4tZnmCn+rTFaGD8vIXtMqbxjkE2TtO2H8RiTO5no7ky/KH
 SPzng8fBBpTxlVi+9MuQBHP3HbMbczAH0xMHFj7b/mnUSOVKPGJKMXs8SqjDe6XNIM0UtqCiNo5
 5YKLWJp+AbbE=
X-Gm-Gg: Acq92OHq0FM4fyTJcR+fBU6dJblMLuajyACu91e8+diETg1n/VRwGgZ6yzLpfSS3UWl
 dC6r2mlFZ2yokwfI96FMB7W0qmWBaoDL5wXtnFUrho7xCU3v7xMQtRrJ0N8k2RCCEKBp7pu4V/B
 UqupmVwHF4f/sBbQKyoL8P4/bGiCdAA16jnczPCkwO8JoT6S+AM+C8CW12dBZ3uxgq1V7Lejfgh
 7Yw9bSBdyhLh2ijJigCPfGS0rQAaN67dH+XbzwN0lLVWGxKxRn6Kdo6kFbqWsePdTeluE+GFmJh
 R5+fnYBbqqMoUWz2cHmWDmVaVbkOPH6Ng5LNnA7Ud2832/KdbFov0yKGNeSzP22EPpXkdJThd2r
 zzXfFU509uCy+oPCtt4+hJzBjVnHCVnl+Zf0rbCl0qJqXA5mi8aWmBJeFzk+EavAST7USHy+gz9
 09dTss0JBo234o5k6TkA==
X-Received: by 2002:a05:6820:8188:b0:69d:a6ef:f014 with SMTP id
 006d021491bc7-69da6effcb3mr4770777eaf.14.1779801007471; 
 Tue, 26 May 2026 06:10:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83aafca2sm6974601eaf.15.2026.05.26.06.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:10:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH 2/9] x86: Rename zboot_run() to zboot_run_args()
Date: Tue, 26 May 2026 07:09:08 -0600
Message-ID: <20260526130931.2103552-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526130931.2103552-1-sjg@chromium.org>
References: <20260526130931.2103552-1-sjg@chromium.org>
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

Rename this function so we can (later) create a zboot_run() function
which looks the same as bootm_run()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/zimage.c | 4 ++--
 boot/bootmeth_cros.c  | 6 +++---
 include/bootm.h       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index a5f2231aa52..b542ca2d458 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -434,8 +434,8 @@ int zboot_go(void)
 	return ret;
 }
 
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline)
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline)
 {
 	int ret;
 
diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index c7b862e512a..ea4c9ed830f 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -446,9 +446,9 @@ static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 	}
 
 	if (IS_ENABLED(CONFIG_X86)) {
-		ret = zboot_run(map_to_sysmem(bflow->buf), bflow->size, 0, 0,
-				map_to_sysmem(bflow->x86_setup),
-				bflow->cmdline);
+		ret = zboot_run_args(map_to_sysmem(bflow->buf), bflow->size, 0,
+				     0, map_to_sysmem(bflow->x86_setup),
+				     bflow->cmdline);
 	} else {
 		ret = bootm_boot_start(map_to_sysmem(bflow->buf),
 				       bflow->cmdline);
diff --git a/include/bootm.h b/include/bootm.h
index f6958be751a..a6262de9ce7 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -273,7 +273,7 @@ int bootm_process_cmdline(char *buf, int maxlen, int flags);
 int bootm_process_cmdline_env(int flags);
 
 /**
- * zboot_run() - Run through the various steps to boot a zimage
+ * zboot_run_args() - Run through the various steps to boot a zimage
  *
  * Boot a zimage, given the component parts
  *
@@ -289,8 +289,8 @@ int bootm_process_cmdline_env(int flags);
  *	to use for booting
  * Return: -EFAULT on error (normally it does not return)
  */
-int zboot_run(ulong addr, ulong size, ulong initrd, ulong initrd_size,
-	      ulong base, char *cmdline);
+int zboot_run_args(ulong addr, ulong size, ulong initrd, ulong initrd_size,
+		   ulong base, char *cmdline);
 
 /*
  * zimage_get_kernel_version() - Get the version string from a kernel
-- 
2.43.0

