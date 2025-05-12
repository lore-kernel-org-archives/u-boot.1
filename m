Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC435C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 10:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12B808091A;
	Mon, 12 May 2025 12:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9759782162; Mon, 12 May 2025 12:49:17 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A343B8007D
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 12:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D9B150C;
 Mon, 12 May 2025 03:49:04 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C89493F673;
 Mon, 12 May 2025 03:49:13 -0700 (PDT)
Date: Mon, 12 May 2025 11:49:11 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, Cody Eksal
 <masterr3c0rd@epochal.quest>
Cc: <u-boot@lists.denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Philippe Simons <simons.philippe@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, <linux-sunxi@lists.linux.dev>, Tom Rini
 <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2 1/6] sunxi: A133: add DRAM init code
Message-ID: <20250512114911.1df896ed@donnerap.manchester.arm.com>
In-Reply-To: <abf4d18b-93c0-4384-ae00-ce19f1a7dbbc@cherry.de>
References: <20250511011003.15654-1-andre.przywara@arm.com>
 <20250511011003.15654-2-andre.przywara@arm.com>
 <abf4d18b-93c0-4384-ae00-ce19f1a7dbbc@cherry.de>
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

On Mon, 12 May 2025 11:21:33 +0200
Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi Andre,
> 
> On 5/11/25 3:09 AM, Andre Przywara wrote:
> > From: Cody Eksal <masterr3c0rd@epochal.quest>
> > 
> > This adds preliminary support for the DRAM controller in the Allwinner
> > A100/A133 SoCs.
> > This is work in progress, and has rough edges, but works on at least
> > three different boards. It contains support for DDR4 and LPDDR4.
> > 
> > [Andre: formatting fixes, adapt to mainline, drop unused parameters,
> > 	remove struct struct sunxi_mctl_com_reg, hardcode MR registers,
> > 	switch to mctl_check_pattern(), remove simple DRAM check]  
> 
> Missing Cody's and your Signed-off-by.

Yeah, I know, I am hoping for Cody to reply to this mail with the line,
since it was also missing in his github, and I don't think I can just slap
SoB lines on someone's patches.
I will add mine then as well.

Thanks,
Andre
