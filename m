Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58851C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 11:28:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0336960686;
	Sat, 25 Jul 2026 11:28:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqZLcqqTfnpL; Sat, 25 Jul 2026 11:28:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03DE560664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784978924;
	bh=QB++/WX9Q8U3V2GbtTrTDwGgU6Bqjp2unR3JJg/o/PQ=;
	h=Date:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pe9vGDs20FU3MZt5h/zWWB8WgfBwMqeY7C1FsdkO/L/0pcgyL0cjG9Vx/nq7+6YpF
	 Tuyfe22MXapQuXLxOtYUbIYDE6SltfKZCtIEPV+u5Ut1CijguP3Xn3KxL+oHj+WcuD
	 rRdSl8oqp2RSC0zYOYtK2YULNYBeMxNh3ndg3+x8M7sYsZMRwoY+MfpciHxm7V6tTP
	 F+aG8hnoVV/D+w9F9wJwD86sXJiu3v7Ao37eRhB6VcXMmcGiGmeHej0/BNma3FdTY/
	 tFEnWrbUEOgMjLTOICZoxGsVsxG/QdCVO2gXV1ZMgt3m81JDng+EW9gjzivn4ZMDXc
	 KF6NJOYt144aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03DE560664;
	Sat, 25 Jul 2026 11:28:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8839B39E
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 662AD409F8
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hXYFS6vtvAtl for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 11:28:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mark.kettenis@xs4all.nl; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9C207409BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C207409BE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C207409BE
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 11:28:39 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DE6800AE; Sat, 25 Jul 2026 13:28:36 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C18708005D
 for <u-boot@lists.denx.de>; Sat, 25 Jul 2026 13:28:34 +0200 (CEST)
X-KPN-MessageId: f7673309-881b-11f1-8f54-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f7673309-881b-11f1-8f54-005056992ed3;
 Sat, 25 Jul 2026 13:28:32 +0200 (CEST)
X-KPN-MID: 33|DtlcFR13ux4UjxEHDSLRLFKgigpoeYRdViSliC9tCFztFjRJfLiRvTxmTCAyJY8
 M6XHNMvGw4N8jQtvoJt0m+oedrgCHFuyxgl4cEeofcB8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Acazk5yR9ay5Xs8WeDkTBgUS6CxLmR1NFsoIezv4KuSLu/Ur7GmMe9zlRem8Mz0
 pMEMj+GONXbxyyqosPWAJNA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id f6c8f794-881b-11f1-a789-00505699772e;
 Sat, 25 Jul 2026 13:28:32 +0200 (CEST)
Date: Sat, 25 Jul 2026 13:28:30 +0200
Message-Id: <87se57s3z5.fsf@bloch.sibelius.xs4all.nl>
To: Leo Liang <leo.liang@sifive.com>
Cc: charles.perry@microchip.com, u-boot@lists.denx.de,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 mchitale@ventanamicro.com, u-boot@lists.u-boot-project.org
In-Reply-To: <amSS9gMuX1EThezO@lliang-1876.localdomain> (message from Leo
 Liang via U-Boot on Sat, 25 Jul 2026 18:41:58 +0800)
Subject: Re: [PATCH] riscv: remove log_debug() in enable_caches()
References: <20260622194308.70639-1-charles.perry@microchip.com>
 <amSS9gMuX1EThezO@lliang-1876.localdomain>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=QB++/WX9Q8U3V2GbtTrTDwGgU6Bqjp2unR3JJg/o/PQ=;
 b=crjGOd0O2pBLFSopBoNm7e+PhSw2BDNET8GOvYwlRQKGlq/Ezbh54JvWfkYymMT4hi87FKu0lE1iC
 VrguYXHGK0EIWObfXGmNaOPsogUQr84gqf/X4t8baLkLRj8WVwrm9U4MvJOukVg/Hi7x8NwqhfF3JL
 aLDnv7eazOKjZWr+SWcCHfwbl/xWV0aEwi8uS8MlCOHNFtVMAPN+7SRQlnTYSPzNR9YUABhG7nK8xD
 36AziN62BXkfHVzLJqSHzhC4TWEBnBfgzsTkdRVxZeXFcPD4d9zsofWMSYYEppp+kn1B2rOON4Yrfy
 JGb9UBdQQYEaKWjg9nNe95uQS9Q4btQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=xs4all.nl
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=crjGOd0O
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=xs4all.nl
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mark.kettenis@xs4all.nl
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="crjGOd0O"; 
 dkim-atps=neutral
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
From: Mark Kettenis via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mark Kettenis <mark.kettenis@xs4all.nl>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

> Date: Sat, 25 Jul 2026 18:41:58 +0800
> From: Leo Liang via U-Boot <u-boot@lists.u-boot-project.org>

Sorry I didn't spot it before but...

> On Mon, Jun 22, 2026 at 12:43:07PM -0700, Charles Perry wrote:
> > log_debug() cannot be used before log_init() has been called. Remove the
> > log_debug() statement in enable_caches() since it is called after
> > log_init() in initcall_run_r().

This part of the commit message contradicts itself.  Should "after" in
the second sentence be "before"?

> > 
> > This fixes a bug where a RISC-V system which does not have the "zicbom"
> > extension (such as PIC64-HPSC/HX) would get lost in an infinite loop in
> > log_dispatch().
> > 
> > Fixes: 9e859849e2ca ("riscv: cache: Add CBO instructions")
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> >  arch/riscv/lib/cache.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Applied to u-boot-riscv/main, thanks.
> 
> Reviewed-by: Leo Yu-Chi Liang <leo.liang@sifive.com>
> 
> Best regards,
> Leo
> 
