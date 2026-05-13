Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0049CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76E2B845E3;
	Wed, 13 May 2026 16:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="R2Ca5xbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6875A8466C; Wed, 13 May 2026 16:23:43 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED43D8341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E4F6C1F9B3;
 Wed, 13 May 2026 16:23:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778682220;
 bh=RkffR5ziQqnoLZFrGOIQSUkRiuVMDQfsSxE6WrMtClE=; h=From:To:Subject;
 b=R2Ca5xbMA1Io2qIcm3S9qKuj9QfazKRFWmo19JuL/spis1KK2bdoaHJcCuw7Bapx2
 MHXP6KUE6wKOz2HClZt/9hIbRNFQBGEYQlBiH842M6ufR7WXG7xihc2Iob1QL27AYv
 ESgSPzxdoWGW4cBzz1VVm190LDrpPvOZ4MvoQFGXOcpiYpQICG+yHqe2tIIfVF55D/
 4ZqtqwxREFpvsF/VGbhRICP7cRHGgAb1b3ZDmGY3EMZFHaliCqcsLT7nfaHEjNOe3j
 gAGwoNc8zFvITUjKTY35/PgynjSpnYJWtkDDnE7EOpHQuUtrOt6hNMtyCTH29Kulad
 2i+atR+Amt5OA==
Date: Wed, 13 May 2026 16:23:36 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>
Cc: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, trini@konsulko.com,
 vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com,
 praneeth@ti.com, kamlesh@ti.com, vishalm@ti.com,
 k-malarvizhi@ti.com, anshuld@ti.com
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
Message-ID: <20260513142336.GA123538@francesco-nb>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <momeoh6chz4swvgj3oj36p57os2cejpbcx37qyc7f3pydvwdlt@gaucmqmtpjso>
 <677d1d7c-8276-44f2-b563-d2b0d0a263ea@ti.com>
 <b42fe4a0-a0f3-4773-be29-ac881c750799@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b42fe4a0-a0f3-4773-be29-ac881c750799@ti.com>
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

Hello Andrew, Shiva

On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
> On 5/13/26 8:06 AM, Shiva Tripathi wrote:
> > On 5/12/26 22:14, Ernest Van Hoecke wrote:
> > > On Wed, Feb 25, 2026 at 04:54:38PM +0530, Shiva Tripathi wrote:
> > > > Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
> > > > MMC hardware. This provides TPM 2.0 functionality through
> > > > Microsoft's fTPM Trusted Application running in OP-TEE secure world,
> > > > using eMMC RPMB as persistent storage.
> > > > 
> > > > fTPM support in U-Boot provides the foundation for measured boot
> > > > and disk encryption use cases.
> > > > 
> > > > The ARM64 condition ensures these apply only to A53/A72 cores and the
> > > > MMC condition ensures fTPM is enabled only on platforms with eMMC
> > > > hardware support.

...

> > > Do these changes mean you expect any K3-based board to follow by
> > > building OP-TEE with RPMB support (and in production provisioning an
> > > authentication key on first boot) now?
> > > 
> > > I'm asking because we noticed errors in the below form appeared during
> > > boot of our Verdin AM62P and Aquila AM69 now:
> > > E/LD:  Status of TA bc50d971-d4c9-42c4-82cb-343fb7f37896
> > > E/LD:   arch: aarch64
> > > E/LD:  region  0: va 0x40005000 pa 0x9e900000 size 0x002000 flags rw-s (ldelf)
> > > E/LD:  region  1: va 0x40007000 pa 0x9e902000 size 0x008000 flags r-xs (ldelf)
> > > E/LD:  region  2: va 0x4000f000 pa 0x9e90a000 size 0x001000 flags rw-s (ldelf)
> > > E/LD:  region  3: va 0x40010000 pa 0x9e90b000 size 0x004000 flags rw-s (ldelf)
> > > E/LD:  region  4: va 0x40014000 pa 0x9e90f000 size 0x001000 flags r--s
> > > E/LD:  region  5: va 0x40015000 pa 0x9e980000 size 0x011000 flags rw-s (stack)
> > > E/LD:  region  6: va 0x4005a000 pa 0x9e910000 size 0x055000 flags r-xs [0]
> > > E/LD:  region  7: va 0x400af000 pa 0x9e965000 size 0x01b000 flags rw-s [0]
> > > E/LD:   [0] bc50d971-d4c9-42c4-82cb-343fb7f37896 @ 0x4005a000
> > > E/LD:  Call stack:
> > > E/LD:   0x4005b7b0
> > > E/LD:   0x4008f220
> > > E/LD:   0x40083298
> > > 
> > > Interestingly this did not appear on our Verdin AM62 SoM.
> > > 
> > > Of course, we can simply disable the fTPM until our support improves, or
> > > ignore this error if it is harmless, but I wanted to ask about your
> > > intentions before digging much deeper.
> > 
> > It's not expected for all K3-platforms to build OP-TEE with RPMB
> > support, some platforms lack eMMC entirely. fTPM is an optional
> > configuration for users who need measured boot, disk encryption, or
> > similar TPM related use-cases.
> > 
> > The Yocto SDK we release for K3 platforms includes the fTPM TA embedded
> > in the OP-TEE, not sure if the same is true in your case.
> > 
> > RPMB provisioning is needed for full functionality, but even without it
> > you shouldn't see these errors. Maybe the fTPM TA is missing from your
> > OP-TEE build, or something similar is causing loader error.
> > 
> 
> Given the above log shows the fTPM UUID, the fTPM does look to be
> loaded and running in this case. Given a more complete log from
> a different thread on this issue I'm seeing:

The whole integration / optee and so on is current mainline U-Boot
v2026.07-rcX + meta-ti master branch, built together in OE with this
https://git.toradex.com/meta-toradex-bsp.git/


> So this should be harmless, but why there is such a large error
> printout we need to investigate and try to make it less verbose.

We have the same concern here. It is not clear to us why we do not
see the same on am62.

Francesco

