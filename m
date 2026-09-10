Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B85C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 04:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37E57607FA;
	Thu, 10 Sep 2026 04:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oxCagHhgx_nm; Thu, 10 Sep 2026 04:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 744F0607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789013659;
	b=A65GDRB24FTdHET7k4SNNyO7xsc3QMUl0KwzCDcbhEneBHbEjCB7X0Flw9h+qOJHVW0T
	 z4hpbRhb8WlDE+DLQLS6VURiJrnIjI/WQ6/eJvmb9O+xeJm4YPrQu06XNRSgloIyKCt3X
	 14sn/okDQvRxyTJ1bGcKT2EqpaAYprBppTvtN4Q1QZFe0s8as5jeqAZbXrUS5SgYFRNmb
	 WzNonY+hkPHmsed4WjHeaWbASnwHwYCPrS+sxpR3JYpAWsJUhJgVqZblMyeimLxmlfyIs
	 hAUSqq/uHj5S0+vBwqRqq9uVvAWr4Bp8yl0EFNiweYHF5kLu2g4HPB8Jb/4C3Hl+Yng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789013659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W5rzqZrVPLDFiBQonimftgO1n8fzP5ApBJM6wOLjP7c=;
	b=KsgFq+xtkyDrW4R2iQqhZ3RzPl5izpJj4EnkQNEheBGBA7q9/pa8Y1r5cSPF7B8W7EiP
	 xYPwheeuIiaqSBzwzyYWyzeb5pLxtYCQ2zNSTbpjvbgTLDdtFRE4lzQu05sjn8S0V4njZ
	 TIo+Pq+A2fhTd5Go7B44DfEETIaKCT3hJ2qUHrpBy6QrrS0cdzNKXnoHX0JWkeMULfmRt
	 eKwsQiCgYJuWVCSPmKiUL4CJXUE5/hKOic8I1kcf5zIqZmcId2zI+ILRyH+vEWq2Re7ov
	 spjzwR7W438zkQ/ltMCwutn2hu/6n/eNKGk8pHKvWtXvbyLRg4/v4oBUkHmLTzmR+hA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789013659;
	bh=W5rzqZrVPLDFiBQonimftgO1n8fzP5ApBJM6wOLjP7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vCPJ1BUkyuGpDwzXNSd1oCyIR+pKtbh7BlKcxRUlJpM+wPyUbL3HTM0Z0RtcMGFqw
	 vyc3e4E0U7Uj09/kArAm8DldkgOZKc8O77C9SemhKswwRURdNicNZQAON0mi7WUuJa
	 r0dSkxIED4kc3qb8vLZQ+5ZEgDD3p+5028lqXywFa1928JCJsCS+swPCHSYG7iRGhu
	 Vm5NX7agG+NefvdiQUSD+OMSwZRLTL720Qale1QKxes6aAjol8oU38wJG8k6BP/7yu
	 hA8wfZ1mW2WUJmEmmT9IZEL/GVuYPlZCL/21LVUnrPX+J3FdlWXiRHqLewss23azBL
	 few6IpeyjZ+OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 744F0607C4;
	Thu, 10 Sep 2026 04:14:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED7B93AF
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF6344007E
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:14:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXDdClxM_37s for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 04:14:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0EA614005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789013657;
 b=RfWZy1DMqX51mxuOX4mQC9LIrswjPaMX2LkwBtm+YItG7lqHuHxtLxR9Gv2BasnCasyz
 7tvxUCc2sGyJ/6n+qsm5QQDmr72VknPv6QUgkgedrZcgQgLyE36DS4re5hwuSNsSqynvK
 IW7GhKNnCgmYeZhnjfP3ukmA+fI9iP7+igWeJDYDAvk2gp2SI3KDcLcm7j2fIpzHLHEE/
 LUSLdTH/YpyXrCljfxi7JAefTFBrKXEWPwQy7fcWqb1eP2AvlmnGtIRLesSWyjjok1TOV
 up1rfuP6iJvrWK+ZbjD4rlm1GVFmDcnPyjvG3hEOoCq2/E26UIH8fGkKIVFpESXK3aA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789013657;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=W5rzqZrVPLDFiBQonimftgO1n8fzP5ApBJM6wOLjP7c=;
 b=sRHE9ovecLMYbWrm9cb7SFaCKYm8cxcVZmsAoYhnh5Me88vvzqhxFpCxgrgIx3rBUPSI
 SwOKumJN3DH8D5GewiDvF7L4p9YZRABUkHkoAN0RwP9Pgt+ud8liRdIhKs3NDZpPMxoIO
 oUb0D+jcp6HCSPq3ZK9GAySwr+oPkP82IFaKKQsG/e8gcsqGsqt/T0zxD22iZP8Pg1Mp6
 qyd3tvLgjRFxY47eTdXxta8FR2jyvNapR1eQpLCif2qCApI8dJozo8LgbXjiUzJwa6Sv4
 6+nIFEuujhqmJZz4Aj2CxncRRJhe9+RkgB/RtQ4Fe7jSpoUUBrKZ6CRr16hx24s5Lrw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=HZYa2gwf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=HZYa2gwf
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EA614005A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 04:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789013645; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VMmp4IvnaIdPUBbqcBLDuumDnPDIfsQpBj0TiyKf42c1lSxBmEkBkQi1IGu4R2jnBWT32ZOU8pMLH2YSU2ms8nDzIFop6KZSTPehv+SzkuXu417IwXUIGGh6PzX9bZWTmhP58FLw0pIMQLajAF1R8uNucOPgi1lwe5/NIh+F+Us=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789013645;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=W5rzqZrVPLDFiBQonimftgO1n8fzP5ApBJM6wOLjP7c=; 
 b=bGwQhRHemckIeouuB4JvoFG7ckCWylMd3RFsbSSPekSExeZ/3JXN+hu1sv1jooye3ryfccelHH8cdwskSlANxjoivWnvabGFKQHZf2gdhlv8jE1p42R8iROYOXfRXfDxaliKknS9hVPI6seOthXt9ZbhetBrWABkVEgsaEyylNI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789013645; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=W5rzqZrVPLDFiBQonimftgO1n8fzP5ApBJM6wOLjP7c=;
 b=HZYa2gwfvbVVdsgfOw3aZn4wU1nNIcRK0DoxXRKLjmLzQ8goL4J7vGX+SiQxBziT
 icXh3yOxI0/wcpEVxR2DP+H9ShaOz9SxMDUplTm8GG7sG5BapsIgaP7q7Z/oImsr4fT
 QY2PZNfwoCELEBTtXB+2DPhkqSKufOJhTDIiGJlQ=
Received: by mx.zohomail.com with SMTPS id 17890136418856.110017045403424;
 Wed, 9 Sep 2026 21:14:01 -0700 (PDT)
Date: Thu, 10 Sep 2026 04:13:30 +0000
From: Yao Zi <me@ziyao.cc>
To: Nikita Shubin <nikita.shubin@maquefel.me>, u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 2/2] riscv: timer: Make RISCV_TIMER definitions weak
Message-ID: <aqIuasUoIlSaQX6L@pie>
References: <20260909-riscv_fix_early_timer_mmode-v2-0-563bff2a50c5@maquefel.me>
 <20260909-riscv_fix_early_timer_mmode-v2-2-563bff2a50c5@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-riscv_fix_early_timer_mmode-v2-2-563bff2a50c5@maquefel.me>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.6.0
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

On Wed, Sep 09, 2026 at 09:31:00AM +0300, Nikita Shubin wrote:
> Mark timer_early_get_rate() and timer_early_get_count()
> as __weak to avoid link conflict with other drivers
> (e.g., ACLINT MTIMER) that also provide this function
> when both are enabled.

So with only the first patch applied, building of
starfive_visionfive2_defconfig is still broken, isn't it? IOW this
breaks bisectability and should be avoided.

Best regards,
Yao Zi
