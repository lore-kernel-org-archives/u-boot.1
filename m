Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4C606A334
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 07:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s4JTWMSG
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7C3C80D01;
	Wed, 28 Oct 2026 07:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hED-nuLnkn0u; Wed, 28 Oct 2026 07:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9461480CE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793170957;
	b=WilOjUBlZ6uqJy2t1Huwv2TryCUm1jFjv1LvdfPw4u+k7U2libaZW7gLdzukaPJv597m
	 4hko7K67LSY8IfDr9nFJm9QEg77/ASh2535r5JHy2jpZw4VX2RsURht/zLGREKhqJ3zfm
	 1xerHt5qDqGRIMcDXrxeXmzxi7Y1JvSc8ia4EzLChgzCCgWvlGxxy0E4G20+E4mbnIof+
	 o8XuAyKkoou0Zs/SXo7Agzl2oKjDKZeG/lCJLOd2uCVsejX+hmvZiA6AoZjPmEAWki4KA
	 G2HO/BdX9NWP3jSU/p4hvykVj+5IwTAjYxVhxx5+tKoY9+ZCK1+KdevpLHFLSDyiSLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793170957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-DKIM-Results:
	 X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tcn7mDdAsq1WgC76MDlFWmaqHjH9/3NZepZwVQcaesA=;
	b=EzFgChiOwLvKa6p3zH5Hz93kXqCJ/cUt/oABfSLB/Sif2PZ5JnHwGyP9cI8xofv1VsQ9
	 Xial6brpxR2bGVHuKPJSg7258q+r9D0I0SKim3mTDmsB4vyz45ccq7ORgXNJh2EUHv2W1
	 ZzqPtcm2khmYsk0G4ATX+EMBl+Trp/sB1YhMm7nObY6imGF35PRMiEFA0gZj2nEelfs5l
	 8fh2J77RJO1DQExRMVvzw9F7STobS+M1P+JQcUlIteJQsRplcKqYes3KdoyepkWItGvf2
	 oTn+HeOVuC6dSLfwKf1gb3TIZaXXIK7muZodxzyymYsPBTUujXGHAoyGGEtvQMPYvPg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793170957;
	bh=tcn7mDdAsq1WgC76MDlFWmaqHjH9/3NZepZwVQcaesA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=s4JTWMSG1AfdZ2WXpJLmiMusFNi5Z28bICOkekBMdR5eN8/6+cSUp5yI1E4474xbQ
	 uhtODgIrFu8Sw0rfQppdD2lPhSDRv6jwzgzNZDeIv0m1JkZeqNYaZRh+4hanHTAJPn
	 cvy/hVSSq/jZaGK0AbTIHj5dZMsxMHUQN0eNFB6Ubu+SgkSe0phZV4bhIGIrwVppGL
	 ru+Ue1C3vxCQJEEmTuBOsytgfl0CYFl0Gbfusz6pBmIXTRgxe1lTxR/mJi5MUC5RnC
	 CxY2K4puAbz9Hskvm74lr3Vki3CWmyxod6i8/k2nianB+Ml87rOhiYD8O0pFvEqYxK
	 OGesy4swLnMzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9461480CE8;
	Wed, 28 Oct 2026 07:02:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3F89D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9584B605F7
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfSFbALmNkEa for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 07:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1467605D6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=220.128.198.184
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793170954;
 b=b3yXxbalT9v+eCDl1yPNLMylQDEhAH8e9x0oXhbfroyu4/j8FBQGlVLUDhnoWTLSXxQN
 8nmW0m1lffQaY3CK1wg48dm3yUCxCEcqFLbtFSxUNpAzww6uKJmiYC3dYDCWFSy5cWHf6
 6MAkCp2IilXlbuiYxQuM7DX5OBEPUA0KoGfyOkQqrgu0DmSNIVLxE3jKhhrSBe9GJsAsV
 1Gs5JLuL9SSsyrL1suhLRifaeLi4MJtxedxQRU1U6Tg9i6TcCaS6c3qZK63NQhJ4tDeXR
 4YvkysUGRZYBRrbl1rHKA7zrTNvEkdy5b+t1EnXSIxeQnoVdcmsgCvycofalfssq67Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793170954;
 h=X-Greylist:Received-SPF:Received:Received:Received:Received:From:To:
 CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-DKIM-Results:X-DNSRBL:X-SPAM-SOURCE-CHECK:X-MAIL;
 bh=tcn7mDdAsq1WgC76MDlFWmaqHjH9/3NZepZwVQcaesA=;
 b=KdIU7BNYWVh/P5sg4EUzM08B1myB10wzB0Lpc6naLiaqNQVJ6GJfASiBjANjkAl9pqNG
 Nqv2UIqCKjCmWE5if3iDarMEFR0/XnMRdXeUk2HRNRuI0Kgt/7FE6etIcrhqeji9WEnxd
 P7zQFpuCvHmQtD/0o86AbcxxgPLil2izkIkF1o4xpw759HY34/QTYTk4PG8cxlD3N/hwh
 JqWbHMhTQG96w72cuNcFc5WdrXd6s3bBD7W655CkYRD827h5jXDPUbzrO2tWo0VY5miPc
 gvvYEMZOdhyDY2h17vj1IcPxU1zIF1MwaKSB45LBMwAFmoxUByjTLQDxkEjw2Iu5I+g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=andestech.com;
 arc=none smtp.remote-ip=220.128.198.184
X-Greylist: delayed 1126 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 07:02:33 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andestech.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.128.198.184;
 helo=atcsqr.andestech.com; envelope-from=randolph@andestech.com;
 receiver=<UNKNOWN> 
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1467605D6
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:02:32 +0000 (UTC)
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 69S6htHu034971
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:43:55 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from mail.andestech.com (atcpcs53.andestech.com [10.0.1.153])
 by Atcsqr.andestech.com with ESMTPS id 69S6hcQv034816
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Oct 2026 14:43:38 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs53.andestech.com
 (10.0.1.153) with Microsoft SMTP Server (version=TLS1_2,
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
Subject: [PATCH 0/4] riscv: andes: add L2 cache flush support
Date: Wed, 28 Oct 2026 14:43:25 +0800
Message-ID: <20261028064329.1986824-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs53.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69S6htHu034971
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Andes, flush_dcache_all() only flushes L1, and flush_dcache_range()
and invalidate_dcache_range() call it. Without the I/O coherence port
(IOCP), DMA masters do not snoop the CPU caches, so dirty lines left
in L2 make them read stale data.

This series adds a flush_all operation to the cache uclass, implements
it in the Andes L2 cache driver and calls it from flush_dcache_all().
In U-Boot proper, enable_caches() runs before driver model is set up
after relocation and cannot find the L2 cache device, so patch 4 runs
it again once driver model is ready. U-Boot proper in S-mode then
drives L2 itself, as the Linux ax45mp_cache driver does.

Side effects: each range operation flushes the whole L2 cache, "dcache
off" and "dcache on" turn L2 off and on in S-mode, and L2 is now
enabled in M-mode U-Boot proper.

checkpatch warns about the #ifdef in patch 3, which matches the rest
of the file, and does not know the Assisted-by tag from Linux's
Documentation/process/coding-assistants.rst.

Randolph Lin (4):
  dm: cache: Add flush_all operation
  cache: andes-l2: implement flush_all
  riscv: andes: flush the L2 cache in flush_dcache_all()
  riscv: andes: probe the L2 cache device in U-Boot proper

 arch/riscv/cpu/andes/cache.c   | 19 +++++++++++++++++++
 drivers/cache/cache-andes-l2.c | 16 ++++++++++++++--
 drivers/cache/cache-uclass.c   | 10 ++++++++++
 include/cache.h                | 16 ++++++++++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.34.1

