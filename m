Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF68FD3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3886D8927C;
	Fri, 18 Oct 2024 01:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IJDeE/qH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDC88925F; Fri, 18 Oct 2024 01:25:11 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE9908926E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83aad99d6bfso63638439f.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207507; x=1729812307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ky/j/cyd6ts1mX8BLh7CVsdgjQlxcByQjcflje61vzA=;
 b=IJDeE/qH/EDqoyCi8S6VY5O5XNF/DhSsPPqZyBr+GFaakqXKK+jJd5MxKK2Fjsi4w7
 SYlIJiJEI8mllbyp7WcBMMArsG27jRBfg0Oqj/7YFzLOOwCXoY9bNK95lhdEQz9vP/0A
 E4x5t6zzowuHrVLEbZ8UgnTngK3OWKiXng0M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207507; x=1729812307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ky/j/cyd6ts1mX8BLh7CVsdgjQlxcByQjcflje61vzA=;
 b=bwODyGCIGZzoPM4HXzrwUwbpmlTjZGW4N99NUnyA7e++hL4rLzpSsazVjZwzsHnzjX
 OELdk33VPGKwWBP7L7MSy++01/MKbUWqOv2rdSTscrK5p4qHAL55xUmHvTDAb6HXsj0J
 ppnDMUbvhf3QlCdsc7q0AQZUcMzJVOfZAwbNFjMVk6Ijn+Zl9gmiot/tLe8YYpL+smoW
 E+NcJOK86yoKdZTvUWoCBraD2jjicshtBrABjTRADA+aBWI7Rp/HQv+FpvQ0BnfWzY44
 eO/Go7OH7I1Yv2aQTb9oTeswejYslErrr//6OqsfUaJE87gzm/sBujPHljtsdDRyGr/q
 2UAg==
X-Gm-Message-State: AOJu0Yxkbg0osGcBKYYfj4/onFabgaZeoeGixpEW0G0NN4RoLmegBMTF
 nJzKgw3Lovkd8moTOQ+5p7w8YVZyYg6ldAWnAhOaXNvr0Hpb0qXChcLj6/CFUtQcuIMAOMTUAKg
 =
X-Google-Smtp-Source: AGHT+IHML2iT/UGas+j5NJJYa7IANRdQo5/ImqjnpWe1eYi183lcSwD9ahEPJJVIs2RJidbdYHnk/A==
X-Received: by 2002:a05:6602:2c83:b0:832:13ce:1fa3 with SMTP id
 ca18e2360f4ac-83aba62260amr54336839f.8.1729207507310; 
 Thu, 17 Oct 2024 16:25:07 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10ba3454sm117117173.79.2024.10.17.16.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 16:25:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH 26/34] efi: Simplify reading files by using the common function
Date: Thu, 17 Oct 2024 17:24:05 -0600
Message-Id: <20241017232413.724808-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017232413.724808-1-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
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
---

 boot/bootmeth_efi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..f3ddbe71405 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -110,19 +110,14 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
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
-	if (ret)
-		return log_msg_ret("read", ret);
-	bflow->buf = map_sysmem(addr, bflow->size);
+	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
+					addr, &size);
 
 	set_efi_bootdev(desc, bflow);
 
-- 
2.34.1

