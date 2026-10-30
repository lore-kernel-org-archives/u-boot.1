Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945B9606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HksSsxAx;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=nom99xB9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28CEC60AA1;
	Fri, 30 Oct 2026 09:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VefG6dYvir8w; Fri, 30 Oct 2026 09:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1EBD2606A7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793351109;
	b=p4mFIWMzcqMfUnlkZhXqGRj+mL99EcLMsyjyQlAx/sZFaRdhl/+3CdZWcdz10vRRHlOK
	 ajKDWrmW0pyc1TBaiyo0Nax/oDP4Jvhqw4wjvIKWVduhggQGskQWLwzA0asbGXRooKIol
	 NAkpHFfu3KZGDwfbfLhWw0ytR4Up3f3CVqcxeOpA8mFyjal9X6NwgedFExxADXo+u3GIo
	 9XWF+aef3nPCoyth/QbzR8jgBE/QrpoYfjW3SIDQFWxxv/RzTLM5rkL/NuFVX+URBsVe0
	 RRb/Q+KKdPBDkUHdd8PanH1O3qUNYvHI55YFucHCwGVoLkGXMZx25s9To3ISO5fnPAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793351109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f1N2g7PUwYTrMypWXU0gvn5NeqHFcLgM4FpfKr6pmiE=;
	b=gW0NNFvE4sjUY2K4IwbaqYpig5lyzhLVZ2SHMJdYNeK5T9RN+d+TLvmqO01adnd90AaN
	 1DIH96BMFBkjV2WcHPqv3k7MyVCN51XK5YQ7goIOKJ9zHT7cOZNhCGgCUgU0YKmEnFC+G
	 0jPOdDH/yfZdbgwUMPoNzh1jsIFEPK8OQUuEY3jgeUHvp9plldQuAEDy1zTJwEA61FifM
	 Y1lck9FHCuT1EoYMHkzC7B3jZELJovjMmTxGR9zU5cWb+ydwAF2e4vY+gNTCcGVhGjmgR
	 +VNx3RD69iAuHbSMRxEXyCYGc9eWs5ro1MbbCd8yUF6ohI2VhKMGe3vCmWBw5+OcHKQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793351109;
	bh=f1N2g7PUwYTrMypWXU0gvn5NeqHFcLgM4FpfKr6pmiE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HksSsxAxQol4BdkW1+b/8EnqoTBlAK53Y/7aWsoTntR/anjdzCUwOnwE97kkzHhuC
	 mSHVkSEJo81Qe/QYgSAa2Ppw2lVrhAoHcvFYRrAF0syVFUEl+AAKPpgv83Mun/ATIe
	 xxcud2/CytRYL25EHR9lrgeOn1Hs4aHQrHoBMd8xl9WRTnN5o+XCQ/T19EUqPXIFCp
	 DG+9czEKZ1FfD+QsVfFO60LGBdxJppC3SxIyv5v3mkpapEUaXfqLcMm7ejeTHlfptu
	 l9XSh3UdPSz4dxjrcH808IIPZ+zOeSHzxI0cx/9ucalH0u5Nkskg2PvYakUq4SGRDf
	 FQawG/KqMQ/qA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EBD2606A7;
	Fri, 30 Oct 2026 09:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEE661DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C44C64016D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GkHsPJ-Fy0dP for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A580D4010C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793351107;
 b=KWJiwbImHEjBNpw4GdPWoax1l+7yybQsyhkVfoGj3LrVXOyL1AHytNq3GTbesfjyKfOY
 WaQk0DlYperq4QiCK15VeebduiJ778mYGd0VWHnIpsdKp0x2blzi8MIU6g8ZTOx0xO8Tt
 7ItzJdS8+MgkODtyd+5QbNgKoNdrEuCdBegU1pds9DmC6IXk4a2hQKPDZc85bJd0ahDKe
 UAKGoAUqYmTRvC8y/j5w4RHbwj+PZ4RZ9vKdO3feJfffLXKBc7Inqllv0/ealR6xQoUkK
 ulArb4AXoUacj/C5AXY9VS+9yFs4iaq216nGSZ1KDUrZn7aVn44Gn1jZtyc6QcKdReQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793351107;
 h=Received-SPF:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Rspamd-Queue-Id;
 bh=f1N2g7PUwYTrMypWXU0gvn5NeqHFcLgM4FpfKr6pmiE=;
 b=qwkLw3vgetIjsfDBfy66EIDbPVEyYCCwjlxTIa9zAE9agRChXq7z1JWpVlTmz8g1AXTg
 RbdDg60z2liWF0YN/uH338LTcIwoqe/lAZXXH1Nghemoa1l5m6Wm9PNyfH2nMJu800AJZ
 JAfgtDWQejQOwQxwRo8raD3LoNWDQRDO2dqMsqaJwz6EzS4TL++rlRtKp2i1gmwaNdhon
 khabk47w7XhbmVD+1p+LESLFbBT7tu0PeZ9TKrUPXNjEBdes2miRRweX4kbi/4AjXNMdZ
 qJebD9FuljTNbSRJ8uvjBJ4jEFU16b8SOj/VnWpukOq8C4s47mgnQSww6LNSa8duhMA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=nom99xB9; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=nom99xB9
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A580D4010C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:05:06 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jGFPL2BBqzMldP;
 Fri, 30 Oct 2026 09:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793350694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1N2g7PUwYTrMypWXU0gvn5NeqHFcLgM4FpfKr6pmiE=;
 b=nom99xB97WmGWHw6zqVvB6Dzh5OrnD9KUL14JacrETlENEnoaNL2+mcjEE2s8eXW4mbo+c
 e0YZI4g8GCNhmZ5hfPntBVsexq+ZvwXAHaK2nltONx9xOxPubrXKKhJ6dTC+9e5l6cUgYO
 fNFf6lLfgzw9CJsamey1Rz1Kcpgif4skLMoarIUMBV0rt6C/9r39Hque2DmKyjgSBTsJ43
 Cjam3HFyQc+Im0BawzHgowL9MeFSbdJyESEahIx9PqROBPO/BL19PCQVIJW+saDMNugXDH
 RZez89MthJkFSeMfoXYPpRB6SLwwHu2wwm5DvN2cvF78l02YfpD2e49YV8ZEZA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Fri, 30 Oct 2026 09:57:42 +0100
Subject: [PATCH 2/2] arm: mediatek: mt8188: run board_init_f() with the
 caches on
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-std-upstream-mt8188-spl-caches-v1-2-b45905cb19c1@beckhoff.com>
References: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
In-Reply-To: <20261030-std-upstream-mt8188-spl-caches-v1-0-b45905cb19c1@beckhoff.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793350690; l=3303;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=hRLnuvOMmRGyy26gCMpNi+XirGGNzdWHWuFPTkaeGX4=;
 b=6TVnlEiZ+EiZydPnmgH4gtbMLp9+TNksain0qxSSTJV9wz6xM6oK/+X3MSwfpkdSbGt76S49i
 ElLc/32dKjcCh35pUsEhsVYZ+3WQ6okrko573oNf443w7dDoT/7TXZS
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jGFPL2BBqzMldP
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Device tree walks and other setup is very slow without caches, so turn
them on before relocation.

On an MT8370 module, from bootstage marks before each initcall, two
boots each:

  step                            caches off        caches on
  initf_dm                        349.8 / 349.7     4.6 / 4.6 ms
  serial_init                     204.7 / 204.7     3.0 / 3.0 ms
  dram_init                       162.2 / 162.1     2.3 / 2.3 ms
  relocate_code                   22.0 / 22.0       0.4 / 0.4 ms
  board_init_f() to main_loop()   819 / 819         87 / 87 ms

and from the serial console, after power-on (includes 5s debug usb wait):

  U-Boot banner                   7346 / 7346 ms    6772 / 6777 / 6765 ms

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 arch/arm/mach-mediatek/cpu.c         | 14 ++++++++++++++
 arch/arm/mach-mediatek/mt8188/init.c | 23 ++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 04ede8823b07..484a50f0a25c 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -7,10 +7,13 @@
 #include <dm.h>
 #include <init.h>
 #include <wdt.h>
+#include <asm/global_data.h>
 #include <dm/uclass-internal.h>
 #include <linux/arm-smccc.h>
 #include <linux/types.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 #define MTK_SIP_PLAT_BINFO ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
 					      ARM_SMCCC_OWNER_SIP, 0x529)
 
@@ -23,6 +26,17 @@ int arch_cpu_init(void)
 
 void enable_caches(void)
 {
+#if IS_ENABLED(CONFIG_TARGET_MT8188) && !IS_ENABLED(CONFIG_XPL_BUILD) && \
+	!CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+	/* Deactivate the data cache, enabled before relocation in mach_cpu_init() */
+	dcache_disable();
+	/*
+	 * Force the call of setup_all_pgtables() in mmu_setup() by clearing
+	 * tlb_fillptr, to use the page tables reserved by arch_reserve_mmu()
+	 */
+	gd->arch.tlb_fillptr = 0;
+#endif
+
 	/* Enable D-cache. I-cache is already enabled in start.S */
 	dcache_enable();
 }
diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index 2e6aa041c38f..139412071131 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -49,15 +49,32 @@ int print_cpuinfo(void)
 	return 0;
 }
 
-#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
 /* Early page tables, in DRAM unused by SPL and by U-Boot before relocation */
 #define MT8188_EARLY_TLB_ADDR	0x4e000000
 
-/* Initialize the MMU and activate the data cache in SPL */
-void mtk_spl_enable_caches(void)
+/*
+ * Initialize the MMU and activate the data cache in SPL and in the U-Boot
+ * pre-reloc stage. The MMU/TLB is updated in enable_caches() after relocation.
+ */
+static void mt8188_enable_early_caches(void)
 {
 	gd->arch.tlb_addr = MT8188_EARLY_TLB_ADDR;
 	gd->arch.tlb_size = PGTABLE_SIZE;
 	dcache_enable();
 }
+
+#if IS_ENABLED(CONFIG_XPL_BUILD)
+void mtk_spl_enable_caches(void)
+{
+	mt8188_enable_early_caches();
+}
+#else
+int mach_cpu_init(void)
+{
+	mt8188_enable_early_caches();
+
+	return 0;
+}
+#endif
 #endif

-- 
2.56.0

