Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BC0D5C0C4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E79CB89263;
	Fri,  8 Nov 2024 14:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FS+hgBMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F77988C86; Fri,  8 Nov 2024 04:47:37 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FC288B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-290ff24354dso832389fac.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037653; x=1731642453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UUYPcOoDLNwtR/HMM/W9X6o122Kbhz1rAZhklWpyZL4=;
 b=FS+hgBMXJTYC//JHZbIdDopOBzIa3UvanLGYyeGZMtfxzW30MuJRQnp5ldgIE/XB61
 nEdxNTciQMreguFETgis3ZBfIlcmnA+UpdoaFytDevhfsxgId0K3yLnlegtxtfXyvm3J
 QlAOZaLqgW4oGpWgoUzcYF6wR1ziQ+w5iouA4CWHweog7sjz1DTJ5SXvS+Bie7edZIa0
 BeKj+aVjaubqN5bbi3fApuxtG/6jwXTaRQiJsutwarmirAYpEXfdQP9WS1IgMxqiEkJK
 H6BmdjRSCLVrRAyr8aVpUXQJTisQZxstkR5CI5Lt9Qs+/kPNT6mJe2vH3XIRsxIXG/Ao
 uGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037653; x=1731642453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUYPcOoDLNwtR/HMM/W9X6o122Kbhz1rAZhklWpyZL4=;
 b=VO5NRN0gxZwY39RGPgWhUgJp6fcr/gd+hli0arb3zcocB2hP5ZBMt9KDh8w+FtdAj/
 6htByXhW9QKM42mkTf6P0ZidGpdAOVe6YZ7MT5+t11XLPtWJNQcFboo6tik2LfIGgHIW
 V3czUukImu3ojF0TaWr3lP2XSSt8SKmn3cLRo/F1PtFTFywdiETOzxb6TMaKbQluPuBE
 bb61QbzC3GOWyhcTH2ahyqO8ynMbcumykoDWX8O6Q6eBsHhPc3KgtumvTOoLV7EayndQ
 sy8yHinUDgmQn76qHsxlSWaeShRKfcMbfNJAgHhyHZf/BvpVLjd63u1QX3Ba5AG0J31E
 7asw==
X-Gm-Message-State: AOJu0YxdyXgGKejuRNe5eEriUdU2OxMpUM8G3mud/3+XnwMZJ5YUHauP
 p8l1NpMJ4bsyYpvdORPFu2soCzinUDzofuzUFVApzqLvX716d9UzLpbigFk9/68=
X-Google-Smtp-Source: AGHT+IHwS9mseYKz7bT5Bf2NQFygi/ykilD/PyYNCZzAzXIpYmKB9cHqRRNjzW/exAckhYUXaV3lHw==
X-Received: by 2002:a05:6870:a54b:b0:270:1dab:64a9 with SMTP id
 586e51a60fabf-2956010ac12mr1575229fac.14.1731037653269; 
 Thu, 07 Nov 2024 19:47:33 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724079aaa01sm2632269b3a.100.2024.11.07.19.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:47:32 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 11/15] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
Date: Fri,  8 Nov 2024 00:47:27 -0300
Message-ID: <20241108034727.346465-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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

Add an implementation of the EFI_IP4_CONFIG2_PROTOCOL. The protocol
is attached to the handle of the efi network device. This is the same
handle where snp and pxe are attached to.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_loader.h          |   3 +
 lib/efi_loader/Kconfig        |   9 ++
 lib/efi_loader/Makefile       |   1 +
 lib/efi_loader/efi_ipconfig.c | 216 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_net.c      |  20 +++-
 5 files changed, 244 insertions(+), 5 deletions(-)
 create mode 100644 lib/efi_loader/efi_ipconfig.c

diff --git a/include/efi_loader.h b/include/efi_loader.h
index a19505d4cc..216b2a9d00 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -627,6 +627,9 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
 efi_status_t efi_gop_register(void);
 /* Called by bootefi to make the network interface available */
 efi_status_t efi_net_register(void);
+/* Called by efi_net_register to make the ip4 config2 protocol available */
+efi_status_t efi_ipconfig_register(const efi_handle_t handle,
+				   struct efi_ip4_config2_protocol *ip4config);
 /* Called by bootefi to make the watchdog available */
 efi_status_t efi_watchdog_register(void);
 efi_status_t efi_initrd_register(void);
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 066f0ca0da..36377487f3 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -476,6 +476,15 @@ config EFI_RISCV_BOOT_PROTOCOL
 	  replace the transfer via the device-tree. The latter is not
 	  possible on systems using ACPI.
 
+config EFI_IP4_CONFIG2_PROTOCOL
+	bool "EFI_IP4_CONFIG2_PROTOCOL support"
+	default y
+	depends on NET || NET_LWIP
+	help
+	  Provides an implementation of the EFI_IP4_CONFIG2_PROTOCOL, this
+	  protocol can be used to set and get the current ip address and
+	  other network information.
+
 endmenu
 
 menu "Misc options"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 00d18966f9..0c7e8cfeb8 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -58,6 +58,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
 obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
+obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
new file mode 100644
index 0000000000..4853b2b05d
--- /dev/null
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Implementation of EFI_IP4_CONFIG2_PROTOCOL
+ *
+ */
+
+#include <efi_loader.h>
+#include <image.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+
+static const efi_guid_t efi_ip4_config2_guid = EFI_IP4_CONFIG2_PROTOCOL_GUID;
+
+struct efi_ip4_config2_manual_address current_http_ip;
+static enum efi_ip4_config2_policy current_policy;
+static char current_mac_addr[32];
+
+/* EFI_IP4_CONFIG2_PROTOCOL */
+
+/*
+ * efi_ip4_config2_set_data() -  Set the configuration for the EFI IPv4 network
+ * stack running on the communication device
+ *
+ * This function implements EFI_IP4_CONFIG2_PROTOCOL.SetData()
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @data_type:		the type of data to set
+ * @data_size:		size of the buffer pointed to by data in bytes
+ * @data:		the data buffer to set
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_ip4_config2_set_data(struct efi_ip4_config2_protocol *this,
+						    enum efi_ip4_config2_data_type data_type,
+						    efi_uintn_t data_size,
+						    void *data)
+{
+	EFI_ENTRY("%p, %d, %zu, %p", this, data_type, data_size, data);
+	efi_status_t ret = EFI_SUCCESS;
+
+	if (!this)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	switch (data_type) {
+	case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
+		return EFI_EXIT(EFI_WRITE_PROTECTED);
+	case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
+		if (current_policy != EFI_IP4_CONFIG2_POLICY_STATIC)
+			return EFI_EXIT(EFI_WRITE_PROTECTED);
+		if (data_size == 0 && !data) {
+			memset((void *)&current_http_ip, 0,
+			       sizeof(struct efi_ip4_config2_manual_address));
+			return EFI_EXIT(EFI_SUCCESS);
+		}
+		if (data && data_size == sizeof(struct efi_ip4_config2_manual_address)) {
+			memcpy((void *)&current_http_ip, data,
+			       sizeof(struct efi_ip4_config2_manual_address));
+			efi_net_set_addr(&current_http_ip.address,
+					 &current_http_ip.subnet_mask, NULL);
+			return EFI_EXIT(EFI_SUCCESS);
+		}
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+	case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
+			if (data && data_size == sizeof(enum efi_ip4_config2_policy)) {
+				current_policy = *(enum efi_ip4_config2_policy *)data;
+				return EFI_EXIT(EFI_SUCCESS);
+			}
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	default:
+		return EFI_EXIT(EFI_UNSUPPORTED);
+	}
+
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_ip4_config2_get_data() -  Get the configuration for the EFI IPv4 network
+ * stack running on the communication device
+ *
+ * This function implements EFI_IP4_CONFIG2_PROTOCOL.GetData()
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @data_type:		the type of data to get
+ * @data_size:		size
+ * @data:		the data buffer
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_ip4_config2_get_data(struct efi_ip4_config2_protocol *this,
+						    enum efi_ip4_config2_data_type data_type,
+						    efi_uintn_t *data_size,
+						    void *data)
+{
+	EFI_ENTRY("%p, %d, %p, %p", this, data_type, data_size, data);
+
+	efi_status_t ret = EFI_SUCCESS;
+	struct efi_ip4_config2_interface_info *info;
+	int tmp;
+
+	if (!this || !data_size)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	if (*data_size && !data)
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	tmp = sizeof(struct efi_ip4_config2_interface_info) + sizeof(struct efi_ip4_route_table);
+
+	switch (data_type) {
+	case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
+		if (*data_size < tmp) {
+			*data_size = tmp;
+			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
+		}
+
+		info = (struct efi_ip4_config2_interface_info *)data;
+		memset(info, 0, sizeof(struct efi_ip4_config2_interface_info));
+
+		info->hw_address_size = 6;
+		memcpy(info->hw_address.mac_addr, current_mac_addr, 6);
+		// Set the route table size
+
+		info->route_table_size = 0;
+		break;
+	case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
+		if (*data_size < sizeof(struct efi_ip4_config2_manual_address)) {
+			*data_size = sizeof(struct efi_ip4_config2_manual_address);
+			return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
+		}
+
+		efi_net_get_addr(&current_http_ip.address, &current_http_ip.subnet_mask, NULL);
+		memcpy(data, (void *)&current_http_ip,
+		       sizeof(struct efi_ip4_config2_manual_address));
+
+		break;
+	default:
+		return EFI_EXIT(EFI_UNSUPPORTED);
+	break;
+	}
+	return EFI_EXIT(ret);
+}
+
+/*
+ * efi_ip4_config2_register_notify() -  Register an event that is to be signaled whenever
+ * a configuration process on the specified configuration
+ * data is done
+ *
+ * This function implements EFI_IP4_CONFIG2_PROTOCOL.RegisterDataNotify()
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @data_type:		the type of data to register the event for
+ * @event:		the event to register
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_ip4_config2_register_notify(struct efi_ip4_config2_protocol *this,
+							   enum efi_ip4_config2_data_type data_type,
+							   struct efi_event *event)
+{
+	EFI_ENTRY("%p, %d, %p", this, data_type, event);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/*
+ * efi_ip4_config2_unregister_notify() -  Remove a previously registered eventfor
+ * the specified configuration data
+ *
+ * This function implements EFI_IP4_CONFIG2_PROTOCOL.UnregisterDataNotify()
+ * See the Unified Extensible Firmware Interface
+ * (UEFI) specification for details.
+ *
+ * @this:		pointer to the protocol instance
+ * @data_type:		the type of data to remove the event for
+ * @event:		the event to unregister
+ * Return:		status code
+ */
+static efi_status_t EFIAPI efi_ip4_config2_unregister_notify(struct efi_ip4_config2_protocol *this,
+							     enum efi_ip4_config2_data_type data_type,
+							     struct efi_event *event)
+{
+	EFI_ENTRY("%p, %d, %p", this, data_type, event);
+
+	return EFI_EXIT(EFI_UNSUPPORTED);
+}
+
+/**
+ * efi_ipconfig_register() - register the ip4_config2 protocol
+ *
+ */
+efi_status_t efi_ipconfig_register(const efi_handle_t handle,
+				   struct efi_ip4_config2_protocol *ip4config)
+{
+	efi_status_t r = EFI_SUCCESS;
+
+	r = efi_add_protocol(handle, &efi_ip4_config2_guid,
+			     ip4config);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+
+	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
+
+	ip4config->set_data = efi_ip4_config2_set_data;
+	ip4config->get_data = efi_ip4_config2_get_data;
+	ip4config->register_data_notify = efi_ip4_config2_register_notify;
+	ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
+
+	return EFI_SUCCESS;
+failure_to_add_protocol:
+	printf("ERROR: Failure to add protocol\n");
+	return r;
+}
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 43b57b63d5..015b6a7cc1 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -48,11 +48,12 @@ static struct efi_event *wait_for_packet;
 /**
  * struct efi_net_obj - EFI object representing a network interface
  *
- * @header:	EFI object header
- * @net:	simple network protocol interface
- * @net_mode:	status of the network interface
- * @pxe:	PXE base code protocol interface
- * @pxe_mode:	status of the PXE base code protocol
+ * @header:			EFI object header
+ * @net:			simple network protocol interface
+ * @net_mode:			status of the network interface
+ * @pxe:			PXE base code protocol interface
+ * @pxe_mode:			status of the PXE base code protocol
+ * @ip4_config2:		IP4 Config2 protocol interface
  */
 struct efi_net_obj {
 	struct efi_object header;
@@ -60,6 +61,9 @@ struct efi_net_obj {
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
+#ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
+	struct efi_ip4_config2_protocol ip4_config2;
+#endif
 };
 
 /*
@@ -987,6 +991,12 @@ efi_status_t efi_net_register(void)
 		return r;
 	}
 
+#ifdef CONFIG_EFI_IP4_CONFIG2_PROTOCOL
+	r = efi_ipconfig_register(&netobj->header, &netobj->ip4_config2);
+	if (r != EFI_SUCCESS)
+		goto failure_to_add_protocol;
+#endif
+
 	return EFI_SUCCESS;
 failure_to_add_protocol:
 	printf("ERROR: Failure to add protocol\n");
-- 
2.43.0

