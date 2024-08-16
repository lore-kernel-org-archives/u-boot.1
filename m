Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C1C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 17:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB6E88B83;
	Fri, 16 Aug 2024 19:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="mCzX8Lor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9508870B; Fri, 16 Aug 2024 19:43:35 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D07788BC4
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 19:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 633BD236BB;
 Fri, 16 Aug 2024 19:43:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1723830206;
 bh=YXJUFf2wIWTkPbThICkbEjukTNbxxMF4IgXp+daOmIk=; h=From:To:Subject;
 b=mCzX8LorFTOnH6m0tY0Vd1qtYHZzltkTF6sxF8T4olTrEAKuuH0pgJtPAuhKi4BDM
 UHEM+1AMrgqaSJ8IWpgnbAefxwoxcPtxdPKpByp0ztAplziBUvk9n5CriiEJkcihXx
 VnHhYAPLXfm8yuIOsjJithcEf1dAncd4ps2XIcvZVovaqJt3fU9EwYIN/IE9A7BItn
 5yzs2KwwrkLzUWbr9TFbVpYyHjHBULIWAvNuVkdIUQ79MQe/x7pkmqrAodJtWBaPKO
 IQU/zLKmfWQP9eVtX347p1kQwsC9QoMfi2ILw9D2P2gojdtiBjZ4cIpOHy3VvBnVqR
 AKp89OaI+DwiQ==
Date: Fri, 16 Aug 2024 19:43:22 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/1] board: tegra: convert boards to text env
Message-ID: <20240816174322.GA4270@francesco-nb>
References: <20240807121434.11761-1-clamor95@gmail.com>
 <20240807121434.11761-2-clamor95@gmail.com>
 <CAFLszTiK=i+_TDQuW3dSgEyZgbhqvzsKD+28WO_+9SQUUoBH4g@mail.gmail.com>
 <CAPVz0n0_vv4-AXnYrvJy0w1HXBXrT_isNgp2-mehDda4XvzefA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPVz0n0_vv4-AXnYrvJy0w1HXBXrT_isNgp2-mehDda4XvzefA@mail.gmail.com>
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

Hello,

On Fri, Aug 16, 2024 at 07:51:25PM +0300, Svyatoslav Ryhel wrote:
> > On Wed, 7 Aug 2024 at 06:14, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > Convert boards to use text based env. This is the first stage of
> > > conversion, common inclusions should be converted next.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  board/asus/grouper/grouper.env                | 15 +++
> > >  .../asus/transformer-t20/transformer-t20.env  | 17 ++++
> > >  .../transformer-t30/configs/tf600t.config     |  1 +
> > >  board/asus/transformer-t30/tf600t.env         | 16 ++++
> > >  .../asus/transformer-t30/transformer-t30.env  | 17 ++++
> > >  board/htc/endeavoru/endeavoru.env             | 13 +++
> > >  .../ideapad-yoga-11/ideapad-yoga-11.env       | 16 ++++
> > >  board/lg/x3-t30/configs/p880.config           |  1 +
> > >  board/lg/x3-t30/configs/p895.config           |  1 +
> > >  board/lg/x3-t30/p880.env                      | 15 +++
> > >  board/lg/x3-t30/p895.env                      | 13 +++
> > >  board/microsoft/surface-rt/surface-rt.env     | 14 +++
> > >  board/nvidia/cardhu/cardhu.env                |  2 +
> > >  board/nvidia/p2771-0000/p2771-0000.env        | 22 +++++
> > >  board/nvidia/p3450-0000/p3450-0000.env        |  7 ++
> > >  board/toradex/apalis-tk1/apalis_tk1.env       | 45 +++++++++
> > >  board/toradex/apalis_t30/apalis_t30.env       |  9 ++
> > >  board/toradex/colibri_t20/colibri_t20.env     |  3 +
> > >  board/toradex/colibri_t30/colibri_t30.env     |  9 ++
> > >  board/wexler/qc750/qc750.env                  | 15 +++
> > >  configs/apalis-tk1_defconfig                  |  3 +-
> > >  configs/apalis_t30_defconfig                  |  1 +
> > >  configs/cardhu_defconfig                      |  1 +
> > >  configs/colibri_t20_defconfig                 |  1 +
> > >  configs/colibri_t30_defconfig                 |  1 +
> > >  configs/endeavoru_defconfig                   |  1 +
> > >  configs/grouper_common_defconfig              |  1 +
> > >  configs/ideapad-yoga-11_defconfig             |  1 +
> > >  configs/p2771-0000-000_defconfig              |  1 +
> > >  configs/p3450-0000_defconfig                  |  1 +
> > >  configs/qc750_defconfig                       |  1 +
> > >  configs/surface-rt_defconfig                  |  1 +
> > >  configs/transformer_t20_defconfig             |  1 +
> > >  configs/transformer_t30_defconfig             |  1 +
> > >  include/configs/apalis-tk1.h                  | 58 ------------
> > >  include/configs/apalis_t30.h                  | 12 ---
> > >  include/configs/cardhu.h                      |  4 -
> > >  include/configs/colibri_t20.h                 | 11 ---
> > >  include/configs/colibri_t30.h                 | 12 ---
> > >  include/configs/endeavoru.h                   | 43 ---------
> > >  include/configs/grouper.h                     | 45 ---------
> > >  include/configs/ideapad-yoga-11.h             | 58 ------------
> > >  include/configs/p2771-0000.h                  | 20 ----
> > >  include/configs/p3450-0000.h                  | 13 ---
> > >  include/configs/qc750.h                       | 42 ---------
> > >  include/configs/surface-rt.h                  | 18 ----
> > >  include/configs/transformer-common.h          | 91 -------------------
> > >  include/configs/transformer-t20.h             |  4 +-
> > >  include/configs/transformer-t30.h             |  6 +-
> > >  include/configs/x3-t30.h                      | 44 ---------
> > >  include/env/nvidia/prod_upd.env               | 60 ++++++++++++
> > >  51 files changed, 332 insertions(+), 476 deletions(-)
> > >  create mode 100644 board/asus/grouper/grouper.env
> > >  create mode 100644 board/asus/transformer-t20/transformer-t20.env
> > >  create mode 100644 board/asus/transformer-t30/tf600t.env
> > >  create mode 100644 board/asus/transformer-t30/transformer-t30.env
> > >  create mode 100644 board/htc/endeavoru/endeavoru.env
> > >  create mode 100644 board/lenovo/ideapad-yoga-11/ideapad-yoga-11.env
> > >  create mode 100644 board/lg/x3-t30/p880.env
> > >  create mode 100644 board/lg/x3-t30/p895.env
> > >  create mode 100644 board/microsoft/surface-rt/surface-rt.env
> > >  create mode 100644 board/nvidia/cardhu/cardhu.env
> > >  create mode 100644 board/nvidia/p2771-0000/p2771-0000.env
> > >  create mode 100644 board/nvidia/p3450-0000/p3450-0000.env
> > >  create mode 100644 board/toradex/apalis-tk1/apalis_tk1.env

...

> Francesco, have you checked this commit on apalis-tk1?

Nope, I was not able and I do not see myself looking into it in the next
few weeks because of other personal and work priorities.

I honestly do not expect anybody going to update U-Boot on apalis-tk1
anytime soon, and the product is discontinued, given that

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Apalis TK1

If we ever find issue, we'll fix those.

Thanks,
Francesco

