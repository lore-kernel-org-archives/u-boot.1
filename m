Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67E1E73140
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 08:31:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CF383DAE;
	Mon,  2 Feb 2026 09:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gAsDYHlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0BD83DA9; Mon,  2 Feb 2026 09:31:31 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9D483BC9
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 09:31:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-658381b28e8so5794628a12.0
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 00:31:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770021088; cv=none;
 d=google.com; s=arc-20240605;
 b=DbBQ//AlHRDRvmhtekOIMDmAOT+Gr2PgEyRllFRrB/YezsvRGB9BRFHEFisFeipUjP
 BDzIHAfcctwNkhyGN6qm5Ow43CuhNz9LWUFUPKJ95gDBhvUwLx14D9RupQ/xtxbfX0bX
 yYqzPNo9exZ/HesPfAda1G2LZQo5HSmmFvp/5kIqmVctF96lPd+y6G91zM2DI8QiSUyD
 VMjcSD3bOiPw1aMrphPbR+ODBiMurHb0m3Zx936QXERKdyRV9cThaB7Axfl7g7N1ymc/
 LVgh2hibBd73BKj2M3svjZxYddjU8mT1ZhnEKiKeaT6yP4Li6zJuiheT7nildy3yLjv2
 GmqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JyKqBU6gD3T7zKxUUwINcjEFKwGgwMPbjPqpjXXFet0=;
 fh=QgJu7lg0NDqgH5JDO1Ap1caXoLIn8Nj8VOZEgbXwrhY=;
 b=gDwWXHUJ+JYQzfy42GK5PTRJR9fJrXI1de9LtqJig/CRHXgzygiQm3Y/vAXE+Hja75
 bF0gXRwdrpxf8jsFamjajQby1G1MUY0PM254P9TZJ3MlprDKY9MBw/fKtAK7AmvQGqjv
 K+1ay2Mf+QXrmj/pTVYODc8sxUcKPXWt84OnpuITw+1vYXHzOWcgIKqNv7bttzSvdX/w
 CJRBVecuOsz7VTElFIyiPmD63OtU3m3FKE+d7jFZfb6kcJcTXbOX9MJn8UIJkc7vFYZQ
 6ENcJ7TFIvRk0/asAvz1QI9jokWpROmKzCTaz3ew+2ZOdIC3D2mbP7YLXIhTgB3MkGz7
 vgjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770021088; x=1770625888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyKqBU6gD3T7zKxUUwINcjEFKwGgwMPbjPqpjXXFet0=;
 b=gAsDYHlLQzy0A0GAHYFhfepvRptaDKFaGzMKx5I8jMNJoIei2cL0auqb47U85LPthH
 cm8fpfptOS9YIgu/S+5dIJA1GIWfQomw1hz/FUblXIRzOSCgryxenxa5Zo3sb6I4mIPb
 FGggub9EJF2m2b3O2HQv5mHWb/LEG+q+G5rp65ANL2HibitTOoXw+Zo8UejGu9E6ftZQ
 QLm4MWcM3LeTYraUdFdZ/lP8xMd2SfUY2FVs8IFSM0u5M3gODaLAaNWwUmfEB0IUSfCp
 ZLHAwlgmjou8QJ/PwaTVvODjmujeXAvLKTk1sCK+DYF8fb4S2LNSSHCKljuhFnsXa5bO
 AVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770021088; x=1770625888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JyKqBU6gD3T7zKxUUwINcjEFKwGgwMPbjPqpjXXFet0=;
 b=xD19ju14tapPB+LoLwPw9MaLPtWYIY25FA/xeM2sGsuAaAUmoHgrN3P7UyscSK8LOP
 P1S5U/CCw7F9KWLzGQfuvno4+4x80UGtiUxPx9kEfGE1IW8+j+0PEWOGg+QNMJ5wj+u6
 gnhellYb3gRF7x1D21l/ygsxVAu8FF0RCsePkpV1FYzGzdIQ9FgdWfGgsNUclAvYg8JB
 AWVu1vegqMXhmebR7g9Hs6B7njoPFKHO4shwTdA78WMy5U32Uc/Xo0pwR2Agm7h7GLfC
 nSiXub7Jtj1JfpLmk+bjsh3can00BihmVN5FNnYyXjruZ1lrKWkgrmfxP7uD+7YBL+3Q
 QRCQ==
X-Gm-Message-State: AOJu0YzPGECPGDzKXmorXGi5flfZtDVgtpomiqtQVE5Jj25J6H0D1HjF
 jpipTP5+wTHMuVjG4iru8pNN2A1cpvghtmngsBKe+4oSH+OBksqd5m+tyJUTlKns7g+KNGrnm1r
 sW1pY3bhYUfIS/zUtnZL7oPbKH/xkpWC4ZwOFIe1tYg==
X-Gm-Gg: AZuq6aIxFKJ5KhIolqv36j0GcbtL9cAw6kVKvhV0Ok/is18icCXRHklw2T9PjP6GriH
 LbVT7sfNtQnFvVtWCpqB6P7nJSU4eHDMwhoWJ//TzKs+74pNYbb8KQ3ylYvU9cHy7tzCCMU1LWp
 7sEuat8ARd89D8MU6Bl6XomKlzGLs8iodn7BgeEiaWtNuvFE+xRS6rQerKYd6by6DndS5S9p37B
 jJKrarqdRij2hKtN87B6cp9PFjq2cYtZkrpFvx8nIdrcqzLM3vySA/vP4FB18sY2YBPSVYkAwCZ
 jv+sIxdnLWAotqd+eW9hLJr2LluNIFwpyFV7Z60=
X-Received: by 2002:a17:906:d54d:b0:b87:4c37:7fd8 with SMTP id
 a640c23a62f3a-b8dff7beb72mr645538866b.49.1770021087763; Mon, 02 Feb 2026
 00:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20260123-add-genio-700-board-v1-1-274019c628d1@baylibre.com>
 <87343ooh89.fsf@kernel.org>
In-Reply-To: <87343ooh89.fsf@kernel.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 2 Feb 2026 09:31:16 +0100
X-Gm-Features: AZwV_QitWvmPOL1BBBUUP92R2R4lFwhlllYGx0ZHbDchwyIy1Jpthj2S4nbaJ2s
Message-ID: <CAEHHSvZaOWBS4gZAdNzHkKdgrH2kHw++zXrZKW7TtCmQn5JKWA@mail.gmail.com>
Subject: Re: [PATCH] board: mediatek: add MT8390 EVK board support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
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

Le jeu. 29 janv. 2026 =C3=A0 11:17, Mattijs Korpershoek
<mkorpershoek@kernel.org> a =C3=A9crit :
>
> Hi Julien,
>
> Thank you for the patch.
>
> On Fri, Jan 23, 2026 at 09:37, Julien Stephan <jstephan@baylibre.com> wro=
te:
>
> > From: Julien Masson <jmasson@baylibre.com>
> >
> > This adds support for the MT8390 EVK board with the following
> > features enabled/tested: Boot, UART, Watchdog and MMC.
> >
> > MT8390 is based on MT8188.
> >
> > Signed-off-by: Julien Masson <jmasson@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  board/mediatek/mt8390_evk/MAINTAINERS  |  5 +++++
> >  board/mediatek/mt8390_evk/Makefile     |  3 +++
> >  board/mediatek/mt8390_evk/mt8390_evk.c | 34 ++++++++++++++++++++++++++=
++++++++
> >  configs/mt8390_evk_defconfig           | 27 ++++++++++++++++++++++++++=
+
> >  4 files changed, 69 insertions(+)
> >
> > diff --git a/board/mediatek/mt8390_evk/MAINTAINERS b/board/mediatek/mt8=
390_evk/MAINTAINERS
> > new file mode 100644
> > index 00000000000..73fc28b096e
> > --- /dev/null
> > +++ b/board/mediatek/mt8390_evk/MAINTAINERS
> > @@ -0,0 +1,5 @@
> > +MT8390 EVK
> > +M:   Julien Masson <jmasson@baylibre.com>
>
> Since Julien Masson is marked as maintainer here, can we guarantee he
> will be doing some testing/reviewing on patches for this particular
> board?
>
> If not, maybe find another maintainer.
>

Hi Mattijs,

I checked with Julien Masson and he wants to be maintainers, but I
also added Macpaul Lin from Mediatek, as co-maintainer.

> > +S:   Maintained
> > +F:   board/mediatek/mt8390_evk/
> > +F:   configs/mt8390_evk_defconfig
>
> Could we add this board to the MediaTek board documentation?
>
> https://docs.u-boot.org/en/latest/board/mediatek/index.html
>
> I know that doc is a bit outdated but it would be nice to improve it and
> list this board.
>
> For me, that can be done in a future series/improvement.

I forwarded the request to Mediatek internal teams, and they will
handle this internally.
With the Lunar new year vacation coming they won't be able to do this
before end of February.
Same for other new coming boards.

Cheers,
Julien

>
> Thanks
> Mattijs
>
