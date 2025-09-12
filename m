Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9692ECAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 13:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD03983429;
	Fri, 12 Sep 2025 15:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ALWzWA3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8794F833E9; Fri, 12 Sep 2025 15:02:47 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCF483281
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mathieu.dubois-briand@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CDAB64E40CA2;
 Fri, 12 Sep 2025 13:02:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8CC4460638;
 Fri, 12 Sep 2025 13:02:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 82834102F28D5; 
 Fri, 12 Sep 2025 15:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757682164; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=G8hmPW9teiLw6iYb6thvwDFODNmSUx65ugnsuKWSw6I=;
 b=ALWzWA3kpkZHsbKR7LVQGcMhOxDAnNR3RcqM5JTzoS9sFM4F8vQm1DSsisSa2e8Vl4hbU8
 TgIW3dBUO3vwO9YJPUV45eIGZugRBTmRapm1i9/AAD99fxrGBeveyJ8oX8RuYYH63Ie9qB
 cUd5ou0OZmB33GXHnHkTGBqcd3XK1FosIEPO49PrWFfgYvRCAPASnui4vnrYDGQGJvsMYe
 mfNEbbHUN5MtxJqWbvmPAOonXCWz7n/GneCm1LsY8cSMDXfaiPUNTgi1dYJdTWoBrxkSyY
 oFnSThP66RiJkm/9DrhkOyuO40J4cvDsuHAF34DSaYZiJCrGcTZD2yNnVO8DVw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Sep 2025 15:02:43 +0200
Message-Id: <DCQUBQH9WP7A.1LHUU1832BW1D@bootlin.com>
Cc: "Stefano Babic" <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, "Tom Rini" <trini@konsulko.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH] imx93_frdm: Add support for flashing board with UUU
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250911-mathieu-frdm_imx93_fastboot-v1-1-c629d8b7c8cc@bootlin.com>
 <CAOMZO5BeSWeUa7Ek=E0gAo0e4wzooseBsjKnkGSYZpMCx5fWgA@mail.gmail.com>
In-Reply-To: <CAOMZO5BeSWeUa7Ek=E0gAo0e4wzooseBsjKnkGSYZpMCx5fWgA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 12 Sep 2025 15:04:58 +0200
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

Hi Fabio,

On Thu Sep 11, 2025 at 9:43 PM CEST, Fabio Estevam wrote:
> Hi Mathieu,
>
> Thanks for your patch.
>
> On Thu, Sep 11, 2025 at 10:35=E2=80=AFAM Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> wrote:
>
>> +       if (get_boot_device() =3D=3D USB_BOOT) {
>> +               printf("Detect USB boot. Will enter fastboot mode!\n");
>
> Nitpick: printf("USB boot detected. Will enter fasboot mode\n");
>

OK

>> +fastboot_partition_alias_all=3D0:0
>> +fastboot_partition_alias_bootloader=3D0.1
>> +emmc_dev=3D0
>> +sd_dev=3D0
>
> emmc_dev and sd_dev are both 0. Is this expected?
>

Erf, of course this is incorrect. Thanks for noticing this.

>> +CONFIG_USB_GADGET_VENDOR_NUM=3D0x1fc9
>> +CONFIG_USB_GADGET_PRODUCT_NUM=3D0x0152
>
> To keep consistency with other i.MX development boards, please use:
>
> CONFIG_USB_GADGET_MANUFACTURER=3D"FSL"
> CONFIG_USB_GADGET_VENDOR_NUM=3D0x0525
>
> As done in configs/imx8mp_evk_defconfig, for example.

OK

I will fix these points and send a new version soon.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

