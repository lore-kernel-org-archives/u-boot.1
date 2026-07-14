Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D49C4450A
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 17:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C3BA84D3E;
	Tue, 14 Jul 2026 19:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="IVB/VmdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A1284D40; Tue, 14 Jul 2026 19:19:27 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B45F84D22
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 19:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=64802a528=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1784049565; x=1815585565;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PWS6z2Sy/1CUaI8ryanlCeSwERuZMPiTKUxGNJopOk0=;
 b=IVB/VmdH1ordhgtj4eTBYE+WWecTl99O+SnJihfNSxARjZTicVfvuQ+d
 JpJIozqVg0VZYbaCWBnQ30RJ8f1zn/SqtSwhbpBhOOriWoszeYrDEeG+L
 b95EbKqpZR2XPqdlN/7rgGHPVItXAU3Djg5yb0wsvAuOhZFcdlQsYNO1h
 xZs0pbM7RLFlR3ix+VbmCYiwE1EVpzH12uDApnVH3QXQIFhlhcMiVnOOv
 +SsvlpCKd8OnR/n+lrpjPaap6W6aW2kZexJV7iEdJyP5HK2vsfq+blEos
 tLYyd2mw/Fh51CQmqkjh7YLRw7Z6KAJ56Ph7N0vxCFym9ogqDFRitZ7bD A==;
X-CSE-ConnectionGUID: GMK1ahPwSpWyR6L3toE93A==
X-CSE-MsgGUID: bdhPTN2YStGpPV42P0y4ow==
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="227763108"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 14 Jul 2026 10:19:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 14 Jul 2026 10:19:23 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Tue, 14 Jul 2026 10:19:22 -0700
Date: Tue, 14 Jul 2026 10:19:19 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
CC: <u-boot@lists.denx.de>, <anup.patel@oss.qualcomm.com>,
 <charles.perry@microchip.com>
Subject: Re: [PATCH 0/3] riscv: Add generic SBI MPXY interface and MPXY command
Message-ID: <alZvl61jiQ0Wlvl2@bby-cbu-swbuild03.eng.microchip.com>
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
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

On Thu, Jul 09, 2026 at 11:26:01PM +0530, Rahul Pathak wrote:
> This patch series adds a generic SBI MPXY extension
> implementation which provides an interface to interact
> with platform via supported message protocol (eg. RPMI)
> 
> It also adds a mpxy command which uses the generic
> SBI MPXY interface and provides cli support to
> interact with supported message protocol. Currently
> it supports RISC-V RPMI message protocol.

Hello Rahul,

I'm happy to see that you're interested in RPMI support in U-Boot.

Can you share with us the context in which you developed those patches?
i.e., what hardware are you using and how is the "mpxy" command used.

Is "mpxy" mostly just for debugging or is it expected that a bootscript
would initialize the platform with calls to "mpxy"?

Thanks,
Charles

> 
> Rahul Pathak (3):
>   riscv: Add SBI MPXY generic interface
>   cmd: Add mpxy command and add RISC-V RPMI driver
>   riscv: Enable SBI MPXY core interface and MPXY command
> 
>  arch/riscv/Kconfig                 |   9 +
>  arch/riscv/include/asm/sbi.h       | 268 +++++++++++++++
>  arch/riscv/lib/Makefile            |   1 +
>  arch/riscv/lib/sbi_mpxy.c          | 529 +++++++++++++++++++++++++++++
>  cmd/Kconfig                        |   8 +
>  cmd/riscv/Makefile                 |   1 +
>  cmd/riscv/sbi_mpxy_cmd.c           | 482 ++++++++++++++++++++++++++
>  configs/qemu-riscv64_spl_defconfig |   2 +
>  8 files changed, 1300 insertions(+)
>  create mode 100644 arch/riscv/lib/sbi_mpxy.c
>  create mode 100644 cmd/riscv/sbi_mpxy_cmd.c
> 
> -- 
> 2.43.0
> 
