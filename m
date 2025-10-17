Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0F5CCD183
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 01:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DF72836D1;
	Fri, 17 Oct 2025 03:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="O1FW3XBb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E828C83700; Fri, 17 Oct 2025 03:33:55 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BD48367F
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 03:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 40D8026250;
 Fri, 17 Oct 2025 03:33:53 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jsLMZlZzlD6A; Fri, 17 Oct 2025 03:33:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760664831; bh=1pdoaI2xvoBZ5Z6eNm8vHFkw7wgkadwUPadmfHDWBck=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O1FW3XBb6puJiPrD50KmkLbYu9PQmwfXL6dJeshNJpnAdAu+FYZ+mCSDaK7fdZ/8t
 nVKIDwVUWmZd3NuGxTk33yfj+/62ijyFvaLnLXP+UBkEGOmjIHVTNJhzNke9RpYAJe
 46yTKyk3Teajg2kiV90YBG+i3lAa4BkAx+WSeLvBddm7Xr6VpeC12kts1+6U/DqmxE
 +FSlP4nQN23EwcNGCXiWE//MkZZgVtgSIawW+mIv8s+Oq9YvHcpj0EyC9Vf17acL0n
 ZwAA6AWX89VFBa1lH8xz+4y4Fa/OhTHcNH7KRCKnK1fl3H99s6/RmgbzK6a/n4mJnu
 fSGfLprLU7wNw==
Date: Fri, 17 Oct 2025 01:33:11 +0000
From: Yao Zi <ziyao@disroot.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
Subject: Re: [PATCH 1/1] riscv: consider CONFIG_RISCV_ISA_ZAAMO in SPL too
Message-ID: <aPGc12v2H5sCZNMi@pie>
References: <20251016165851.45311-1-heinrich.schuchardt@canonical.com>
 <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdc0e15-c37b-4f1b-8148-bf3de590be0c@canonical.com>
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

On Thu, Oct 16, 2025 at 07:04:48PM +0200, Heinrich Schuchardt wrote:
> On 10/16/25 18:58, Heinrich Schuchardt wrote:
> > Commit a681cfecb434 ("riscv: Add a Zalrsc-only alternative for
> > synchronization in start.S") changed the hart synchronization in start.S.
> > It uses CONFIG_IS_ENABLED(RISCV_ISA_ZAAMO) to determine which method to
> > use. If the macro evaluates to true the old behavior is maintained.
> > 
> > The macro evaluates to false for SPL builds which was unintended. Use
> > IS_ENABLED(CONFIG_RISCV_ISA_ZAAMO) instead.
> > 
> > This fixes a boot failure on StarFive JH7110 based boards.
> > 
> > Fixes: a681cfecb434 ("riscv: Add a Zalrsc-only alternative for synchronization in start.S")
> > Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---

Hi Heinrich,

Thanks for sending the patch!

> 
> Hello Yao,
> 
> It would be worthwhile to understand why your new method does not work on
> the StarFive VisionFive 2. I only addressed the Kconfig issue. But I suspect
> there is something broken in the alternative pass.

A possible reason is that, on JH7110 not all the cores support LR/SC
instructions: the S7 small core always raises access exception for it
since the implementation of LR/SC requires data cache to present, while
S7 doesn't have one.

This is documented in SiFive U74-MC Core Complex Manual,

> Load-reserved (LR) and store-conditional (SC) instructions are special
> atomic instructions that are only supported in data cacheable regions.
> As the S7 core does not have a data cache, the LR and SC instructions
> will always generate a precise access exception.[1]

As S7 also takes part in the initial HART lottery, usage of LR/SC
instructions might just crash its boot process with exception.

However I could only confirm the idea days later when I have access to
a JH7110 board. Since earlier Tom has merged the patch[2] that reverts
the problematic commit, do you think it's better to wait for me to
confirm the cause and write v3 of the patch, instead of fixing it up
now? I'll carry your Co-developed-by tag in v3 if you're okay with this.

> Best regards
> 
> Heinrich

Best regards,
Yao Zi

[1]: https://starfivetech.com/uploads/u74mc_core_complex_manual_21G1.pdf
(Chapter 3.6, Atomic Memory Operations)
[2]: https://lore.kernel.org/u-boot/176063629917.212270.1145034876136991424.b4-ty@konsulko.com/
