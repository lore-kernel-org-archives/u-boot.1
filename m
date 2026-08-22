Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4B0C5DF8C
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 17:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9094940589;
	Sat, 22 Aug 2026 17:52:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIqZ3wYP5uYv; Sat, 22 Aug 2026 17:52:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787421165;
	bh=U6t2KODDxc9YgU5hJm0HO/jcra2Ze5ZWdAGSqSDhZ+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LGZczwyq+x0SYidACRZThIav6IS1VyWmEf6SqXiaOQIJxU397ARw77v42szKw25t9
	 OKuCcmiLfeA1xzxbd9Cp+ZeFG1o6fWDAzHhAJAYb3rZWCzfbfz2BC34MDoM7Q+A5xN
	 uSc361Q5iCixdPqrQy2f3+WSPyld2irsPrn6Nl80kWtpj2KZbhcRQu1WMGtBaAPuFd
	 nkpLbvUJlxXMM0qMVPhijiGnEg265q4WRHtvIO245oHREuhDJHkqFo/Yk+YKirUoMu
	 4YtuqUeRNViivIy5LEcS1I28JwGTHhmMKGm73LSdYVixaBjyRhN5taKfzNPEI5QH4s
	 qH8f46J7/ItaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB71340598;
	Sat, 22 Aug 2026 17:52:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B706329B
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 17:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99D1960639
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 17:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJFOjEDLJfoQ for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 17:52:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=hMeukgVf
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FD9A60635
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 17:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787421151; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KFshAVHXw/uCs9LSsyE/N53tp0peH86dz7Y+/AUyzfQogmR9nrdUW01NAS/PMmG5GyfTgTIArD5kbbgkfXOzi0JuyoLkHFsoLzMa4AptHVPvULlxeNLIVm8BlvEA3zAbMSJxKvISfBIFdO1iz40aXc/yTWOFk+yuVqEQX++c5zQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787421151;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=U6t2KODDxc9YgU5hJm0HO/jcra2Ze5ZWdAGSqSDhZ+M=; 
 b=jkhMbFUqvtW3+swv+dzKwWVs//zUD0g9pko9lolq8lCD65odRE6CAkEkCrMhW3fkJgVCXOttlMVWJfdU+jtVX9KWV9xi4gzqHQBabev9V7QFq+uQV6P12YTykOJePRpRzp9+h/nofw5Mqfh4ITXcBX1268jofk2obGdKT80EICw=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787421151; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=U6t2KODDxc9YgU5hJm0HO/jcra2Ze5ZWdAGSqSDhZ+M=;
 b=hMeukgVfarj4MJ23XPQ0jjT050y973Wg87WilZ9w4nV1kbPnTj0xlijT81mWFPlw
 UKKvKeXbTPWoC95nXnV7zyjNjhOG1G/DwWkEwuGIOLhOyH9pLiRpDYjltQcTJeJ+qLu
 KHD5B/NY+BAEmRFWUEkQ31W8OLTSwF0TGIsQEYpY=
Received: by mx.zohomail.com with SMTPS id 1787421147941590.0563093059571;
 Sat, 22 Aug 2026 10:52:27 -0700 (PDT)
Date: Sat, 22 Aug 2026 17:52:14 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 10/19] LoongArch: Boot Image bits
Message-ID: <aonhzngo6A-kZ9pF@pie>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-11-me@ziyao.cc>
 <20260821162048.GN523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821162048.GN523975@bill-the-cat>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/287.412.46
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

On Fri, Aug 21, 2026 at 10:20:48AM -0600, Tom Rini wrote:
> On Fri, Aug 21, 2026 at 08:42:10AM +0000, Yao Zi wrote:
> 
> > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > 
> > Implement loading and booting functions for LoongArch
> > standard kernel image as per spec.
> > 
> > LoongArch kernel do expect us to fake a efi systemtable

I occasionally noticed this typo ('a' -> 'an'), will fix it.

> > for passing fdt to kernel, we don't need to implement any
> > EFI functions for kernel because it won't look into anything
> > beside devicetree from that table if we tell kernel we are
> > not efi compatible by setting a0 boot argument to zero.
> > 
> > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> [snip]
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > index ac4be2c837c0..5654de5a58c7 100644
> > --- a/arch/loongarch/Kconfig
> > +++ b/arch/loongarch/Kconfig
> > @@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
> >  config OF_BOARD_FIXUP
> >  	default y if OF_SEPARATE
> >  
> > +config LIB_BOOTM
> > +	select CRC32
> 
> If this is needed, it's a generic problem (and to be fixed outside this
> series) where LIB_BOOTM (and possibly LIB_BOOTI/Z since you know what to
> look for) need to select CRC32 and SPL_LIB_BOOTM SPL_CRC32. Thanks.

I think the dependency is specific to LoongArch, since CRC32 is
necessary only because we need to fake an EFI system table, which is
CRC32-checksum'ed, to pass FDT to the kernel on LoongArch. AFAIK other
architectures don't require such treatment, so I keep this
LoongArch-only.

Should I include a comment here to explain the dependency?

> -- 
> Tom

Regards,
Yao Zi
