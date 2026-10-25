Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5B606A31A
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 04:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZrJRPNgZ;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NFfF3JRc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 581EE40672;
	Sun, 25 Oct 2026 04:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rEr6dIJLpGqb; Sun, 25 Oct 2026 04:47:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75FD44066A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792903641;
	b=gDSYnlreEx0N1hGUE3qn6SJSA2gnk/NrZRB80syA6H1amFKiBD4d/Jy213Gvz4HnVCnp
	 FwttQ6IyAHJ9tjlAoYNq5j3aQymHVPcBeMDnZaQNu3UiX0/96JA65hTvrWUBNJDnegExS
	 /7ZclZXwSAY3g9+xOEWJ10Ei7W3LOHxK2D+tZ+VQ1Vzs7QnMinR53WjIdlskq0McSIFZp
	 YCiQqB9OhxosYLzucUn2YtDTunJjwR282BgHWxGY7zJJ175T5Epk0939/SvJ/gcKoDH/H
	 VoqSj92mzQlkSyjIGPdYu7TRCGve37qzRFLt58Wts24+8hJqbFDf2VuicW8OUP/7naQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792903641;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ofJiY/jDz9ukl5cecoJz8SyZGgzCS7TwD5Z7NPvMdyw=;
	b=RoWFoGGGaCbeIYL1V27mLyidh99kvL4DOC8aNHzJPIYMshfo3w3VYqJD9fvzyzkY4r1b
	 7ZD2KOy8hxAbAjDNrLJY9aOICSUZqwSwraV92vsSvwTceftgiSs+fQ1jNIfMphlm0qmmn
	 6TId2Zd4nb3NGF/sylIJr7tI9FJSCjgddgI9hvqBZ2UAer8gfH+Jd1FVDlAvEUlb/bTjY
	 ZPv0iOXfa6v2HNR637Z6TIadlSyuznfWNHezzeCZVWJczJu1HKM/1fuGgI0dEi6phC6dJ
	 w1sTdN5hqBfBssQ3H4JlHkneHnFpjEdJRgGDDcR7flfTllVfQ0cHgCExMdk1Q1zuCrw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792903641;
	bh=ofJiY/jDz9ukl5cecoJz8SyZGgzCS7TwD5Z7NPvMdyw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZrJRPNgZvY0U6HqqnBtN/p4GkTc0xcahN5kwmfy4lJqgxQOGz1xL+hl0REUTDhroA
	 iBlj3YdFsCYBO3yQxnoDNdPVmCzf/fo5va7TDP8RKytisxR5QfiKTqgcyRgqI1LZpZ
	 BHI52cXxbWLyAmNS/Zuene743UgSDQfOgBgdNL8B5rso7uc0/L+3DDuOGB1iOaraFh
	 DotXx57CuGWsm61jTiEa8JxqiR0Xw8w5u1idW1MmrV4FrcUP2KMdWmZ1ANwUfodyCs
	 Bwfj/BOU9/YDYC+oc0EeUekfSZtAL5u3m5ny2B0TAa45K8vIooh0yjn+8O6F0Lkk7l
	 A51XtpVVX0Obw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75FD44066A;
	Sun, 25 Oct 2026 04:47:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 47EE72F5
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E52780DB3
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id huA8yVBnhWjN for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 02:00:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5819A80E2B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792893623;
 b=EbpoDH6PrZ0Xxr+Twso00iv85kZMMAb+XagX6GKvRd37SkNzUobrZLpKC6JC6Vs1iw6m
 Pt1UnYx/IXf5HzRRkL0YFOsOrOFXJX05ikhOvB5uqPbnNCF1yEpI5zH7/D+ye3RMLECys
 PRzLstDv2alHLLzTjyjXj8lgD3DcetSueZ8qh3rE4upncByGSa+LwwofQvfNfYAQtROia
 35PsnZvmCdmJ5GduZfOk9A0DauxuKr+SqHZ8LT1/0mJuG290+quMKBddrVzeH2qg9/ch9
 Y6TXshXExlwxMNjfjbQtnjveH0xveNcqBjoWWgHiwwErVcH13+NMSMGbaRNdFXomS7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792893623;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ofJiY/jDz9ukl5cecoJz8SyZGgzCS7TwD5Z7NPvMdyw=;
 b=saHYZgrgaVozKApvW0LOW/VNeShy1FQA8DFHb7zZOeLCrkRkW0XRbPBMTmTLz2mpd9Sw
 2jZYnlfi/UwS8bTDJ/Y1UNXo2UCD+yWkNfzIe8kmwavLWnWXafRTBM+6r4/i81ULEa9xL
 cLT16R7SRnJEJO9B6BX/WLoJE+ySUylcMfvFcvGNdIoOYDOEiZfyTAFMPxP52IbzpjP5r
 XCmquWwp8M5sn7ZEIXz1xUc4tg+pjV12kNgYDaoBQE3Q7QJuTEz3+kCCJOHCUMyUgLmhN
 /huBaUOEMeXKLTnd5BZYCzVs4BBxORoN/O5engFKCQN059E+9xOEFMVOvjURRyXH9Yg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NFfF3JRc; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e2f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NFfF3JRc
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5819A80E2B
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 02:00:21 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-7ccae9f1a9eso1195719137.1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792893620; x=1793498420;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ofJiY/jDz9ukl5cecoJz8SyZGgzCS7TwD5Z7NPvMdyw=;
 b=NFfF3JRcSO6ivgSYRTsiFZ5K2QG9sL9sTVhOkSyt/ns8hWQScEWawCZKVOisirWcAi
 9h40OM3pvwOJcix0FR9z6Z9/4Q1kcQES/0UY3xfJgXGUXtD1JMM9K5ZfOWpTSHz/JYqC
 5LmOODuO661tpy6sEiRAFKsdoP5vUU6spob14cHNKS0fBXuwancwyyq5DjSCJgTEftOz
 CZhK1nLRMSxeBOVISvacwcASzDE/8uEDC96c2LJttuF+ltP5WB4psy7ozy8YWp+VnSOQ
 9o5LiDgtX7SXSLBlIAnQbdMhe5qgEq8ktf8p/0a+whj296vynAjdb8x8lRX9pdRhkZjL
 AT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792893620; x=1793498420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ofJiY/jDz9ukl5cecoJz8SyZGgzCS7TwD5Z7NPvMdyw=;
 b=wt0bbUUVq8uIPprUGq+TaCgdZ9K/6SNU1aDq1W/ih0qPsGf8i3yv9MaEn/hXY8e7zK
 qz8anCKCkHsn1nK5Iy81jYeQM4/dYok0hzsCFd/ntHVNQ8CelSwru9CGaLckOIjARHGy
 oQUwhVxgOT9W9tRTej4M4IZ2PTSubgI533hQXhtwtY5tC61yK30CRpMiA8tatTE00iG3
 OzS7pvnz/M/U2JDYyMaNjMhIN/y8NTQcypDTka8z0WzvgwoGUhQ/emw1k6mos3Xj/t0f
 GUnBFqCHlwn4y5FAhxHSvDRImH+TH1Cf2CMNVR8XxOx/hDk10+PoneiHH6+S/z2FkHXZ
 +mqA==
X-Gm-Message-State: AFq9FYIT3Af0Tzn3RKJ0DFplykCUsr/V8VBeJ3UitLWfopFgrJugJ4HI
 JvK6WXX36ggaN+xf52pGEGtZfZ+KsJOrE3rPfM7yFN+TvOC7meeavHT7quLkGqhH
X-Gm-Gg: AYBFou0ZTgJ1ArDB7WzFCh/qBhzBvsfFzgnzfOwyQIuTjL80h3HqNerLCyJdk0YbC8p
 StW3OuUeSRT9+yZOcbN/zfkhp7T+33CZmBHGcwQ+gzMNITGtMUGmneMsy3RLxrArJqyVed3O2aO
 r27X8291gVP9jR9WxRO777gw5Mn9cwFqlikbF4hpt1Z8Sanr1+p2I84WjXW2IEM2u0sjx7RRoji
 FlMcJd0th6fGWaFuJkIuKK5kE0a69has8fQJjG97J4gKpgV4daMEiwFYUDO7T+jZhRWA6L4npBc
 8hF0NVuzWE2IMMgatA57NhtCnBTUva1xcqwSWbU3kK9F7rilmbWk7mouxjNSujOcEgMAXWxkEvk
 y6YNay/S1bC/vn/oNsPcZM1gvFSyRY0TaW3A2DjrBCXrWZSITtNM4cpQltwKbfhgCQZUjbnSTyC
 qzy32MoV57/k6UL7/pOF+NJjyRRj04hn8G32Brh3TwI6R6mEDYU0dHYg/s43/u1FLg8PcfLy2EA
 ft2/dgpl8P+qnvvN2MX/zlVsiRfRWNsNi5Qw6HQmyy+TJMbnHVR7cABN5IbUpjMi44bONPN7Z4N
 Gpc8GKLJ0iUmW/Gl6B09T92kHFI=
X-Received: by 2002:a05:6102:3fa1:b0:7cc:3eb0:6ece with SMTP id
 ada2fe7eead31-7ce5cdb3455mr951899137.33.1792893620583; 
 Sat, 24 Oct 2026 19:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2804:1eb0:a0:15ff:76c:632f:8ae8:6a5c])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ce5e2baf56sm3485070137.11.2026.10.24.19.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 19:00:19 -0700 (PDT)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 1/6] armv7: ls102xa: Apply erratum A-008850 on all LS1021A
 boards
Date: Sat, 24 Oct 2026 23:00:07 -0300
Message-ID: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 25 Oct 2026 04:47:19 +0000
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

Commit f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
made SYS_FSL_ERRATUM_A008850 depend on SYS_FSL_DDR, since soc.c includes
fsl_ddr_sdram.h for the DDR_EOR bits and that header needs
CONFIG_CHIP_SELECTS_PER_CTRL. The ls1021aiot and ls1021atwr boards set
up the DDR controller in ddrmc_init() and do not select SYS_FSL_DDR, so
the workaround is silently compiled out there, even though both boards
still call erratum_a008850_post() from dram_init().

Move the two DDR_EOR bits next to struct ccsr_ddr in fsl_immap.h, drop
the fsl_ddr_sdram.h include from soc.c and select the erratum again for
all LS1021A boards.

Fixes: f9147d636ce2 ("Convert CONFIG_CHIP_SELECTS_PER_CTRL to Kconfig")
Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alison Wang <alison.wang@nxp.com>
---
 arch/arm/cpu/armv7/ls102xa/Kconfig | 2 +-
 arch/arm/cpu/armv7/ls102xa/soc.c   | 3 ---
 include/fsl_ddr_sdram.h            | 4 ----
 include/fsl_immap.h                | 4 ++++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv7/ls102xa/Kconfig b/arch/arm/cpu/armv7/ls102xa/Kconfig
index 9ce94555ed0..70170e735be 100644
--- a/arch/arm/cpu/armv7/ls102xa/Kconfig
+++ b/arch/arm/cpu/armv7/ls102xa/Kconfig
@@ -9,7 +9,7 @@ config ARCH_LS1021A
 	select SYS_FSL_IFC_BE
 	select SYS_FSL_ERRATUM_A008378
 	select SYS_FSL_ERRATUM_A008407
-	select SYS_FSL_ERRATUM_A008850 if SYS_FSL_DDR
+	select SYS_FSL_ERRATUM_A008850
 	select SYS_FSL_ERRATUM_A008997 if USB
 	select SYS_FSL_ERRATUM_A009008 if USB
 	select SYS_FSL_ERRATUM_A009663
diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c b/arch/arm/cpu/armv7/ls102xa/soc.c
index 7ff59edd452..60f63da73f8 100644
--- a/arch/arm/cpu/armv7/ls102xa/soc.c
+++ b/arch/arm/cpu/armv7/ls102xa/soc.c
@@ -12,9 +12,6 @@
 #include <asm/arch/ls102xa_soc.h>
 #include <asm/arch/ls102xa_stream_id.h>
 #include <fsl_csu.h>
-#ifdef CONFIG_SYS_FSL_ERRATUM_A008850
-#include <fsl_ddr_sdram.h>
-#endif
 
 struct liodn_id_table sec_liodn_tbl[] = {
 	SET_SEC_JR_LIODN_ENTRY(0, 0x10, 0x10),
diff --git a/include/fsl_ddr_sdram.h b/include/fsl_ddr_sdram.h
index 182f5836533..650bfc29b49 100644
--- a/include/fsl_ddr_sdram.h
+++ b/include/fsl_ddr_sdram.h
@@ -146,10 +146,6 @@ typedef struct ddr4_spd_eeprom_s generic_spd_eeprom_t;
 #define WR_DATA_DELAY_SHIFT	10
 #endif
 
-/* DDR_EOR register */
-#define DDR_EOR_RD_REOD_DIS	0x07000000
-#define DDR_EOR_WD_REOD_DIS	0x00100000
-
 /* DDR_MD_CNTL */
 #define MD_CNTL_MD_EN		0x80000000
 #define MD_CNTL_CS_SEL_CS0	0x00000000
diff --git a/include/fsl_immap.h b/include/fsl_immap.h
index 54d6e0ab377..759a484a926 100644
--- a/include/fsl_immap.h
+++ b/include/fsl_immap.h
@@ -136,6 +136,10 @@ struct ccsr_ddr {
 	u32     debug[64];		/* debug_1 to debug_64 */
 };
 
+/* DDR_EOR register */
+#define DDR_EOR_RD_REOD_DIS	0x07000000
+#define DDR_EOR_WD_REOD_DIS	0x00100000
+
 #ifdef CONFIG_SYS_FSL_HAS_CCI400
 #define CCI400_CTRLORD_TERM_BARRIER	0x00000008
 #define CCI400_CTRLORD_EN_BARRIER	0
-- 
2.43.0

