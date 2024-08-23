Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6733C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14A6188C50;
	Fri, 23 Aug 2024 15:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l/9OxuMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0300588C17; Fri, 23 Aug 2024 15:50:10 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B6DA88BFD
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4281ca54fd3so16385795e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421007; x=1725025807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=l/9OxuMY0ciMDG4rbtFVaO7UU68bpKlVurBNefbGWkbwigsM1WOjYQd/+ABxhaY0FD
 KiuVdwKO9aNTTJQGTzYlXJDK7P94HiSlliwueuo9MW5XW7AuYLP6rlnguM7z+CPabgTR
 5FJ6BjPq6GdcDkKsmdmHCLh5AzNoteMg73flDHmESDek33ZATwgccpfVI4etNGMYyU9q
 Wp2klQQqth2tRRGslqUofxMkNVMg96p6rHXonTP8JraD3t59KZQ/T+ZR31VeUvQujk+Q
 OC/L0La1xiJrvvKj2bslej4d3/Zz3fo0TUXFV4jnGHSpHbE4bf/GyH55km+wpbVDa0Cr
 mQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421007; x=1725025807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WQUv/HNCuMRxpKPtwooUf712RMBAKG5Q2VDiw47vrAI=;
 b=Dl7gIRJG4CUnncIAs5IdXszji4BUO+DFVEk618vDDVghSZhEjNLLj3EbzKESeImgx8
 pPu5Szd6itrapLPYg8iBLvI9ZtAT+/1ckOqgAbPKvXYl+Tr1SkOiaxyAvgKUAvXpbY6J
 i2PHmyQI0Bdqdcga32zQTUjhBq5mOMDqma+NgK3Rc5SMfpjGT7WtNQt/9cCdZIBketqv
 uAYIebjZdelLvglY8EBLaSbRCM5a0F1SeRraI0SBxnqo7lz9eRPS4trjxNXWUnWBbe2u
 5lXgZX9EC+Zm6MbMnp1oDtEUr+BC1BknD7pacMNE6rgMP1NEc2Scy2wQA6IWVlt7TFBy
 GOfQ==
X-Gm-Message-State: AOJu0YzBykVqzCZ/UAIXkyZqgUPYboVCNMFB6kJjdgEsVMjTjk9F3Ywa
 KJqq7PoMKxJ+Ogz18kS9Uvy/+WvjZ9Q5EO0frto4Ub2brRzyfEVQKoWSs1iXMne0wNwSbSvtt53
 ZzJGw+mwQ
X-Google-Smtp-Source: AGHT+IEDbLZJeDMtZgh4ACp1MJGJf1zdX3KgXtBSShrDvDljzVVJovpOwTKlIpxXsJ8v/U9O45ILrg==
X-Received: by 2002:adf:959a:0:b0:367:9625:bd06 with SMTP id
 ffacd0b85a97d-373118e3552mr1540055f8f.42.1724421007222; 
 Fri, 23 Aug 2024 06:50:07 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:07 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 27/37] cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
Date: Fri, 23 Aug 2024 15:48:31 +0200
Message-Id: <316f7bf4005999e127655ad13426cd48152e29a7.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

Support "bdinfo -e" when lwIP is selected.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 cmd/bdinfo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
index 437ac4e8630..472e5c42b08 100644
--- a/cmd/bdinfo.c
+++ b/cmd/bdinfo.c
@@ -151,7 +151,7 @@ static int bdinfo_print_all(struct bd_info *bd)
 	bdinfo_print_num_l("relocaddr", gd->relocaddr);
 	bdinfo_print_num_l("reloc off", gd->reloc_off);
 	printf("%-12s= %u-bit\n", "Build", (uint)sizeof(void *) * 8);
-	if (IS_ENABLED(CONFIG_CMD_NET))
+	if (IS_ENABLED(CONFIG_CMD_NET) || IS_ENABLED(CONFIG_CMD_NET_LWIP))
 		print_eth();
 	bdinfo_print_num_l("fdt_blob", (ulong)map_to_sysmem(gd->fdt_blob));
 	bdinfo_print_num_l("new_fdt", (ulong)map_to_sysmem(gd->new_fdt));
@@ -197,7 +197,8 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		case 'a':
 			return bdinfo_print_all(bd);
 		case 'e':
-			if (!IS_ENABLED(CONFIG_CMD_NET))
+			if (!IS_ENABLED(CONFIG_CMD_NET) &&
+			    !IS_ENABLED(CONFIG_CMD_NET_LWIP))
 				return CMD_RET_USAGE;
 			print_eth();
 			return CMD_RET_SUCCESS;
-- 
2.40.1

