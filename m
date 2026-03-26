Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDD010A1E82
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A033483F14;
	Thu, 26 Mar 2026 12:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UXEnQ9I0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A53380517; Thu, 26 Mar 2026 12:51:33 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29756838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso7657945e9.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774525890; x=1775130690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2Z1UmY5ZYlyL7HbF/75dN6hWTpGHa0x+q+pJO3Y3VU=;
 b=UXEnQ9I0Su2PNYmofwiVlFNd3Kst931NIZ42VfE2qn/UHgyaX9S2srYbTwKB4B5qU8
 xVxIvIugFV2CqgTdfe7F2fT3PCc3zRIoMhLskbG0AvwWMGm/yVaBv5PxjeplUth5EyGa
 JLyFHmvE1CV2zey2p2tWRwZts+YDIqE27F41K8HdoYPGdUybq6uixm/8OTEdhnYvyFXd
 ZTAQTcGnCjgBZ172vIdm4cBcvucSPmXNjRlix8+vVzWZLluCjS+aGgy524eOaKT33f4V
 QYOuKz8/+2sps5A2cV3lGIPuHbEC71QaRTbfeaoqU/yIFrfq4mryCAKOcI+rumnie7gx
 /weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525890; x=1775130690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P2Z1UmY5ZYlyL7HbF/75dN6hWTpGHa0x+q+pJO3Y3VU=;
 b=scPHUvLwkT4QPNZ1ioAlbOWhoYWinyPCPwaypspVNy0/com94zLlK1zIhIXHdOSxrO
 fIyFzzG94anqLUjS01wz9FAHoKwZ7WYGkwI1wNwrpN48WPZil1N2/pCakDgONwRo1CC8
 b3KwvWw62Ynb4mmodJPhZNXGiaYJ4bCXGp+Pa1iMz/NmmMj4GHT966BxezYmvSqTitjg
 q4ntoTPufyNJ1maL3OaC1CmmDIq1TkuSHXmI6m+QgVSjW9z2DDWTuCbdBkH156YTXZT2
 PbS6VGoHvCt5eJdUtltbAxOho4Y5chvXNlq/Ur1syvDNPUyneznBpTwJkTJaA8Gbopt3
 Wl1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJZLC1eXWvNAOFLM5ltZzCAcZBl1EcC5tfu6RaWvA2B70s2MfK+WWR1urjifRb6QWWa0aZjlo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp3vR1I1KM4XDQoiOLloy4F5bI1V94qrNLnPRsXg7I7xx30OXL
 KSmEK5ZZTMH0cqAy/iqD3RB2rdo0yUFrNyjJ8vME//DxbJbJ/trM+rrJnB80QAEWy7s=
X-Gm-Gg: ATEYQzy/4cqJYK5QzN3xmYOcLZwT5uix3RyyH9AwpBBBb5hB1MQlORcDCK1zQ2cjNqY
 RgdslYD/YabwugONIU1UCjCymD1gl2QkACwnCiUZYEMpeqSrtLsRNNbnOqWrUK2IsflS0Iav6Hz
 gl0/uagJYVsZ6G9HpzzODIoNG5PwMMf+mdI+NVPsT35IaSCeUvp4nhEl10VpqRfjjhp4TFo/iMX
 CVH7GWWce+C6Fk3Ozpdw0RP5fy2I2ipTZMks/5yAmu3kF2N1jhnCBuI00RbygradCrjJsDWLbQ9
 pf6S2kBLJTVTx/BwRBclW0ZcyFFSiHGyY7MEqPVAulFr6HdoDnJc+lO1ntjfVoZnw2OuNRSLZ7H
 C+o18Evgg1RboF/5i+P+9m+xk5hkE2cac8d6ZIyQI+YT3T6D6pxeaPMGMu5xp+UElE+7gmRDru5
 17F3yiH9NOaGylVvFWbWsiRqum2jtrcHjKf037Zuk51IFtyviw7GjO6/TEs5dz2/UZHr4FaEDvd
 lkXTdX0QkvGuAAYuOgr3cyHsw9GNN96APCPkDltqFTzDb8frJy9GTvnrFtfzcb2sH4FZESjPaD7
 hWL08cRXfYAIRwTyYiAPa/OXGKMqBCaKqzuIaOH4IfCdCDr96882/fD84wbFyKXLVkt7DwJlP5d
 ZlzUsCFhz4T9U9/h83SUGFte9ZLO54tbuop5lsdNjO5aYDPiYTsDASBesV5mez2fGdRbQMfn/0q
 nG1yx5rVCTKp3pNriL8MWBr4Nt/NulA2GiBJalllS+2l42mbpgqJjHKFYXUQyK
X-Received: by 2002:a05:600d:16:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-48722ba90cbmr14842715e9.4.1774525890514; 
 Thu, 26 Mar 2026 04:51:30 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871fb3d09dsm25968005e9.0.2026.03.26.04.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:51:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/3] fdtdec: Deduplicate iterator function
Date: Thu, 26 Mar 2026 13:51:07 +0200
Message-ID: <20260326115111.1631261-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Both fdtdec_setup_memory_banksize() and fdtdec_setup_mem_size_base_lowest()
implement the exact same iterator over all memory banks, the only difference
is the body that is executed for each bank. Deduplicate the functionality
into iterator function fdtdec_setup_mem_for_each_bank(), which takes a
function pointer to a function which implements the body as a parameter.
No functional change.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Changes since RFC:
- None

 lib/fdtdec.c | 77 ++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c79..d820f75b031d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1092,7 +1092,7 @@ ofnode get_next_memory_node(ofnode mem)
 	return mem;
 }
 
-int fdtdec_setup_memory_banksize(void)
+static int fdtdec_setup_mem_for_each_bank(void (*bankfn)(struct resource *res, int bank))
 {
 	int bank, ret, reg = 0;
 	struct resource res;
@@ -1120,63 +1120,46 @@ int fdtdec_setup_memory_banksize(void)
 		if (ret != 0)
 			return -EINVAL;
 
-		gd->bd->bi_dram[bank].start = (phys_addr_t)res.start;
-		gd->bd->bi_dram[bank].size =
-			(phys_size_t)(res.end - res.start + 1);
-
-		debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
-		      __func__, bank,
-		      (unsigned long long)gd->bd->bi_dram[bank].start,
-		      (unsigned long long)gd->bd->bi_dram[bank].size);
+		bankfn(&res, bank);
 	}
 
 	return 0;
 }
 
-int fdtdec_setup_mem_size_base_lowest(void)
+static void fdtdec_setup_memory_banksize_bankfn(struct resource *res, int bank)
 {
-	int bank, ret, reg = 0;
-	struct resource res;
-	unsigned long base;
-	phys_size_t size;
-	ofnode mem = ofnode_null();
+	gd->bd->bi_dram[bank].start = (phys_addr_t)res->start;
+	gd->bd->bi_dram[bank].size = (phys_size_t)(res->end - res->start + 1);
 
-	gd->ram_base = (unsigned long)~0;
-
-	mem = get_next_memory_node(mem);
-	if (!ofnode_valid(mem)) {
-		debug("%s: Missing /memory node\n", __func__);
-		return -EINVAL;
-	}
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		ret = ofnode_read_resource(mem, reg++, &res);
-		if (ret < 0) {
-			reg = 0;
-			mem = get_next_memory_node(mem);
-			if (!ofnode_valid(mem))
-				break;
-
-			ret = ofnode_read_resource(mem, reg++, &res);
-			if (ret < 0)
-				break;
-		}
-
-		if (ret != 0)
-			return -EINVAL;
+	debug("%s: DRAM Bank #%d: start = 0x%llx, size = 0x%llx\n",
+	      __func__, bank,
+	      (unsigned long long)gd->bd->bi_dram[bank].start,
+	      (unsigned long long)gd->bd->bi_dram[bank].size);
+}
 
-		base = (unsigned long)res.start;
-		size = (phys_size_t)(res.end - res.start + 1);
+int fdtdec_setup_memory_banksize(void)
+{
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_memory_banksize_bankfn);
+}
 
-		if (gd->ram_base > base && size) {
-			gd->ram_base = base;
-			gd->ram_size = size;
-			debug("%s: Initial DRAM base %lx size %lx\n",
-			      __func__, base, (unsigned long)size);
-		}
+static void fdtdec_setup_mem_size_base_lowest_bankfn(struct resource *res, int bank)
+{
+	unsigned long base = (unsigned long)res->start;
+	phys_size_t size = (phys_size_t)(res->end - res->start + 1);
+
+	if (gd->ram_base > base && size) {
+		gd->ram_base = base;
+		gd->ram_size = size;
+		debug("%s: Initial DRAM base %lx size %lx\n",
+		      __func__, base, (unsigned long)size);
 	}
+}
 
-	return 0;
+int fdtdec_setup_mem_size_base_lowest(void)
+{
+	gd->ram_base = (unsigned long)~0;
+
+	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
-- 
2.51.0

