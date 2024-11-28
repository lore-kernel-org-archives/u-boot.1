Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85911D69112
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E7A89D19;
	Thu, 28 Nov 2024 15:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WPyK5yaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7159E89D20; Thu, 28 Nov 2024 15:37:13 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C98B89D16
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7fbd9be84bdso615679a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 06:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732804630; x=1733409430; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Wn4TrGsEZs39w+teIxV70aJGRYMEMWjXIFmiKGMJ8E=;
 b=WPyK5yaXyQ6I69Y3Ct9fwV5KggSbP4W2tHV8f3zCYYpk3YJ7KvByGW/3apRPaOO3o+
 GnmX0cOmoQQIZJ7sJ2PxY/fGJkugLbiHEQOLhuX3fzG4tHpO3Ltk2ZD2I++Lbi3z+1Pb
 j+8CzgW6QHbYZ80cF40gBr2i+RjOSUpoLC9awEljgtu/GMo8jLYnBSBgCdCjxYN2kK7o
 +Rj+WMV0vlthUo5xBDw9xUIRoh8lJ6XvF6VH7DXkYuoRmLXd2p38Eud1UP3CVTMLuHRZ
 M19H1x4PtopZc8KhDuI7sYlIgXEaICsRf3JAkSwiQYlPh9t+8uSCL3/7ilvd15rhLpPF
 O1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732804630; x=1733409430;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Wn4TrGsEZs39w+teIxV70aJGRYMEMWjXIFmiKGMJ8E=;
 b=uS4yTDK94H2j5FYt4IrI1UEi/lQHaNytRxv6KLabHfIfAwCtykrshi+/WZYAr4xyXQ
 4iYB3GMq0SMPyYJq374NkQf08jegQwlnpfzxoW8tRukjhYcyd3r4TY7yZmRlFol9Q92x
 axOyv9lblwh6IFwHXZiUE/iycW4IyywMOOgl5RdwJczKHLCVrQKbYfu+kN0cBq+i99sl
 Ivv3PWTqlpc0cHexBtAPZpYOAalMk7yr8foZwNPmTHkm2vcpkQRevCNEj6g3yxt+EfHI
 KvcOiGvSy2ZWBw82vnZ+LD0y6Imficlr9pEqs0UK0ROB56/DpZpJ8IOiCpSRykEBC3dw
 jVzg==
X-Gm-Message-State: AOJu0Yz3IFdWMyVU9Z3VZwujLrpTtFZ9f0gh83oZme+P+avczr4wWAWm
 WAHgZ4p++1o62kESw3L85Hqj7Ysr2fiJE6EocLXUkmV0gIz/Hv5iTRxaKcH4T7c=
X-Gm-Gg: ASbGncuIz6Z3hPJFZqcfIFhhXCaAWoWlyTyZIV+jIGHCa3MuRTJM1Je42sQsmUciNPq
 nv5cS0gFo0U0AhuAOuZjkQpjbpwRBk1/7+RA8DnXMUw6EFHSM0re5+FMLtJdT7gZ33Sh28Aa63F
 PSJmj/+lUeuQ2av6bmkjPGlvk7saPZIs+ugecf1eNgoHYmTsyZIzfbUYgh+seC6d4v+T7AXVTUE
 Imq6nfYRar2g/UrBisxpZ58NrpKppQpDuF07Tt94Zg=
X-Google-Smtp-Source: AGHT+IF+BTvuQIaxRuGWL04xqugqID76sh1kT2Xki3cME5xuTXA4seL2o+zHuxIvFvOLYMJndaD4LA==
X-Received: by 2002:a05:6a21:33a7:b0:1e0:be48:177d with SMTP id
 adf61e73a8af0-1e0e0aada5fmr8928007637.3.1732804629577; 
 Thu, 28 Nov 2024 06:37:09 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fc9c2d5af1sm1392775a12.16.2024.11.28.06.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 06:37:09 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] lwip: wget: Fix incorrect rebase of 5907c81 on top of 5907c81
Date: Thu, 28 Nov 2024 11:37:04 -0300
Message-ID: <20241128143704.590211-1-adrianox@gmail.com>
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

  Commit 5907c81 ("net: lwip: Enable https:// support for wget") was not
  correctly rebased on top of the changes introduced by Commit 6cc4d04
  ("net/lwip: wget: put server_name and port into wget_ctx") in next.
  This commit re-applies a  couple of lines from 6cc4d04.

  Fixes: Commit 5907c81 ("net: lwip: Enable https:// support for wget")

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 net/lwip/wget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index af48d741a4..8b3e5cf29b 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -288,7 +288,6 @@ static err_t httpc_headers_done_cb(httpc_state_t *connection, void *arg, struct
 
 static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 {
-	char server_name[SERVER_NAME_SIZE];
 #if defined CONFIG_WGET_HTTPS
 	altcp_allocator_t tls_allocator;
 #endif
@@ -297,7 +296,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
-	u16 port;
 	bool is_https;
 
 	ctx.daddr = dst_addr;
@@ -307,7 +305,7 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	ctx.prevsize = 0;
 	ctx.start_time = 0;
 
-	if (parse_url(uri, server_name, &port, &path, &is_https))
+	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
 	netif = net_lwip_new_netif(udev);
-- 
2.43.0

