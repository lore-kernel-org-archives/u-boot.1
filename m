Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11156E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FE589684;
	Wed,  4 Dec 2024 04:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VhpAIdyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEED89684; Wed,  4 Dec 2024 04:05:57 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8C798911D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-215513ea198so3372925ad.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281553; x=1733886353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQO2gjF1WKV1Ny2k5g8Pec8RnrA/AUrlot7qkqDL6C0=;
 b=VhpAIdyVT2EGjwGSxjJdadFbikRG8ZbT9OcncGXyF11z8pyqLvOcTRxdPAtlZELLcY
 cdK0mji9nnbGOl2xwtDbZBq8MXwRzZs5Stt7YMdwNQDxuWSH5qs20MBb6P7Z7600ypPb
 kao9j5NmWh/tUkNjuefg9zgFzPaqmzZucImCO8c2is0Bt4xrZ0emXnjjHTiKeE7uKp03
 a/CVPN3JhD0VAjqUeL4uIYb7evGSQH6PeMXl/ckhu7hxMgQBKPmGk6lIORno3A7Xcjhr
 O1z5sbE2ObdputFYZiuuF+gzwsCeiBIoVqs5eirJFE1VnsiZqcxFB9RUrSbvYWDFVvzn
 xMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281553; x=1733886353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQO2gjF1WKV1Ny2k5g8Pec8RnrA/AUrlot7qkqDL6C0=;
 b=gwYyWo036+r23Hl6CGBgsoKqtBxFTw63sNxfOMd5pBRKW/i5tzKQ52K7qkxJsO7fNA
 0lCkKnMUvd3YkVjD9QqF30SQSVnQM2ZhkAtBlPTom+YZhymqrzcrDN4eRjVXK9H1zuzU
 uLAV81WMVgPFN1NRd8V9ul5UMN5m4HIruIOPHrGHAD/m2EZLLRgGwXWMw3TBaaq8K4QE
 ftFsVbzKCz70KLKI4vB+WIDXSsZW6I9aCcexM5rAZdZ6NlCaDOXrCEi70FAMWGv9NR43
 3ZzsVUxLIyVg1nFudVEmbI0VsJtAqsG82RCMIM2yPTAfcSjOLEw9syv3e++IcgU8V806
 IweQ==
X-Gm-Message-State: AOJu0YzhEfHITjaQ/8WeUm9PnqZA/s1k0WfGnJvZvHmDXwVHSIHbLbhk
 W3d/cyiOQ5awFMY8diM+hHUPIOaShkiM9zvuSLX9eqxLDvH3AiIiEQHpWIkhR9Q=
X-Gm-Gg: ASbGncs4m7weIkiniWVoM1OmdljLZ69E5JUMRAEfpGMrTfqw8cisN4taDe4lkss0+cA
 ZTV/tFsRIAhigxmZ2UGOpwo28grbMIos0CXYC59YCh6Maw/KyvotVtLmJG/IwESWbiKNI76HSHM
 CX+YWNHbzR4BVYNGJjbo1kkCi3CvcjjXnzMaBP01AYXIuMQvQRjT7C8AENRIur0Q3N+7G7JfOrC
 HPZn1IPW21p0ad8hD1po5bIXDvO2a3bM7JOmtnHE2A=
X-Google-Smtp-Source: AGHT+IEpbrF4fqND3MW/lpDwfMYEO8+FBgqRemuMpUfzEpiLrvVB6wxcpaJEAO1WDyFegsZ90H2HAA==
X-Received: by 2002:a17:903:1744:b0:215:3998:189f with SMTP id
 d9443c01a7336-215bd45d400mr70226535ad.6.1733281553260; 
 Tue, 03 Dec 2024 19:05:53 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:52 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v7 07/14] efi_loader: device_path: add support for HTTP device
 path
Date: Wed,  4 Dec 2024 00:05:22 -0300
Message-ID: <20241204030530.2099776-7-adrianox@gmail.com>
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

