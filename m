Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B912ECD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DCF8489D;
	Fri, 12 Jun 2026 19:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="GAfN20fH";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="KG4xw6fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEF53846B0; Fri, 12 Jun 2026 17:17:12 +0200 (CEST)
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DF69839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 17:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=agx@sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781277428; bh=VpDSnz+Y5C4y8wDylZuTG33/Ie7HvLA0GwgFVpRQvGg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GAfN20fHv2h9gdvWIZC3Wxhg8r6gQIRyqaGmHw0jPEBU8B11R9t9/YxErdqJrtJWu
 uC9dqszCf695oj9hnw5moWwavQeG25935xVn27OgqvSuiotOMtI3syZC6fRuQwZBHd
 ufcJ0h6DeZaXRtHbkZpANYjG/ElSvVBMcTV38cOvaF2L3pGBF1TG94Ivx0dfBUQ95E
 +QCD35LkPXXArSj4fK5g/NBfXx+dAEFkigQe8gxNYhe5upUC5w5pfAvJTDC8f6Y2B4
 ywbvl869vRPF85Mogo9R6BUqPYQIHwI57afA5C8HWzeFloOODtxXCEWFXNL4FrxKAX
 gpsBqujAEH7DQ==
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 4DAF8FB03;
 Fri, 12 Jun 2026 17:17:08 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yxC2g5NRgZwP; Fri, 12 Jun 2026 17:17:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
 t=1781277426; bh=VpDSnz+Y5C4y8wDylZuTG33/Ie7HvLA0GwgFVpRQvGg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KG4xw6fPMBvinuL69pPWSCJ5NEJy2aQLMNv0B+j9cz56dv1uw0jtMS6FSbWPGcU15
 Iv4FsUXSVl1QQVhgqUAJy0z/NxB+OVE2nZzmTwGpGlberVBhLLi6T1wwmNsHvb0fJj
 NM4UNMUyX6mELSmxGi7ThJzwXGsldyS34jmblgXOtn18xmyrd9eXkDD4gv6lcScLMb
 l/vrLI9t5uT6SjgCgoJP+z9u5i58tkaeDsGDmS5MHW61CkX2HJ4SLEhyCtYismMr3P
 S3F8YZ25vIHevB0BvT22sdKCSBL1nHBYFfygthnqt2zychRkvx5FWPBo00WXysXOLv
 sDCKo5X6uNTKA==
Date: Fri, 12 Jun 2026 17:17:04 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, team@phosh.mobi, Manuel Traut <manut@mecka.net>
Subject: Re: [PATCH] board: purism: Add support for the Librem5 devkit
Message-ID: <aiwi8Mxp8hFvAWkC@quark2.heme.sigxcpu.org>
References: <20260525-devkit-v1-1-2d3e7549ee9e@sigxcpu.org>
 <CAOMZO5DE19HBVk=L35doV0DshnkYZ38Zh0g_N30fHKKAdB1C9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DE19HBVk=L35doV0DshnkYZ38Zh0g_N30fHKKAdB1C9A@mail.gmail.com>
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

Hi Fabio,

(trimmed the cc: list to keep traffic at bay)

On Tue, Jun 09, 2026 at 09:53:08AM -0300, Fabio Estevam wrote:
[..snip..]
 
> > +Get and Build the ARM Trusted firmware
> > +--------------------------------------
> > +
> > +Note: srctree is U-Boot source directory
> > +Get ATF from: https://source.puri.sm/Librem5/arm-trusted-firmware
> 
> Can't the mainline ATF be used instead?

I wanted to switch to
https://github.com/arm-software/arm-trusted-firmware but most of NXPs
boards use ATF from https://github.com/nxp-imx/imx-atf/

What is the recommendation here?

Cheers,
 -- Guido
