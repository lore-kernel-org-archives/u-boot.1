Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B6606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VptDZ4K2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=VcUXkpNt
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 856E540A49;
	Thu, 19 Nov 2026 12:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fI5bQ-snG1Y3; Thu, 19 Nov 2026 12:09:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F845407E2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795090149;
	b=c2Vr34bMDdyoKVgCWsnleRgBVE6PcgsLlOVjYHQuRlMrEcFrGIVsXkGi0EUXGIDLTpLo
	 T+9Y+NC/TX4xv9I93ft+8pSX+vAVzFvnRdqfF4g50tMx+0MVmUG8cABjMQ1TvKqBNNDqZ
	 i8S2ceqY91g0gTr9BF6BXYN/5OlhNiW5DbIYTawIS2w1flJZopOQUhsa1iVUxR2zXLnZh
	 oNprszOv2m8iB4SRibBitw/y/Albm6amOzmBPygyyl0WZli8jioL+GrCXoMfWFXcHrEGT
	 PlhQqi035OWL9gEnD37zH3CdQvvBHbhtqp6E+02RK4hJ+GcmZ/XgyiHbnqt1YtrOfzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795090149;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GZEORa/jBKV8MSiTZfdm3gkg3f9LzuX2fIUlZyFBv+o=;
	b=CNmJCLKc87BO6WXxoS6njoFwoJ8JGqtzIl71r7lGsdwk2oppGwMx0peGcpm+w/diHu1h
	 u16wboQ8YMR6BDx3T4Q4hy++d5Zg2K92+rnyMKGHTlrzr2ZGmgn2FgjV67j0XtVDYW1Ca
	 KzTWlS2NU1WCwOftoAx4UoFy/2H2tPZqZe87bd7+3ZDy91sm4mC4TvIbNk1Pl1j1xdeRO
	 vNNkW/YoUcVEvcYk5YV8uzux0s0rZpEwcA+6H7fN6pdV+yd2Ppbgafk7xVk9IJiBoeCe+
	 3Aq398Z9dR2eh31PORMpTqJ483KD6j9PsUyn+SkBl8iE+mCNe7qDYep5VPX4mkaXmug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795090149;
	bh=GZEORa/jBKV8MSiTZfdm3gkg3f9LzuX2fIUlZyFBv+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VptDZ4K2+QTcFd/xxK20qhmSjVa8Nwxq/yXh6wh2X3SbarsvasXmjpAV860UtVjNU
	 Gv/LAzHRvfwCJbQdodQrq2owwPkJAVrFE6WkJwNSdID2O0T+XcWhMrji60rlYOtP0T
	 De2/A7oJnTNPVaz8RKY5VS5ycx546jvHOY1GIE9GOdixFf90Ylp18PPQG/lHTaIBf0
	 jSTLXHd3vLmdWrcX4DRebXtepxRF7CDQfjfCE5gKUfYOOfIyn4/qTGejPO/j9zg54S
	 Bf5ZO1P21W+H1yumjvfgR6orAVF92+iOKSRX5eF4J5HFrWvvISNOEvqgyil0ERhGyO
	 BaY3mmlGjNoLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F845407E2;
	Thu, 19 Nov 2026 12:09:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37311A32
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1DCD960D56
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAhfB_dpb06J for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 12:09:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 368C860D53
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=VcUXkpNt
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 368C860D53
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 12:09:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=VcUXkpNtyhKfVDPZ9Jz6N+UK/KKpV/4epkRiD1E/uY7zhe7KpL33etElqbykXKlITxz6mg7OwLxY77ZLjFet5zvrBPfXZYaVmStstPlEUCAZEjnlWYNypziUM3PBDjipzD5DSIyEbWQz1HYftALnc68YDUjPmr4XobkxztpWAwI=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=GZEORa/jBKV8MSiTZfdm3gkg3f9LzuX2fIUlZyFBv+o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795090106098416.3680934739531;
 Thu, 19 Nov 2026 04:08:26 -0800 (PST)
Date: Thu, 19 Nov 2026 12:08:15 +0000
From: Yao Zi <me@ziyao.cc>
To: E Shattow <e@freeshell.de>, Zhouqi Jiang <luojia@rustsbi.com>,
 u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, tim609@andestech.com, leo.liang@sifive.com,
 me@ziyao.cc, sjg@chromium.org, alpernebiyasak@gmail.com,
 jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Maslowski <info@orangecms.org>
Subject: Re: [PATCH v2 1/3] riscv: Describe SBI_V02 in terms of the SBI version
Message-ID: <av7mr8AQaxVDQBmW@pie>
References: <2744044E69DD25E5+20261115143808.1812787-1-luojia@rustsbi.com>
 <20261119091842.3062208-1-luojia@rustsbi.com>
 <C333C8B0E169374B+20261119091842.3062208-2-luojia@rustsbi.com>
 <3a1eb830-1a49-4c24-b8c6-b63abbeb722f@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a1eb830-1a49-4c24-b8c6-b63abbeb722f@freeshell.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.87.94
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 02:43:12AM -0800, E Shattow wrote:
> Hi Zhougi,
> 
> On 11/19/26 01:18, Zhouqi Jiang wrote:
> > Describe SBI_V02 by the SBI version it requires so the help applies
> > to any SBI firmware implementing v0.2 or later.
> > 
> > Signed-off-by: Zhouqi Jiang <luojia@rustsbi.com>
> > ---
> > Changes in v2:
> > - Split the SBI_V02 help update into a standalone patch.
> > 
> >  arch/riscv/Kconfig | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 386241efd4a..0edf0247983 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -476,8 +476,7 @@ config SBI_V02
> >  	  single hart needs to boot and enter the operating system. The booting
> >  	  hart can bring up secondary harts one by one afterwards.
> >  
> > -	  Choose this option if OpenSBI release v0.7 or above is used together
> > -	  with U-Boot.
> > +	  Choose this option if the SBI firmware implements SBI v0.2 or later.
> 
> SBI is not necessarily firmware in that sense.
> 
> "Choose this option if a RISC-V Supervisor Binary Interface
> Specification v0.2-or-later conformant implementation is used together
> with U-Boot. For example, OpenSBI release v0.7 or above."

I'll second the idea of keeping OpenSBI-related stuff here for more
users to benefit. But also, most users don't care the full form of
"SBI". So let's say

> Choose this option if the SBI implementation used with U-Boot conforms
> to RISC-V SBI specification v0.2 or later.

One really interested in what SBI is could easily find its meaning by
searching the web.

> Most users do not know or care about the specification. However if you
> want this to be applicable to all OpenSBI compatible implementations at
> this specific level of compatibility then we should mention it in terms
> of OpenSBI or else it becomes very confusing to see OPENSBI= in
> documentation.
> 
> [..]
> 
> -E

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
