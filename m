Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E675606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TE/GPwuU;
	dkim=pass (1024-bit key, unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=XIdSR0eX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5917141358;
	Wed, 21 Oct 2026 19:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QtyJpBJ3PqSd; Wed, 21 Oct 2026 19:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E12F41068
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792610096;
	b=SqpHMp6wkSgLQHJ2dVSpWAIj7HxP8oiukA6L+q2n4xRbwqE51zjBk+jvUwTl8KFqVmxM
	 lpSBf5RNfZHJdU69foRDq3jKwXr43+CeCs9ejhflwDIXjYRoXeUykyHYpCThZ3+d2WDsd
	 hf5nQ2da7aqwMZDdHQ1P8GdOgXpQJnBFVE0PQmybMl3L2h4zjZQ/F34Y9iqasHWW5muiz
	 /0gjyxCe94lWILHyioSEohU5g6mCS6F+Oe/SBg3R2n1oZxx9E8E/ogyNZ3i9qubaPuAbv
	 OMkFlMdQxPLZccE55lKnJVW6FSasK0opfM0xkqV+8OQbEOU224k2IpkyvFzTIhxyFQw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792610096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FOUN1o3EK50dGmPruppiv3Tr6q8BAxdvQkcF+W9ni6c=;
	b=OIYbVnmI3xnBJbi45ZbvdblvmzBXLzHOJVuDkScCFxaf57Db5brCsd9p5ujCwdHIEIgl
	 4L2ku7LBkmrSKhUBmby2AZuCNYirkk0hKljStxNSSlcIVrPpJbvVWUXkH8LPDBtzg0K73
	 zyB06osMmNv0b2zAsaYZV45WLAgHXLFt+pejNVIcovAZAVjS7q+TE08j+K25oOw+LKTHP
	 xmhiJZnoPgrSBMU/tlrQgV7CINfd7nQBzCE7ANEcB0cNE1jLMugpKvOz9yWQH2H9sCdGJ
	 aHwVUKE8P97S25zHOs/KjNl90KLvY9YDWWV2sV+BHn5MHunqXmNBHMeXbfIkp69dNPw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=XIdSR0eX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792610096;
	bh=FOUN1o3EK50dGmPruppiv3Tr6q8BAxdvQkcF+W9ni6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TE/GPwuUKidW3VeIGkkIEGdb6iAbS6GCV4RXzArPIK3yNkWvYaIppuqDS9YUNNr8f
	 PIiCuWla+9jAorxhwEOp9r21TLTqGD95WtoYGhiq0ZOrAG/yL+QVQZOgiKivDcqoy9
	 RFAnMggKl8YsMmrtLGe3/YVfZWroSq6Q8NqyQR3g5GeVB3evw/W5voCz/QN7cL2/oc
	 9AUs5n14L3nHv9EARfIcf2rLNcO1hfEFlUD69whPthZ/fipoRyQZuXKT5kZlobEXvP
	 vzOwM0RnDQ4DtoS6yIQIs1Y0eLxwLnQTB9IZ+9jLvrvCEB+IVqQzDyZjf5bRjdbS7R
	 vuMPLeFxHhh6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E12F41068;
	Wed, 21 Oct 2026 19:14:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7EFB3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 19:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9947940F5F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 19:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id My1Bki9zgbpo for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 19:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9859E41068
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792610093;
 b=X9J2HnmJf+omcyfxhxJ7Q5vwBaRUSZ6J8VxFZ8j8s8/pV8gkzJ2hO3uD5lGjZtwTvnmO
 JvnVZIHiG2dEMbxgAuRII4zntwkSvkB8BFJtjYJTb2MQ2LuCkK9BWskzTI1NI6Y/HpfTG
 yHYoYMO61bvVUoiPjBjP15ctXMTT8gqi+A9E/d+GtFshQd8ELHwWsnsm/WgHS2BztQYLE
 7T4pgstqgRZJVsegTDFgceoF7Njq00ODMVbHeJpCjsppBXoZq2KEhRoUNPQn4tiGg/0fH
 6+9vC/GPQX3JOMTOX3TNp3wfPiVbROafF+2Vfq3FAH2Y/5Y11f25IbOMR1JRec+9CHQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792610093;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=FOUN1o3EK50dGmPruppiv3Tr6q8BAxdvQkcF+W9ni6c=;
 b=RHcTWBdpdVU7kWxiJQ2JB3re0ukng0fzxmRFpxmZAgr7oRG5389L4XZ2UKsUjJFk7Kee
 Ae/c1+EVrLwy+Tsb0xZjQKcMFLMHlqWq+Q32QAaE61fC4fF24eZlo+1SF0n+TuD58M8pR
 X9Fd9eZLh/t2Y0938yepGBIKJQbeKx2pp1RFtO/yAH1o/LJwocBwdQmQ04z6WY2Nr3rvi
 KnyjpXAaJMXPMlOTaHudwo01oM2fPaVfowqa5R6vJ/HGSHMtfF42xZ3jxi6+Fkr5G8yYK
 Dq+VdtpQsFibq16468UYhW4yOAH3J4zDsc4li68PidCAxOo3utVPoXwkWxgPSaAJdJA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XIdSR0eX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=XIdSR0eX
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9859E41068
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 19:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792610084; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VS2QI85xt//C2t1+AfuAyIE54dhlgey8RaufBIsW8bDfXTiTqMiYU7m7cyMUjXvyC/P6yyclBWq5IffHme/kYQCM/atBTxCK4OldCZPYXO4D69yXXVX8Xh2tbKJfQwDP4dLh0t2PNt0RdB4w2lldQZHvuqcf0GlErIGa1x0e3No=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792610084;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FOUN1o3EK50dGmPruppiv3Tr6q8BAxdvQkcF+W9ni6c=; 
 b=SkOpvJnb7x5kezPl1Sx2rdNKonLDjELT7Qs+7q1RSecL5ikHh9KjwvBJSEmg5g4mW9odFgKGv5g3hDCEBbsL8NyHX2bV6Kr6pN75cC56hjuEIGXRYEUNDt8NcVx1/Lg8gc8PS5Q46hZNEyLmt77uih3t/VUXBEryrFwyjnb4zYg=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792610084; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=FOUN1o3EK50dGmPruppiv3Tr6q8BAxdvQkcF+W9ni6c=;
 b=XIdSR0eXCP/Azl40B5Ip0GHiRUyDkPUfg4OidC1qHPp38/kODa02RqDl6aSb8/pb
 z3cjIvut0Y8Ea8s55HDy/1cm/mOiAD7tYnIiICM7Jo3FeKpIsU8AlDpXWa2nZ01Rnsz
 /WlSOaV/pgeTk6a4NtGxi9FfedRjkNH7oH1yNXgY=
Received: by smtp.zohomail.com with SMTPS id 1792610081947753.0992780948372;
 Wed, 21 Oct 2026 12:14:41 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:14:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 17/20] efi: LoongArch: Implement everything
Message-ID: <atkPFII7BsNN5D2m@pie>
References: <20261016065500.137544-1-me@ziyao.cc>
 <20261016065500.137544-18-me@ziyao.cc>
 <CAFLszTgaSeQVDZWryR_dfPzwxqO1Q7YQ7y=3PRZ2-sTp0m2sFg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgaSeQVDZWryR_dfPzwxqO1Q7YQ7y=3PRZ2-sTp0m2sFg@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.588.96
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 06:16:40AM -0700, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-10-16T06:54:41, Yao Zi <me@ziyao.cc> wrote:
> > efi: LoongArch: Implement everything
> >
> > Implement crt, relocator, linker scripts, and handling of PE relocation
> > IMAGE_REL_BASED_LOONGARCH64_MARK_LA. Wire things up in Makefiles and
> > Kconfig. The relocator originates gnu-efi project.

...

> > diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> > @@ -12,3 +12,15 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
> > +extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
> > +extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
> > +extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
> 
> CMD_BOOTEFI_HELLO_COMPILE and CMD_BOOTEFI_SELFTEST both select
> EFI_LOADER (which selects EFI), so the first two lines look redundant
> with the third. The arm and riscv Makefiles rely on CFLAGS alone - was
> any of this needed to make the build work?

I think lib/Makefile.lib-u-boot now carries default rules for *_efi.so
to work out of box, thus this could be removed, thanks.

...

> In any case:
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks! All your review comments are reasonable, and I'll apply them in
v6.

> Regards,
> Simon

Best regards,
Yao Zi
