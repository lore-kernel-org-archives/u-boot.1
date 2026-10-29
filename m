Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA3606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cQRT4DID;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=nyGxV1QE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 49DF5809B5;
	Thu, 29 Oct 2026 05:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMo4UkZGbvX8; Thu, 29 Oct 2026 05:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9613080DC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250613;
	b=QDQMz+MP3kUYD86qvYQ3su3FEqEeUrSYO67PbpO4y+QN5cZN6mbs20ioTm3N6OHD7EEb
	 /H1pihidA7eCU4ht2Lr6dgv1TBXkIeDoYxWCrWGNWGj+7q8Z5IQ43ni0evmlA4TvCV7N4
	 a3Uuhp72ALY5kUGjMGbHFj5oWkwgc+ljdkfdh40Ix0RBeg4XAoCmb8rH7sHGG0yBCAnwe
	 NH3dEP/onCuZay/ATG+FWdEErkEs5r05/ESXGKUzxucqjTTB6ebhVGucEGEaGZUB1eAff
	 R2/HOrhfMFpEdBIVw4DSChlMcxbxs7DF71k4EnhqxGneheHx18qxqPW0pvhEp6n8H8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250613;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7eiUorLQh1+iIEL+c422dEto0AMvXGw38bhHhWuRVAg=;
	b=AG1zew1UunGpFu41n3YGfHONd9wV0sf+tZLCQRHd6VLMqwByJFAaHWATS0sgQQbPhUIe
	 3lWREAR5ws82ZXcCM9HSD33BAuIvS9UMBm/DQbBtbsIzgyCcz+rlZMdOzUTF25LwRzsRy
	 cy4E67Vwn++YHhdOzo+fUFNgDp7/Dd3GyrdX1Tm5GyOswQNtcZqBePihU1Tgd9T4hSGNR
	 J/gIFF2NuBGJZi89UM38URTlWEofT+m+IDF9T9tOPRMrWSYtlgHY0iw+g1Uu+dZqcugIs
	 Ji/LxeMWfmRqnQSQxZc0gPsI64yO6DETxh0UXmBDid4F/aftKTiQtcqYONGSQxjwU4g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250613;
	bh=7eiUorLQh1+iIEL+c422dEto0AMvXGw38bhHhWuRVAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cQRT4DIDUq+Nkhd4/Ngv+hfguvbWWZIbgHKnndRU+dnfRhiWoeHOj/PW5fNkuXkSN
	 NL05CBg5PKVWn66/gIKlJzR5/mi+zN+1/VMl6YBRWSCAimfCVvI0vsct+Awup7bRGG
	 hiQ9jXvk77L3fP295mmS5W23m6q+zlOdGdfIDx63DXmFooBDghw99gDRJwxvegyuDH
	 LbzoJRPq1JumHZkzmrd5fhY4WFFQZu89bG4uODPUt93DVQqbbzr30uLoXFeRawfvxL
	 C5zxSf71SEY0axZ3nj7VI5hi/uaNy+QzmUG5JLQ96r+4rQaRx/1GuqTC46eK0lyjrN
	 8b+pzfxeClkpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9613080DC5;
	Thu, 29 Oct 2026 05:10:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A80521DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A5E040310
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BLzn_rr1qQo0 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:10:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ED31040176
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250611;
 b=dVigybEopqoOjhCp9wmcuEqoyR32oQbX8qXuH/bxK/EVVDhjK/6hDVdmCIFZwOcjCLG2
 a0jWdqWieh334ZY3CyjiiBbXRBynR11gNT6vHu5Pxf2jbWvEMi1Ag2JMMT0VVXAvPFPa/
 C5XMyGm2CO94JDXu329o461uhilogbz+21T26kJ7CxEIm0ndkB2XVLU7T5FJcb+4tcO5A
 i6Q3Fn/aPxS868PPnefPTyrNoAhPoTUdpzQ6fy7XVsOZec77SE90EfSRKcwZ6JolwE6eE
 EamQ7rblrcrlbPYjvvJ+Dp5snnKmuqc92rJo1U2x/68F3Prf7rVi5fjnaT/N2YDOjQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250611;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=7eiUorLQh1+iIEL+c422dEto0AMvXGw38bhHhWuRVAg=;
 b=AX5R8gCbLy6/YRnGB/3bezie6/7Om/1rJhMu7ke8JQuKU/uywKhrO+wCKbhlBm9DauZQ
 qbGO8RSsa/kjzzajKUQgdEh2EkCsWOQs5ECvlo4wmbUJ5/4lYPVvDDytbIZXsZ1MMrzmD
 1vpHuc/X9prVuTi7TURtEd9TRaUNggNboj6aHea/5mXcULKVyhFzgRcO7w2A7/HFo9IBw
 yvtpFzphz488YSjyA6WqP0Qn/ssatwcVJYgmD1Lhkr3zigCPqSycO3Ux6yLBbCFvlKofs
 /OoyfIWk6EoICmOf7cxxGpc1l4QSqAarVBx96MJRiwz2nzgmt6tBGInBL/rVGyroVJg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=nyGxV1QE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=nyGxV1QE
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED31040176
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250603; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ovvc1rNzcJBtGvlnr47tGYGqi2hORQRn1xlfzAYA2URqrm10ARrmtxDaos3Z+fOqnctJSAmldZTrpp7nl2Oe7GPPuRHbohLx8NRloSxJg7QIzq8Va5G1DoG+WjxVQ1i6Gj41MPP4EnQcX3A2WCQwkSgJpftEQV4HYcuo+4+/mqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250603;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7eiUorLQh1+iIEL+c422dEto0AMvXGw38bhHhWuRVAg=; 
 b=MCz55jVF6BkJnpE5xf3LNdytOwJjH73oqeSnofWK9w1pDNwBistJzmStob4fccR/fS21YguK8LBk0dnOcqo/pnTUg9e9gengkexDaTTuCeMOzrRbJuje1nwJJWPucHZFnl0YhsXa2OArWgDdWhdVogB6zHMI6oMbW7AgJIl3KP4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=nyGxV1QEiAVqx70umIVqgVwOL9sq+o7iax1ouhBwy8rUlZDR/dakbcVMQb9M0O7YTlz2sM314EP5b2vuxI5IerGBHX0lOkfcCm3PbWDfz+r7Zj6W2MbQTTvXDt/f+O4o7QLExfjObhFRDFY4gnJYMDrMPxGT67EsgY/iK6AfVDQ=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=7eiUorLQh1+iIEL+c422dEto0AMvXGw38bhHhWuRVAg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250601431123.3787746576694;
 Wed, 28 Oct 2026 22:10:01 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 12/20] board_f: Add LoongArch path of mon_len calculation
Date: Thu, 29 Oct 2026 05:07:29 +0000
Message-ID: <20261029050738.1107663-13-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

gd->mon_len is calculated in the same way as SH and RISC-V.

Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

New patch since v4, to ensure U-Boot correctly reserves its own space
for relocation, even without SYS_MONITOR_BASE enabled through
MTD_NOR_FLASH.
---
 common/board_f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/board_f.c b/common/board_f.c
index ead7b6dd743e..bb29b056f3c8 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -277,7 +277,7 @@ static int setup_mon_len(void)
 	gd->mon_len = (ulong)_end - (ulong)_init;
 #elif defined(CONFIG_NIOS2) || defined(CONFIG_XTENSA)
 	gd->mon_len = CONFIG_SYS_MONITOR_LEN;
-#elif defined(CONFIG_SH) || defined(CONFIG_RISCV)
+#elif defined(CONFIG_SH) || defined(CONFIG_RISCV) || defined(CONFIG_LOONGARCH)
 	gd->mon_len = (ulong)(__bss_end) - (ulong)(_start);
 #elif defined(CONFIG_SYS_MONITOR_BASE)
 	/* TODO: use (ulong)__bss_end - (ulong)__text_start; ? */
-- 
2.56.0

