Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D23C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 19:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1FFF82A8B;
	Tue, 15 Apr 2025 21:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tkmllmrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5165D82B3D; Tue, 15 Apr 2025 21:34:53 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CBE682B1C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 21:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so5349559f8f.3
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745690; x=1745350490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLR7UW7V70MRs5WGvk88LiGNkaGRuqIFsd+Dt9PTzVA=;
 b=TkmllmrkEdJv2w6ynzH6j0DYgjDe8a3c43JTV13an8AGLpfCp5ILpmCcwfKAA8Zel9
 UTS5ddt4HNqzcwhjRBe7N2c1mHSk59uSd4TMYYRCihKa31KdtHsgSfVbkxNADWywBfPe
 Us3FChnCF0PT0wv2qsq2ky8PDYV380ef+tbtNDoL8xSeCKd0VJ+IEihDAaZLVubxZa1x
 PrIqpkqY60xqFAsmnz52toBhLnm0UUdTPjoT1de7PcgyUZEImxWNrmH7+kYV6XXb6/3v
 WaCsxJGTgHOvQzlvASJgZ0/+0UNFTByNihI00SGc4QX/5polYwJGwgVhaOl+9FL22vxI
 IDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745690; x=1745350490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLR7UW7V70MRs5WGvk88LiGNkaGRuqIFsd+Dt9PTzVA=;
 b=DLpRLQaCxIm4LP2Tdb9CNl9OsI4v4GYDHdPDVi1F8guY/R1ixVk3B3E9+ET45yjkfo
 UsVkM0rSeZfHJ8ww3HJFISRNnSzEj8W1+VbbGX5SKXiEOxTcxFYMUFug+Lv/cOl68SeJ
 X9ZcBEfd0IxDVbxKvHO9CxChF/qCnAOZ8IsvCbHF/Neb14fY2oor3yoIygqAvqA6lPhu
 GmKLF2Do7wfDOSmd+86xxXJsNRIb6k5eNrT8eT864sX0AjZ/a3FhcDqMEDXWSQ9nahU3
 24nGklQ1VjD7REejaxpL49l4v3E2FrU9R2ClryPiXa3D1MlDzRk/x6mRzsEgOYpvIcZZ
 1a5Q==
X-Gm-Message-State: AOJu0YxkpTBC5PShTQnuY61d2sPogLnGZ85p8DBEOqCA3boAiGRMDOAR
 R05MwaUtg8NpLK3utgo++h7cSaHonsNJ5TXKlz5f3N8inJI5b1rZCfiyZPgUfHlC47XA9x2wQtd
 IjnQ=
X-Gm-Gg: ASbGnctGib2sw7VmlY1YyxQZrS3jDcz4Duzo/EO2zv3QIXvTKGfZSMCGRAAakppWNco
 7e9fY+ecYuczaYjAQp3tnU4Fea53RamqajWqnzsg+tYPFvUgbghm0P/ATKXiWJhdQ47l59i7UXC
 t3oAXbqaOSMS8xCauaoqWDD7vZXAKbZcZ08N3Gz3t266Os5ABmpQXRASP0xXCS1BvoSUlUkk5WY
 2PlmZ1hIJQJOcVrdXpONW/8RkKTtyymHEo7nEUrtsYrtjc+7WNcsrLP2S+hpD7lBqEwPAVwvXGa
 XhEBlgVCSpxupdXZA65m3TE6NXICjLem9/GclxMEAY2rIbVpF73wveIq8aI=
X-Google-Smtp-Source: AGHT+IG6xU16vlB+UGC9dAgL9/yDfZ7ZKrpPFBLxc0tJL6aoI0pFPxOvvhNqO0csxaKde/LKdEy/sA==
X-Received: by 2002:a05:6000:4305:b0:39a:ca05:54a9 with SMTP id
 ffacd0b85a97d-39ee2751d61mr589336f8f.29.1744745690474; 
 Tue, 15 Apr 2025 12:34:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6ebc:6ce:770e:95f9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43d046sm15520484f8f.63.2025.04.15.12.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:34:49 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 1/4] net-lwip: change static function wget_loop() to be
 wget_do_request()
Date: Tue, 15 Apr 2025 21:34:26 +0200
Message-ID: <20250415193436.1240804-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415193436.1240804-1-jerome.forissier@linaro.org>
References: <20250415193436.1240804-1-jerome.forissier@linaro.org>
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

wget_do_request() currently does so little before calling the static
function wget_loop() that we may as well rename wget_loop() to
wget_do_request() and put everything in one function.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v4:
- New patch

 net/lwip/wget.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/lwip/wget.c b/net/lwip/wget.c
index ec098148835..2b512a1bc84 100644
--- a/net/lwip/wget.c
+++ b/net/lwip/wget.c
@@ -372,13 +372,14 @@ static int set_cacert(char * const saddr, char * const ssz)
 #endif
 #endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
 
-static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
+int wget_do_request(ulong dst_addr, char *uri)
 {
 #if CONFIG_IS_ENABLED(WGET_HTTPS)
 	altcp_allocator_t tls_allocator;
 #endif
 	httpc_connection_t conn;
 	httpc_state_t *state;
+	struct udevice *udev;
 	struct netif *netif;
 	struct wget_ctx ctx;
 	char *path;
@@ -394,6 +395,13 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
 		return CMD_RET_USAGE;
 
+	net_lwip_set_current();
+
+	if (!wget_info)
+		wget_info = &default_wget_info;
+
+	udev = eth_get_dev();
+
 	netif = net_lwip_new_netif(udev);
 	if (!netif)
 		return -1;
@@ -469,16 +477,6 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
 	return -1;
 }
 
-int wget_do_request(ulong dst_addr, char *uri)
-{
-	net_lwip_set_current();
-
-	if (!wget_info)
-		wget_info = &default_wget_info;
-
-	return wget_loop(eth_get_dev(), dst_addr, uri);
-}
-
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
 {
 	char *end;
-- 
2.43.0

