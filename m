Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3F3C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A779B88414;
	Thu,  6 Jun 2024 18:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=nic.cz header.i=@nic.cz header.b="ga1LDZKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 452A68844B; Thu,  6 Jun 2024 18:33:36 +0200 (CEST)
Received: from mail.nic.cz (mail.nic.cz [217.31.204.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E240883CE
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 18:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nic.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.mojik@nic.cz
Received: from marcharch.labs.office.nic.cz (unknown
 [IPv6:2001:1488:fffe:6:592e:6672:3345:e2e0])
 by mail.nic.cz (Postfix) with ESMTPSA id CE20F1C2B72;
 Thu,  6 Jun 2024 18:33:32 +0200 (CEST)
Authentication-Results: mail.nic.cz;
 auth=pass smtp.auth=marek.mojik@nic.cz smtp.mailfrom=marek.mojik@nic.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
 t=1717691612; bh=WWhp4I7EVnGNJgAjaXOGT1hZMMlIfE16pcjKBKwxG58=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
 Subject:To:Cc;
 b=ga1LDZKqmgwCaKy6HifhcIf+iNRSV5DEI+D1Eq511Z+oJrj0kkc+w9KOs6u3gW6w6
 DBlVsDV85edeOFe4wYnlhYBwZaH2VYaRSc22JC/TJFV8mddxAhK9nAmxbZnNVv4mUZ
 OyoXNh93BzlU3zRznIRqmd5sA+cwY/VBeaUfU7QI=
From: =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>
To: u-boot@lists.denx.de
Cc: kabel@kernel.org,
	marek.mojik@nic.cz
Subject: [PATCH 3/6] powerpc: mpc8xxx: Extend find_law() to
 find_law_by_addr_id()
Date: Thu,  6 Jun 2024 18:33:23 +0200
Message-ID: <20240606163326.386950-4-marek.mojik@nic.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240606163326.386950-1-marek.mojik@nic.cz>
References: <20240606163326.386950-1-marek.mojik@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.10 / 20.00]; REPLY(-4.00)[];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25192, ipnet:2001:1488::/32, country:CZ];
 WHITELISTED_IP(0.00)[2001:1488:fffe:6:592e:6672:3345:e2e0];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action
X-Rspamd-Server: mail
X-Rspamd-Queue-Id: CE20F1C2B72
X-Spamd-Bar: ----
X-Rspamd-Pre-Result: action=no action; module=multimap;
 Matched map: WHITELISTED_IP
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

From: Pali Rohár <pali@kernel.org>

The find_law() function searches for LAW just by physical address. This
is unsuitable for cases with overlapping LAWs. Extend it to
find_law_by_addr_id(), which searches for LAW by physical address and
target id.

Add a static inline definition of the original find_law() into fsl_law.h
header.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
---
 arch/powerpc/cpu/mpc8xxx/law.c     | 5 ++++-
 arch/powerpc/include/asm/fsl_law.h | 8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc8xxx/law.c b/arch/powerpc/cpu/mpc8xxx/law.c
index f16bc19966..f3a9749625 100644
--- a/arch/powerpc/cpu/mpc8xxx/law.c
+++ b/arch/powerpc/cpu/mpc8xxx/law.c
@@ -130,7 +130,7 @@ int set_last_law(phys_addr_t addr, enum law_size sz, enum law_trgt_if id)
 	return idx;
 }
 
-struct law_entry find_law(phys_addr_t addr)
+struct law_entry find_law_by_addr_id(phys_addr_t addr, enum law_trgt_if id)
 {
 	struct law_entry entry;
 	int i;
@@ -146,6 +146,9 @@ struct law_entry find_law(phys_addr_t addr)
 		if (!get_law_entry(i, &entry))
 			continue;
 
+		if (id != -1 && id != entry.trgt_id)
+			continue;
+
 		upper = entry.addr + (2ull << entry.size);
 		if ((addr >= entry.addr) && (addr < upper)) {
 			entry.index = i;
diff --git a/arch/powerpc/include/asm/fsl_law.h b/arch/powerpc/include/asm/fsl_law.h
index 9e2f2d5370..d1cd728397 100644
--- a/arch/powerpc/include/asm/fsl_law.h
+++ b/arch/powerpc/include/asm/fsl_law.h
@@ -130,7 +130,13 @@ extern void set_law(u8 idx, phys_addr_t addr, enum law_size sz, enum law_trgt_if
 extern int set_next_law(phys_addr_t addr, enum law_size sz, enum law_trgt_if id);
 extern int set_last_law(phys_addr_t addr, enum law_size sz, enum law_trgt_if id);
 extern int set_ddr_laws(u64 start, u64 sz, enum law_trgt_if id);
-extern struct law_entry find_law(phys_addr_t addr);
+extern struct law_entry find_law_by_addr_id(phys_addr_t addr, enum law_trgt_if id);
+
+static inline struct law_entry find_law(phys_addr_t addr)
+{
+	return find_law_by_addr_id(addr, -1);
+}
+
 extern void disable_law(u8 idx);
 extern void init_laws(void);
 extern void print_laws(void);
-- 
2.45.1

