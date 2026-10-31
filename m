Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE6606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dXOqvchq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vY1bHucd
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E0C98110E;
	Sat, 31 Oct 2026 12:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-8F8oIxUmYY; Sat, 31 Oct 2026 12:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A244C81107
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793449649;
	b=VqNwr2bIYrit/nzDwTrlsWgXNcKUr+Vrrio3uOpTWR1ZXQ/ITmAC+kkR2yYl/K4DAv9D
	 v8o0NQ5IWxQkHwqKWQPdpQwwCvQ4VefxZ22HF8mLVihsxJ6iuf9scuja4GFcesl9IaOvx
	 TjnW4zSf3LCZC31ZGFolHS5GcPek0l9NXEIlDaZwdtc67T7WKT8h3mWgSSHjorp7Hkoxf
	 t2SIzgHyU3DOqJlJmcla1ZThix7CfwWHHs02Mp5l5Qf8V3WFiD8LqGw9LZEz7NRrM+v/H
	 wN9pm48WLpIzlc7/pE0e/SSTgp0ENtkQPGMOdwqW17G9ittUXIiUnw+EAW748US+CvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793449649;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QhlVPU0xr8AJ1QINaA1ze5lTIaNeY0dCunxJj60wdso=;
	b=J+cJ0oQzIzVE8hH4vK2SDUzVtT2WVROavh0EtR3sJ1zPX/qGJR/bAd3qTJizHX1kd15L
	 gHHW6YltsWI23eKPJ+RN8wttBbpvjsePLr+Dnh89dNIPhdzHYEwoai0Z09zHZu4Ti+0hf
	 t+y57K2zfZkG6RpUsNlN2DR0TBs3rL9ezUid057LMvAySPAPKkJMnw3oCcLBDHOuE1/hF
	 wV/X2Kfus7HAlklY7bxf43bxGLgYqwukdgFu1htdfKarqjazcxmCB+1R4Q/kttos/AVlW
	 T+KV1kbxUJNGFXol8g4f1dJI1F4GgRz3Q7Z4rH3lSbJfBk/o9VyXqNCEB1+veGDDgrA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793449649;
	bh=QhlVPU0xr8AJ1QINaA1ze5lTIaNeY0dCunxJj60wdso=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dXOqvchqS9+IB2IWiSzmhPh/0uzY9pmwVR0r2ZtAg3DtfsNELrNsOi+nPEaDCT5x8
	 qtOY8Ol4mxcLWIbAFUAYCV8cnjUSlXVqhrNZN9Z9BvUnk9ClCMaEqtK6trZSiah//a
	 VLBmtnJqZhJLR8Jz+daZVl0N/C7qBBxpHSbkXCvHAavDW2SgiTNDCZk/0M9CUcgg+n
	 X5Ay30UBusTZKw6+J7QcxTkvrPa9HqVJgosmy3zNjBoyl3+YUWQpoDTufTBoPrWZVO
	 Z3BLRSvrJ4HggTmPKoLobdAt+1ipL73EJelaew1dacN6ezidmBxLEl/XH2Y6o79j+k
	 oiqPGg0arb9Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A244C81107;
	Sat, 31 Oct 2026 12:27:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 51139380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41AAF60645
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZ4V7Y2QU2wG for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 12:27:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65A6960641
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793449647;
 b=arlj/hh74cs/YpaG3s01zedGI7Feo5y5Rl9zVtxoy0LnAQdM7fF0NX5GEi6WhaVQYWiv
 ep3iLqLzQmVlxglddHfl1WFQwEjRcnbmFVgv5ICAVC4SGDFRkkwH1XD/3xKYzCHvUjzby
 K0Kp15SKPxQoHM24/hHYnQZB/EWQBHTjaz+FtZqKmGKkXYgO7SanEAUJARojRBBCgCCFd
 /a/Mh55BTYQqx+jBTWGexwA23cg5FVVJH4yMUmfZI/EGdOkYn4Tw3vGHXJPcjCu36L5Uf
 rLS3G8lmdq8LMxu3/yWJ9c1FZgSPq9JP6H52wUzk/xjQL6AttY5scgehM0yoWoB7+lQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793449647;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=QhlVPU0xr8AJ1QINaA1ze5lTIaNeY0dCunxJj60wdso=;
 b=cRHA8qwQBRXGS+BM36112bCnzHoVDRRe49ojUp/EjwiFYtdlvkOSZueFlEEiLE+XWWs1
 m68O+5n4DRr/VHj4xaYs/uz/S8GEaRaWbQDyQb5SR8raUszasqnCrhX/qum0NjWRb7hta
 lkQNNXLOTcYjx7iuqtltcYHG7zn7xuRxGAHKHfwSfbBCI2sQ8Eo/5DOgFGleXAXuME9tz
 27Gx1qZw5DE8NBnNtE2ioXpSiCusKWqFVpS5/VLuHZhb08tDIGf26XXytBChuOAGLdmUj
 r2Tf3tJM4ux2geYvL0zOHffyC3J6zG+6iExUdriVZMEL8TilIBiJsRRzWcT71QiZTcA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vY1bHucd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=vY1bHucd
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65A6960641
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 12:27:26 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso719119a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793449646; x=1794054446;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QhlVPU0xr8AJ1QINaA1ze5lTIaNeY0dCunxJj60wdso=;
 b=vY1bHucd5tgGaEEzI2xagiSR/KO1yDlL0odWHdLAr/ShuAoN1RtT8M/xYy+80S4fU1
 nvyjd9rEZoEFgrQYo/yzsJcygfZcStodOMhdco+5VcdXI7WSjMPbXG4bXBucvQKMskG8
 SYX+sHda7Ac3qhlSf+MjYkz0CZUu7uE7inSX/0KAjfRl/AcfJGJCBz9L8KjGZ5jhWCP5
 bLAq38jBby8073EVfv4dcFyPqKeXiBQEIjHckZM5353bbDH50cVFV2DTZhKDFJKHTkM6
 jMxdHKQ0LkmbP4Toz+Y/AnoOnCXmLjQ5MqrRy1KJmpgXEUk41Iv/pj1bYD6aQ/H6Jfa+
 5szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793449646; x=1794054446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QhlVPU0xr8AJ1QINaA1ze5lTIaNeY0dCunxJj60wdso=;
 b=hnXQEcSgdsedxO74QAywiS3o3vYZffzOjP5j0PJKU7REddpVu4qGzfUgZ/0ID+6i8f
 jiKRWOGarlUgu+HT+Gh7qD9yOlb1Cc+jeCtd18iNvyMsjwZnKoC2bfbSKalIUxGRCUZb
 sJdJhtbow/xSOLqkHRZgp3v5buBNccKOJS5xFFENQlTI0XpZch8iDVIyUtPCbQNj/r27
 QoV4nhTSCOIL8Qr1DsylLjTUIyKnWJsHPNtljg1w8vls6cxaCC7h/kVAsmkvtPDv1g9v
 sJgyMDj2LbKHbmoMC+bk14VQEvOlo9lxGRj7ndVFPKaay4nyn5+Tq0eFqb93Z9INf+5Q
 ew9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmXmbF2cLT1xiS3E+Cz7afau+38sqERqJMM1uXInuZjZuaUQrChdBeAPRYeHMM5f/4bgM6F2k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKA5AdHN/7FjSWOwWFNa7HopbBS0t2BaIQX3Q/k6a+2nlOypMKE
 dpoeQ2gmLpx26Eb1bYlS4NawoW/CTNE6pR6cBjw2oRYdw9S0n27Kny77
X-Gm-Gg: AYBFou3PJtXTP4f0vEIiPShF6UQRUI/AC91PytR+pWs6IcgM+UGHEkl8nnMXeTrgSVp
 jthlUDHIs1oYjZkkEfFiJSRSe2gS/j98+mb8Fmz/CF5HpswdxUfaDo75lEEF1OGaIazM7mjo2gB
 iIEoAs3J7+ovE45JuhcfRNfUPn+K+3CkA/Zq5qwHEhWHHzr8qJuMIpvLlHs0/+ZuT/0mRnRXCpF
 7Y/wQMSGb5C9FDW5yUPOM1r7/MEsuGwNGXMH3mpmsVcf4cy2PTR6MhQha9XhyuaWlyoCI88NlN+
 eGBrprB+Opk2cKFGJMUqq4pMhRTn5SjbZCtoZGVZY12wPWS+FpofLgQzZE9luCpZ0pjkLITuSPb
 x2l0gNoFTEBaIOzymMksfUPtSG3OeG69pSAi+MZY0UpKRWRY+aYytkthpqOQ0uw/pYiMoaF0iYS
 4J52lAxkYgPmUrukW5e8qUIOv+muoca8+sYN848tUQu86YbXvUgVUEFk80WfmYSF0GVmpANX4Lp
 +Mz9LOfUfmRTlzldGcgLZHUhNg9VPmRitsehOxKMbwac7wzLRUY5SWvXUGeskbgt8Q30GOi2vRd
 fODbbNmOtlHwMPtuKtDxNTsXoUN0wHYcdbvJGUc0tB0kTxhVchGqNvYC66Cj6s2WcLEffuR5J99
 72/pYJhVpTnARfwocXULB4Kd7srWrWW0QJ/tQtS7uGaERt1VIg4YKzn+rr+ig9M3Uom0335O9d8
 sSmlDrIS7p
X-Received: by 2002:a17:90b:3e83:b0:3ab:c370:3684 with SMTP id
 98e67ed59e1d1-3ae89767179mr3974527a91.30.1793449646212; 
 Sat, 31 Oct 2026 05:27:26 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm7553863a91.3.2026.10.31.05.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:27:25 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Yixun Lan <dlan@kernel.org>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: Tom Rini <trini@konsulko.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Guodong Xu <docular.xu@gmail.com>, u-boot-spacemit@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH] spacemit: k1: drop the CS1 DRAM map on single-rank boards
Date: Sat, 31 Oct 2026 20:27:21 +0800
Message-ID: <20261031122721.3240434-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DDR firmware marks the CS1 address map valid even when it trained
one chip select, and dram_init() adds up every valid map. A 4 GiB
Milk-V Jupiter (cs_num 1 in its EEPROM) is reported as 8 GiB, so
U-Boot reserves memory past the end of DRAM and passes 8 GiB to Linux.

Clear the CS1 map valid bit after DDR init when the EEPROM says there
is one chip select, which matches what the vendor U-Boot does by only
counting CS1 when ddr_cs_num > 1.

Fixes: 3691fbccfc89 ("riscv: spacemit: k1: probe dram size during boot phase.")
Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
This depends on "spacemit: k1: initialise the EEPROM index in
read_ddr_info()" [1]; without it the EEPROM read can fail, cs_num stays
at the default of 2 and this change does nothing.

Tested on a 4 GiB Milk-V Jupiter booting from SD: the SPL reads
cs_num=1, U-Boot reports "DRAM: 4 GiB" and the second bank is
0x100000000 + 2 GiB (it was 6 GiB).

[1] https://lore.kernel.org/u-boot/20261027154347.1392094-3-alan.tseng.cs@gmail.com/

 board/spacemit/k1/spl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index cc0e26bb0..3e8439a71 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -56,6 +56,7 @@
 #define DDR_DEFAULT_DATA_RATE   2400
 
 #define MAGIC_NUM		0xaa55aa55
+#define DDR_CS1_MAP		((void __iomem *)0xc0000208)
 
 typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
@@ -406,6 +407,12 @@ void ddr_early_init(void)
 #else
 	ddr_init(0xc0000000, cfg.cs_num, cfg.data_rate, NULL);
 #endif
+	/*
+	 * The DDR firmware leaves the CS1 map valid on single-rank boards too,
+	 * and dram_init() adds up every valid map.
+	 */
+	if (cfg.cs_num == 1)
+		clrbits_le32(DDR_CS1_MAP, BIT(0));
 	writel(MAGIC_NUM, (void __iomem *)0x00000000);
 	flush_dcache_range(0, 64);
 	invalidate_dcache_range(0, 64);
-- 
2.43.0

