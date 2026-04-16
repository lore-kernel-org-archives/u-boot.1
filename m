Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E44F433F7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2130384227;
	Thu, 16 Apr 2026 08:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p/ZKko6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E0E883EEF; Thu, 16 Apr 2026 08:00:15 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14CA84207
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso90009325e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776319208; x=1776924008; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqsYMUeGyUGXw34cIjdntI8dEFhH9ejtFq3bqgVy0sk=;
 b=p/ZKko6yg8GQFCxVCKC9uoZGieGJnlj0tsPGzE1+CSRpb6MUWWlH0m/VGO5N15gZBx
 lDkgtMsGpOW9FEi2JhVWEZFFEVC8QOpvQazUbbRvOic5LSId0gaNKkVc4Ig3HJWd3PWX
 uloEN9BakZp7NJuK7gP9qbvoq2K+mgpBDYOeidhT1gXIhEPrOY7dflKJ1SsWkcfOhOND
 UndsZOgPtN1cxbY3sUmw4krf6OIFWZeAnJ2xZjoVDD1PzCjkOYgsaX5bgq13CAukw5xh
 JE6s00vJKATIZsBhtjP7dYqFqBvFEb5iA9rCIfFGQzYUiu3ipylXfr3OBxQSASfQeYaC
 kYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319208; x=1776924008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HqsYMUeGyUGXw34cIjdntI8dEFhH9ejtFq3bqgVy0sk=;
 b=EU858pNcfv+0+eLkU10wVn7FU++T1+UMQ4rBu9X/zQClkr3EG3+goKRwKUoGNALtah
 3DFz0Mtk/xDXL/+PMAgBla3Ni1f4fSf7G6/OIY9HBRQ1Ex2hsAnr9hCrlk1AeoG3DWFF
 jqH9/NSCcaOfzW2cuF4gK/wWRUaUeHcilgiqwSFRWMIpbWe2RN2CoH02iXBrn18hwr4P
 vcozt4t+vmJRmi+kwMAmkKrfWOjBrw+GJsrBR9H1OW8vW+xX2DqEk0fLMkimJbp3kiTI
 i7tGHdkusBd0dRJRWWbzP68BQYhF2CbynOnM5KBDQNynVZcCZCmYF4c09oBK8dJzsgPi
 pphw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VxR4sPEzwK5Yw0tR8GrRMNtXmXYzNgEqYcL5WO4dCSBugBRPCxNkZ+yG58Y6LFMQw9CshoBU=@lists.denx.de
X-Gm-Message-State: AOJu0YxBXE3QPC8Z+yMOnjv7X6s/wxD/9+O6HgnYV3TS6KlJtzcOWQOp
 zNswGpcFt7mXjp05wJ+Wc82CDl8IGPKjywuxCj6TCb9MOLne73rUYP7UkBilmC1JY4k=
X-Gm-Gg: AeBDievsdsesbtVYlUWa0rvCTsSPTpj8IUHkmIF2me9fTOPOz+yV5Q1IQTO5GwgdN2f
 2oyGg1Vuti6BDRY1++19ZIN6iNb8xcIjDhefAwtxtF4fIlvJaDLp0I2Qg3B0qem20RM3Q949zrf
 gb8OdwGPuLCstAbGN3wKnIanwsy9TTF9SLbdbJtpY3gGSS+llO6NFFolcLxqKUOMTp0+YFq4nfa
 OMuVRLJ288WJP5tZoCtZPn5WOaLhj7DOuL5SfhClmuMxiEtejVuqEGKEzG/K5jfn9zpSQ1SIU+f
 lOI2vY1VYpDeLBM8OBI6AnqRug+GW3CSzVPHeC82CVff3ixaUlnLqMtM8kUCM4MprdvnUVDqBJp
 Q2doQm1wbCOsKouPer+w6AmdXUc+HBgUO85RoGbYzxposln0T3YrMrRIS4dW2q0ogwkaS5VdcFU
 YFuguOp0WFIt4Ic3i0/wfIuZn6CGniuPhb1X8FcEhXCtolHDlSuIoQZTGVjfJd6liWlW1zfa7KM
 Hk3ngfMQ86I+CySnNylBlb0kIQmqWOrq1RWjyoeF0B9yQdvlO84ilPBeU7Uh07mpMLuQTxyjUsf
 I9aeGTX1pcA9V+ILCaDBI3hPCju8H1Fb1IiTKHPuuRjn/7X8hMpXhOrdODoacRk1K1abiBekXdL
 Rx8/JbEkZPnJlLqDAkHxKBcpZQkS7m6/nT4icFUDSfUuSsqwyruJvuCAUIb1Pjx84uozJJPaFJG
 P6VkpOhTTQT7E/28lzo7cdgZGX/Jv2sjihByEAvYtzrWNDWVV5t+TFMrrI3Ziu
X-Received: by 2002:a05:600c:a415:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-488d67bf7c7mr254263745e9.4.1776319208289; 
 Wed, 15 Apr 2026 23:00:08 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e9a770sm36379755e9.19.2026.04.15.23.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:00:07 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/6] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
Date: Thu, 16 Apr 2026 08:59:38 +0300
Message-ID: <20260416055948.130041-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
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

Introduce function fdtdec_setup_mem_ram_top(), which determines the topmost
address in the last DRAM bank, to be assigned into gd->ram_top in order to
relocate U-Boot to the actual end of all DRAM. This makes use of iterator
function fdtdec_setup_mem_for_each_bank() introduced in previous commit.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 include/fdtdec.h | 16 ++++++++++++++++
 lib/fdtdec.c     | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/fdtdec.h b/include/fdtdec.h
index 4e09f9d718c5..35caf4b789e8 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -957,6 +957,22 @@ int fdtdec_setup_mem_size_base(void);
  */
 int fdtdec_setup_mem_size_base_lowest(void);
 
+/**
+ * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
+ * available in any memory bank
+ *
+ * Decode the /memory 'reg' property to determine the highest end of the memory
+ * bank and populate the global data ram_top with it.
+ *
+ * This function should be called from a boards board_get_usable_ram_top().
+ * This helper function allows for boards to query the device tree for topmost
+ * DRAM address.
+ *
+ * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
+ * invalid
+ */
+int fdtdec_setup_mem_ram_top(void);
+
 /**
  * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 9c35b08e709f..a173c4ab323d 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1166,6 +1166,24 @@ int fdtdec_setup_mem_size_base_lowest(void)
 	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
 }
 
+static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
+{
+	if ((res->end + 1) > gd->ram_top)
+		gd->ram_top = res->end + 1;
+}
+
+int fdtdec_setup_mem_ram_top(void)
+{
+	phys_addr_t old_top = gd->ram_top;
+	int ret;
+
+	ret = fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_ram_top_bankfn);
+	if (ret)
+		gd->ram_top = old_top;
+
+	return ret;
+}
+
 static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 {
 #if CONFIG_IS_ENABLED(MULTI_DTB_FIT_GZIP) ||\
-- 
2.53.0

