Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB7606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QLFg9bic;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gwydVjqF
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AF61406D7;
	Mon,  9 Nov 2026 19:40:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R05_DcpNzFYh; Mon,  9 Nov 2026 19:40:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E35A640677
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794253254;
	b=YdBQRctYR6eQsDlfRsYo8GxaVbwF7PoKDhb05uuGvf2QKD90M+LRd+sj07IOtZ6vN9YG
	 YVb4/Tdk6GVi+NQ34MnaHDNeO72qdC5IRlFdP0UXmUJwxYp6prnsIenpCMRyFNiqHZxy0
	 aMAmnEMz4Pj6bCP6zp/gTzGJSvqkA5bofxzXkaNWrNerpl33B2sCERFJyg34BwVyNbplU
	 3vAvFgRlrMFWPQW54yp4OFYg/qnX9RAKvVXUe55gB2zeeTtMhjCDPaH1arGiz+tst2fzV
	 BPSxGp5ziToXINN9XTzxQ/t5SV/Y/3FkJ9yO4unsqQzvWU4JJVTMJfYxDPiaJNE9VTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794253254;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VBuB0IyUW7xW/j1Zykn3xtlSImV3Bi0rngxD7pEctvc=;
	b=hct2I54SfPY2JfBq0/iy6Iqy9453Am7W+r0pzq0uvuhNFyNusGHedXEbQ1X5CBwu2yAp
	 llbjNCmgEzRQ2Ah4AfL1PVgH4dKcsk20ER3Iji9600Mki6U1Z4xowV42jwmoDkzt1QOXR
	 dyy8uLMoEQVa5R1PY9uI71atTZfANND4Lzlf4Yys928G1o3HeqhzsSqI4/aGgYyQiDbV5
	 wZNeKU2fXwy2O1i712PbwkFtTqWEcQ/MqDvWR1NajXAjDLIg4XVt/N02b2s0NzagnCmVY
	 xN6Z5am8aXxmEbONW5F+NzxEZmtQWh3G66lMZWr3eVSPOYSZNHyapE1wxBCLohFpeBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794253254;
	bh=VBuB0IyUW7xW/j1Zykn3xtlSImV3Bi0rngxD7pEctvc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QLFg9bicKd8Xyt/pA9bvde+7x9b8pF/qOYj4JhlQjS3TEPdOFcOQ6e1Dbo4JuRUZi
	 czH6sGmpRLfKekRTabTiA7Ef4jJo4pIag6FZPcnNqloisaqfHf8IH0R9ldqB+/oXXN
	 Wm+ENM05xaM09LNYO+olUdwsdkGzwOjkFYK6Ptv0tLFE+l2BP3IOWhkPshD5Q1oOiJ
	 Vnx9JA0usLPa11iGTR6H4j+3GPp3cxDA/S5e5GmY5llg81qer1yQsgULP6bFsOiv96
	 +2jytg/cBSbyq56Z4qwMc9roJ0FRzMHcXaD9vksLJsv1+Nrf+cm+NSWLlo++3Q1w+H
	 qm42ySf63Fh3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E35A640677;
	Mon,  9 Nov 2026 19:40:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 86477335
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7748F80DA2
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WT2mUwmJeVtK for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4DB2380D34
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.224
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 19:35:43 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=gwydVjqF
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.224;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-224.mta1.migadu.com [95.215.58.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4DB2380D34
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:35:42 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=qYGl/r0zj/YjbchdOyByltf9+Zu2lazUJ2hMqhXOQa4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794252940; v=1; x=1794857740;
 b=gwydVjqFlSDMB9IzYWxDOa2X82f/0bJ0tUiZ0xfHEG6Qa0u01hmE8J30cpLXeWZYy8e+c7MA
 DV4uv7cXUCc3rK7cu7x+KDFbqbg1m6/41KOaTpKRp+lmXQBfrvFjZNUCaBCq8+UxFYIaJgycMgc
 ZbC0lt7ROBZ7uHTXc3urVlzk=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by mta12.migadu.com with ESMTPS id 04bca93bf33a7fe9;
 Mon, 09 Nov 2026 19:34:36 +0000
X-Mizu-Trace-ID: 04bca93bf33a7fe9
X-Migadu-Flow: FLOW_OUT
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Subject: [PATCH] MAINTAINERS: update email address for Bradley Morgan
Date: Mon,  9 Nov 2026 19:34:34 +0000
Message-ID: <20261109193434.3225755-1-bradley.morgan@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 19:40:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update my email address in the POWERPC entry to bradley.morgan@linux.dev,
and add .mailmap entries to map previous addresses.

Signed-off-by: Bradley Morgan <bradley.morgan@linux.dev>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index c6cb27cdff8..bba5ac43f14 100644
--- a/.mailmap
+++ b/.mailmap
@@ -39,6 +39,8 @@ Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
+Bradley Morgan <bradley.morgan@linux.dev> <brads@mainlining.org>
+Bradley Morgan <bradley.morgan@linux.dev> <include@grrlz.net>
 Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
 Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
 Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
diff --git a/MAINTAINERS b/MAINTAINERS
index b6ce499d0c2..3f4f984bebd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1456,7 +1456,7 @@ F:	drivers/power/
 F:	include/power/
 
 POWERPC
-M:	Bradley Morgan <brads@mainlining.org>
+M:	Bradley Morgan <bradley.morgan@linux.dev>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc.git
 F:	arch/powerpc/
-- 
2.53.0

