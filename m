Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E651C606A31D
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qWR2KFG+;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=jSy+/Esf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E0A180E22;
	Fri, 30 Oct 2026 09:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jaPz6Pz0qxjX; Fri, 30 Oct 2026 09:03:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDCFE80F47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793351035;
	b=o49o+Ibu0ZyN4LXItDWPcPaTx9jz/qh9lvQk3PWNrGxxcYx29haOEatd39GolpRYhcq4
	 HhQ8LZiyFiwdc1SIZHtfUAB9s+p1tIbp9UCgM8Jp3cprUd76qNXsvpW4Hw5NiosWtTFNs
	 MIQDocE0XTEIxy6PGhIeabT8RFTtCjhULqy9u0wVQordyFEs1XxqddcNdXX/3/KIpps4h
	 rlboC3qRRy+CPSz9VCIAI9G8UYJqxmyhPC9hPO8R8mBHdQYg662BqKTvt319ADYlFaqrS
	 4OlKNgmvyGXrQ9fZtxUz+ydNvXEXY3HN9OkFMQZlq8HGOmnvvuyEzhmcS5KEmSMjkYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793351035;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LLLnqR56FtyrMamTGhHUbCCpvuMjRF5D1kErFkOqE1Q=;
	b=HczWQVv3EoTRpTVaXAFlFzvLrHxLd30la9lUh72ATqX3vewuynV668nfGKRpZhg8diUk
	 2mwM7Dtr97nNVtjcNtA4QUkCCRLz09alChawY7UhgNvXkg4K8mkOh4e34bXy6P44mDFpy
	 0TVwMFh78YEL5B30W3msH8uwILvL1miqJOB9idXa78+iApdAlQJc2e8sZRzRTWbxIeVFi
	 scZh/M0LH084f8L3gUs+rOMne66s3ThfCz73vtrU/BeEsuCUPqNblL1qP/FU+eFYUZBqo
	 VVnD7aGSmJpIQ9pmvIYkDs3KDEVUbVF6Tak9dWTwZpv6sPHYD6zdiyqnUgdzLlmdBGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793351035;
	bh=LLLnqR56FtyrMamTGhHUbCCpvuMjRF5D1kErFkOqE1Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qWR2KFG+/6/nL9SfsHBVTV0Y65ElW0ZPsmTf93f0UYWAFuh3kQs7V2qi0mrHWFBjA
	 Qxfjya2jqGXqpsHgPkiGxiUNatKPAEtuA7DVAmbOugpA5bGboJ5V5rl60HIN544noL
	 vl1FMmP08SaRsU06IH9kPgKdXpE6fX69/cWoTTadchk45LoH+ZdQ6kW8YgEDGxZai/
	 v+HN6BKDq4kktZbLEWlajGzEBgZlwp7QNLQMn/Br8RlSq43+/KaCMH2Wv8RXx9DWWz
	 Sw04LAbt1qOv3Sjsda3rqERnWzUqaYTHc4mdLcKLcQI2EJy05XGfp4u67KBVRMt1cX
	 7np95M9gUh3qQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDCFE80F47;
	Fri, 30 Oct 2026 09:03:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC7831DE
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9A7D4057C
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oAjRA9lWxVtt for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6740F40417
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793351028;
 b=NluAnjlzACtSQSbZGhYpVAjdfAW4m2N1sJwfM7HCNSdw/sWOAbBpMoiSQ/0FNQlV7GL+
 eKB5uusGCyDeIwWZMq5PJSUYWgPM+Zcr2oMgsumHoO7cSfIeSwOPwPXLD/6k9OsDRTT/x
 UJzdrb3TOxyel5T52N9RkS7vwHzwGSSLy54LMryurX8J2BeMbqFv8ZP7oLu3chy13U5NA
 oc072UdPRRFHewhYWGdUbH4Z7btdIvXnjoIGwCuYP82LMunXnb1TBsltIrAHbwTD2Nt+n
 qgvTK8PFkcX6ov1F/8JBIJN6wZSmJF3RQjLNDP5Onn/NC5NFTGFfELo4FMuxZumyAbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793351028;
 h=Received-SPF:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Rspamd-Queue-Id;
 bh=LLLnqR56FtyrMamTGhHUbCCpvuMjRF5D1kErFkOqE1Q=;
 b=gH9Rl/NcbBW4CmQc+/4FCpodB/NpAAXt27sc92haL6j2JeK96PDPCzKlonxvs6cd70Ed
 CBIn0G/ORWJn0VKegKkQdkb6uPFbcgmQBCKJ5FG2YpW+BdVAa8LhXF9sHwJbwVSO9u87m
 2W0+EeeIfZlZpj9hH/e3afHPZqCPWHKv1XHLHZfzirkrmYXF1EJGXCPuEwUSNO/4Wkzlc
 AlmiAHNJ30E//p2X5i9/PwyPlVa56iC9AF9lWRW0Y7XHOKxObnbpbSEQEd2z58AMkQ5U4
 6d7tSXzDSWUaVM05Ht94bRIdQOBJKf/J2oRGrt8y+lrWbl5+e3Ag/lFVB/dqQn/9VYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=steffen.cc;
 dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b="jSy+/Esf"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=jSy+/Esf
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6740F40417
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:03:46 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jGFPK43byzKm54;
 Fri, 30 Oct 2026 09:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1793350693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLLnqR56FtyrMamTGhHUbCCpvuMjRF5D1kErFkOqE1Q=;
 b=jSy+/EsfXmN7cjJxwSTgmCbibK6QTbB9DI9RvPqJnqFOclh0/FbxY40GYnsKgPuEHqrNi4
 8jTFYGdhtcsyNB3EzYc0ysCXzeYGIWJ41v/MfIsLj9jXuBZOeZQtgZtf4ttdV7RzBRLKPR
 orx6aH9YilBdJgPQBOVg7+9ZvSecbWVFVKIgMGP/hdnLWHSXOVUhzKaZXEoMlHvRA2Ze/4
 cHS1OnJCEPYJCtfTTpogKg9rn+lJmytt42FdG6PJm5SVPLYS7ydz2mpmCfnJ7vMUwLMk6i
 fHZn53WScz7CuQDZc/OQdyjxIfQXeyrV1RpV0IUElU0DjP1kk62Qp8+gzNTNgw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Fri, 30 Oct 2026 09:57:41 +0100
Subject: [PATCH 1/2] arm: mediatek: mt8188: enable the caches in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-std-upstream-mt8188-spl-caches-v1-1-b45905cb19c1@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793350690; l=2069;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=1KtkrBIN1UviJWgq7x7t48hWB1Ll9eWQhcx+zbiD2Ug=;
 b=oq6ELV864T89yqTjyxc8JYvVNeS6kuozx/dOwVCf290KsvqN+ko+OnPkHGoT+cqOVWMJA7m1z
 VlUe8+y7wsuBxY3cj4LszGegjyIMQOQ+MR6ZmJu8bcMXan7EnE9geOW
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jGFPK43byzKm54
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

Running through spl without the dcache is very slow, especially when
hashing or checking signatures.

Time from the SPL banner to entering BL31 on an MT8370 module loading a
2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:

  FIT                    caches off            caches on
  unsigned               864.0 / 864.3 ms      95.8 / 95.8 ms
  RSA-3072 signature     1903.3 / 1903.8 ms    142.0 / 142.0 ms

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 14 ++++++++++++++
 arch/arm/mach-mediatek/spl.c         |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index b2cdec8c2189..2e6aa041c38f 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -6,6 +6,7 @@
  *         Chris-QJ Chen <chris-qj.chen@mediatek.com>
  */
 
+#include <cpu_func.h>
 #include <asm/global_data.h>
 #include <asm/system.h>
 #include <dm/uclass.h>
@@ -47,3 +48,16 @@ int print_cpuinfo(void)
 	printf("CPU:   MediaTek MT8188\n");
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
+/* Early page tables, in DRAM unused by SPL and by U-Boot before relocation */
+#define MT8188_EARLY_TLB_ADDR	0x4e000000
+
+/* Initialize the MMU and activate the data cache in SPL */
+void mtk_spl_enable_caches(void)
+{
+	gd->arch.tlb_addr = MT8188_EARLY_TLB_ADDR;
+	gd->arch.tlb_size = PGTABLE_SIZE;
+	dcache_enable();
+}
+#endif
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 125ebcd784fe..8073101e3ef6 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -14,10 +14,17 @@ __weak int mtk_soc_early_init(void)
 	return 0;
 }
 
+__weak void mtk_spl_enable_caches(void)
+{
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 
+	/* enable caches early */
+	mtk_spl_enable_caches();
+
 	ret = spl_early_init();
 	if (ret)
 		hang();

-- 
2.56.0

