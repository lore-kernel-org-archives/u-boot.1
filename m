Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EF1CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D0983A48;
	Thu,  9 Oct 2025 14:39:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qbMA3BtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE5083A4B; Thu,  9 Oct 2025 14:38:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D723B83A3A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 14:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3485444D16;
 Thu,  9 Oct 2025 12:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1ABC4CEE7;
 Thu,  9 Oct 2025 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760013532;
 bh=VzksdcudeMN6sel9/1SAC7anjGje5C6H1KLSPItfwxA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qbMA3BtD05tNHrWtaQcAhGWpv9wBGkRt6iqzYoqqK6OmVaA4RHKw7GLnW8cSS6zy5
 teh4gDhFo6dWA7uhn2iVngePRWCpsProsThP3Z+9MOMU1KT6Fz6g+mhVcyI0xyd1ot
 2zvdENECN+zAsLtLgy8oVbBZ3ZJ8cXapqYPv+/KP84VlRi3fd3RE/ta2beMup3Ge2A
 LNKaS0dca6gVv15iK7e03IIDmUTgt0y+5/cRAqyRhqOFaMdXjbV4GlMf63SzuSNC0x
 hd5IW02jKXz/Ftla9IXGzQP2rZTZhuQqkGhen1gCoPtRm9zY7wYru71EQZ0UswJW/E
 oAZiwbEszxNtQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Peng Fan
 <peng.fan@nxp.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Adrian
 Alonso <adrian.alonso@nxp.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH 5/6] usb: dwc3: gadget: Add
 delay after software writes DCTL in dwc3_gadget_run_stop()
In-Reply-To: <PAXPR04MB964469BED1917590C26B835DE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
 <PAXPR04MB964469BED1917590C26B835DE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
Date: Thu, 09 Oct 2025 14:38:49 +0200
Message-ID: <878qhkw8py.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Alice,

On Thu, Oct 09, 2025 at 10:34, "Alice Guo (OSS)" <alice.guo@oss.nxp.com> wr=
ote:

>> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Mattijs Korpershoek <mkorpershoek@kernel.or=
g>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B49=E6=9C=8829=E6=97=A5=
 16:47
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>; St=
efano Babic
>> <sbabic@nabladev.com>; Fabio Estevam <festevam@gmail.com>; dl-uboot-imx
>> <uboot-imx@nxp.com>; Tom Rini <trini@konsulko.com>; Peng Fan
>> <peng.fan@nxp.com>; Troy Kisky <troy.kisky@boundarydevices.com>; Adrian
>> Alonso <adrian.alonso@nxp.com>; Lukasz Majewski <lukma@denx.de>; Mattijs
>> Korpershoek <mkorpershoek@kernel.org>; Marek Vasut <marex@denx.de>;
>> tharvey@gateworks.com; Alice Guo <alice.guo@nxp.com>
>> =E6=8A=84=E9=80=81: u-boot@lists.denx.de
>> =E4=B8=BB=E9=A2=98: Re: [PATCH 5/6] usb: dwc3: gadget: Add delay after s=
oftware writes DCTL
>> in dwc3_gadget_run_stop()
>>=20
>> Hi Alice,
>>=20
>> Thank you for the patch.
>>=20
>> On Sun, Jul 20, 2025 at 06:13, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
>> wrote:
>>=20
>> > From: Alice Guo <alice.guo@nxp.com>
>> >
>> > When using NXP UUU to download flash.bin to i.MX95 19x19 evk board, it
>> > will get stuck in a loop at sdp_init() without this change.
>> >
>> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>=20
>> I see that a similar change exist in the Linux kernel:
>> https://lore.kernel.org/all/20220901193625.8727-4-quic_wcheng@quicinc.com
>> /
>>=20
>> Please mention this change in the commit message for v2.
>> See the following example:
>> https://lore.kernel.org/all/20250110-dwc2-dev-v4-7-987f4fd6f8b2@pigmoral=
.te
>> ch/
>>=20
>> > ---
>> >  drivers/usb/dwc3/gadget.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> > index 2b01113d54c..6b2b25c7aa5 100644
>> > --- a/drivers/usb/dwc3/gadget.c
>> > +++ b/drivers/usb/dwc3/gadget.c
>> > @@ -1423,6 +1423,7 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc,
>> int is_on, int suspend)
>> >  	}
>> >
>> >  	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
>> > +	mdelay(2);
>>=20
>> Can you elaborate on why 1ms is not enough?
>>=20
>
> Apologies for the confusion that I previously replay this email from the =
wrong email address.
>
> Hi Mattijs,
>
> Apologies for the confusion that I previously replay this email from the =
wrong email address.

No worries.

>
> This patch I submitted was indeed inspired by the change you mentioned in=
 the Linux kernel. The mdelay(2) value was determined empirically during te=
sting on our development board.
>
> However, after a deeper understanding of the driver, I believe the real r=
oot cause is that the USB3 PHY was not properly initialized. When DWC3 is c=
onfigured to DWC3_DSTS_SUPERSPEED in dwc3_gadget_start(), enumeration fails=
 because the PHY is not ready and cannot complete the electrical and protoc=
ol-level handshake required by USB 3.0. The delay acts as a workaround to c=
ompensate for the missing hardware initialization or timing issues. Once th=
e PHY driver (phy-imx8mq-usb.c) is added and properly initializes the USB3 =
PHY, the delay is no longer needed.
>
> The updated changes are included in the patch set titled "Enable USB and =
ENETC on i.MX943 EVK", specifically in patch 6 and patch 7:
> https://patchwork.ozlabs.org/project/uboot/patch/20250923-usbnetc-v1-6-50=
7cddbe7214@oss.nxp.com/
> https://patchwork.ozlabs.org/project/uboot/patch/20250923-usbnetc-v1-7-50=
7cddbe7214@oss.nxp.com/
>
> Thanks for the feedback!

I see, thanks for taking the time answer me. And glad you could solve
this properly by enabling the PHY driver.

>
> Best regards,
> Alice Guo
