Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7B606A32F
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YX8AUtYo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ZbfkGTt6
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D7D480D87;
	Wed,  4 Nov 2026 04:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UiaAimjPUWda; Wed,  4 Nov 2026 04:36:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DB0980D66
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766968;
	b=OEDihrmgaViIRPV5Fbqit5ziAhFkL0JTw4YaHrL20iNZmNTYN8hG9S16lVgJejd5q34V
	 GPr+nemOzc91TvyskoMFxnCzfo3AhW+2DS08uAVyxXu9SH35TtHbq9GlZAop8nWPoPL9Z
	 o6hRLj0kZ0IhnhImh+d3m/GKfvQagLDdnRpv+pbElzWc9NRGWDDtk7DX+9+xErQCXmkLp
	 elvTRM0jV3Korr+Qb33zh8JsLkZA0Pt3glYDjEZezHfdLAhk9xjUsLLXRpDjS/hOCLqPH
	 zivuiN8tqRaeSY6+Fq2y9zc9/WSl2l5RcDguFnI/sUA1zZSR+7gHTRAGBJp6tpkyUAw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793766968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KnpdFoWRCkxXxHhf2uoEUI9PIO0vBE4w6YWHM+TUnr4=;
	b=bX8gXlvZVnGU2DMgE9fCNOLbWwO5yPkN1bE0JMo9qHJEztlWHft/uuHrMpknPL6DCoo7
	 rA6TLd9CRB9FDdv4U7hirTFEt8GMKSPXpBlCzSdq/WUjtcp8RPQmW2H1xSJHNOFi723JW
	 sci0SLCIayqYGYtCnmv/2to8NvP4P43OkyyFAZACqTWt6We7DPZzN/imC2zruIKEWXEW2
	 yQfeGaTigPOAETB4OuKSpu8mlx65NGnR5SNHXpLi3lQ/c+yY8RHukU900Zt1ruFclfgDF
	 /EZcIHRDBWopUQBmMxcVE7kIRA6roWh/ZduAwoUAH+kXcmPhYmb4dGjKJo//DpSai1Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793766968;
	bh=KnpdFoWRCkxXxHhf2uoEUI9PIO0vBE4w6YWHM+TUnr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YX8AUtYo+anVYefRFf53G56xVW7FVuFXEtmvmCkw90nJAFeQ/X+fyVf99OHmB3Hh/
	 /YN7vrpgp5DivwgdRwFeSQH1m/qyUkuIB4vZkS7tluLzqWZg1SJgAXdsA5QbL4Y6fM
	 i+zhVMjDonKbFZaUdydin06ugKnBnM5VmA1qmS+6EKtsnxenAX+TRU7tEfnNSvaYjV
	 DqxZuzdfaLeTmISCKHLeIqwpTsS5eXI/x4vpPUqh/GxsdJ3iEmqykD5KHCABW+62ec
	 evboj6W/WQpQq60Jtrf9u1dDnKIKhoj0cG17V/X70jmU5UulJgyteTpEWdCn7m059c
	 6F9mV0K1N25ZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DB0980D66;
	Wed,  4 Nov 2026 04:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CE85FA14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B38AA405CF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQxCmgjutjNJ for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:36:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13CE6405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766966;
 b=XPTUdNa8FBzMTOYF0tl62OS/EjVuvYksXyi16cOoooWEFVJ4AahKAy7M84l7iPvOD4+6
 bGcj0UPlbtAgRT+Vtlg5rh9q92/9TvNQQqzLGZWCkjctsgZOkP7nO6Am/Q3uAJNTybsgT
 AipbEmJTiJsNRIq2o54aMNcdpHjAGbKTnSkaxoyL4/rwP1mCgZlkBdfIqoqQVf6qthUPD
 YJ0tOg1HG1HA2tZ11zPlhKkDGeBH46N8bTMajZfw+YzId4y5ZMEPguVNgPjqtduLf9GOW
 2zMo8CVEiNduH6/fs7UGpmZDLI5cmcSYZ1mrmpNjDagT/v84XxCI5v7uYMICQoy4oxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793766966;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=KnpdFoWRCkxXxHhf2uoEUI9PIO0vBE4w6YWHM+TUnr4=;
 b=HWVu+VPDTsu05dRNB8WKUlV/rwJtSxuDx5WKF77pGn1o1bl66Ia7IUSajxnVIc2IC3x6
 Bl5rVC8mXBYUitsHLSeSEeYwTojiivSd0+nxXuetFLWBmg0+0tKp33/m3+w7KuHOJH/vV
 Zju2k3WrOcrW4uW8TVZY0Ck4uQ7pgbvoR338aRIZmfIL+cjUeqTmMqdkywvhZcUivyuz6
 0H/zbCD9xuL+JagRltmY5m0PC6GzlMqcx/Lq/Tyq516txId+RJruYX/vsMLzgSe2sAnC9
 M7P82mcz8NDr//BqzdbHnp2w+kxbADVnGFVyUhBCzFwOuU3LRhQRk8mSQIJyNQVUyxQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ZbfkGTt6; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=ZbfkGTt6
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 13CE6405C6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793766956; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dHoCNVFoOQUuQzmIiCxjQGNpW3cuaPxPcrYxYKW7BnYvHx6/7cM8/EOIf+Ej1jNw2xIr1G+S13TRZM4M1YldFoqLQgkaaHuMg+1xn5g/Ovx603uHHtZVUzkDfseJI9/1yqsWEFZPSk1htc7r8Z9270mt1JQfTJ1P0Vg1Q9QKIW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793766956;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KnpdFoWRCkxXxHhf2uoEUI9PIO0vBE4w6YWHM+TUnr4=; 
 b=YGRDhJPjVjTdgbT/hjElPFnhNcwGnuILJMQReRbs91mdbuDtxqXkrj8W0hCn5tyFdx/72lnrNIo2wZU/+J+pTwKbMYMy+PSWG6kHSGI/L2a8ZDK92OmmBm/SaYSkxVkNZH+UU6KS6HiTA2CVmMRzkBq1j9/4n99U8B01cVbHpB8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=ZbfkGTt6yUjLXHUPPnczG2mBIzZhN/U8KZRmWKro9AQguN+gW+dCQqBDn/T60pEOovGOb3fRLLIw+8sTHFHVpJKJbdgxe/pYKASZEFA24yfkgun6WCatFicgUgAIyekFzs6FKzvLS84bG12POyqkHVs5jeTt3KtCmEKrKTZlunM=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=KnpdFoWRCkxXxHhf2uoEUI9PIO0vBE4w6YWHM+TUnr4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793766954238910.0234533773223;
 Tue, 3 Nov 2026 20:35:54 -0800 (PST)
Date: Wed, 4 Nov 2026 04:35:49 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 07/20] LoongArch: lib: General routines
Message-ID: <auq2JfDtb2gR72Lk@pie>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-8-me@ziyao.cc>
 <CAFLszThRv0=yGbu+bf_uYPjv0aGME80upMX41kbSaQ41qPfzFg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThRv0=yGbu+bf_uYPjv0aGME80upMX41kbSaQ41qPfzFg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/293.744.82
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

On Sat, Oct 31, 2026 at 01:43:10AM -0700, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: lib: General routines
> >
> > Add cache probing through CPUCFG, cache operations, setjmp()/longjump(),
> > and etc. for the architecture.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> >  arch/loongarch/include/asm/cache.h       |  11 +-
> >  arch/loongarch/include/asm/global_data.h |   7 +
> >  arch/loongarch/lib/Makefile              |   7 +
> >  arch/loongarch/lib/asm-offsets.c         |  66 +++++++++
> >  arch/loongarch/lib/boot.c                |  14 ++
> >  arch/loongarch/lib/cache.c               | 235 +++++++++++++++++++++++++++++++
> >  arch/loongarch/lib/reset.c               |  14 ++
> >  arch/loongarch/lib/setjmp.S              |  52 +++++++
> >  8 files changed, 405 insertions(+), 1 deletion(-)
> 
> > diff --git a/arch/loongarch/include/asm/cache.h b/arch/loongarch/include/asm/cache.h
> > @@ -15,6 +17,13 @@ void cache_flush(void);
> > +#define CACHE_MAX_LEVEL		3
> > +#define CACHE_MAX_INDEX		6
> 
> Please can you add a short comment to these, saying that the first is
> the number of dcache levels tracked and the second is the number of
> cache IDs that CACOP can encode?

Sure.

> > diff --git a/arch/loongarch/lib/setjmp.S b/arch/loongarch/lib/setjmp.S
> > @@ -0,0 +1,52 @@
> > +ENTRY(setjmp)
> > +	LONG_S		s0, a0, 0
> > +	LONG_S 		s1, a0, (1 * LONGSIZE)
> 
> There is still a stray space after LONG_S here, and after LONG_L in
> longjmp() too.

I'll clean it up.

> In any case:
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

Regards,
Yao Zi
