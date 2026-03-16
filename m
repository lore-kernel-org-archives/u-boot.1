Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 913DCEFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D12F83F86;
	Mon, 16 Mar 2026 09:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="DJLuH17P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DE683F8A; Mon, 16 Mar 2026 09:26:42 +0100 (CET)
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch
 [79.135.106.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD6083F14
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1773649598; x=1773908798;
 bh=kGaYVga24QKo29jXiT0L2Is8woswWwnH5N27TqRadkA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=DJLuH17PGOXfSQdpS3QftcLb4JFUuz5E8sqvjOJGdsCy3WiERkLZthg7cNjhBdqzC
 7uPT+LEhBdR6oFDev8zecppzmrjT8Sqm2CeWv0ZBQe2KnvrGIkiJ1dSgqW1NxIR6wo
 GiV1uuflbiZZPb8nsEMLLCCW1Emy2cxL8eK0/QKE76Fs5/zntDJNFmxOs17JIw9h/Y
 BuUaT+373HORmRok0bwNGtCXUz0WEOZqRBN25AMQC4qNTIe2XkN9iXoE0SAn33Rydy
 Fv6jpH5EaGU58NV1iYl3vsjBixCkwoyXbXqhN+6+/gl+fW8LCuHDjTAqrRVZd98tNC
 hPpejbp+l5S7g==
Date: Mon, 16 Mar 2026 08:26:33 +0000
To: Peng Fan <peng.fan@oss.nxp.com>
From: Philip Molloy <philip@philipmolloy.com>
Cc: u-boot@lists.denx.de, linux@analog.com, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/4] Minor i.MX DDR init clean-up
Message-ID: <Y6hN4uV7tikRwtjm1nX1cDbhhVC3352WFGnHMYBU7An9v9t_1qGkuXK4TtvmbAXLcN5xKP0e36z0Km8ig9FYXRAnxgEjVjiEdL2Ue7Mi9RU=@philipmolloy.com>
In-Reply-To: <aa5ZdyTtUwe5NReJ@shlinux89>
References: <20260306085824.886254-1-philip@philipmolloy.com>
 <aa5ZdyTtUwe5NReJ@shlinux89>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: 31e04ebba890f80cafb5c03aa07549e6a668326e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Peng,

Thanks so much for the quick reply!

On Monday, March 9th, 2026 at 6:22 AM, Peng Fan <peng.fan@oss.nxp.com> wrot=
e:
> Hi Philip,
>=20
> Thanks for your patches!
>=20
> On Fri, Mar 06, 2026 at 08:58:27AM +0000, Philip Molloy wrote:
> >This series makes minor clean-up changes to the i.MX DDR init code.
> >
> >Unfortunately, I don't have access to any NXP hardware. I ran into LTO
> >issues with my Fedora toolchain building imx8mm_evk_defconfig. And
>=20
> Would you please share the error logs?

Digging a bit deeper now I came across the following Fedora issue:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2357465

> >binman issues because of missing binary blobs with some imx9*
> >defconfigs. But compilation was successful.
>=20
> Right, the ddr binaries are out of tree.
>=20
> >To support an upcoming ADI SoC that also uses LPDDR4 and Synpsys IP I
> >would like to leverage the i.MX implementation. Therefore this clean-up
> >can also serve as a kind of pre-RFC. I would love to know if the
> >maintainers are open to transitioning to a more generic implementation.
>=20
> If most code could be reused by ADI SoC, that is good to have a generic
> implementation to avoid code duplication.
=20
Great to hear! Hopefully I can submit something before the end of April.
