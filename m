Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F206C6FD1F
	for <u-boot@archiver.kernel.org>; Sun, 24 Mar 2024 15:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8332C875FA;
	Sun, 24 Mar 2024 16:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="wmWx70lY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E6C879E0; Sun, 24 Mar 2024 16:00:56 +0100 (CET)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B218718A
 for <u-boot@lists.denx.de>; Sun, 24 Mar 2024 16:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:
 Subject:Content-ID:Content-Description:X-Debbugs-Cc;
 bh=ISIIMrQB4qYHL+SgzEB8x57zTD3DeLXw2t/87qb6rf0=; b=wmWx70lYWfQVSZIo4xH+q4uVAK
 FWRierPaUFl8lIT/i+HsQifuHsglxJ6wl0FpFR3b8j+EV5YToCVqmUCTfwz2vNo0yu+Iai0WAik6S
 G3sIhg10c90aIT+1KFoY2T5f/6dp67wOnaU1pFI3HKKcW9yca9cTTbpB+/Y4PoUWvitxPb8kgTOoP
 LSljknQpGnb0mvtH/EwoWfeCljd4yrjR4HJlRyqEymKBUy7cpQhZW8BS3tiYzSaXfWMQpwX6OmdFs
 rhCYkqCXbNlGW6BndhXDfAnvFqJNaynGPdgR9kvaYsbAqQDnnY2gySgn3fO3V5+NV+HTaf/++hatC
 86fh28nQ==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1roPKw-005PE9-1d;
 Sun, 24 Mar 2024 16:00:38 +0100
Date: Sun, 24 Mar 2024 16:00:37 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/6] board: starfive: support Milk-V Mars board
Message-ID: <ZgBAFWBB0-213CfQ@aurel32.net>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
 <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240321181149.177356-5-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

On 2024-03-21 19:11, Heinrich Schuchardt wrote:
> The differences between the Milk-V Mars board and the VisionFive 2 board
> are small enough that we can support both using the same U-Boot build.
>=20
> * The model and compatible property are taken from proposed Linux patches.
> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
> * The second Ethernet port is not available.

=46rom the device tree that have been submitted to the kernel [1] it seems
another difference is that there is a CD gpio for mmc1.

=46rom the schematics, it also seems that the usb0 port is not in
peripheral mode, but in host mode. That said on the submitted kernel
device tree it seems simply disabled.

Aurelien

[1] https://lore.kernel.org/linux-kernel/20240131132600.4067-2-jszhang@kern=
el.org/T/

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
