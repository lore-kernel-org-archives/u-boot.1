Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4845BC02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CE4680C7E;
	Sun, 16 Feb 2025 12:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lf84Yglx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE9E80F18; Sun, 16 Feb 2025 12:23:52 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A97A80F0B
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-309025ec288so31935281fa.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739705030; x=1740309830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=Lf84Yglxve3mMYY/TMAce3Uanhuhe0eKwf/IO0znJSXxjC/9PRMXidtI5pk7/P3wGO
 GoBRDUi6VSP0f8WBmiHCf0gw1MvEepcn4k5hPIFT2owK6SHurCZWekYn0WYqkKTNjxzx
 /e85MBvUoVE2gLkHIbiDx5pUFeIvO80FtQp9cuDxu0mDriFPG2duuqtLkOx2yRXkJh4B
 CaEjGijGnYvXYaVcniM/PM0HIx1GEwxBUVNnvy2nXpBLhkOyb24pZgmvMkG7/XNJ+dIR
 d2jbbC34s1cE07PChgazErMjOgEW9CdWwZdokQ1EsOoUVc51L+yvcMxHvbkokcj4ktGE
 aFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739705030; x=1740309830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76kJkzMOEkjZFcWxQFb6p0AFhBY9P1lvqHJYQ6scJ8E=;
 b=n0IS37vjiciISY9N96+X25suZPomY2FvPIxHkGXW8gn/uvRif8QCzZVpyDOHJVHOlk
 +ay4FVKB+4DWpmCoMflQbdZy+LyVEyoyBRnQLNOOFHkHLb8SlNWODb/NKwcrPqr1po91
 EnJ6PrQiPjmLRKF1c5sgEOrY35UOsud3bgqmEKm1rHCOS1crE7jrOOK9EvdWvm2aKdZH
 BdKH2wPWviHgdZiIW8n08DkZc4+Nh2o/GC/T6GXidGchX/47xenOziJ0/9AiK18OU5tn
 R6YYak+baclye4cPkHyiro/iGJrQzIggbWAEQr3W511XloUErMfs8kPmJieZ7NbSdhY9
 Czkg==
X-Gm-Message-State: AOJu0YxnX8BQytEfCc18sV/p3tYn9BW6m+qH2wLVN8OtbY1wYt+KH92R
 E+P9zBVrgDI6Hc+gAsCr84cdPh+AszaKQxJEeFYn9KUtZe0lE4YK
X-Gm-Gg: ASbGncuJND+DsFPKOzWcFEyBjFb0baxqmnaiCME728s61pU0jFGW++d8mVKSjmjrlKi
 SPsgJQf8jS6aaIcxUWTDyKcnW09iWFfDEd+FpMOse/UtOzfenwJQZ1OMWQym4ZSetn6xygoNEMW
 dbOl+SY46hZXt+ap7aERU4qP+OLtB5+IrFeWERqLe1WLeAXExD1GAIZUUCHvOp5T+IrRim7q1+q
 x/ZutUJllwJOAlMwXaxoebczEIbc/V4uwoF83C6gq73dQZnSDSKte4c/8Wi0Vy0VsCImCAUIbCu
 /7xtEag=
X-Google-Smtp-Source: AGHT+IHRvzPNtTMeVCocsrwkKIG0lMWLkmCkbGdVNxPm7Pr9sBlTFLKG1RYTsm1ITHd3awDalwpIMA==
X-Received: by 2002:a2e:9cd1:0:b0:308:e9ae:b5a9 with SMTP id
 38308e7fff4ca-30927a2dec8mr18050431fa.6.1739705029218; 
 Sun, 16 Feb 2025 03:23:49 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-309100c528asm11976111fa.22.2025.02.16.03.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 03:23:48 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/2] core: ofnode: add of_graph parsing helpers
Date: Sun, 16 Feb 2025 13:23:26 +0200
Message-ID: <20250216112327.59090-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216112327.59090-1-clamor95@gmail.com>
References: <20250216112327.59090-1-clamor95@gmail.com>
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

