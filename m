Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A9EE77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1ED989734;
	Fri,  6 Dec 2024 03:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tw37Dl9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA1F89729; Fri,  6 Dec 2024 03:37:31 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 136C18918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a777958043so6529175ab.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452647; x=1734057447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnFaitV/n0GPg6YYhPB8/MET0vxlWv6+/wH9w65GJCY=;
 b=Tw37Dl9r1CbCXSqXw2PbEy+AqLDrxLVRJ2LkvGvqmCOZvHsVaQ8Ef+zTcbDMvEZUfP
 ridghOygH3lExVXIcoAoGEL0x5Z6gfEwdc/PBX9Vpmd0uIHVvIidBWGcpYFF1T3SXnx0
 CGH+rkRliOcn3erd3oFkwkInGugeZyklHFohM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452647; x=1734057447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnFaitV/n0GPg6YYhPB8/MET0vxlWv6+/wH9w65GJCY=;
 b=QkERJv5p+XOf8/UDAVngyqFpWy5pKC2cVcGDbCQuxCHjkX5mLK7VG+uVZOllsG+hDE
 wRilXc9B/9qxMjybr/58md8P7y3CdkOituqWiDzQ7hYQyyQdIAw/IgCaN6YLWDfkUFbz
 S8fep23v6bwBibVWc9OYvLqS6/SKJNJNl0tkuyS0vpjvtSM6sVr2clmTYuyPe4duIFCW
 XxpwBYMwa3bicBhN9TUD8gNOmeujLkCzTFfNFDOYktHAYghoJuUpxag87KQWq4CNKGkp
 twG4pNYD9p8WZo0EELeaPKRq/NfWaahS51nw0uV6gD854V1xsMJOv/wk614cpzZB65wZ
 4dwg==
X-Gm-Message-State: AOJu0YzoZkL/GFIYr/bKwm/CnObx6gx5QsOG4MBDTrK3gIHrLBVyi+Ii
 VWupoGzz48hagPW1sAYiX6/BxdoWE56SZqxJ0ToQ9ORo/XSEr7j6mKzWBUOFYQnTHxmr56Q+DPA
 =
X-Gm-Gg: ASbGncsvXOOKBaJcJi5StgPMd10FVkaewhvFflzGdk6Da8mU0yh6XgUVkeIz2TXv6Yu
 EEvA7ZimHypMgAZ4SHZDOOYP3OImkxyRQVDdgV2S4xVgg9cDXckomBiIdMwVdo0Tcwqm+fwoqGM
 jPo8UXn42PhTHRI/mByg9LdluSLYPC+yLU0bbA6YztBmn7yKg65zn6g7LbOO/ok8gBJcR9BWLII
 lr0gYr79jvIhtv6F78aM30uY9QsT7Nnvfbl2OSlEJhNKwD68GYPCJJwIuKjtZFRjtiRS07dZXzM
 liq3NO1kKxE=
X-Google-Smtp-Source: AGHT+IGrVZuaMtEuyvSsleP4e7X+b6M8y3x5L4++QMAHysLWmC/XgFemWPSmWvnuY28cxwKXO6N6yg==
X-Received: by 2002:a05:6e02:1c46:b0:3a7:fe8c:b014 with SMTP id
 e9e14a558f8ab-3a811e29199mr17494185ab.21.1733452647276; 
 Thu, 05 Dec 2024 18:37:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 21/46] net: Keep the bootstage functions together
Date: Thu,  5 Dec 2024 19:36:00 -0700
Message-Id: <20241206023626.2456858-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Move the bootstage_mark() function just before net_loop(), so that the
IPv6 code is not in the way.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..deebd5b710f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -413,8 +413,6 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		return CMD_RET_USAGE;
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
 		size_t len;
@@ -428,6 +426,8 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
 	size = net_loop(proto);
 	if (size < 0) {
 		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
-- 
2.34.1

