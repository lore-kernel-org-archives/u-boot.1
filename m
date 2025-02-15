Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F59C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD5580F4A;
	Sat, 15 Feb 2025 18:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPTVuXvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5071E80F3F; Sat, 15 Feb 2025 18:56:05 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA44A80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54298ec925bso4214431e87.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739642158; x=1740246958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=lPTVuXvAoDXKIni2VU2yy7G6UwTftL4JuxR0JlJRo/ozMg/BTavyK+jzYQsjlegwSZ
 lbZ0+cM/jqXMfKXkz8wLlaS44txePjr15eJgeIOCXWMRBt3vdsuhLDb1FFMbKZcmYzyJ
 h7IONuS/RcGY0gwFT4Jn3f69tsvO0gpit1jo5OZ+T45VP+zg9QCs8vV885uOGBAU2HPS
 LzaMqfENgVOq8gz63tc7e52MvOHdMYb+p3P6BehwRMIllicSr/nHt9mhawV5lo/HVs8Y
 SZo1zE3CEqJ2kFFwdpdEzK+/VN82fJdlRqdC8iJl8ttqeoW7p9KXkspVIkLju01pNdHz
 Dirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739642158; x=1740246958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=M23+h9bPhBXLEBGm1IgNJdqJfqrqRYPJ0RpWNFD274vW/nLFmQYreILoe9nVEJS2nF
 hmtX154IdC8uN4xzc8EXHo5WXVDkmN/M8cxKjYouFsAx02PuwrJiO6+POxXknSNKvbzR
 KxSTwqAKk6wf/DJJZQIELJlqjCTwBf5MnDE1LK/gqrP9/CFGk/bhx3Asi3gTgpjRPA5f
 kOumRbMeYPp525jK41IUEPyHQ3+uUoTNAdf/aGDm9CUVZLoubppeh5gtoIP7YDTbQVv9
 5w5SpN9airsBFcUKtKPherJTVOyT51oFvIkGeEqnW0kMIl5qt/PeCBRVsZMMfUFydQ4p
 efYQ==
X-Gm-Message-State: AOJu0YwhuD8UWM7IG10d0RA63FrbiIOV3aKI6t9XCBtDFaQT4KDKZmYv
 1RR9tyI2e4sOUcl8ZrI1s1iGEvhAlrO6el2HC5zOwXkXhE5mIwfC1MbnGg==
X-Gm-Gg: ASbGncs7DSnbC92/hTSjmTEAaddyJOeGbhZ1sodLm9vo1S9VXGFXGOvK7PW+EUnh0TO
 tJqj5FjCb9MczEhYM+V0Zg4YVKhR93FbbIHPEAcQQeRLl8DqViZdne/gDfB2EWMsg07JJ+i8vT+
 Q/GjitR+ZkoDqRWGFnQVq8PvkI7nU5FRxbXg4z21pX7g9CqNcJTLw0BTJx2uz1U6Yru+aEW7G+f
 AgMdtY8xp1b/1CIg3awIqgYidJ/zDoTEPAaM+8w0e9C1u37BRh0caSfdzVZ7d00SL1bYVvYB03J
 CChC2sA=
X-Google-Smtp-Source: AGHT+IFjPn6/Hx58E9am3eo9FKcy/ivqgtyqZgTtxITOzbAQFU2QZd/9tnbMCUFGnb/0VVJngHINbg==
X-Received: by 2002:a05:6512:2342:b0:545:b89:3098 with SMTP id
 2adb3069b0e04-5452fe5b894mr1560401e87.24.1739642157684; 
 Sat, 15 Feb 2025 09:55:57 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-545315629c8sm231764e87.223.2025.02.15.09.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 09:55:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] core: ofnode: add of_graph parsing helpers
Date: Sat, 15 Feb 2025 19:55:34 +0200
Message-ID: <20250215175534.203539-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215175534.203539-1-clamor95@gmail.com>
References: <20250215175534.203539-1-clamor95@gmail.com>
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

Add a mostly complete list of ofnode analogs of of_graph
parsing helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/core/Makefile       |   2 +-
 drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
 include/dm/ofnode_graph.h   |  90 +++++++++++++++
 3 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/ofnode_graph.c
 create mode 100644 include/dm/ofnode_graph.h

diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index 9ea57911f89..657e589c286 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -16,6 +16,6 @@ ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
 obj-$(CONFIG_$(XPL_)OF_PLATDATA) += read.o
-obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o
+obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o ofnode_graph.o
 
 ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
diff --git a/drivers/core/ofnode_graph.c b/drivers/core/ofnode_graph.c
new file mode 100644
index 00000000000..90c92af3258
--- /dev/null
+++ b/drivers/core/ofnode_graph.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#define LOG_CATEGORY	LOGC_DT
+
+#include <dm.h>
+#include <log.h>
+#include <dm/ofnode.h>
+#include <linux/err.h>
+
+/**
+ * ofnode_graph_get_endpoint_count() - get the number of endpoints in a device ofnode
+ * @parent: ofnode to the device containing ports and endpoints
+ *
+ * Return: count of endpoint of this device ofnode
+ */
+unsigned int ofnode_graph_get_endpoint_count(ofnode parent)
+{
+	ofnode ports, port, endpoint;
+	unsigned int num = 0;
+
+	/* Check if ports node exists */
+	ports = ofnode_find_subnode(parent, "ports");
+	if (ofnode_valid(ports))
+		parent = ports;
+
+	ofnode_for_each_subnode(port, parent) {
+		if (!strncmp(ofnode_get_name(port), "port", 4)) {
+			/* Port node can only contain endpoints */
+			ofnode_for_each_subnode(endpoint, port)
+				num++;
+		}
+	};
+
+	log_debug("%s: detected %d endpoints\n", __func__, num);
+
+	return num++;
+}
+
+/**
+ * ofnode_graph_get_port_count() - get the number of port in a device or ports ofnode
+ * @parent: ofnode to the device or ports node
+ *
+ * Return: count of port of this device or ports node
+ */
+unsigned int ofnode_graph_get_port_count(ofnode parent)
+{
+	ofnode ports, port;
+	unsigned int num = 0;
+
+	/* Check if ports node exists */
+	ports = ofnode_find_subnode(parent, "ports");
+	if (ofnode_valid(ports))
+		parent = ports;
+
+	ofnode_for_each_subnode(port, parent)
+		if (!strncmp(ofnode_get_name(port), "port", 4))
+			num++;
+
+	log_debug("%s: detected %d ports\n", __func__, num);
+
+	return num++;
+}
+
+/**
+ * ofnode_graph_get_port_by_id() - get the port matching a given id
+ * @parent: parent ofnode
+ * @id: id of the port
+ *
+ * Return: ofnode in given port.
+ */
+ofnode ofnode_graph_get_port_by_id(ofnode parent, u32 id)
+{
+	ofnode ports, port;
+	u32 port_id;
+
+	ports = ofnode_find_subnode(parent, "ports");
+	if (!ofnode_valid(ports))
+		return ofnode_null();
+
+	/* Check ports for node with desired id */
+	ofnode_for_each_subnode(port, ports) {
+		ofnode_read_u32(port, "reg", &port_id);
+		log_debug("%s: detected port %d\n", __func__, port_id);
+		if (port_id == id)
+			return port;
+	}
+
+	return ofnode_null();
+}
+
+/**
+ * ofnode_graph_get_endpoint_by_regs() - get the endpoint matching a given id
+ * @parent: parent ofnode
+ * @reg_id: id of the port
+ * @id: id for the endpoint
+ *
+ * Return: ofnode in given endpoint or ofnode_null() if not found.
+ * reg and port_reg are ignored when they are -1.
+ */
+ofnode ofnode_graph_get_endpoint_by_regs(ofnode parent, int reg_id, int id)
+{
+	ofnode port, endpoint;
+	u32 ep_id;
+
+	/* get the port to work with */
+	if (reg_id < 0)
+		port = ofnode_find_subnode(parent, "port");
+	else
+		port = ofnode_graph_get_port_by_id(parent, reg_id);
+
+	if (!ofnode_valid(port)) {
+		log_debug("%s: port node is not found\n", __func__);
+		return ofnode_null();
+	}
+
+	if (id < 0)
+		return ofnode_find_subnode(port, "endpoint");
+
+	/* Check endpoints for node with desired id */
+	ofnode_for_each_subnode(endpoint, port) {
+		ofnode_read_u32(endpoint, "reg", &ep_id);
+		log_debug("%s: detected endpoint %d\n", __func__, ep_id);
+		if (ep_id == id)
+			return endpoint;
+	}
+
+	return ofnode_null();
+}
+
+/**
+ * ofnode_graph_get_remote_endpoint() - get remote endpoint node
+ * @endpoint: ofnode of a local endpoint
+ *
+ * Return: Remote endpoint ofnode linked with local endpoint.
+ */
+ofnode ofnode_graph_get_remote_endpoint(ofnode endpoint)
+{
+	/* Get remote endpoint node. */
+	return ofnode_parse_phandle(endpoint, "remote-endpoint", 0);
+}
+
+/**
+ * ofnode_graph_get_port_parent() - get port's parent node
+ * @endpoint: ofnode of a local endpoint
+ *
+ * Return: device ofnode associated with endpoint
+ */
+ofnode ofnode_graph_get_port_parent(ofnode endpoint)
+{
+	ofnode port = ofnode_get_parent(endpoint);
+	ofnode parent = ofnode_get_parent(port);
+
+	/* check if we are on top level or in ports node */
+	if (!strcmp(ofnode_get_name(parent), "ports"))
+		parent = ofnode_get_parent(parent);
+
+	return parent;
+}
+
+/**
+ * ofnode_graph_get_remote_port_parent() - get remote port's parent ofnode
+ * @endpoint: ofnode of a local endpoint
+ *
+ * Return: device ofnode associated with endpoint linked to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_port_parent(ofnode endpoint)
+{
+	ofnode remote_endpoint = ofnode_graph_get_remote_endpoint(endpoint);
+	if (!ofnode_valid(remote_endpoint)) {
+		log_debug("%s: remote endpoint is not found\n", __func__);
+		return ofnode_null();
+	}
+
+	return ofnode_graph_get_port_parent(remote_endpoint);
+}
+
+/**
+ * ofnode_graph_get_remote_port() - get remote port ofnode
+ * @endpoint: ofnode of a local endpoint
+ *
+ * Return: port ofnode associated with remote endpoint node linked
+ * to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_port(ofnode endpoint)
+{
+	ofnode remote_endpoint = ofnode_graph_get_remote_endpoint(endpoint);
+	if (!ofnode_valid(remote_endpoint)) {
+		log_debug("%s: remote endpoint is not found\n", __func__);
+		return ofnode_null();
+	}
+
+	return ofnode_get_parent(remote_endpoint);
+}
+
+/**
+ * ofnode_graph_get_remote_node() - get remote parent ofnode for given port/endpoint
+ * @parent: parent ofnode containing graph port/endpoint
+ * @port: identifier (value of reg property) of the parent port ofnode
+ * @endpoint: identifier (value of reg property) of the endpoint ofnode
+ *
+ * Return: device ofnode associated with endpoint linked to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_node(ofnode parent, int port, int endpoint)
+{
+	ofnode endpoint_ofnode;
+
+	endpoint_ofnode = ofnode_graph_get_endpoint_by_regs(parent, port, endpoint);
+	if (!ofnode_valid(endpoint_ofnode)) {
+		log_debug("%s: endpoint is not found\n", __func__);
+		return ofnode_null();
+	}
+
+	return ofnode_graph_get_remote_port_parent(endpoint_ofnode);
+}
diff --git a/include/dm/ofnode_graph.h b/include/dm/ofnode_graph.h
new file mode 100644
index 00000000000..908c990a3f3
--- /dev/null
+++ b/include/dm/ofnode_graph.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#ifndef _DM_OFNODE_GRAPH_H
+#define _DM_OFNODE_GRAPH_H
+
+#include <dm/of.h>
+
+/**
+ * ofnode_graph_get_endpoint_count() - get the number of endpoints in a device ofnode
+ * @parent: ofnode to the device containing ports and endpoints
+ *
+ * Return: count of endpoint of this device ofnode
+ */
+unsigned int ofnode_graph_get_endpoint_count(ofnode parent);
+
+/**
+ * ofnode_graph_get_port_count() - get the number of port in a device or ports ofnode
+ * @parent: ofnode to the device or ports node
+ *
+ * Return: count of port of this device or ports node
+ */
+unsigned int ofnode_graph_get_port_count(ofnode parent);
+
+/**
+ * ofnode_graph_get_port_by_id() - get the port matching a given id
+ * @parent: parent ofnode
+ * @id: id of the port
+ *
+ * Return: ofnode in given port.
+ */
+ofnode ofnode_graph_get_port_by_id(ofnode parent, u32 id);
+
+/**
+ * ofnode_graph_get_endpoint_by_regs() - get the endpoint matching a given id
+ * @parent: parent ofnode
+ * @reg_id: id of the port
+ * @id: id for the endpoint
+ *
+ * Return: ofnode in given endpoint or NULL if not found.
+ * reg and port_reg are ignored when they are -1.
+ */
+ofnode ofnode_graph_get_endpoint_by_regs(ofnode parent, u32 reg_id, u32 id);
+
+/**
+ * ofnode_graph_get_remote_endpoint() - get remote endpoint node
+ * @endoint: ofnode of a local endpoint
+ *
+ * Return: Remote endpoint ofnode linked with local endpoint.
+ */
+ofnode ofnode_graph_get_remote_endpoint(ofnode endpoint);
+
+/**
+ * ofnode_graph_get_port_parent() - get port's parent node
+ * @endpoint: ofnode of a local endpoint
+ *
+ * Return: device ofnode associated with endpoint
+ */
+ofnode ofnode_graph_get_port_parent(ofnode endpoint);
+
+/**
+ * ofnode_graph_get_remote_port_parent() - get remote port's parent ofnode
+ * @endoint: ofnode of a local endpoint
+ *
+ * Return: device ofnode associated with endpoint linked to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_port_parent(ofnode endpoint);
+
+/**
+ * ofnode_graph_get_remote_port() - get remote port ofnode
+ * @endoint: ofnode of a local endpoint
+ *
+ * Return: port ofnode associated with remote endpoint node linked
+ * to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_port(ofnode endpoint);
+
+/**
+ * ofnode_graph_get_remote_node() - get remote parent ofnode for given port/endpoint
+ * @parent: parent ofnode containing graph port/endpoint
+ * @port: identifier (value of reg property) of the parent port ofnode
+ * @endpoint: identifier (value of reg property) of the endpoint ofnode
+ *
+ * Return: device ofnode associated with endpoint linked to local endpoint.
+ */
+ofnode ofnode_graph_get_remote_node(ofnode parent, u32 port, u32 endpoint);
+
+#endif
-- 
2.43.0

