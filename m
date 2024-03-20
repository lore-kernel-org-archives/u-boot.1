Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591F6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 08:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2EDD87E2C;
	Wed, 20 Mar 2024 09:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EXmOYnNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B894880DD; Wed, 20 Mar 2024 09:46:16 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2085A87D37
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 09:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34175878e30so1822316f8f.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 01:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710924373; x=1711529173; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1itOGC3iK2pPn9n1B+vVtylYhWBQ0QdpjPw1OYMkUts=;
 b=EXmOYnNVm9YmM8kwVvaQ40CjhkuQqeIlJWhGAbYnAkpz+ATtDrk5eYz3r0mQodmAsH
 PcgyFf3LGl/G9P5JnDWFiaXzlcxo3sgsFGETdjtfgG+ylEHu/JmuneBUoCAqucoaScNE
 Kl8qJ5TjuFk+Yxcs41GWnAqAV6GoaSHyg0IOu73jbrsF6NLAn0geJZjP+TAcpdvmQcFe
 d63wmeKp0sRrNX+TcsyycrPbqj98H/oUAyx6oI0K09KVhwPSe05pQuupXLxi5gXbqdM8
 mhNztV8Nsj/FtM8xDEeLtnovD2VjUeUkj4M/YrfrHzVS+jqT3ZehxmyYYdsby10pqBlc
 nzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710924373; x=1711529173;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1itOGC3iK2pPn9n1B+vVtylYhWBQ0QdpjPw1OYMkUts=;
 b=MzXXxEzr/MrYZL4T6GUkPL8UG5Tt1kZaSn/l+HPxlCZbATo5vrHHwpQ8c6sNSqFavv
 /r25ZQL1RJ+QrPmcVbjOIgKM1y1J7o7mvRCXsmyyRETqTYpezSqjKMQSJZZ4U5Nd0zvH
 yzFF1JksY42y5dFxDmEWiDCT3kGFab3SUvJLz3Ica4ztAXOzV9Wu5eA5GxjsBuCAYW2J
 s29wSN/vA+2aqcauUlqIOloQct9aXWbWxZPmHoW359ShXKUB7cRmQNQ5rVpv35QdNCqe
 K3hy5qi7pFQYfU6NI+N1xz9xC6Dp8ES+VSABxIy3P/PSMPRG/BuH8weWRyXQAg8+y+oO
 unBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlySGCSPiQVWMRFtzuxRA2WkxqkiAUopBPqE8s1iWRec5PmPl86vhxeiLEyy62FO92ObmrN9DPmpkej7CGMvOZvO91fQ==
X-Gm-Message-State: AOJu0YxIpEiJEkm7Nip2cf0+6tL6noafzLix7HeC0v4cF8o9c6CPA9Ym
 A64rImeSVspasQi3IBK4gh7XjlHzmsnrK0MKV50mrfBFMt3SZckpd6plHliJS30AXbcdKRS/BuW
 ecXM=
X-Google-Smtp-Source: AGHT+IFh2RQ4uA9PJS5OCiAOXJGqg/Ie+fY8Jof6gekY8dT6T1pH203NDS0fRA8h1JFk9zMHh48iPA==
X-Received: by 2002:adf:e64d:0:b0:33e:c7e3:b2e7 with SMTP id
 b13-20020adfe64d000000b0033ec7e3b2e7mr980111wrn.11.1710924373375; 
 Wed, 20 Mar 2024 01:46:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm14333312wrq.7.2024.03.20.01.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 01:46:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Mar 2024 09:46:11 +0100
Subject: [PATCH v2] board: amlogic: fix buffler overflow in seria, mac &
 usid read
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-u-boot-fix-p200-serial-v2-1-972be646a301@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFKi+mUC/4WNQQ6CMBBFr0Jm7ZhpBSmsvIdhUWGASQglLRIN6
 d0tXMDl+/nv/x0Ce+EAdbaD502CuDmBvmTQjnYeGKVLDJp0TjdV4Rtfzq3YywcXTYSHbye0pMq
 +KFvbGwNJXjynyjn8bBKPElbnv+fPpo707+SmUGFlc6a7UUXH9Jhktt5dnR+giTH+ANTFeUC9A
 AAA
To: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8633;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oDxTXtnmKu8nkYh49t1KnDwaKSZcP4x49OcbZqtGKfw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+qJU4/wA25T75dlK3HSNUFUGi40uJOXtVTnKqezn
 /X0dqwuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfqiVAAKCRB33NvayMhJ0dVBD/
 9hFip9lVhxtNjE7qvRuKyiW1YhznRuHCXNi4Y1KDhsWkCT9rs0Eg5Wf4gJjPArYXv7UeFz4uR/NcpR
 cTJrwLBFedEMqN1qrhN3ZZWs7bbuDjeg1G1ArLmtlz65ryzapL4t61+7EILwyV9Ghq/QPtACMkTo/j
 47GnX2Dj6mQHg+/CdEfRb7DAwad0IRMOH+iCdJVAyYZl0egPChl+1qc6mD7ZQuaCG0rM/8tVo1P9I9
 J1SPQN6/UhAMIioiVBGAUclE50U48SuHR8QETJGyN9EQj06el/NvIGJn/Mo2hsQEr4aLC+VkB/RVEZ
 mQPnsonaZBOohkC+eZX8ftdonyjLfhZrOf0fXmyk12k/trlOZ1WJbAyLS0M0+iJXrYJEvfe7QFckVt
 MTeU6wJsI5ROYrMJvoQiWfsovnSAO++bFpzS9UZdtn/v7vo+Hc0Umq5z+F4Y86dwkfBZHXxULW3OlB
 kGWmb0obDRW0FHWbHbBDP0MICpMOlNWFoMWqrX+v6kGed3egL0Iz2NmZZO56oHU7KMFyL2Tk6TxqXP
 kF61wR6tkfrfwu4mDLS6ZFr/Ai/rh30MuQcPdjDlLblle+nPkuep/5QsIwqXJW7WQm18029uON/SX/
 xpDgQ2/Fz06cg6M0ACxCLtwqoZOcHiFglGWPJiKop6NSQWsUsZgV2XauBsRQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

While meson_sm_read_efuse() doesn't overflow, the string is not
zero terminated and env_set*() will buffer overflow and add random
characters to environment.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Also fix mac_addr
- Link to v1: https://lore.kernel.org/r/20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org
---
 board/amlogic/beelink-s922x/beelink-s922x.c | 3 ++-
 board/amlogic/jethub-j100/jethub-j100.c     | 3 ++-
 board/amlogic/jethub-j80/jethub-j80.c       | 9 ++++++---
 board/amlogic/odroid-n2/odroid-n2.c         | 3 ++-
 board/amlogic/p200/p200.c                   | 6 ++++--
 board/amlogic/p201/p201.c                   | 6 ++++--
 board/amlogic/p212/p212.c                   | 6 ++++--
 board/amlogic/q200/q200.c                   | 6 ++++--
 board/amlogic/vim3/vim3.c                   | 3 ++-
 9 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/board/amlogic/beelink-s922x/beelink-s922x.c b/board/amlogic/beelink-s922x/beelink-s922x.c
index adae27fc7e..c2776310a3 100644
--- a/board/amlogic/beelink-s922x/beelink-s922x.c
+++ b/board/amlogic/beelink-s922x/beelink-s922x.c
@@ -20,7 +20,7 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[MAC_ADDR_LEN];
+	u8 mac_addr[MAC_ADDR_LEN + 1];
 	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
 
@@ -41,6 +41,7 @@ int misc_init_r(void)
 			tmp[2] = '\0';
 			mac_addr[i] = hextoul(tmp, NULL);
 		}
+		mac_addr[MAC_ADDR_LEN] = '\0';
 
 		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
diff --git a/board/amlogic/jethub-j100/jethub-j100.c b/board/amlogic/jethub-j100/jethub-j100.c
index 6a2c4ad4c3..010fc0df7d 100644
--- a/board/amlogic/jethub-j100/jethub-j100.c
+++ b/board/amlogic/jethub-j100/jethub-j100.c
@@ -17,7 +17,7 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[ARP_HLEN];
+	u8 mac_addr[ARP_HLEN + 1];
 	char serial[SM_SERIAL_SIZE];
 	u32 sid;
 
@@ -34,6 +34,7 @@ int misc_init_r(void)
 		mac_addr[3] = (sid >> 16) & 0xff;
 		mac_addr[4] = (sid >>  8) & 0xff;
 		mac_addr[5] = (sid >>  0) & 0xff;
+		mac_addr[ARP_HLEN] = '\0';
 
 		eth_env_set_enetaddr("ethaddr", mac_addr);
 	}
diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
index 185880de13..0b781666e9 100644
--- a/board/amlogic/jethub-j80/jethub-j80.c
+++ b/board/amlogic/jethub-j80/jethub-j80.c
@@ -27,9 +27,9 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
-	char usid[EFUSE_USID_SIZE];
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
+	char usid[EFUSE_USID_SIZE + 1];
 	ssize_t len;
 	unsigned int adcval;
 	int ret;
@@ -37,6 +37,7 @@ int misc_init_r(void)
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 		else
@@ -46,6 +47,7 @@ int misc_init_r(void)
 	if (!env_get("serial")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 					  EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial", serial);
 	}
@@ -53,6 +55,7 @@ int misc_init_r(void)
 	if (!env_get("usid")) {
 		len = meson_sm_read_efuse(EFUSE_USID_OFFSET, usid,
 					  EFUSE_USID_SIZE);
+		usid[len] = '\0';
 		if (len == EFUSE_USID_SIZE)
 			env_set("usid", usid);
 	}
diff --git a/board/amlogic/odroid-n2/odroid-n2.c b/board/amlogic/odroid-n2/odroid-n2.c
index 2135457edd..a4bcc62174 100644
--- a/board/amlogic/odroid-n2/odroid-n2.c
+++ b/board/amlogic/odroid-n2/odroid-n2.c
@@ -107,7 +107,7 @@ static int odroid_detect_variant(void)
 
 int misc_init_r(void)
 {
-	u8 mac_addr[MAC_ADDR_LEN];
+	u8 mac_addr[MAC_ADDR_LEN + 1];
 	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	ssize_t len;
 
@@ -128,6 +128,7 @@ int misc_init_r(void)
 			tmp[2] = '\0';
 			mac_addr[i] = hextoul(tmp, NULL);
 		}
+		mac_addr[MAC_ADDR_LEN] = '\0';
 
 		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
diff --git a/board/amlogic/p200/p200.c b/board/amlogic/p200/p200.c
index 7c432f9d28..769e2735d2 100644
--- a/board/amlogic/p200/p200.c
+++ b/board/amlogic/p200/p200.c
@@ -21,13 +21,14 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 	}
@@ -35,6 +36,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/p201/p201.c b/board/amlogic/p201/p201.c
index 7c432f9d28..769e2735d2 100644
--- a/board/amlogic/p201/p201.c
+++ b/board/amlogic/p201/p201.c
@@ -21,13 +21,14 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 	}
@@ -35,6 +36,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/p212/p212.c b/board/amlogic/p212/p212.c
index fcef90bce5..f6e60ae3af 100644
--- a/board/amlogic/p212/p212.c
+++ b/board/amlogic/p212/p212.c
@@ -22,13 +22,14 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 		else
@@ -38,6 +39,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 			EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/q200/q200.c b/board/amlogic/q200/q200.c
index 3aa6d8f200..47f1566a9d 100644
--- a/board/amlogic/q200/q200.c
+++ b/board/amlogic/q200/q200.c
@@ -22,13 +22,14 @@
 
 int misc_init_r(void)
 {
-	u8 mac_addr[EFUSE_MAC_SIZE];
-	char serial[EFUSE_SN_SIZE];
+	u8 mac_addr[EFUSE_MAC_SIZE + 1];
+	char serial[EFUSE_SN_SIZE + 1];
 	ssize_t len;
 
 	if (!eth_env_get_enetaddr("ethaddr", mac_addr)) {
 		len = meson_sm_read_efuse(EFUSE_MAC_OFFSET,
 					  mac_addr, EFUSE_MAC_SIZE);
+		mac_addr[len] = '\0';
 		if (len == EFUSE_MAC_SIZE && is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);
 		else
@@ -38,6 +39,7 @@ int misc_init_r(void)
 	if (!env_get("serial#")) {
 		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
 					  EFUSE_SN_SIZE);
+		serial[len] = '\0';
 		if (len == EFUSE_SN_SIZE)
 			env_set("serial#", serial);
 	}
diff --git a/board/amlogic/vim3/vim3.c b/board/amlogic/vim3/vim3.c
index 8bdfb302f7..43d7a8e84f 100644
--- a/board/amlogic/vim3/vim3.c
+++ b/board/amlogic/vim3/vim3.c
@@ -151,7 +151,7 @@ int meson_ft_board_setup(void *blob, struct bd_info *bd)
 
 int misc_init_r(void)
 {
-	u8 mac_addr[MAC_ADDR_LEN];
+	u8 mac_addr[MAC_ADDR_LEN + 1];
 	char efuse_mac_addr[EFUSE_MAC_SIZE], tmp[3];
 	char serial_string[EFUSE_MAC_SIZE + 1];
 	ssize_t len;
@@ -169,6 +169,7 @@ int misc_init_r(void)
 			tmp[2] = '\0';
 			mac_addr[i] = hextoul(tmp, NULL);
 		}
+		mac_addr[MAC_ADDR_LEN] = '\0';
 
 		if (is_valid_ethaddr(mac_addr))
 			eth_env_set_enetaddr("ethaddr", mac_addr);

---
base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
change-id: 20240319-u-boot-fix-p200-serial-a017f57caf88

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

