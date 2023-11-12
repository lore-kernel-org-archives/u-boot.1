Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0783C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23854875B6;
	Sun, 12 Nov 2023 16:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F98lJkUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D022C871AB; Sun, 12 Nov 2023 16:28:05 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A1286E24
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a6acc8e222so149434639f.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802881; x=1700407681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CY7JvnhtrBCF1VR/1FE6QL52U3Wt2EQzOfBysoQ5ap4=;
 b=F98lJkUvaMGAcT6KgkO52lgPiGMdAAbHz3LdK8dRaJRlkXQsV2kUu0lpLP3XP+YIQs
 vQlskcQyZfA0CjNux06x8AzLSsDMhdZMNHbOvcGo5Ub4XvkP4n0FWW6xxVMQcUmEy+0X
 byZ8L5eLs2RnbgL89J0G4mTXTpUm8XcP5rNdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802881; x=1700407681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CY7JvnhtrBCF1VR/1FE6QL52U3Wt2EQzOfBysoQ5ap4=;
 b=inbfRNY5/8jVH3Nafp+7zAGbxCIPbvaqoefE96U1LuuHwX8qedBw1OdgTbRCiyQ05P
 yKMIUp8WkN0JiM3FPTZCGz6lbmSQqAWwDpCeFTbAtuSpcrbpfWggfk5G15favRyQIlCC
 Q9cakn8S3YMQcpWzafo2j3VAvMyKisXPzZ/9Usqyx9dbfOlVaAlKSPSpVLTmXFNCL2uz
 voD5Ut0xW0fv6lBiLvktOskFryAUhFUFpkMrpj3isfz1+LWEYqWIrfCYAYunHT7hhBzI
 FIPsE/AoZ5g5xOMyATLBGtBqJj85RE75CNVMI6JucO6Z8gOpMzUWj3r7BsJk/mm06ktP
 3aOw==
X-Gm-Message-State: AOJu0YwWkm5W9U4mBlFccrQBuTm8ZYrUsWfRRbDBcu0l8wRWj1plmuEh
 8fq0znYt3BvzbwUjQLSLyFFB3DKC/Ij2b/fKjn4FQw==
X-Google-Smtp-Source: AGHT+IEk70jo69jj9eoanKGZ9ZR2u27aZtIvyYBWvjVAbcZclCzL2CQGLtFPQ+DLJRsoQpmvyaRoIQ==
X-Received: by 2002:a5d:9282:0:b0:798:3cb5:ad30 with SMTP id
 s2-20020a5d9282000000b007983cb5ad30mr5766112iom.7.1699802881714; 
 Sun, 12 Nov 2023 07:28:01 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:28:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Andy Fleming <afleming@gmail.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Safae Ouajih <souajih@baylibre.com>,
 Stefan Roese <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: [PATCH 4/7] fdt: ppc: Drop extra size for ramdisk
Date: Sun, 12 Nov 2023 08:27:47 -0700
Message-ID: <20231112152754.130399-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

This code dates from around 2008:

   56844a22b76 powerpc: Fix bootm to boot up again with a Ramdisk

Since then we have added FDT relocation which provides enough space
for expansion. We have also added all sorts of fixups earlier in
image_setup_libfdt() which require more space, with ramdisk being the
least of them.

Therefore this extra hack for ramdisk seems unnecessary. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 54d219da7da1..408369d489ca 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -24,9 +24,6 @@
 #include <dm/ofnode.h>
 #include <tee/optee.h>
 
-/* adding a ramdisk needs 0x44 bytes in version 2008.10 */
-#define FDT_RAMDISK_OVERHEAD	0x80
-
 DECLARE_GLOBAL_DATA_PTR;
 
 static void fdt_error(const char *msg)
@@ -692,10 +689,6 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 		goto err;
 	of_size = ret;
 
-	if (*initrd_start && *initrd_end) {
-		of_size += FDT_RAMDISK_OVERHEAD;
-		fdt_set_totalsize(blob, of_size);
-	}
 	/* Create a new LMB reservation */
 	if (lmb)
 		lmb_reserve(lmb, (ulong)blob, of_size);
-- 
2.42.0.869.gea05f2083d-goog

