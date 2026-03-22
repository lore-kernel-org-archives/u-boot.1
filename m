Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D12D58CA1
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 20:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742AD8405B;
	Sun, 22 Mar 2026 21:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGCVX9Qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239BD8366F; Sun, 22 Mar 2026 21:09:52 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8A1C83FA7
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 21:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so8919655ad.0
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 13:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774210188; x=1774814988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0WOimlIZe75PbFE2NxSlDd6zINtP9Hlx5GtpuzZLvZM=;
 b=lGCVX9QileSMykUUC+3mOTz6h66mBC54pil1cVgXPiSgd2yHXXyrbDzN3cVhlKPA/k
 WNFaA6prarzZCB43hfnGQn3Jtn478Z4rrirda1ACsLWXGx/kJMJWJrAMKk1MBjbtzS3V
 ZUDku/TlDJeQdc8jaFxxxmJR6eiXaIcDb/lqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774210188; x=1774814988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WOimlIZe75PbFE2NxSlDd6zINtP9Hlx5GtpuzZLvZM=;
 b=hsbv+rHgBxsT8OKVN0ZVilT36ON5OKvEYf+4rFvP4Z4UaZphmondxyyVuDzlWt1zdq
 d/LG27Zv4obVgNOOvkBMBAAopq9CI1k2wEe08UlpOBvs0fct5XAL/sa1x7z1jL7HpZPB
 hTK52L1LmkSHWtCTlfTm4A3eoxXLd/X3GQ/WP5SOuEzbn3/Cp+TnpVfNygFaZbzbuZLu
 rR8okLhpFLMcnE0MxdUW/VIWwBDV0Cqls7y2BnDkjdUt8M52WbyWRvu2unBYTVrWsSg9
 pMadmkFqHGytzxoZaY4RbgYX4C9gpRYUUi9OUQ/npCiMX5vgA7N4LkqXMYbKg/8slEQF
 K0Dw==
X-Gm-Message-State: AOJu0YzUwu4lkfWD79MoZBhFq5+Zbx2nTNcE/vNhw5vXSUgQupr32QkA
 6D34P+2KVzDFXW0VrgwJzlXxzIpe9LIAAqA4P4BEMMMAflHGellBh4JuQ2dUbGU4jNh6JZ7Ubhd
 CsfBNSw==
X-Gm-Gg: ATEYQzxSCRgcE+jPNFEItB4RxhuNmJIoU8Un3cw8ZnHnEn95Hb9KUdyNnF7EtWHJnGy
 45eIqfmsgWCPU7UqKLEYxDGK6oFvJITKD44T8BKo4jEMI+3TDjL1iCRGhJqZftOCgDulhrFIwXq
 cbL1bqIh7c2y3s32viKv4fxT1DxhSpQDklYE+QB4Gwo+8h5JwooSpThthEZEh7f3qNlQY8rFUOi
 CL3Zc6CpUqw3T63irdUHkWYpdPNb6HNkOFqJfeB0T8EjUwwd7kG7cOjJ1ZdrUpcJTNBPe8gO6wq
 UdTA7yBuxGJYoa85BLnsh8FOHiBAPtPUyKHwM5UrLPTIw8SvIF9v3xLiP7tXqKdh/KIGa24vrwy
 TPZ5Ch+tkqqdpCShq/h8QdHCIlb4U6kiIK13g4sdiGDRR6Pfm4XVL9/gm1Y4+vD7WwOkc4El6+j
 JQBs/yBvAA9QftCJvzgg==
X-Received: by 2002:a17:902:cece:b0:2b0:5cb4:d89d with SMTP id
 d9443c01a7336-2b0827a7629mr99176775ad.29.1774210187733; 
 Sun, 22 Mar 2026 13:09:47 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083690346sm83915725ad.70.2026.03.22.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 13:09:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Ryan=20Pers=C3=A9e?= <ryan.persee@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] bootstd: efi: Handle prior-stage FDT in network path
Date: Sun, 22 Mar 2026 14:08:50 -0600
Message-ID: <20260322200856.1398442-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When CONFIG_OF_HAS_PRIOR_STAGE is enabled and fdtfile is not set,
efi_get_distro_fdt_name() returns -EALREADY to indicate the prior-stage
FDT should be used. The block-device EFI path handles this by setting
BOOTFLOWF_USE_PRIOR_FDT, but the network path treats it as an error,
causing the bootflow to stay in 'base' state with a -EALREADY error.

This also means fdt_addr_r is required even when no FDT download is
needed, giving a spurious  -EINVAL error.

Fix this by calling efi_get_distro_fdt_name() before checking
fdt_addr_r, and handling -EALREADY by setting BOOTFLOWF_USE_PRIOR_FDT
to skip the FDT download, matching the block-device behaviour.

THere is no test for this at present, since sandbox does not enable
CONFIG_OF_HAS_PRIOR_STAGE and lacks infra for network-based EFI boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_efi.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f592fec07f6..cbb392e1636 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -269,27 +269,29 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("fi0", -ENOMEM);
 
 	/* read the DT file also */
-	fdt_addr_str = env_get("fdt_addr_r");
-	if (!fdt_addr_str)
-		return log_msg_ret("fdt", -EINVAL);
-	fdt_addr = hextoul(fdt_addr_str, NULL);
-	sprintf(file_addr, "%lx", fdt_addr);
-
-	/* We only allow the first prefix with PXE */
 	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
-	if (ret)
+	if (ret == -EALREADY) {
+		bflow->flags |= BOOTFLOWF_USE_PRIOR_FDT;
+	} else if (ret) {
 		return log_msg_ret("nam", ret);
+	} else {
+		fdt_addr_str = env_get("fdt_addr_r");
+		if (!fdt_addr_str)
+			return log_msg_ret("fdt", -EINVAL);
+		fdt_addr = hextoul(fdt_addr_str, NULL);
+		sprintf(file_addr, "%lx", fdt_addr);
 
-	bflow->fdt_fname = strdup(fname);
-	if (!bflow->fdt_fname)
-		return log_msg_ret("fil", -ENOMEM);
+		bflow->fdt_fname = strdup(fname);
+		if (!bflow->fdt_fname)
+			return log_msg_ret("fil", -ENOMEM);
 
-	if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
-		bflow->fdt_size = env_get_hex("filesize", 0);
-		bflow->fdt_addr = fdt_addr;
-	} else {
-		log_debug("No device tree available\n");
-		bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
+		if (!do_tftpb(&cmdtp, 0, 3, tftp_argv)) {
+			bflow->fdt_size = env_get_hex("filesize", 0);
+			bflow->fdt_addr = fdt_addr;
+		} else {
+			log_debug("No device tree available\n");
+			bflow->flags |= BOOTFLOWF_USE_BUILTIN_FDT;
+		}
 	}
 
 	bflow->state = BOOTFLOWST_READY;
-- 
2.43.0

base-commit: eb00c710508d09b2a3b9aca75dd18280f1304703
branch: bootstd-fix-us
