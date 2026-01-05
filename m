Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F75C79FBD
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBB1836A3;
	Mon,  5 Jan 2026 20:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b8GdOUDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 121EE83D62; Mon,  5 Jan 2026 20:51:13 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0248D82B20
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-8b25dd7ab33so22473785a.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767642669; x=1768247469; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Le7UhoIFOLTec4IX99i8QE/FWjxFWOWhC1QTGixpu3I=;
 b=b8GdOUDvNpA7NaH8ZisY83uVian8YcTwCugm6URQHGZntqiTmfe0/Xt2tcWNhQ26lj
 8u814O6U1Y0dy/pJCbYhe7F8UYA+ct2HoYWrVlI9OxQrP9SpSleF+GJZC072+jcPXbb2
 d9PnM1oZHt563TEjUXxYYIEFWyKyww+pqSL8Ofxj0qhnH7d/xZhHyLcWUuQ4slbWJb5A
 qRlZYPknJ5vHOHNvxj3Gg/mJvEKhX+SIi2B9ETW9r5Bhs9IvZp3Z5/1lLYGjwAzh8xTJ
 z9Ln2v55Yln9x1ao3fkWlXy1xHuKQyzVQMuYzdQuc9fcC7NaqDNAce7pGLluwnrZhodW
 2xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642669; x=1768247469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Le7UhoIFOLTec4IX99i8QE/FWjxFWOWhC1QTGixpu3I=;
 b=EyIgxbuzbMUGXUrs6F4tRdFEU1Vv3LpnfOmSPp+DiQiXMcZZOYLUX6jI1BZIt6+eNl
 T5zotzN7b/rhtKQpP1rC0Rj+NFjTBwL6QKa0MCc7Gn3VPtsGXudF++TruS+4jZv6Tlan
 pKMaVJ6CNXirl3ies+oiaQCWX2bqA7d3TkEzKitNvetDUPX5DIH4mATr/Y9h/H4567/1
 w9SFawefFi6f87YbfeAKo4e69ih7nmMf/Ut3WUn4RMGc3qhpWKFHVFD7OC2QElOEUCPr
 jl5TZUxtcAqnj9pryDcmIMQAx7RiHdi62b57Elro+fWU8/znaL/4LsXXaciZKV4LlQw2
 pS2Q==
X-Gm-Message-State: AOJu0YxXPU5L/ogX7JK2zMTDsXbr41gCwh/dcrU8fY4H590knJiF/r/8
 GXNWsh0WMSlB5tbtW+XR0RQgT3n6gUE/2sskQufLytgQNM56yVpEqZIRa1aIFIuJLnsK+US2sDW
 Y6v2m3NqAgsitsS0fOmCLZX808EYdguU=
X-Gm-Gg: AY/fxX6ROlwNM6bbMoeoJ3T+Y1A3UuUDeKiO631e0Zq97hwu4n6EG3APePcZ14E8a+o
 EkygzTMB1m5tm6uT+ygJVrty9ACBuIkn3CjDvoUMf4OKksDIpE/NKXZk1N/P37aDd1weDKy1LFX
 DbCAZGSIH2BHQJ15Rm6FCnwLuR1Skzsf6golnyZCERRqyhaypVYBOHryWVdqRrAvccEi3/slzOJ
 2nchfJB2muXR2R4QqxBbWO7FuJtyipGiqAE5D0nKWHYas0SRRP+llsh7vpAsNKAycm2K7lk5+r2
 licLXXKxqcsaTcJ5E+OaGQgGandp
X-Google-Smtp-Source: AGHT+IGvELj172weYTCrFI8PzinB0HPwE7R5ez/XPY2/fKSNE1mqHbnzf3GprO/0rEvjDG8vkHttVXAn2xeoGN0a3o4=
X-Received: by 2002:a05:622a:2597:b0:4ee:2984:7d95 with SMTP id
 d75a77b69052e-4ffa76a1fa9mr11289281cf.13.1767642668487; Mon, 05 Jan 2026
 11:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20260105-rk3576-ufs-v2-0-caba979a0d6b@gmail.com>
 <20260105-rk3576-ufs-v2-1-caba979a0d6b@gmail.com>
 <20260105151816.GM6124@bill-the-cat>
 <CABjd4YzxpEFA0qCgUT4T1Z3R4O0W7LqPNdFWn7=5NDHO8K7XKQ@mail.gmail.com>
In-Reply-To: <CABjd4YzxpEFA0qCgUT4T1Z3R4O0W7LqPNdFWn7=5NDHO8K7XKQ@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 5 Jan 2026 23:50:58 +0400
X-Gm-Features: AQt7F2rA51Aw0dOcgo3T7njkQu2wVtyHqKmvYgOYzsSP-SJnx2cJyqWc6IsRnG4
Message-ID: <CABjd4YwuqFH9gzDmmxD4rq-VXK0jBB98-giNWvMrWMAP6KAJbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] spl: Make UFS available for SPL builds
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Elaine Zhang <zhangqing@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Andre Przywara <andre.przywara@arm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut@mailbox.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Dhruva Gole <d-gole@ti.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 05 Jan 2026 20:55:41 +0100
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

On Mon, Jan 5, 2026 at 10:15=E2=80=AFPM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> Hi Tom, Neil,
>
> Your replies came pretty much simultaneously :)
>
> On Mon, Jan 5, 2026 at 7:18=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Mon, Jan 05, 2026 at 07:05:36PM +0400, Alexey Charkov wrote:
> >
> > > Add minimal infrastructure to build SPL images with support for UFS
> > > storage devices. This also pulls in SCSI support and charset function=
s,
> > > which are dependencies of the UFS code.
> > >
> > > With this, only a fixed offset is supported for loading the next imag=
e,
> > > which should be specified in CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR as the
> > > number of 4096-byte sectors into the UFS block device.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > [snip]
> > > +config SPL_UFS_SUPPORT
> > > +     bool "Support loading from UFS"
> > > +     select SPL_LOAD_BLOCK
> > > +     help
> > > +       Enable support for UFS in SPL. This allows
> > > +       use of UFS devices such as hard drives and flash drivers for
> > > +       loading U-Boot.
> > > +
> > > +config SPL_UFS_BOUNCE_BUF
> > > +     bool "Use a bounce buffer for UFS loading"
> > > +     depends on SPL_UFS_SUPPORT
> > > +     default y if ARCH_ROCKCHIP
> > > +     help
> > > +       On some platforms the UFS host controller may be unable to lo=
ad all
> > > +       image segments directly to their required memory locations (e=
.g. due
> > > +       to DMA constraints). This option enables an interim bounce bu=
ffer in
> > > +       system RAM to let such platforms boot directly from UFS, at a=
 cost of
> > > +       an additional memory move while loading the image.
> >
> > So, the full U-Boot rockchip UFS driver does not use the generic
> > BOUNCE_BUFFER mechanism. Is this because of memory constraints in SPL?
> > Second, can we not just re-use the generic bounce buffer code
> > (common/bouncebuf.c) ? Thanks.
>
> On Mon, Jan 5, 2026 at 7:22=E2=80=AFPM Neil Armstrong <neil.armstrong@lin=
aro.org> wrote:
> > Can't this be replaced by the SCSI bounce buffer ?
>
> Thanks for the pointers. Frankly, I've overlooked the existing generic
> functionality, being somewhat new to the codebase.
>
> It seems that the current UFSHC driver only deals with broken 64-bit
> addressing when deciding to use a generic bounce buffer, while the
> constraint in this case is that part of the FIT image containing the
> ATF wants to load itself not to system RAM, but to a PMU SRAM region,
> which is inaccessible to the UFSHC's DMA engine either due to security
> firewall settings (as Jonas Karlman proposed in his comments to v1 of
> this series) or some other reason.
>
> I guess I could add a per-variant override of the scsi_ops
> ->buffer_aligned() callback (which in turn gets propagated to
> blk_ops), checking if the requested buffer is above/below the start of
> RAM on Rockchip RK3576 specifically? Just wondering whether that would
> be considered an abuse of the interface, given that it's not really
> anything to do with alignment as the callback name implies.

Quick update. I can confirm that the following one-liner works just
fine instead of my open-coded version:

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259c..eb2882d35e03 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -2257,7 +2257,7 @@ static int ufs_scsi_buffer_aligned(struct
udevice *scsi_dev, struct bounce_buffe
                return 0;
        }
 #endif
-       return 1;
+       return (ulong)state->user_buffer >=3D CFG_SYS_SDRAM_BASE;
 }
 #endif /* CONFIG_BOUNCE_BUFFER */

Would anything of this sort be acceptable? Happy to adjust in v3.

I'm guessing that DMA reads to an address not in SDRAM is a niche
situation, so no one should be too upset about them going through a
bounce buffer. Furthermore, this block of code would currently only
apply to Rockchip RK3576 and Renesas gen4/gen5 by the virtue of
Kconfig dependencies.

Best regards,
Alexey
