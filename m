Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640DFC5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:22:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E13583A5E;
	Fri, 20 Feb 2026 10:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EalqzbFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1785C83D0F; Fri, 20 Feb 2026 10:22:49 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C10E383A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 862FA60054;
 Fri, 20 Feb 2026 09:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD6DC19424;
 Fri, 20 Feb 2026 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771579365;
 bh=WsTClPfUCljZfCFqZ6oaQwKN+RvyXNi39F5R8jEanqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EalqzbFXniXg9bsnSWpf314FYb7sIne+AlSYzJRHJyd65wrmpwW1Mee3qgUkLTsaY
 TMQDfamUdUxw/JXe24u+yL7+E/uMvtFjpJi195a/DowHyAa1htE7xbLM31DaEs9FPH
 cgrNB3PZAqUpkpspVvDw/MEfIdy5e2bsrZUAnWbp2BBbeHtmjftoRLKi+yVKe9eUYV
 GjreMgIsR/rAEeOmXRx0pUgrtEbEIQcFBpIUG2y0isQgHz8yv47Svg3L4MVQrbEbwK
 pFD4h5qhTAldLlcVuZM2ir62JrErjwgOeC1LXzPa9xYOXc0mMj9w+47rcG2SaMRhM8
 LRAWtYeHO2TtA==
Date: Fri, 20 Feb 2026 14:52:36 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 casey.connolly@linaro.org, u-boot-qcom@groups.io,
 trini@konsulko.com, xypron.glpk@gmx.de, sjg@chromium.org,
 michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v3 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
Message-ID: <aZgn3J-cwiWv05TC@sumit-xelite>
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
 <20260213110527.1254098-2-aswin.murugan@oss.qualcomm.com>
 <CAC_iWjKzr_nYSJft_HbkHB+F5UKiPBr3sdEZ5vc=gTT-p+WFMA@mail.gmail.com>
 <174996d6-a4c2-4cf2-b25d-b59a9d7dd767@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174996d6-a4c2-4cf2-b25d-b59a9d7dd767@oss.qualcomm.com>
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

On Wed, Feb 18, 2026 at 12:36:51AM +0530, Aswin Murugan wrote:
> 
> On 2/13/2026 4:55 PM, Ilias Apalodimas wrote:
> > Hi Ashwin
> > 
> > On Fri, 13 Feb 2026 at 13:06, Aswin Murugan
> > <aswin.murugan@oss.qualcomm.com> wrote:
> > > The current PSCI-based EFI runtime reset implementation is always enabled
> > > when CONFIG_PSCI_RESET is set, but it does not support the extra arguments
> > > required for specialized reset modes. As a result, reboot requests such as
> > > bootloader mode or EDL mode are ignored and fall back to a normal reboot.
> > > 
> > > Add CONFIG_EFI_PSCI_RESET_RUNTIME to give platforms explicit control over
> > Is there anything missing and you can't use EFI_HAVE_RUNTIME_RESET?
> Thanks for the feedback, Ilias
> This is a kernel‑level limitation based on drivers/firmware/efi/reboot.c [1]
> implementation in Linux. The efi_reboot function intentionally ignores the
> reboot data string and always passes NULL to ResetSystem. As a result,
> special reboot modes like "bootloader" or "recovery" aren’t forwarded
> through EFI_HAVE_RUNTIME_RESET.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/efi/reboot.c?h=v6.13#n46
>

Yeah I know about that limitation for which the right EFI approach to
use is EFI_RESET_PLATFORM_SPECIFIC. I tried to implement it here [1] but
looks like needs a bit more testing from UEFI implementations. Would you
be able to give that approach a try?

Having EFI runtime reset service exposed to OS is certainely better than
OS trying to rely on platform/PSCI specific reset approaches.

[1] https://lore.kernel.org/all/20251114085058.2195900-1-sumit.garg@kernel.org/

-Sumit
