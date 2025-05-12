Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62984C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 10:46:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C9E8091A;
	Mon, 12 May 2025 12:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657D682162; Mon, 12 May 2025 12:46:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BB11B805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 12:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09763150C;
 Mon, 12 May 2025 03:46:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD9D33F673;
 Mon, 12 May 2025 03:46:50 -0700 (PDT)
Date: Mon, 12 May 2025 11:46:45 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: <u-boot@lists.denx.de>, Jagan Teki <jagan@amarulasolutions.com>, Cody
 Eksal <masterr3c0rd@epochal.quest>, Philippe Simons
 <simons.philippe@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 <linux-sunxi@lists.linux.dev>, Tom Rini <trini@konsulko.com>, Jernej
 Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: allwinner: a100: Add CPU Operating
 Performance Points table
Message-ID: <20250512114645.60bff4cb@donnerap.manchester.arm.com>
In-Reply-To: <ab250c1b-d227-404d-b834-300b82b925a9@cherry.de>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-4-andre.przywara@arm.com>
 <ab250c1b-d227-404d-b834-300b82b925a9@cherry.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Mon, 12 May 2025 11:24:07 +0200
Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Andre,
> 
> On 5/11/25 3:10 AM, Andre Przywara wrote:
> > Add an Operating Performance Points table for the CPU cores to
> > enable Dynamic Voltage & Frequency Scaling on the A100.
> > 
> > Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
> > [masterr3c0rd@epochal.quest: fix typos in -cpu-opp, use compatible]
> > Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> > Link: https://patch.msgid.link/20241031070232.1793078-14-masterr3c0rd@epochal.quest
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > 
> > [ upstream commit: a8181e6861fec3068f393d77ff81b2aaf4ea4203 ]  
> 
> Did you use tools/update-subtree.sh to cherry-pick those commits? The 

No, I didn't, just remembered that afterwards. This would only work for
this patch anyways, since the other two DT patches are not yet merged in a
tagged release (the last one isn't even reviewed yet), so I just added them
here for completeness, to give people an idea of how the defconfig would
look like and to allow compile testing.

The plan was to maybe merge the first two patches (the DRAM code and
Kconfig bits), then wait for the DT bits to trickle in.

Thanks!
Andre

> changelog seems odd to me compared to what we usually get when using 
> that tool. Modifications of dts/upstream should only be done via this tool.
> 
> Same remark for the other DTS changes in this series.
> 
> Cheers,
> Quentin

