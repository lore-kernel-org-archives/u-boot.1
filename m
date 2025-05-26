Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F060C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAC182B0F;
	Mon, 26 May 2025 12:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jBmg/ZkG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB93082B19; Mon, 26 May 2025 12:16:05 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9BE882B0E
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so20080385ab.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254562; x=1748859362; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=jBmg/ZkG6H1IEAgg3aRNxmcjL7h+rnfQkOzmY1UWl+wfpeLBwcKzYbYUMGTI+SXi7U
 pBz2o74CmlKZCsvEtkLoSwNjCL9EE/8mAesCux7Sb7rqUMKdj16wjARDzZt22F13hFIy
 UU/6Id5gc7IHj0KvHBO2SLp6i2peaTGFXjwQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254562; x=1748859362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQFP2M+hSI0/F4RqhZR9nvNeaybgPUUpM5wZ+Fusg6U=;
 b=OTDatLxPujoxzNIuppKb7nYLgXlUn27zl7gddw3VEU6v8/D7tiliDeDvb4Efj0bhCl
 BfTJnratMUx+mreni3FvjD0MGojyW/HRTq989JCUznA9pNvX5JHuvUNdYvO1skttMN7r
 vjztAs0Fxu6xH8C9PsyrP6eLfuS0kbxKYgZCYfQMUmRqpEkMMk+MeCA1Np0DmyqWqPrK
 fupHux7a5poiyMWohI9Lv502T1Btt3UAWBphB+wM1udM4GXNnno2f5myy1d82qlThowZ
 52owTm4SPi8wMeUjQbId/OtYfB+FBdPEAE83uWydZp71UTFE2ljD4Hc4yaAePg2s4ECY
 NXOw==
X-Gm-Message-State: AOJu0YyAolZwYWXQkJ9aR+LaTgQDSF499sBnprp6NI9ObPs6fArgV3Fu
 3A6s3tHJPYcdsq2Yb4mgLTwVFpKdNfeOArNZZ5qcOBUsGlnmeYD5eD4Uhq2PEPLX7rR92NPV26f
 LFOxMU3E5
X-Gm-Gg: ASbGnctuddXhYGQNDOQKlCevsfIFvI8lOIB0Vkp8SIsLDBPZ61dxeGj4cJxdPlIMeLP
 pAJWSBM+djOeq4krBFsIkS5sMrtKWymIuRx6Bf//0hGV5UVu74mqvGnYuTjkUsDTP/jrTvV1HDc
 lCigc9yaB2WAEK/KQuPOose/hhyjphKSPZQeSHu0vlfjjsN80xA1KZS25K2vrvQ+JXwDQrxmEK4
 MFvv1ryLc7idKVh7Dbfv4/0JsOHmFJRf3xKHlzxcDZ25tjbx5XqpX1YSx9XoADU+Gj7Ex6kkGMD
 TAZJ5fD8lMZeWarXECYV6/EFv+XP+jxdygS9OzovQa+XnKuQnSOfpPu7vS0peNB+o69fbvA2Fq1
 Cml91pFL0+/Vl
X-Google-Smtp-Source: AGHT+IGUJXo7SfN/A97D11u8mbmXjMkJefUjQ9wMynclZtJPUpW58SKyvhZhZdSoXGKEqkkXHU4hQw==
X-Received: by 2002:a05:6e02:1606:b0:3dc:87b5:2ca6 with SMTP id
 e9e14a558f8ab-3dc9b6d3abcmr77324535ab.7.1748254561816; 
 Mon, 26 May 2025 03:16:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 01/25] spl: Adjust xPL symbols
Date: Mon, 26 May 2025 04:14:47 -0600
Message-ID: <20250526101541.3254628-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Update for the new xPL naming, which was missed in a previous patch
which purported to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 common/spl/spl_reloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 324b98eaf98..216c0f36623 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -59,7 +59,7 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
-		  spl_phase_name(spl_phase()), spl_phase_name(spl_phase() + 1),
+		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
 		  buf_size, image->size, image->fdt_size, need_size);
 	if (margin < 0) {
-- 
2.43.0

