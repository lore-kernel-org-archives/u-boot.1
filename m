Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCB3C88CB2
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 23:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4DC86977;
	Fri, 25 Aug 2023 01:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Js8ulmoQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C24486977; Fri, 25 Aug 2023 01:31:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD0DB86828
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 01:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D77956141D;
 Thu, 24 Aug 2023 23:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2119FC433C8;
 Thu, 24 Aug 2023 23:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692919895;
 bh=PA7mvxQ0rnNIOfheBu1/Oe5XnzM5X3HCdctz/k9pX20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Js8ulmoQz40zcwvMIrcEgPN4DfWQJ1kGYjOkxVkiuXs/TkJsXC9yyHhj+hYoDBt4m
 eEtl3J1Cvw7qROBypUceHBM+38mx4dCX4yjNEriVMj1jWPpiwKg1/6icdJwLFMZ3/d
 tWciioIRv+YRmzOvZ41GsUiCdVxw76yGcMOe774T/IZtdVfHnTLqTFPmzwFzNEUGkJ
 i5++wOy40ADKznYr0Ob0TVQyg36f7Uy6ExVFJv+MTx/2ikCG1OlG4NGy5kNJeknWJg
 tYXn3LKhPPkihjJFatb9dIVNrb4px8RAYpDIbx3pxDBlNwzgEdhdBkPiHPNKdDX3u/
 woy0emcnCMk1A==
Received: by pali.im (Postfix)
 id 648729D2; Fri, 25 Aug 2023 01:31:32 +0200 (CEST)
Date: Fri, 25 Aug 2023 01:31:32 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230824233132.q34cjb7hqlavioue@pali>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
 <20230823201400.m4l6hl7zy6x6srzd@pali>
 <c1ed8f80-5752-df54-192d-c1b8c16e4f28@canonical.com>
 <20230823203526.domqjv74ttdwfo73@pali>
 <bbdab138-2499-ad95-d4a8-dfada7e72651@denx.de>
 <20230823205506.oboh4hxdxdi4oalj@pali>
 <6b9634d5-e87f-9605-c236-49ad9f29a263@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b9634d5-e87f-9605-c236-49ad9f29a263@denx.de>
User-Agent: NeoMutt/20180716
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

On Thursday 24 August 2023 15:06:44 Marek Vasut wrote:
> On 8/23/23 22:55, Pali Rohár wrote:
> > On Wednesday 23 August 2023 22:46:13 Marek Vasut wrote:
> > > On 8/23/23 22:35, Pali Rohár wrote:
> > > > On Wednesday 23 August 2023 22:32:18 Heinrich Schuchardt wrote:
> > > > > Looking at the MAINTAINER file it seems that POWERPC should be set to
> > > > > orphaned.
> > > > 
> > > > And this is only just because of your fault folks here, as you have been
> > > > completely ignoring any my patches for improving this situation here and
> > > > finally after more than year of my reminders more of you wrote me
> > > > officially that would ignore any changes from me.
> > > > So go and complain to somebody else, not me.
> > > 
> > > Why not pick up the PPC maintainership yourself ? You are qualified enough I
> > > think.
> > 
> > I'm not sure if you cannot read or understand above written text, but I
> > will repeat it once again and the last time specially for you: I'm not
> > going to send any changes, improvements or fixes to any people anymore
> > who either implicitly or explicitly wrote that will ignore me or my
> > contributions.
> 
> So pick up the PPC maintainership, apply the outstanding patches, send a PR
> to Tom and problem with stuck patches is solved. Why not do it this way?

As you have proved that you are either troll or continuously trying to
make me a fool, you have been added to the black list of idiots. Do not
contact me again.

> > > There is a whole thread on frustration about getting patches reviewed and
> > > upstream here too:
> > > 
> > > https://lore.kernel.org/all/20230816180808.GB2919664@perftesting/
