Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0469606A33B
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ha3WNfFE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 960B280E79;
	Wed, 28 Oct 2026 07:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C_iFauCjEe73; Wed, 28 Oct 2026 07:02:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFF9480E4C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793170967;
	b=HOAk9rRc02EyVeZGv6bgY1klbLA7zF4T2dSt5CyriowzZ2CJ+Ract7czrR8DuJT58mUq
	 33PHZYzQ1q3/W/KAQ9rLjT8P6/JaModQZgjFPhHRgyAlmd8ACX9DCgZbhFzssMUv8nLSI
	 8r52SShHVovnZg+hZk80lZ+vCjAXozIC/wXRvvPEuqT2KRmR4tRRZnnb+X94+bBERHE3Y
	 wA39G2XVJavLjexDREL+ekzWCqBb0H52iAsK7SNCR4lJxjrN7qJxg5WkblVFMqsPVZvYS
	 xVcXETDjEyLf+sMZ/c3PcNMx6heVOnHmdaIEH/htaYgwaUerF7CVFnC81NZ3sqwEciw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793170967;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dFtAU6HSmjqsCl4Ev58EDN38ejUmTKRTj6QJczjR+bU=;
	b=ibWFneOXqLXoZE+xbBoNqXLd+jeOo9WEjYMQds8LeI/GhlJx5uNMUzV2RebC5qoKOuCv
	 aJ42dAXM9s/rQQIfunHrkFVWECRRXav7kEJ0BIkTnwRMyKzoIup6+3pw6DRz5UXwO7/7L
	 4+uRmSTk8RiJQMD/54cL6mYwXTr923swRZ2yavUu1jXmTLYskOoilSO6cbs8AD6C6PWwc
	 NvtH/sqByNUiqXHl/quCauSFJI1gdMojUM7ym2l4slAW3fPpha8ruico7k4mNSKRox2mN
	 hQDGWpyf1BlAlK9VM8jVP9Es+q53+xKgVXpQEjfHgN0kYR3RJgo50MM6PqyOz1OLNgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793170967;
	bh=dFtAU6HSmjqsCl4Ev58EDN38ejUmTKRTj6QJczjR+bU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ha3WNfFEJj2/Fg6ixXxfNbkTb5JLYbrVVe5AbHuplNnYtS3s9DXy+VukntBEAYgah
	 n7xH5LAxTDtFgpVl9WgYdbyDpRfyu1Id74hT09K2Ku/1crCLhxr4nKjLsRv9T7rlqc
	 aoo1WtQ2KtNhQCxL6qSKqgd2jYXx4lbbr+i7Igm8faSdhERj+W6yteuKpNM0mMkaDZ
	 k2HUugWEpGnscoMJAuF61Ep/adagduKd/0RnSTxP1SacICdqboCmkUmjJwOWm8LsA8
	 5uOmImKcm15+6ABUYykmLSC/HV+0RKKUBVTGwxox+23Kq/VqzDZqljs+1DjFdBIzRe
	 qnyEYDJaaEZvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFF9480E4C;
	Wed, 28 Oct 2026 07:02:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADB08972
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9177A605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vHcUTqS_hZgc for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:02:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3CF5606CB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=220.128.198.184
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793170964;
 b=b7zCLPtSPC55ThLUwdU+BVH8GBY5hrQ7pFHvCDPs8HE+3D7iBpjxh+zny/t+cUKnUvXJ
 7AQo1TvcoVzxXRf2g8mxVAnmtO2zN6z/L9hrgIi74bXn9V7wzBPKKNCO3a/pNqFOSMF0n
 v3D5oIptKKEAi3lOhJCfMu5bg51mk0gEsw1KAZpaO46RhXPex0gX6wxau/9AQ8hIPbiKI
 JIG3dx5fRKQIZpHejWiinb/BjN0uBQFbG6BLeYO48sQ41OK9o5n2WsfGGdLWc2clgAivV
 W6m+bwO10ymTRAptcuLqs36UMpUz+3g2Ys1JCy6R0slAXAEjHItzuJQ73nJncuuHjTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793170964;
 h=Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=dFtAU6HSmjqsCl4Ev58EDN38ejUmTKRTj6QJczjR+bU=;
 b=FcSIeKaZbhCe594U1JWOqAHBsOjzJBJ0v5twoRiSn/DZ9IU+fD0smQrsPvwis/5bJipC
 ykziUZF4Jpj2DqxjPMobcREJpFA2QMuKOE4B14C+arwL1c7WFpLX5mTtCBfVUrMgtnqyD
 7uHpGU/F2mTxIb95YIndEt+HAws9jXeN4KtIMsMpnVrdq6uRO6yXSORhLbfS8EHE5c406
 AdxpLb287I0jgbF1l8B0IUbBLO1emQ28tdR69G/eHui7qEwXqUdRSzMQdUMI8lCEQTjEG
 aFE/qO+3S6gQl7nlW3y8LawOWMDYR2tc/sTXCnGqyJMsoqyNhkaigDPFHuSQiHII3cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=andestech.com;
 arc=none smtp.remote-ip=220.128.198.184
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=randolph@andestech.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3CF5606CB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:43 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 69S6i4pl035105
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:44:04 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from mail.andestech.com (atcpcs55.andestech.com [10.0.1.155])
 by Atcsqr.andestech.com with ESMTPS id 69S6hcOl034819
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2026 14:43:38 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs55.andestech.com
 (10.0.1.155) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 3/4] riscv: andes: flush the L2 cache in flush_dcache_all()
Date: Wed, 28 Oct 2026 14:43:28 +0800
Message-ID: <20261028064329.1986824-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028064329.1986824-1-randolph@andestech.com>
References: <20261028064329.1986824-1-randolph@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs55.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69S6i4pl035105
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

flush_dcache_all() is expected to write back and invalidate every
level of the data cache, but on Andes it only flushes L1. Flush L2
through the cache uclass as well.

Until the L2 cache device is probed, andes_l2_flush_all() returns
without touching the hardware, as andes_l2_enable() and
andes_l2_disable() already do.

flush_dcache_range() and invalidate_dcache_range() call
flush_dcache_all(), so they now flush the whole L2 cache too. Flushing
by physical address is left out to keep this change small.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/cpu/andes/cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/cpu/andes/cache.c b/arch/riscv/cpu/andes/cache.c
index bb57498d75a..30d766da8f9 100644
--- a/arch/riscv/cpu/andes/cache.c
+++ b/arch/riscv/cpu/andes/cache.c
@@ -44,6 +44,10 @@ static void cache_ops(int (*ops)(struct udevice *dev))
 void flush_dcache_all(void)
 {
 	csr_write(CSR_UCCTLCOMMAND, CCTL_L1D_WBINVAL_ALL);
+
+#ifdef CONFIG_ANDES_L2_CACHE
+	cache_ops(cache_flush_all);
+#endif
 }
 
 void flush_dcache_range(unsigned long start, unsigned long end)
-- 
2.34.1

