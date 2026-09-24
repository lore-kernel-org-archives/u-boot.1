Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7AEC98311
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 08:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFBAC40E00;
	Thu, 24 Sep 2026 08:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jVcvTbCgYcAZ; Thu, 24 Sep 2026 08:59:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98E7540E65
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790240359;
	b=ddOagfTXxZwg16vfrJGHM4vhMnLjIOHVmoAVAC+aCJjkpKPnkXX8qhKtRjqm9317Qi8g
	 qyNH9uMuxAIacdwHE1a6l4VbZGhzGVCVajfKGjhYZ1sKu/lSwYOYQEBsFOFJYeDQpSgqz
	 OTy2V4m2Ske2gd70v888qXlZ4hTCwOl45t2yrojVs816qiIucU8sFTtF/livX9P0mMxeO
	 bMqydROKPCo3l93RX0HUOC74ZupT6q4HKZHLl0bjj04PD0d6GIFUNPdvNb7Bw7q3Jmp9I
	 vWrLTB1DSGGNO0dO4aGrnL6+pgERFr5DE/A590l8MrW28AWPJWiI68le8NLrNDh+9Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790240359;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FuAmXAYmQM/Lw09kV6qF8OT69JB8Tv7EYE0cwgq/4Sw=;
	b=rtfTAs9TIl8o1uE5NqasQzSSMAKh7w0Lzv4dPATPRjuVdk+qMuZHa1K/AUqI0Y+RZggm
	 /xi7l6LuRBjQVtyOI32ftNd0a9KtCKLhuPAbWJx2XH02VXivZmw6FExIvq+NZpt3020YL
	 yDvGRtfmK4zxdvGEiBeiqkVWtD7F7PpotBmu+X3yLCl/LLMogI8lHHvOGLD+ii3rR8ZK1
	 +iiq97R91g7Qepe5ADF1FqyfghGqydDdl52XS3GmNc8ZwGoCbHOp1OoKzwzY9+4mnZqGg
	 yrJgBSA7iqIYEVbVUGhX2iAuKesbSbEEM14QLJ3+1n23k1hi+vvpGZrXv/RDjOfBuyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790240359;
	bh=FuAmXAYmQM/Lw09kV6qF8OT69JB8Tv7EYE0cwgq/4Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TFG0fDelnwd1RYDx/tKgKqMnmnB/7CI8a+bVQobQDrZncMCbWnJrztVGVO+WbxOOa
	 dd6thtv2Gh2wcXJXXY7D2dxp6uPJQYZMRTlaBBGaVZ7p8DnaUulwkxaUpWADLuzLav
	 YZvCIMvCInVeyHBqxGZJ+GTvnIzWe9uNlkNGEDy8ASxC2xsFVcNcsyrlbbJNwg2L4K
	 U9RpuQXg7EvHT9HrB46ue81dhTMHrOJ+QOHq9QIB4PGkIgL8bIPsCROnrJsy/ekLB7
	 iH2idDdCOY7LqfdNKr+VFyQHMqJU9ScpKIQ42D0y5Deg2yyKgzU80UoPKanpWb552w
	 hLXCBrfnnnPYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98E7540E65;
	Thu, 24 Sep 2026 08:59:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 446981344
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0DB3C60B5C
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id begeOvpt-bVG for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 05:55:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B511360B22
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790229334;
 b=UN1trzqGSl8/aopdOHkUIeAbtbpsVelo67NMiakd3Fa57TJmITkyVojQjUXveetaViw9
 o+5J7XlDdL7uWSD1rL5Pk92NO2YZ0HI4LOZ6TP30aT74T8br7tfqUdspz4oWqqWVrKKs/
 NKKLUcLAoecdaJL4rvMvfZEE9yb66BC8QUhW1NgHnfKiTUUSxjHXPmWs32EqeNE+pJZPd
 c13TJNjhzIryXVHQKDoLkKpUW9iQeoOHmrP0DvnGyo8YUThFTnIC2xyP2mLOoCwdldgc2
 mEsM3QxaBVbUZhq4afN0PjBVlO2PkSqzkjiPQBjL1vBKz/PjcdFhVqmGSZGS9a4UhHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790229334;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=FuAmXAYmQM/Lw09kV6qF8OT69JB8Tv7EYE0cwgq/4Sw=;
 b=bAW4S082VwhrYKjJKVgplJ8XDfF2EjleaHZkxFm/0p4kU2jzd1uU4o9DM4Tf3BeqAFaN
 zvsNr+UR2rxAPs4Oyd61M+pDoEZ+Cye6DxfKcobacSlSoWd5kwrmVggvI6nRUO6hYHPcL
 PJtFmf8ceFQPUu6Vr2zl8ZNTkjZGG2zxMYUdd/Oda49IYAGl9uWYKcyHoNUKrcgPGZ/xL
 FYpjk2TscSJMgnyhwYCWSG3m0+cF70bNQzj9IHlgEGE3fDpiCt+ZWP4RRHuZQ1ctWw6sZ
 UJwwHvvo5fCu0xIC/AyTqIYBbWXp93MmoM++soVzTilKhw0E+9R0p9+zX1iMRjnB9zg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=njaEp+62; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=njaEp+62
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B511360B22
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:34 +0000 (UTC)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 79E903F600
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 05:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1790229332;
 bh=FuAmXAYmQM/Lw09kV6qF8OT69JB8Tv7EYE0cwgq/4Sw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=njaEp+62jISct6RuKSyqQ5WurWzzcyOjQioRK+ZJn8AukunjyJIrAu8BI3cMPno6f
 UuaxsDBBsAAdJi1ZAxULf68p48QVv6NUfX15BRmHpq3V5Z9/PejqyKjKH/yaYOM3pw
 LRF/rasK7EI1f7+0gRI2hZkrf/WfYD1ZoQaDxdJpj/EElwXGVsiO7TCKKBbCIDzaFY
 mbn3a33L4rOUfkCqAQy49tMxh856pHLUy2dsmOpW5UQPuGTSDH/cT+Yvk9jjcWWHwz
 ueajYirpJhMUYJM/dVCLTLp345g1DHn5q9YeVI9K5G0fqX/8RlwDfeJSonazDjkr6n
 L0y66+ook4iRCMrd4XIhsXwXAasjOqGFXadAxa+XMmcysRjxEURg56CbetF3pbX/E4
 DPSAYPPq4nlQThpgA+xvnOC6Xmi2+NyfDffuOhFxgeMYg9PJiQ9hyD742I23TeWmuQ
 F33pD7ppaWZis0uWM8tvEjNvw0/+oDsAxz3oHJFVxBz3i5bbO6csANSnuGs9Sq1UMq
 B9D6hsfefQNWL0ROGJsDRyOEjsq1dNzzgna/oSTLLEBKIYs8bBQyNFe8c1NNXX2byI
 ajF1i8gbXdHZwiW9jtPriCD0DSXodgQXCspKzpNJZszdGhMoZ1kj2F2ceDuHJYKBjD
 QZMhY/B/J06qvfGArhK1z3QY=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39b77130a7fso1670803a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 22:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790229331; x=1790834131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FuAmXAYmQM/Lw09kV6qF8OT69JB8Tv7EYE0cwgq/4Sw=;
 b=fDr39byInfQ4PnWw3xl7TV1g4P5OaAcbPDBJjknTJNynVDjc4rzFTssITFu+rLqH8i
 u+/lqare1qZzQfsnyxVXAwwzBjNJPPXqtGgX5Ipvd2qsvaTb75imTVNd4a6h7UcYPggS
 N3R3qPsQq1YLaggWB9Nwki78Fjzai+sq1QoQ/wy+e9N83FZSv5QtgJHBnVXdEAYaduWZ
 88uGlyt8r+fZIdy1qU1qaDs187ou98qIM7F8yA+yBpTujtn+3m4NvqRi81DlkzaRJl//
 S+hLDUQjtEqBmjGj1Oo8AYxh+PttSkaasu1lk7TLJlEzP9CGciebws7rhoUSGLH551g4
 m0tw==
X-Gm-Message-State: AFuF++kEbWBOSSaIlMW1oUFIAaw+GNKr7wuIhscLHolMgd6nLNKRivBA
 1JzsogCMjYAgsWDkrRbQeXQFxwpc1airuytKWqd8zA2LXKm7FgEQCbd1HISNnwG2KBaXWbkpXiO
 mfxn93ra+7fTFUHTknFJ9gUFfSptxUOkiWaxt83kMdJMBp6nP4XB6NItfbs08nW/kdoZDdyeWcB
 aR5oHDZbRvJb2xthJTIA==
X-Gm-Gg: AYBFou1760i/4AV58z2ZLk97QjWcjWzXHMHqmSX5PF970bvwKjrTyo4dPv9dIlw8M9K
 gY7Trd5QWbAqiOKbItl7yOuqxkQvaMAKfvmAcdhFOfJDEzTPCVcJH6joaBWnmRYbCSq6dP0WWgW
 sG7RdAdthtH/zd8zy4EPzmA0AR2ozZxFIREB58FU+J4KrxKpzEXJR4bxk3TZYaVD5HA3dLeGJZj
 Exyv44I3tIPHmbKUVq7jrC2EJyglLygCbgLs8ZnFb6QkiUdKQoHj0RGQv45md4rVFnLrPD3n/Ap
 ChjqfLgvI2g42BAql+zpiMV6Og4YdgkPnJE2mFHmClRcFK9EiKZORyGaEpPEyfBtH+wBAi4CD6a
 n8V4GJ9N0qB3AhRvJqSXomNAUZyrM60W7T73Mj8vDXjG3jqsOyhAwkx97rw2+gPwZS5APUg==
X-Received: by 2002:a17:90b:1c84:b0:39e:6a81:5a94 with SMTP id
 98e67ed59e1d1-3a098e39a55mr1117149a91.40.1790229330853; 
 Wed, 23 Sep 2026 22:55:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1c84:b0:39e:6a81:5a94 with SMTP id
 98e67ed59e1d1-3a098e39a55mr1117127a91.40.1790229330463; 
 Wed, 23 Sep 2026 22:55:30 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a09733f48fsm2825829a91.11.2026.09.23.22.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 22:55:30 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
Subject: [PATCH v2 4/4] spl: fit: use constants for FIT property names
Date: Thu, 24 Sep 2026 05:54:52 +0000
Message-ID: <20260924055459.125648-5-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924055459.125648-1-aristo.chen@canonical.com>
References: <20260923154610.339153-1-aristo.chen@canonical.com>
 <20260924055459.125648-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 24 Sep 2026 08:59:03 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

spl_fit.c mostly uses the property name constants from include/image.h,
including FIT_LOADABLE_PROP in spl_load_fit_image(), but still spells
out a few names as literals:

- "loadables" in spl_fit_record_loadable() and spl_load_simple_fit();
  use FIT_LOADABLE_PROP.
- "fpga" in spl_fit_load_fpga(); use FIT_FPGA_PROP.
- "compatible" of the FPGA image node in spl_fit_upload_fpga(); use
  FIT_COMPAT_PROP, as boot_get_fpga() does in U-Boot proper.

No functional change.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: no code changes, collected Reviewed-by

 common/spl/spl_fit.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 1a0066c92a0..64e5f95546f 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -608,11 +608,11 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 	const char *name;
 	int node;
 
-	ret = spl_fit_get_image_name(ctx, "loadables", index, &name);
+	ret = spl_fit_get_image_name(ctx, FIT_LOADABLE_PROP, index, &name);
 	if (ret < 0)
 		return ret;
 
-	node = spl_fit_get_image_node(ctx, "loadables", index);
+	node = spl_fit_get_image_node(ctx, FIT_LOADABLE_PROP, index);
 
 	ret = fdt_record_loadable(blob, index, name, image->load_addr,
 			image->size, image->entry_point,
@@ -735,7 +735,7 @@ static int spl_fit_upload_fpga(struct spl_fit_info *ctx, int node,
 	debug("FPGA bitstream at: %x, size: %x\n",
 	      (u32)fpga_image->load_addr, fpga_image->size);
 
-	compatible = fdt_getprop(ctx->fit, node, "compatible", NULL);
+	compatible = fdt_getprop(ctx->fit, node, FIT_COMPAT_PROP, NULL);
 	if (!compatible) {
 		warn_deprecated("'fpga' image without 'compatible' property");
 	} else {
@@ -767,7 +767,7 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 		.load_addr = 0,
 	};
 
-	node = spl_fit_get_image_node(ctx, "fpga", 0);
+	node = spl_fit_get_image_node(ctx, FIT_FPGA_PROP, 0);
 	if (node < 0)
 		return node;
 
@@ -928,7 +928,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	if (node < 0) {
 		debug("could not find firmware image, trying loadables...\n");
-		node = spl_fit_get_image_node(&ctx, "loadables", 0);
+		node = spl_fit_get_image_node(&ctx, FIT_LOADABLE_PROP, 0);
 		/*
 		 * If we pick the U-Boot image from "loadables", start at
 		 * the second image when later loading additional images.
@@ -971,7 +971,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	for (; ; index++) {
 		uint8_t os_type = IH_OS_INVALID;
 
-		node = spl_fit_get_image_node(&ctx, "loadables", index);
+		node = spl_fit_get_image_node(&ctx, FIT_LOADABLE_PROP, index);
 		if (node < 0)
 			break;
 
-- 
2.43.0

