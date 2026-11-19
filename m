Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2788606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 11:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qg2oOgQG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=eAHY4JB4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A630D40A71;
	Thu, 19 Nov 2026 11:42:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W3JA98Rjwhih; Thu, 19 Nov 2026 11:42:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6311C40A6A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795088574;
	b=qHeSSyGQIR6+Vn75xgRRiy2C0Xs7gFYql1ZpAdhqg7oiVC1ioYeq2NAOt5FpE6D/BXK3
	 wYyTfDFFm+dobJtIJjxybGgQ1o5ylbOtOIETO+rFNRE4MNpztRpKhqn0fN8Po82dVBNL8
	 TFx44KzZIwYFun0oKqDFXRpWkUNjqFdqTTFiy95rvjLJhhYCfzxoehPfOrEKI2r1F89T5
	 qfJSs6M1KM+KPI+1zio3y0h18jteM5/xNp7c5myUf0fUu8SvFbaS23NvJG5DyXql0I5Mm
	 N2AlqlCW1eQdtc2KHt9zmknbmLR0sK2KU7hYFnPy9/WsAtxAWadHyfIBtTzW2+RNqqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795088574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E9zKL5MvMUc1PRIsW1MREaLsrxuYSNZQk4Yp6EkhwV0=;
	b=qR28O65NtgXD3GO+rbwwMTvCUsXHQMOvQK4m1S+QsfeQJbQ9EdXFIIFQ4/2mlPfobvcQ
	 YP0QTC7MOvoUhw4t1vzakUtUOT97u3jCKnYew9O7qPADeD7RnuYvlsKyVUpKtPp8F8G4U
	 oZqjOuxT3/MfFd6AU4gwLeilazyM9VwoKt+/HgT8gCdXR2GRm9gcFYc6v6SbW/VDsmxqO
	 QxBZ6uejga1fTTcNQ6w0KA4ebkciCEXKSkBDzQogjdOSQ6yL5jjxEsMdI1LN83tpyJNpK
	 vfT5rvKn14Mw3U5oL+SvuxzskkIowO58cMcDSzc5Ahn4NvwYA7UikYIMi0VncUdr4dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795088574;
	bh=E9zKL5MvMUc1PRIsW1MREaLsrxuYSNZQk4Yp6EkhwV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qg2oOgQGF6ukkD6aDhPEJK+UYIuaTKZTs0bzzvZNXrnumw3julhGV1rRHrpnMIPEA
	 bVI0Zec/bBocbrE11ullmb+B+NvlN+pzl4iOur9QfxxScbrqmBV2pXxZwwcPk88qOz
	 pSDjG8W7XXf54ai5G1r0K5jMPiOmzDXJWZmVxB8DfDewsyKCMIefsskkfE3AYaN2Nk
	 r0YKiRrow5/lhiF0nHk0xNl5IZCMs7E9MG8ZeK2rh10O3LooETAIjidvXDp3wzL1aO
	 fyc8Sbr6Jl799q5gWMERVrOFeMpTe94GGk0PO23SQaC7U60sVoo44eWZ4LpS5QNSe/
	 p7gbyTwq2Qw0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6311C40A6A;
	Thu, 19 Nov 2026 11:42:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D2071E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0316F60D56
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:42:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9EjnbijheGeO for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 11:42:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 933EA60AE4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=eAHY4JB4
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 933EA60AE4
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 11:42:50 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=eAHY4JB4a43he+MBHslzh92E6wSeZJ05svH4cWhPD6DGaMsm0FGc8RVyv+qrASeeI+c8NmYo2clkgPkLkzE/w0+wOXTiY3BL1VrrN/aaZtxbQIUhoMsvh4UgCIqPElSbEtLpBU//E2HcikHZogfuFwxKI8a4oOhdh6VJPQBSeKY=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=E9zKL5MvMUc1PRIsW1MREaLsrxuYSNZQk4Yp6EkhwV0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795088541830251.98915415293357; 
 Thu, 19 Nov 2026 03:42:21 -0800 (PST)
Date: Thu, 19 Nov 2026 11:41:59 +0000
From: Yao Zi <me@ziyao.cc>
To: Zhouqi Jiang <luojia@rustsbi.com>, Yao Zi <me@ziyao.cc>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com,
 tim609@andestech.com, leo.liang@sifive.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, jiangzhouqi2025@iscas.ac.cn, plucky@rustsbi.com
Subject: Re: [PATCH] riscv: Add RustSBI firmware support
Message-ID: <av7gh5SblUm5WYA1@pie>
References: <avr-_7CNcFit18nw@pie>
 <1388F640AFD6F7C7+20261116151554.2375371-3-luojia@rustsbi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1388F640AFD6F7C7+20261116151554.2375371-3-luojia@rustsbi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.64.54
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:15:56PM +0800, Zhouqi Jiang wrote:
> Hi Ziyao,
> 
> > Please quote the context on reply, so the mail is easier to read. I'm
> > adding Tom's comment back here.
> 
> Thanks, and sorry I omitted the context in my previous reply.
> 
> > > > To be clear, I think all of the changes to make things more clearly
> > > > generic here are good. At first read, it looks like aside from display
> > > > strings and a different scratch options value, RustSBI and OpenSBI are
> > > > interchangeable as far as U-Boot is concerned? If so, I'd like to
> > > > explore continuing down that path more.
> >
> > On Mon, Nov 16, 2026 at 01:42:33PM +0800, Zhouqi Jiang wrote:
> > > Thanks. You are right: RustSBI and OpenSBI are interchangeable here because
> > > RustSBI implements OpenSBI's FW_DYNAMIC handoff protocol. This reflects
> > > ecosystem compatibility rather than a formal RISC-V standard for
> > > inter-firmware handoff.
> >
> > So if RustSBI could be supported through OpenSBI's handoff protocol, why
> > not simply keep the current OpenSBI stuff as-is, only replace the
> > fw_dynamic.bin with RustSBI's binary?
> >
> > From the view of this patch, I don't see any improvements by separating
> > RustSBI stuff out for the current situation.
> 
> I agree. For v2, I will remove the separate SPL_RUSTSBI option and use the
> existing FW_DYNAMIC handoff. The current draft keeps RUSTSBI= as an alias
> for OPENSBI=; both use the same FIT entry and handoff. Would that alias be
> useful, or would you prefer using OPENSBI= for both?

I prefer to keep using OPENSBI=.

> > > I initially considered merging the tags, but I now prefer to keep
> > > SPL_OPENSBI and SPL_RUSTSBI separate while moving the shared handoff code into
> > > a common path. This keeps firmware-specific details, such as scratch options,
> > > explicit and leaves room for other SBI implementations.
> >
> > However, scratch options could be modified through Kconfig options
> > easily. Even with a separate Kconfig option introduced, others still
> > need to alternate it to use RustSBI-compatible scratch options.
> >
> > So I think, like what I have said before, a documentation to explain
> > support status of different SBI implementations, and
> > SPL_OPENSBI_SCRATCH_OPTIONS' effects on them, might be more appropriate.
> 
> Agreed. I have documented the supported implementations, firmware input and
> scratch options in the RISC-V architecture documentation.
> 
> In your earlier review of the original patch [1], you also wrote:
> 
> > These changes should be defnitely split into separate commits, since
> > they're related to too many different components (riscv, boot flow, spl
> > loaders, binman, and doc).
> 
> > > @@ -476,8 +476,7 @@ config SBI_V02
> > > -	  Choose this option if OpenSBI release v0.7 or above is used together
> > > -	  with U-Boot.
> > > +	  Choose this option if the SBI firmware implements SBI v0.2 or later.
> >
> > This change itself looks like a good clean-up, and could be accepted
> > independently with RustSBI support. Please split it into a separate
> > commit.
> 
> I plan to split v2 into three patches:
> 
> 1. Make the SBI_V02 Kconfig help text generic.

Makes sense.

> 2. Add the RUSTSBI= firmware input alias, binman test and missing-blob help.

Whoever, the code would be largely identical to the OpenSBI handling,
no? This is one of the reasons I dislike the idea.

> 3. Document SBI firmware support and scratch options in the RISC-V
>    architecture documentation and SPL Kconfig help.

The documentation itself should probably not stay in SPL Kconfig help
text. You could inform the reader to refer to something in doc/ instead.

> > We should probably not cover every possible SBI implementations in a
> > board-specific documentation. A better option might be explaining the
> > support status of different SBI implementations in RISC-V-specific doc
> > doc/arch/riscv.rst, and keep all the board-level ones as-is.
> 
> Agreed. I have kept the board documentation unchanged and moved the
> firmware information to doc/arch/riscv.rst.
> 
> One point I'd appreciate your and Tom's thoughts on: the existing FIT
> description and SPL debug message say OpenSBI even when the binary is
> RustSBI, although the U-Boot "sbi" command can identify the implementation
> at runtime. Would carrying a firmware name for display be useful, or should
> the existing labels remain as they are?

I prefer to keep them as-is.

> [1] https://lore.kernel.org/all/avr68Io04mE4YFs-@pie/
> 
> Thanks,
> Zhouqi

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
