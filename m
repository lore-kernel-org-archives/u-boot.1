Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE6606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dOE6K6hP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vxAmt6Fk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51EB780BCD;
	Wed, 25 Nov 2026 15:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wa0l0WDj6wtE; Wed, 25 Nov 2026 15:53:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD97480C3F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795622025;
	b=AuwGvVzcMuqJ1bAHl8NzUuKOLbDcgZe4tXCgreYOe6DnW8KsicSZ3ilJ1xccx2EOJdIT
	 ywkUEBTxR2ttVpAbpxTvyoqbAs02Q2b4tg6tJUcjo7EEb/D+YFownLde8P9mDjkqzkE3p
	 aEZal/XIaHzDBzOoMMxOTSPRZbxluxysB45bkzyg2wlXSOao2cqt43JRTGQdk9D1D4Hx9
	 ZZfLvLcm1o4pU4O4+H871K3iGCv5ntKC3MM9vv9yXng5KSo291afv6dRhRcajDYEAch3J
	 7ikwLGGOMpLlecJ6dlzhBhkNUKkld4kbT4crBfYzuj5K+W3h5pVrMTo4ABILiTvt4yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795622025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:X-Envelope-To:
	 DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:X-Migadu-Flow:
	 Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L5cvLquh39Tdfku0JitTMI/8VyqBeq/SNWPRbwvem3M=;
	b=czlvxgeh4tCN5Blh8qxyL9d4wbqM7rvPHFB10EN0E1DEDnZG6T+FVZO/ohUcpltCJlao
	 qydTyC8nZxRW2an1vsmwvVaAPqBmQc5WAkByHXjjCpb4T9+gzpHn1QEdXc8AT8Zuz2peC
	 uK/hxu9sKfHLOVkdL0eWYj8Yvv3eWutuO1e+EO6oUofTzH5P5fNWM7r2T6vAFQXDG4pyS
	 sCsaXUuSec51Gijj2GXTUgBaEwhx37Zx8yXQUS1mPIVgwRTUaXIMENtBe+vnbTjClFzGD
	 CJZwtpuULgUSLCns9mRe/CfO/x3AahxJtMegJ3bHUVHR12ihoyFhYRXMO+iK9lhHDww==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vxAmt6Fk;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795622025;
	bh=L5cvLquh39Tdfku0JitTMI/8VyqBeq/SNWPRbwvem3M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dOE6K6hPO4FGOjO8nWYbEWXq5R/xwciNsoMXMfAWlRjnsocXy0Y0u6sK4HiKIZiiI
	 xxM6u5ISZpM4IG5w4CjvsJqGexrbA+eMsM+FXZUhEh30S8C/0T0n/+yGXhf/Otq1Qr
	 1VQKfEqNXTlFd5I8VPjBJzajp1kVW9DWJn5tAMOo+JttmeScV4b4vWEe76nqtYRZUP
	 AR8I7jJxp+4dfw4N15jx4nc1onUXDWB6HVllMOhOYv35dwANZQGqkI3b38mgvCk0Q3
	 6dH9ZnXLi3OIprrXnW9loqjBVmpwurs1g2SWsp72UW4DKHqK9xbvveib8z9sBZCLQM
	 necLYUAhRoGlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD97480C3F;
	Wed, 25 Nov 2026 15:53:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 953CF32D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B8A180C3F
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R3DWFMmk-PnH for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:53:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EAF5D80BCD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=95.215.58.245
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.245;
 helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=vxAmt6Fk
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAF5D80BCD
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:53:42 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=4YuKyoFXDYQIW50zUel7p4plrj4hcPunpTcbqyt/AOE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795622020; v=1; x=1796226820;
 b=vxAmt6FkQmLeY9BTKlr3RcYW37aicmZMdYkIz5V8N2ZU07zkAbRAN/8TBFjR9B8Dd53l2Bt0
 GrI/WzyeP7kBN675jZyBFihHtwXkIa45JgQAGz1XYIi63fhMqLQ4mRf4/cbbTI5uus/vE53wViR
 kGiUUmMuvzqyMGar1wiIg3/c=
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id 55c9bc601a59ef94;
 Wed, 25 Nov 2026 15:53:40 +0000
X-Mizu-Trace-ID: 55c9bc601a59ef94
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 15:53:36 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
CC: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/6=5D_powerpc=3A_mpc8xxx=3A_Avo?=
 =?US-ASCII?Q?id_a_64-bit_division_in_get=5Fwin=5Fcnt=28=29?=
In-Reply-To: <20261125124259.95636-5-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <20261125124259.95636-5-pepe.schlehofer@gmail.com>
Message-ID: <C41DA0FF-2B86-4CD4-8C07-87E896617605@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 November 2026 12:42:57 GMT, Josef Schlehofer
<pepe.schlehofer@gmail.com> wrote:
>GCC turns the u64 division in get_win_cnt() into a call to __udivdi3(),
>which U-Boot's private libgcc does not provide.
>
>Compare size with the product of win_cnt and PAMU_PAGE_SIZE instead.
>For a non-zero win_cnt, size / win_cnt < PAMU_PAGE_SIZE holds exactly
>when size < win_cnt * PAMU_PAGE_SIZE, and the product is at most
>128 * 4096.
>
>Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>Cc: Bradley Morgan <bradley.morgan@linux.dev>

Acked-by: Bradley Morgan <bradley.morgan@linux.dev> # PowerPC


>Cc: Tom Rini <trini@konsulko.com>
>---
> arch/powerpc/cpu/mpc8xxx/fsl_pamu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
>index 638c3a6fee5..b6f8552d7d8 100644
>--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
>+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
>@@ -364,7 +364,7 @@ static uint32_t get_win_cnt(uint64_t size)
> {
> 	uint32_t win_cnt = DEFAULT_NUM_SUBWINDOWS;
> 
>-	while (win_cnt && (size/win_cnt) < PAMU_PAGE_SIZE)
>+	while (win_cnt && size < (uint64_t)win_cnt * PAMU_PAGE_SIZE)
> 		win_cnt >>= 1;
> 
> 	return win_cnt;
>

--- Thanks!
