Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2FBC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5319D87AB2;
	Tue, 31 Oct 2023 18:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="cPEUot5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17665875C4; Tue, 31 Oct 2023 18:28:18 +0100 (CET)
Received: from smtpo55.interia.pl (smtpo55.interia.pl [217.74.67.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65635875F5
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=poczta.fm
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sst@poczta.fm
Received: from nr200 (ipv4-80-68-225-159.net.internetunion.pl [80.68.225.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
 Tue, 31 Oct 2023 18:28:13 +0100 (CET)
Date: Tue, 31 Oct 2023 18:28:12 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] configs: orangepi-5-plus-rk3588: Build SPI image by
 default
Message-ID: <ZUE5LCNz3oc3R_9Q@nr200>
References: <20231031161327.1104885-1-sst@poczta.fm>
 <20231031161327.1104885-2-sst@poczta.fm>
 <3d718a4e-0977-4a9b-8b9d-dc0e01849c82@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d718a4e-0977-4a9b-8b9d-dc0e01849c82@kwiboo.se>
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1698773295; bh=eqj9Pgo/p8ve3kPZ9HxSgQuGvj2KEmmTWz1SNrgL8rU=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 b=cPEUot5l48dymgiZeOH2/wW8hfeyZPp5Hh0MUURG7wooL1lYH0YKmYSxbLgsbwArz
 om8BuaUlnzH7lsrlHWSTdisRPtOWFYkAkimc2BVSki2Lew8TzFn7YrL12cdzAQXjHe
 L1ZCmNMLgDue3QnTiPepFv8O/mfWX1KPx7RbNwLs=
X-Mailman-Approved-At: Tue, 31 Oct 2023 18:35:53 +0100
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

On paź 31, 2023 17:49, Jonas Karlman wrote:
> On 2023-10-31 17:13, Slawomir Stepien wrote:
> > Flashing this image to the on-board flash is useful when you want to
> > start Linux from a medium (e.g. nvme) without flashing u-boot elements
> > to it.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> > ---
> >  configs/orangepi-5-plus-rk3588_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
> > index 0473699621..9af65026a0 100644
> > --- a/configs/orangepi-5-plus-rk3588_defconfig
> > +++ b/configs/orangepi-5-plus-rk3588_defconfig
> > @@ -103,3 +103,4 @@ CONFIG_USB_OHCI_GENERIC=y
> >  CONFIG_USB_DWC3=y
> >  CONFIG_USB_DWC3_GENERIC=y
> >  CONFIG_ERRNO_STR=y
> > +CONFIG_ROCKCHIP_SPI_IMAGE=y
> 
> This was intentionally left out from original submission due to an
> unfinished discussion at [1].
> 
> Also note that this option is not added at correct position in defconfig
> file. Next time, please re-sync defconfig changes with a make
> savedefconfig generated file.

Ah yes. I did forget about it. Sorry. I will regenerate it correctly...if there will be v2.

> [1] https://lore.kernel.org/u-boot/b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se/
> 
> Regards,
> Jonas

-- 
Slawomir Stepien
