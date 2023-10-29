Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF69C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 03:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD1C287C87;
	Sun, 29 Oct 2023 04:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyoM2fYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EE387751; Sun, 29 Oct 2023 04:49:06 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F36A87C67
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 04:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77774120c6eso247390385a.2
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698551342; x=1699156142; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqp8K7NDX2uF5sF2GACuz12BqNBDA9BFOUWsATROQkM=;
 b=NyoM2fYlvd90ck2MalC778/717RI3c433prB3PwbbmPO1Pv2hgpoFxkwOp3nPYP7Vn
 aHTu3xAPfdnl4+UorESPUN32MrwwyJSw0+9VJe7TNMP7B/nusNM8ZGcDL+c42PMQw/k5
 4N88EAL87acr3UxII+KFwWt+N8L1DTI/oD8n74U71EOhGFf9QnSSGwyqe/gFsBx/0OdN
 Ck0+DQeC5um8qd20lPfkGpYnG8aqbipByyG868oaFgVP3HhHe1OcGRxhhGm7zLft148c
 UvaAgv46ongMWeTPzMiJdXLx98SNKHUgiSc8O72hQjVWnVnBvSM6SaS0rjwY/PDz7XFq
 kvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698551342; x=1699156142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqp8K7NDX2uF5sF2GACuz12BqNBDA9BFOUWsATROQkM=;
 b=BhKyRmB/H/p710zr4m1VuuVxdmJJCKefLYlkOvh1WML9l4ROthjtcaaH0YC2T+PuKw
 v2HyxNBhlIhdQkysR8A4qgZyzToBjDAwuW9/1bBoMTyA3tn24zhpZh7SN8ut6o8yPEtQ
 q9p1m9CtxV2WgpycEcI6gi3eLb9BQPSHzRK4mS6d6eOSt/KDX50v0lMULE6lM67wO6m+
 7vSud21YFNZNTFdM9cH1CYBeVZEm5OCSx/hxgI49Hn0QtWrR1En1nR3raDEoQcMe9sXj
 K6uLv9VTRSk5AbFnY6VLfatoip5U2D+OWrPGN/arycA+uNsdm251voEKcce9gaF2RdUx
 KF/Q==
X-Gm-Message-State: AOJu0Yx7k2fKjyhk9xRyp6+BwRi/BitfsSYeczQYTw9cjxZW9LHbBAr+
 jGaHxChrPXMAA7y3XHo6MNeyvoydA+rKzw==
X-Google-Smtp-Source: AGHT+IEhYrDil3iGvbkGpib8lN6T6rgls+G0osjYTbOpipQ6ZTO7q4By9bv4bjUNWxfLlz8SA2dI0w==
X-Received: by 2002:a05:620a:888d:b0:778:910f:d89e with SMTP id
 qk13-20020a05620a888d00b00778910fd89emr5391026qkn.72.1698551342330; 
 Sat, 28 Oct 2023 20:49:02 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 o6-20020a05620a2a0600b007756c0853a5sm2096766qkp.58.2023.10.28.20.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 20:49:02 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,
	Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 11/15] nand: Add function to unregister NAND devices
Date: Sat, 28 Oct 2023 23:48:41 -0400
Message-Id: <20231029034845.1169614-12-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231029034845.1169614-1-seanga2@gmail.com>
References: <20231029034845.1169614-1-seanga2@gmail.com>
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

This performs the opposite of nand_register, allowing drivers to unregister
nand devices. This is probably unnecessary for most regular drivers, but we
expect sandbox drivers to get repeatedly bound/unbound, so this will help
avoid dangling pointers.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 drivers/mtd/nand/raw/nand.c | 17 +++++++++++++++++
 include/nand.h              |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand.c b/drivers/mtd/nand/raw/nand.c
index 3abd82068fb..80017b3dddd 100644
--- a/drivers/mtd/nand/raw/nand.c
+++ b/drivers/mtd/nand/raw/nand.c
@@ -74,6 +74,23 @@ int nand_register(int devnum, struct mtd_info *mtd)
 	return 0;
 }
 
+void nand_unregister(struct mtd_info *mtd)
+{
+	int devnum = nand_mtd_to_devnum(mtd);
+
+	if (devnum < 0)
+		return;
+
+	if (nand_curr_device == devnum)
+		nand_curr_device = -1;
+
+	total_nand_size -= mtd->size / 1024;
+
+	del_mtd_device(nand_info[devnum]);
+
+	nand_info[devnum] = NULL;
+}
+
 #if !CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 static void nand_init_chip(int i)
 {
diff --git a/include/nand.h b/include/nand.h
index c1d7533aaac..fc584f5ef7a 100644
--- a/include/nand.h
+++ b/include/nand.h
@@ -22,6 +22,7 @@ int nand_mtd_to_devnum(struct mtd_info *mtd);
 #if CONFIG_IS_ENABLED(SYS_NAND_SELF_INIT)
 void board_nand_init(void);
 int nand_register(int devnum, struct mtd_info *mtd);
+void nand_unregister(struct mtd_info *mtd);
 #else
 struct nand_chip;
 
-- 
2.37.1

