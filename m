Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B00CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88E583A3A;
	Thu,  9 Oct 2025 14:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F114A8r2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B431E83A3A; Thu,  9 Oct 2025 14:31:11 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D81C83A2B
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 14:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so980271f8f.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760013068; x=1760617868; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h7+r3HsiC4p/YM7GWsnZZEWU/tAK1fazg2r57gcHHEE=;
 b=F114A8r2ms4UqGoLgGqSJmu2pjwT6vTJYegISOqv/Pzr8E3fvB0OmhRvYcsEQS/bdF
 Hcz2L+lm0o08pz7pflNu7ESyngFrkO4hoQp0qHOyNGl/IHJTfSC+ci4dC7OkaKrG6Dax
 NDA6LUx8jyiUsyjYX93FNOQV/x5LVpz2vi9dnVM1EIsqsJFxK7aysD74CjbF/5u5o7Ka
 emCy/k/+B0f8p/yS59YjA/B8QM8NtyJ4uDauc5PqZphdsbo/Qlf92sYPB6rAIJmOS/+0
 zJTRRs0u6/ZT1DL3m/8HXjl7+tYUuU4nMrxyQHPQnn9caECfPftdLMqfYz7ZjpAl3NUn
 MbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760013068; x=1760617868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h7+r3HsiC4p/YM7GWsnZZEWU/tAK1fazg2r57gcHHEE=;
 b=pqnyyhdIBLdmMkmCEU8AmQ2A7u4ZAlVErSWgdjWE/DS7jSGyHZsKpCnkNWgutCSk4W
 sAsc+gkTWWX9odsD6KPq9qO6oSOgKy3CQO752HtiQ6pnIXPRJuuBSpJbiVRSO6YuWzxY
 dZBJxngpS5S1I+x76AXOZGcW6lA8cODvaFaWw+b9FhCNPQXqlGvp4dhHwxq3f6Q1hM2y
 itwKZdAdKznfgQPGKLP1QTyirRniXucZBmEaotli6cHpB0nWHDHNB9leeYKg0iKCiE28
 sVZy9BicSPz/Y5wvjUGV9Xtr5n5lLWqeI3p+3XRuskQDj+RDCLJWVOcVjCPVsKU+dPsV
 qBZQ==
X-Gm-Message-State: AOJu0YyhtVj39Xd5hUCZ5CEnokFVp5hvLREs0IMEVg925aZ98uUzzcU+
 Ej38AVg3D/yfu3g5p47O2KI3s5nxd3VZGtaBbxDxZpFMJzB0I4i7YCR07mimGN1+19fnFwgKsHO
 cO5bYCO8=
X-Gm-Gg: ASbGncv6O0hxvEEy3GlhCjOFqU+uGO58opbl0IE232mHlHade8HnJ1KfBSaRtX0fQGp
 LwPz7Rcf2I+ni8brFxLPy0nyYqHcTViJXcBOTu+ItFbTxzaLFgr3ktnamXRRUKIcDhF56BZn2cy
 tRg2Za3nmHDmhCYb7Q2Kdx9tTkKinblhMoYsFE16Jn++AxPIWW2X5SZcQ0uiqV7EUT5pCszS2hz
 1oUHTsv48QUFisHi9YER80cXMrAJBfPQJk1lw5l0oCRgRvmWYtqYCixvpS58GOKTaBiuiaa2B13
 LAk+nl+1HLK/CpEvyDGkhyi0VZ7ayFrZGcPolE3xHDKQKoqfSc0CRiMNcJhVePuo3tVJA2GlE36
 wLQCR6B9XtgtyvxqIf6pm9i0viIU+5owYIBrciuz40UjK1ZQazYR9bouKcHU=
X-Google-Smtp-Source: AGHT+IHV8NEecl4iCxTGJIPgQBhGe8rAdm2FLvLHuEEdmXwl+hgVq6WpEzPtfzNwgd6ai3SMtzoNFw==
X-Received: by 2002:a05:6000:401f:b0:3e9:a1cb:ea8f with SMTP id
 ffacd0b85a97d-4267260e2famr5315750f8f.52.1760013068428; 
 Thu, 09 Oct 2025 05:31:08 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:86ff:a12c:54e9:8445])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf183b6dsm45516265e9.17.2025.10.09.05.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 05:31:08 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Benjamin Hahn <B.Hahn@phytec.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH] net: make dhcp_run() common for NET and NET_LWIP
Date: Thu,  9 Oct 2025 14:30:14 +0200
Message-ID: <20251009123034.2441110-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
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

THere are currently two implementations of dhcp_run(): one in cmd/net.c
for NET and one in net/lwip/dhcp.c for NET_LWIP. There is no
justification for that. Therefore, move the NET version into
net/net-common.c to be used by both stacks, and drop the NET_LWIP
version which by the way does not look totally correct.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

 cmd/net.c            | 36 ++----------------------------------
 include/net-common.h | 10 ++++++++++
 include/net-lwip.h   |  1 -
 net/lwip/dhcp.c      | 22 ----------------------
 net/net-common.c     | 35 +++++++++++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 57 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 886735ea14f6..24099764493e 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -134,8 +134,8 @@ U_BOOT_CMD(dhcp6,	3,	1,	do_dhcp6,
 #endif
 
 #if defined(CONFIG_CMD_DHCP)
-static int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc,
+	    char *const argv[])
 {
 	return netboot_common(DHCP, cmdtp, argc, argv);
 }
@@ -145,38 +145,6 @@ U_BOOT_CMD(
 	"boot image via network using DHCP/TFTP protocol",
 	"[loadAddress] [[hostIPaddr:]bootfilename]"
 );
-
-int dhcp_run(ulong addr, const char *fname, bool autoload)
-{
-	char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
-	struct cmd_tbl cmdtp = {};	/* dummy */
-	char file_addr[17];
-	int old_autoload;
-	int ret, result;
-
-	log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
-	old_autoload = env_get_yesno("autoload");
-	ret = env_set("autoload", autoload ? "y" : "n");
-	if (ret)
-		return log_msg_ret("en1", -EINVAL);
-
-	if (autoload) {
-		sprintf(file_addr, "%lx", addr);
-		dhcp_argv[1] = file_addr;
-	}
-
-	result = do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
-
-	ret = env_set("autoload", old_autoload == -1 ? NULL :
-		      old_autoload ? "y" : "n");
-	if (ret)
-		return log_msg_ret("en2", -EINVAL);
-
-	if (result)
-		return log_msg_ret("res", -ENOENT);
-
-	return 0;
-}
 #endif
 
 #if defined(CONFIG_CMD_NFS)
diff --git a/include/net-common.h b/include/net-common.h
index 1112af381a98..78d98e5bba07 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -479,6 +479,16 @@ int net_loop(enum proto_t protocol);
  */
 int dhcp_run(ulong addr, const char *fname, bool autoload);
 
+/**
+ * do_dhcp - Run the dhcp command
+ *
+ * @cmdtp: Unused
+ * @flag: Command flags (CMD_FLAG_...)
+ * @argc: Number of arguments
+ * @argv: List of arguments
+ * Return: result (see enum command_ret_t)
+ */
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 /**
  * do_ping - Run the ping command
diff --git a/include/net-lwip.h b/include/net-lwip.h
index e88e2186635b..c910def5719e 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -50,7 +50,6 @@ int net_lwip_dns_resolve(char *name_or_ip, ip_addr_t *ip);
  */
 bool wget_validate_uri(char *uri);
 
-int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index 531bf2c67057..b798014ebcb9 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -150,25 +150,3 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return CMD_RET_SUCCESS;
 }
-
-int dhcp_run(ulong addr, const char *fname, bool autoload)
-{
-	char *dhcp_argv[] = {"dhcp", NULL, };
-#ifdef CONFIG_CMD_TFTPBOOT
-	char *tftp_argv[] = {"tftpboot", boot_file_name, NULL, };
-#endif
-	struct cmd_tbl cmdtp = {};	/* dummy */
-
-	if (autoload) {
-#ifdef CONFIG_CMD_TFTPBOOT
-		/* Assume DHCP was already performed */
-		if (boot_file_name[0])
-			return do_tftpb(&cmdtp, 0, 2, tftp_argv);
-		return 0;
-#else
-		return -EOPNOTSUPP;
-#endif
-	}
-
-	return do_dhcp(&cmdtp, 0, 1, dhcp_argv);
-}
diff --git a/net/net-common.c b/net/net-common.c
index b064557d5241..442b05975581 100644
--- a/net/net-common.c
+++ b/net/net-common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <dm/uclass.h>
+#include <env.h>
 #include <net-common.h>
 #include <linux/time.h>
 #include <rtc.h>
@@ -48,3 +49,37 @@ void net_sntp_set_rtc(u32 seconds)
 	       tm.tm_year, tm.tm_mon, tm.tm_mday,
 	       tm.tm_hour, tm.tm_min, tm.tm_sec);
 }
+
+#if defined(CONFIG_CMD_DHCP)
+int dhcp_run(ulong addr, const char *fname, bool autoload)
+{
+	char *dhcp_argv[] = {"dhcp", NULL, (char *)fname, NULL};
+	struct cmd_tbl cmdtp = {};	/* dummy */
+	char file_addr[17];
+	int old_autoload;
+	int ret, result;
+
+	log_debug("addr=%lx, fname=%s, autoload=%d\n", addr, fname, autoload);
+	old_autoload = env_get_yesno("autoload");
+	ret = env_set("autoload", autoload ? "y" : "n");
+	if (ret)
+		return log_msg_ret("en1", -EINVAL);
+
+	if (autoload) {
+		sprintf(file_addr, "%lx", addr);
+		dhcp_argv[1] = file_addr;
+	}
+
+	result = do_dhcp(&cmdtp, 0, !autoload ? 1 : fname ? 3 : 2, dhcp_argv);
+
+	ret = env_set("autoload", old_autoload == -1 ? NULL :
+		      old_autoload ? "y" : "n");
+	if (ret)
+		return log_msg_ret("en2", -EINVAL);
+
+	if (result)
+		return log_msg_ret("res", -ENOENT);
+
+	return 0;
+}
+#endif
-- 
2.48.1

base-commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
branch: net-dhcp_run
