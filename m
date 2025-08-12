Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF24ECA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 13:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260A583390;
	Tue, 12 Aug 2025 15:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QxQfNGZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297BF833FC; Tue, 12 Aug 2025 15:26:06 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EF3283390
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 15:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-af98b77d2f0so1016981766b.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755005163; x=1755609963;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtgLhjVDncV6kKjDGtWzgP+vyaxQtj4IqXnjj4TLsbI=;
 b=QxQfNGZVr46PG7ElpUf/COuygipLEm9WmV79DN1TnkkYBXc2cIYxZQOllaWaLwSy5A
 ytLMLpWEZfxOENpa5c1qtz9/Fn907NFxvYKnEYiL8G1936EUgJvsjGUnuHO5Pb+xZOQA
 YzHvk7SmDtea7Fac2acMkFMRaZmYxawgjZRYt0Q9JSfo31EK+mvJBKtnUnPUTRzPObf/
 BIDOKUw+dpQdTRggQBMVVhIGF+vXFbW21ynMtkyme54gasZk3r/nyhuhepAjsaKa66Tx
 kob02Ruqik4wnDTypMOXLM+xRzz+XqZ1iqOsRBn5WeMspssPChO+OZyuyf0nZi6kIV7p
 Mccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755005163; x=1755609963;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtgLhjVDncV6kKjDGtWzgP+vyaxQtj4IqXnjj4TLsbI=;
 b=h6f4YUlPQwoEtfzgYwoJDcp8kKrJtJ35YDMkIBnZCks3FraKtUpmI/8hjl+rSBK8BW
 eCZ0NqDoN6G6dmpUO63p+rKOjPCJ4I9EXH521OM7g5va1tX6Mc+isCgLzq1xcCH+9Yq1
 GZfOqN7cznYsJAkiLRtIg6IDTb4r9fBUZMav2CMJ87rgGlDK8hmDHaVdCxy1QJq+2eE1
 JYZH+mCI6jBGtT+dMNsT0gyg8EP476j59JkV+U+q6zCvO5xcwEO35C5mMLbVu0haV6OC
 fhXKXOBkBkjJxTjQvJjvaKBT90k/f5i49CSfwn/3gZI9T7eS3AZGCZso4//PJCUBDUGy
 rhEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEYM5Wau/LVOXKMMrajrMvi1G+T1/24W0t21w1hZ3oQN1olC/j/EjSkCcgX1oLAZ+RIkp/lRg=@lists.denx.de
X-Gm-Message-State: AOJu0YyE2D1Sz3bboRdEL8Ogkj/AQjMuoZqrle7R9s2pB20ipATRTIyB
 Uz/ie1hcIiW2RRCTu8r4NGgpamnqKyserluJ/8BY/WyEcGOu/RN579sVyYk8HVYS9H4=
X-Gm-Gg: ASbGnctYL6Rl62EO9n2DA3AXQeyMpJf5zBqelbmx8a9sUseFTzIL00I7Jo/nJARn9bR
 EwHFNt+Ok5+iKswghDrmCrI61E0oxij3Ko9pFlamJoaUSDbeJzOh1uPQnHmAw/oiy2FJcbC6Dsj
 86r25oPK3kbnhNHSVzD4gTLa9X9RZAqFocYqxTL8hhMq7Ikf+++m22Tc5JfujbV0sf5upYbV9Cp
 VpqJnd3Hnv3ogWKvUW6j3ZEeVrB8tYAgY7oguyq4tygR5vKUBqoGtvOYies8YZBdo+MiClCmdXu
 Qb++cdjVaD0jaD9hYzaC/OF8ZaWVMr1T6ZCZiuNpbo/+NsG8NrSKlShVt2uFXnSF0mIWV0bgSzB
 cnyL7/4zvE9G8Kg==
X-Google-Smtp-Source: AGHT+IElAdZH6iRxSpN6EnK788bQtIEPCXAP7jqvBcy4iBKU6J7KsktIwXPmCzDOMJSbPIFVy69RMw==
X-Received: by 2002:a17:906:9fca:b0:af2:b9b5:1c06 with SMTP id
 a640c23a62f3a-af9c6453129mr1597763566b.14.1755005162792; 
 Tue, 12 Aug 2025 06:26:02 -0700 (PDT)
Received: from localhost ([195.52.61.108]) by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-af91a0766e2sm2199660066b.27.2025.08.12.06.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 06:26:00 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1ec1c947af5f0c00cd54054de5f869e7620c6b98ed15cb72325b102ada23;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 12 Aug 2025 15:25:52 +0200
Message-Id: <DC0HEKLG5NCR.1XPU8UANUK4I4@baylibre.com>
Cc: "Sebin Francis" <sebin.francis@ti.com>, "Dhruva Gole" <d-gole@ti.com>,
 <u-boot@lists.denx.de>, "Kevin Hilman" <khilman@baylibre.com>, "Vishal
 Mahaveer" <vishalm@ti.com>, "Kendall Willis" <k-willis@ti.com>
Subject: Re: [PATCH v3 03/22] ram: k3-ddrss: Add support for DDR in
 self-refresh
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Akashdeep Kaur" <a-kaur@ti.com>, "Sumit Garg" <sumit.garg@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Bryan Brattlof" <bb@ti.com>, "Tom Rini"
 <trini@konsulko.com>, "Robert Nelson" <robertcnelson@gmail.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>
X-Mailer: aerc 0.20.1
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
 <20250623-topic-am62-ioddr-v2025-04-rc1-v3-3-a4da322c16af@baylibre.com>
 <cd4f6a21-74c3-45e1-bece-426efb2b0705@ti.com>
In-Reply-To: <cd4f6a21-74c3-45e1-bece-426efb2b0705@ti.com>
X-Mailman-Approved-At: Tue, 12 Aug 2025 15:58:39 +0200
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

--1ec1c947af5f0c00cd54054de5f869e7620c6b98ed15cb72325b102ada23
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Akashdeep,

On Wed Jul 2, 2025 at 8:49 AM CEST, Akashdeep Kaur wrote:
> Hi Markus,
>
> On 23/06/25 17:38, Markus Schneider-Pargmann wrote:
>> In IO+DDR the DDR is kept in self-refresh while the SoC cores are
>> powered off completely. During boot the normal initialization routine of
>> DDR is slightly different to exit self-refresh and keep the DDR contents=
.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
>>   drivers/ram/k3-ddrss/k3-ddrss.c | 177 ++++++++++++++++++++++++++++++++=
++++++++
>>   1 file changed, 177 insertions(+)
>>=20
>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-d=
drss.c
>> index 6590d57ad84f3c4dc5c72c6c5889038c463b0469..874614140c6d4a785fcca6ed=
a4a8736e1183e193 100644
>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>> @@ -57,6 +57,16 @@
>>   #define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
>>   #define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5
>> +static void k3_ddrss_self_refresh_exit(struct k3_ddrss_desc *ddrss)
>> +{
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_169,
>> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_EXIT_EN_MASK |
>> +				 K3_DDRSS_CFG_DENALI_CTL_169_LP_AUTO_ENTRY_EN_MASK,
>> +				 0x0);
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_PHY_1820,
>> +				 0,
>> +				 BIT(2) << K3_DDRSS_CFG_DENALI_PHY_1820_SET_DFI_INPUT_2_SHIFT);
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_106,
>> +				 0,
>> +				 K3_DDRSS_CFG_DENALI_CTL_106_PWRUP_SREFRESH_EXIT);
>> +	writel(0, ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_PI_146);
>
> Can we change this writel also to reg update function based call?

Yes, that would be possible, but it would transform a single write into
a read/update/write.

>
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_PI_150,
>> +				 K3_DDRSS_CFG_DENALI_PI_150_PI_DRAM_INIT_EN,
>> +				 0x0);
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_PI_6,
>> +				 0,
>> +				 K3_DDRSS_CFG_DENALI_PI_6_PI_DFI_PHYMSTR_STATE_SEL_R);
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_21,
>> +				 K3_DDRSS_CFG_DENALI_CTL_21_PHY_INDEP_INIT_MODE,
>> +				 0);
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_20,
>> +				 0,
>> +				 K3_DDRSS_CFG_DENALI_CTL_20_PHY_INDEP_TRAIN_MODE);
>> +}
>> +
>> +static void k3_ddrss_lpm_resume(struct k3_ddrss_desc *ddrss)
>> +{
>> +	int ret;
>> +	unsigned long timeout_start;
>> +
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_160,
>> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_MASK,
>> +				 K3_DDRSS_CFG_DENALI_CTL_160_LP_CMD_ENTRY);
>> +	ret =3D wait_for_bit_32(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL=
_345,
>> +			      (1 << K3_DDRSS_CFG_DENALI_CTL_345_INT_STATUS_LOWPOWER_SHIFT),
>> +			      true, 5000, false);
>> +	if (ret)
>> +		panic("Failed waiting for low power command %d\n", ret);
>> +
>> +	k3_ddrss_reg_update_bits(ddrss->ddrss_ctl_cfg,
>> +				 K3_DDRSS_CFG_DENALI_CTL_353,
>> +				 0,
>> +				 1 << K3_DDRSS_CFG_DENALI_CTL_353_INT_ACK_LOWPOWER_SHIFT);
>> +
>> +	timeout_start =3D get_timer(0);
>> +	while (1) {
>> +		if (get_timer(timeout_start) > 5000)
>> +			panic("Failed waiting for low power state\n");
>> +
>> +		if ((readl(ddrss->ddrss_ctl_cfg + K3_DDRSS_CFG_DENALI_CTL_169) &
>> +		     K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK) =3D=3D
>> +		    0x40 << K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_SHIFT)
>> +			break;
>
> As i see, wait for bit function can wait on mask also, can we use wait=20
> on the bit transition with timeout in this case?

If I see it correctly wait_for_bit_32 accepts a mask but can only check
if the full mask is set or not. In the example above we would need
separate arguments for mask and expected value, e.g.
K3_DDRSS_CFG_DENALI_CTL_169_LP_STATE_MASK as mask and 0x40 shifted as
the expected value.

>> +	}
>> +}
>> +
>> +static void k3_ddrss_deassert_retention(struct k3_ddrss_desc *ddrss)
>> +{
>> +	int ret;
>> +
>> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
>> +				 0x0,
>> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD |
>> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RETENTION_MASK,
>> +				 0);
>> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
>> +				 0x0,
>> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
>> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD);
>> +
>> +	ret =3D wait_for_bit_32((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
>> +			      K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
>> +			      true, 5000, false);
>> +	if (ret)
>> +		panic("Failed waiting for latching of retention %d\n", ret);
>> +
>> +	k3_ddrss_reg_update_bits((void *)K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL,
>> +				 0x0,
>> +				 K3_WKUP_CTRL_MMR0_DDR16SS_PMCTRL_DATA_RET_LD,
>> +				 0);
>> +}
>> +
>> +static bool k3_ddrss_wkup_conf_canuart_wakeup_active(struct k3_ddrss_de=
sc *ddrss)
>> +{
>> +	u32 active;
>> +
>> +	active =3D readl(ddrss->ddrss_ctrl_mmr + K3_WKUP_CTRL_MMR_CANUART_WAKE=
_STAT1);
>
> As seen in=20
> https://elixir.bootlin.com/u-boot/v2025.07-rc5/source/arch/arm/dts/k3-am6=
2a-ddr.dtsi#L10=20
> - the address range for CTRL MMR is starting from 0x43014000 and has a=20
> size of 0x100 but the address we want to access is outside that range.=20
> (0x43018318)
> We need to increase the address range in this node in dt file as well.

Thanks for pointing this out. I am trying to push for a syscon node
upstream without success yet. The CTRL_MMR register definition is
overlapping with the wkup_conf device node in the upstream dts
k3-am62a-wakeup.dtsi, so I chose to didn't increase the size.

Best
Markus

--1ec1c947af5f0c00cd54054de5f869e7620c6b98ed15cb72325b102ada23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaJtA4BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN7
BwEAlnvQZNJ3yqqNiaC1p4xd46RYNlBwDOujFy5SPECIjMYBAPw+/fW60h6U9Fpc
sAlk30QYiig5xmCuwD+/rbhJjj4G
=W5Y+
-----END PGP SIGNATURE-----

--1ec1c947af5f0c00cd54054de5f869e7620c6b98ed15cb72325b102ada23--
