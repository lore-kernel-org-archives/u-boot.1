Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C4C47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 17:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A708387C20;
	Mon, 29 Jan 2024 18:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDF687C44; Mon, 29 Jan 2024 18:50:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5FCF287BDF
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 18:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA8D139F;
 Mon, 29 Jan 2024 09:51:18 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9C333F738;
 Mon, 29 Jan 2024 09:50:33 -0800 (PST)
Date: Mon, 29 Jan 2024 17:50:29 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Samuel Holland
 <samuel@sholland.org>, Maksim Kiselev <bigunclemax@gmail.com>, Nick
 Alilovic <nickalilovic@gmail.com>, Chuanhong Guo <gch981213@gmail.com>,
 linux-sunxi@lists.linux.dev, u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-sunxi/master for v2024.04
Message-ID: <20240129175029.330974f4@donnerap.manchester.arm.com>
In-Reply-To: <20240129173418.GA1152441@bill-the-cat>
References: <20240129155543.2439451-1-andre.przywara@arm.com>
 <20240129172449.0b9ebc9f@donnerap.manchester.arm.com>
 <20240129173418.GA1152441@bill-the-cat>
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

On Mon, 29 Jan 2024 12:34:18 -0500
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> On Mon, Jan 29, 2024 at 05:24:49PM +0000, Andre Przywara wrote:
> > On Mon, 29 Jan 2024 15:55:43 +0000
> > Andre Przywara <andre.przywara@arm.com> wrote:
> > 
> > Hi Tom,
> >   
> > > please pull the sunxi/master branch, containing the first part of the  
> > 
> > I just saw that the CI pipeline failed on missing maintainer entries for
> > the two new boards. Is that a showstopper for you? Shall I update the
> > branch, or would a follow-up patch be sufficient?  
> 
> I've fixed this up myself this time, since I was doing another CI run
> with this for other changes but in the future please fix these errors
> before sending the PR.

Many thanks for that, and sorry about the mishap! I wanted to trigger the
CI yesterday night and send the PR this morning, but then discovered two
problems in a last minute test. So I was admittedly rushing things a bit
today. I built all sunxi boards locally, and that passed, so I didn't wait
for the CI to finish ... :-(

Sorry again!

Cheers,
Andre
