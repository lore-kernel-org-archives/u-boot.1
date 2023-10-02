Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E72E784A4
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 07:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6782187112;
	Mon,  2 Oct 2023 09:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="XfOqH86Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5EE87114; Mon,  2 Oct 2023 09:09:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44BE98710F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 09:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696230547; x=1696835347; i=frank-w@public-files.de;
 bh=2zvyFkWwxOAE3Vf2l75lzTywH5UVn1feDPF0pB6uX0E=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XfOqH86YT3UQJkoK/iEH3ERVX5HvyARYuQOb+kbw/fUls23wayzhOYLnC5OkzzmxmRY4/vnW137
 GPGLLf2uNq03vUnE2kstSks5QM2fTEnR9KGwylUjGPcgAEHvpK0HMv25A3AcZQ9IzU5OizQhVJmtk
 wwsxO7XWU97dYYMwXAcXRSedW00NkR07tXQYlkCK9T1HxFIRk6g9NfrIaFuskwT6zjC5jbCodlcqJ
 dPV49uziQTcvS5OgQ4XslNQ2kEuoUUpxUA6fxSDTxXdRXeq1JcHGXokip4WC3FKe8psTzc0DTrUkF
 TmCykzrslDRe7ctUaEUjvYPhMcs2DQDhCNHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.132] ([217.61.157.132]) by web-mail.gmx.net
 (3c-app-gmx-bap51.server.lan [172.19.172.121]) (via HTTP); Mon, 2 Oct 2023
 09:09:07 +0200
MIME-Version: 1.0
Message-ID: <trinity-6f4dc3e7-6c77-4a85-a8b3-b7d5b1b87ef9-1696230547625@3c-app-gmx-bap51>
From: Frank Wunderlich <frank-w@public-files.de>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <linux@fw-web.de>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Joseph Chen
 <chenjh@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Aw: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Oct 2023 09:09:07 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <0ef110bf-12d3-d507-63d3-03f15255188c@rock-chips.com>
References: <20230920184005.50931-1-linux@fw-web.de>
 <0ef110bf-12d3-d507-63d3-03f15255188c@rock-chips.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Q9D+627xf6U333mQwVMietCzk9JKqAw6mMMYcvrtb5l+ImdzC9+339Ij/S9jv5U1RSHmp
 dQgOqglLGRnmgVoP6FZoTD66o1FrkdRl5Qh77hk7FQUFfcmpTQv71v9rYhPCRV/AMPpRt1IcbAEU
 XgZnhQkN+ylblSwC9AE80ooH3aXBEyCjtfnzKBDn3YnS8R9aTi6uSERz71osYOibVvfb/rlKQd5N
 S9zyTb3ni3ZfiHUqfdBqRJnJsGKSf3sSzX1MTwGetfXj357C+Q734lx9DYEu6ajZOYkHG44Jgiri
 O4=
UI-OutboundReport: notjunk:1;M01:P0:SzhDK5lL8Ag=;+zfoz6uXSomGbIboragXTjFtH6L
 +OvEtw0WB4u15Nx8ngcOM87mFRKyLQpRmWYnHRcxKzxf0iInos9QYEjL2Tlyz8s1SzKs8cw1z
 rHYAvaup8bNxQ0QjcTGv10zG6M8exXTSJa6jlfIHnPz0iUSkDtm2vhjBAzJq+9RAurStriY4+
 3MYmd2dp5nMF6Yf7WTvtogGDLr0/9MbAVVoa2iHKFHln0bniCoYk9ALIhFFKVj/wC/TddjUwv
 gYnp/n/lGjAt05jzw/UfPAHR9brnP4a3eHfJlFjEBYznkWLqSIVIZI60WhSD9FaehsxtEVz08
 Y2Z75ougWbyRCgx4WtDIjIkWDQTSwKACWmOnd01AsKcNoIS9gg1C2giNJ+auARRJ+W4yl7Mgw
 GTNbcYU9CjYnuL3QR9+zAQcCaNWiQF4Bz46jF9Et+x1UH1ZX/YhRdaueGya81OIl3dFZQbkiC
 jced/kLmZPnvQpMcQnZPNUV/5i6C7QsuVnfw51yYPVkd8Vi/6mBnGWWTge3BHOv2J/lz9Ap/W
 Jsg1XDXaYMDqvwP2wROgKibgmA6+/juxwQ8oIjk1hKXUu7r1d/uJRYLkk9QlSTf6Mw0uyetrr
 C+yU5EnWm6laJjLjO80YmD252+9h4E6YxwnNBjAUuQuPAgvFkaCpSIBak+ElDCzF3HZ6NO1b3
 pn7q3RISI1nM/ik3SaNpKz82xFBwSg0FFLTEk/KeSlu7TH9AgYULFl1FOoKMi9eReM7x3KRtv
 9dA9pK4OSo5D6dd69PI+OsbMPajj1Ekaor62qAdUVXZqNvFYUYmJIOA5ZX8axWaA+GhuQ6aNb
 HXukJM/Ek8n2OD4Fqt+kE2pg==
Content-Transfer-Encoding: quoted-printable
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

Hi

Thank you kever for review.

Tom can you take this and the depencies into next release (2024-01)?

regards Frank


> Gesendet: Mittwoch, 27. September 2023 um 04:42 Uhr
> Von: "Kever Yang" <kever.yang@rock-chips.com>
> An: "Frank Wunderlich" <linux@fw-web.de>, u-boot@lists.denx.de
> Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@chr=
omium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Joseph Chen" <c=
henjh@rock-chips.com>, "Jonas Karlman" <jonas@kwiboo.se>
> Betreff: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
>
>
> On 2023/9/21 02:40, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add Bananapi R2 Pro board.
> >
> > tested:
> > - sdcard
> > - both front usb-ports
> > - sata
> > - wan-port
> >
> > lan-ports are connected to mt7531 switch where driver needs to be
> > separated from mtk ethernet-driver.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>
> Thanks,
> - Kever
> > ---
> > because iodomain is different to evb and now iodomain driver is sent a=
s
> > patch we need to separate between EVB and R2Pro else board can be bric=
ked.
> >
> > ethernet support depends on these series from jonas:
> >
> > rockchip: Port IO-domain driver for RK3568 from linux
> > https://patchwork.ozlabs.org/project/uboot/cover/20230821223020.391862=
0-1-jonas@kwiboo.se/
> > and
> > rockchip: Add GMAC support for RK3568 and RK3588
> > https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.170101=
2-1-jonas@kwiboo.se/

