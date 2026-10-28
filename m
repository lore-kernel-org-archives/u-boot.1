Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A65606A323
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bSN3iOyD
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FA4E60790;
	Wed, 28 Oct 2026 07:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZcRZNI5Q-sd; Wed, 28 Oct 2026 07:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89486606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793170970;
	b=Z9QRJWePYYkR1iCI4TXY2Tyd5jsy6Gs+4wWwpFfl1uTKpgxCreSdtbYfnUgqN3UQAbUF
	 Dh9qhBYOJ00RG4a9mOfrTCoLiUIDbXBUXp8uYj2Zn+r5qb9l/DzPyAs8FJQ2prfzGG5vD
	 c79Cm3HZ9mTRjcUIhJwoDlaoGYtlHGb0DeSClja1/QVXBIIXZpra48Mk2iQumhCGkGAWC
	 Ji/+efGXuwK9EBrJpePqVPaZunahLnyOG7TwBflTy9O1TgteetRdrGEdhPrOejkIUIB47
	 us96YJ2iRVXP/+EEftpTBVbTU/v/jZvBABfevLmnerhxOd/kjXBpfTOXw+GGGvsZ5Eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793170970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e30CGAV5AuzPOYfBnOB+ipDK9TGAkHLCBGNQTwXLLPw=;
	b=IEAP+Q6TDHn9tanBLLrBLjp688jiAao7XS9O1bIewV4qZWGcS8t0IoyOhBmayU9xpTxg
	 faM3RICgLRuvKphuwmbeGBPuFVStnpiMPGKHUP4fnQ7GeWccoMh97g5rPWGlF/Sjclxvl
	 EvaZDQ0xHj6k0GGru6USiM/jf6Cc5aKMtiaMEOkFpiMsZaUi+AeII++ZeRjUr93seRY/p
	 CTk58tiC6zhLNovrPoA2EpEJg20HvcE0gnj9EkYtJwC8oFR8yNXl71s3ftumJ01OsCSEk
	 2Fcv5ODwXhxG/YKZbICrTDhyAFGKH0Ti2N2oeHcTS34sDUAxHWZhibMrZ2qWOCxZipA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793170970;
	bh=e30CGAV5AuzPOYfBnOB+ipDK9TGAkHLCBGNQTwXLLPw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bSN3iOyDt4kbn33UH0SRsOSAmv+o2VqysAq6+5vn/y9M2nmFF72/b84T8CjTfc6af
	 hc6kjuSRV6YaAJfoSoOSeig5wtWHqzfUP9tdsLJCBl3zNS4EIQV6/FaisolDVreYq4
	 EBh7px0/tLU0rWTrp18NFJPt427lzzwi5stXpfGRMWFrJ2N22VBmQvYuaCSjd16PXT
	 kGgfwU8TMXOGCUpK8I6NJue//QYuFy5xKn9N4vpMyhfK/w+5gEHNHq6pNftKGvS4EW
	 IdtOPW4YP6DeyE36ZxgcwRKOg9FqAMsAdQxE2xtaVOU3yMKxeFWvTy4uuy5YOitmYA
	 Gx7e2iRaxrwtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89486606E1;
	Wed, 28 Oct 2026 07:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F25E79C6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E15834058A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zi3NoKEfu69L for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9A77D4059E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=220.128.198.184
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793170966;
 b=Z38VP/K4iocm5H98cEEChicfyrL7U2PbHa0mkizQ4xrR0h4x5hMg5L7A9l+ScjyP0P1h
 +07dHe+AOV6tbOuEB8xWSPgJr2fhT9wb9frY2/ZrepIRtHisXxyvClHVLF+x38vmn3HOO
 RX4GC71fPRy0CymwP6LlyZ1m7rEvlqx4QDXWpCTJHgFRzclVrYhcfvteawn2cbRRcDp2d
 umns1uZ1g0l6q64ZpnFnsGnU/LQhE9W9RIY8x67mEg4SThqWWMkxKoagpLE1GiNBMiWBz
 zTd4c4XcZZFm+66n7/GpqAj3UeOk5cmlwbe0zZXTvhOqEbgDcYhPtcD6bNKeoqpLWuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793170966;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=e30CGAV5AuzPOYfBnOB+ipDK9TGAkHLCBGNQTwXLLPw=;
 b=cDJzhsVOoWgV2MVaU7j5zA3fHtC/EqaQZ0otUyWAEB1aEUU1uCp0PcDDTHdNBzpREQA7
 xE8x3hlGFlXCaBwaau8WZ80SlkuL1OGqk8LiQ/P1oasUmvFMMZQjrU+OHtSZ/KmmIqfxj
 wdu+hNU70+hxw4K3s2rQXck4RSIil7oDRb3JrkysP7YRfbaPuOZtGFmR3tp9Na+Le2skl
 kP5j6QdIEGf6luzb9STyu4a9ST/zc7gO1cWnE/D1Y/WvDqB+T2/X6k8cZ355qAlt27lg0
 cd/d7z/AB6+Omd/jHJEGqjENCBuc9KFRemcLsFdri+jWxre2ttPe7Q/0t2lD9N/BQAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=andestech.com;
 arc=none smtp.remote-ip=220.128.198.184
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=randolph@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A77D4059E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:46 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 69S6iBZp035107
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:44:11 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 69S6hcUd034822
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2026 14:43:38 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Wed, 28 Oct
 2026 14:43:38 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Oct
 2026 14:43:38 +0800
From: Randolph Lin <randolph@andestech.com>
To: <u-boot@lists.u-boot-project.org>, Leo Liang <leo.liang@sifive.com>, "Tom
 Rini" <trini@konsulko.com>
CC: Randolph Lin <randolph.sklin@gmail.com>, Tim Ouyang <tim609@andestech.com>,
 Randolph Lin <randolph@andestech.com>
Subject: [PATCH 4/4] riscv: andes: probe the L2 cache device in U-Boot proper
Date: Wed, 28 Oct 2026 14:43:29 +0800
Message-ID: <20261028064329.1986824-5-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028064329.1986824-1-randolph@andestech.com>
References: <20261028064329.1986824-1-randolph@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69S6iBZp035107
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In U-Boot proper, enable_caches() runs from initr_caches(), before
initr_dm() sets up driver model again, so it cannot find the L2 cache
device and flush_dcache_all() never reaches L2. Without the I/O
coherence port (IOCP), DMA masters do not snoop the CPU caches and
can then read stale data from memory.

Call enable_caches() again from an EVT_DM_POST_INIT_R spy, unless
SYS_DCACHE_OFF is set. In S-mode, U-Boot proper then drives the L2
controller itself, as the Linux ax45mp_cache driver does, and
"dcache off" and "dcache on" turn L2 off and on. In M-mode U-Boot
proper, L2 is now enabled, as enable_caches() intends.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/cpu/andes/cache.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/cpu/andes/cache.c b/arch/riscv/cpu/andes/cache.c
index 30d766da8f9..9a1ca950e11 100644
--- a/arch/riscv/cpu/andes/cache.c
+++ b/arch/riscv/cpu/andes/cache.c
@@ -10,6 +10,7 @@
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/uclass-internal.h>
+#include <event.h>
 #include <asm/arch-andes/csr.h>
 
 #ifdef CONFIG_ANDES_L2_CACHE
@@ -30,6 +31,20 @@ void enable_caches(void)
 	}
 }
 
+/*
+ * In U-Boot proper, enable_caches() runs before driver model is set up
+ * again after relocation and cannot find the L2 cache device. Run it
+ * again once driver model is ready.
+ */
+static int andes_l2_init_r(void)
+{
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		enable_caches();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_R, andes_l2_init_r);
+
 static void cache_ops(int (*ops)(struct udevice *dev))
 {
 	struct udevice *dev = NULL;
-- 
2.34.1

