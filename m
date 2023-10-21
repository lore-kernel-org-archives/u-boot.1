Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909F7C001DF
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 00:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CDD8754B;
	Sat, 21 Oct 2023 02:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 312BC87548; Sat, 21 Oct 2023 02:03:31 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 06B8C8754B
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 02:03:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 608FA143D;
 Fri, 20 Oct 2023 17:04:07 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D502A3F64C;
 Fri, 20 Oct 2023 17:03:25 -0700 (PDT)
Date: Sat, 21 Oct 2023 01:02:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: project-tvbox project-tvbox <project-tvbox@prp.uespi.br>
Cc: u-boot@lists.denx.de, linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: error on h616 ID axp806 legacy kernel
Message-ID: <20231021010221.3ac96652@slackpad.lan>
In-Reply-To: <CAC15VHSqtbfP-4YZYJ71CDXryJT2s-vXF9Kj=kNT4yCEAHmC=A@mail.gmail.com>
References: <CAC15VHSqtbfP-4YZYJ71CDXryJT2s-vXF9Kj=kNT4yCEAHmC=A@mail.gmail.com>
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

On Thu, 5 Oct 2023 17:37:48 -0300
project-tvbox project-tvbox <project-tvbox@prp.uespi.br> wrote:

Hi,

> In the legacy kernel, when starting, the error appears:
> the chip id is 0x5d00
> ic cant match axp, please check...

Please keep in mind that the BSP code contains a lot of nonsense, the
PMIC setup seems to be particularly problematic, with dramatic error
messages even when everything is fine. So is there any actual problem
with your box?
And I don't know what "chip id" here refers to, but it's surely not the
AXP ID from I2C register 0x3, since that is only 8 bits wide.
That number looks more like from the first part of the SID, which is
also used in the DVFS code to discern certain dies or SoC revisions.

In any case, are you sure that your device actually has a PMIC? It is
not unheard of for TV boxes to drop that chip (many H6 TV boxes did), as
fine grained power management might not be too useful in a TV box.

Cheers,
Andre

P.S. Please try to add some Allwinner specific lists (see the CC: here),
or the #linux-sunxi IRC channel to get quicker responses.

> well, in the axp.h code the id is defined as 0x40, I tried changing it
> to 0x5d00, but it does not accept the u-boot compilation error, does
> anyone know how to change it, it seems to be an error in the number of
> registers available in the .h

