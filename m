Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18383C44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9B384D41;
	Tue, 14 Jul 2026 19:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="onX2EwFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861E184D22; Tue, 14 Jul 2026 19:26:39 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC52984D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784049991; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=llRlK4sz7i89G5t+fqzOnZTsthtQhU4vISHDJ5JZMgYGGIW/yTDdvrmSOJdU+V32C1VtLofEH4HXeoduFFUYCbQR3Z3WMAnJO9mwfXG0XjlkVgPVSsHfGNdHeuIyVwcOB7UefCizDol32DeqT9LD7Yoe8xOaNV0pCzX4Co7qoxU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784049991;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=75h9qH7sKN6yp2gFURYrwKQJvPcEoPN3IXqj/ba1iuE=; 
 b=KIYh8l3gWtVSUPDhmoHljIrdiVR8+hb544jV0owMbGflaIb0bDHoZ+Dqdag4EiydoySdHAbigM114Ww8m3NQPNbiG2hae96bZIxaIw7fgw8RW0/MNmH9AkKUtqkEbYbTadzBrgf9Kh17MQMwaSBPzrjy+8/S8H9x1qpDUPT4Md4=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784049991; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=75h9qH7sKN6yp2gFURYrwKQJvPcEoPN3IXqj/ba1iuE=;
 b=onX2EwFlQcPy1+/ip7w61FPLxai/aBpMoCUFbnkxp4np1qVJvf82FhcFToiJB/gM
 PKI9YV/28KKSUQeYQQIahdj4CQh6RjE2KVVGVucUkmnBn2DFu09V1Rd8FGsnuj7ivvI
 7irMc4Zvt1K2uvpMBU6XoB5Az7rKrjodAKsAa1KU=
Received: by mx.zohomail.com with SMTPS id 1784049988532746.7993877592895;
 Tue, 14 Jul 2026 10:26:28 -0700 (PDT)
Date: Tue, 14 Jul 2026 17:26:22 +0000
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/16] LoongArch initial support
Message-ID: <alZxPrNmjeVSsTUv@pie>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701175926.GS749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701175926.GS749385@bill-the-cat>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Wed, Jul 01, 2026 at 11:59:26AM -0600, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 11:17:52AM +0000, Yao Zi wrote:
> 
> > Hi all,
> > 
> > After talking to Jiaxun privately, I decided to take over the series.
> > 
> > So far this series has implemented general support for initializing CPU,
> > exceptions, kernel booting, CPU and timer drivers, QEMU LoongArch virt
> > machine support and UEFI standard compliant EFI booting support.
> > 
> > LoongArch had defined 3 ISA variants, LA64, LA32 and LA32R (Reduced,
> > intended for MCUs and education purpose). This is a little-endian only
> > architecture. Only LA64 is implemented in this series since the hardware
> > is more widely available, and I'll work on 32bit support later.
> > 
> > This series had passed checkpatch with exceptions on some false alarms
> > and headers imported elsewhere. I've tested virtio devices, direct
> > kernel booting, efistub kernel booting and grub. For loongarch64 CI, I
> > would continue to work on Jiaxun's another series[1] soon.
> > 
> > Toolchain can be found at [2] or using upstream one, to build
> > 
> > 	make qemu-loongarch64_defconfig
> > 	make
> > 
> > To run in QEMU:
> > 
> > 	qemu-system-loongarch64 -nographic -machine virt -bios u-boot.bin
> 
> So on this note, we need to also have changes for:
> - buildman to fetch the toolchain, which is easy since it's part of the
>   normal kernel.org ones.
> - tools/docker/Dockerfile to fetch the toolchain, for CI
> - Changes to .gitlab-ci.yml and .azure-pipelines.yml to build loongarch
> - Changes to those files to also fire off QEMU for loonarch
> - Changes to https://source.denx.de/u-boot/u-boot-test-hooks to support
>   the previous requirement.

Okay, I've talked to Jiaxun and will also continue to work on his
previous series[1] to add CI stuff.

> > 
> > TODOs on the architecture & board:
> > - loongson,ls7a-rtc driver
> >  - The only device on QEMU board haven't been supported yet
> > - LoongArch sandbox host support
> > - TLB enablement
> >  - This is required for real CPU to utilize caches
> > - Possibly EFI-APP support for real machine
> > 
> > I have one question regarding the process: I've decided to
> > coordinate with Jiaxun to maintain the loongarch port, and AFAIK we
> > would need a custodian tree on U-Boot's GitLab instance in order to run
> > CI. If this true, what's the process of creating a tree?
> 
> I can work with you both off-list to get one created.

Thanks, should we contact with you now so I could include a MAINTAINERS
patch with correct git URL in the next version, or wait until this
series gets merged?

> -- 
> Tom

Best regards,
Yao Zi


[1]: https://lore.kernel.org/u-boot/20240717-docker-image-v1-0-7c7fc6251e7a@flygoat.com/
