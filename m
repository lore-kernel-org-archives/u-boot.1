Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE7FC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 18:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D67FC880FE;
	Sun, 14 Apr 2024 20:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713119893;
	bh=z96GMqF7GGmsDctxJj4yt6Os5qABj4B10VNQzSvyYAQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gdv36XYRxKcsTQp6H5b6rZLtmZfEwSXrZaz3KomUUMHASIK6TPyX2R5+5/ntO4yGF
	 ier7Y/JOAS2LIFgjNgNxKgNo1y5QisG112rH5/FNZxZeQXL66Fkr9C5YR55FOnwaGo
	 Cskp2nsIs1ER/IM2rM0ExQv/eEjI0yJTsAUbd2H1mdV+gaa1yIndBVkfqVC1mwyST6
	 a6cDlO7os/BlteGGtHMIeusbBmWF1I5q4tfSosRMhopoH61eSDxiP/ync6G5DShegG
	 rGqRg9/Y2IMXKF4PVvKXme9XW8jmkWRZHoCSDYn2XLXd/u1F1cJlbX8XavHfJds20t
	 U4rFd7y0dGyCw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5AA9D88059;
 Sun, 14 Apr 2024 20:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713119892;
 bh=z96GMqF7GGmsDctxJj4yt6Os5qABj4B10VNQzSvyYAQ=;
 h=From:To:Cc:Subject:Date:From;
 b=hgVLrqq+IZ6KJvW50JHJaKE+ppc5UKTgVHfDUpo+0kB1xyKHbAFjWbGRNwzWtgtcq
 aaRbByRvE0jCmr2WfvPImxczCIihUmRgxv+SSGWvs/o1VEFsy1W0gLnSHtjixXGeMH
 s2uoIqY/ICXl1Oug9LVAsBeCFZ6sp8UP3yzu5Hpt+pgL6VnaVGnjxprJ2XUOprqtkm
 7rFVQa9Qz0nOSeIE5Jn75FPyyhy9XmaTFI9HBFOqpWs1Gh77JAGDDhIOKHGbr8oPkp
 iXVZsXA787FM/p8FyPGO1R120QVW9PkNUhqcAJgXxXjqAuExvS09JiztbsMC5dDoZs
 6G5ygCAKe8ryA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] boot: fdt: Turn all addresses and sizes into u64
Date: Sun, 14 Apr 2024 20:37:20 +0200
Message-ID: <20240414183759.146925-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

In case of systems where DRAM bank ends at the edge of 32bit boundary,
start + size calculations would overflow. This happens on STM32MP15xx
with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
usual 32bit system DRAM size overflow, fix it by doing all DRAM size
and offset calculations using u64 types. This also covers a case where
a 32bit PAE system might be able to address up to 36bits of DRAM.

Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 boot/image-fdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 2b92bdaff16..f09716cba30 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -158,13 +158,10 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
  */
 int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
 {
+	u64	start, size, usable, addr, low, mapsize;
 	void	*fdt_blob = *of_flat_tree;
 	void	*of_start = NULL;
-	phys_addr_t start, size, usable;
 	char	*fdt_high;
-	phys_addr_t addr;
-	phys_addr_t low;
-	phys_size_t mapsize;
 	ulong	of_len = 0;
 	int	bank;
 	int	err;
-- 
2.43.0

