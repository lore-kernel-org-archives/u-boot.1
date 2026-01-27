Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FED25959
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 08:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DF883FDC;
	Tue, 27 Jan 2026 09:03:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YRCSaPcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CABBF83FC6; Tue, 27 Jan 2026 09:03:14 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3013F83F53;
 Tue, 27 Jan 2026 09:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B213543D0D;
 Tue, 27 Jan 2026 08:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF3EC116C6;
 Tue, 27 Jan 2026 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769500990;
 bh=Y7ewQu4ZtYotEgmEsb6Lk11qKdA2lAUGYAPBg0dj9X8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YRCSaPczsxMZsPNQuEzHTm1nxKEBO6bDFFXVQP6rtrMoyv6cWpWoGri3uy5m/EMlX
 +hf5fBs+MXx6ijvnjiQBIyyIg8Ju4b1gdUTyPPMUEGFz8aCvt0kDVOLlR2GGAJ+x5r
 of4NbjF1AGQDS5hKurFqYsUsDSHh6+QyXUBlr0TuC8ZkTz1OwJFxBX6eiiUahrg361
 Zqo0dTdJ6I11YhKO67uaU35EA/dsIz+u7j6QMC1zZfYFj4PcWvNHdcFZVooDgEv1kt
 TAQPyOxAiSxNf+YEjuMXZZFymzDlRjJklnsdnCtTHh+XD+uSGHKoY83Yz2PEJ5YOy2
 5L64kndczP1yw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: Re: [ANN] U-Boot v2026.04-rc1 released
In-Reply-To: <20260126204548.GX3416603@bill-the-cat>
References: <20260126204548.GX3416603@bill-the-cat>
Date: Tue, 27 Jan 2026 09:03:07 +0100
Message-ID: <87ms1zo538.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Thanks for the update.

On Mon, Jan 26, 2026 at 14:45, Tom Rini <trini@konsulko.com> wrote:

> Hey all,
>
> So it's release day and I have tagged and pushed things out.
>
> First and foremost, this is a bit rougher than I would like but I hope
> that doing the release will underscore the urgency of finishing some of
> these fixes. We now require for our own use to be given a correctly (8
> byte) aligned device tree. This is done in a lot of cases. However:
> https://patchwork.ozlabs.org/project/uboot/patch/20260122172247.2995437-1-b-padhi@ti.com/#3640858
> is needed to ensure that platforms that use a FIT image in the SPL phase
> work.
> https://patchwork.ozlabs.org/project/uboot/patch/20260120153314.95091-2-jamie.gibbons@microchip.com/
> needs to be addressed further to fix the case of platforms which apply
> overlays in FIT images (SPL or OS). This series also shows that if your
> platform does not boot then SPL_MALLOC_F_LEN may be too small.
> https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
> contains some of the discussion around the case of SPL *not* enabling
> SPL_BSS_SEPARATE and so having an incorrectly sized empty BSS appeneded
> to the image.
>
> So, that's the important state of things right now. Some platforms are
> broken. People helping to test the proposed fixes, or if needed, picking
> up the changes and posting the next version of them, would be
> appreciated.
>
> We're continuing with a community meeting following the release and the
> calendar link is
> https://calendar.google.com/calendar/event?action=TEMPLATE&tmeid=MHYzYzQ1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwNmE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.calendar.google.com&scp=ALL
> and once again this is the same time as the previous meeting. The
> meeting details itself are:
> https://meet.google.com/btj-wgcg-euw
> January 26th, 2025. 9am (GMT -06:00)
>
> To join by phone:
> https://meet.google.com/tel/btj-wgcg-euw?pin=1307528552322&hs=1
>
> In terms of a rough changelog:
> - We're on v6.17-dts for upstream device trees/bindings. The v6.18-dts
>   tag will be too late for our release cycle so I expect people to be
>   using the cherry-pick method to bring in dts changes as needed.
> - Lots of platform updates. This is always the case with -rc1 and I
>   never know which ones to emphasize.
>   - That said, we've removed ATAGS support from some platforms as it's
>     very legacy these days.
> - Lots of fixing of issues reported by Smatch.
> - We now support clang-format and prefer that over the old
>   scripts/Lindent option for formatting code.
> - Continued work on improving our old pre-rST docs and converting them
>   to rST.
> - Fixes in our DFU, MMC, PMIC, USB, UBI, SCMI, UEFI and networking
>   subsystems.
> - Some cleanups and improvements to Falcon mode, with the aim of being
>   able to support this feature in secure boot contexts.
> - More patches required for "allyesconfig" to build have been merged,
>   but some are still outstanding.
>
> I continue to plan to do an rc release every two weeks and the final
> release will be 05 January 2026.

I guess you mean 06 April 2026 as stated in
https://docs.u-boot.org/en/latest/develop/release_cycle.html#future-releases

>
> Thanks all!
>
> -- 
> Tom
