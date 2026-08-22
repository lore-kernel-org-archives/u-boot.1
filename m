Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0B7C5DF97
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 20:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47DE280DE5;
	Sat, 22 Aug 2026 20:47:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxnRuwiKmqu2; Sat, 22 Aug 2026 20:47:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787431668;
	bh=s1adpuVlLbfHYtpNdLeZWUirqXSDOW+U52yAClWDLWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAsPvY5Mn83kU7kmxt0bMPF75+boiQYWQW36HKjWna2tLiZsZqmi/icPlu3Fb4FtH
	 r8ZKl9lUD6UN+No41tEdlKt6ZMrF5j4Vr23ANyPDGerBAmR+FVLEpOrcBl+yQ4/Chs
	 v0TmK4CPyXhUg9SggPGolaw0qVJl9gNunCZMXAS9UVrsbZCHCcTQCw7yscPHGXg41d
	 OMu7w3xcL/GynLVn3RFzP1tDXBbVSZByN7Zz7hmzTJCO7vw+xciKrsmAbM13f20fUU
	 qFLBDvE35R3NfU+qz4xj0XnFlNvHWa8gHBCabeWiwM6biBxqzYMrkItT7XlrZu2Bgv
	 eirl0LaHh7WoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E04C680D80;
	Sat, 22 Aug 2026 20:47:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8539D29B
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AD91606B6
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:47:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBTdJZAkPCUy for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 20:47:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=JtwYaSDt
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8185F605F9
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 20:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787431655; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QRGMreYCMxFT6KqjR+Xh2E5UfiixEAc5wu1EOpMjZMItXy2slsO4tuqQGVS805Op4BExqIZfy29pHx1fUz2Kk8+QkEyecSsNxlFXXpTYxMRscHnoTmH7LZM17nhMtKb2eKS+BR3vu/lvv+zQJVoYWaoW2Or0E+EfaIFkQ3KkLgA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787431655;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=s1adpuVlLbfHYtpNdLeZWUirqXSDOW+U52yAClWDLWc=; 
 b=jaPsUK0Rt7eiy8CkRLayqgEUOlqw6mvWBBwAAoJEulPJ1joHRxHocYJ8zmmw/cZYm/J/SuCxFMLrN88ieh3tjLhS0/NdoRaEqRgyOxJyNlDMqb8GXMNQAIt+DYH2SWJ/nqQ5AwzZYDLkHxYEA0FhPlGRIFd0cU3+BTP0liZqJL0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787431655; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=s1adpuVlLbfHYtpNdLeZWUirqXSDOW+U52yAClWDLWc=;
 b=JtwYaSDtNbwZXdapH9Onht7bVddlqamQ4QG3Pt0afKEmuW88NKQKNrs6F4D7Jr5Z
 3iP8xp0KM9MO7CPpaqJXFfW6VA+YCJC8t5kqcip3WYmUJPdHMy5wxlM/IK/iyQ7k65E
 Qz83lm7qwQdmbz9Kw6BKw5oNqUNxqbJeAdX+QN7k=
Received: by mx.zohomail.com with SMTPS id 178743165421398.46351649583528;
 Sat, 22 Aug 2026 13:47:34 -0700 (PDT)
Date: Sat, 22 Aug 2026 20:47:28 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 10/19] LoongArch: Boot Image bits
Message-ID: <aooK4E-A1e9-XtSl@pie>
References: <20260821084219.1703743-1-me@ziyao.cc>
 <20260821084219.1703743-11-me@ziyao.cc>
 <20260821162048.GN523975@bill-the-cat> <aonhzngo6A-kZ9pF@pie>
 <20260822190316.GW523975@bill-the-cat>
 <20260822190651.GX523975@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822190651.GX523975@bill-the-cat>
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

On Sat, Aug 22, 2026 at 01:06:51PM -0600, Tom Rini wrote:
> On Sat, Aug 22, 2026 at 01:03:16PM -0600, Tom Rini wrote:
> > On Sat, Aug 22, 2026 at 05:52:14PM +0000, Yao Zi wrote:
> > > On Fri, Aug 21, 2026 at 10:20:48AM -0600, Tom Rini wrote:
> > > > On Fri, Aug 21, 2026 at 08:42:10AM +0000, Yao Zi wrote:
> > > > 
> > > > > From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > > 
> > > > > Implement loading and booting functions for LoongArch
> > > > > standard kernel image as per spec.
> > > > > 
> > > > > LoongArch kernel do expect us to fake a efi systemtable
> > > 
> > > I occasionally noticed this typo ('a' -> 'an'), will fix it.
> > > 
> > > > > for passing fdt to kernel, we don't need to implement any
> > > > > EFI functions for kernel because it won't look into anything
> > > > > beside devicetree from that table if we tell kernel we are
> > > > > not efi compatible by setting a0 boot argument to zero.
> > > > > 
> > > > > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > > > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > > > [snip]
> > > > > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > > > > index ac4be2c837c0..5654de5a58c7 100644
> > > > > --- a/arch/loongarch/Kconfig
> > > > > +++ b/arch/loongarch/Kconfig
> > > > > @@ -56,4 +56,7 @@ config STACK_SIZE_SHIFT
> > > > >  config OF_BOARD_FIXUP
> > > > >  	default y if OF_SEPARATE
> > > > >  
> > > > > +config LIB_BOOTM
> > > > > +	select CRC32
> > > > 
> > > > If this is needed, it's a generic problem (and to be fixed outside this
> > > > series) where LIB_BOOTM (and possibly LIB_BOOTI/Z since you know what to
> > > > look for) need to select CRC32 and SPL_LIB_BOOTM SPL_CRC32. Thanks.
> > > 
> > > I think the dependency is specific to LoongArch, since CRC32 is
> > > necessary only because we need to fake an EFI system table, which is
> > > CRC32-checksum'ed, to pass FDT to the kernel on LoongArch. AFAIK other
> > > architectures don't require such treatment, so I keep this
> > > LoongArch-only.
> > 
> > Ah, I think where you select LIB_BOOTM you should also select CRC32
> > then.
> 
> Or, finishing the thought, "select CRC32 if LOONGARCH" in the main
> entry for LIB_BOOTM.

Okay. I separate it out since it's LoongArch-specific and doing so
avoids touching generic Kconfigs, but was not sure which is preferred.
Will move the selection to the main LIB_BOOTM entry.

> -- 
> Tom

Regards,
Yao Zi
