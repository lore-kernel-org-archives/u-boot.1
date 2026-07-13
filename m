Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B8EC44507
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0042884B45;
	Mon, 13 Jul 2026 15:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fEUDWnfx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A51984B48; Mon, 13 Jul 2026 15:11:04 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 338AD84B3B
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso4619632a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:11:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783948261; cv=none;
 d=google.com; s=arc-20260327;
 b=hDcaO7CIvUXTD7B6FwMzKgIv34k3KnbyzfGr6XsXiqWxqgD4PijcNAyZoMhnDeYAG6
 VfyjgCzvHyX6n/EqM5GwVz/uMZBjbCa2LHGGSaWRwiFyQcXPLLvQgWtbqd5NIy54PNHI
 toTN+MIPOKc40lLoc6jYg2PmvAXzIRipeF6LwU9pvxYxxvJ6kVbSVHA1Tha26flaC505
 0kySWsZQYVeC79jFRFVNLa1E0j2yVIRPeduqf0/3nWvZEIcExTLujsQr7p7lEHg0HQq3
 RjSRRJeZOCCI0Zj1seckaNZcYo7C4KhCAcocySvEc8KmQ6xfqFELGQIjULmGrxrnZox8
 Royg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sqbfqV39WtEaJ8GnnYHn5xwi+n7v0E1SfHFvDPWx/8k=;
 fh=7fq2WdkNCvCMvJmCEHaCPgmX74d0EzLwasMFTlOEV04=;
 b=UBmcygFt9RwW6W0F6o1qjsIiPzC2AEb3/cg9jEMfPsovcQE424PqDzZlZZZmK1TFym
 Yys2/19MmU1mIOYDu0oUdKuWj3KwPeJjWJNVaONCIdSuaXsfp6wZXGSlg09OH0SfNmIM
 vOmOjEZglEZmmK0Uw0dULEUacZLFeRWVagpJXbKYmjosG0G3K09VBBGYGdDAlgq+UuMO
 RNsz6tGwdgAD00vkh5Jhq0CulhOrSdtXGVyfdcaj63NYA0y0DIcj6Q5+FZ+C36PYeGLk
 3Ejrn67Z/L6GGpyW8oc3zFDHZGhlP33hCivFH5KeU69E6W0MJN+t6j2nD3Cch7v2vO/C
 FcCw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783948261; x=1784553061; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sqbfqV39WtEaJ8GnnYHn5xwi+n7v0E1SfHFvDPWx/8k=;
 b=fEUDWnfxeG5H+CkT4Cj7HW+uxiu+3TtfoUzTXtpI7TIVHqO4cWnxvIePjyrj8Bz4rn
 GF4z2F2cIXCuHtd6hd2RSd55zvCpzNgvzhCE4hXJG0QJW75sPELeRIrnugFl6N2CZ80p
 VMWp+v3yM3XCUACIe73NQD6JDTueKBrprhnUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948261; x=1784553061;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sqbfqV39WtEaJ8GnnYHn5xwi+n7v0E1SfHFvDPWx/8k=;
 b=R2gwd73N/YeSf8bLai3hqtBKw66AeP4WWhiRt6fUQJxp71IE3npjmbklkE6p3toKrs
 5W8GBZYTDq2+REmFo4l634g3pkhiCZbiAfHhFVgC17C2IL60HU9jz0St6c6+LTzcVaoL
 BwjoGaK5K8XvvsVxoNf0XtfAlNVuEduNn8fOcHWr/5HyP+kdfgNcKZ9VBU+E0S/qXYrw
 KWUHkgIqBbMp1LHmb3+Qk9BS8VtoK6wpn10trJ0urTo0V3cEkupJv+r6geQzm4FR04vy
 OaTqSsWz5dq2mzGUpc6GU+WUjDSPWSAhCZ7I1egK8qPmQAX5K95RX4dRN4i+TKE0KekO
 czKg==
X-Gm-Message-State: AOJu0YzlOLhnbU0nurtxwWWAAZNecD3HiDznDKccJFRBbp5rY0P+ApQ0
 ZDNSakGI1wFYN1b9DluK8AJ8dCK4wdOaasc76MIdOLDvcyGAwoFthdmvhg3IE7xVpfTKD1IBcoa
 Pb898F9TWLcOjH3mfKcNUOiNHdD1AZrHByw3hjXz2
X-Gm-Gg: AfdE7cnuxef6SGkYYLcilv+fh2ThhSnp7pwdSCJRGPvxO7USUAalqSUgq1M0mODn3uU
 tq4aSb4/o/16Th+Hh5F1cNQEmRwVFeN0nlPe2f7M+wVSQUNjpuqUGFBNiM4510OhmbGM3iL7qai
 t8G4no2dYAE1BuOMZoeUEO4yJwMy7NRMUyCAEnwHB1geP9oioG4NCIAYbOV90pAYpGNu6VC3ieI
 ccsuD3tNWta6+ee4HboT9ceZmXfMNAm/XbMWTcMgrVEcqBfne+5WWSO9V4gfcnM/u/KgeM=
X-Received: by 2002:a05:6402:5253:b0:69a:a4cb:2882 with SMTP id
 4fb4d7f45d1cf-69c5f0bb815mr3932075a12.9.1783948261560; Mon, 13 Jul 2026
 06:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
 <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
In-Reply-To: <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 07:10:48 -0600
X-Gm-Features: AUfX_mzvFGeIOb8KatzkC1wZ5JFQpCwEi2LrlmKBeVwX59l1CSTRWZ_E4NNztDs
Message-ID: <CAFLszThwLCFR+HwhOVa69oGv7NTwcjXvHGtgbFsJ4kbPOweRFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
To: romain.gantois@bootlin.com
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
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

Hi Romain,

On 2026-07-02T08:11:07, Romain Gantois <romain.gantois@bootlin.com> wrote:
> usb: gadget: Add Renesas RZ/N1 USBF controller support
>
> Add support for the Renesas USBF controller. This is an USB2.0 UDC
> controller available in the RZ/N1 SoC.
>
> This driver was originally written by Herv=C3=A9 Codina for the Linux ker=
nel.
> Suspend/resume features have been removed in this U-Boot port.
>
> Linux revision this was ported from:
>
> 74851fbb6d64 usb: gadget: renesas_usbf: Handle devm_pm_runtime_...
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Co-developed-by: Romain Gantois (Schneider Electric) <romain.gantois@boot=
lin.com>
> Signed-off-by: Romain Gantois (Schneider Electric) <romain.gantois@bootli=
n.com>
> Tested-by: Ralph Siemsen <ralph.siemsen@linaro.org>
>
> MAINTAINERS                       |    5 +
>  drivers/usb/gadget/Kconfig        |    9 +
>  drivers/usb/gadget/Makefile       |    1 +
>  drivers/usb/gadget/renesas_usbf.c | 3036 +++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 3051 insertions(+)

> This driver was originally written by Herv=C3=A9 Codina for the Linux ker=
nel.
> Suspend/resume features have been removed in this U-Boot port.

Please also mention the two other removals noted in the cover letter -
handling of endpoints > 2 and dynamic detection of endpoint DMA
capability. Otherwise users will be surprised when a gadget needing
more than two endpoints fails to bind.

> +     for (i =3D 0; i < ARRAY_SIZE(udc->ep); i++) {
> +             ep =3D &udc->ep[i];
> +
> +             if (!(usbf_reg_readl(udc, USBF_REG_USBSSCONF) &
> +                   USBF_SYS_EP_AVAILABLE(i))) {
> +                     continue;
> +             }
> +
> +             INIT_LIST_HEAD(&ep->queue);

If the availability check fails, INIT_LIST_HEAD() is never called and
ep->disabled stays 0. usbf_reset() and usbf_detach() then iterate over
all slots and only skip disabled =3D=3D 1, so they will call
usbf_ep_nuke() on an ep whose queue list is uninitialised. On RZ/N1
all three endpoints are always present so this is latent, but please
set ep->disabled =3D 1 before the continue (or at least init the
list_head).

> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> @@ -159,6 +159,15 @@ config CI_UDC
> +config USB_GADGET_RENESAS_USBF
> +     bool 'Renesas USB Function controller'
> +     depends on RZN1
> +     depends on DM_USB_GADGET
> +     select USB_GADGET_DUALSPEED
> +     help
> +        Renesas USB Function controller is a USB peripheral controller
> +        available on RZ/N1 Renesas SoCs.

Two Kconfig nits: prompts use double quotes throughout the file. Also,
the help text is indented one space more than the tab + two spaces
convention used by the neighbouring entries - compare with CI_UDC just
above.

> diff --git a/drivers/usb/gadget/renesas_usbf.c b/drivers/usb/gadget/renes=
as_usbf.c
> @@ -0,0 +1,3036 @@
> +static int usbf_remove(struct udevice *dev)
> +{
> +     struct usbf_udc *udc =3D dev_get_priv(dev);
> +
> +     usb_del_gadget_udc(&udc->gadget);
> +
> +     return 0;
> +}

Just to check - if the device is removed while the pull-up is still
asserted, D+ stays driven and interrupts remain enabled at the EPC
level. Would it be worth calling usbf_detach() here so remove() always
leaves the hardware quiescent? What do you think?

Regards,
Simon
