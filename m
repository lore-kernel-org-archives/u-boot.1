Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06F0D591B3
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 21:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71789894D5;
	Mon, 18 Nov 2024 22:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TQlaLoea";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0C5894BD; Mon, 18 Nov 2024 22:09:47 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF1088C10
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 22:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2969dc28dafso646937fac.2
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 13:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731964183; x=1732568983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Y8e23LlPM3k6Z12jbZRtH8b1oFiqSMHwfDFrPKxQCw=;
 b=TQlaLoeaVkzZgTtjL04Hv5RWH83zpIh9YYQ3EUUKlvKoYuhjqIpTcOMp3TYvTiUHga
 c2sWz9ZbA4qwUAzcKPWR2KiAxYQpnXFLtN1iH1d8Vz9AStipmLla6mClVi/+XIzuinha
 w8IJpbTv7cX1UbSfxys2IcmpnkeMhPSV2PbywGTOVMDUx6W5+FrYvVoYtEDW+c8DPM0c
 gC++K1anR0MfPWksKhhqWvYYVCiVDlD4tx5tKHVDxWCFyvmOqhzmGC7ikx/STvNEDEYo
 826WCWTj0pNK0kbl1CtNy6+/uuAi+kZfBXOcy0Tzgs6ey2RCYPOtpXoshHratYJMjy3m
 lTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731964183; x=1732568983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Y8e23LlPM3k6Z12jbZRtH8b1oFiqSMHwfDFrPKxQCw=;
 b=EkDhrg5WS9Q4FRNOrf3rhJEbj9zgxib2qQJlq+3kx9xz3FEcviKAcqUlxImHL6d6uj
 Y4bc5hNq1+vz6n+tXSz5JtvmpJkhC/S6EIkv7YbkYr3CXWGAUAx09RKRGe04Oth0fHuS
 upgKPir6TKHkUnyy6W7LhBsOml4QAuYc+YJJcrzI8eCIRGAKVn+zqEwtqzQpOs5Nz2e+
 2vKGWjPE1pmchYiO9k7AyYgWj024JcCPc5MxuwKQ1N7Zm8gvjsVtsRO5G5uwbEEB3VP7
 WUjD4pyku2ZL26xMGILnAvtZ9UFo1OWwdKnhNCCSxZcd7HJ753oWfXzihj1fpmnH8gMW
 E2dg==
X-Gm-Message-State: AOJu0Yw5gUJi3leu2phW4mltDA2YK1GBsYBzu/L1Kbs8VtDxIcCVjPl3
 B19ObPcyiTn89ZjId38IccG+J2rKab5izjf6OgAxK2FWNLjjWwINJV8vphBP
X-Google-Smtp-Source: AGHT+IGMvCaUMIkoW79+cdL3drn+2zYs6Im6RaADo23MnJpHEowA66fkTYxaP5MWs2AXK135/fBmzA==
X-Received: by 2002:a05:6870:56aa:b0:295:eb24:71cf with SMTP id
 586e51a60fabf-2962dd905c9mr11887237fac.2.1731964183633; 
 Mon, 18 Nov 2024 13:09:43 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29651852a7asm2994621fac.3.2024.11.18.13.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 13:09:43 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v4 10/14] efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
Date: Mon, 18 Nov 2024 18:09:04 -0300
Message-ID: <20241118210908.51196-11-adrianox@gmail.com>
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

Add an implementation of the EFI_IP4_CONFIG2_PROTOCOL. The protocol
is attached to the handle of the efi network device. This is the same
handle where snp and pxe are attached to.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
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
index d96d4e08bd..0cd6023bb2 100644
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
index 58d49789f1..b8c8d2ba4a 100644
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
index d81277eb2e..999369f16a 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -54,11 +54,12 @@ static struct efi_event *wait_for_packet;
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
@@ -66,6 +67,9 @@ struct efi_net_obj {
 	struct efi_simple_network_mode net_mode;
 	struct efi_pxe_base_code_protocol pxe;
 	struct efi_pxe_mode pxe_mode;
+#if IS_ENABLED(CONFIG_EFI_IP4_CONFIG2_PROTOCOL)
+	struct efi_ip4_config2_protocol ip4_config2;
+#endif
 };
 
 /*
@@ -993,6 +997,12 @@ efi_status_t efi_net_register(void)
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

