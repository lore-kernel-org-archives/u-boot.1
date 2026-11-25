Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32941606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bVeBgC81;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=lT6cFdRw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 069B080E71;
	Wed, 25 Nov 2026 17:24:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mf1lXbRi0s6u; Wed, 25 Nov 2026 17:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E5D580DF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795627470;
	b=cp5WQhvuRY5p6vJ2KuKKSRQKIi+eLSe2d1tdrJA5wgS06M3yJF2XYcPweRrTLQr960tl
	 UUz/247p28Edf2Kpy34w79gk0WWeEgxndWxpjeCnap7TSTD++y5V1lsgavDCDP9/+BQ3n
	 AP0+5Aey6uT3gJ26Es4c8Z1OiwkQlHKOr5fN1W3F5iNhWS1b7gEKKoQDTNBgDioQCDAKi
	 /N2NimQYlTh1mPDidzsTQJv+7ZzK2W69GrDyUTEQsXnadQWBt7nbQJ3V/5os5TlXIIbaR
	 HkKzP00lLtG36VJE1oYl4E7bUoM/0cn0JVhhCB/hQufnLG4NodYg2tQQvR/PyGtSokw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795627470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=O9f+9BRPSH1ZUbOTy3ROb6913PwlhHXYGB3IDiExeEE=;
	b=bkahIl8zRC/W/n5FVqr7+FPuK5nN+PIB2viL/+ZrsOWpGaU4b9E/VwygJx6cXxYbZ4z4
	 ll/Y01c700jZZS0BYr8d8ceIAaOEaArwe3N9t1QTLswfLYEyg6fyErUVQa7DrlPaItekS
	 uA0mrKAay6uZblmdh0UxTMdj47xyZVB3/n4e5sO87Bfb7tq50LGvByIrOKSUgbkEvZWQa
	 LzeRw+6/DomXoCMdfI4k2Oo3fiOrrgt++IpDVGodVwoULb4Y2w6UMSqoN7CkFpUCDJeWE
	 xKqmY4UORTAE+xTDLcuBOajnXK4Ii4pexmb1fWSJv92vWeDI3zyuJX6uBfvKD/iSW9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=lT6cFdRw;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795627470;
	bh=O9f+9BRPSH1ZUbOTy3ROb6913PwlhHXYGB3IDiExeEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bVeBgC81AF9g3+wXVpeQOxYCcgvW7f6xE/06T4N7e6KV6YrJGY8f56Vf8o2c/fRAv
	 l66rTucF2ri6KKuPiU8nkNScckNCklBJtGkromdNZ1IlUnxUYDBrZ6hK2UTUFlOmkM
	 efNDPMLFUP7JSgHPWTkPgcTS8uYYrFn9oYtU9/Sku/5VAbM3FAlznljHvvOKVlRdO+
	 caNXHGfFsHj4fxWi1k3allhIOIW37LBvk+EtP+0+WEargdhJYcAXpv51EBD1YeMYQ8
	 3CbE/UGuApYWtf3HG/BsZSnuI1vCvwhQv54h49LSYmM4+HqsD99SxvTRWm15PyA4K1
	 tXLXifWFjholg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E5D580DF8;
	Wed, 25 Nov 2026 17:24:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7710043
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 68A6C80DF8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:24:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUs6_5JFSPnS for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 17:24:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8260780C38
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=lT6cFdRw
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8260780C38
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 17:24:27 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=lT6cFdRwnmnEanYvljmVl2SXlQhWDrDgRYLaEaJ4vjmlgMTdoNMN4bTdC0fMdrocfHEvcsUq5T4NnvgykV8CInHvMqCyeviq78phDpFnczT89CQO+ahmhuGFqxG/Q1MmRXd/zquHfTpB/wtRCzrOVfQjMP0DoG+6h+yGpwitRHk=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=O9f+9BRPSH1ZUbOTy3ROb6913PwlhHXYGB3IDiExeEE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795627436281516.3769754542882;
 Wed, 25 Nov 2026 09:23:56 -0800 (PST)
Date: Wed, 25 Nov 2026 17:23:47 +0000
From: Yao Zi <me@ziyao.cc>
To: Indrek Kruusa <indrek.kruusa@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Han Gao <gaohan@iscas.ac.cn>, Kongyang Liu <seashell11234455@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hiago De Franco <hfranco@baylibre.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Raymond Mao <raymond.mao@riscstar.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] riscv: consolidate the T-Head C9xx cache operations
 and CSRs
Message-ID: <awcZoxsOHvBdex9_@pie>
References: <20261124195237.692679-1-indrek.kruusa@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124195237.692679-1-indrek.kruusa@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.600.19
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 09:52:33PM +0200, Indrek Kruusa wrote:
> This series consolidates the vendor-specific cache operations of the
> T-Head C9xx cores and the machine-mode CSRs those ports use, and
> implements the whole-cache operations.  It is a prerequisite for the
> upcoming Allwinner D1/D1s support.  However, no definitions have been
> added yet that only D1 would use.
> 
> The series adds arch/riscv/include/asm/thead_csr.h, with the CSR numbers
> and bitfields the T-Head ports use today.  It also adds
> arch/riscv/lib/thead_cache.c: the renamed thead_cmo.c, with the enable and
> disable functions taken from arch/riscv/cpu/th1520/cache.c, which is
> removed.

This isn't what I'd expect. I'd prefer to have separate thead_cmo.c and
thead_cache.c, and also separate Kconfig options, where the earlier
defines operations based on XTheadCMO, and the latter implements
machine-mode-only cache management operations through CSR.

A strong reason to separate them is that Xuantie cores with these cache
CSRs available might not use XTheadCMO, iirc Xuantie C908 is such an
example.

[...]

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
