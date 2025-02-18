Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13337C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 17:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F0A80C98;
	Tue, 18 Feb 2025 18:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnV/KTa3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51FC80646; Tue, 18 Feb 2025 18:09:03 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C51F80BA8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3061513d353so61041011fa.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739898540; x=1740503340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=fnV/KTa3uiTI1tzJ/ZA8wcs7FELka6mPFt2R+Ph6G+ePZf3SSjjqTH8z/y5nYJsDB/
 NMCa2Cs0zwUmCVKBgwX70b19Y4DIZHgBc0nBvbb0nu+Q65JITy5rFvGkjeXnY/UgxJpp
 gC5GOas7mr7XAiUIMTahtBmzg1w9kl9mZgU+rYlSRRJyhk7ZAZyoQOnAZq/ogjNUoXTa
 cJTxrEhjSESjDmQgmLXiH4VQ3wGqh03Mqu/qg5xBPObTSMGt+kary7BBxJlz3X/Tp18M
 +IE4w+rrL25FJlXVGL0aMHOQGk+te1v/oxcBwv0yRzSO3ohLFtX51nFp9QD/zBc+2xPp
 hUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739898540; x=1740503340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=BiJ77IZo1hlbPExQqZm94lXgKzifGYxnFXIQN9geGIZf14YDsQt5m4AhmC8H6xgaNn
 zSxVdRPm/yGl9vo6nNm6alIgLZfWJUTLpqxrx878CKNwCR+uWiwURNVuGf7GOFBPk7GN
 2Z9T/5R1pHHUDzdnGaaJq+buieZfKikWMxcxHj+lxCgvUOgZdad7h7Ib85S192+SdyQV
 bMjt7398ITUTSH0+4aHaJj0ByfkISFoT0ntEFgFmmz8Q5ySu6K4hIMaoGCrGFlwCBBiC
 eBbEkgmkleJAqstJKAYRd0bZAUG1rfOESKlwjh2bOj0iYHo9cNDiWPdi0dSdaotpM6Un
 YclA==
X-Gm-Message-State: AOJu0Yze+7MBl+SSvZ7+SdIiKkHe06fwuXs5D61MM9RhW71hBQk/jqpI
 nOz5roGuyNO8wnr9ZAbICWQ5sEWQVVKk8LpP4PFKrgGsRMQmYv9wWB1+Kg==
X-Gm-Gg: ASbGncteImKrv2AcznSyUqsNCraW6V6GObGDYOkblgSIHH1pzwxmybUrXiWPchnVdFD
 7Ii0P+saUDozbTfKhaqAk5C4vlF1NEJhj3mdSstBsO0EC/FTQfsss9YGfTr6ljRBc9MHWptfrqh
 zUTUJrUHdOfOE61Km6LI2eTDXN8qW9/DxC9Bz9HSMPzEjPRGH+aZgk5rf+Z6xJOcUEEJahtCv8T
 KsYhk4PgKb55N9kDd3DrHpxmaBO29zU1xbx9P5OjpPyF0POaPecnEKoYVDaq+dhwN1sow5RQTBi
 vmDUx+0=
X-Google-Smtp-Source: AGHT+IHVgEKcgtARF5sz6tIzn1ucPVIYb3L4bKVJ6vBeoedcmjTDh44F8dFpb3+Y1CxlSUO1t3+/GQ==
X-Received: by 2002:a2e:9057:0:b0:309:24df:f193 with SMTP id
 38308e7fff4ca-30927b1df4dmr43526881fa.28.1739898540007; 
 Tue, 18 Feb 2025 09:09:00 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30a266e4968sm10888621fa.77.2025.02.18.09.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 09:08:59 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 1/2] core: ofnode: add of_graph parsing helpers
Date: Tue, 18 Feb 2025 19:08:38 +0200
Message-ID: <20250218170839.5427-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218170839.5427-1-clamor95@gmail.com>
References: <20250218170839.5427-1-clamor95@gmail.com>
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

