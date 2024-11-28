Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877C0D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A551A89D19;
	Thu, 28 Nov 2024 15:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYX8l1ht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EB9A89D2B; Thu, 28 Nov 2024 15:44:44 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CE9989D19
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ea2bf25dc8so778173a91.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805078; x=1733409878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhG7I43dq+ua1edWOIA1/44P8hWHFkZJoMa9JIc8lWA=;
 b=DYX8l1htPN6MtdNW0SSykhpLJpOVJzVvXdUDF1NrP9Wfv5mcr3wL+SLp+n1fm7KmFl
 6DUBP4alzTO2fnQjGbFbKHAO6P8mgOkGZ2TLaWmcOecKRxnhdi6prEIQLpCHma9atoFK
 vzwO8o7zfpqyTKsjlRFCn/aKVh16e/aW1m839BNA6ksS9TcqStdvWnRA8FRkP4vfdUso
 Lu6c6rWProW8DYCv0fV3FbJ6zIYPMmgkkhlkRWuguEr3Dob+59tfJlre/uD8URbf9EL5
 mJTIRozFVJzpupeHztVB0r4hzN0skpGGvGqkloXCduwZR3jnvyPAmiOuWe7ni1CmcAe7
 EHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805078; x=1733409878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UhG7I43dq+ua1edWOIA1/44P8hWHFkZJoMa9JIc8lWA=;
 b=JFbk6uFtfShcHmXjbEPIR52IGXHRqtqBKQZ66whxfgbDCWmrRKTBgyQwwY6kiMxGzx
 Lt6HixJ5Xmne6/8YsRMi96Dg5D4ryTIDQPK/RggAkpCPZQByTaopoxWVXSDbJibLFr/P
 U35UkLY8dtks6C3zkOpTz3QMAWEeSnldFj+HLLlq8rBehNgUTh9YDEemhFETUDrIGgYN
 JSdHcFfeMYsd6Phq+FEZbiUGYBDzGuaPnV+KPmKFWbZi6jd6LgfBm7rWSSmeDXq0+MQI
 96Fabl66YmQ7VFEBbbCsVxaZ/7DrsoOLIiMl14yzZOsaaS6NLonG0qBZGfkRcdNj/kNr
 3sFw==
X-Gm-Message-State: AOJu0Yz3FnLqBo+3UrK+wrM4r0gn5y+ba56wVONr91GXjKd6o7V2sauV
 WciXSIfy82ijUTd1NTlF8AcNvxiB1F0Na4sJ6v67ytGDkt8gi90wRqDGk94NtTc=
X-Gm-Gg: ASbGnctGqFHpNZwmDOeIGc6az+IVttnorcBIfl0RB9K6AaOhzZi12wjtDfRRkcsKpU4
 HJ8CMRcExBfQPFpohO9hbVqPRd25mBMlE6Vif/CJSOSF2aDCLKrXo6OYRT7Lseg1fgT/AES6hz6
 DI2tzWSFXKatqT+uivISn4XrCYRPRYDOz3vQ9aZUEkn35HN/cYqc+QbdhPBa0GIbj9hyqbdKnSR
 jNPSjusU1gjZdpIPNFfOOVjUER8E4xChV32v13KJsE=
X-Google-Smtp-Source: AGHT+IHRQt9U83fUHyKCGxLBPnf/fIZQmqtwO2ZZw6iRAgoVWnBpRdofw+3/31IfC6k93PljTipgcg==
X-Received: by 2002:a17:90b:2882:b0:2ea:5e0c:2850 with SMTP id
 98e67ed59e1d1-2ee097bb10bmr8325533a91.25.1732805078062; 
 Thu, 28 Nov 2024 06:44:38 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:37 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v6 07/14] efi_loader: device_path: add support for HTTP device
 path
Date: Thu, 28 Nov 2024 11:44:09 -0300
Message-ID: <20241128144416.604126-8-adrianox@gmail.com>
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_device_path.c | 64 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 612bc42816..96b204dfc3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
+struct efi_device_path *efi_dp_from_http(const char *server);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					size_t size);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 6fcbc91e0b..a6d4300686 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1021,6 +1021,70 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
+/**
+ * efi_dp_from_http() - set device path from http
+ *
+ * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
+ * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
+ * and an END node.
+ *
+ * @server:	URI of remote server
+ * Return:	pointer to HTTP device path, NULL on error
+ */
+struct efi_device_path *efi_dp_from_http(const char *server)
+{
+	struct efi_device_path *dp1, *dp2;
+	struct efi_device_path_uri *uridp;
+	efi_uintn_t uridp_len;
+	char *pos;
+	char tmp[128];
+	struct efi_ipv4_address ip;
+	struct efi_ipv4_address mask;
+
+	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
+	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
+		return NULL;
+
+	efi_net_get_addr(&ip, &mask, NULL);
+
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+	if (!dp1)
+		return NULL;
+
+	strcpy(tmp, "http://");
+
+	if (server) {
+		strlcat(tmp, server, sizeof(tmp));
+#if !IS_ENABLED(CONFIG_NET_LWIP)
+	}
+	else {
+		ip_to_string(net_server_ip, tmp + strlen("http://"));
+#endif
+	}
+
+	uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
+	uridp = efi_alloc(uridp_len + sizeof(END));
+	if (!uridp) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+	uridp->dp.length = uridp_len;
+	debug("device path: setting uri device path to %s\n", tmp);
+	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
+
+	pos = (char *)uridp + uridp_len;
+	memcpy(pos, &END, sizeof(END));
+
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
+
+	efi_free_pool(uridp);
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

