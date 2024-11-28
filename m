Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE01D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8362989020;
	Thu, 28 Nov 2024 16:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dYZWJN6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3773D89500; Thu, 28 Nov 2024 16:19:29 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB0488FFC
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e9e377aeadso787724a91.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732807165; x=1733411965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LR9Na8EhXK4eg8O3lnlyKy8C3I3x0tJR5eTJ//QZX5Y=;
 b=dYZWJN6dvvxF2D86Hs2VG/c0x7nyKSsx6UAPoBsn/0RLXJJGq9YQCNN/NmosJjCXrE
 6HfaGDwOUGL3wSEBWnLod5RPP3i0WaNZWEsw0dHPkyhyqnjP75W2Zg25/ST4t0kOWJYX
 PGmdgMcFmGgZ8P4JM7em3Kpwb04OXxPveq9tpElEwDjggvSTQCvdqJdnGfPpBnk3+rv4
 kNJmjB+GTaYltcga/zkjb4WnaExF4qpp2xhXrHLN1+xf7eNTuoavdqh64Gvj8iNqku1M
 6rYclXuy2tm2KuEV0uEst/3nRQZWMvOOQUCCF46dUP37wL/Pc8Qhn99TNioGF2nZ+pvP
 HwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732807165; x=1733411965;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LR9Na8EhXK4eg8O3lnlyKy8C3I3x0tJR5eTJ//QZX5Y=;
 b=h1cD8PlvpwVI4UcA8Tdyn/NlsGxYWUzrTS0+jdGOzzJ7MqZ1KNcD/6DeAuGV/j/Lqv
 uebF02Ns8bIVnbHzzwC8cwgurnrGAsaKKX5YriGrdCnTHU91yMGQvtfev16pFEw725Gl
 VbAbbRku4KEdCWTphVBjaiSFHXo5HGEDf5mXkyLovDu+mzr0AJbFgnCgGmPsK/9lhYG9
 7KE3Tses3SwCCQCSRm686ligsrFySIJHOfF5HS1xxCgkJVIC9eJHIbnBZYnTxRlA54qQ
 CuOnUlnVBFAfceF9hTSg3xQxtRQHh3b/Mbz3RyJcZ39EFFmZBjxSQCKnwIboiqx99yAZ
 EJSg==
X-Gm-Message-State: AOJu0YyGm+3Z7wNUGV5+//37xVpIlGv6dZLMcWAzlVKXdHiz8W0SCoEV
 LaULjCK9eFAoHO2kf10qdiIaUCbkXVVcOBMAO9//LszvRsdiI3TLmHVDlu3irwk=
X-Gm-Gg: ASbGncvXj+6+nwCEX5Xl7B0hmEG9W7xVG+FyrYkikM6dRPaEQ49KBNbUXJMYLLp9mU5
 gTFnFxp+O2pFcN0s2kfXbKe5mXr9C1e3KQsirZu8z8UmiEoklUr3TLVlX+H7gvSVezri3PjTHDE
 CG2yjq6q0Jx9oyKftH6EqUJ7FVFwun2TP6mFpTfh/FESTBYVXqpehSNJHgZixNGn3Asr4nfPvRS
 SSWZqzh9dnTys5Tg2/L1cLi21Nz5SB/VonYJyPz/+I=
X-Google-Smtp-Source: AGHT+IHB64Of9dfzmohjglzKdTaLFRalkEIpFUbphMHPUB9RWgAurGWo+SYoUi+4qdGBCEYqhGcthg==
X-Received: by 2002:a17:90b:3d89:b0:2ea:61de:38ed with SMTP id
 98e67ed59e1d1-2ee097c294emr7832997a91.26.1732807165325; 
 Thu, 28 Nov 2024 07:19:25 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fb0df0dsm3590885a91.44.2024.11.28.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:19:24 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2] lwip: wget: pass port and server_name via wget_ctx
Date: Thu, 28 Nov 2024 12:19:19 -0300
Message-ID: <20241128151919.605791-1-adrianox@gmail.com>
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
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2: changed commit name
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

