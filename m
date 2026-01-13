Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971DFCF45C6
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 01:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F4683700;
	Tue, 13 Jan 2026 02:22:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010168382A; Tue, 13 Jan 2026 02:22:30 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24B8836AC
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from localhost (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 54A253415D9;
 Tue, 13 Jan 2026 01:22:25 +0000 (UTC)
Date: Tue, 13 Jan 2026 09:22:20 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 02/10] sunxi: spl: a733: config text and stack address
Message-ID: <20260113012220-GYA24058@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
 <20251130-01-a733-soc-support-v2-2-18bdd4376fad@gentoo.org>
 <20260102014033.26410b4c@minigeek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102014033.26410b4c@minigeek.lan>
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

Hi Andre,

On 01:40 Fri 02 Jan     , Andre Przywara wrote:
> On Sun, 30 Nov 2025 21:45:11 +0000
> Yixun Lan <dlan@gentoo.org> wrote:
> 
> > Add some ciritial SPL settings for A733 SoC
> > 
> > - Set SPL MAX SIZE to 180KB, 0x47000 - 0x74000
> > - Set SPL running address to 0x47000, with a header padded before
> >   the image, so the final SPL text address need to shift 0x60 bytes.
> > - Set Stack address
> 
> The patch separation for those addresses looks a bit arbitrary, since
> there are other SPL specific addresses in patch 01/10, and we don't
> really support an SPL anyway.
strictly, we still need SPL stage, for cpu to fully switching to 64bit
mode, as the initial brom/boot0 are running in 32bit, also currently I
rely on SPL to chainload u-boot image with CONFIG_SPL_RAM_DEVICE support.

and yes, the only missing part is DDR initialzation in SPL..

> So either drop this patch, or merge it into the previous one.
> 
I will merge them into previous patch, thanks

> Cheers,
> Andre
> 

-- 
Yixun Lan (dlan)
