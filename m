Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0CED3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA82895F8;
	Mon, 25 Nov 2024 01:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P8SWB8YW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83FDC895F8; Mon, 25 Nov 2024 01:58:29 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23F848952A
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7f43259d220so2793614a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496305; x=1733101105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a16BKITQ7bUj5Rl/BUTdBDKF70Is7E/0WJtXYzoHzek=;
 b=P8SWB8YWyxEhz0+DFp7ZW+ozL0JP97HojP/4B8GpOQwdjBoBPfAnsK3O1GZ+GHCTsi
 SmQ/QmdweXaNVcPdD6io4db09J0sObfKG2cby4AG9uYUNr4KP8tiRH8h3hsxIrdWkzZH
 YiucXeJTS2sGPVuu/Rb+U7283sTz5FOC3XEjKW/jgi9VFuGVNUjB24ZeGOrgtqkwTxsd
 M466BnAUoW8jfNsCtXifx3ft+Iriv1WYjnrBzpwB79OsN/uQBB212mYtna8/yaB7GZ1V
 2h5spd1wjpVnq/t9jHyd0kwzNWYmpYsXU+wCjSw2tmg6Gg/1xa7ii6Khs+wjKoS69XoR
 IBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496305; x=1733101105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a16BKITQ7bUj5Rl/BUTdBDKF70Is7E/0WJtXYzoHzek=;
 b=e7siHZvSiU9fZQROLPxKQKU2qribGPhT6p1HEVqNr+gtM1C1YuDlkdId/IGBcPH1uT
 Z8pep6UHccK6PfP73W2470JT+xC8S9PryDRf1KuhYieyKm1QsoHIrm5aoUl5v0QmkqNn
 Zz6ddpKecl+8LDSNwOeN5TRMWIYSphmFdtiEnv3VXP9fSywzfLYbhQvHghTe26XLW4uo
 wSTQx3VkD5AMWd2bOiqySz+xliw8Poq9lVmHCRWiJIfgmseN5XqHaljU51k3yzunXE4z
 ZWh90vS4W6kcOx2m6SNXlt1RJ0hCRqsNuk0csn4zeE4w81GvCTHucGMUo/rki40JDfFd
 Xb+Q==
X-Gm-Message-State: AOJu0YxphqbpRsPtuD1YEmjoHcyiBmlmiforkF3eqYa2J19d0/A+4zvs
 8fb12J0Lq4C3iD9Z4lDuTmeZo/aizMGwYfaqT9fcwjG/g6ImpVg2lJc0Nxup2EY=
X-Gm-Gg: ASbGnctxVNU7S4nHnB9A7wmz4JAKe8YZPkEuQsQzXE7T7gLNoM0X4EHI0a2mKMuAwkW
 BHXCv3I5Gw/daxQ+8JNaAwAE1Mr8b6XOG+fa2nLf1yrWmNLDXuNp4aMr717/iHHHgSGEgmDn45Z
 n9YlBCNGvSBYIfqij7QPWFU1PMh42FhqlPsubW+xcNFHBLqRTDwB40roaCXmNDW44qQthm7Tt96
 aF/7L2O7bIrO8ZbHeM5dowf58RWuBVl/HDOOPPTrXZM
X-Google-Smtp-Source: AGHT+IGdM7HZx46VZl2ycTMPgaF1BUJ5S+Xvag9uerH5Fej3/ic3ZZCfsBKckzsAiV0u9BRM8pv4wg==
X-Received: by 2002:a05:6a21:33a6:b0:1db:e0ad:8ff6 with SMTP id
 adf61e73a8af0-1e09e397991mr16221881637.1.1732496305515; 
 Sun, 24 Nov 2024 16:58:25 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:25 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 01/14] net: wget: let wget_with_dns work with dns disabled
Date: Sun, 24 Nov 2024 21:58:01 -0300
Message-ID: <20241125005814.236669-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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
---

(no changes since v3)

v3: 
 Removed console output inside efi routine.

(no changes since v2)

 include/net-common.h         |  7 +++++--
 lib/efi_loader/efi_bootmgr.c |  2 +-
 net/lwip/wget.c              |  4 ++--
 net/net-common.c             |  2 +-
 net/wget.c                   | 34 ++++++++++++++++++++--------------
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index b7a519e36d..139cece091 100644
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
index 53c3b169e0..3347a61e74 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -289,7 +289,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	return -1;
 }
 
-int wget_with_dns(ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 	eth_set_current();
 
@@ -323,7 +323,7 @@ int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
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
index 3bc2522cde..4bb1590410 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -530,8 +530,7 @@ void wget_start(void)
 	wget_send(TCP_SYN, 0, 0, 0);
 }
 
-#if (IS_ENABLED(CONFIG_CMD_DNS))
-int wget_with_dns(ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 	int ret;
 	char *s, *host_name, *file_name, *str_copy;
@@ -550,24 +549,32 @@ int wget_with_dns(ulong dst_addr, char *uri)
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
@@ -581,7 +588,6 @@ out:
 
 	return ret < 0 ? ret : 0;
 }
-#endif
 
 /**
  * wget_validate_uri() - validate the uri for wget
-- 
2.43.0

