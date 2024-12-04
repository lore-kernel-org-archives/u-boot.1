Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB77E7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 13:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA3289407;
	Wed,  4 Dec 2024 14:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fSfRA9hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BFB887D1; Wed,  4 Dec 2024 14:37:55 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 253AF89407
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 14:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B4Dbjd52050048
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Dec 2024 07:37:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733319465;
 bh=Rtrn3IudEUWENjG3O8hAow5MgJ/w3z9krB6vJpbbrMM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fSfRA9hylZqjCYD3+vEiWItZ2N9V407UMUkA/q3RuA0Gk6RfOxnPn0tD1FWbPpzx5
 yFDbr/iSkf/3uuPBV8UBdC8Vo3CRJZCYNP88drguh75HgHifiIf5ws3j9lyz93N7cq
 0cYnX8YnNJAq7jSnvXt98lnGXsM1Os7zQ3abNK6g=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B4DbjTr007942
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Dec 2024 07:37:45 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Dec 2024 07:37:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Dec 2024 07:37:44 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B4DbhIl113234;
 Wed, 4 Dec 2024 07:37:44 -0600
Date: Wed, 4 Dec 2024 19:07:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <marex@denx.de>, <hnagalla@ti.com>,
 <mkorpershoek@baylibre.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <jan.kiszka@siemens.com>,
 <j-humphreys@ti.com>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
Message-ID: <ftdjegd5mctcn3ndvgrl4apyxkzms7hxivxlyjcrk4qrmvsx7r@og3t7eyyhmkt>
References: <20241203093748.138260-1-s-vadapalli@ti.com>
 <20241203093748.138260-2-s-vadapalli@ti.com>
 <9254b268-2336-48ca-91de-9da34a93b467@kernel.org>
 <6hohujytkznjcemgu2cjhk2x5pxw7euwzojbt6ktji2yp6zft2@i77rsmzwfgj5>
 <5bd5c98c-530b-4f05-9fbc-e2d867be920a@kernel.org>
 <dj32jyfvxsds6wsax4tk7kw75zfiutggd5gfbwpklym7gifjih@awk6aerfjwl2>
 <6b4cb5ed-3d19-4fb2-aba7-90f0a0f4f4f0@kernel.org>
 <4cgkdnpdn7j5tnfwvvskm3ltiqfnp5lx5gc5hwcrsljpg4bdin@hpkkswe4dej6>
 <9a69d8ae-221b-4d46-9b4c-7df0bd6fc0af@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9a69d8ae-221b-4d46-9b4c-7df0bd6fc0af@kernel.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed, Dec 04, 2024 at 02:34:56PM +0200, Roger Quadros wrote:
> 
> 
> On 04/12/2024 12:05, Siddharth Vadapalli wrote:

[...]

> > Why not do what this patch does? What is the issue with the current
> > patch (apart from the checks, which I could retain as well if others
> > wish so)? The caller clearly mentions the expected role, so why not use
> > that?
> 
> Because the patch is more complicated than it needs to be, now that we know:
> 1) generic_host_probe() will only be called when dr_mode is "host",
> 2) generic_peripheral_probe() will only be called when dr_mode is "peripheral"
> or "otg".
> 
> The problem case is generic_peripheral_probe() being called with when
> dr_mode is "otg".

We can also be sure that generic_periperhal_probe() expects dr_mode to
be "peripheral" only and not "otg". So why not fix it at the root, which
is what this patch does? Independent of the issue, is the following a
valid use-case?

generic_peripheral_probe() with plat->dr_mode = "otg" and hence
generic_probe() using "otg" rather than "peripheral"
as is the case now. Is this resulting in something functional for other
users of the USB Designware Controller? If the user requests "peripheral"
mode of operation, will "otg" meet the user's requirement? If yes, I have
no further objections. Irrespective of this, if you believe that the fix
should be in the core as you indicated below, please feel free to post
the patch.

> 
> Another alternative could be to override dr_mode to "peripheral" if
> it was "otg" in dwc3_generic_probe before calling dwc3_init() but
> I don't prefer that as we are loosing platform information here
> and it will have to be reverted when dual-role support is added in core.c.
> 
> So better to deal with this in core.c and add a note why we are doing it.
> 

[...]

Regards,
Siddharth.
