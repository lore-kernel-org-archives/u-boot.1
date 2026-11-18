Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C5C606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vPefD5dd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=ouH69zrY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DCC640A1E;
	Wed, 18 Nov 2026 15:46:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zgJGgumP2Xdw; Wed, 18 Nov 2026 15:45:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 31D1040A0F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016759;
	b=aS8yQ/SZ+lmpjciRCA8tF7/HUKRl+K7XZ070Dcym3AoTG/WIwujvQXN0FwK/5HBIrjvZ
	 xzXPOoz8BBeeVbXjouKE/nIiFR1Pz3UBdT6tVuexGsZyr1SHOYvdcLsmp7Te2ito0oxme
	 djQeUuo1ZdYymT/egffRl5b2Mz/YT7gbzr2gmEqDxPp4QzvQFjpPppy0Svy3wtaGfaS/l
	 ufV082oqEB9jPirS5482m3OLPpBI4nq70C8aizGqK0oGCBgkx8cvIST3DcKruvXkurZCe
	 gyLLebPy6XIn3pQIA315rHojWvtEkP1J4i0umQG64P0lV8hEem8kWZOD+GCW2RNLL/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZfGzXg/wO/qa3r95tNO4RS0pM2iy2tLBVTdjtNx7tz4=;
	b=AvGazyZfyZsSk/w5vrLcm3RNU6gxHFFMxPme8S01nUMUy4DGT2Fetv/d3cMf6z20ymyP
	 8aItExvSJuvST05FzDUYu8VWYgfPwFPIZ2+zV2Tj0Drj2TXW7FQaBqIlBR7jKs4Yf9+MT
	 hnku1+o3E9eRc5bL3rrpRSJXiuimoUBp7k7d1d60LcNrCmbqJOiNtHRYGX2OTpCoiXbep
	 uFfK6QmJ5zRs9zxv5cw+uwFbuHpnCpxxWP9ys0QYGtQ4jERQgGE3FognTNlr9+gcrEzFj
	 YlXTFnvi8R41+i8QIbT683w/ZtQCWlVrEhJHBchs4Mbqs/H9K+GOupmlxNNSQy0FD2Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016759;
	bh=ZfGzXg/wO/qa3r95tNO4RS0pM2iy2tLBVTdjtNx7tz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vPefD5ddnnxaEKxHW9b2kiiIlFPE4gYVH3mzicqp28F2waigxP5r7eO4A5V0U3iVb
	 qwRqBOVmrn/xwKcMjJ2HErbfrou6iZ17Kw8O7jTWZZW8zbsQM4DMUOYwsVMVXZg+hk
	 Ysguppwx5MLZ7nqkzoNm6KVcsQyD1duKjxaGO9uROHAWzxNhhjcIo3mi8NBxWF8iGX
	 L7SVMWaXE5a6rcslOr7a52q03qhZRWAmm3+etAOqsLUECj0fgE4sE3mFHmG+a45JU8
	 koV6dblnu4E+yajaDlkBeR77KLV26s74S70czgO53cDOlBVRSLXIrfZO+3uTahKB8w
	 DmM8F5p5XGbMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31D1040A0F;
	Wed, 18 Nov 2026 15:45:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D7458A0E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3EF2810A1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:45:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fb7eSAbCm4wk for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:45:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD5E88122B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=ouH69zrY
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD5E88122B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:45:55 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=ouH69zrYa2jBspcoHCYKeERefgy34n6u+j3GvZlBcwhASyK0LfvRTqthqIvnm2xXad0WDZyhlv6kHNn4OsY5aQ7rxWbEjMKy/cMP8bxuvdJGPLHOALKL+rH6UA+mAVtBDxKLUROjqt8+md5xqR9YGKUiYf3CKTjYfYJGLcSE08k=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=ZfGzXg/wO/qa3r95tNO4RS0pM2iy2tLBVTdjtNx7tz4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795016738926281.829635554231;
 Wed, 18 Nov 2026 07:45:38 -0800 (PST)
Date: Wed, 18 Nov 2026 15:45:20 +0000
From: Yao Zi <me@ziyao.cc>
To: E Shattow <e@freeshell.de>, Martin Husemann <martin@NetBSD.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: Re: StarFive VisionFive 2: NVME not responding randomly
Message-ID: <av3IEIY_T08Dv1xY@pie>
References: <avxWs2PzYcvPidNw@big-apple.aprisoft.de>
 <5e9eeca5-6772-4aae-b2a7-d49b1676f6d5@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e9eeca5-6772-4aae-b2a7-d49b1676f6d5@freeshell.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.994.34
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:55:36PM -0800, E Shattow wrote:
> Hi Martin,
> 
> On 11/17/26 05:29, Martin Husemann wrote:
> > Hi folks,
> > 
> > I boot my StarFive VisionFive 2 from NVME usually, but "sometimes"
> > (which is actually qite often) u-boot does not recognize the NVME
> > and can't read the partition.
> > 
> > Full boot lo of a working boot below. When it doesn't work it
> > says:
> > 
> > [..]
> > USB XHCI 1.00
> > Bus xhci_pci: 2 USB Device(s) found
> >        scanning usb for storage devices... 0 Storage Device(s) found
> > Working FDT set to ff6f4430
> > Hit any key to stop autoboot: 0
> > Card did not respond to voltage select! : -110
> > Card did not respond to voltage select! : -110
> >     <------- all normal untill here, now the difference starts:
> > ** Invalid partition 1 **
> > Couldn't find partition nvme 0:1
> > ** Invalid partition 1 **
> > Couldn't find partition nvme 0:1
> > Cannot persist EFI variables without system partition
> > ** Invalid partition 1 **
> > Couldn't find partition nvme 0:1
> > ** Invalid partition 1 **
> > Couldn't find partition nvme 0:1
> > ** Booting bootflow '<NULL>' with efi_mgr
> > Loading Boot0000 'nvme 0' failed
> > EFI boot manager: Cannot load any image
> > Boot failed (err=-14)
> > 
> > 
> > I tried everything obvious: software reset, reset button, removing power for
> > a minute - nothing made a difference. Sometime later it just works again.
> > 
> > I can build a debug version, but would like to hear some hints what
> > debug stuff I should enable for that, or any hints where to look.
> > 
> > Thanks,
> > 
> > Martin

...

> My understanding of PCIe on JH-7110 SoC is there's a hardware design
> flaw and the "fix" is a delay-and-wait that was rejected by Linux
> upstream. This presents more readily with *some* NVMe drives. It was a
> hot topic for discussion and based on that I selected Samsung 970
> EVOPlus 500GB and 250GB models and I've never had an issue appear with
> the 250GB on which I do all my RISC-V development as with a Home
> Assistant Yellow baseboard hosting the Milk-V Mars CM Lite (JH-7110 SoC)
> system-on-module.
> 
> Is this the issue you're experiencing? What exact make/model is that
> NVMe module?

I don't think these are likely the same. The issue E referring to is
probably mentioned in this patch[1], which says,

> As the Starfive JH7110 hardware can't keep two inbound post write in
> order all the time, such as MSI messages and NVMe completions. If the
> NVMe completion update later than the MSI, an NVMe IRQ handle will miss.

and its follow-up[2] adds,

> Not any two of inbound post requests can`t be kept in order in JH7110 SoC, 
> the only one case we found is NVMe completions with MSI interrupts.
> To be more precise, they are the pending status in nvme_completion struct and
> nvme_irq handler in nvme/host/pci.c.

So it's the order between writes for MSI interrupts, and writes for
MSI completions, that could be broken.

However, IIRC, U-Boot's NVMe driver always polls for updates to the NVMe
command ring, which is natural since we don't have any interrupting
facilities at all, so it's impossible for us to suffer from any kinds of
ordering issues related to interrupts.

> -E

-- 
Thanks,
Yao Zi

Meow-mrrp-mrow, I'm a cat.

[1]: https://lore.kernel.org/linux-pci/20240227103522.80915-23-minda.chen@starfivetech.com/
[2]: https://lore.kernel.org/linux-pci/ZQ0PR01MB0981BC562E837B232B419AC28229A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn/
