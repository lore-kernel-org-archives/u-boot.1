Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D5D3E787
	for <u-boot@archiver.kernel.org>; Sun, 14 Dec 2025 11:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD2F8036B;
	Sun, 14 Dec 2025 12:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LrRn5Qlb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A8A80433; Sun, 14 Dec 2025 12:09:46 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F4E180107
 for <u-boot@lists.denx.de>; Sun, 14 Dec 2025 12:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D11563F7CF; 
 Sun, 14 Dec 2025 11:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765710584;
 bh=JqP5aEVDrh23rJWHV8ePCEBMTveOurTJmXD3srxzeHw=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LrRn5QlbXdfaG6RxNrZ7l816JF9GBYZwu+fDOQZW6vAPS4M1Imbt2XytLNywT3OOT
 hpd/Vjhse2TaVPCY/RFMpRPgVjqStbu582/g/pamT+rbunjQy9SbX5MvuvK49savdx
 k6q/C/3cZecyfJpgCKGBDtYphf0GGfrEC6kY+j4z3PfpUSjbaZnU++Dq1UWHHBAEFh
 zTCx9MjmtTCj7OaqbToog+dHo9IdX/VktCqMroPTw0jHtScvore9qwioFXc6SARmf0
 mgsiQtXWIBXnhAr7mSGw+9MfEzck3eLizG6dWkwjgQjBkVDDNKW5kMWY7k3mU2AucT
 zuyZHzaxd71+6QNahuVX1W811MKmb1e4cC7d3Su+FaN3GH0O0y9YkwgW26QntxIC/r
 zy+ln8Z9XGoJub6jmxBYhwiqySFH+z6wJEJG5EbpjRFV/y4ukGZrUT0vY/R14OGyQd
 V+IaSEz988zrq+G6TECZM0xv/630kDDB40UD9dQp1ASVZ++Km0YPfn3YPlTggiakXu
 2wZsNh6/GpRC5wG+AobVNsjg1W5GbuApFl1GSizSVAM4837S7o7wlr1Xob5GcumCDh
 ynK/5bW6YShzN8oZhUoYdsEKbXU55Wgu4BCtgs4l7QJyHoIxqdJve7i2ZRmBqzxdUM
 bQkjxhlEEl/k+5pGYOIAst+4=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: enhance LoadImage test
Date: Sun, 14 Dec 2025 12:09:37 +0100
Message-ID: <20251214110937.136425-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Check that only a file-system installed on a handle for thethe
device-patch node immediately preceding the file path node is
used for LoadImage().

The test can be run with

    setenv efi_selftest load image from file
    bootefi selftest

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
The addtional test succeeds with current U-Boot but fails
after applying

[PATCH v2] efi_loader: Trigger capsule updates with automatically generated boot options
https://lore.kernel.org/u-boot/20251208151503.1681988-1-ilias.apalodimas@linaro.org/
---
 lib/efi_selftest/efi_selftest_loadimage.c | 45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_loadimage.c b/lib/efi_selftest/efi_selftest_loadimage.c
index 24548f1ae63..967eaa58c69 100644
--- a/lib/efi_selftest/efi_selftest_loadimage.c
+++ b/lib/efi_selftest/efi_selftest_loadimage.c
@@ -125,6 +125,44 @@ static struct {
 	}
 };
 
+/* Incorrect file device path */
+static struct {
+	struct efi_device_path_vendor vendor;
+	struct efi_device_path_controller ctrl;
+	struct efi_device_path path;
+	u16 file[sizeof(FILE_NAME)];
+	struct efi_device_path end;
+} __packed dp_file2 = {
+	.vendor = {
+		.dp = {
+			.type =	DEVICE_PATH_TYPE_HARDWARE_DEVICE,
+			.sub_type = DEVICE_PATH_SUB_TYPE_VENDOR,
+			.length = sizeof(struct efi_device_path_vendor),
+		},
+		.guid = EFI_GUID(0x4f9a0ebf, 0xa179, 0x88a6, 0x25, 0x68,
+				 0x10, 0x72, 0xb1, 0x93, 0x51, 0x71),
+	},
+	.ctrl = {
+		.dp = {
+			.type =	DEVICE_PATH_TYPE_HARDWARE_DEVICE,
+			.sub_type = DEVICE_PATH_SUB_TYPE_CONTROLLER,
+			.length = sizeof(struct efi_device_path_controller),
+		},
+		.controller_number = 1,
+	},
+	.path = {
+		.type = DEVICE_PATH_TYPE_MEDIA_DEVICE,
+		.sub_type = DEVICE_PATH_SUB_TYPE_FILE_PATH,
+		.length = sizeof(struct efi_device_path) + sizeof(dp_file.file),
+	},
+	.file = FILE_NAME,
+	.end = {
+		.type = DEVICE_PATH_TYPE_END,
+		.sub_type = DEVICE_PATH_SUB_TYPE_END,
+		.length = sizeof(struct efi_device_path),
+	}
+};
+
 /* File system info */
 static struct file_system_info priv_file_system_info = {
 	{
@@ -517,6 +555,13 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
+	ret = boottime->load_image(false, handle_image, &dp_file2.vendor.dp,
+				   NULL, 0, &handle);
+	if (ret == EFI_SUCCESS) {
+		efi_st_error("Invalid file path accepted\n");
+		return EFI_ST_FAILURE;
+	}
+
 	return EFI_ST_SUCCESS;
 }
 
-- 
2.51.0

