Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6999C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 23:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E5E829E4;
	Fri, 16 May 2025 01:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qw15ZRog";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E371D8059D; Fri, 16 May 2025 01:42:03 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0C7806D8
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72ec58e45baso1325010a34.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747352520; x=1747957320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBLt15Osj0oPZSh3B6zrcReC2GiGEwyjHjXGIwY9VDo=;
 b=qw15ZRog7z4VRvnLD2wqCJ28G8b7a99KObiUvnShy+rJEdsqMZwzq08h1kGiMRuzF3
 Kzn2OCSfMKW2VWmgEf2IaB70rDVsb1KpZDTbODnBRkKeXt+vVqDo5VQXwaXaY2t2YnJf
 CRDhJiwXCJQ97wspcsr9Sw6fMTFvUpkeQcDzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352520; x=1747957320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBLt15Osj0oPZSh3B6zrcReC2GiGEwyjHjXGIwY9VDo=;
 b=G0DGSBbd6QZQs6yoeXQM9Wxv1wh5I68Zyla20XEcF628AJyaz1O1wXVkmV1s/hUWCY
 YnV2GGa2YEXkKjq0GLcWryclaoRJ/0eiiXF0lywvWTBHKoE6LWRW+8NQnqTOFNlbCJ4U
 0iOEHOJz/iIJFZyoef63UwyU5FhCGCRx6Q6Nwt116rl/Noip41b/R5qoPvg5w6nWlz1m
 4Ugi+zCXvZuQhHphPuU3QQcpfVJqpfSfXjGUry7QbRM9oiC4fPqaF4gRn4tKuTNYqqFE
 TSAft5Ll03ojBs/2tlKYSuGv4VZ2bdbgBc6Pex0KQ2vbl5u6ZpNPxTlSZrK5ZqTtVLPG
 Dm0g==
X-Gm-Message-State: AOJu0YyCCTIQNLE01mEaNYtqpZ737PvvCXQ3qlmf1yHfAITTpn0N7kjr
 IxtSn+5aaUOigktDVNt2Ezvp8Asww7PJPjvG5Q/gPA5eTHfl33bilyQTC4ps16GiJ41oZdgL6Xk
 0DpjuwBI=
X-Gm-Gg: ASbGncvHpjoPgJTce81iHkcrE2hcv9aG0rzXxPgUQEZ1gFoyqEa0GnMfjYOp5uiDhOK
 iU67DGPdpgpD3x+Ru+JgAm5Z2KzUNJkGKoxDa/6GXbfgd4r/Z3HvzJlD2ScCt0ed9wLtMxDuy0+
 g2QtiBizKBNSMaOPu6Ujur27ZXBh+GDTgVwbc9cS5/BiE6a4guhXv3c2f2NDuHga/A2S5IkQNvS
 SpvLeRddCO8063iDOs0UqM8jmnkv/rSqH2jNqfacVsK+fZIwPAOn7G4TfDzOVE0CUpg2R4AEbMb
 4RCiKAbN1Vb2ZRDy4oXhWqkQmQ7uj6JTpk7fQpnVgD32HlcO9oshErecGnJ5PxcoemnTFOWPjhY
 6WxFjxFCXHskz1QI=
X-Google-Smtp-Source: AGHT+IHq1uHB259CLlVyjvsuWFMYdOaUoC7aqF5so5GdpdzMmwNshNi+Mgu6glyXkeOylgilt10cfg==
X-Received: by 2002:a05:6830:3696:b0:72b:a175:2f0d with SMTP id
 46e09a7af769-734f970403emr441345a34.0.1747352520288; 
 Thu, 15 May 2025 16:42:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6b3a9b3sm147559a34.52.2025.05.15.16.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 16:41:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/22] net: Remove env_get_ip helper() function
Date: Thu, 15 May 2025 17:31:30 -0600
Message-ID: <20250515234154.1859366-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515234154.1859366-1-trini@konsulko.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
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

Currently, we have the function env_get_ip which takes an IP address
in string form and returns a struct in_addr representation of that
address. It is however little used and means that a number of places
indirectly (and unclearly) get <env.h> via <net.h>. To clean this up
start by replacing env_get_ip() calls with string_to_ip() calls. This is
generally a no-op as env_get_ip(str) is an inline of
string_to_ip(env_get(str)) but in a few cases we can or already have
stored the result of env_get(str) and can save the additional call.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v3:
- New patch

Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
---
 cmd/elf.c                |  2 +-
 cmd/net.c                |  2 +-
 drivers/net/netconsole.c | 11 ++++++-----
 include/net-common.h     | 13 -------------
 net/link_local.c         |  2 +-
 5 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/cmd/elf.c b/cmd/elf.c
index 6b49c613703e..5e0ee30a7c86 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -247,7 +247,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 			ptr += sprintf(build_buf + ptr, "e=%s", tmp);
 			tmp = env_get("netmask");
 			if (tmp) {
-				u32 mask = env_get_ip("netmask").s_addr;
+				u32 mask = string_to_ip(tmp).s_addr;
 				ptr += sprintf(build_buf + ptr,
 					       ":%08x ", ntohl(mask));
 			} else {
diff --git a/cmd/net.c b/cmd/net.c
index eaa1de5295f2..886735ea14f6 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -564,7 +564,7 @@ int do_sntp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	char *toff;
 
 	if (argc < 2) {
-		net_ntp_server = env_get_ip("ntpserverip");
+		net_ntp_server = string_to_ip(env_get("ntpserverip"));
 		if (net_ntp_server.s_addr == 0) {
 			printf("ntpserverip not set\n");
 			return CMD_RET_FAILURE;
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1943de8ba730..c2ce4a80d120 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -61,8 +61,8 @@ static int is_broadcast(struct in_addr ip)
 
 	/* update only when the environment has changed */
 	if (env_changed_id != env_id) {
-		netmask = env_get_ip("netmask");
-		our_ip = env_get_ip("ipaddr");
+		netmask = string_to_ip(env_get("netmask"));
+		our_ip = string_to_ip(env_get("ipaddr"));
 
 		env_changed_id = env_id;
 	}
@@ -81,11 +81,12 @@ static int refresh_settings_from_env(void)
 
 	/* update only when the environment has changed */
 	if (env_changed_id != env_id) {
-		if (env_get("ncip")) {
-			nc_ip = env_get_ip("ncip");
+		char *tmp = env_get("ncip");
+		if (tmp) {
+			nc_ip = string_to_ip(tmp);
 			if (!nc_ip.s_addr)
 				return -1;	/* ncip is 0.0.0.0 */
-			p = strchr(env_get("ncip"), ':');
+			p = strchr(tmp, ':');
 			if (p != NULL) {
 				nc_out_port = dectoul(p + 1, NULL);
 				nc_in_port = nc_out_port;
diff --git a/include/net-common.h b/include/net-common.h
index e536968a92bb..2ca565fe4edc 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -456,19 +456,6 @@ void net_process_received_packet(uchar *in_packet, int len);
  */
 int update_tftp(ulong addr, char *interface, char *devstring);
 
-/**
- * env_get_ip() - Convert an environment value to an ip address
- *
- * @var: Environment variable to convert. The value of this variable must be
- *	in the format a.b.c.d, where each value is a decimal number from
- *	0 to 255
- * Return: IP address, or 0 if invalid
- */
-static inline struct in_addr env_get_ip(char *var)
-{
-	return string_to_ip(env_get(var));
-}
-
 int net_init(void);
 
 /* Called when a network operation fails to know if it should be re-tried */
diff --git a/net/link_local.c b/net/link_local.c
index 179721333ffc..f6425ff3df26 100644
--- a/net/link_local.c
+++ b/net/link_local.c
@@ -106,7 +106,7 @@ static void configure_wait(void)
 
 void link_local_start(void)
 {
-	ip = env_get_ip("llipaddr");
+	ip = string_to_ip(env_get("llipaddr"));
 	if (ip.s_addr != 0 &&
 	    (ntohl(ip.s_addr) & IN_CLASSB_NET) != LINKLOCAL_ADDR) {
 		puts("invalid link address");
-- 
2.43.0

