Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED0CC55838
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D40CB40670;
	Tue,  4 Aug 2026 02:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UKloLLI8Q5ZN; Tue,  4 Aug 2026 02:15:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFFFC405E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809701;
	bh=wPoIOcG9qK0f3HNi1KyGtz++1OOA7Sa/7Y2bnR+v5BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WwN9i42qSJ0e8Hq3m6moYOi7+VeLTTBx1wYKIbZZU4SI1fB2O8ZfJ09ig+sFUdOz3
	 erxdCWT46veyQ2C0HS7RkfYPUlpETBq2xcwm0tWp2zfBm2uPbu6o8FKvq+3ALd8om3
	 3VeCsUj7K3P8mdLIgDqWeY2FSdMj7pLNRJYvLr3Els74L7cnfmS9tcnSx8ZgfsaRmE
	 lwVLTkxFbSJnh+cxuWxj2jGpUypxQ1GkyTeMUeOFrPREVSF3Bo79tYq3UP4Z3xZ+4/
	 M3d2IcTFyeoijLdDBI0Qp52/zzQAIbFg9ikpcFSXHDv9f0p98ANPO61Eo1b30Zvs8A
	 RT2u0jER08cVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFFFC405E8;
	Tue,  4 Aug 2026 02:15:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CFC7F218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B543680AC4
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O0MlbgnP8-cb for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:15:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=elliotjb+anduril@elliotjb.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1A20680ABD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A20680ABD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A20680ABD
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:15:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F21842FC; Tue,  4 Aug 2026 02:15:51 +0200 (CEST)
Received: from MTA-12-4.privateemail.com (mta-12-4.privateemail.com
 [198.54.127.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFD980087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 02:15:49 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-07 [104.30.160.130])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 4hDYwb0W7Xz3hhTH;
 Mon,  3 Aug 2026 20:15:43 -0400 (EDT)
Date: Mon, 3 Aug 2026 17:15:42 -0700
From: Elliot Berman <elliotjb+anduril@elliotjb.com>
To: Simon Glass <sjg@chromium.org>
Cc: elliotjb@elliotjb.com, u-boot@lists.denx.de, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 3/3] x86: emulation: enable cfi flash drivers
Message-ID: <anEu4G06m4ageNbB@eberman-5690-nixos.corp.anduril.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-3-fb403348e29b@elliotjb.com>
 <CAFLszThnAfwivMS7ReoXkfrfXsFpmnwT0KGR68kLrQPuw+ENMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThnAfwivMS7ReoXkfrfXsFpmnwT0KGR68kLrQPuw+ENMg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:14:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785802547;
 bh=UuysLfbdWP5AHB8IrMrdKmqMZWR1TpqW8rCQAi6Tcpo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OmnpR0nEg1cJas8PPRlqFmV10Mg5EuVFqE31mE4JKSGebWbuMT3rtjL4GQmw5dc5F
 Eqc0H68SAkFGHYVt24q9a08wkuAFnmIURtczI7FSOH9PzlN/GpNm3XE7o/mX4Y/Dnf
 U8TCiCw9sKlc306nIidQGtH6OnGtCntuBvC8vZ6vEEIFDW+8rXOIEJMAY9Y3ZC8fB8
 AkQ/HHpHIQJ3F1grfiQH6sHnVRRTPVM6hX8qcbViEbsHyWx4R9CDQGMYfSC7grFu5f
 zd0inSIV2O9cv8jl5NZLAtz1KBS98EVPuha538mBoAE60WhGmeJxqheJ871FTLGUlG
 zPEdxcTy4WE/Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.a=rsa-sha256
 header.s=default header.b=OmnpR0nE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb+anduril@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="OmnpR0nE";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Mon, Aug 03, 2026 at 01:25:36PM -0600, Simon Glass wrote:
> On 2026-07-30T19:37:45, Elliot Berman <elliotjb@elliotjb.com> wrote:
> > x86: emulation: enable cfi flash drivers
> >
> > Enable MTD/CFI so the pflash node just added for qemu-x86/qemu-x86_64
> > can be probed, matching the flash config qemu_arm64_defconfig.
> >
> > Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> >
> > configs/qemu-x86_64_defconfig | 13 +++++++++++++
> >  configs/qemu-x86_defconfig    | 13 +++++++++++++
> >  2 files changed, 26 insertions(+)
> 
> > diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> > @@ -76,6 +79,16 @@ CONFIG_ATAPI=y
> >  CONFIG_LBA48=y
> >  CONFIG_SYS_64BIT_LBA=y
> >  CONFIG_CPU=y
> > +CONFIG_DFU_MTD=y
> > +CONFIG_DM_MTD=y
> > +CONFIG_MTD_NOR_FLASH=y
> > +CONFIG_CFI_FLASH=y
> > +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> > +CONFIG_FLASH_CFI_MTD=y
> > +CONFIG_SYS_FLASH_CFI=y
> > +CONFIG_SYS_MAX_FLASH_SECT=1024
> > +CONFIG_SYS_MAX_FLASH_BANKS=2
> > +CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
> 
> CONFIG_SYS_FLASH_CFI is only referenced by a handful of legacy m68k
> board headers - it has no effect for a DM CFI-flash setup, so please
> drop it. qemu_arm64_defconfig doesn't set it either.
> 
> > diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> > @@ -76,6 +79,16 @@ CONFIG_ATAPI=y
> > +CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
> 
> qemu_arm64_defconfig doesn't enable this and the emulated CFI pflash
> handles single-word writes fine. Please drop it too so the two
> defconfigs really do match.

qemu_arm64_defconfig has SYS_FLASH_USE_BUFFER_WRITE and SYS_FLASH_CFI
enabled [1]. However, I agree that neither of these are needed for the
x86 defconfigs. I'll drop them in v2.

[1]: https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/configs/qemu_arm64_defconfig#L56-58

> > diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
> > @@ -48,7 +48,9 @@ CONFIG_CMD_CPU=y
> >  CONFIG_CMD_BOOTEFI_SELFTEST=y
> >  CONFIG_CMD_NVEDIT_EFY=y
> >  CONFIG_CMD_MEM_SEARCH=y
> > +CONFIG_CMD_DFU=y
> >  CONFIG_CMD_IDE=y
> > +CONFIG_CMD_MTD=y
> 
> The commit message says this enables MTD/CFI so the pflash node can be
> probed, but you are also turning on DFU, MTD and MTDPARTS commands
> plus DFU_MTD, which exist to make patch 2's capsule wiring work.
> Please either update the commit message to describe the full scope, or
> split the DFU/MTDPARTS bits out.
> 
> Regards,
> Simon
