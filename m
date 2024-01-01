Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3737C47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 11:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78F1E876DE;
	Mon,  1 Jan 2024 12:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Zuzvjsnb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A38587705; Mon,  1 Jan 2024 12:53:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CD3C871A6
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 12:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9E6713FC04; 
 Mon,  1 Jan 2024 11:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704109978;
 bh=xGhTKZa5g0jdL7087MTlKyyUeYR5WgIc8bu0cJ5Nq/o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ZuzvjsnbmRhyOhApLk7U7e5osidTtebHs29zFDLCZ7e2cH01JRfBFm9HWDBGzDzRK
 t5hvTr9iy6q7Xxj9xtELLtSjH0gvuHycUbTkTNA9tCYMbrzgzjDVRCozVwLjBpMeN4
 BTzZ4G0h+oRSyXtSAB7dhkVLUnTPlG80h5asVrWpQLVCqhIRf2cyMzYy+9hK+lirDE
 fljTpJ9S0XE/6HDxKi+n6StGE1/hKhHTDi5AZEKf8+e3Qxu+q28z9I5u6FLyWhstmX
 z+Ey9wGQ8HXBISSeYGaXzsFrlYuP6CDZ1G2ULIiFc5Z14DryjlO74QvvvTP22QNBtt
 Pdyb8AtKGO3cQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] x86: all firmware tables must be paragraph aligned
Date: Mon,  1 Jan 2024 12:52:50 +0100
Message-ID: <20240101115250.78735-1-heinrich.schuchardt@canonical.com>
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

On qemu-x86_64_defconfig the following was observed:

    => efidebug tables
    00000000000f0074  eb9d2d31-2d88-11d3-9a16-0090273fc14d  SMBIOS table

The SMBIOS configuration table does not point to a paragraph aligned
address. The reason is that in write_tables() rom_addr is not aligned and
copied to gd->arch.smbios_start.

The Simple Firmware Interface requires that the SFI table is paragraph
aligned but our code does not guarantee this.

As all tables written in write_tables() must be paragraph aligned, we
should implement the address rounding in write_tables() and not in table
specific routines like copy_pirq_routing_table().

Add paragraph alignment in write_tables().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/lib/tables.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/tables.c b/arch/x86/lib/tables.c
index 5b5070f7ca..89d4d30a6a 100644
--- a/arch/x86/lib/tables.c
+++ b/arch/x86/lib/tables.c
@@ -97,6 +97,8 @@ int write_tables(void)
 		int size = table->size ? : CONFIG_ROM_TABLE_SIZE;
 		u32 rom_table_end;
 
+		rom_addr = ALIGN(rom_addr, 16);
+
 		if (!strcmp("smbios", table->name))
 			gd->arch.smbios_start = rom_addr;
 
-- 
2.43.0

