Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680FDD5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C148921F;
	Fri,  8 Nov 2024 14:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GJwRpEut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44BE888DB6; Fri,  8 Nov 2024 04:46:52 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1327F88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:46:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c70abba48so17719245ad.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037608; x=1731642408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YfMVd5zgGLlmDJONKNkWDqNeaxU55xF3aidA0PfNLzM=;
 b=GJwRpEutYbn8W1yk2YHq4V+vNPcb/CPGL0fua4ppvhjl5mO6H2gjQ+8gbzPMNvUEtH
 Bsv54FPfftHhdMRePR+FsiXJshga4xP48qtyi5D11KUTx8wmdbxeCU65nPbbqC9W4wyw
 afJ0eOlNat11+BEJFlW/ANd3hL+G73vqlj/h4QyhLf5TuBdgYr9ZgBDIq4eRcWTYa7lA
 4aDBMwbN6upMfbKOlBlPq0sz0rCZudFXHKXOLtaRmi6dbBUIgRDLtV2vCrWyYCPm3hZT
 GhkgH2WMJysqbcASHUnnUsxL7gCLpT4K0HDrnU6HxiK+LFNzSBR3HIT3wVUuPVGeQfxo
 UcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037608; x=1731642408;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YfMVd5zgGLlmDJONKNkWDqNeaxU55xF3aidA0PfNLzM=;
 b=mgaFASQewhV1mUL/5yaVn/a2T3UIX8bnjYUP5Rh82RNxb5in+vUXrP7+gjjAegtOMi
 lFdFeRNKKS9JIbLbkMkZNCYIR/eHcyLYypl5llP+2nwKB38mnIlExjIuj9Muay9bSNpE
 wVsTP4LXI2CI3bK+iInfQMQUaOtw7eSvMMKw5f0sOTxSrUGRLKKkvc3D3nnvyVRR+xv0
 jD9cGtIbLmWcnH4uBAkYCeQoP7HXrpJeUKHIXB0cCjf/hwipc3ieBdo1OTzob5kjAOn8
 HFVbeJIgIiPCdG1JkDb7gm6LBehQi9ZXqUiLxtdBp/AZq3uTOy9I/DnZgR2wd5aUqKiJ
 rxlg==
X-Gm-Message-State: AOJu0Yxk9c9H034yb3SpxcLoldzjg/aRrC26TJ4AaSX4tyzQfwGh/ecf
 0wQiI4XtqRSrqxZeKc2ZYxyWCqvw33KQeYx5N2suypGH0q8+8WszUbJKwYNG6fg=
X-Google-Smtp-Source: AGHT+IFbv/D14UH4zsx+Bi2cS+Uy+H469uuIRqC1a4LFVcKCfDZnTGg/3BaFsNvQ5ey6JdhJiUIzVA==
X-Received: by 2002:a17:902:d4c1:b0:1fa:1dd8:947a with SMTP id
 d9443c01a7336-21183d65bbbmr14822685ad.46.1731037608564; 
 Thu, 07 Nov 2024 19:46:48 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e46023sm20274485ad.120.2024.11.07.19.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:46:48 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 08/15] efi_loader: device_path: add support for HTTP device
 path
Date: Fri,  8 Nov 2024 00:46:43 -0300
Message-ID: <20241108034643.346373-1-adrianox@gmail.com>
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_device_path.c | 51 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 44d29e7967..ab79364857 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
+struct efi_device_path *efi_dp_from_http(const char *server);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					uint64_t end_address);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 3e02341224..dc79a61196 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1012,6 +1012,57 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
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
+	efi_net_get_addr(&ip, &mask, NULL);
+
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+
+	strcpy(tmp, "http://");
+
+	if (server) {
+		memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
+	} else {
+#ifdef CONFIG_NET_LWIP
+		// The lwip stack does not set env variables for server
+		efi_free_pool(dp1);
+		return NULL;
+#else
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

