Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6843ECD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF95384CF3;
	Fri,  8 May 2026 17:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OrmVwiUj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978AF84BBD; Fri,  8 May 2026 17:26:26 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF39684BBD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bc64ad08bf9so340452566b.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778253984; cv=none;
 d=google.com; s=arc-20240605;
 b=Mvk9PrJTQ01UeRkke6LLs0Mt+8xYOdhRXkCmWdGqPtrAVSmZHhpjsoycvag7S9HjJ2
 moIhBltuBRsivzsB+13yH7XsPtpm5kGdeZy6Utyd+eexMKavtc5pJQPu1Brfz9DQTXro
 BnABfCDwGEC6e5jejBDFhrKNRSnFxsWEcsKFlgX3AFq/r5N5ktIvQGFnAbB6uGj2JZpJ
 miibTYHcdIFVlQkdP1r5QxgEXjDgU4vPFWjxn74VPFRtcLFiti/Chw7YQCxvFifrOx58
 r0DWIDUJowTGhRRTyekqAqM65NMZFxN/jH8XPjOuLFqxd2RlDIe7zpu0kUUh/OK/KSkt
 aN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UKqBoWOEJJBZIW16ekDrYJFGAnybI0Cfo2VM6Cj84FQ=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=M+ds2G2eSxTQ2r2Y+rcaOKKA6tyzIWD6rebqxiMArevAdEssgmw5xZklrLwxyuEN/V
 1mMt/bdyIcZ3suTU+Q2qO4BwmOAC0BsGV86Q54D5s/x2E2jFd0pWqJ4p13SilVlJWWMa
 sY9JMe7Hlz1tfkA81bxw2IYLtSB8msavzPge5Mxqjbg6NzitLE4V+ncUcs1aNJfDuyF/
 CI0WWZbF/vT/CFs9myZfdKkh3TeR91nWJgdjpe8AFNu1ZUoZ7y9NCv6aWw0J12sGLwEp
 Dn95segrj1htTKoMIE4dfNlXRAHMXhxrBgX0tKgy5UCFwxdvHENz/e8bbGjpScBCzGta
 pRew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778253984; x=1778858784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UKqBoWOEJJBZIW16ekDrYJFGAnybI0Cfo2VM6Cj84FQ=;
 b=OrmVwiUjHMCLIBcCZk3by67gYG41Kob5rYBnSexLMqAFpvrINtolnml/xLycsy0zV2
 nGmzWJLdrgONXMQuf13FQFa27fll3L6pMrwTB043pJE4dhfjRvupH5B17UobMjULLEro
 wIvDgambKETVV234Gy9HgRC7RnpNllceu1/OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253984; x=1778858784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKqBoWOEJJBZIW16ekDrYJFGAnybI0Cfo2VM6Cj84FQ=;
 b=Y80cjDaHbGJ5uQuEkWE9Q7KA1ZHvHaeKe0Ghby2x7HXePpRNnv62BIQdsNe5WMJkKo
 3X3/6kfIADK8MTMhjv8f5tHH3EAN0b2LtNtCEuXk9f3KU3H6SiEB+MpgIb/iobBMW9M8
 YJ+lJnLefrM+AvjZvDb43bWFZZS/bnzSStXgrlDkmXqvazdVeloNQdBI7oImZu+mBATK
 2or3FdPYST0eqIACAoQCnKBNVryXKEUqsPSsnTik/OF1vsLuqPCZaIALLWOhOefTI+ql
 OlQF/R6/VTjnKXY6M08hb3TAApdLmrc4yN4AfjtpbjFJCOuQAC16pAiADmXafRelhSk9
 v4vw==
X-Gm-Message-State: AOJu0YwWX8X9gNm3jG0SjA7/ukUpPz+hK3PzF+zlMeqntDOWRtTjikkM
 qp8B4ssD3MZrJvfckHtSMG7H7giZ2dhBi8AOzSWWdNgH0qqBwpXwPD1PNIDch//ElE29eOmTaut
 nsvjs2CS8Wd/ycNUr671qS5R1g/+Z4ACNkQTnKcy8
X-Gm-Gg: AeBDievAEs2cMZguEZxab7lHAY9I7vFkEfU++0krY3buclKxKKjk5hzlOT5I8XIf8Ji
 X+59V4Mnt+7JqrsniTfYh/KeHee3kL78SpgwBQPvyiwaN0cIcMnhAaAsM1jXHcpR0EHNbI2mhso
 De6vVCa5npAK45Ei6AOlGvkOCer6KVpnQvNdEydSx7IvbBdbjhG4aIIJKjqS/aY3GJhXKUyOLV+
 TyjUb1bYrGBJ4S+m5dvhH/IsTAfQ8SWNlyKGmLra8ANjW1YbBZ4sAZ1P0wRrUmmdJbnkM81EFX6
 Xwyb+A==
X-Received: by 2002:a17:907:1c9b:b0:bc4:75be:62d9 with SMTP id
 a640c23a62f3a-bc56f9fdfc3mr830819566b.45.1778253982741; Fri, 08 May 2026
 08:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-6-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-6-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:26:07 -0600
X-Gm-Features: AVHnY4Ljhfa02ef7Jx7oUp7R2MRpa5w_Q1-bnpoJVk2eeEwyr3V4Ckr1PNzO5mY
Message-ID: <CAFLszThadHrxu2nszMKHGrfU8ZExO88rGzLxMUONAx3VFyJodg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/64] usb: dwc3: import from kernel v4.2
To: jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v4.2
>
> Sync Linux kernel dwc3 changes from v4.1 to v4.2.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v4.1..v4.2
> Commits imported:
> aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
> 43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
> 50641056d833 usb: dwc3: Use ASCII space in Kconfig
> 19915e623458 Merge 4.1-rc7 into usb-next
> e152813ff5fe Merge tag 'usb-for-v4.2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
> 76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
> 891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
> 909eacd748b3 Merge 4.1-rc4 into usb-next
> 88bc9d194ff6 usb: dwc3: add ULPI interface support
> a89d977cc04c usb: dwc3: pci: add quirk for Baytrails
> 3e10a2ce98d1 usb: dwc3: add hsphy_interface property
> 45bb7de213d8 usb: dwc3: setup phys earlier
> c5cc74e8c12b usb: dwc3: soft reset to it's own function
> 2917e7181589 usb: dwc3: cache hwparams earlier
> 6c89cce0476f usb: dwc3: store driver data earlier
> f699b94789a6 usb: dwc3: ULPI or UTMI+ select
> b5699eeee68f usb: dwc3: USB2 PHY register access bits
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> drivers/usb/dwc3/core.c          | 110 ++++++++++++++++++++++++++++++---------
>  drivers/usb/dwc3/core.h          |  26 +++++++++
>  drivers/usb/dwc3/ep0.c           |   4 ++
>  drivers/usb/dwc3/gadget.c        |  10 +++-
>  drivers/usb/dwc3/platform_data.h |   2 +
>  5 files changed, 126 insertions(+), 26 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
