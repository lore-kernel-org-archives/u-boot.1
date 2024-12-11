Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8D6E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 21:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92AB5801E7;
	Wed, 11 Dec 2024 22:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE775801EA; Wed, 11 Dec 2024 22:54:24 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6E9E7801DB
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 22:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD5791007;
 Wed, 11 Dec 2024 13:54:49 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AB083F58B;
 Wed, 11 Dec 2024 13:54:20 -0800 (PST)
Date: Wed, 11 Dec 2024 21:53:27 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Leon Anavi <leon.anavi@konsulko.com>
Cc: u-boot@lists.denx.de, lhristov@gmail.com
Subject: Re: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
Message-ID: <20241211215327.26dc369a@minigeek.lan>
In-Reply-To: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
References: <CALtQ3O2jF6sEvofpZ+FtJgmgTKZvNRuohnwEtPz4ES0WqtxU5g@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 9 Dec 2024 23:08:19 +0200
Leon Anavi <leon.anavi@konsulko.com> wrote:

Hi Leon,

thanks for the report!

> Commit ffb0294 from 12 November 2023 that simplifies early PMIC setup
> conditions causes issues on Cubieboard 4 and Merrii A80 Optimus with
> Allwinner A80 SoC (sun9i). The commit was introduced with U-Boot 2024.01
> (rc3) and remains as of today. Because of it both of these boards hang at:
> 
> Starting kernel ...

That's odd, how do you boot the kernel, exactly?
I just tried mainline U-Boot (via FEL), with:
=> setenv bootargs "console=ttyS0,115200n8 earlycon"
=> bootz $kernel_addr_r $ramdisk_addr_r:300000 $fdtcontroladdr

and it booted fine to the prompt, on a Cubieboard 4 (CC-A80 v1.2).
Kernel was some 6.11-rc6 I just had lying around.

I also compared the code before and after that patch, the only
difference is the order at which DCDC5 gets programmed: before it's
after DCDC4, with the patch it's right after DCDC1.
The rest looked the same.
Booting ffb0294~1 and ffb0294~0 also worked for me, without issues.
So can you please describe how you test that, exactly?

Please also note we fixed d75fa8c80dcfa in U-Boot (DCDC4/5 typo), and
dd36ad71ad6 in the kernel (DCDC5 constraints in the DT).

Cheers,
Andre

> Older U-Boot versions without this commit work fine. As a temporary
> solution I reverted commit ffb0294 and this way the boards boot
> successfully. I tested this work around on Merrii A80 Optimus with several
> U-Boot versions, including with U-Boot 2024.10.


> 
> Lazar, a friend who owns Cubieboard 4, also tested and confirmed his board
> boots with U-Boot 2024.10 if this commit has been reverted.
> 
> How to fix this? Is there a known configuration that can be added to
> Merrii_A80_Optimus_defconfig and Cubieboard4_defconfig to avoid hanging
> with the existing source code from commit ffb0294 ?
> 
> Best regards,
> Leon

