Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7109DC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 14:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65FD846FD;
	Mon,  6 Jul 2026 16:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="13YOELvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D693784852; Mon,  6 Jul 2026 16:20:11 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17A53846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 16:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6401f59d0=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783347609; x=1814883609;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=wJ1RQ92x3XA+4q29xz6wUz5pSyV1GLA36EU2JlHhfTA=;
 b=13YOELvmkUtIBXsxS7y9hRpM+zn/JbdJ3NBdwWQadS8zZGvYJ+F8ip2O
 3MXuJRklPmylri3/2DXQv+ukw9BApOgMgzA5FHc5ElyOwGcWv84lUCps+
 Ja0Qp1N6jcqY1afdSvZ7zGRuiN6RPF1nYkpGLblaKAxekbwrXa4TCzGEp
 vA1faAPhtrC4SwyDdiRQZFpEY3Ze0SEZQA+JrJIpaX2HMiFMRIW3HEhtc
 S8SL4Vp+VLklsPKTff64g3CCnoy11RfoNgCt2qmH6kPG1U95MPUwb0Y4y
 LUznhZod60P18JLrq2tOqEWQtiMEZA4maJkIHVb+8jN3tFvdC1eAycM+j A==;
X-CSE-ConnectionGUID: c7e1O96PShuw1EP5PW0OHw==
X-CSE-MsgGUID: 9F1mbTNSQ0ijJDQR/LvDGg==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="60153746"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Jul 2026 07:20:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 6 Jul 2026 07:20:06 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 07:20:04 -0700
Date: Mon, 6 Jul 2026 07:20:03 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 "Rahul Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Tom
 Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan
 <peng.fan@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass
 <sjg@chromium.org>, Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, "Quentin
 Schulz" <quentin.schulz@cherry.de>, Stefan Roese <stefan.roese@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Philip Molloy
 <philip.molloy@analog.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 "Casey Connolly" <casey.connolly@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH 5/7] drivers: power: add support for RPMI power domains
Message-ID: <aku5kzlWKcMYDYzE@bby-cbu-swbuild03.eng.microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
 <20260626201613.1035208-6-charles.perry@microchip.com>
 <akIQggjnR/8JfkWQ@shlinux89>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akIQggjnR/8JfkWQ@shlinux89>
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

On Mon, Jun 29, 2026 at 02:28:18PM +0800, Peng Fan wrote:
> On Fri, Jun 26, 2026 at 01:15:46PM -0700, Charles Perry wrote:
> >The RISC-V Platform Management Interface (RPMI) defines the device power
> >service group [1] that is used to control power domains. This is used to
> >implement a UCLASS_POWER_DOMAIN driver.
> >
> >[1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.9)
> >
> >Signed-off-by: Charles Perry <charles.perry@microchip.com>
> >---
> ...
> >+};
> >+
> >+static const struct udevice_id rpmi_pd_ids[] = {
> >+	{ .compatible = "riscv,rpmi-device-power" },
> 
> Not find this binding in Linux kernel or dt-schema.
> 
> Regards
> Peng.

Right.

I'll remove the device power service group in the next version. This is not
strictly needed for the initial introduction of RPMI and can be added
latter.

Thanks,
Charles


