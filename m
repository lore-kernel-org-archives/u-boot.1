Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED4FCEFCE6
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 18:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88ED783B9B;
	Tue,  6 Jan 2026 19:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RncZ+Thy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C5C83C08; Tue,  6 Jan 2026 19:27:12 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E97083B64
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 19:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4eda77e2358so9763751cf.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 10:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767724029; x=1768328829; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0ZRB1vJcM7QgNF0U9fCAEtOAGO+sppFcnIu8cjjfV4=;
 b=RncZ+ThyURRD1lDciSZaTTITCctFu4fKSUDdulhsP3QOW+OGdKsjJVmxBkZsA4tGb0
 wlr1uEa3IkHkMX5R1bxnijLQGXfU8VliSWRECh65qsHfJeezdM6Mv4zj7TUzdzqo5eiG
 GXnIPJyHH0uqr8D69DtP3vY/fGhOrjCKlDZO0VjiccKMmnVLtG1PGNYc+Z5OgzhkSfQL
 5nEIPCC1AWgxXbOpUNV+pFFTKmpGRCzE6qA8VWI7V+ltSEr3zZQHKLg9cwmfJNIQWq21
 uUWqqvPXageuQ5mHwpCvWU3+48p6b0EUxOASCb7M5SEUUTnPvWjwOe0OvGdIc/PpAN/k
 uSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724029; x=1768328829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i0ZRB1vJcM7QgNF0U9fCAEtOAGO+sppFcnIu8cjjfV4=;
 b=HGI0fL+tqjlj5+Zgja2ebwOh186sXB5KY0IsEDZ723jLxFh0hrH7pMWcbi2cgSe1OC
 m4camg77v5pSt7o8K/n1Zj3I8XkHlq7O33jphccAJNnL6JjiAD19bkr+BIGiZiq6+niR
 D0mPSKzUNwiMFUANi8N77GOD/xAdt20qtBUkSDbBgyb1sg+us9baOlh5yFTAsmCWNOCq
 syxhASlSPcZYsQgsvU0FcGrhimj24KUoW5o8U3m8zSEOEchywNJbjUp1OSg5xEL8Vo9p
 x6wrAlJYvII6JMYulpTYZhKyhCiHBEEQHOAl/qfFgQWtwgKUXLrjG36VzRUfeRWDoR1o
 hKwg==
X-Gm-Message-State: AOJu0Yyf5ODss7jEeXOb08+C8ZALgQBXkziaM8A6Z+UHwAtfThFy5kGx
 0Rz6ZL6weHQRkA4gNqQVvH3iboqhtBUXIqhX5SdotRcuIHDPs7LhpG63D3DbKNCKgBXNIP6igpV
 9aQ5m0okv9y0YyrCFJPbEXMUSv+E8s5s=
X-Gm-Gg: AY/fxX7Dl3+7P6o2SECGc3PdFD8xLqKa2PrWFiRX6GxA74F/batEP4U124WVPOSxopf
 jiGZumrwlDka6S9TvbnkKGrVVnRes3NvnvdoWgek4YjsZvhnnc2xyAAikBVhv7vGJY1X0gwYEwS
 Vvr93mpR8aY/CKb1U7BhmwvFvlQyKMsXxLfWfRFtQu1xaAdacAGQqCSW6kD/JBYAPgFwa4hRwNc
 fvIw717FpZAGEO2npC5/J+ye2nyUmpMeO67NNkfJ+vLGVHLbEcpmv9ztslszkWa1AtThpcvyiu3
 yT4FcvwIKPCx8l8K40tGg49aLOaY
X-Google-Smtp-Source: AGHT+IHRt2vEvX5tAbwt/YsBVWAu6Azj7c18Nr93/P7qklxlx2cf7tAP1EUAgYjgyXfnRn6YYXFLQ7NsRPsEm5g9I3E=
X-Received: by 2002:a05:622a:1f12:b0:4e8:b288:7b6a with SMTP id
 d75a77b69052e-4ffa78393b1mr46106581cf.82.1767724028935; Tue, 06 Jan 2026
 10:27:08 -0800 (PST)
MIME-Version: 1.0
References: <20260106-rk3576-ufs-v3-0-bfe259fd6d17@gmail.com>
 <20260106-rk3576-ufs-v3-3-bfe259fd6d17@gmail.com>
 <67576082-d8b0-419e-8365-0f6294fe0ffc@linaro.org>
In-Reply-To: <67576082-d8b0-419e-8365-0f6294fe0ffc@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 6 Jan 2026 22:26:57 +0400
X-Gm-Features: AQt7F2pBrZzqKIwT3Gz_1Sm_7wLU7c1vU0JOinlGlv6NXecForF3dCnODNLayMU
Message-ID: <CABjd4YwyVKDRDz16u+rbiorFmPSJtEi7VgKZABr7A+_p2qDA=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] ufs: rockchip: Enable SDRAM-only DMA quirk
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Dhruva Gole <d-gole@ti.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Huan Zhou <me@per1cycle.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Joseph Chen <chenjh@rock-chips.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 06 Jan 2026 19:35:03 +0100
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

On Tue, Jan 6, 2026 at 6:09=E2=80=AFPM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> On 1/6/26 14:57, Alexey Charkov wrote:
> > Rockchip RK3576 can boot fully from UFS, but as part of the boot
> > process the SPL needs to place part of the ATF code into PMU SRAM,
> > which is outside the SDRAM range that the UFSHC can access.
> >
> > Enable a quirk to force bounce operation for this case.
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   drivers/ufs/Kconfig        | 1 +
> >   drivers/ufs/ufs-rockchip.c | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> > index 6c75bb2a0790..2543b5d47c04 100644
> > --- a/drivers/ufs/Kconfig
> > +++ b/drivers/ufs/Kconfig
> > @@ -76,6 +76,7 @@ config UFS_RENESAS_GEN5
> >   config UFS_ROCKCHIP
> >       bool "Rockchip specific hooks to UFS controller platform driver"
> >       depends on UFS
> > +     select BOUNCE_BUFFER
> >       help
> >         This selects the Rockchip specific additions to UFSHCD platform=
 driver.
> >
> > diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> > index 0384244387da..699460fc4d15 100644
> > --- a/drivers/ufs/ufs-rockchip.c
> > +++ b/drivers/ufs/ufs-rockchip.c
> > @@ -153,6 +153,7 @@ static int ufs_rockchip_common_init(struct ufs_hba =
*hba)
> >               return err;
> >       }
> >
> > +     hba->quirks |=3D UFSHCD_QUIRK_DMA_SDRAM_ONLY;
>
> So you really want to enable this quirk for non-SPL builds aswell ?

Well I haven't run into any similar issues with the main U-boot, so I
don't have a strong opinion about keeping it in place there.

However:
1. Having the quirk enabled doesn't cause all transfers to go via the
bounce buffer. Only those for which the provided destination buffer
happens to be outside SDRAM (which must be extremely rare if at all
possible under U-boot, given that it hasn't caused issues for anyone)
2. If it turns out that there are indeed cases when the UFSHC needs to
read or write something outside SDRAM while operating under U-boot (I
can't think of a reason now, but then I couldn't think about that ATF
to PMU SRAM thing either, until I ran into it and spent more than half
a day debugging) then I'd rather spend a couple of CPU cycles on a
memmove than end up with a hard lock up, a cryptic error message and a
dump of UFSHC status registers
3. It's one line less code this way :)

Happy to add something like "if (xpl_phase() =3D=3D PHASE_SPL)" though, if
that sounds better to everyone.

Best regards,
Alexey
