Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F67CD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D320D81E18;
	Tue, 12 May 2026 07:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MiFLJmGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E96783015; Tue, 12 May 2026 07:08:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E12803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:08:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5699543325;
 Tue, 12 May 2026 05:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8EAC2BCB0;
 Tue, 12 May 2026 05:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778562518;
 bh=wSeK3do1x1Ea0BOVPWel9RfdmsIhgzAE0a/DTmia4ww=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MiFLJmGnFBuz+dHlFuleWi/cTH6yHdA1VHABpe0lx6CYTL6Kx4Q2DquE4Dj7e7ii6
 NcMmrFIgkgTIlkeazuXfHjiAn5LlBs3hK60+h5oOjaNQgIGoQQQrz0nWMHe+KY0XgG
 AL1mqYBm7dznWqmrJJiph2t4+qu28y/2tk+W6iNLj+DP3/W7dgraMN8y71Fe3WNQ+v
 8YyqvzetxSPFMyQDgmm6APJrubbYs3yJKs7+7viNJ9+qQ5iqQ+2lHrHm8sH8zS4KSb
 oJrt1LiF0sCe9Yc9806sd+0t2M4l4l7YSh/9ix23GDXVzKeqBo9OpNED73aZEnyEqe
 24etXCnMu1U0w==
Date: Tue, 12 May 2026 10:38:29 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Michael Srba <Michael.Srba@seznam.cz>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH v7 09/11] mach-snapdragon: add board_spl.c and split out
 common code
Message-ID: <agK1zQWeFmaEfs-J@sumit-xelite>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-9-7d0e22aaaa8f@seznam.cz>
 <d965e291-51eb-4120-8740-1f14d739bc5c@linaro.org>
 <6bc4f999-b37f-4961-9bed-17d45e1b77ac@seznam.cz>
 <85e696ff-e66c-4cd3-92d7-61edfe6493ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85e696ff-e66c-4cd3-92d7-61edfe6493ab@linaro.org>
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

+ Varda

Hi Casey,

On Mon, May 11, 2026 at 04:00:46PM +0200, Casey Connolly wrote:
> 
> 
> On 11/05/2026 15:55, Michael Srba wrote:
> > 
> > 
> > On 5/11/26 15:33, Casey Connolly wrote:
> >> Hi Michael,
> >>
> >> On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
> >>> From: Michael Srba <Michael.Srba@seznam.cz>
> >>>
> >>> Code in board.c will now only be compiled into U-Boot proper,
> >>> and the new board_spl.c will only be built into SPL.
> >>> Code in board_common.c is common to both phases.
> >>>
> >>> Also split out mem_map.c, which is currently common to both
> >>> phases since it seems to not cause issues in SPL. In the future
> >>> it should probably behave differenly in SPL, especially if dram
> >>> initialization is supported.
> >> Sorry to be a pest with this one, could you rebase this on the SMEM
> >> series since it also pulls out all the memory mapping stuff.
> >>
> >> Since the only thing you left in board_common.c is the board_usb_init(),
> >> it seems like it's only actually used in db410c at least according to a
> >> quick grep. Could you just move it over to board/qualcomm/
> >> dragonboard410c?
> >>
> >> Along with the other changes maybe most of the contents of board_spl.c
> >> should go into some board/qualcomm/sdm845-spl/board.c file or something?
> > but there's nothing sdm845-specific about it? SPL won't ever be passed
> > dt by a previous stage, empty board-init is a sensible default even
> > if someone wants to override it in specific cases, reset-cpu is a stub and
> > if qcom wants to implement it there's no good reason to use PSCI for that
> > so it can be universal (though an ifdef for the non-typical case
> > of late-in-the-chain SPL would probably still be cleaner than multiple
> > separate board.c files), and fully implemented spl_boot_device should check
> > what medium the BROM booted from (or at least if it was EDL, which is
> > in a hw register, not sure if emmc vs ufs vs sdcard vs spi needs awareness
> > of data passed from PBL), so again can be perfectly shared.
> > If DFU is not enabled in config then the USB boot branch can even
> > be ifdef'd away at compile time.
> 
> Alright, I'm a bit unsure how Qualcomm want to base their stuff on top
> so I'll defer to you and we can keep this as-is. fwiw the "sdm845-spl"
> naming is just arbitrary, if you can pick a better name please do.
> 
> Sumit: any thoughts on how to align these approaches and keep it all
> maintainable?

Yeah I earlier asked Michael and Varda to converge on common Qcom SPL
architecture which can be used across SoCs.

Basically how I think the way forward here would be to have a common
Qcom SPL architecture which would then have the platform specific hooks
for functionality currently supported by that platform. Once more
platforms try to use the same functionality then we can migrate that to
common code.

Looking at Michael's series, I think it's mostly doing the base
infrastructure SPL setup without much boot functionality added. So we
should be able to merge that once it's rebased on your SMEM patch-set.
Then Varda should be able to rebase the IPQ series on top of it. I think
the QCLIB blob loading for DRAM setup can be a platform specific hook in
the common SPL code overriden for IPQ platform for now.

Michael, Varda,

Let us know if there are any concerns to approach mentioned above.

-Sumit
