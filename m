Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C99D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CD288F28;
	Thu, 28 Nov 2024 15:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Br0j372w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930B6897DA; Thu, 28 Nov 2024 15:44:48 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB76C88F28
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ea2bf25dc8so778250a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805084; x=1733409884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3Eg/rf5Iy0q0DnNmwevOG6gAeCYEMbCFhxqwRqGUeY=;
 b=Br0j372wMeHCePGy7l9XRgCnOAuc6H4S92477JCSu9fCsVd/RH5Nv36KMwqP/vDX1w
 LCduyuXVUchQduGqyGWvbaWCAg6Krc6K22Qlzn+rNk0AkV06syHcM+dpmpF0w8pIcA/s
 5vKUYFR3o7BwxYLOnp5wlEnoU23JMjBCWX27H2pRUGydhsCbzEN4ygQA4APVVwE5+iMK
 8GxEg9yrjbOHSEqB2gLx0SjCniYKNfsBpffr2XNen4t+GblfikgbJ9WXqAojdZA4WiZh
 iQe4lENEktxgfGmdJMxvkB2vBwe3wS6+LxlzW14fYq6SQflL6ySCna+38VdGfvslC2sy
 T9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805084; x=1733409884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3Eg/rf5Iy0q0DnNmwevOG6gAeCYEMbCFhxqwRqGUeY=;
 b=V0aRxpGpdKnwpJX3bevoBCRCdFBdeuoU7T16z/lsRsAX3A6xbzfr0QEZ4+dsljzosc
 42rRtljmJicpkg0Tv1zyxNo9KJkFMsvlwHD7Kh5z2l2YhD7XzCAiVHpEkMQ226FRKXJ9
 hG8j9ZfCJJjkKikjksN3sLmvU1+dmKWtNVAbePN/w+L9+WeVRbcTtYOxRSRtQ0diLSgX
 90qXmmhDd6kAF6+cSihnN/5wls2L1LxGIeqrlxjzNgn6vS6ms//7on5slURs3Eo8TAW7
 OxaJjb0guuEDXRh1VOvSYHW/PiFz2yeIr0lrxkiVAxQqoeLEOZpJMZ9NaGISeYwdSlm5
 BH8A==
X-Gm-Message-State: AOJu0Yw8xjM92VxwNcgybkC5OtPzrooKgWdoHyAcf+P4xh88Vd8tde/V
 dJAO1oOMWVhmjE+RT0c3lbKC1WNA2PdAqwzovImUBguNsuzMq1WYQqFubJ6mcRc=
X-Gm-Gg: ASbGncvl9Jnax+im1vx6bkHXVlFxVGE5VRVRvYhras8xZYkYZvCc5KgUJZpS7WzZ8eH
 LwD8zaSEGPx2LW+bJbWtf0SR0RGBqiGdoj88OmHrykjNqO3uXKH3STFuRYP0tqHEB+nh6AjszJl
 d5S3SpeQUhhGi6CoYfm6Ede/8m+dtr2UU73HOcXD9huJbAqJyNPzkLAhYN1d+cJKUN5jSgRh0cp
 LfQYlTsBD4w/V5VL1nZY+gLiCSRxpR7n4K8ctA3j18=
X-Google-Smtp-Source: AGHT+IGXI5FtxQpYDn7ZK+JhLK0kkrVUonMh8S13J3S/FOSIirEylXtyrKZV5z73IAvM9qepz5AvIA==
X-Received: by 2002:a17:90b:2ecd:b0:2ea:3ab5:cb8c with SMTP id
 98e67ed59e1d1-2ee097e340emr9123305a91.33.1732805084330; 
 Thu, 28 Nov 2024 06:44:44 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:44 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v6 10/14] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
Date: Thu, 28 Nov 2024 11:44:12 -0300
Message-ID: <20241128144416.604126-11-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128144416.604126-1-adrianox@gmail.com>
References: <20241128144416.604126-1-adrianox@gmail.com>
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
(no changes since v4)
Changes in v4:
 - efi_ipconfig.c is compiled if ARCH_QEMU || SANDBOX
 - An #ifdef changed to IF_ENABLED
 - Removed a log_err
 - Reworked sanity checks in efi_ip4_config2_set_data

(no changes since v2)
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
index 0000000000..b4b929b144
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
+		if (data_size == 0 && !data) {
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
+		return EFI_EXIT(EFI_UNSUPPORTED);
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
index 368f62c5b2..d3a8deecd0 100644
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

