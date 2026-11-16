Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754B606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uZVqb/JI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=plDjlZdK
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D978C40653;
	Mon, 16 Nov 2026 16:27:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dWURdaUbkeMN; Mon, 16 Nov 2026 16:27:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6A2340636
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846475;
	b=R4u71crx841PVLun18bZnO9bzlKq+dVOs88lnOpZQKWRTqhUbG2EUxN5YqDPEgdzXTW2
	 D2LKePld725Z6jmuEelw/BVOx8l/Pc1QFYO4Y6Tq2bir+C0Tj6lC83DcBMoI69gpAfOHy
	 ChFOCNJ/rCB8XEE7ZajTaqBkm4VQyazRGCLUINJtE21c+P6rSWqqzp/oxXluHYYVb44zL
	 04mOYMqU6maIH+T9VFJ6Yg6Ot3p+fyTITxLT1FTkFOZwD2xDhKbuEDCMxz1JTBKyARYWn
	 S9s9CDZxGRwkGGIjhFze4VmpKFyRxOPzFOKEhaWt6tgXZD+Ze3wnlU6sG3MaKgXKfAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LZEQUlLhxtyaw5SVj4J1aE92xk6vIkwo/od0UkB2eO0=;
	b=SOSx4vFDsiSfdaXPXN+QYaBiE/3E9fKM4zckBP9E12nVQUFbCzoKBC3JO16yj7OIGywO
	 wBtPpu44o92/w6sAhQ31keStEFwuI4az3WHv8ll/N0YjVGXSX+IZOaSVpGYeNH9sDKgqY
	 2dwOqHJnhjDqIxr9lCILIarmbi9+QjO8h90UBDpcOqVjKD5MWg7USUz3nHO/wXQEWU42P
	 ifHML755CdVnblvqyPpbU+w3+rc9J5hN4brr/ja4ukAh92CaOfAPmgzOxNE3m1EGehAUn
	 A5yAE6THN2Nm1/BgNffcN/w+YhZB95Ey4QzwSowUfEoTGBm9KKESLD5pfscXFCFxBNQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846474;
	bh=LZEQUlLhxtyaw5SVj4J1aE92xk6vIkwo/od0UkB2eO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uZVqb/JIwvuaFE6Oueas+LjDzgd/dTt8hjC9VFHiVzpAdsvNOO1vNXH2bhlTMiOc/
	 DUJn6k2UMmNGl0DdWkWRQxpJIU0ZyVldMYHbr3CsKkUbcmBvpHz33F9f/MSwQYip95
	 vPARi0+3FMRssAD8C6dK4uhJgb9tvUoE5imVPkyD/h4HB7tW9oA8OGB32VeBSFqNGx
	 lCdyTiHncveYrQvjTl5/ArdjDErhHPOC4CKoFsgQ45dVbmETpVGql3uv1N5S9zA+Vm
	 loY4u2/vNapLgJv5PCPh4Y0WlQ3inU+i5sEwyMacdLogkn3bD7ECj0WE/dKlVIBw9P
	 MtAVsXUqE8jWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6A2340636;
	Mon, 16 Nov 2026 16:27:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 39EB52FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B5BE80FDE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UF8_EH8SCr70 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:27:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 889DE8100A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=plDjlZdK
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 889DE8100A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:27:52 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=plDjlZdKrOb7ca1Pc9hIwoMiMWNWEDnNLMPxppCiKlcrf4e/zGQRCm/JZ6np4nMfaSEde/jO70lIyLjf0bCrbJ+wg3SLPOVwT/tfQrI4IcR85eR4ocXHZeCk4JKqBnjhYqzV4kMK8B+y2kJWZCtu7Dh6gulTXEaM6ISPt/K7AD8=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=LZEQUlLhxtyaw5SVj4J1aE92xk6vIkwo/od0UkB2eO0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794846461682135.67717868419186; 
 Mon, 16 Nov 2026 08:27:41 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Tue, 17 Nov 2026 00:26:17 +0800
Subject: [PATCH v2 2/4] riscv: Fix up the OS memory nodes from the DRAM banks
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-riscv-fixup-memory-v2-2-4731aa6c3fb5@pigmoral.tech>
References: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
In-Reply-To: <20261117-riscv-fixup-memory-v2-0-4731aa6c3fb5@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>, 
 Yixun Lan <dlan@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>, 
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=2SQWEgj96dm7ar8hkI1Wq7KrWD8WfYR4+wN4FM1r6+g=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ+6510uJyhkqewME/1GEv+4hZ1i4CwBRpdZ37YC547E
 /72pPSPjlIWBjEuBlkxRRYuf/F/1jo8344ItN6HmcPKBDKEgYtTACbCt4eRoTVm/k0XjTt3Xyxq
 9Ln2/ldRwD7janbm1zeeLqp9IVP9npGRoWO/klLog+LAlteKaWufKRz5d/ZXYMskQ1+7zP6J2ZN
 ZuAA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The device tree loaded for the OS may contain a static memory
description that does not match the layout determined by the firmware.
RISC-V currently relies on board-specific fixups to pass that layout to
the OS.

Update the OS memory nodes from gd->dram[] in arch_fixup_fdt(), as ARM
already does. Platforms that need to keep the memory description in the
OS device tree unchanged can disable CONFIG_ARCH_FIXUP_FDT_MEMORY.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/lib/fdt_fixup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/lib/fdt_fixup.c b/arch/riscv/lib/fdt_fixup.c
index 6dfd1a2d5b8f..0786a03e58cd 100644
--- a/arch/riscv/lib/fdt_fixup.c
+++ b/arch/riscv/lib/fdt_fixup.c
@@ -160,6 +160,22 @@ int arch_fixup_fdt(void *blob)
 		return log_msg_ret("could not set boot-hartid", err);
 #endif
 
+	if (IS_ENABLED(CONFIG_ARCH_FIXUP_FDT_MEMORY)) {
+		u64 start[CONFIG_NR_DRAM_BANKS];
+		u64 size[CONFIG_NR_DRAM_BANKS];
+		int i;
+
+		for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+			start[i] = gd->dram[i].start;
+			size[i] = gd->dram[i].size;
+		}
+
+		err = fdt_fixup_memory_banks(blob, start, size,
+					     CONFIG_NR_DRAM_BANKS);
+		if (err)
+			return err;
+	}
+
 	/* Copy the reserved-memory node to the DT used by OS */
 	err = riscv_fdt_copy_resv_mem_node(gd->fdt_blob, blob);
 	if (err < 0)

-- 
2.56.1

