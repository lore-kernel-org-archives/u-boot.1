Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F413CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B4A848EB;
	Fri, 12 Jun 2026 22:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pgTMTxfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B90984949; Fri, 12 Jun 2026 22:19:31 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0668063E
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-517b1f2c6adso12455811cf.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295567; x=1781900367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lP2EKlas0xg5fKU1GwOU0mCHlS9V92y6NdWDxgPV5xM=;
 b=pgTMTxfUUDy4LfLRLiIBMy9t2Bz9o8OQ173uqJy0+pXmV3TIKxT/gEilJgyrPOUsHf
 re36An7XINgyVxHLfdM6Af/gjXyhImqeQwWVEKkpZSL9pOQt6s2PcXJOF61dtHk9gmqH
 bWGZtlyGtGx/rDeCSeLuwklRxAaiacoEoE9V5O4UPOqm1ImSn1e6V4KC2a9j8f34SvUS
 9BHeWgMhoUu0aOd+VMg1/g2JOZxC+e05XMdZ7A4DXe5iWw5iAP2oeCzt1Xs/eQPzUZF4
 N7QzcZrELX7+Nw8RkM5UkooDJaXOeXZ9jsRsEpE/2CeHJn5xHc3QNlfZNYKtUgGpgtAe
 lmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295567; x=1781900367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lP2EKlas0xg5fKU1GwOU0mCHlS9V92y6NdWDxgPV5xM=;
 b=TnphoxS6ZdFOXV+3upPRm/U67q4g9dJB++XULKMDpmjdiv+LVBrruRRaqz+CRYLgTe
 DuHAw0T+Xpc9tXpHOHDdOrfaSLeszNMZFIvs9OMabX/1UhynXn2+XWqa3pn5zy6se6T2
 3wn/+CyV2SrxAZ9PxFjC4te5dJILfZkA/NkwPHrea2iNDE5gDD2fuEHEV0L9nQvsDVbT
 jvb+MOF/mUZLv/2ideTVaQKzFxZ7av3sou0+emOTrRUnIfegZ3ChekTbPRZ3gkzELnvZ
 920wT1/6liIaGGdF7159iOda+DnOfGw1kdX3XPmBBqIisXuYpADNB38DR+fxLCfZJ0y2
 BikA==
X-Gm-Message-State: AOJu0Yyw0hlX4fS+apWJkS+cNPbsH/bZHE4hZPaseX4hp1aPH0OCKESm
 HsC/zFAjqOY1NV96lrNqMWk0ScT88UT1IkAzTJbyTifLRB/9+WwqzEeI2b+W/y37
X-Gm-Gg: Acq92OEBVCfJLrt0djQH4tAnakBozUfJrGLuWEu6+GqXkNOf8SaqervUzTow6wHjCPl
 dc85DRcjgI0jvreQP3M+Eemu6+UAOurdWiht4YbQQXleigbXb2KZEV+HO7Nwuo6UolxXlb9CH2e
 3IhU1k0Z2xc9kKQyJXQA+RqShkiFMYPoRVrTsoaQTQb6lpbZiW+2uWI2yTRMe/P+mFGJgzxK2vE
 9JuPEPQqYCZbaFJ/KSG+uoYf0fXeY5i0+7Vr0HU+EP856Ktow2BLvGmbsBERzy7iw2WUXifEfiX
 Kb5EAUv3yIX3GbAWol8+GIxVz2/axOeg1n1d9aKz2BurDZb476d1hhcNceWEOPdNn4yZWWPAGkY
 4VQLZL5t4UnzSk15EVNicpDY0azZzjMoSsDZbrUXBIp3fgkY9fzaPRYY5nWpfj1piMHVM4ljJCW
 1gpDPlqwfopb3zWN0wMHEwMYqNPZrmhunnuJMlXKzSJFCzU5rYFZLWFwm54L+F/zPlkgF2llQ/W
 Kz2M1/p
X-Received: by 2002:ac8:5a0c:0:b0:517:8069:8afb with SMTP id
 d75a77b69052e-517fe4ddbf4mr62575621cf.33.1781295567310; 
 Fri, 12 Jun 2026 13:19:27 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:27 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 6/8] cmd: meminfo: widen memory map addresses to phys_addr_t
Date: Fri, 12 Jun 2026 16:18:59 -0400
Message-Id: <20260612201901.73657-7-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612201901.73657-1-raymondmaoca@gmail.com>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

On 32-bit builds 'ulong' is only 32 bits wide, so the memory map
truncates any address or size at or above 4 GiB even though the
columns already allow 13 hex digits. Boards with large DRAM therefore
print wrong bases, sizes and gaps.

Use phys_addr_t for every region address and print it as a 64-bit
value so the map is correct regardless of the build's long width.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 cmd/meminfo.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 69a5b1b51a2..537ef2a0e13 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -21,18 +21,23 @@ void __weak arch_dump_mem_attrs(void)
 {
 }
 
-static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
+static void print_region(const char *name, phys_addr_t base, phys_addr_t size,
+			 phys_addr_t *uptop)
 {
-	ulong end = base + size;
+	phys_addr_t end = base + size;
 
-	printf("%-12s %13lx %13lx %13lx", name, base, size, end);
+	printf("%-12s %13llx %13llx %13llx",
+	       name,
+	       (unsigned long long)base,
+	       (unsigned long long)size,
+	       (unsigned long long)end);
 	if (*uptop)
-		printf(" %13lx", *uptop - end);
+		printf(" %13llx", (unsigned long long)(*uptop - end));
 	putc('\n');
 	*uptop = base;
 }
 
-static void show_lmb(const struct lmb *lmb, ulong *uptop)
+static void show_lmb(const struct lmb *lmb, phys_addr_t *uptop)
 {
 	int i;
 
@@ -56,7 +61,7 @@ static void show_lmb(const struct lmb *lmb, ulong *uptop)
 static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
-	ulong upto, stk_bot;
+	phys_addr_t upto, stk_bot;
 
 	puts("DRAM:  ");
 	print_size(gd->ram_size, "\n");
-- 
2.25.1

