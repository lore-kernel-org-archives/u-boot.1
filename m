Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3C1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 15:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51372871CE;
	Tue, 12 Dec 2023 16:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nb7sYO61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C980187015; Tue, 12 Dec 2023 16:52:28 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D477D870D0;
 Tue, 12 Dec 2023 16:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFqIqM069457;
 Tue, 12 Dec 2023 09:52:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702396338;
 bh=OpFdrxO1t5tevEeuE2IpjidX+ZYOUapzho53rgqMpF4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nb7sYO618Olf7D6lnj7lH6SK3HkCf/94inIvSKnB0z/uDS9hERA919FMRWacqDGDq
 uyqQZNmirGbD7ggevgDPn4MRtIyWjRpq/AXPrNMsoQoz/wDnWRDv/1IkC04QT/YvZL
 F80ENDwpPyN8Z3rsJUXORV96FP1W3lk4T2IJFLFM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BCFqIas005602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Dec 2023 09:52:18 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 09:52:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 09:52:17 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BCFqH6j031051;
 Tue, 12 Dec 2023 09:52:17 -0600
Message-ID: <ae0675e2-940a-439e-9557-e5a4f745f1b0@ti.com>
Date: Tue, 12 Dec 2023 09:52:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal: FIT support for extension boards / overlays
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Chen-Yu Tsai <wenst@chromium.org>, Tom
 Rini <trini@konsulko.com>, U-Boot Custodians
 <u-boot-custodians@lists.denx.de>
References: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO_uPMH_9sTF7Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 12/12/23 8:05 AM, Simon Glass wrote:
> Hi,
> 
> The devicetree files for a board can be quite large, perhaps around
> 60KB. To boot on any supported board, many of them need to be
> provided, typically hundreds.
> 
> All boards for a particular SoC share common parts.  It would be
> helpful to use overlays for common pieces, to reduce the overall size.
> 

For this to save much size we would need to have the SoC split
from each board that uses it. We don't have that in DT today.
There are some efforts in progress to help on this but until
then we will not get much here.

> Some boards have extension add-ons which have their own devicetree
> overlays. It would be helpful to know which ones should be applied for
> a particular extension.
> 
> I propose implementing extensions in FIT. This has a new '/extensions'
> node, so you can specify what extensions are available for each FIT
> configuration.
> 
> For example:
> 
> / {
>    images {
>      kernel {
>        // common kernel
>      };
> 
>      fdt-1 {
>        // FDT for board1
>      };
> 
>      fdto-1 {
>        // FDT overlay
>      };
> 
>      fdto-2 {
>        // FDT overlay
>      };
> 
>      fdto-3 {
>        // FDT overlay
>      };
>    };
> 
>    configurations {
>      conf-1 {
>          compatible = ...
>          fdt = "fdt-1";
>          extensions = "ext1", "ext-2";
>      };
>    };
> 
>    extensions {
>      ext-1 {
>          fdto = "fdto-1";   // FDT overlay for this 'cape' or 'hat'
>          kernel = "kernel-1";
>          compatible = "vendor,combined-device1";
>          extensions = "ext-3";
>      };
> 
>      ext-2 {
>          fdto = "fdto-2";   // fdt overlay for this 'cape'
>          compatible = "vendor,device2";
>      };
> 
>      ext-3 {
>          fdto = "fdto-3";
>          compatible = "vendor,device3";
>      };
>    };
> };
> 
> So FIT configurations have a list of supported extensions. The
> extensions are hierarchical so that you can have ext-1 which can
> optionally have ext-2 as well. This allows boards to share a common
> SoC to add in overlays as needed by their board. It also allows common
> 'capes' or 'hats' to be specified only once and used by a group of
> boards which share the same interface.
> 

Are you suggesting an 'extension' that lists every 'cape', then for each
board that has a 'cape' header we list that 'hierarchical extension'
to suggest support?

Seems reasonable, but we don't have universal DTB overlays today. Each
overlay needs to be built for a specific board due to several reasons
(I have some plans to help solve this but the upstream kernel path might
be a ways out).

> Within U-Boot, extensions actually present are declared by a sysinfo
> driver for the board, with new methods:
> 
> get_compat() - determine the compatible strings for the current platform
> get_ext() - get a list of compatible strings for extensions which are
> actually present
> 
> The extension compatible-strings are used to select the correct things
> from the FIT, apply the overlays and produce the final DT.
> 

These extension compatible-strings, could they just be the name of
the overlay file? That is what we do today with our name_overlays[0].
The benefit is these names can be used to load and apply overlays in
the non-FIT case just the same.

If we name the configuration nodes after the DTBO that they contain
then I'm not sure what this 'extensions' list gains us over having
a list of overlays to apply like we do today.

Andrew

[0] https://github.com/trini/u-boot/blob/master/board/ti/am65x/evm.c#L189

> To make this simpler for the common case (without extensions), we can
> allow multiple FDT images for a configuration, with the first one
> being the base SoC .dtb and the others being the .dtbo overlay(s) for
> the board:
> 
> confi-1 {
>          compatible = ...
>          fdt = "fdt-1", "fdto-1";
> };
> 
> Comments welcome.
> 
> Regards,
> Simon
