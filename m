Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B1E95A8E
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 21:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B144D86CBD;
	Sun,  8 Oct 2023 23:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CiYYu9+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCD386587; Sun,  8 Oct 2023 23:36:56 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8084586CFE
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 23:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79fe6da0095so177349139f.0
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696801012; x=1697405812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1IwbD1nhKVjeM2OA5vHd3gfgn5dsvz+8nlhfb3w4e+8=;
 b=CiYYu9+K/6sY3FT/Ud9muU57zplELI1e0QIAG4Sd9rpT6CrgQ17q8VGSILGfeAyACu
 Ez953gr29bvZSxlsWzGzdoCy67k9vgDgZoAvPqcVneohfOf5r206TNhfQW2FsF9sARk+
 36a2lH0MGjq78mDouI6GwfyEG7VKj3HSo3Rks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696801012; x=1697405812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1IwbD1nhKVjeM2OA5vHd3gfgn5dsvz+8nlhfb3w4e+8=;
 b=eI0jrpY6NjoMXVNRNGGaCgyVmaAWIHn9XjcDkn6LLEfnNbEhjsMTDTeBF+jo4oamHg
 Zds6E7QayoQnotqLeDpkHp3OSmhevGB5Y2I6UagufgsX/id/AZVdPoZKPvbNRZtozMt1
 tnJMVJIXxePCR88fgSmVDpKFDrn3QcxAiQQANNa+CIpVUbZ6tmw7K6WAQo8b/sSC8Rcj
 l1SvW8oRWTo9dhOJgJStW2udsh/qDwgdcz9C6IWbvfdiGGHPzpue6W5tWY596pJquLJY
 n8SxjMhVM9boluffxpJPbFzB27D1qO9NEr5pLRCiUT8amH6befi/bTEHFoLL2pUbhhjh
 Pr6g==
X-Gm-Message-State: AOJu0YwUGlTACbJRkPb7k72wh3GO4TDq+HAjq/hMHeyq0NvY24MEYxBm
 dEUP6rXGN8GzckPoksSNY1P37zznW27kCvvyoeo=
X-Google-Smtp-Source: AGHT+IGx8cj0Xy7lr0LWchjT8f8OVplyqbomVZYJ0h1v8RzOEGKyZoesih3+MbAPlA8hbD3ugkRs3w==
X-Received: by 2002:a05:6602:52:b0:790:9728:4014 with SMTP id
 z18-20020a056602005200b0079097284014mr17938073ioz.11.1696801012155; 
 Sun, 08 Oct 2023 14:36:52 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 f12-20020a02cacc000000b00430bb70004dsm1751826jap.103.2023.10.08.14.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 14:36:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/5] smbios: Move the rest of the SMBIOS2 code
Date: Sun,  8 Oct 2023 15:36:41 -0600
Message-ID: <20231008213646.622002-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
References: <20231008213646.622002-1-sjg@chromium.org>
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

Move all of this logic into the else clause, since it will not be used
for SMBIOS3

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/smbios.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 96f67cd6ad7b..c7a557bc9b7b 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -464,9 +464,8 @@ static struct smbios_write_method smbios_write_funcs[] = {
 ulong write_smbios_table(ulong addr)
 {
 	ofnode parent_node = ofnode_null();
-	struct smbios_entry *se;
+	ulong table_addr, start_addr;
 	struct smbios_ctx ctx;
-	ulong table_addr;
 	ulong tables;
 	int len = 0;
 	int max_struct_size = 0;
@@ -486,9 +485,7 @@ ulong write_smbios_table(ulong addr)
 
 	/* 16 byte align the table address */
 	addr = ALIGN(addr, 16);
-
-	se = map_sysmem(addr, sizeof(struct smbios_entry));
-	memset(se, 0, sizeof(struct smbios_entry));
+	start_addr = addr;
 
 	addr += sizeof(struct smbios_entry);
 	addr = ALIGN(addr, 16);
@@ -523,8 +520,11 @@ ulong write_smbios_table(ulong addr)
 		printf("WARNING: SMBIOS table_address overflow %llx\n",
 		       (unsigned long long)table_addr);
 		addr = 0;
-		goto out;
 	} else {
+		struct smbios_entry *se;
+
+		se = map_sysmem(start_addr, sizeof(struct smbios_entry));
+		memset(se, '\0', sizeof(struct smbios_entry));
 		memcpy(se->anchor, "_SM_", 4);
 		se->length = sizeof(struct smbios_entry);
 		se->major_ver = SMBIOS_MAJOR_VER;
@@ -545,9 +545,8 @@ ulong write_smbios_table(ulong addr)
 								   isize);
 		se->checksum = table_compute_checksum(se,
 					      sizeof(struct smbios_entry));
+		unmap_sysmem(se);
 	}
-out:
-	unmap_sysmem(se);
 
 	return addr;
 }
-- 
2.42.0.609.gbb76f46606-goog

