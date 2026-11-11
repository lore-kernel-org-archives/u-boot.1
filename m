Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3B606A8A4
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OFVhV7A2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=emabPg5m
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8A9C811E0;
	Wed, 11 Nov 2026 15:50:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fRrtp-PHNZS; Wed, 11 Nov 2026 15:50:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C287A81175
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794412208;
	b=RYtVlOSD+fAfodSnBY5WBeCReqWK9eYB+nKv4EwtOib//wvAkHojlnfGbmmyitj7n6yY
	 9w8B6vbYvAIboKHamgJWdOSwuiy/6aHQKBLAE38uPN1ZEjUhCLw/Evei0rRWo4VtQ0Yho
	 TWl39DZmlMJzQtKqtpOaZ4TlrTrSqdwqosbfyQvLi2t9nx9O6PXsYWOWtJ12fd7XvB9FY
	 NE7ifRBcakWDHh16/fz5RGtgHX03u+YEkHj1/GBaS5OzRaWoMg8fNrCd9Sa0Gyya0+DdO
	 tcmi/2P9SCj0qjGDVloEOLFeCgGVJrFM0E3dPyXW03iuPcSPv9W9PFEmhuP1diyxByg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794412208;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uLrdizOh8Ga80svUO0fMn747KPYzAluGYnLgh53pWCw=;
	b=pjCq159lBCW1G45Zo3CXFjodHALWFgGasc1n4N7/K+jV90fTHgLyWwbc3+JriGAqlPFZ
	 01fxek+raSEnoTbDt8M6kBhEeyxDZVind0vSQxXlYm7t5bQ173nQ2901sGPl1VNtNOk/z
	 V0QyAPIQ/ilXK2pdSRHcCE4vq6qafu/inKnwmgpSpYe4CZjdLn+jqWOLrV/gVIZlOnpUL
	 Nqiu5WGzVCh1NGt1IeidcJJVpKCQbv2vTw0IhsH22RFLQ7iBI9qlts51CAseeTQCsdILE
	 3kwV9ewKOFMnUxpO/dkm6JNqWupk7xO3bD/CM7oZH+/hAVoksrEpD6UosgjN+cDUO5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794412208;
	bh=uLrdizOh8Ga80svUO0fMn747KPYzAluGYnLgh53pWCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OFVhV7A2IWuPn9iG9zlYDQ2Ft7XizYw6UqvPEO5RgXLlMSFYYu+vG9E9TziE+VgBc
	 dPI0EXpoYPVRYnMhXgCmxryawgEN6Ei0DFXmjy56qX9yTbbNWZtAmZquhnLbHZmZqj
	 pMsbTkcX6PZC2u6oYyR7m382vGHp4+5yuWmOT/H8aLMh3qaUsXxzkzUa+hH4IvIy82
	 NVARS9oLiWXqh/X0fMtMSpkdh4WhQGUuQuz+4F9ak9GmqFuSk+eCO+aCkwioSOv8RB
	 nUOX8U64g4LuJz4GcgTTgcEhOgOW04bpvPrvDQoGSCOvB2jL9sHXwNk0+aHtBq2wPs
	 Q2Ff/04tbXdYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C287A81175;
	Wed, 11 Nov 2026 15:50:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C0212FE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:50:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D5874016D
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:50:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6PWWzT7NejI for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 15:50:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 13CA84006F
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.12;
 helo=sender5-op-o12.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=emabPg5m
Received: from sender5-op-o12.zoho.com (sender5-op-o12.zoho.com
 [165.173.182.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13CA84006F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 15:50:05 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=emabPg5mLY/PHdELCY2YcHNlRmQqEeNXbCS32uOAt4Jb1I39wQZXLbvhZi8XF9bz96GfLQ/3is/niBi9wy/k9+xXwmmXIvevIz11/8z6y96ABQFQ0/NjdmVXmdi6AEin6t3nAdn4abq9Wy6k+bquu3OR2K3CGNLvFCvIt5ttgxg=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=uLrdizOh8Ga80svUO0fMn747KPYzAluGYnLgh53pWCw=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794412200198368.85359209548756; 
 Wed, 11 Nov 2026 07:50:00 -0800 (PST)
Date: Wed, 11 Nov 2026 15:49:52 +0000
From: Yao Zi <me@ziyao.cc>
To: Martin Husemann <martin@NetBSD.org>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: RiscV SBI incompatibilities?
Message-ID: <avSOoJFxsR6hDuUd@pie>
References: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avR9RCMQHL8TZIAR@big-apple.aprisoft.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.403.76
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 03:35:48PM +0100, Martin Husemann wrote:
> Hi folks,
> 
> maybe I tried something stupid, but it felt like a good idea at first.
> 
> I am updating my VisionFive 2 board from an oldish installation with
> U-Boot 2024.10.
> 
> To have as few moving parts as possible, I build 2026.10 with the same SBI
> that I had lying around from the original 2024.10 build, which happend
> to be OpenSBI 1.4.
> 
> This failed spectacularily: most sbc_* calls for HSM fail with 
> -3 (SBI_ERR_INVALID_PARAM).
> 
> A few calls worked, like sbi_hart_start() and sbi_hart_get_status(),
> which told me the hartids I was using were valid, but then doing
> e.g. sbi_send_ipi() or sbi_remote_sfence_vma() failed.
> 
> Does this ring a bell? Is it expected? Did I overlook a "minimal SBI version
> 1.X" somewhere?

doc/board/starfive/jh7110_common.rst says,

> 3.  U-Boot for JH-7110 requires OpenSBI v1.5+ generic platform object
>     fw_dynamic.bin to be included in the Flattened Image Tree blob. OpenSBI may
>     first be built as below:

I had a brief look through the changes from v1.4 to v1.5, and suspect it
has something to do with OpenSBI commit c5be0e1ed1fa ("lib: utils/ipi:
Skip initialize ipi when dt is not enabled")[1], but don't confirm it :)

> Martin

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://github.com/riscv-software-src/opensbi/commit/c5be0e1ed1fa17b9f9abb49e80db014e067523e4
