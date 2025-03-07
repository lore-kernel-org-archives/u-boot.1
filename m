Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AEDC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 11:15:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC16780E94;
	Fri,  7 Mar 2025 12:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="K16stKq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A892980F0B; Fri,  7 Mar 2025 12:15:55 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF1AF8003E
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 12:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 973BF20272;
 Fri,  7 Mar 2025 12:15:52 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxEhn4RGEwCd; Fri,  7 Mar 2025 12:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741346147; bh=d6Gr5mIMQ5Knvi79FcjHM61L1e0ZtGO+sLbGwBJEZWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K16stKq9/UcLSrQ8YLvSAEaKIqR2r0L4quMU57JKDFapirkKzJ9je+xS4R31OSzul
 PGDDZmSAii3yOGQikoXU7ApTlJZ9p0u5tGzretABIOwWpkfF5aUJX6PhzVlh51A4XR
 jA1EHKgZ8F9X+SItXGEGT1LxlAWNXLK1K3FS5xOAvh95/orJfP9jNXfKdZq+Sc1XoR
 WLOuvGMZRx1FZBJ65E9xi0hoUjmOYswh8/051zqSAFSKjEjwxT+Y18FHQwmPRJLBy5
 aIFa9YUIBDxoyn8syy75GYv0tPHK2T07bOaUGxfoOCyRu8VAimUXwjFxhjFLF7s/N0
 nQUXd2xOEcZYw==
Date: Fri, 7 Mar 2025 11:15:26 +0000
From: Yao Zi <ziyao@disroot.org>
To: Leo Liang <ycliang@andestech.com>
Cc: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 "Angelo Dureghello" <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 5/5] riscv: select OF_HAS_PRIOR_STAGE by default if SBI
 is enabled
Message-ID: <Z8rVTvohydhmsHso@pie.lan>
References: <20250227144734.61458-1-ziyao@disroot.org>
 <20250227144734.61458-6-ziyao@disroot.org>
 <Z8mCUtgAW2qujI13@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mCUtgAW2qujI13@swlinux02>
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

On Thu, Mar 06, 2025 at 07:09:06PM +0800, Leo Liang wrote:
> On Thu, Feb 27, 2025 at 02:47:33PM +0000, Yao Zi wrote:
> > Availability of RISC-V SBI service implies a prior stage exists. As SBI
> > firmware usually passes a FDT to the loaded program, let's select
> > OF_HAS_PRIOR_STAGE if SBI is enabled.
> > 
> > With previously added fallback version of board_fdt_blob_setup, S-Mode
> > RISC-V ports use the SBI-provided FDT by default. This covers the most
> > common usecase, where a SPL (probably the U-Boot one) selects proper
> > devicetree, loads SBI and U-Boot then invokes SBI with the devicetree.
> > 
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Hi Yao,
> 
> This patch would fail some of the CI tests.
> I will take other patches from this patchset first,
> and could you take a look at the CI tests issue ?
> (https://source.denx.de/u-boot/custodians/u-boot-riscv/-/jobs/1049827)

After digging further with the failure, I found the series has two
problems,

- OF_HAS_PRIOR_STAGE is an option shared between XPL and proper U-Boot.
  The generic board_fdt_blob_setup() doesn't work in a XPL build,
  corresponding checks should be added.
- The default binman configuration for RISC-V platforms doesn't pack the
  FDTs into the fit image if OF_HAS_PRIOR_BOARD is enabled

Although it doesn't break anything to merge the first four patches for
now, I'd like to rework PATCH 1 and add a check against XPL build in the
new revision. Then we could merge a patch that is technically right and
avoid fixes tags.

Additionally, I found OF_BOARD is actually disabled on Unmatched and
Unleashed and the board_fdt_blob_setup() here is dead code in fact. Thus
the commit message of PATCH 4 should be fixed as well.

> Best regards,
> Leo

Best regards,
Yao Zi
