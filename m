Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCAED591B7
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07950894D6;
	Mon, 18 Nov 2024 22:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grjk7FgV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ADA5894FB; Mon, 18 Nov 2024 22:09:58 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6563894AC
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2969dc28dafso647108fac.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964194; x=1732568994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6KK2Tc+BE4dbjhDhJAlOKoE8RGoAIBmihx1GYoQfrk=;
 b=grjk7FgVL5K5qshYPm2TzEN99l2Hy/YNQ+KWxP9oiyh6zzf4rb9JHM5OJE5BRnluzs
 rg8cEJNsjxV8zlsFfTVBOGdgLJXM+2dfEOUSyfrIRI3S9UJTVZ77RRfwBTMgqvvjQ1Mu
 R2M6UHqor1D9bgDTeJLxJJPblZ1MPRT3a0sUVGnKkfub683rVYj7DIjDH9z4TdYYdido
 U0JYf0tpeRMGve9cHvokSAZC9bGipRqExVRJbHYZuiQ46n/SeMjSpL66gcTNV2v9+EEC
 YoMyBaZcbi5VydHcZtu+9zGUb7YpzmjX5Mw2YS/iYUUc/hFXD8FeXO8JTMDHoe20VTET
 Vuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964194; x=1732568994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X6KK2Tc+BE4dbjhDhJAlOKoE8RGoAIBmihx1GYoQfrk=;
 b=FJBs6fEkrwiiAfUoBvWYY2nSlJSNn4jPaLxSL3P8QhFIfJiWesVb44XLTdnMFzFomp
 4epzrmCjBc69KxsKzvpROVHvHyfLbU+S/W9Ts0u0GcmercDloGf11J2H2wsBIgvan1ba
 enZurEvhGvqPbO/MquxWtuS53PG0wyuiQye2vhk93nP3+lFrN4a3YGYxdOKZAx+5IzFx
 InihzmmZF7OdSgSIw0YPu61ktziY9vpFgXWCRnFT+h6NN6qTsUbTfjqp6NeEXJIrNVOy
 gY/F+dAy92CnjkJnV80y5IuxKzPwlYFj+YuFR9HidMriZzOrlz7FYKAKUDIF9pZbVttt
 ZyUQ==
X-Gm-Message-State: AOJu0YweKq4J3i/KAr9CiqV/sZULmirrpMa4yMrlz8jAGs11OucQwXSJ
 TcAS5b6j0Nj//7fxEYXadBsffo2UfHciPnPMI8dgbdSaLj99aHxFWrNynRPO
X-Google-Smtp-Source: AGHT+IH6pAHtO+akZ/+xXGdUdKbfu84lKtSKZDUUdghvHqeV0vV7S7z6basrBZ28uQW3Z1HQJKWF2Q==
X-Received: by 2002:a05:6871:806:b0:288:39e7:b54 with SMTP id
 586e51a60fabf-2962deea5d2mr10021877fac.22.1731964194551; 
 Mon, 18 Nov 2024 13:09:54 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:54 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 14/14] efi_selftest: add test for IPv4 Config2 protocol
Date: Mon, 18 Nov 2024 18:09:08 -0300
Message-ID: <20241118210908.51196-15-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241118210908.51196-1-adrianox@gmail.com>
References: <20241118210908.51196-1-adrianox@gmail.com>
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

Add a test for the EFI_IP4_CONFIG2_PROTOCOL. The test sets the ip
policy to static, adds an ip address, and then reads the current
ip address and checks for it to be the same as the one that was set.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v4:
- Removed unnecessary void* casts

(no changes since v2)
 lib/efi_selftest/Makefile                |   2 +
 lib/efi_selftest/efi_selftest_ipconfig.c | 170 +++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 140c08effc..17fbfad116 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -53,6 +53,8 @@ efi_selftest_watchdog.o
 obj-$(CONFIG_EFI_ECPT) += efi_selftest_ecpt.o
 obj-$(CONFIG_NETDEVICES) += efi_selftest_snp.o
 obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_http.o
+obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_selftest_ipconfig.o
+
 obj-$(CONFIG_EFI_DEVICE_PATH_TO_TEXT) += efi_selftest_devicepath.o
 obj-$(CONFIG_EFI_UNICODE_COLLATION_PROTOCOL2) += \
 efi_selftest_unicode_collation.o
diff --git a/lib/efi_selftest/efi_selftest_ipconfig.c b/lib/efi_selftest/efi_selftest_ipconfig.c
new file mode 100644
index 0000000000..67a7d4f411
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_ipconfig.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * efi_selftest_ipconfig
+ *
+ * This unit test covers the IPv4 Config2 Protocol.
+ *
+ */
+
+#include <efi_selftest.h>
+#include <charset.h>
+#include <net.h>
+
+static struct efi_boot_services *boottime;
+
+static struct efi_ip4_config2_protocol *ip4_config2;
+static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
+
+/*
+ * Setup unit test.
+ *
+ * Open IPv4 Config2 protocol
+ *
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	efi_status_t ret;
+	efi_handle_t *net_handle;
+	efi_uintn_t num_handles;
+	efi_handle_t *handles;
+
+	boottime = systable->boottime;
+
+	boottime->locate_handle_buffer(BY_PROTOCOL, &efi_ip4_config2_guid,
+				       NULL, &num_handles, &handles);
+
+	for (net_handle = handles; num_handles--; net_handle++) {
+		ret = boottime->open_protocol(*net_handle, &efi_ip4_config2_guid,
+					      (void **)&ip4_config2, 0, 0,
+					      EFI_OPEN_PROTOCOL_GET_PROTOCOL);
+		if (ret != EFI_SUCCESS || !ip4_config2)
+			continue;
+		break; // Get first handle that supports ipv4
+	}
+
+	if (!ip4_config2) {
+		efi_st_error("Failed to locate ipv4 config2 protocol\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Execute unit test.
+ *
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int execute(void)
+{
+	efi_status_t ret;
+	enum efi_ip4_config2_policy policy;
+	efi_uintn_t data_size;
+	struct efi_ip4_config2_manual_address manual_address;
+	struct efi_ip4_config2_manual_address orig_address;
+	u8 netmask[] = {255, 255, 255, 0};
+	u8 ip[] = {10, 0, 0, 1};
+
+	/* Setup may have failed */
+	if (!ip4_config2) {
+		efi_st_error("Setup failure, cannot proceed with test\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Set policy to static */
+	policy = EFI_IP4_CONFIG2_POLICY_STATIC;
+	ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_POLICY,
+			      sizeof(enum efi_ip4_config2_policy), (void *)&policy);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to set policy\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Save original ip address and netmask */
+	data_size = sizeof(struct efi_ip4_config2_manual_address);
+	ret = ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
+			      &data_size, &orig_address);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to save original ip address and netmask\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Set static ip and netmask */
+	memcpy(&manual_address.address, ip,
+	       sizeof(struct efi_ipv4_address));
+	memcpy(&manual_address.subnet_mask, netmask,
+	       sizeof(struct efi_ipv4_address));
+	ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
+			      sizeof(struct efi_ip4_config2_manual_address), &manual_address);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to get ip address and netmask\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Try to set interface info, this should fail */
+	ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO, 0, NULL);
+	if (ret == EFI_SUCCESS) {
+		efi_st_error("Interface info is read-only\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Get ip address and netmask and check that they match with the previously set ones */
+	data_size = sizeof(struct efi_ip4_config2_manual_address);
+	ret = ip4_config2->get_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
+			      &data_size, &manual_address);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to get ip address and netmask\n");
+		return EFI_ST_FAILURE;
+	}
+	if (memcmp(ip, &manual_address.address,
+		   sizeof(struct efi_ipv4_address)) ||
+	    memcmp(netmask, &manual_address.subnet_mask,
+		   sizeof(struct efi_ipv4_address))) {
+		efi_st_error("Ip address mismatch\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Restore original ip address and netmask */
+	ret = ip4_config2->set_data(ip4_config2, EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS,
+			      sizeof(struct efi_ip4_config2_manual_address), &orig_address);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Failed to restore original ip address and netmask\n");
+		return EFI_ST_FAILURE;
+	}
+
+	efi_st_printf("Efi ipconfig test execute succeeded\n");
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Tear down unit test.
+ *
+ * Return:	EFI_ST_SUCCESS for success
+ */
+static int teardown(void)
+{
+	int exit_status = EFI_ST_SUCCESS;
+
+	return exit_status;
+}
+
+EFI_UNIT_TEST(ipconfig) = {
+	.name = "IPv4 config2 protocol",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+	.teardown = teardown,
+#ifdef CONFIG_SANDBOX
+	/*
+	 * Running this test on the sandbox requires setting environment
+	 * variable ethact to a network interface connected to a DHCP server and
+	 * ethrotate to 'no'.
+	 */
+	.on_request = true,
+#endif
+};
-- 
2.43.0

