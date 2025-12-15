Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C25D5B16E
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 12:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6BF80050;
	Mon, 15 Dec 2025 13:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nc/IonbK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D837B800D0; Mon, 15 Dec 2025 13:44:09 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7171F8003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 13:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E01093F1F0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765802645;
 bh=HYNkRuc4Bpba3uTkldcTULlcRyPP9GRA/TWJR5CR5/U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=nc/IonbKQpXCJ9WtzAYFI8vl1kjbImraCcGT3Yl8CGxuS2C7yrqHs3k0L27kjGQ/f
 OhThJfZwP/q1ZS5l8i/Fcs6BKMpFtQYc85Yw9xsyIvGBCSk3j/LBJdZZ2nOrNSFTtI
 BPnZxakLYEWvn+/I/YajauTqlrQUJ11i/LoFQwctY1iIHSmC96T0za2Z3yRCUup7M+
 EKSyY0VGqVzmABCds1if0CUL87lQ29L3oSz4Rg56d4kT9iolrjVFi348StYTlX8bmV
 fD8Lk/VWkG0nBW+rvaelSkWTImQg5N/ppglO3JbdKStGRlF89DHzSL7lmAfr/ubmng
 H7HjSL0wzw6iKk6eY0BwCphbmO5XYkV5raXcsopW8I0Myck6R/uGt11sAvhwkXfutP
 6ffccVfX87ID2FqI3qLHwdyOkPbWQbA4qmbhAhG7r5O8m0/WC/jsjWwrTgJ1qM0U4S
 uLgyK9lk4sMQkYJPQUCSOFCJo0/ZXOqCh5p7uFrdUxBpwdwqlMi3z+4ymUD2e2yVuV
 c2KKo2JruriTY1iPuRbhMEBe2pkTWz00LVa6nh/D/atFJ9yI/u4+UJqqJrlLiTJYiN
 FCtKkc3I7bLq7T2lwIGZKwZIBsVJN/ovkFtWCO1w4GFR4bW725Ufo0V/5Vsk7xviPK
 R59Khz9OhPmKnQTjgSvIRF+c=
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso17772335e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 04:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765802645; x=1766407445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYNkRuc4Bpba3uTkldcTULlcRyPP9GRA/TWJR5CR5/U=;
 b=F2edYVCF8KYectuFVw0z4xIZRykgcOVzU/2OMcD5iIJqU7288ZPqH1RwPNL1hjJ5fo
 BhHhjlRBA+WVMInzhOo6a3yPtI6QpJrwGbzywhJ6ND45VSKGRlTpXEfG5K2yC+C4QCCW
 96eBBISzGaLptaxHgS8uuqWXK3OZ35lUlI91KzzBLgMukatCnYoXNxZdK8d98A1EhGBQ
 kKg4Lb6MUsOUyOXf9eemfLzCt+3ptVP3yKJITT3AeT4tlAqTk8K+kzB+OA+WJMYX92OF
 VIRv1//dHQDCpNOtQiHKXnRitA19tAaC/3hJ7FXt9/H1ijvbAvdYAZzYfctbK3Wlk/3Q
 QT1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqF7ptNMgVhQN16Rlk49wvMeTFUUExG1NH1uXO5CWB9ZBqNlcTmDYBAmuG1pyNsm9c1mRfNhk=@lists.denx.de
X-Gm-Message-State: AOJu0YyXewzfcJuQuz/toMLswfsygEvpZc6/MqQhh0GKukiEduSmhfE6
 m0A3pc/RSkY+xI81AqVpIv2909TZr/r9O8Li+2MQJ61bwoCoouf1RjDE8RzP+U6l3n3ElM+5J3Z
 9EFBeGKEEqVIacGC5BuaTm0uVi2NsNNWIVibEFKPVVTvw1hZOSVn0wV++4XbBdD3LpXRXAGW5rC
 16AJk=
X-Gm-Gg: AY/fxX5+qCuUfz8mjkXvM7NJ7NtSTE//QZL/C6Qj3u7U8LzSjG6Ed/0dvFPddOhzGW+
 zU5TVVOOI2FwndivIQfeDhDtp12a7aQj3ZdqitKJGjGXy3ShNFPYR/er8EuJmaGo+h1e42lLOnC
 k2fFNJpmy547fFBEBMlIkFfiAWHYayGrVlxlHJKbiaCyEt+Q1cNieeihUTT+asMGOx5O0gyqzOS
 tmGE56miwWP0U1E0a4gilc0z2PjnxDjxCrhGxCIhwTQauhrkTVDpEB1kicR4eZ7fzOvGebiJjxz
 piHQbELjofv4NMcVhJvuTEn91w/Hf/pgxAqC3YUHsWDnr7VKLbdtv/FZRPydbB129hT2fwE7PdN
 UbedLGEnCdoS1JyU3c86dnRv42LhOMvjTmXAoSuC6SevTFz4nwYoeTM7+eDGDmqMojY/mSPaA1j
 6U
X-Received: by 2002:a05:600c:3b87:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47a8f8c1946mr152143515e9.15.1765802645253; 
 Mon, 15 Dec 2025 04:44:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxTRPKMeZ4qF2S9weympK1pEi6QV7IlXWVStPK15+6Qx0o2DSjDnEGlbtVHNqTGy/u3vzqnw==
X-Received: by 2002:a05:600c:3b87:b0:471:9da:5232 with SMTP id
 5b1f17b1804b1-47a8f8c1946mr152143185e9.15.1765802644866; 
 Mon, 15 Dec 2025 04:44:04 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6f26ebsm191788265e9.14.2025.12.15.04.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 04:44:04 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] efi_selftest: Enhance LoadImage test
Date: Mon, 15 Dec 2025 13:42:51 +0100
Message-ID: <20251215124251.18482-1-heinrich.schuchardt@canonical.com>
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

Check that only a file system installed on a handle for the
device-path node immediately preceding the file path node is
used for LoadImage().

LoadImage() ends up invoking efi_dp_find_obj(). This test helped to
demonstrate an issue in a suggested patch to change that function.

The test can be run with:

    setenv efi_selftest load image from file
    bootefi selftest

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	update commit message
	- fix typos
	- refer to efi_dp_find_obj()
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

