Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1949BE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 03:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34BD8893EE;
	Wed,  4 Dec 2024 04:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eHr7ms65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B6189414; Wed,  4 Dec 2024 04:05:42 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD4F89351
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 04:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-215666ea06aso3533105ad.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 19:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733281538; x=1733886338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z76AhAGZcCpItjFjEHF1MRn2dzGJr2eEZXxaOPHne4w=;
 b=eHr7ms65gHxRn1pxLLsmnrhMtt1cydAkkRN7ouO8NOzpZg0rLaDyCLuYv5vCEi8o+l
 VpsCO5GtnmNkmvUxth1Hztv+5TTdUfHXEidF2XZa9dBH7r21zYNJjkHKCkETH+oEl7K9
 DPFKOl3qHC6JOHh+tyXfoUyt7Qb4inQfvydkv65bEjZYsa//O53lWkZVeuZ2is3s+PF7
 GILf9I2FQuakkKFkV/HfAQu8A4D5bj1G0hLstussZJ78qAs/xaX22Xs9tarUtShsIAdU
 tK32QYuIM4wlnT6ra3DufIip3nFfdt6SrBjpSt2kgGNGcUIm2vk0s40Elhn3nTJW9fe0
 5M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733281538; x=1733886338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z76AhAGZcCpItjFjEHF1MRn2dzGJr2eEZXxaOPHne4w=;
 b=HD+6IzeH4re5dktV/YQCw6SDuwrNDga70XqHPAOA2xHPjGwk7bkQw9rULV/Va8ln8g
 NYeDCVESbXsAyqa45R5c3drORQylCGKebubFWNgAxew0ODA6ASTpuRCzMmI8SARlM5sQ
 izKC6IOhxLli8YPRk1ihphYxKI/11ltSYLZ7Q2QAx4gCklSo9ThyEkoGousnTIT6SML0
 GdJ8DJBshZ7VMmNuLyR5NXxt/kOoCTryeHxvh8+NglcmngSKtFPUxJs2s8Zp+5VdZfVr
 TaJrLddCtVwhw0O2gM9ndr19lqluI/oyMduTSIEENKZ3lVoEtXRET24QXHMFzqr+pop7
 RtSg==
X-Gm-Message-State: AOJu0YyDte25CjMWzEkoa+yDxA7gFWOlocTYGo4TkHV44yMz8/z2eCIN
 N+WDSA5yqwl+uFt7yHiv1td+uZ+tS5JAlt/gmGIA15ksHzM4SkC14AZfpo9gV3w=
X-Gm-Gg: ASbGncv3Yk3JB7FGRzxuG4XUOg/NEHZ7XgIuPjbnf9pP0r1mIrzVHUy8+t2F+9XZeWg
 GJwUOBro4rPxpvoNZWTU0iS7DDKxY3jUng2WiBqoPVIdH53ImvTKOipHfeANXIUAEvi6jgGv7js
 t93ASkTaInPrivx9dRtJ3943ZlCdWCYX5g/gwlb3VfiQpV8ovdHTu9iYwF7u5pufq6qJ8QGA4pU
 XevnQ9tE3ZpmHrp6r0l5gO9bxeEEy8T9REdZgKglMg=
X-Google-Smtp-Source: AGHT+IEoSoiX5HER7BNhvH0CljURIAR4SEJqYfNpvPyhpGnbZ7FcpYtmwyhEhZ/jI+ASEGy1GXYOHw==
X-Received: by 2002:a17:902:e88e:b0:215:a303:24e9 with SMTP id
 d9443c01a7336-215bd45df7amr84228815ad.3.1733281537261; 
 Tue, 03 Dec 2024 19:05:37 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215714b4f77sm56196335ad.202.2024.12.03.19.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 19:05:36 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v7 01/14] net: wget: let wget_with_dns work with dns disabled
Date: Wed,  4 Dec 2024 00:05:16 -0300
Message-ID: <20241204030530.2099776-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This was marked as TODO in the code:
 - Enable use of wget_with_dns even if CMD_DNS is disabled if
   the given uri has the ip address for the http server.
 - Move the check for CMD_DNS inside wget_with_dns.
 - Rename wget_with_dns to wget_do_request

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-common.h         |  7 +++++--
 lib/efi_loader/efi_bootmgr.c |  2 +-
 net/lwip/wget.c              |  4 ++--
 net/net-common.c             |  2 +-
 net/wget.c                   | 34 ++++++++++++++++++++--------------
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index c5e314b360..8fc1bac47f 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -501,13 +501,16 @@ int dhcp_run(ulong addr, const char *fname, bool autoload);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 /**
- * wget_with_dns() - runs dns host IP address resulution before wget
+ * wget_do_request() - sends a wget request
+ *
+ * Sends a wget request, if DNS resolution is enabled it resolves the
+ * given uri.
  *
  * @dst_addr:	destination address to download the file
  * @uri:	uri string of target file of wget
  * Return:	zero on success, negative if failed
  */
-int wget_with_dns(ulong dst_addr, char *uri);
+int wget_do_request(ulong dst_addr, char *uri);
 /**
  * wget_validate_uri() - varidate the uri
  *
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 8c51a6ef2e..c6124c590d 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -479,7 +479,7 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
 	}
 
 	image_addr = hextoul(s, NULL);
-	err = wget_with_dns(image_addr, uridp->uri);
+	err = wget_do_request(image_addr, uridp->uri);
 	if (err < 0) {
 		ret = EFI_INVALID_PARAMETER;
 		goto err;
diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index 3d02f26c09..af87e1acd3 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -353,7 +353,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	return -1;
 }
 
-int wget_with_dns(ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 	eth_set_current();
 
@@ -387,7 +387,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 		return CMD_RET_FAILURE;
 
 	wget_info = &default_wget_info;
-	if (wget_with_dns(dst_addr, nurl))
+	if (wget_do_request(dst_addr, nurl))
 		return CMD_RET_FAILURE;
 
 	return CMD_RET_SUCCESS;
diff --git a/net/net-common.c b/net/net-common.c
index 45288fe5f8..e01b0da7d7 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -23,5 +23,5 @@ struct wget_http_info *wget_info;
 int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
 {
 	wget_info = info ? info : &default_wget_info;
-	return wget_with_dns(dst_addr, uri);
+	return wget_do_request(dst_addr, uri);
 }
diff --git a/net/wget.c b/net/wget.c
index 5d70b7a82e..f3b43b06b8 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -535,8 +535,7 @@ void wget_start(void)
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-#if (IS_ENABLED(CONFIG_CMD_DNS))
-int wget_with_dns(ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 	int ret;
 	char *s, *host_name, *file_name, *str_copy;
@@ -555,24 +554,32 @@ int wget_with_dns(ulong dst_addr, char *uri)
 	s = str_copy + strlen("http://");
 	host_name = strsep(&s, "/");
 	if (!s) {
-		log_err("Error: invalied uri, no file path\n");
 		ret = -EINVAL;
 		goto out;
 	}
 	file_name = s;
 
-	/* TODO: If the given uri has ip address for the http server, skip dns */
-	net_dns_resolve = host_name;
-	net_dns_env_var = "httpserverip";
-	if (net_loop(DNS) < 0) {
-		log_err("Error: dns lookup of %s failed, check setup\n", net_dns_resolve);
-		ret = -EINVAL;
-		goto out;
-	}
-	s = env_get("httpserverip");
-	if (!s) {
+	host_name = strsep(&host_name, ":");
+
+	if (string_to_ip(host_name).s_addr) {
+		s = host_name;
+	} else {
+#if IS_ENABLED(CONFIG_CMD_DNS)
+		net_dns_resolve = host_name;
+		net_dns_env_var = "httpserverip";
+		if (net_loop(DNS) < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+		s = env_get("httpserverip");
+		if (!s) {
+			ret = -EINVAL;
+			goto out;
+		}
+#else
 		ret = -EINVAL;
 		goto out;
+#endif
 	}
 
 	strlcpy(net_boot_file_name, s, sizeof(net_boot_file_name));
@@ -586,7 +593,6 @@ out:
 
 	return ret < 0 ? ret : 0;
 }
-#endif
 
 /**
  * wget_validate_uri() - validate the uri for wget
-- 
2.43.0

