Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6CB606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cFtBhSIW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Sjz0ps0T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D923405E3;
	Wed,  4 Nov 2026 04:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x1XVS9oSWt-7; Wed,  4 Nov 2026 04:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A4B69405D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793767555;
	b=qLodUVSgUA8miOI1LQc0sV3Het3aTllFm1+/3o2NxL5D+xwN64SX6zn3lnlzy9SID7W9
	 K9ULeS1kSr29Rh03rRniAd+KZ4ORUIfOYcRluo9IeCodjHrexTpUqDSkX0SxcAd0eBO2Q
	 gUsRlvdYN6fPkQN+U7czxEu1An3H41L2d/z7NfhLr0rkLOpocN9z7691Bj4uRRFMe/1Jz
	 gY8/0G71MaHKTZ3GhQReOZb2gBXThcLHQmUOa61eFXP8Fs7uZB7F63d2s8+DP41OnVgti
	 Zm0MBG9qRwpZkqYztAsXHDJ5f65oq4u0FZ5evudtv9ApXxkuN8BZkRhe/dse90G8ayg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793767555;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4riMNvFXhpJC8oAG+dVN14S9fuw0FnX87Hd2nX/faIM=;
	b=CBolXThlkfMxWA1sTKLiR1NPxuU8XZfclhewI80uCH1BwMR1C+xtJPkj5z9v6ADiofXM
	 NmnTmznlzQFmwJHjfqIh2Z8pqxVTjB+OpiqIUWRstpbEOh3f3BlfcrqIa8Vnk76Yd7AI4
	 pQSaQXEdl5r/JQvcldLWngq7rEDg/3FLn+5Ztk7oOD4+/aKwGdluzfqoxJi5LefhacVoJ
	 cwIPpS3ib3pqx0v6fx3xYdMOkwivSMO2r43gfOeBrJgEvu4hlLn113Za3lMbORVXdLUrm
	 5VuElqrtAfAf6zFOx1uu6FFKTCbQzQwberlwc9amdjj1t69lqeDF6gsHMMD9MR7x5Lw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Sjz0ps0T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793767555;
	bh=4riMNvFXhpJC8oAG+dVN14S9fuw0FnX87Hd2nX/faIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cFtBhSIW/cLwKukGhGTH6w/RmKxYMs3b+sb+wL5vemsVBQFG5PgucfkB8+IwJovxH
	 QFwYzPO526w6dWhkj+mPcIKv8XT+AktZYypNWvoG6Ij4QV5/lrE39ug2fq2soQ+GwU
	 RpyPd10mKEhrhPcUHFFMRyTIM/KTLULuB1VhEdiHw+oks399w+RdwdSggV4pXO7iAM
	 Mqdv6z95Miqtk6gGRYL1G+Tfsxz30n+7FSU8k1pqN7l7OJNN/tKCV7Len2YTS21C9n
	 1uo6429YAiE6jIvp3kH8bFZg6dJy8hARpf9Ec16niF4Eo/0qyDryYq6YYnmIKN7+3F
	 3FH4Xu5D9sGwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4B69405D2;
	Wed,  4 Nov 2026 04:45:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7F15A14
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD945405D2
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFWXofoVxJKu for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:45:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 01408405CD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793767553;
 b=DvCILF6CsoggQQ1Y8vMU0HfCPZTuy8k9gBA07yi8iH+tdFqBAecur490H1y6rz68GcTE
 i54D4D5h+ydpWl8QaPjPXOTZgcIJ+IUeiFQH1a60OO3CkFZpyPV7/431znOvDl0l9ksNx
 nuUGUoBomkZuqwIbWDiYzkcevrTZIsijIZBx6TbT7aWLwEGscO1dBPDuuDfhaj3T5OPAq
 mkc9yEtPyA3vCPNLHSxbhBuFdlq/sA8GuiDH6zYpYUT6f+yFU/sDOFUlb/mszr3tb6Ucd
 BxNdXO6X1lJSD0w7+GM10BXzV33xw+RVeumUdDkbNc7alIvc+dCvgW0OapX2ESTbU7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793767553;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=4riMNvFXhpJC8oAG+dVN14S9fuw0FnX87Hd2nX/faIM=;
 b=dPhYRiQ9h3/hQh67S84Fvz9xvaqC9x1ZMQWnJgF1xwGuNw9TJlNDDEvxs3wlKnLCFpQy
 uyABJSNfsQjbl0cFCDFaeR5o5sPTMF5wbzVAzs0r9ml+IrBeTJWFDWeKr3ijr/FbdNzsg
 R/dLmBHZacWciaaJAZysjTeTvg2NT5r5fOsSs72eV8J/YnpHafVP5tMuOgXZiIEqHKsYz
 Sk3P943zx+0KVLlZ4PAq1+prxAdatxijip8FphvdNuDw2aLNJCKqb/KCNyeJQbrcaQlHW
 kdvg640pTh/yGrqFAh2Kez51AWhkSYQChIovK3MkTgZMSqnM16+vYLqxhee/kFAbD/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=Sjz0ps0T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Sjz0ps0T
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01408405CD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793767543; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WmLmzjqBGsHkgWgxj/gMLzFfRI28AIFiujxbqy8iDhtQQlhqO+A9L63wyIioC6HafFOhuQQc0Tk0VAv1RfRBM2m0Hm+Hctc9N1jN1ffixSRb4oZTDBjDXv+YiN8+py+bSbGDag+yzMDOCijeeFIQ6OzmFuAO0eEHehJOrdRnEqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793767543;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4riMNvFXhpJC8oAG+dVN14S9fuw0FnX87Hd2nX/faIM=; 
 b=fkAtsFLW05BVV7fCDAcKLmYRtIFQ/mxLwIOaJCB242Fit2b1ioychwu9CBqjBSYFgeoC5Qotv9uBiw7DKIIRmn2SJcozoXLZB3rA5+VDOGpF4iu1APSnMIvtirJJErGUDBwHoSZe4jDb00MYktGOMghDtOurbujhLsiuiQg/6BM=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=Sjz0ps0TMYt4PRajEWZxrbAITRrddzb58Ge0E+1FPpitfMlc4KpbKIxis8avCvZ07deR+0zqY20k+jTR8al9JqqQDj4FlbbnQedx/ipkMBZLJTaKYDpI8YDKcXo3uhYwBH74Od1PyxtEfLRDchxIgYE3I6n5bzjk2FVlbYtkU2c=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=4riMNvFXhpJC8oAG+dVN14S9fuw0FnX87Hd2nX/faIM=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793767543198663.299870203996;
 Tue, 3 Nov 2026 20:45:43 -0800 (PST)
Date: Wed, 4 Nov 2026 04:45:38 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 10/20] LoongArch: Boot Image bits
Message-ID: <auq4coFjtPBivwdl@pie>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-11-me@ziyao.cc>
 <CAFLszTgZyC1yDgCtH_VzCS0ZvEG3kw81fx_xns8L=6w7m9OEaw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgZyC1yDgCtH_VzCS0ZvEG3kw81fx_xns8L=6w7m9OEaw@mail.gmail.com>
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

On Sat, Oct 31, 2026 at 01:43:27AM -0700, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: Boot Image bits
> >
> > Implement loading and booting functions for LoongArch
> > standard kernel image as per spec.
> >
> > LoongArch kernel do expect us to fake a efi systemtable
> > for passing fdt to kernel, we don't need to implement any
> > EFI functions for kernel because it won't look into anything
> > beside devicetree from that table if we tell kernel we are
> > not efi compatible by setting a0 boot argument to zero.
> >
> > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> >
> >  arch/loongarch/lib/Makefile |   2 +
> >  arch/loongarch/lib/bootm.c  | 129 ++++++++++++++++++++++++++++++++++++++++++++
> >  arch/loongarch/lib/image.c  |  77 ++++++++++++++++++++++++++
> >  boot/Kconfig                |   1 +
> >  cmd/Kconfig                 |   2 +-
> >  5 files changed, 210 insertions(+), 1 deletion(-)
> 
> > diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> > @@ -0,0 +1,129 @@
> > +	systab->hdr.crc32 = crc32(0, (const unsigned char *)systab,
> > +				  systab->hdr.headersize);
> > +
> > +	cfgtab[0].guid = efi_guid_fdt;
> > +	cfgtab[0].table = images->ft_addr;
> > +
> > +	gd->bd->bi_boot_params = (ulong)systab;
> 
> The CRC is still calculated before cfgtab[0] is filled in, so please
> move it after that.

Oops, I'm totally confused by UEFI specification, where hdr.headersize
is the size of the full table, instead of only the header's size :(

I'll fix it up.

> Also please use map_to_sysmem(systab) for
> bi_boot_params rather than a plain cast.

The problem is that bi_boot_params is ulong, not a pointer, I don't
think it improves anything here?

> > diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> > @@ -0,0 +1,77 @@
> > +	uint32_t	code0;			/* Executable code */
> > +	uint32_t	code1;			/* Executable code */
> > +	uint64_t	kernel_entry;		/* Kernel entry point */
> 
> Please can you use u32/u64 for these members?

Sure.

> In any case:
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

Best regards,
Yao Zi
