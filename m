Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0068CF8E4B3
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 07:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A3384258;
	Fri, 17 Apr 2026 09:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XvEKU9ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9BCC83FC0; Fri, 17 Apr 2026 09:15:52 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A5A83FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso3666105e9.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776410150; x=1777014950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jiPVCHfizk5nKMv0TFveCyP+YN5hGFmOdxQlu0i+Zec=;
 b=XvEKU9iiZ3g80KlyjrPoOhIQpvfhhliBKHFvDVh0J19WiHHT+bvlAxFgXK52bW7zBP
 t5IaUCb6w2yFequZB6PtB4jM1khxbI36KMX1BlDFY1ek6MmoMLoKaR3AFK55nCAzZJDw
 SXCxCmd0LNpi7Q+42TuWnUC7pN08J5qgtBsz2FB0NhU+hp/dMSNfg8e7QaLcSiiSKqBB
 zjfOBslP+VLp7e23+Ez8ZMlrOi2WKEpSrrOYxt5O/LoIpYRCX1yJkgJckkL8rtdzuEyh
 4mtgaec/tK33oPDrsZRfqmj2+vDvG6Trk1kNZdLZmoSytIILcVNjR9T2Wcp1jRfjHrTR
 NJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776410150; x=1777014950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jiPVCHfizk5nKMv0TFveCyP+YN5hGFmOdxQlu0i+Zec=;
 b=CkLi9YVvpV6qKLyTWuTdNCeZiQSqrKLkqCmmJ4LFCgAYkt5X3BFjziMD+rTVUdMfRG
 lRyXeu6FKmiZBQvH1TQlhY+tbNL7f/EMYMl0HB0bivRSeZ8mD8Ngsl+5kU8wtyJs0esl
 ISpeHoUcF7jrxNcCciUlkQ3AAqmqN9NMrgV62emLedy5CMuxxbWvCJfKifJVrJOo49yy
 QEhkEwUaEBamkvHBmQFDxc8iW3TMIKNrpxRsb/UZFQJdGQgsiRk0acV0xeErSXb1vjgB
 o5nZG56R3qbzQdI0jo/x3WnLMOAohshL22Q/14HpF6TibVkwgSDb8DqyGkVjCmroyjWh
 0xOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ie22AWD+yhC+5vRDy0peMHqc1jJKE3DnaAwqAZZzQ2A3mW0Dy5U+4gSF++VMs9HWlx1mFv9o=@lists.denx.de
X-Gm-Message-State: AOJu0YzVh+2L7S/At1fq3IB5kSogbvArvAcxbkWCet1SBPTAVOx4WwGf
 35MFXNKUj7kFfv4ShL7SNiYArWEG/40oIaoZvOHwZMeKAMAg2ea5w3csG08SnRRH
X-Gm-Gg: AeBDietE7GRa8sHIfG+kHmzPJJ9IMnQt0Edg+Ea15luxi/Ud97yGDRRMabkW2O/QNtb
 s1AAZOofyoGKIxZ/4sMuVQn1T2ZPr9rdQfjHi8NvcOcDWPiPhynKPPRgVAqznKgAucwG/IaDONb
 kQYLhZsuZOua/sz72jQ+qB3NIor95maveLRBONZeZ6fNfb8Cxfo6KulLZRpQhfxT+1CRArEKoSH
 I59peqEjyW0+2rEU2cdtYX0Bt4zWo0sw8EDOzQGoOyCmu2oe50IWGJGchehnd7oOnNI9TG0lBtk
 m25TAIfKi/MgFr3IAwUCkJlTaI7msQ0CdEnuwfcSNACyCfPZ/73ugLW359vdXJSeN7Xjq8pmaWX
 LkETN94juKjR23QCYFr3MEzr52uLQkc0bASFHg1rwpsLIt7+OA4jHM1sBSJ9DwAqVjm6131N/7P
 qDaBCXf+8OmwA8qVSy1DoVkPSlav+lLocjLIhF33c8cYZ9ngmvhwsKHDHS18Re54euN+isKXRzX
 zKVNi5+NRLc9k5zmPmqfo28yrRIhpn3WGvT7fHEA3oRanXn
X-Received: by 2002:a05:600d:8402:b0:485:3af5:7e53 with SMTP id
 5b1f17b1804b1-488fb77a36fmr16023315e9.19.1776410149998; 
 Fri, 17 Apr 2026 00:15:49 -0700 (PDT)
Received: from emanueleg-nb.homenet.telecomitalia.it
 (host-87-2-163-213.retail.telecomitalia.it. [87.2.163.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb6dfa33sm15573955e9.0.2026.04.17.00.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 00:15:49 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Alice Guo" <alice.guo@nxp.com>,
 "Sumit Garg" <sumit.garg@oss.qualcomm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 1/3] common: memsize: add RAM size probe based on alias
 detection
Date: Fri, 17 Apr 2026 09:13:31 +0200
Message-ID: <20260417071546.1610330-2-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
References: <20260417071546.1610330-1-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Add probe_ram_size_by_alias() to detect RAM size by checking whether a
write to one address aliases to another address.

Compared to get_ram_size(), this function allows the caller to:
- limit probing to a small set of required accesses
- avoid touching reserved or already used memory regions
- handle non-linear alias patterns

On the iMX95 SoC, when used with LPDDR5, accesses beyond the end of an 8GB DDR
configuration do not alias to the expected linear wrap-around addresses.
Instead, the aliased addresses appear to follow a pattern related to the
DDRC bank and bank-group addresses mapping. Experimentally, the observed
pattern is:

Write        Read
y00000000 -> x0001c000
y00004000 -> x00018000
y00008000 -> x00014000
y0000c000 -> x00010000
y00010000 -> x0000c000
y00014000 -> x00008000
y00018000 -> x00004000
y0001c000 -> x00000000

This helper makes it possible to probe RAM size by explicitly specifying
the probed address and the expected alias address for each size check.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 common/memsize.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/init.h   |  7 ++++++
 2 files changed, 66 insertions(+)

diff --git a/common/memsize.c b/common/memsize.c
index 1abf3fc47d73..3ecf9bac2aac 100644
--- a/common/memsize.c
+++ b/common/memsize.c
@@ -127,6 +127,65 @@ long get_ram_size(long *base, long maxsize)
 	return (maxsize);
 }
 
+/**
+ * probe_ram_size_by_alias() - Detect RAM size using known alias addresses
+ * @checks: Array of RAM alias probe descriptors, terminated by a NULL
+ *	    @probe_addr entry
+ *
+ * Probe RAM size by writing a test pattern to each @probe_addr and checking
+ * whether the same pattern does not appear at the corresponding @alias_addr.
+ * This is useful on systems where address wrap-around does not alias to the
+ * base of memory in a linear way, so get_ram_size() cannot be used directly.
+ * It is also useful on systems where the base of the physical memory cannot
+ * be safely accessed, so get_ram_size() cannot be used at all.
+ *
+ * Return: The size associated with the first matching entry, or 0 if no match
+ * is found.
+ */
+long probe_ram_size_by_alias(const struct ram_alias_check *checks)
+{
+	long save[2];
+	int dcache_en = 0;
+	long ret = 0;
+
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		dcache_en = dcache_status();
+
+	while (checks->probe_addr && !ret) {
+		volatile long *d = checks->probe_addr;
+		volatile long *s = checks->alias_addr;
+
+		save[0] = *s;
+		save[1] = *d;
+		/* Ensure s is written and not cached */
+		if (dcache_en)
+			dcache_flush_invalidate(s);
+
+		*d = ~save[0];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(d);
+
+		if (*s != ~save[0])
+			ret = checks->size;
+
+		/* Restore content */
+		*d = save[1];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(d);
+
+		*s = save[0];
+		sync();
+		if (dcache_en)
+			dcache_flush_invalidate(s);
+
+		checks++;
+	}
+
+	return ret;
+}
+
 phys_size_t __weak get_effective_memsize(void)
 {
 	phys_size_t ram_size = gd->ram_size;
diff --git a/include/init.h b/include/init.h
index 1e375da48936..c31ebd83b85e 100644
--- a/include/init.h
+++ b/include/init.h
@@ -14,6 +14,12 @@
 
 #include <linux/types.h>
 
+struct ram_alias_check {
+	void *probe_addr;
+	void *alias_addr;
+	long size;
+};
+
 /*
  * In case of the EFI app the UEFI firmware provides the low-level
  * initialisation.
@@ -88,6 +94,7 @@ int dram_init(void);
 int dram_init_banksize(void);
 
 long get_ram_size(long *base, long size);
+long probe_ram_size_by_alias(const struct ram_alias_check *checks);
 phys_size_t get_effective_memsize(void);
 
 int testdram(void);
-- 
2.43.0

