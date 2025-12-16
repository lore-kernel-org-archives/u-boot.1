Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F73D5CCB3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 10:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E482833C6;
	Tue, 16 Dec 2025 11:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.b="blA4EBFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC688334F; Tue, 16 Dec 2025 11:00:44 +0100 (CET)
Received: from mail11.out.titan.email (mail11.out.titan.email [3.232.242.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A329E8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 11:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dVsr94N1fz9rx0;
 Tue, 16 Dec 2025 10:00:41 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=mj12kWkO6rlCNjSz5WLtM+5G6zYaejA2HyJ6u1XRWkc=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
 q=dns/txt; s=titan1; t=1765879241; v=1;
 b=blA4EBFWbmrK0yt23A4fjWCQ6DKORIuoTssjKQw0xWNE4XUvoACmBmGUSJ6ozEUgAQwwhGS5
 fp17F8EtcEMXkMdDP+oSaJGOcFpXimJhU/bti3pzAUuRP7TDQ1l9OhOjNepbVSaWw/0Ivh563i8
 X7ZhS3k9YwUefdOMd9XZ1ivA=
Received: from pie (unknown [117.171.66.90])
 by smtp-out.flockmail.com (Postfix) with ESMTPA id 4dVsr30712z9rvR;
 Tue, 16 Dec 2025 10:00:34 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:00:31 +0000
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>,
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 4/7] usb: ci_udc: Convert driver to DM_USB_GADGET
Message-ID: <aUEtvy4ggZE-z8-j@pie>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
 <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-imx8ulp-v1-4-504115a53020@nxp.com>
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765879241386220647.21635.614421772324637445@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=69412dc9
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10 a=CEWIc4RMnpUA:10 a=8AirrxEcAAAA:8
 a=GiyjKlH3aJ3og4FCEfQA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22
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

On Tue, Dec 16, 2025 at 02:38:36PM +0800, alice.guo@oss.nxp.com wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Convert the ci_udc driver to driver model by using the uclass
> UCLASS_USB_GADGET_GENERIC. The clk and power of USB controller and USB
> PHY both are initialized by parsing the device tree nodes.
> 
> If CONFIG_DM_USB_GADGET is defined, we use the ci_udc driver in DM way,
> if it does not defined, we can use ci_udc driver in its original Non-DM
> way.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> ---
>  drivers/usb/gadget/ci_udc.c | 352 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 348 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> index 4bff75da759..154a3ab7f22 100644
> --- a/drivers/usb/gadget/ci_udc.c
> +++ b/drivers/usb/gadget/ci_udc.c

...

> +static int ci_udc_otg_probe(struct udevice *dev)
> +{
> +	struct ci_udc_priv_data *priv = dev_get_priv(dev);
> +	struct usb_ehci *ehci;
> +	int ret;
> +
> +	ehci = (struct usb_ehci *)devfdt_get_addr(&priv->otgdev);
> +
> +	pinctrl_select_state(&priv->otgdev, "default");

I think device core would take care of pinctrl and set it to "default"
state before probing the driver if possible, is this call to
pinctrl_select_state really necessary? See device_probe() in
drivers/core/device.c.

Regards,
Yao Zi
