Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B786C0032E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 23:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936C087540;
	Sat, 21 Oct 2023 01:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E40087541; Sat, 21 Oct 2023 01:53:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 4526586E47
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 01:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5682E143D;
 Fri, 20 Oct 2023 16:53:43 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4ABA3F64C;
 Fri, 20 Oct 2023 16:53:01 -0700 (PDT)
Date: Sat, 21 Oct 2023 00:51:57 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: project-tvbox project-tvbox <project-tvbox@prp.uespi.br>
Cc: u-boot@lists.denx.de
Subject: Re: H616 DRAM support on mailine kernel
Message-ID: <20231021005157.1dde04dd@slackpad.lan>
In-Reply-To: <CAC15VHQzeob=727iTbah2uOkr0LGhFLRq4W3ZpQoPNJ4rHdEJw@mail.gmail.com>
References: <CAC15VHQzeob=727iTbah2uOkr0LGhFLRq4W3ZpQoPNJ4rHdEJw@mail.gmail.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
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

On Thu, 5 Oct 2023 17:23:06 -0300
project-tvbox project-tvbox <project-tvbox@prp.uespi.br> wrote:

Hi,

> 
> How can I edit the drm parameters directly in the mainline kernel,
> since the mainline dts does not have these options like the legacy
> one, I saw that the dram.c drives in the legacy and mailline are
> similar, for example:
> [dram_para]
> dram_clk = 600
> dram_type = 3
> dram_dx_odt = 0x03030303
> dram_dx_dri = 0x0e0e0e0e
> dram_ca_dri = 0x1f12
> dram_odt_en = 1
> dram_para1 = 0x30fb
> dram_para2 = 0x0000
> dram_mr0 = 0x840
>  in the mainline kernel

The kernel is not responsible for setting up the DRAM controller, this
is done in U-Boot (as you apparently have already figured out).
Mainline U-Boot patches a few months ago added U-Boot Kconfig options
for those parameters, please check configs/x96_mate_defconfig and
configs/orangepi_zero2_defconfig for examples. All options are
enumerated here:
https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-sunxi/Kconfig?ref_type=heads#L54-105

Cheers,
Andre
