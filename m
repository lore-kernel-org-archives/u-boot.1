Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79E3C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE1C87ADA;
	Wed, 25 Oct 2023 16:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="WFh5Xre2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589AF87ADB; Wed, 25 Oct 2023 16:18:25 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183B887AD9
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:18:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 58f44532-7341-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 58f44532-7341-11ee-b94e-005056992ed3;
 Wed, 25 Oct 2023 16:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=eqXCHq3tt+OP0Lkz4+9e5eX/4HC1xPNWCk/u4DBJUng=;
 b=WFh5Xre2Efxs8GlOpIX9EnoXVk3pn3Xi9w+Ce0xyaQRSj55n4m0O+vdkC+xgHlbyhx1hTS3+fdoiZ
 NWwz65kV+ww3SekbBY6PvQN5lF25VMWUo2By7/VQcaKqA0X2oPI4nmkllhfva7cPBmrkCnDhDh7lV+
 pjqCgPHYw3m1/I79i2r9C8s5Uc8M3o4aas9KAF8V/L3+tvm3dAjBl5kfpXzl4xJDb8eiYKMTL0sy+k
 OlVWk3Fp3/Ai5OVRkfw2O9mp1eV184dDwXZjCtoTvzx1UrDmcaj89EqKhslOjJ3X1Y3lmmxiYwJETB
 Cx4GzReASmgg25wo/MK6WCtLK2nQRqQ==
X-KPN-MID: 33|twP2dUfbxx+TN60EWZiyOkq/Vo3dLE/iyTCQMq5P9v5pkD1KZ+TqtDHCwpXY6u5
 IaYvJEHQVyGoSwX7HDZAx4jxdps50c+2nERWzOAuF4O8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|s9oQIa+iukrOmVUA4F4eNh1o+jO7Tyg6zCF91Xip9SMa/eEH/5i1lem6GoL/z/M
 I4/NKUz9eYqprrt5BCvD9fA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 599d0511-7341-11ee-ac7a-00505699b758;
 Wed, 25 Oct 2023 16:18:21 +0200 (CEST)
Date: Wed, 25 Oct 2023 16:18:20 +0200
Message-Id: <87bkcmrdjn.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: sjg@chromium.org, caleb.connolly@linaro.org, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 bmeng.cn@gmail.com, brandon.maier@collins.com,
 kconsul@ventanamicro.com, oleksandr.suvorov@foundries.io,
 patrick.delaunay@foss.st.com, sughosh.ganu@linaro.org
In-Reply-To: <20231024223405.GM496310@bill-the-cat> (message from Tom Rini on
 Tue, 24 Oct 2023 18:34:05 -0400)
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
References: <20231021004522.53311-1-sjg@chromium.org>
 <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
 <CAPnjgZ1Q4y1SvwMa3gRX6Xa=5gP7gTSiQfe83jQ=KQC2K=EG7g@mail.gmail.com>
 <87il6xqrso.fsf@bloch.sibelius.xs4all.nl>
 <20231024223405.GM496310@bill-the-cat>
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

> Date: Tue, 24 Oct 2023 18:34:05 -0400
> From: Tom Rini <trini@konsulko.com>
> 
> On Mon, Oct 23, 2023 at 05:31:19PM +0200, Mark Kettenis wrote:
> > > From: Simon Glass <sjg@chromium.org>
> > > Date: Mon, 23 Oct 2023 00:04:14 -0700
> > > 
> > > Hi Caleb,
> > > 
> > > On Sat, 21 Oct 2023 at 01:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On 21/10/2023 01:45, Simon Glass wrote:
> > > > > U-Boot typically sets up its malloc() pool near the top of memory. On
> > > > > ARM64 systems this can result in an SMBIOS table above 4GB which is
> > > > > not supported by SMBIOSv2.
> [snip]
> > There is absolutely no guarantee that arm64 machines have memory below
> > 4GB.  Examples of SoCs that have no memory below 4GB are AMD's Opteron
> > A1100 SoC and all the recent Apple SoCs.
> 
> So one thing to resolve here is where does that requirement about the
> SMBIOS table needing to be below 4GB come from (standards wise), and in
> turn is that obeyed by consumers like say Linux or OpenBSD? Answering my
> own question, maybe in part, https://www.dmtf.org/standards/smbios reads
> to me like there's a v3 and maybe we should be doing what we need to
> support / identify as that, if it doesn't have that restriction?

Right.  U-Boot implements SMBIOS 2.x which is pretty much obsolete and
uses 32-bit addresses.  SMBIOS 3.x allows for 64-bit addresses.  So to
fix this U-Boot needs support for SMBIOS 3.x.

Personally I don't see why we'd need SMBIOS support on non-x86
platforms, which is why implementing this isn't a high priority for
me.  I simply disabled SMBIOS support for M1 for now.
