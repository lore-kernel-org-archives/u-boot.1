Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD8D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 10:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4EB838FA;
	Tue,  9 Dec 2025 11:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Im2dGwPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FE7C83B81; Tue,  9 Dec 2025 11:49:23 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23DB83849
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 11:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso45269145e9.2
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765277360; x=1765882160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D21JmQnHH/ZFq2PVSa9iuVobtoB8rmUlRLwualAX038=;
 b=Im2dGwPiMH814hfJx2iGs90qbJdxvNQizn3MhI9tzqMCXYWghyRbfbA1tGG9CE6oby
 vqQcDvYKSnkGaMTetoVf5iWAdyzuMXecfNvNP7zl1BsNjUbx7MeUvMU2HgQmyLCFMyha
 5XRZ80cIndxcdUurxJNkNnVtaQhiF3eARsDIwSmRn3j79c3VWsLPlSk4HExXMxV7DQPu
 jxuFcj9FRdA07iXzp+ei+TZuOe4wEIjynVmlGzSpdojWbm+nOqMVCpgvO1nm27y2Yjrq
 StkYP7WHCGUjGFt9DHqtibyyqKlhcQT2ncFMxOXu6kbrK1gqz1IfzVLKEThckj39pC1V
 Vd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765277360; x=1765882160;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D21JmQnHH/ZFq2PVSa9iuVobtoB8rmUlRLwualAX038=;
 b=l9jCuw3TvhEAl2ITXWavPyjJ2SsUYNa9Cti7JuYlJVi2Fu1vj7YFQxXk2OJ7tubTCq
 yN9s5geOH86/kHNFUqAqDYWeT5vNPmCJaQlhVmCnytCdCxoZ7hlimog9gQE4xrPOeZa3
 MlE2zL8GhLM1hBWiB8y7EiKExnORQlpfMiLKzKAPncm1dcPuvkCUAXHutILOroU0xT2T
 Wmkuu5dLHbhN25bIrVsRtTNmcdUNLiGglCAOKR1I+ftJ9A4ECl89z7lrphvcKFilAckA
 nDG3aocIO2gozfmORflZMhjcefttV5XiuaesZ9zq4JHiowvtFfIzyO4bW/0ZwFcsALnr
 7aAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT9jFEtL/BdsRtZIKadmRmKRbH9WFf1wvJ2vYCwL07S0kCqn0cD9VNs7dBCnT6q2aetskU4VE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8p8PvKRO2S0arOjIC+d68b1KwAFKocTCrOYMMXgFUI0CfZKni
 3alYEFtHnZG2oy4w6v9bzQKUof5YJGcdarHLm6gyrFYP+pYDTRL4xf7bhUJvYrL86Vg=
X-Gm-Gg: ASbGncuiExoWAb4qMGDLKLOdEYajqoEPOAZwWKBnVrnhfd5cjK5KXBtqPmbeYkouXwC
 31i7Bi1Bl7IvqhH6jPgZtOjd1hNVEnPWL5NR2I0zLqYt3JqV8MROQS+TbRin3UQ+s2BvPdDCfzs
 ZFiHoYu9FLSlV6Q93UmyQyXWWS3G1tT+LGzoi+ETiJ4t7pkprXDcsdN9h0RRzPxCq850IIwPP5s
 XJkGlq2NSr9x5lS0Hm7Krfgldc8Ngd1CQ9EX8gEIfs7U7CTIdrkyOwwWtKFSbiTK1dGZjzUHR/+
 QKF5E0ANK7+AVTjI2vVs3YW0HKFrIrhTM7CW1OOVobDZXYgpfqiCFb9rXLa9RnMx795QBFvScVC
 aj9CMZ70XUvct/Ve9R0Y1ld3BLAwQZDqRrJ1M2XkfxI+oNR1mB+tLtjy+3bbzfb0RNMQnMAd5J2
 ads6w78fTjoBuuGpYeTbOc2vuqs9HKU83D6Zs/+TSiFqiT/fh/rJAiiAFNOyqd8qBQQlipXw+Yq
 5bYFd1zyKycA9kpjGYn+DF987uO/g==
X-Google-Smtp-Source: AGHT+IEO+6yaWn6SbGQ/FFEfStv9nU6gBdv/NnXAn9wnlM/U75KAWXF1csqdSo97S+zN+/w2fSGBqA==
X-Received: by 2002:a05:600c:d8:b0:479:3a89:121d with SMTP id
 5b1f17b1804b1-4793a891252mr76396185e9.36.1765277359867; 
 Tue, 09 Dec 2025 02:49:19 -0800 (PST)
Received: from hades.. ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6228basm32146525e9.4.2025.12.09.02.49.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 02:49:19 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com,
	andrew.goodbody@linaro.org
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Add tests for efi_dp_find_obj()
Date: Tue,  9 Dec 2025 12:49:08 +0200
Message-ID: <20251209104910.1801409-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

We recently changed efi_dp_find_obj() and extended it's matching patterns.
The function used to try and match device paths that are only an exact
match or shorter than the provided one. It can now match device paths
that are longer, but we have no selftests for it.

Start by adding basic testing.  Install a device path on a dummy handle
that contains
- Vendor GUID
- NVME
- partition
- file

and try to find an exact match, a match if longer matches are not
allowed and a longer match if longer matches are allowed.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Heinrich, I understand that is not covering all use cases, but it's a start
Andrew (cc'ed) will add
- A second longer device path to make sure we match the longest one
- Multiple ESPs and partitions to test device_has_esp() as described
  in https://lore.kernel.org/u-boot/20251208151503.1681988-1-ilias.apalodimas@linaro.org/

 test/lib/efi_device_path.c | 106 +++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/test/lib/efi_device_path.c b/test/lib/efi_device_path.c
index 5a358ddcb934..483546b2224c 100644
--- a/test/lib/efi_device_path.c
+++ b/test/lib/efi_device_path.c
@@ -10,6 +10,66 @@
 #include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
+#include <mapmem.h>
+
+#define FILE_NAME_SIZE 16
+#define GUID_VENDOR \
+	EFI_GUID(0xdbca4c99, 0x6db1, 0x694d, \
+		 0x08, 0x75, 0x82, 0x9b, 0x64, 0xf1, 0xbc, 0xd1)
+
+static struct {
+	struct efi_device_path_vendor vendor;
+	struct efi_device_path_nvme nvme;
+	struct efi_device_path_hard_drive_path part;
+	struct efi_device_path_file_path file;
+	u16 file_name[FILE_NAME_SIZE];
+	struct efi_device_path end;
+} dp1 = {
+	{
+		{
+			DEVICE_PATH_TYPE_HARDWARE_DEVICE,
+			DEVICE_PATH_SUB_TYPE_VENDOR,
+			sizeof(struct efi_device_path_vendor),
+		},
+		GUID_VENDOR,
+	},
+	{
+		{
+			DEVICE_PATH_TYPE_MESSAGING_DEVICE,
+			DEVICE_PATH_SUB_TYPE_MSG_NVME,
+			sizeof(struct efi_device_path_nvme),
+		},
+		1,
+		{0, 1, 2, 3, 4, 5, 6, 7},
+	},
+	{
+		{
+			DEVICE_PATH_TYPE_MEDIA_DEVICE,
+			DEVICE_PATH_SUB_TYPE_HARD_DRIVE_PATH,
+			sizeof(struct efi_device_path_hard_drive_path),
+		},
+		5,
+		0,
+		1024,
+		{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
+		2,
+		2,
+	},
+	{
+		{
+			DEVICE_PATH_TYPE_MEDIA_DEVICE,
+			DEVICE_PATH_SUB_TYPE_FILE_PATH,
+			sizeof(struct efi_device_path_file_path) +
+			       FILE_NAME_SIZE * sizeof(u16),
+		},
+	},
+	u"\\test_image.efi",
+	{
+		DEVICE_PATH_TYPE_END,
+		DEVICE_PATH_SUB_TYPE_END,
+		sizeof(struct efi_device_path),
+	},
+};

 static int lib_test_efi_dp_check_length(struct unit_test_state *uts)
 {
@@ -47,3 +107,49 @@ static int lib_test_efi_dp_check_length(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_test_efi_dp_check_length, 0);
+
+static int lib_test_efi_obj_find(struct unit_test_state *uts)
+{
+	static efi_handle_t dummy_handle, handle;
+	struct efi_device_path *device, *image;
+	efi_status_t ret;
+
+	ret = efi_install_multiple_protocol_interfaces(&dummy_handle,
+						       &efi_guid_device_path,
+						       &dp1,
+						       NULL);
+	ut_assertok(ret);
+
+	ret = efi_dp_split_file_path((struct efi_device_path *)&dp1, &device,
+				     &image);
+	ut_assertok(ret);
+
+	/* find handle by exact match */
+	handle = efi_dp_find_obj((struct efi_device_path *)&dp1, NULL, NULL,
+				 false);
+	ut_asserteq_addr(handle, dummy_handle);
+
+	/*
+	 * Try to find handle by partial match if the dp is smaller while not
+	 * allowing matching for longer device paths discovered
+	 */
+	handle = efi_dp_find_obj(device, NULL, NULL, false);
+	ut_assertnull(handle);
+
+	/* find handle by partial match if the dp is smaller */
+	handle = efi_dp_find_obj(device, NULL, NULL, true);
+	ut_asserteq_addr(handle, dummy_handle);
+
+	ret = efi_uninstall_multiple_protocol_interfaces(dummy_handle,
+							 &efi_guid_device_path,
+							 &dp1,
+							 NULL);
+	ut_assertok(ret);
+
+	efi_free_pool(device);
+	efi_free_pool(image);
+
+	return 0;
+}
+
+LIB_TEST(lib_test_efi_obj_find, 0);
--
2.43.0

