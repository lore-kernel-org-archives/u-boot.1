Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49370F433F7
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7B484242;
	Thu, 16 Apr 2026 08:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wo8YNK0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E14984207; Thu, 16 Apr 2026 08:00:23 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D697D8421D
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso70959085e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776319219; x=1776924019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keTZjmJ9L2wjNIMe4PYzgordnJwPs5xudOLPG6AHzeI=;
 b=wo8YNK0KBiNt3tQF0DvJ8A52Ia1T3gkc9Bzjo8ImSZmsor6NhzYfOyNfNhmEK6fXwO
 l2+CXtkR5PCp5N/yWMna2bjdMnJ2MmqboJJaKOYkGt6uVMoZKHCP+YYJ9SHYK4i4O0k/
 ZM5Ao5CrXYfQzLaBAUCXk5ODl39vwKk5z5m8fBJ/z89aszD6dgp+zuCEPV3u5epz7RVi
 s/JKwqdiyvLDfBUfjM1z5rs3VTvmwEE+HTwuRC6hLVdCLFoXEYRc9458c0vq1fScp/qP
 um17uRhazXg7GWxsA6wFTOxiR4aGYI78wajxKov5hTM6jFni6iUEYU32XtDJuwTwHAa2
 khrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319219; x=1776924019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=keTZjmJ9L2wjNIMe4PYzgordnJwPs5xudOLPG6AHzeI=;
 b=a4SjSKG0+GqHV3hI/6BICn+JYr8x2vqKsUGsWO81zltDIYtjc0c5zmzwxNh3Ooa/g+
 VcnZgOSqElWlGGU+X+E29UowxrHPQ7tCkQW5nyaT7C529iQzpb8exlH5koc4d9QG9o0c
 +I4RUH8AaOqnumNbeMsI2nKdipVOrqJ0zDsJ29Z+mTg8GExSYVNSdICD16aXUJ7yodst
 K7kJWOrCZyMyVAI90+6JyC+Z6RcrKaRnj3l425dRC/3VLUy76XACc0S7z7dXOLrXmIwh
 PxO12k/x/467wzCoFblGIa58dr1hFpIk+BrMgn/wFWTbXjsi16vf64tgm5eq3FFH7W7X
 PwSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R0H8OmPdDobWI9nZBJW6zszQP7Z72wO9Ie9MFBtvFRE1zn5RYUGFffR3gh/7ts+gxG2FkN+8=@lists.denx.de
X-Gm-Message-State: AOJu0YxT+dd1BO3PuSHd3ZHKS6poeQD8Vj3jjX1V57IKZCy5hk3x1wnE
 aM6e6/tAZPwOT908PMa9cm7ULY8QnCqtOOz4hS0THysBU6MJRNf149TTUMWiaf/01rs=
X-Gm-Gg: AeBDiesVE5/t+GTZw40GDeqttN6xOIYk8QHX1wW2E+BDVd2tbSd5RJLc8pyFgEZL3vq
 cEmgxSXCnZNTP6/fAxUUUkXsvgh+zGCpMt/DO33Mm+QHSDNovlCmUlDXr0CiVOjWvb3yg4cx5iX
 YKOpmMEzU17j51gQyiQzZ8S0G3lHnozc0mgKQ6+olpAn04C3lKPPFvCjJeHMYj02fCMtSwVckEH
 GTNtT37spAFwME4QM5Zhm3P0Q/8OT8vaIPKXHatebF5VUDNyqp6HV9SZNrA4ckh66QftEll7JMs
 KfoCcJQ+PkUi43/OJDGD7ImQyZjmu/5OSt8KzIIG50s8/fQNSodXQq3xSWjRInHl8PZkZs3711N
 XapteF5aQNE8jYdKA+pJK+zTPfz2gYBByePL2f/5TZ+cE/A/t2pGH29V6wASpmQq691hIuBECpg
 TPrespzBBE0qrcxVy/Wnpp8nsEydBNFMADZIauY8L5WIKN2MH+uYaC3ZgKDc0ttDBnPtCEY2+s9
 rDTSlupekVXnGIaHdSicuD6LvDO92tStnQqb1d9I12WAKy/A5BUYmf+x2CAkEL3m3VfSu3wuE7H
 /Uj8V144m/Fgi8FdhnPgux93VLi97pY1T9t++gemZ5TDriymryO+MDi2P7xRDcZFwlalpohom5W
 lX1TM8Igsd39MxpWoE0DoT1x6Sou8paR78BH4eFsXexAN/xXVfa4x8GVK9noqIYgyefs9GNXhFv
 Pt7Z7FJachoBPZxxjc2iykrGG3jcCQFdK2TM24r6eJforsoZAvdPd4Q4hSA/Q/
X-Received: by 2002:a05:600c:1987:b0:488:b187:d8ed with SMTP id
 5b1f17b1804b1-488d67bf765mr342601795e9.2.1776319219051; 
 Wed, 15 Apr 2026 23:00:19 -0700 (PDT)
Received: from hera ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e9a770sm36379755e9.19.2026.04.15.23.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 23:00:18 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 6/6] common: Add an option to relocate on ram top
Date: Thu, 16 Apr 2026 08:59:42 +0300
Message-ID: <20260416055948.130041-7-ilias.apalodimas@linaro.org>
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

Right now we only relocate u-boot to the top of the first
memory bank unless the board specific code overwrites it.
This is problematic when loading big binaries as it
fragments the contiguous memory space for no apparent reason.

It's worth noting that there are cases where we must not relocate
above the 4GiB boundary (64bit hardware with 32bit only capable
DMA). E.g This will break platforms, if the ethernet
controller cannot DMA above 4 GiB, and once U-Boot does
get relocated above 4 GiB, the packet buffer which is built
into the U-Boot binary is also relocated above 4 GiB.

A previous patch moves the bi_dram[] info from bd to gd and make
the memory bank information available early. So move the
dram_init_banksize() INITCALL before the relocation address calculation
and use it to derive the address.

Also add a Kconfig option and allow the common code to relocate U-Boot
to the top of the last discovered bank.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Kconfig          | 10 ++++++++++
 common/board_f.c | 25 +++++++++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Kconfig b/Kconfig
index 7f00e76ba786..63c273ca8c8f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -491,6 +491,16 @@ config SKIP_RELOCATE_CODE_DATA_OFFSET
 	  Offset of the read-write memory which contains data, from read-only
 	  memory which contains executable text.
 
+config RELOC_ADDR_TOP
+	bool "Relocate to the topmost memory address"
+	depends on EXPERT
+	help
+	  When U-Boot relocates, it chooses the end of the first memory bank.
+	  Enable this if you have multiple banks and want U-Boot to relocate
+	  to the topmost memory address. This will use the information of the
+	  board memory banks configured with dram_init_banksize().
+	  Use this if you are certain all of the devices can DMA to high memory.
+
 endif # EXPERT
 
 config PHYS_64BIT
diff --git a/common/board_f.c b/common/board_f.c
index 4ac22dca9e7c..f95e789257ad 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -339,7 +339,22 @@ static int setup_ram_base(void)
 static int setup_ram_config(void)
 {
 	debug("Monitor len: %08x\n", gd->mon_len);
-#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
+
+	if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
+		int bank;
+		phys_size_t total_size = 0;
+
+		for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+			if (gd->ram_top <= gd->bi_dram[bank].start)
+				gd->ram_top = gd->bi_dram[bank].start +
+						gd->bi_dram[bank].size;
+			total_size += gd->bi_dram[bank].size;
+		}
+		gd->ram_size = total_size;
+	} else {
+		gd->ram_top = gd->ram_base + get_effective_memsize();
+		gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	}
 	/*
 	 * Subtract specified amount of memory to hide so that it won't
 	 * get "touched" at all by U-Boot. By fixing up gd->ram_size
@@ -350,10 +365,8 @@ static int setup_ram_config(void)
 	 * memory size from the SDRAM controller setup will have to
 	 * get fixed.
 	 */
-	gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
-#endif
-	gd->ram_top = gd->ram_base + get_effective_memsize();
-	gd->ram_top = board_get_usable_ram_top(gd->mon_len);
+	if (CONFIG_IS_ENABLED(SYS_MEM_TOP_HIDE))
+		gd->ram_size -= CONFIG_SYS_MEM_TOP_HIDE;
 
 	debug("Ram top: %08llx\n", (unsigned long long)gd->ram_top);
 	debug("Ram size: %08llx\n", (unsigned long long)gd->ram_size);
@@ -970,6 +983,7 @@ static void initcall_run_f(void)
 	 *  - board info struct
 	 */
 	INITCALL(setup_ram_base);
+	INITCALL(dram_init_banksize);
 	INITCALL(setup_ram_config);
 	INITCALL(setup_dest_addr);
 #if CONFIG_IS_ENABLED(OF_BOARD_FIXUP) && \
@@ -998,7 +1012,6 @@ static void initcall_run_f(void)
 	INITCALL(reserve_bloblist);
 	INITCALL(reserve_arch);
 	INITCALL(reserve_stacks);
-	INITCALL(dram_init_banksize);
 	INITCALL(show_dram_config);
 	WATCHDOG_RESET();
 	INITCALL(setup_bdinfo);
-- 
2.53.0

