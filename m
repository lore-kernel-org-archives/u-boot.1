Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874EFF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0F88407B;
	Tue, 31 Mar 2026 10:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vHGJopH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 222E18405B; Tue, 31 Mar 2026 10:01:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83BE83F5B
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 10:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso54709935e9.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 01:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774944093; x=1775548893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4V9/9WOOFlrhZHPpG8CFQJNwO5yyEuFwNtfZb1CCIg=;
 b=vHGJopH8lenwNa2A0UzshTj37Mgajncz0qILEebf2/cWqoIussvclLRyLZFXjhe+tk
 NSwucouMOjSOROgZJSMB38l6+hGOFhgul5ytDbuKpry/E0DBKC0uKYRCBweCxTzjbRLl
 7e9ImVVtWzPKnZdnTlz3LF2Tk9KySbjzR44IVZ3I5MFz7WEZA7D3RgFWzBwlzhXjaiO1
 7q68BhkvuihzzY4svNbYb1JPRFjoucAgomF951praWanEh8TuUlJJIhJQdJokC7A2VoL
 fZPa6pvKG76uSS4J3F3ch9aIX9/LX6E6T7R9HGdTJbMAk3SJ2MH/iQj8oeWSKLUfedEJ
 vXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774944093; x=1775548893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l4V9/9WOOFlrhZHPpG8CFQJNwO5yyEuFwNtfZb1CCIg=;
 b=B7UTCYFI0Spbc+AYBy/lQksL8RU+oxC7AVl2KKcS9HNkfUge9Xpx4ElqHtxNDiHF9u
 9Q7+QTFL16e/OnxKB/3YnHEeQBOODpW+n/PYByBrYYYhHqvvwn0HgT3DHxAp9bVn+Xew
 5K7EfM07njLf9+BM2sXxP/0GfitXP7VrTALDYJaUoqz1CJ8irqJ00t5wXFyU/eB4vzR8
 lLhkqrA5mCUA+jOUIRfeb0xj8uPYulXGhOPudwIUvaz3OWu4bOVDdLaptDHe8RFJDwL5
 VRMkubWvmxOUKYIzqzTTUXXl1DWnYEdvAAebP1UTTU0/vOGEiszFURYQLb0aAUoqNSaY
 XQag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx4ivltc5pxa/MMwY/cNg58W7FdA8l4YiUTo4murdOW8p8T0v3qfQ8q+NR5G6V4VsLoIoWbEs=@lists.denx.de
X-Gm-Message-State: AOJu0YzaJgTKmt49/kz8ObAGJDbOBHJIQsxZuGsIGQCzxBtjzGM2xt8v
 WdoKHCtBcemKodDIZUcflc0QXNxoJt5ZEnFZ1Lb+E5q6TEsXJORRwBiSObr3q77/8ow=
X-Gm-Gg: ATEYQzyYPU9np3mO5K7SQ4BtzTmojxOjzfCNX2CFDLjaFddtCd7mDKe7t4aK8Pqo4G/
 Nb+fPv7L0dE2EMGdYT6tj0Rw98X/ZfxvNstQsv4agE3VHEbBcdL8QtDbqESGnaB7NbImJ7xL/st
 tNS+LgtGNSmdWv+Ov86saPq3je7VfCWtZKBmv1QkDZlz2BSfeaD2puKCrsl2/Q7Z7YzBCtmBGtY
 J9zn12N6Fsf2aHmnrmuLSE/tTPLx71r1ct/6SpERnJFFcAlo36uGQGIDAwhwUHW00ZMlg+tmdsC
 IR6YFCH2iU+4izplzuv4A1V88FKYW1vRjdsaV4QRVTFHbcz13qMWEc4cDm/Id5JH3igwM+zH9Ap
 g2A1bEeQSSRdCBxyZdv1L5eqC6K9fXm1P42jZV5c0SGyx5zhtj5L20AcDBmpWo+0x+xt/weclTx
 cD9gJVvcomSXnUBMCacDbdOEvmJMvbsxQrPQpf0dwZa2OaQLUDyWQHY3xiUx6hQQvPlR5bEPLdH
 YtZL2oNhs/iWbM61S5R7B8DIMs+kApCMMG2C86hLHYkjIFHfj7JMYn0w7MGxSNNsB7HL1xrFd3J
 kp2shYdOjbJkCcf9pCBsEspBlx9/7FPpxFk/C5EL/7Dq1tBVEaecTiBhg0WQcGWsfgg6/1w0PW3
 I5ebVR6zdMq4kenOSH2esEhph63DEqQqx45RII/sV1ndAdlq4eLanheEf1/JjlmqVTuCz3RQ5pu
 ROVI6dcMCps4eaMxiL8VPs0mKwejWLM//i/6hty0nD3USn3bNM2PwwB45wJ3QP
X-Received: by 2002:a05:600c:4e08:b0:487:1fb4:7b3 with SMTP id
 5b1f17b1804b1-48727ef0cc2mr285408885e9.23.1774944093096; 
 Tue, 31 Mar 2026 01:01:33 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c9250afsm10087065e9.36.2026.03.31.01.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 01:01:31 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: marek.vasut+renesas@mailbox.org,
	trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/4] fdtdec: Deduplicate iterator function
Date: Tue, 31 Mar 2026 11:01:11 +0300
Message-ID: <20260331080117.2370092-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
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
2.53.0

