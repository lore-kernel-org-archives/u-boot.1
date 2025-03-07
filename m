Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F858C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 06:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DA480F4C;
	Fri,  7 Mar 2025 07:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eKtchZHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD6E810DC; Fri,  7 Mar 2025 07:16:49 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E6D480E94
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 07:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 66F8BA454EB;
 Fri,  7 Mar 2025 06:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73485C4CED1;
 Fri,  7 Mar 2025 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741328201;
 bh=jK73m508rlEeELzvmo+r72pTS0WlKlPvZDVvM3ebXUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eKtchZHz/1iuS2lORUhSZrMiuKJQwF0UHIL5zthiJB1A3tI1VYWZB+p6GUWGvJeOb
 UMJZy0IpPFGeHNBIdTZM0qsqmcyoL+nS3cAm2N5Two5ee/8D+giE2eGhVysfHAqEEJ
 H7Xt5lljov2OHHR/kZtn3fJwmQvTL1o56vrw0hkg3ntcJYZ8f+RcjNSWP1VWqWR/SA
 xc2e1XhVQp0ypNGFZ7j2dNFdhAj3En1cyHZRRPNO0JoWQ85hfORwrLkwEouD6z2Yn2
 pyxr7J49QyutZ7Pq2NwGlE340Oar8I14Cp3vk8MbpPsrYxDLkY9hOhfEOKlU9+rGds
 SaRSOUbNuOqcQ==
Date: Fri, 7 Mar 2025 11:46:31 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Manikandan.M@microchip.com
Cc: eugen.hristev@linaro.org, lukma@denx.de, seanga2@gmail.com,
 sumit.garg@linaro.org, kever.yang@rock-chips.com,
 marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, festevam@denx.de,
 Oliver.Gaskell@analog.com, aford173@gmail.com,
 prasad.kummari@amd.com, caleb.connolly@linaro.org,
 andre.przywara@arm.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, Nicolas.Ferre@microchip.com,
 Mihai.Sain@microchip.com, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to
 at91-pmc-status.h
Message-ID: <Z8qPP6Z-DpMFdiKX@sumit-X1>
References: <20250305060711.1127301-1-manikandan.m@microchip.com>
 <20250305060711.1127301-2-manikandan.m@microchip.com>
 <Z8lH93V9DUfdoiLd@sumit-X1>
 <02132f8e-79b2-4b47-b4d4-60bb9c9a793f@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02132f8e-79b2-4b47-b4d4-60bb9c9a793f@microchip.com>
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

On Thu, Mar 06, 2025 at 10:39:28AM +0000, Manikandan.M@microchip.com wrote:
> Hi Sumit,
> 
> On 06/03/25 12:30 pm, Sumit Garg wrote:
> > [Some people who received this message don't often get email from sumit.garg@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Manikandan,
> > 
> > On Wed, Mar 05, 2025 at 11:37:04AM +0530, Manikandan Muralidharan wrote:
> >> Rename the include at91.h to at91-pmc-status.h to avoid conflicts with
> >> the upstream bindings that has the same file and update the
> >> relevant legacy SoC Device Trees to reflect this change.
> >> This is useful while compiling the DT and driver of the new SoC files with
> >> OF_UPSTREAM enabled.
> >>
> >> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> >> ---
> >>   MAINTAINERS                                             | 2 +-
> >>   arch/arm/dts/at91-sama7g5ek-u-boot.dtsi                 | 2 +-
> >>   arch/arm/dts/at91sam9260.dtsi                           | 2 +-
> >>   arch/arm/dts/at91sam9261.dtsi                           | 2 +-
> >>   arch/arm/dts/at91sam9263.dtsi                           | 2 +-
> >>   arch/arm/dts/at91sam9g45.dtsi                           | 2 +-
> >>   arch/arm/dts/at91sam9n12.dtsi                           | 2 +-
> >>   arch/arm/dts/at91sam9rl.dtsi                            | 2 +-
> >>   arch/arm/dts/at91sam9x5.dtsi                            | 2 +-
> >>   arch/arm/dts/sama5d3.dtsi                               | 2 +-
> >>   arch/arm/dts/sama5d3_mci2.dtsi                          | 2 +-
> >>   arch/arm/dts/sama5d3_tcb1.dtsi                          | 2 +-
> >>   arch/arm/dts/sama5d3_uart.dtsi                          | 2 +-
> >>   arch/arm/dts/sama5d4.dtsi                               | 2 +-
> >>   include/dt-bindings/clock/{at91.h => at91-pmc-status.h} | 0
> >>   15 files changed, 14 insertions(+), 14 deletions(-)
> >>   rename include/dt-bindings/clock/{at91.h => at91-pmc-status.h} (100%)
> >>
> > 
> > AFAICS, include/dt-bindings/clock/at91.h is just a subset of
> > dts/upstream/include/dt-bindings/clock/at91.h. If that's true then we
> > should just be able to drop local include/dt-bindings/clock/at91.h from
> > U-Boot tree. Won't that just work fine?
> 
> 
> Yes, you're right. It's a subset of the upstream at91.h. However, we 
> must retain it due to dependencies with legacy SoC files that haven't 
> yet been migrated to OF_UPSTREAM. I believe migrating those files now 
> would introduce a significant number of changes w.r.t Device Tree files."
>

It's not required for SoCs to be migrated to OF_UPSTREAM to start using
upstream bindings. The DT bindings headers are meant to be stable and
reusable such that we don't have to maintain duplicated headers.

-Sumit
