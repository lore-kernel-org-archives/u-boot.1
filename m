Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16051606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ImJGykzK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=oU9J9fww
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC7E2405D2;
	Wed,  4 Nov 2026 04:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Xj_yJo9Ryzo; Wed,  4 Nov 2026 04:35:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D9200405A7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766904;
	b=IYcWFuBoLY0VGOW9RHOcSrxUHboLzPewhuZCXxGUNrxhdlrsE1fs1KdQ8RTMIRQImjyh
	 6qeS5t21HP2j0rHrWKF7JB+gKEZNBTetpnDJenk2CT1elCK6RW9W4SW2bcRuttJNKfIYf
	 BaW2Q1ND6MO3AhQM7OmXPomJiXCpTjijKFXEVzzymFudCn569l+gs9Ny6be04hBmwZlh8
	 hWvupkn436hB28FYMcEwBlWC6lvumttmxLNbM0QPf8p+jbjKxsTF4l4lYN7R8/XtuEZjE
	 fq/SNNlEiJGjhYv/E7kU7MLmnuyqcGNmxxtIK7mJzZN/DUhPrN0oi+L5tub3z2s5d8Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793766904;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=viwCbOyl3y+l9Gpim7CTbPqJs/w1ph6T+USe/KHYToc=;
	b=W+ta2pg3E2gTcevgvwI2vEMHTS9hwTQ1gvHxGY+8zoOOzM+U+HRNaBMbw2XvClVSNJ+P
	 1IkoEBLBoZxuAjRLxr8iqBnglE4KZJXTPDPXyuNmDBCq3xnN9HTPd5b7DKGnEf9m7WfmC
	 4VsjbCuDoH+J1zb3El9c/PY29wt/IgcFVCq3OUgCsSYBJ9X1/g3lkES1dLfb4z5pvE9yP
	 alkR9Wqq39I/7hTHVQVMuXoBmhGaGUpLYeJHYzYmWnQi/DfWA3b1TlmKhioli6dwwNaBg
	 xTm0EIMGJ27VA//ljtTSBA4iJup2bo38lsEcEIjPZxJu3dDK5CtnaW74KMSOZ1DKebw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793766904;
	bh=viwCbOyl3y+l9Gpim7CTbPqJs/w1ph6T+USe/KHYToc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ImJGykzK7Glcqe8zN77TppdNM/xl5l1ksh3HMEmP9MdtI2/qeLAeUDm3RrNlmE5Wx
	 yHEf+tq9enBeavXOZFHCQp130C+b8iQqAVSHST9WC2rNqB/43Gr1Hx/tz89uTkEaL4
	 jkTCtc9aiP2iHeH1UzlO1HaiWD3qVTliP2b0U3A4BBTTi4GmUAfUTp71jIFAt2whvx
	 qF0Z/z/RIur748E/lNL1Rjp3BvBzmDW5w+T0eZYo1Tj8ECUrHa9KrjMqhgNFDNfZw5
	 MRDQFwG0g9T8GAWjs5DfBRpRbOUhNRs+yRh/7saamzdIdwIiuFr4mzhbIKWZ33vxoq
	 8BJaWEmLVQdIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9200405A7;
	Wed,  4 Nov 2026 04:35:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6EFB72AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6063360697
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpdlpU-3njq5 for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 04:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C81AB605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793766901;
 b=b85xzexfKNZMuzbNVNIydHsQCwHrPpIOx8vdyNVEf8BdZ0R84TKpUhYUtpDClnXAz2h0
 A0czBj+KZpl/88ET+hHmT3tV60S2DokBFKUEa48CqwEJj+nSo0slKUaX3wxU7tMgGrNOj
 KCdpv9EBPpKNGtg9syZIFvxTcIqVACrhmaR5FBmcN9DTyjF0aIpnrfmMDlzrVXzRQt+5s
 SQQqteujkHrxYoctA59262KWyiQTKFwYCVX72oNHP8D0jjr5WopiODpOOOZCno2ZjAXk+
 QtxFw9oiAlOPtXppCpVhmF1uY2DzXPAsKW3Pi+h6XvRKxjRpDMeFHjSu2MjtJWK0jvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793766901;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=viwCbOyl3y+l9Gpim7CTbPqJs/w1ph6T+USe/KHYToc=;
 b=G9ahhuD6Uow6R/jaO+INCKgtckjo+qQcqsP3CPlex6kgGxwtHmrn71BOxGKEkHG5EYe7
 tmWcVnn1dOfiam/yn5artr6Cq+u0MegYHGaIv9pse8bPhexI3yid1ZXGAg5DFvmIAVI6w
 r/BDqmmPWPnuda3+8su9rD0ZDQ4snTVR2XC/ekI8EPlnJ6K1johHPSg4Hfrp/B6hskRVL
 TgW58UNzENc3z3P4TfL6fezvVipUKwdzi4VmOO23yaebpR7TgTlNqD0aYG4JpnTX9YKWg
 R2nbnPlq+Jsh+iKrPFeYuMmOwdy61KCFPmFAtS3yZbT4jiLPQRGGaO6Y5+78EB5SMAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=oU9J9fww; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=oU9J9fww
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C81AB605FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 04:35:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793766894; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VZ3reuHkyvU0enVbq51rc7sDiBtXsYpaACVeVCCsQcVijU1CmV4QbzLLO2pAGT9ciFxCAVb952eXmcxMHKLFugxffHCM9fTICps5pJ1czyvcYrxC7dk81U6R7xjB14P/4MvdHg0UHdibvPJWdwsYN2tBny2CZT5KQyRlStzyuWA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793766894;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=viwCbOyl3y+l9Gpim7CTbPqJs/w1ph6T+USe/KHYToc=; 
 b=It2821DGmTSKSeRLPAlqj1vl72+32kRAra47phfoTbsxJpc7eO+3ISUTqXVgtDzt682kBNrqUYD1bT9snNBg7kVmDCMiqIgTcrCGhhhGe0qkKzM0DtcRRsjlfmRTQxerxU+IsbONh4ZZA44a23QUOkTVZhCwUbDw5vllBZi7o+8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=oU9J9fwwv/kPMGwa2gI5TdxU9Lneombz7bqi6xMA1t5JBJeliLqYRMe457by3nnq5RateX69AUUmHzVdZ1gvNJSaR+szpmlpmDIslbSK8DDSNdLJdTY1aHy6SZITmnlf3mNAk9GGBOVsA0KPZq6P7hGJPaACs/3/mSIXO5eqrMU=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=viwCbOyl3y+l9Gpim7CTbPqJs/w1ph6T+USe/KHYToc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793766892934341.9107587406735;
 Tue, 3 Nov 2026 20:34:52 -0800 (PST)
Date: Wed, 4 Nov 2026 04:34:47 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 06/20] LoongArch: skeleton and headers
Message-ID: <auq15yoBk5ZLAfJt@pie>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-7-me@ziyao.cc>
 <CAFLszTimoGFOQmu21+5YjCU=TPnM3ER75ULgcUTT_dsJs6LNtA@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTimoGFOQmu21+5YjCU=TPnM3ER75ULgcUTT_dsJs6LNtA@mail.gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 01:42:37AM -0700, Simon Glass wrote:
> Hi Jiaxun,
> 
> On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> > LoongArch: skeleton and headers
> >
> > Commit for directories, Kconfig, Makefile and headers, aiming to build
> > for 64-bit LoongArch hardware with FPU.
> >
> > Some of them are copied from linux, some of them are derived
> > from other architectures, the rest are written on my own.
> >
> > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Signed-off-by: Yao Zi <me@ziyao.cc>
> 
> > diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> > @@ -0,0 +1,40 @@
> > +choice
> > +	prompt "Target select"
> > +
> > +endchoice
> 
> Please can you move this empty choice into the qemu-loongarch patch,
> which adds the first entry (TARGET_QEMU_LOONGARCH_VIRT)? Until then it
> is just an empty menu.

This is a "skeleton" commit, so I think it's natural to introduce the
menu here, and fill things into the "skeleton" later. But either is fine
with me.

> In any case:
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Regards,
> Simon

Regards,
Yao Zi
