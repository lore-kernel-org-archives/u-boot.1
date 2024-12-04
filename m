Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9DFE7716C
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F272789685;
	Wed,  4 Dec 2024 04:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gWSBqzuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4521789671; Wed,  4 Dec 2024 04:06:04 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AE189696
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:06:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215bd2c32a6so14786415ad.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281560; x=1733886360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jl3TnI2kFSQfDCwqm7TwWiQmokTU0sPKpMNMzIpyrww=;
 b=gWSBqzuU8SEkilkq1IrGX2DDoRWwmATCwbCiawwmCA8+0xyh/6k9F8KoWGFeOe1d4q
 zEG2Q6kbyK/mpnZMO3bMXTtqoRNQ5CtBxwnbqCQjIg2Bkp0ypTrzpEmJ1dinXJ4oSKoi
 QEmI7XYmj6qcqocu48MCjPajGyylyxZk7JW5T8XO6ee/X1uW/cbWSxPg/FfGyBsK55pO
 F0Nm9C3eJERDocwtda+V+Lb22MGefkzsfHfOXNxtWJcPINdlOFh/lpq6G8ztQcU7G711
 GR9B1lFaiUZa6LQn3FZttswyAV2F8GdhZDACwNCMoNWpYtz68TfyLlrsGQOVL0ZLb9iQ
 HnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281560; x=1733886360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jl3TnI2kFSQfDCwqm7TwWiQmokTU0sPKpMNMzIpyrww=;
 b=be1auqXc7i9DXTHsZkPI7zLUIfNsasOKeJnlop7kG0Glbn9+G2z+Sjpnlzd3U+h72N
 gOi54QW2QBgT3xl+Y9WpBqdX7ZcXoNLN2fP9G9o+j2H5vNCzVgT0F+FoaueBWUI1Fj8j
 ia72ihu/aPo/lFSqp6uDZXkKBKwXNecfi25AORETL4LE/vXTuGbFcvrVRUHyTA+0srlD
 RnFfeJDlgLDpliz3CW+qkHJ25Zk8s4LVdvXzgze/E5zCbXRoxp5QoLBkdK9sN7duWtDi
 u4NH9LetYInh4FXSUQQcYcJo62bj0JakdX6Hlk6Z73TF4mrmuxtotW+7gp1fpAw07ubW
 h3Cw==
X-Gm-Message-State: AOJu0Ywu9q1+3W/pa/t8x1n0v3OkrOZkU4zdCKEQGbI3/VC6QDN1H+VM
 saK0EOSYcYItKbBn8qcT/vxwUFWkCbQsWmU5XPyHJ71Ut1+n8pKS51ChyWXb3rI=
X-Gm-Gg: ASbGnctPBil/r7hXoRqtgPKu8KNI8HFVOYxYksMtQ/VEg+Ud7CosKRydiIWIEOfY4tY
 GKPtIaHy5RdC5z1lI8Am4745kijCUAaDcI6sBcMPiZcqCK3Xcziia5kLB+7ebrxRVemXj0r4YuZ
 /5HeiFgStAxoP8tG8aBOsjeF2W6fbisapt2CCf0+o2xhVO/uO4S6p8LDzbmjI+Xr0uEAX3FW0gs
 IKVLY2egKwTqNltC0PBXRns6JUfmF720S+Idv4Jqlg=
X-Google-Smtp-Source: AGHT+IG2Wn86DVNhKvcpDm1Ctxl0srxbZ6PoK64W4pwosYqnBns8uxtrLzf8mz8XFdOVoNqm1ygxdw==
X-Received: by 2002:a17:902:f64e:b0:215:aece:ed63 with SMTP id
 d9443c01a7336-215bd169072mr62781995ad.44.1733281560155; 
 Tue, 03 Dec 2024 19:06:00 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v7 10/14] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
Date: Wed,  4 Dec 2024 00:05:25 -0300
Message-ID: <20241204030530.2099776-10-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204030530.2099776-1-adrianox@gmail.com>
References: <20241204030530.2099776-1-adrianox@gmail.com>
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

Add an implementation of the EFI_IP4_CONFIG2_PROTOCOL. The protocol
is attached to the handle of the efi network device. This is the same
handle where snp and pxe are attached to.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v7:
- Changed some EFI_INVALID_PARAMETER for EFI_BAD_BUFFER_SIZE
(no changes since v4)
Changes in v4:
 - efi_ipconfig.c is compiled if ARCH_QEMU || SANDBOX
 - An #ifdef changed to IF_ENABLED
 - Removed a log_err
 - Reworked sanity checks in efi_ip4_config2_set_data
 
 include/efi_loader.h          |   3 +
 lib/efi_loader/Kconfig        |   9 ++
 lib/efi_loader/Makefile       |   1 +
 lib/efi_loader/efi_ipconfig.c | 214 ++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_net.c      |  20 +++-
 5 files changed, 242 insertions(+), 5 deletions(-)
 create mode 100644 lib/efi_loader/efi_ipconfig.c

diff --git a/include/efi_loader.h b/include/efi_loader.h
index b6f865ca76..9be09a799b 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -626,6 +626,9 @@ int efi_disk_create_partitions(efi_handle_t parent, struct blk_desc *desc,
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
index d93f28b842..0b932df85c 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -476,6 +476,15 @@ config EFI_RISCV_BOOT_PROTOCOL
 	  replace the transfer via the device-tree. The latter is not
 	  possible on systems using ACPI.
 
+config EFI_IP4_CONFIG2_PROTOCOL
+	bool "EFI_IP4_CONFIG2_PROTOCOL support"
+	default y if ARCH_QEMU || SANDBOX
+	depends on NET || NET_LWIP
+	help
+	  Provides an implementation of the EFI_IP4_CONFIG2_PROTOCOL, this
+	  protocol can be used to set and get the current ip address and
+	  other network information.
+
 endmenu
 
 menu "Misc options"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 87131ab911..30cd1de9d6 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_EFI_ESRT) += efi_esrt.o
 obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
+obj-$(CONFIG_EFI_IP4_CONFIG2_PROTOCOL) += efi_ipconfig.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
diff --git a/lib/efi_loader/efi_ipconfig.c b/lib/efi_loader/efi_ipconfig.c
new file mode 100644
index 0000000000..0b247a4c02
--- /dev/null
+++ b/lib/efi_loader/efi_ipconfig.c
@@ -0,0 +1,214 @@
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
+	if (!this || (data && !data_size) || (!data && data_size))
+		return EFI_EXIT(EFI_INVALID_PARAMETER);
+
+	switch (data_type) {
+	case EFI_IP4_CONFIG2_DATA_TYPE_INTERFACEINFO:
+		return EFI_EXIT(EFI_WRITE_PROTECTED);
+	case EFI_IP4_CONFIG2_DATA_TYPE_MANUAL_ADDRESS:
+		if (current_policy != EFI_IP4_CONFIG2_POLICY_STATIC)
+			return EFI_EXIT(EFI_WRITE_PROTECTED);
+		if (!data_size && !data) {
+			memset((void *)&current_http_ip, 0,
+			       sizeof(current_http_ip));
+			return EFI_EXIT(EFI_SUCCESS);
+		}
+		if (data && data_size == sizeof(struct efi_ip4_config2_manual_address)) {
+			memcpy((void *)&current_http_ip, data,
+			       sizeof(struct efi_ip4_config2_manual_address));
+			efi_net_set_addr(&current_http_ip.address,
+					 &current_http_ip.subnet_mask, NULL);
+			return EFI_EXIT(EFI_SUCCESS);
+		}
+		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
+	case EFI_IP4_CONFIG2_DATA_TYPE_POLICY:
+		if (data && data_size == sizeof(enum efi_ip4_config2_policy)) {
+			current_policy = *(enum efi_ip4_config2_policy *)data;
+			return EFI_EXIT(EFI_SUCCESS);
+		}
+		return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
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
+		memset(info, 0, sizeof(*info));
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
+		return EFI_EXIT(EFI_NOT_FOUND);
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
+	if (r != EFI_SUCCESS) {
+		log_err("ERROR: Failure to add protocol\n");
+		return r;
+	}
+
+	memcpy(current_mac_addr, eth_get_ethaddr(), 6);
+
+	ip4config->set_data = efi_ip4_config2_set_data;
+	ip4config->get_data = efi_ip4_config2_get_data;
+	ip4config->register_data_notify = efi_ip4_config2_register_notify;
+	ip4config->unregister_data_notify = efi_ip4_config2_unregister_notify;
+
+	return EFI_SUCCESS;
+}
diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 368f62c5b2..916c15999e 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -60,11 +60,12 @@ static struct efi_event *wait_for_packet;
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
@@ -72,6 +73,9 @@ struct efi_net_obj {
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
+#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
+	struct efi_ip4_config2_protocol ip4_config2;
+#endif
 };
 
 /*
@@ -999,6 +1003,12 @@ efi_status_t efi_net_register(void)
 		return r;
 	}
 
+#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
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

