Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE03C2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 22:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AAF78758F;
	Mon, 20 Nov 2023 23:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lPG+ywDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8AA87585; Mon, 20 Nov 2023 23:33:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA9987250
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 23:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 220CA3F280; 
 Mon, 20 Nov 2023 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700519630;
 bh=zcufABWP/oe4aZPAtu8GaSAVXhQgNuhzwPxvvA8GLQs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=lPG+ywDOlt/i3q7l5qpsHpCld7cj5l7UPMpKsQnT7gbz4i3fA/2r/YDW4moqSgPzX
 3l7QuHKNmuQnjF/Q/hbfKt9Rabqv2dEkcXRfj08qa7sOeIzh4fRr5IcDPbfjRn0zwL
 dMc/eX9O+h/rxTu3pDbmUE+aHPvJX3rRVlyx7rendtTr6sTlAP03JasnbbSaRWWwGE
 ZHO4YAeAF87TjGbxci8V17RSk0LkWpdaxVlR5UWRE6xMbPzeikzxnj46uOwbVVBrnJ
 IJNVhYrt2j8Ts0/eO5yQuuHhDuyzyagmOlcIWgwBNOiPoUA/Yxe1Fp7BrD5OCf6xfT
 3Q+FdUg929dmw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: generated SMBIOS table below 4 GiB
Date: Mon, 20 Nov 2023 23:25:58 +0100
Message-Id: <20231120222558.32014-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

We currently use an outdated format 32-bit format for SMBIOS tables.
So we must allocate SMBIOS tables below 4 GiB.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_smbios.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 48446f654d..0fbf51b98d 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -49,25 +49,27 @@ efi_status_t efi_smbios_register(void)
 
 static int install_smbios_table(void)
 {
-	ulong addr;
-	void *buf;
+	u64 addr;
+	efi_status_t ret;
 
 	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
 		return 0;
 
-	/* Align the table to a 4KB boundary to keep EFI happy */
-	buf = memalign(SZ_4K, TABLE_SIZE);
-	if (!buf)
+	addr = SZ_4G;
+	ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
+				 EFI_RUNTIME_SERVICES_DATA,
+				 efi_size_in_pages(TABLE_SIZE), &addr);
+	if (ret != EFI_SUCCESS)
 		return log_msg_ret("mem", -ENOMEM);
 
-	addr = map_to_sysmem(buf);
+	addr = map_to_sysmem((void *)(uintptr_t)addr);
 	if (!write_smbios_table(addr)) {
 		log_err("Failed to write SMBIOS table\n");
 		return log_msg_ret("smbios", -EINVAL);
 	}
 
 	/* Make a note of where we put it */
-	log_debug("SMBIOS tables written to %lx\n", addr);
+	log_debug("SMBIOS tables written to %llx\n", addr);
 	gd->arch.smbios_start = addr;
 
 	return 0;
-- 
2.40.1

