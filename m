Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA1CD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 23:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CB39891B1;
	Sat, 16 Nov 2024 00:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XqAYQXkd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6C0891AD; Sat, 16 Nov 2024 00:20:04 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD485896FC
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 00:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a6bf539cabso4105295ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731712800; x=1732317600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwrPzuQpgNfl76ZpRyLtVROJTaLKyHN2pQPjNTmUKO8=;
 b=XqAYQXkdKALFVaBDBEXcJ2zX3Tfdwkkw0YuntOXb6jei2tv5qt62ZEwXxmR7GtiSjZ
 UzsULlSNJO24NAaXDg0P08MvDap0Bwhx3HZ2/17zWRonATJO8SgibNhW8qTY3vKgXW7R
 wPfOdkYE73WDABTVSr4h9EfJoqu7f3Nuv62I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731712800; x=1732317600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwrPzuQpgNfl76ZpRyLtVROJTaLKyHN2pQPjNTmUKO8=;
 b=g6Zq3B9+ChByhjyNoLO1CV5hgCZHWhnCEA+RniH2jcoRWSxcn0ttu9Xh4ZIYYwOTVP
 Lceq6zJISc+C0bDo9kjeohVx334sbmaNJXd/caKt+IpYrUNmK7RA1a+nP/D5XNA5m5jQ
 SYXAI8eELjimjsq9mBmEUB4wqnyTngTkKAJSPTtPOAWzcZ2ujGxSC0HamC7yikAvVo7Y
 QvwwpqDeseoY2T07Y84eaVo+ypULUmoikFYW3qZHE17q79wnLPkxQtj4dodtlNaJc0rq
 UBoIaxWdNJ/5PGcELWfsGaDyLXcsokT9SqAMWpAZ+Iw2BsY5pdw0Ru3wGYqRoDCvrROD
 3r2Q==
X-Gm-Message-State: AOJu0YxLhOY+rbwvm4AGLP83Hpm/RsjUutex5Zlp+589+5eNJU4en+w4
 qa8d73q5Yy8F9EU1ezavgJg/wEdMeIMezQYUZjWkW+9+2gr48Eib82ktFGeWmbRf6i9XwtWQf4k
 =
X-Google-Smtp-Source: AGHT+IEv6jVSdrit1Hd4LeWL4VquWAskHdIZ3egPSrklG4aYBxwBddz/TN5mptrNJBLvlKOwSfNpIw==
X-Received: by 2002:a05:6e02:3203:b0:3a7:1ab5:5416 with SMTP id
 e9e14a558f8ab-3a7480231a4mr42488045ab.11.1731712800008; 
 Fri, 15 Nov 2024 15:20:00 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e0756def0dsm582798173.142.2024.11.15.15.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 15:19:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v4 09/19] bootmeth_efi: Simplify reading files by using the
 common function
Date: Fri, 15 Nov 2024 16:19:16 -0700
Message-Id: <20241115231926.211999-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115231926.211999-1-sjg@chromium.org>
References: <20241115231926.211999-1-sjg@chromium.org>
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

The efiload_read_file() does similar things to a common function, so
update it to use that instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes in v4:
- Make sure that bflow->buf is set correctly

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f836aa655f5..47a22d5bd0a 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -89,18 +89,17 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
 static int efiload_read_file(struct bootflow *bflow, ulong addr)
 {
 	struct blk_desc *desc = NULL;
-	loff_t bytes_read;
+	ulong size;
 	int ret;
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
-	ret = bootmeth_setup_fs(bflow, desc);
-	if (ret)
-		return log_msg_ret("set", ret);
 
-	ret = fs_read(bflow->fname, addr, 0, bflow->size, &bytes_read);
+	size = SZ_1G;
+	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
+					addr, &size);
 	if (ret)
-		return log_msg_ret("read", ret);
+		return log_msg_ret("rdf", ret);
 	bflow->buf = map_sysmem(addr, bflow->size);
 
 	set_efi_bootdev(desc, bflow);
-- 
2.34.1

