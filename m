Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF38606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ho3Hi5Fk;
	dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=t67PkHfg;
	dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256 header.s=20250930 header.b=t67PkHfg
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2807780F3D;
	Tue, 27 Oct 2026 19:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PV89ocbfeSau; Tue, 27 Oct 2026 19:43:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2383880F32
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793130184;
	b=ieX2+YeUCDXHOux7A0By8Dw2WsbomUQg/txcN61bpUPqnScPYGMqVyRk0Cq2dmGoQ1XO
	 aekoqXItenqoj0AHIQ3IVr+BUu1bq7s67rY/wHwGq4rf7BmC3/f9sKd6YsGSoeGULK/vV
	 57JU/J5sW/bEHNzbMMa/UFWcywCkk54eXHgRjdRKGBpY1SWT/pg4UrEalxCRMw4/GruvZ
	 LyPxk2Q5NlyV6f29uESjbMvBuleLLKkpeWbOnzD1raJyMp3iSxu+858npff0z3ztvEWTJ
	 myQaxf60WfRQaOopFf9uitvDG8HG02+0RtTXx91K1oF6V4nzVifux4FF2qoNkTz9fug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793130184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RoIdx/uG7djAa03qmgxBCD+TghNW+aJ8WSn+QklOF/E=;
	b=fCIi7LwH/MOlyf540bioXYc2cRLSQTUzuRVkf7AJkuHjyrvvz26GfgjZEBCeUjYvybLq
	 /EOh2BcaZhKmbmixCYA3s0ODliaXi17N6Nwg2gyproJuengjZIApyrQT0uiv7suR2TzQa
	 /tTku/waIgVQL0X4BsiiDRWQHITbzwZVhBwogmfbwBfMwFRyn6vqqFZzNOoDJoKirCrjo
	 qReR7TUvswuN3dIq4qbisfj56mgwqL1sbkkmxWaPFgqMnJ50rSyYbb3kzz3NKuCCx3QU+
	 /sz+coG/IuMCpwDCfr7bt7Ka8UegUIhgYS90DmghlOW3FQea7DcyzNsmMfkoQSQDGeA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793130184;
	bh=RoIdx/uG7djAa03qmgxBCD+TghNW+aJ8WSn+QklOF/E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ho3Hi5FkMF0hGPzTogqGMcSAitVRO8+Qq3+2LXPx5NX1jWL1TAcL2E+4Ys+7nEn1n
	 VqViB6Yg55kJQr9oxzWWeBesy6APwq2CshafsRomlGHjCRKBy45SqO8S+ye0fwlqx9
	 KKdtQl/8psMq5GwZZqReX4sGK2p1ivuLSZguhfLlWCMYoJqMshaIWyZqZXd42w9dDt
	 SDQq3LMywx31zjSJKah2xm0XxNqxAYi8uLt01TJZPI3G8BhXUVLUCIofGPYNpYFeFa
	 dmgtQ+64kMCRqpg/ob7RQOmFn9UaNsEeCiJFJqxugRYIJEFsfGnpIDi/xjVPz7vUk7
	 hGfTIPGjTlEZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2383880F32;
	Tue, 27 Oct 2026 19:43:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A0032F5
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 507CD4010A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vZIX688mLpM for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 16:13:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 95B8D400E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.63.209.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793117625;
 b=ddMCxJFjvi1Ut6UHDxPfw1HhNb/e5zy0O5WTrh9sJRwzqw5y3kV1AZUIhE/xB4v7J8Jz
 fPBsZrm3gqs5kcpmhUtsDmqk22IdEjtjkWldRQygszyg8aCPKhhYXFeO+VYxHRvIMmLkq
 1JlO3K9wH5l38XpggypEUMSYsfz+8cpX5xcuGvoIy1JgN7/cU01IAc7DRDha+4XtU4vmr
 7cnyuCmiEakxbqrgsm5EJ82luIz339U5jC3f5SbT/V+SUoLg0NtLNGSJuOtSF9uOg7qk6
 hf2dEjXVHiK3Jtpr2OqiYNQ+2W373BkhJiGbAgceHf1uy0TCqEjYHvH1WzL5GP8lGUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793117625;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:DKIM-Signature:
 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-Virus-Scanned;
 bh=RoIdx/uG7djAa03qmgxBCD+TghNW+aJ8WSn+QklOF/E=;
 b=nsovceusQXzRNb/qVaXwiTjMEmrbYJzuKbLbmZp1BbD/x8JxqfJSWHXj1Nju9OyeI2tI
 2RVxGLrg4aVo90SOixRn+3YLGwYqeEK1X9CSMbe+zqLk0D0kHhJvisZk1kWyhzbrsDyxK
 v2FlhMH1s3B4XYgdmk1kPqhZg/hbPiow2/lM7tMYfFWThupFwXHAoEiCPYmDoeXpQvFhd
 gEm+rYu9de05EIsuR5DmxPIJm8IRNQ3UCYwfum5/l5vpsOMhfOAO35IdaHlif3+dEaKim
 JkQUnJNlMykMx2o95wN0OqgsLi+mr8tkozUPkdIxRdjGAKYTkny5Cg70zTzNTA2pMjA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=emlix.com;
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=t67PkHfg; 
 dkim=pass header.d=emlix.com header.i=@emlix.com header.a=rsa-sha256
 header.s=20250930 header.b=t67PkHfg; 
 arc=none smtp.remote-ip=178.63.209.131
X-Greylist: delayed 383 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 27 Oct 2026 16:13:43 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=emlix.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=t67PkHfg; 
 dkim=pass (2048-bit key) header.d=emlix.com header.i=@emlix.com
 header.a=rsa-sha256 header.s=20250930 header.b=t67PkHfg
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.63.209.131;
 helo=mx1.emlix.com; envelope-from=tkirchner@emlix.com; receiver=<UNKNOWN> 
Received: from mx1.emlix.com (mx1.emlix.com [178.63.209.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95B8D400E9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793117238;
 bh=RoIdx/uG7djAa03qmgxBCD+TghNW+aJ8WSn+QklOF/E=;
 h=From:To:Cc:Subject:Date:From;
 b=t67PkHfgRR5XSyjZp2gfl5IeqrivztgpAvuG1s6VzBMa2kjYtTWkytKYTruhBVPFn
 bxEaVOzHYuXe6uuch1tZr35QVcS6cdTWU7gsCzGlFERlYN3vosKL05GojgTqLe20zo
 FNmjDS2UtGVgJzXzRU9ftlA4SPrdE08moyYfbsK9J3CRNYgayy1rfSqFYMgNsfTvoy
 mKuOZapWITHeo9B7CUooTGlLFYUT2KF+ISWjS5/06D5jla9Ir8lO0UKNdBIzTPQVAG
 ZD0s5xrmGlyfj+gSjjO5GypowtEX7AXHfNIMbfAbEBEuz4xee0vgqI63qdsGGcn0N/
 Tt7CthvjNi0ew==
Received: from mx1.emlix.com (localhost [127.0.0.1])
 by mx1.emlix.com (Postfix) with ESMTP id 3C6D35F87C;
 Tue, 27 Oct 2026 17:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlix.com;
 s=20250930; t=1793117238;
 bh=RoIdx/uG7djAa03qmgxBCD+TghNW+aJ8WSn+QklOF/E=;
 h=From:To:Cc:Subject:Date:From;
 b=t67PkHfgRR5XSyjZp2gfl5IeqrivztgpAvuG1s6VzBMa2kjYtTWkytKYTruhBVPFn
 bxEaVOzHYuXe6uuch1tZr35QVcS6cdTWU7gsCzGlFERlYN3vosKL05GojgTqLe20zo
 FNmjDS2UtGVgJzXzRU9ftlA4SPrdE08moyYfbsK9J3CRNYgayy1rfSqFYMgNsfTvoy
 mKuOZapWITHeo9B7CUooTGlLFYUT2KF+ISWjS5/06D5jla9Ir8lO0UKNdBIzTPQVAG
 ZD0s5xrmGlyfj+gSjjO5GypowtEX7AXHfNIMbfAbEBEuz4xee0vgqI63qdsGGcn0N/
 Tt7CthvjNi0ew==
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 19E8F5F861;
 Tue, 27 Oct 2026 17:07:18 +0100 (CET)
From: Tycho Kirchner <tkirchner@emlix.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tycho Kirchner <tkirchner@emlix.com>
Subject: [PATCH 1/1] armv8: sha256_ce: load and store state with ld1/st1
Date: Tue, 27 Oct 2026 17:06:49 +0100
Message-ID: <20261027160649.371618-1-tkirchner@emlix.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:43:02 +0000
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

sha256_armv8_ce_process() loads and stores the hash state with

	ldp	dga, dgb, [x0]
	stp	dga, dgb, [x0]

This requires the address to be 16-byte aligned when alignment is
enforced, e.g. when running with the MMU disabled as in SPL, where all
data accesses are treated as Device memory.

The state pointer sha256_context.state is located at offset 8 within
the context, after total[2]. Depending on where the context ends up on
the stack, the state is therefore only 8-byte aligned leading to an
alignment fault (ESR 0x96000021).

Use ld1/st1 with the vector views of the same registers instead, as
the Linux implementation does.

Fixes: 0fcc1c76d1ac ("armv8 SHA-256 using ARMv8 Crypto Extensions")

Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
---
 arch/arm/cpu/armv8/sha256_ce_core.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/cpu/armv8/sha256_ce_core.S b/arch/arm/cpu/armv8/sha256_ce_core.S
index fbae3ca362b..ea918dfc35b 100644
--- a/arch/arm/cpu/armv8/sha256_ce_core.S
+++ b/arch/arm/cpu/armv8/sha256_ce_core.S
@@ -85,7 +85,7 @@ ENTRY(sha256_armv8_ce_process)
 	ld1		{v12.4s-v15.4s}, [x8]
 
 	/* load state */
-	ldp		dga, dgb, [x0]
+	ld1		{dgav.4s, dgbv.4s}, [x0]
 
 	/* load input */
 0:	ld1		{v16.4s-v19.4s}, [x1], #64
@@ -129,6 +129,6 @@ ENTRY(sha256_armv8_ce_process)
 	cbnz		w2, 0b
 
 	/* store new state */
-3:	stp		dga, dgb, [x0]
+3:	st1		{dgav.4s, dgbv.4s}, [x0]
 	ret
 ENDPROC(sha256_armv8_ce_process)
-- 
2.47.3

