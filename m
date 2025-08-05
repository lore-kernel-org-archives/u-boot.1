Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E185FC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A80783753;
	Tue,  5 Aug 2025 16:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="OEPHkudF";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="crVBnCSY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F75281D5A; Tue,  5 Aug 2025 11:41:47 +0200 (CEST)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971E6803CC
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 11:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=p6wHT7Or8Avm/4IzhLq+CIzM8N1SsCwTwThRd4z+pOc=;
 b=OEPHkudFZuQ8DyNPihag1tDaCvlQc1K6CUdXVbyxCgmqGCwSii17mpLudkvYH7wmc+SUVyTKthlN6
 0zcu8UB6pVl4fdNWehZyzBa3nT4RNW6c1r1M7DA83QsSUB7OZUnRn3dccVooOJSq6DwakBv9SYZ9Ip
 py47kS0Nin5iDU64=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=p6wHT7Or8Avm/4IzhLq+CIzM8N1SsCwTwThRd4z+pOc=;
 b=crVBnCSYy6fU3CSFGjgwFBe7GwkW19zPfbfmr6C3S2RR5KxKfGgkYyfCqRlbVF3RoDDt8pdlgbTxH
 jRuqtOScKph2zmJ/tVOpFNwMaz85qkxn9Owp66zlD3Epl9hW/uOEfq7LS+4GJ/sucmu0Cxf/6BQ5EZ
 ca6NU9ufJfvUpwR4FBGiJF3GEUqVFP+rz5ZUkKB5Pgi+p+PppW2iwbWB8gcDCvAYDdcbGY554VrOoq
 3QwNhOIwtBzwZD/PZwg3QxH3yyTHh4ma4NyKkDcwCVUFt9+JAvM8Pb5MfBrenSxjiit4FPWIW9xcze
 D8V31QGpU6lxcyliB+QeaUEqGt4B6+w==
X-Originating-IP: 20.86.212.242
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 63f0b56e-71e0-11f0-b288-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 63f0b56e-71e0-11f0-b288-878ee10b8a33:7
CFBL-Address: prvs=0312fde91a=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown
 [20.86.212.242]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 63f0b56e-71e0-11f0-b288-878ee10b8a33;
 Tue, 05 Aug 2025 09:41:41 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with SMTP id
 E1BEE8051DB; Tue,  5 Aug 2025 09:41:40 +0000 (UTC)
Received: from chbrn3-p-dev026.keymile.net (chbrn3-p-dev026.keymile.net
 [172.31.41.203])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id 7988960B7D47;
 Tue,  5 Aug 2025 11:41:36 +0200 (CEST)
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sughosh.ganu@linaro.org,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Subject: [RFC 1/1] lib: lmb: add lmb_get_reservable_size, fix ramfs
Date: Tue,  5 Aug 2025 11:40:12 +0200
Message-ID: <20250805094012.2268436-2-tomas.alvarez-vanoli@hitachienergy.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:21:59 +0200
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

Our implementation of the ramfs kernel memory calculation relied on the
fact that the lmb library was working with local copies of the lmb
table.

This was updated in u-boot 2025, now the lmb library uses a static table
shared globally. The function that we were using to calculate how much
ram to give to the kernel checks the free size, which does not include
memory that was allocated but not reserved. For example, when we load
the bootfs with tftp, that memory is allocated by the tftp code. This
memory will be overwritten if some other command wants to use it, but it
will not show as free.

This commit introduces the function "lmb_get_reservable_size", which is
exactly like "lmb_get_free_size" except it also considers memory with
flags set to 0 as free.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
---
 board/keymile/common/common.c | 10 ++++++++--
 include/lmb.h                 |  1 +
 lib/lmb.c                     | 31 +++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/board/keymile/common/common.c b/board/keymile/common/common.=
c
index 9b1068376b3..46e04a25abd 100644
--- a/board/keymile/common/common.c
+++ b/board/keymile/common/common.c
@@ -40,7 +40,6 @@ static int do_calc_ramfs_addr(struct cmd_tbl *cmdtp, in=
t flag, int argc,
 		return CMD_RET_FAILURE;
 	}
=20
-	// "Allocate" space for the rootfs (it's only on our local lmb struct)
 	phys_addr_t addr =3D lmb_alloc(size, SZ_16K);
=20
 	if (addr =3D=3D 0) {
@@ -49,12 +48,19 @@ static int do_calc_ramfs_addr(struct cmd_tbl *cmdtp, =
int flag, int argc,
 	}
=20
 	// calculate how much ram we can give the kernel
-	phys_size_t free =3D lmb_get_free_size(CFG_SYS_SDRAM_BASE) & ~(SZ_16K -=
 1);
+	phys_size_t free =3D lmb_get_reservable_size(CFG_SYS_SDRAM_BASE) & ~(SZ=
_16K - 1);
 	if (free <=3D 0) {
 		printf("%s: failed to calculate free memory for kernel\n", __func__);
 		return CMD_RET_FAILURE;
 	}
=20
+	/* We dont reserve the memory for the rootfs, because tftp needs to wri=
te it.
+	 * because of that, we check here if the kernel memory overlaps it or n=
ot.
+	 */
+	if (CFG_SYS_SDRAM_BASE + free > addr) {
+		free =3D (addr - CFG_SYS_SDRAM_BASE) & ~(SZ_16K - 1);
+	}
+
 	char envval[20];
 	sprintf(envval, "%pa", &addr);
 	env_set("rootfsaddr", envval);
diff --git a/include/lmb.h b/include/lmb.h
index 606a92cca48..74513c38369 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -106,6 +106,7 @@ long lmb_reserve(phys_addr_t base, phys_size_t size, =
u32 flags);
=20
 phys_addr_t lmb_alloc(phys_size_t size, ulong align);
 phys_size_t lmb_get_free_size(phys_addr_t addr);
+phys_size_t lmb_get_reservable_size(phys_addr_t addr);
=20
 /**
  * lmb_alloc_base() - Allocate specified memory region with specified
diff --git a/lib/lmb.c b/lib/lmb.c
index bf11405fa57..4537f582a5d 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -802,6 +802,37 @@ phys_size_t lmb_get_free_size(phys_addr_t addr)
 	return 0;
 }
=20
+/* Return number of bytes from a given address that are free or have no =
flags */
+phys_size_t lmb_get_reservable_size(phys_addr_t addr)
+{
+	int i;
+	long rgn;
+	struct lmb_region *lmb_used =3D lmb.used_mem.data;
+	struct lmb_region *lmb_memory =3D lmb.available_mem.data;
+
+	/* check if the requested address is in the memory regions */
+	rgn =3D lmb_overlaps_region(&lmb.available_mem, addr, 1);
+	if (rgn >=3D 0) {
+		for (i =3D 0; i < lmb.used_mem.count; i++) {
+			if (!lmb_used[i].flags)
+				continue;
+			if (addr < lmb_used[i].base) {
+				/* first reserved range > requested address */
+				return lmb_used[i].base - addr;
+			}
+			if (lmb_used[i].base +
+			    lmb_used[i].size > addr) {
+				/* requested addr is in this reserved range */
+				return 0;
+			}
+		}
+		/* if we come here: no reserved ranges above requested addr */
+		return lmb_memory[lmb.available_mem.count - 1].base +
+		       lmb_memory[lmb.available_mem.count - 1].size - addr;
+	}
+	return 0;
+}
+
 int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 {
 	int i;
--=20
2.43.0

