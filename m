Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20263C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9112487BBA;
	Thu, 15 Feb 2024 18:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2A2877D3; Thu, 15 Feb 2024 18:13:04 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 34A6B87DFD
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 18:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EC841FB;
 Thu, 15 Feb 2024 09:13:29 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F143F766;
 Thu, 15 Feb 2024 09:12:46 -0800 (PST)
Date: Thu, 15 Feb 2024 17:12:43 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Frieder Schrempf <frieder@fris.de>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vignesh R <vigneshr@ti.com>, Fabio Estevam
 <festevam@gmail.com>, Bruce Suen <bruce_suen@163.com>, Dhruva Gole
 <d-gole@ti.com>, Jim Liu <jim.t90615@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Neal Frager <neal.frager@amd.com>, Nishanth Menon
 <nm@ti.com>, Ricardo Pardini <ricardo@pardini.net>, Teik Heng Chong
 <teik.heng.chong@intel.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v3 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
Message-ID: <20240215171243.2b063af2@donnerap.manchester.arm.com>
In-Reply-To: <dd662626-279e-4a71-b964-1553cb27c7ff@kontron.de>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215165054.4ddc8846@donnerap.manchester.arm.com>
 <dd662626-279e-4a71-b964-1553cb27c7ff@kontron.de>
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

On Thu, 15 Feb 2024 17:56:10 +0100
Frieder Schrempf <frieder.schrempf@kontron.de> wrote:

Hi Frieder,

> On 15.02.24 17:50, Andre Przywara wrote:
> > On Thu, 15 Feb 2024 14:35:19 +0100
> > Frieder Schrempf <frieder@fris.de> wrote:
> >   
> >> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> >>
> >> The datasheet can be found here:
> >> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
> >>
> >> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> >> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >> ---
> >> Changes in v3:
> >> * none  
> > 
> > Why do you resend then? Also v4 seems unchanged? Did you adjust the people
> > in CC:? If you want to notify more people, please just reply to your own
> > patch.  
> 
> This is part of a patch series and there are changes in other patches

Ah, sorry, I missed that, because I only got 1/3. I think it's recommended
to send a cover letter to the superset of all recipients, or, for such a
small series, just all patches to everyone.

Anyway, it's fine in this case, so just ignore me.

Cheers,
Andre.

> within the series. The usual workflow is to send the whole series again
> even if not all patches changed. At least that's what I've always been
> doing and so far no one complained. If there's a better way, please let
> me know.
> 
> Thanks
> Frieder

