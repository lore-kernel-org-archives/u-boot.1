Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398D5C4829E
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 19:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905DA871C0;
	Mon, 12 Feb 2024 20:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF08871C0; Mon, 12 Feb 2024 20:58:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1870486DEE
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 20:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C9EDA7;
 Mon, 12 Feb 2024 11:58:35 -0800 (PST)
Received: from minigeek.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 296423F766;
 Mon, 12 Feb 2024 11:57:52 -0800 (PST)
Date: Mon, 12 Feb 2024 19:56:40 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Nils Le Roux <gilbsgilbert@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2] net: designware: Support high memory nodes
Message-ID: <20240212195640.49bd927e@minigeek.lan>
In-Reply-To: <20240212184031.GL3040305@bill-the-cat>
References: <20231202093952.33256-1-gilbsgilbert@gmail.com>
 <20231204010930.071a5ba7@slackpad.lan>
 <20240210173703.73d18367@minigeek.lan>
 <20240212184031.GL3040305@bill-the-cat>
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

On Mon, 12 Feb 2024 13:40:31 -0500
Tom Rini <trini@konsulko.com> wrote:

> On Sat, Feb 10, 2024 at 05:37:03PM +0000, Andre Przywara wrote:
> 
> > On Mon, 4 Dec 2023 01:09:30 +0000
> > Andre Przywara <andre.przywara@arm.com> wrote:
> > 
> > Hi Joe, Ramon, Tom,
> > 
> > for some reason patchwork put this on my plate, but it looks like
> > genuine network code to me, and the problem definitely doesn't affect
> > sunxi.
> > As tagged below, I am happy with this change, so if there are no
> > objections, can one of you take this patch, please?  
> 
> I believe I delegated it to you since Ramon doesn't often have time to
> put together a PR, and since it seems otherwise fine and relevant to
> platforms you're the custodian for, I was fine with you grabbing it. But
> yes, I can pick it up directly instead.

Ah, that's fine, I just didn't know and didn't want to interfere with
any other ongoing merges. I am preparing a pull request for this
week, and can surely put in there, unless you want to beat me to it.

Cheers,
Andre
