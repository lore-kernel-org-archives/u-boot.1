Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2DBCCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BF3D810A1;
	Mon, 19 Oct 2026 13:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PoHftu7qiYC7; Mon, 19 Oct 2026 13:24:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA9A180D87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416250;
	b=l6AF0QMyHnC4nZMvJIBICYEm5ZPpCPYeRJ5w35meekLAEOaif5W4oq8V2CVVBwSzbxkj
	 lCiZQ+ekosIWsvmXpaMGhx580eTIXYKaqf8VEXmVHqOOg/jxuUW+kHhToZ/T2MdGbos5t
	 GqxzCfpDpBadYuAUYEmzJc5C8mIfvSUPtcuZBUYoXDIK5Ih/lmQlYm6wSg5+Xt1wwsZLQ
	 NLTa5ejCvVBj7e5F3G/89fjb92J+eKFpPw/4BrQt/dDR/zZ+Bn8GDAc5At9HY9NXIwrj2
	 HTMhbSy371OxYe0UFHvyoK1zJz/YVUfMX3i61elIPV4pC6IsxyET8xIHxSA63P3TxgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=51GcvVeRCQ0DlaUDwGY+/pM6tyd1M0XTNsp+jK/W1pg=;
	b=tDge++6NFUhZeQS0WeEWVUF6Gkme7QDmHwNDtm/H7TZtT9w0/UJ14rP0RomlrEnTdQ5X
	 rdV+617Tg6+iBtTFlZ+npP1QFsSj0qpkxog8PisHTI6DB64n3czSmK5Jsp0GI3etoInUk
	 beiM3BOT8wDEosG9+n7pJL5cXpJru7A1MtS4wQzcd0PJ7o4mnr6FLAUc4+STRTxFhbIm/
	 uKDSeVWZCOHfjIRQvgqhHBYbtArgnfwnDpZjYIRnq3bNLDjTQZwpySa9L8GB4Iq7kYJYl
	 ml/Gzr2Bq3hhbrrKFyrZnz4Dgl/men5DD6Tgw7PmxhS2aiHOrjZFXb4cpLiodWWJh8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416250;
	bh=51GcvVeRCQ0DlaUDwGY+/pM6tyd1M0XTNsp+jK/W1pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xVH/E1x4Ax/33R3dDQmiTwep0Ka7vhnGfTFDyse2jMCYus4p8QdgZk8UyQDMBnmxa
	 a4bRw9BI+FVkFH5St1ealVWdkGia5syGJKBBjH5V4qXj9fjlWk+i3dvuSbut6Ddfm6
	 R9R8In5q5v1/a3k4neLXnxmWd/DphGIN/zot2SrC1OAKS6g1SiuK9ArAKFJMEPGdja
	 77PKRt4CWhgpj83KCaugXkmZP+up8sMr0WpENl3DyxfYIEN70LxdR+kS9BlLOxigRp
	 PZ44vUMmiNFrAWQdrVwikm732geKcYjkxDdcki0Qx7EzeNKLR06kOf4AiWCn9a5f7U
	 m7EoXK/3Kp76w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA9A180D87;
	Mon, 19 Oct 2026 13:24:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 78AB91E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E94E4062B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxSHNprVSkay for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:59:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64CC0405EF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792414776;
 b=a5c8sYe+v/RoYvsmB+g3mjS3wCesdoE63HVyulOyMy/GoVyZeH5BlYZuHewqh+683vo3
 bb7sRDx4/gIO+S2jBCITb3jU3+V0H9ZTyKpQ0eLm5Zrlo3cRUg3g4tl6fyLmNg9LAwXL5
 5KwXW4CmR5U7E1FYM/IDX+mXUBUV62/GDf55QBQ7QXAfuZJOKxR1r9uMBGFjAQ77xchef
 EVRuCWLP+U6LUdObTo9l0pBjJLfpcxcWuBJtTjwP3y4m1swC0Yq/c5Tx8H1UCcjJPIIaw
 mzgx7Ua/HVgjb4jZGrmKY6+vdSTy/zi054T6gAIGyJOCYzLcCVURxm8rw2hbrWFzScQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792414776;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=51GcvVeRCQ0DlaUDwGY+/pM6tyd1M0XTNsp+jK/W1pg=;
 b=LBR9T2eOzQpTUPp99QafkC8kKtMt+WQbHDVUwIY7CB/bOqoneFp8n5vQc9bJ6B74kf+S
 2Au5ZTD40aAcFZdSnAYddiWoNAKnjLbYxV8/gTOs+UJ87UH6WC2xJBBr5RQqrT3ovmbmk
 CwGBTS9CL2EVMRDnXOGkILsViO1hIeSB1p2Pz4EQdF4r5gv1yJ776+UDLRjyPQot/vuLM
 0iCVBrjFkPjo2wiiU1wyVyEF23sYCNc9V4fajgFtjZ9KeBXbQLIQBFv4goXw3F1ISuI5S
 4YCvbp5K5fExF6reEG/tc0QAExg7y3uhVC2rvlay8BpsQzTqqfa41MW+dvKaaeyp6ig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W3GP1Up2; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=W3GP1Up2
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64CC0405EF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:59:36 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso9611435e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792414774; x=1793019574;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51GcvVeRCQ0DlaUDwGY+/pM6tyd1M0XTNsp+jK/W1pg=;
 b=W3GP1Up2aPXIOq3Noo/4d+zZwndi+RvmLbtuDJZ0nYn56yL8MdGPmKFlL6inS5snSo
 k5J1ENSTX98fgq2EW7D9/JN8jo+0d3VVEirQcDZQduscSwPiqjIRS2euMSd7QwDSgiF2
 XSR7qLPHqHql4Vh5N1uYneuc97BFtvXZ4Nf11i1oK8MzqjIdewrXy4uKypbSwN5v0q7/
 /rT6CEErZD1cU9xLobyU2FppI/z8CGM7jdhUUrcjLYQSkMojmCKeWbLqPuxRfJC7QC8H
 YVvMTL+XADRNO3DK3L5W3e+obfei7dfmgg5LZhWNlGV1VaVB7SM+nV1wLj9qPafcm60Q
 mc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792414774; x=1793019574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51GcvVeRCQ0DlaUDwGY+/pM6tyd1M0XTNsp+jK/W1pg=;
 b=A6/Q8Qwa+ZxngsujH2VvAHR6ctr42rex6PrIpLTsm5iGfGVM1CJVYpOREIDkYocCM4
 sB04hQd11B1Syc3wB8dUo3LekdL6sXZ/IeIrOLaSNOoloPS9ZVJshgQEp4ea0u8B5VgM
 yw6qdTTungVcY2qX2COtqWTcx08r3MDZ8y+lzvgBgxGSLdfPWiP8CSAuS3AobumyIFHl
 Sx94eDrZ4+c6fMcOTJAVILjxGImc8jWe8nwWy54a3Q9fjm9y/VmVtrwHBXgFBQXjWpph
 iAODDteo5xlLOJj2v2wLBX5nbzR8NoQEangyf99Ym6S+iPJDxG8U5f5VjY/OMtb1kRvO
 tPsg==
X-Gm-Message-State: AFq9FYLK791+0V+Unm+vhyhEdCiDa812xSiFusL6DrRTUDg2GQvhvR7U
 fTgwlQ58XH2PHGz/cRwQwpR0NQcePbv0Xw2j+/G84xrQ5VB8RMuwrwnD
X-Gm-Gg: AYBFou092YIRqihh6aOJ4Yo1iuluwlKh5Z/vJBd1et9kKNie4mDX0guoskpfhgbASJ9
 Ioh0QQFh5CtifEEnF998Gq/lPnRjv0MiUiuuEF1P1Ba8NdccGoyncPDtJUvvJBKZgaTffN/D//+
 iVmJOHQBXuY1SS/chxaPuKE89e/VQEaN348eSN3rxRyjmccAkF+8gi1TkxHW+Wrn89sOlIKrRIQ
 IhRQOpRJBFfCmbkE7ozbknvzFjvgqrNJls3/UfYBVJhsV5ea2YUV+0m21rwIsHZNGUbQoAvN80V
 ssB+q4N1gsnzLC5BQcfO4cAkqa+0EUN6mVc79WTyw1h3gRKCLFkos47amheRrfixjcEegNRkJQD
 cqNGmkXIjGrt6Ehm8oTF3glZdoyeGs+xVx3sdLv0gCpYciaGa9fJBboNY1KcTkNBSwEGQPGnW2n
 xhTr6uGFrJS5AUDNBLC0F5ok1zup9WBh4jQ5Ifh3QlB23GJNWR4B3jeLV59U/E4Z9n
X-Received: by 2002:a05:600c:8a97:b0:4a1:d061:1d3b with SMTP id
 5b1f17b1804b1-4a1d75fe17cmr121944325e9.8.1792414774119; 
 Mon, 19 Oct 2026 05:59:34 -0700 (PDT)
Received: from eichest-laptop.toradex.int ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d30d778bsm264696755e9.9.2026.10.19.05.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:59:33 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, stefan.eichenberger@toradex.com,
 francesco.dolcini@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/2] imx: mach: imx8: fdt: support newer GPU0 bus node name
Date: Mon, 19 Oct 2026 14:58:53 +0200
Message-ID: <20261019125930.111608-3-eichest@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019125930.111608-1-eichest@gmail.com>
References: <20261019125930.111608-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Oct 2026 13:23:57 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Mainline Linux and NXP downstream kernels starting with 6.18 name the
GPU0 subsystem bus@53000000, while older downstream kernels used
bus@53100000. Because of that, the industrial GPU clock rates were not
applied and GPU0 kept running at the default 700/850 MHz instead of
the 625 MHz limit of the industrial SoC.

Use /bus@53000000/gpu@53100000 and, if it does not exist, fall back to
the legacy /bus@53100000/gpu@53100000.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/mach-imx/imx8/fdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index 630b5e55702..05d2ddead91 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -317,9 +317,14 @@ static void update_fdt_gpu_industrial_frequencies(void *blob)
 	gpu_assigned_clocks[0] = cpu_to_fdt32(625000000); /* Core Clock */
 	gpu_assigned_clocks[1] = cpu_to_fdt32(625000000); /* Shader Clock */
 
-	err = change_property(blob, "/bus@53100000/gpu@53100000",
+	err = change_property(blob, "/bus@53000000/gpu@53100000",
 			      "assigned-clock-rates", gpu_assigned_clocks,
 			      sizeof(gpu_assigned_clocks));
+	/* NXP kernels before 6.18 use bus@53100000 */
+	if (err == -FDT_ERR_NOTFOUND)
+		err = change_property(blob, "/bus@53100000/gpu@53100000",
+				      "assigned-clock-rates", gpu_assigned_clocks,
+				      sizeof(gpu_assigned_clocks));
 	if (err && err != -FDT_ERR_NOTFOUND)
 		printf("Failed to set assigned-clock-rates for GPU0: %s\n",
 		       fdt_strerror(err));
-- 
2.56.0

