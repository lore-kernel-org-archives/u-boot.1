Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C854CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1348284944;
	Fri, 12 Jun 2026 22:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SSzjWk/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521508494B; Fri, 12 Jun 2026 22:19:33 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7BC84944
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-8ccf6a63a45so17792846d6.3
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295569; x=1781900369; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqWOZ204ZYsOFE+X56o7Mez6ytuOTcvtYgM4W8tVAfg=;
 b=SSzjWk/tLe25NrFWpFRj3mDJZWrrKxd4so5OY6LdsUWxPu3B3vV4UVPMxHg2uhKC7Y
 9iu6SrUxE3ljH6U2nshbX1fVrI77rDiuDl+rF8LDS1idbjr4BY4LXYCIqNZckwiSNN0N
 7i/CVSJedkWlCo1T91LT5DhKY252yMsP0SnbXBFR8DLbOQzyhaNCVvP7eHS9ypnZTdSr
 ywR9pxKPTO6Xsxa//cKH6zWxa0AMhfeQMfwXepBuQxkzSDwq0vAJlJwReGBPddsQkoq6
 jIuqxxZaYlI5rcrDQkdPg4rCyh2iYKIZLuPb27GLWrNJxXmUAgcdsSdcfPeDlKv4Lhqf
 Oxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295569; x=1781900369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OqWOZ204ZYsOFE+X56o7Mez6ytuOTcvtYgM4W8tVAfg=;
 b=EgnXRUJ/0UZEwi3UcUyzQZ5xW5SGB/pGc3N4Ig7Di5w+g63OZC6HcWyPYNG/yIpSU9
 CXIQjwC5JGh6Pe95ygyvwqUlAbtm+WItfEqMPg0rRudEJqSrNq+k7GDPv9JnAFG9pQd1
 vUZ/RPnP2E0mkEFxx+/WL569qKxy4kTd8oR7To/Mk7JJVzL+ncU2vzpZc7lLWPD6u44I
 3N2ffURTRIEtdgtz8+gD51FvtTPwRzjVNCHbbNSOT9LYhLK39RW9y2UcfKWka0cW5V0i
 /tjdYsTrl7H2q4aAxPio+tcrf5jRzx2rwxwEmMZM2VX9ARkr2LlGZMzuNlt7KyMUsUfC
 u9UA==
X-Gm-Message-State: AOJu0YwUtMl06Tg6scTNZXwwjDL4PqWbR3pHNyFywG5k0N0ymuy3VY3t
 yNCfHURCkmkCXwMKu+qI8jcTMU3tqUNFffyONUEdl+YBWY5aC48RcKk7Y8FCrPm4
X-Gm-Gg: Acq92OGShINQ5ugnql9Z6ATw8/R3q9ZhJCE/1Z04Wk3a//He/Vk76ztSJyAQphDvfZ7
 hE4wiwKKE09xTOIfhq8Hf2JTznwsQvMH61l+OGUMh2J362+9a7UoSqS9Ml7WMhsrzb36r8XpSw2
 4I6O86+vjQ300BrG/Pf0qOe7rMkK/9XsI8XHOev4wSyQ1USH4yO+nAJRy23DKGA3R0KFHpQ2vTb
 RiQlsQ0yoUNsldVIjCI2L2xuylCjjmZscsyXVPiXJegR+R/8F5ExjEYjzP1ih/UDE8nkAnx+b1L
 OsYl+EpnWFuP3FpRutG0Z28YXpfFolBvjhQ1Dl+appCQivlkGeEoU+XZxudLmnspfZZr++bAmru
 IpgKfV7XdsfYeHLMhE9GoH9U5rGEQF08qz4VB7HHtPi+dYBXpO8H3+I3O2j0gg7l9xDZG89O5ul
 psb+OfcD2Mk6iZ+Af2nkfha3YxzFyr4Oj93raMeLZQGpIRdeiyDHwMuTL/mKHa5O9cetUB8oEan
 BhY/LRi
X-Received: by 2002:a05:622a:1109:b0:517:59a1:82cb with SMTP id
 d75a77b69052e-517fe56614dmr61820611cf.48.1781295569517; 
 Fri, 12 Jun 2026 13:19:29 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:29 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 7/8] cmd: meminfo: fix the lmb info for large DRAM
Date: Fri, 12 Jun 2026 16:19:00 -0400
Message-Id: <20260612201901.73657-8-raymondmaoca@gmail.com>
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

When DRAM size exceeds 4GB, it may be split into two separate banks,
leaving an address hole between them.

To properly handle this configuration, LMB regions must be calculated
individually for each memory bank. Additionally, all address
calculations should support 64-bit to accommodate large memory ranges.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 cmd/meminfo.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 537ef2a0e13..c5cf01f62ef 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -31,31 +31,53 @@ static void print_region(const char *name, phys_addr_t base, phys_addr_t size,
 	       (unsigned long long)base,
 	       (unsigned long long)size,
 	       (unsigned long long)end);
-	if (*uptop)
+	if (*uptop > end)
 		printf(" %13llx", (unsigned long long)(*uptop - end));
+	else
+		printf(" %13llx", (unsigned long long)(end - end));
 	putc('\n');
 	*uptop = base;
 }
 
 static void show_lmb(const struct lmb *lmb, phys_addr_t *uptop)
 {
-	int i;
+	int i, j;
+	phys_addr_t bank_top[CONFIG_NR_DRAM_BANKS];
+	struct bd_info *bd = gd->bd;
+	bool get_bank;
+
+	for (j = 0; j < CONFIG_NR_DRAM_BANKS; j++)
+		bank_top[j] = bd->bi_dram[j].start + bd->bi_dram[j].size;
 
 	for (i = lmb->used_mem.count - 1; i >= 0; i--) {
 		const struct lmb_region *rgn = alist_get(&lmb->used_mem, i,
 							 struct lmb_region);
 
+		for (j = 0, get_bank = false; j < CONFIG_NR_DRAM_BANKS; j++) {
+			if (rgn->base >= bd->bi_dram[j].start &&
+			    rgn->base < bank_top[j]) {
+				get_bank = true;
+				break;
+			}
+		}
+		if (!get_bank) {
+			log_err("The region (base:0x%llx, size:0x%llx) does not exists in any DRAM bank.\n",
+				(unsigned long long)rgn->base, (unsigned long long)rgn->size);
+			return;
+		}
 		/*
 		 * Assume that the top lmb region is the U-Boot region, so just
 		 * take account of the memory not already reported
 		 */
 		if (lmb->used_mem.count - 1)
-			print_region("lmb", rgn->base, *uptop - rgn->base,
-				     uptop);
+			print_region("lmb", rgn->base, bank_top[j] - rgn->base,
+				     &bank_top[j]);
 		else
-			print_region("lmb", rgn->base, rgn->size, uptop);
-		*uptop = rgn->base;
+			print_region("lmb", rgn->base, rgn->size, &bank_top[j]);
+		bank_top[j] = rgn->base;
 	}
+
+	*uptop = bank_top[0];
 }
 
 static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.25.1

