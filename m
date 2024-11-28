Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2313DD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6781589D1E;
	Thu, 28 Nov 2024 15:44:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="irEruR8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F2A189CED; Thu, 28 Nov 2024 15:44:28 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34AB789CED
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee4980f085so96432a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732805065; x=1733409865; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8jRjekUsiog9gV7bGfnDERJQxL40t3AeCAAY9wJ0Ck=;
 b=irEruR8RiOSs0jei97QRvpJwWQ3U27ZeO2JcAbz0p6+TOxxXRRsVMgqWZ7F1H5rinv
 DenAXHtP7pOsJPIpKf4jhrRbY9HumD2lp6NXtyHBbnxn5Zf5UVrmRSo5A+RC4msiRcYm
 LKFnbeN+xAhbZxN1GxmqodbawfbXrqeZVG3BcOhUXfb7T5N61aOyLTVLMAHIMCylEtjW
 NqoE973bdFH8PDacfEkFGC89aNV7WcpvRaInbbduwReZ8b60+CX92qqXWwASq7F6+4yb
 NMDv8qi+HK8QUR80gTJGv/HrairfJMAxvgUoI1JVwBvRP+ihuVsZDB1OspmMYbzsIiN/
 PAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732805065; x=1733409865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8jRjekUsiog9gV7bGfnDERJQxL40t3AeCAAY9wJ0Ck=;
 b=eagDJxMF7mS30ZDs3xVZ2jrc2pYamd8JobWFUT8zoKW/878CYcb7XIXjbNukb1yY9Y
 SuUpw5uzh5uNBKkQ9yXBYirUIVBif/5BgiC5xyzG+NQ+qOjgVMs6fprz5KSB1iLJBMRy
 FP+ECbXBCPU40IQYNwD80S85ZBZROKWT6Ila0j0hHUqNrJ7k5z15zG1xrnixiLKBvyK7
 8GKeiou30M1eu+W9kmUsdqK66R6jBIn2DWoflm20DOYPRD9JEazBhTd16lyznIrKYYVd
 7y1e31Zh5hZ/IkOC8yN6KpET3DiWF+PERMAvNL1tMam5cXAvzQgHzP1oyQheLH9ixacF
 5t7A==
X-Gm-Message-State: AOJu0YwtbULh4SM6yh3FDWkdP7+8xNBSMwt/ZLXkbBnvz8IflTVQNDwX
 S+nCrjOY5ahcg7+SVOPHjD6VPBRAD5xzYO9fNCicPO5X9PcgUMKlxfmN0gvLtdY=
X-Gm-Gg: ASbGncuKJpevvEWtN9nC6/GIaeov0s1WxMxEd9niRywck4KN1ZNwu8qcO06vWo1w+p0
 hIwIe+gkgcvLcqQ6z6YCnT0PSqVf3cCltnQlvBWAbWXPCq+EU1pMDOimXyP479LA3h5+o5ZO13G
 VEvar4NcNy/zOvR5iy2Qn7JnbmtxUDouoQZmdhJVcoWTR1kMgzV1XlsrPDR68KJiKtresFRZHQx
 lgKojnF2jpeI7stLusVm6WgqnWevqJppa+0K/9BFXQ=
X-Google-Smtp-Source: AGHT+IHnW9/Wd/cPdiuJwUbpaxz2B1Bpjyf4ADdi3+H5Ri0aZ+UIT1l+KViwWauYvKzIMtB1lwr2gA==
X-Received: by 2002:a17:90b:1a8b:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2ee08eb148cmr8914273a91.13.1732805064635; 
 Thu, 28 Nov 2024 06:44:24 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee2aff1b77sm1532202a91.11.2024.11.28.06.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:44:24 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v6 01/14] net: wget: let wget_with_dns work with dns disabled
Date: Thu, 28 Nov 2024 11:44:03 -0300
Message-ID: <20241128144416.604126-2-adrianox@gmail.com>
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
index 83ae8a6d15..2becb02f7b 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -355,7 +355,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	return -1;
 }
 
-int wget_with_dns(ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 	eth_set_current();
 
@@ -389,7 +389,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
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

