Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C64606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VZoFmu7y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=avBQjyfs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 829FB40704;
	Sat,  7 Nov 2026 19:03:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a23ihmdnM39r; Sat,  7 Nov 2026 19:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9B8AF406FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794078205;
	b=lf23/FrWUuuvwG7J17LfxtZgXp2rcwpaye8ddAZHwzkeJ+OArBfmXDiUxdA6QDdamXbY
	 U6ltiDNGAJCCwpwCxp5lY+3euTLAqzFFPHW4P+B28q3BXhybo5LPK+t1wI2muvvID4VJS
	 lpc6b/pC5IkrCjDho8YxfJvfoweRMIFGmoh+rfImsYmDpSWFNrveJqAh7ulczdibzEzhj
	 acjWWCM0uATNQcK3d6SUpcRIgPS00B1uNBqQ0Kv5ZWhYGYV/PpPHXShvrdyAE+1ecVqvj
	 1GqC6+qVaoH0wuCzF4i2ir/mYeDDuObg38+s2X+QkrDxwGgLDUkciqRo01BkavA4foQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794078205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WshqW8VT8vXqx3Sl1llcVksTVxBd7SwjtfXEAT0k8bA=;
	b=FFEXngdVxqMzJBVMCSwa/ewGoFMy9gVklHEy+eOeI2rJM+e4+ju5ivmjfvzZjwY6Qgpg
	 76DjS+eUd/wI98Xpwqev+PfdJ7RiSSRdf0EeGkKoLfP6I31Tb5KB7nQqwogflzK2bDJxM
	 L//o/yUYTfusCrVXs3NG4BRIXU9iT8+sRa6qaAlZhGsIkDE9+DPQnD1Y2QvRdmhyx0lAY
	 eT5KM49IlEp9mGZcJpRbWVJl4N+rpiiiyRn3Y6fYERIY4zOs1aNxEKXI8igQnaJzgdeK4
	 jy6m/7vhIwuy16zmjLKSZjdnyeqvHmUoLT2GlloDFu9issF55LuO5fWNzevrXGiT3Gg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794078205;
	bh=WshqW8VT8vXqx3Sl1llcVksTVxBd7SwjtfXEAT0k8bA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VZoFmu7yChHNL6ZHM4PYHZklkjhEYeG4ltsclqaxYQlguxJWj+gsvo6udfkNRdA2X
	 N4VuJ/tooi6nFr0ZFrMWCCt9ifjBdeb+JMYyiA/PfCFxsd/OnTm7qPYLSJOejVwSQK
	 lIp0MGu4045fZUHGWUT7wYBPY5ef8fSqMjq4OKHiTcEihwxp4gpInie8iG3BITWun0
	 q0tOPWT9lhcq7ud1/NOBkxUJFGZfVBJ6RCCGHNL/tLxb2RFYZa/9E3s5Gdxa8M7gNw
	 rqXUXfLfWjoSCkxT0dGW316uXvFRjeYUUUB4tgOcmC3yI2S0ucgt8k0sF1XDg4NLnB
	 DHeqI1jROL1lA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B8AF406FC;
	Sat,  7 Nov 2026 19:03:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75A6D32A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 19:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7312C81265
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 19:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pvDEMYvX8uwq for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 19:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4A7CF80F6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=avBQjyfs
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A7CF80F6A
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 19:03:22 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=avBQjyfs+K8gtUFUHmTZ+rbc2GBPCE8T17PeBFmqsVjxzCTe7x5+oQRD1Olp1HDSA9brkZwyw5nfmIVuSrGmLFXpiXRRWLsNtoOCYMxc86FBbCCW4VVo7ru8xFrxsD5iMpcitQKde6qqZ5l3wkqZy+lGBdmq2v+uIl0amJOCf9Q=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=WshqW8VT8vXqx3Sl1llcVksTVxBd7SwjtfXEAT0k8bA=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794078193192205.948321274818;
 Sat, 7 Nov 2026 11:03:13 -0800 (PST)
Date: Sat, 7 Nov 2026 19:03:04 +0000
From: Yao Zi <me@ziyao.cc>
To: Simon Glass <sjg@chromium.org>, me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 10/20] LoongArch: Boot Image bits
Message-ID: <au916H8p1_rxVJFU@pie>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-11-me@ziyao.cc>
 <CAFLszTgZyC1yDgCtH_VzCS0ZvEG3kw81fx_xns8L=6w7m9OEaw@mail.gmail.com>
 <auq4coFjtPBivwdl@pie>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auq4coFjtPBivwdl@pie>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.65.33
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

On Wed, Nov 04, 2026 at 04:45:38AM +0000, Yao Zi wrote:
> On Sat, Oct 31, 2026 at 01:43:27AM -0700, Simon Glass wrote:
> > Hi Jiaxun,
> > 
> > On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> > > LoongArch: Boot Image bits
> > >
> > > Implement loading and booting functions for LoongArch
> > > standard kernel image as per spec.
> > >
> > > LoongArch kernel do expect us to fake a efi systemtable
> > > for passing fdt to kernel, we don't need to implement any
> > > EFI functions for kernel because it won't look into anything
> > > beside devicetree from that table if we tell kernel we are
> > > not efi compatible by setting a0 boot argument to zero.
> > >
> > > Link: https://docs.kernel.org/arch/loongarch/booting.html
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > Signed-off-by: Yao Zi <me@ziyao.cc>
> > >
> > >  arch/loongarch/lib/Makefile |   2 +
> > >  arch/loongarch/lib/bootm.c  | 129 ++++++++++++++++++++++++++++++++++++++++++++
> > >  arch/loongarch/lib/image.c  |  77 ++++++++++++++++++++++++++
> > >  boot/Kconfig                |   1 +
> > >  cmd/Kconfig                 |   2 +-
> > >  5 files changed, 210 insertions(+), 1 deletion(-)
> > 
> > > diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> > > @@ -0,0 +1,129 @@
> > > +	systab->hdr.crc32 = crc32(0, (const unsigned char *)systab,
> > > +				  systab->hdr.headersize);
> > > +
> > > +	cfgtab[0].guid = efi_guid_fdt;
> > > +	cfgtab[0].table = images->ft_addr;
> > > +
> > > +	gd->bd->bi_boot_params = (ulong)systab;
> > 
> > The CRC is still calculated before cfgtab[0] is filled in, so please
> > move it after that.
> 
> Oops, I'm totally confused by UEFI specification, where hdr.headersize
> is the size of the full table, instead of only the header's size :(
> 
> I'll fix it up.

After reading the code again, I think this should be okay.
efi_system_table points to cfgtab, so it doesn't matter whehther CRC
is calculated before or after cfgtab is populated, they're contiguous
in our implementation only because we want to avoid an extra allocation
here.

I'll keep the code as-is.

...

> > Regards,
> > Simon
> 
> Best regards,
> Yao Zi

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.
