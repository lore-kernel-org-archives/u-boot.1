Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78920C98321
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 11:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1094160BF2;
	Fri, 25 Sep 2026 11:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 55LzqcFTsp43; Fri, 25 Sep 2026 11:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3AA5E60B3F
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790336327;
	bh=kejqOhQgIDuJpqDGKGb7gPQ43z3O8T10N+vK5T0SGa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VzfcSc50/diPXdPTIekYdrTpcbLYjGoU7yrE/S/LNvxUPG/mZXtBi6XemIkIqPNFg
	 vzuqhNdHVybhAbWW7bmJhj6WE77ET5PP/5thHVQgRZwz02os+2nV1apYheikUGeRN8
	 mWnvlYtBP2gstqLTmjVF/EUDJbcL7AdrSzoH+rEBbWk7RFNgTWympVq6dDcrZlGmFH
	 OYVlW91dGSGoRRFzzvsEtvTsabt0+QF1i3JEszd40RmsLltolQWGr5eaFeDGMgeNVI
	 D6FiZHtEFEgtODFg474MTFjIUg8OROYxH/d2YeehwghBajbcvE/IVvGEPnFivrhpkA
	 yygILeDtYnEnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AA5E60B3F;
	Fri, 25 Sep 2026 11:38:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66417D1
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5786981203
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:38:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2XZYlpyuvON for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 11:38:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 30E29811CE
Authentication-Results: smtp1.osuosl.org;
 arc=fail smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790336324;
 b=B6K2L78acMFdTHI/kObA6ZsiVDgo1jpdmtEt26VUKVF8AKjbdbf9+bP12CqEXqVT3leT
 TuptjYm7alADSLqIgchhB0XGB4LL4MqgdM6E1BpU494WB80BpcbgoSAI8DLYQNVfM+LuB
 t5J729KMt/h6n+HpT07359VerqR/JoxL73kpKnPMu8e1SeNyCVnJr93oVA62GJRGsKTxh
 02la/rs+nxtv86rwoxoec84ZorqPXoP0rNI4pCYhTn65tXP1BQfOTAHgFh+xhdbST1B/P
 aWPAAP9XP4450Bzii7UQDXH9ApLfh9txK1O/NGReA8IvbiWbTvA7NPNtVsfd6mp+Pmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790336324;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 Content-Transfer-Encoding:In-Reply-To:X-Zoho-Virus-Status:
 X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=kejqOhQgIDuJpqDGKGb7gPQ43z3O8T10N+vK5T0SGa8=;
 b=PFtXuZ/urskTSw76HfmYv4GSKnIPIi52a3khC32kDsnbVJ4l5APdnUXMp8fqT1xzRyUn
 jtjf2lq40jlf3uCJIy2us7iYBcuvC0MLEoDEuNiw0OJLotJJAbKDC+ELhabWAsTl94bHz
 tFwNQuf4AiN19GYGCYDIkbCNPAdX6slMFqmUZ+HBmM303LdZ7jlU65QOJ0+PmXJ4B9+6G
 uht/+h8KxvPZhSXmPo9VBcTRAszpHCl5e0JGykkDJvqp0D5x+42aOhlVX3j8+n9teloYB
 8euC1EZAi/fw1EEFnW2BtyLEjlL4Sa9FZDPR/rKabFn3Sew+fhnyZTggxhxyHwY7BbA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=fail reason="signature verification failed" header.d=ziyao.cc
 header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=dI7s9EFA; 
 arc=fail smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=fail reason="signature verification failed" (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=dI7s9EFA
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30E29811CE
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 11:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790336301; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OejYJQlaKqYr4594KiIsKDTlAwJRl1BRBrSOk9P0phHwzEewG4JNwUBKbhYvqcWYzHHV3a+LykMzwBan6P03D5aT+giWGZFZHf/kdMPA8CgWbzgjUWm+rX5tppKav8/FKrmCwX1ga7R9xyUA3tWegUQa5zxNhsYOlbME4n3BGK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790336301;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=f76cPU+mD8GJdDhtOl2e/7Iki7uo94SOEI9/hQI8dNo=; 
 b=QmvEKugwCWdllVn2kWACMBHCgdQCgNKOMxer++xQg76XciySfwLoQcJ9QjrhCGDxqS8UD8GlPYnbTDc8u5q3t4bUx0DZBLG+qITCmViX9J/RsolNlf/1dtxGJAMC58AAl2ca6zN2ZigQuimRwVBFP8EhZy53OfGrS0J4CMs5RyM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790336301; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=f76cPU+mD8GJdDhtOl2e/7Iki7uo94SOEI9/hQI8dNo=;
 b=dI7s9EFAQHdxmQ8Z9oGESWUaHuiOOQaQesB72h5TeTJ34Fm0dfCPiTmOKq8B4YNW
 cwNSYohqwWDi+gJiFovlvySIh2AySZ9Hzg9s3/Gg28+FwKx77XoEsjfJVeoGaR8oNIo
 MF/cMmqVfRGplRErsFYu8bzMF5jm6E10cTePqOJE=
Received: by smtp.zohomail.com with SMTPS id 1790336299616716.1336292852011;
 Fri, 25 Sep 2026 04:38:19 -0700 (PDT)
Date: Fri, 25 Sep 2026 11:38:03 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] riscv: Fix IPI not initialized in riscv_cpu_setup()
Message-ID: <arZdGzVgm9ZtnSm_@pie>
References: <20260904-fix_skipped_ipi_init-v1-1-3f4e7a10efe8@maquefel.me>
 <972c116f-a430-4ed8-8b94-e4c1982e5f22@amd.com>
 <856f099441f717605de9be5456dde8c97bbd04d1.camel@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <856f099441f717605de9be5456dde8c97bbd04d1.camel@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.314.86
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Fri, Sep 25, 2026 at 01:19:15PM +0300, Nikita Shubin wrote:
> Hi Yao Zi!
> 
> A shy ping on this patch.
> 
> Thanks !

Sorry for the delay.

> On Fri, 2026-09-04 at 08:20 +0200, Michal Simek wrote:
> > 
> > 
> > On 9/4/26 08:07, Nikita Shubin wrote:
> > > If riscv_cpu_setup() is skipped we end up with riscv_init_ipi() not
> > > being called.
> > > 
> > > But we still use riscv_send_ipi() in spl_invoke_opensbi(), so even
> > > if
> > > CONFIG_PHASE_CPU not set we still need init IPI and clear pending
> > > IPIs
> > > on harts.
> > > 
> > > Fixes: d8810e1d4f82 ("riscv: Skip riscv_cpu_setup() when CPU driver
> > > is disabled")
> > > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > > ---
> > >   arch/riscv/cpu/cpu.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> > > index 3bec7c7cb6d..a65e6951384 100644
> > > --- a/arch/riscv/cpu/cpu.c
> > > +++ b/arch/riscv/cpu/cpu.c
> > > @@ -639,7 +639,7 @@ int riscv_cpu_setup(void)
> > >   	struct udevice *dev;
> > >   
> > >   	if (!CONFIG_IS_ENABLED(CPU))
> > > -		return 0;
> > > +		goto init_riscv_ipi;
> > >   
> > >   	uclass_find_first_device(UCLASS_CPU, &dev);
> > >   	if (!dev) {
> > > @@ -687,6 +687,7 @@ int riscv_cpu_setup(void)
> > >   #endif
> > >   	}
> > >   
> > > +init_riscv_ipi:
> > >   #if CONFIG_IS_ENABLED(SMP)
> > >   	ret = riscv_init_ipi();
> > >   	if (ret)
> > > 
> > > ---
> > > base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> > > change-id: 20260904-fix_skipped_ipi_init-aa5575f55bc4
> > > 
> > > Best regards,
> > 
> > There are 2 other approaches how to do it in the code but it is up to
> > maintainer 
> > to decide. No issue from my side to solve it via goto. Obviously one
> > big if 
> > (CONFIG_IS_ENABLED(CPU)) is another one. Or move it to own function.
> > 
> > Anyway
> > Acked-by: Michal Simek <michal.simek@amd.com>

I think it's likely a bad idea to have IPI stuff in riscv_cpu_setup(),
but this fix itself is okay. I should have noticed it when reviewing.

Reviewed-by: Yao Zi <me@ziyao.cc>

However, I'm RISC-V's reviewer instead of maintainer, so I couldn't pick
the patch for you though.

> > Thanks,
> > Michal

Best regards,
Yao Zi
