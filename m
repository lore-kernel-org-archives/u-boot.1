Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528EC7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 09:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C9E82E08;
	Wed,  2 Jul 2025 11:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiGpg1Q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3341C82E08; Wed,  2 Jul 2025 10:53:51 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCEE8206E;
 Wed,  2 Jul 2025 10:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rmfrfs@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so3920149f8f.3; 
 Wed, 02 Jul 2025 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751446429; x=1752051229; darn=lists.denx.de;
 h=in-reply-to:references:to:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQGhItBOFPV8tKhxDaZicvbqx4OWkNSB5RNSRL1rW5o=;
 b=FiGpg1Q44EQYbklptg+cYSdNSN4RxZ2tHXL2Y7PSeyY+fOu9VFXlysRJkXvwevPI9G
 xFr91n2rYtGnxNHZqUsgvJU62AwdIRw3JE/f85mPGHLcs8Vo1kegt5ILFufFXo4lJEen
 yxtOaGeYlB0qO1f+Yz67KqFKGK8SXy+GTiKypDe4TexCZqzf5A6aIl1aQNUXeBbN4QeO
 NKSJaAiAoYpHF48zjqgLTfA0w1zvE+lQsqHNy0XyFYFPVpwR0Qvu1KFaeNNx9xvMDtjd
 JrR1gA9hACMS/TJvmUZsezxjJQAFGxwkiL56/qHeMekA6eMD5M5FquM7cpH24tXIfA8B
 iITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751446429; x=1752051229;
 h=in-reply-to:references:to:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IQGhItBOFPV8tKhxDaZicvbqx4OWkNSB5RNSRL1rW5o=;
 b=lRpeH/zj+SGMBgI1qctb+Eq2AdW2q7JGKTiNmcPomC8D2g8fKvsYsZI3l6uws040zq
 nMGo4DkVAa5PeKy5bBCLc6YOaBGaatW9mNgZXg9grYYOTNrDgyovlNK53dRp9ImUDGpb
 j7YciyYJ254xYtxC10hhbbb9rW9kHVgch7VGbb4k3Io9AmGHB8BitvoK00OQASA9TWKJ
 a+PomDCj14EhP/8Ln6/rmiy0lt9BBsg99ZCa4/brR5W/+BsaRDBu/h8NgA27rvuyIem5
 Z0gqGmVEQnrYgmci6CFpHH3PAKDqi5f/RuFNp+YSvEYvPWmk7O2i/TvyIx7Q0MTbIgnl
 k4rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/cCn3Zwf7Jvmd4e9HQU3vN52W5yWoEW/QGNJbE1k4OqYhN/idt3B61MQQu3+GenV0uMF572qF+LkdnHkSMA==@lists.denx.de
X-Gm-Message-State: AOJu0Yy+JnESWb6uEZ6PHzCRnzT+z1FXaxyOQhjPPsVwkKW2Ie1sSG/+
 PD5tPQ/RF1yo8MWPZNSBUse9doBEGdYkKmlRMCZC2HmvSbOPYOq6QG2Kw3+azEAQ
X-Gm-Gg: ASbGnctc4Raf+COI4AlQdfcwFlWrT3h/ATF0cizELe2Oez4939Kuio8GnuaPWNSVyE1
 C5eFd6gRUCkQO8g1FV1ZbtZ4TKQzJ1MDEj6IPw+k8gBj4Yf63VhjfKaT/cSMbSlsDznX+hfbq5E
 /+sgDuDr3kMN5znJC/E7fJkUxfbBNXf4DWEAYXD0fx3S+KG7/wY9xhF/ukxSmJWNvKj9CCOxmD2
 OPEjbJ8YccJstmkiXqsFW8pNJrIEk+L4rgw5wskLi5zcxrpIUm2DeuxIdbp33ZLKecsHYNw9w2/
 y5DW3wEIcE6QC8dhm4+B4ga/D8fJzdFzQRA9r0++c8LVVlbwBwUjVEx0BDKNR/Uu0fEcMfRQq/Y
 bAwH1aMzuHFHwwQ==
X-Google-Smtp-Source: AGHT+IHQIQIjLHRqK62veZu9IfUq37Bg9/eZh2AJTDcEBJkazkwdS8xZEVlqzt/q+zCU1qgqfoSR0g==
X-Received: by 2002:a05:6000:1449:b0:3a4:f379:65b6 with SMTP id
 ffacd0b85a97d-3b200f2168emr1484979f8f.46.1751446428525; 
 Wed, 02 Jul 2025 01:53:48 -0700 (PDT)
Received: from localhost (a95-94-245-170.cpe.netcabo.pt. [95.94.245.170])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3a88c80b50bsm15303769f8f.42.2025.07.02.01.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 01:53:48 -0700 (PDT)
From: Rui Miguel Silva <rmfrfs@gmail.com>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Jul 2025 09:53:47 +0100
Message-Id: <DB1FXX03SS1X.3D705QLL4ES1X@linaro.com>
Cc: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>, "U-Boot"
 <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH v2 2/2] gpio: qcom: move pm8550 gpio to new driver
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Tom Rini"
 <trini@konsulko.com>, "Sumit Garg" <sumit.garg@kernel.org>, "Casey
 Connolly" <casey.connolly@linaro.org>
References: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
 <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-2-cc1512931197@linaro.org>
In-Reply-To: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-2-cc1512931197@linaro.org>
X-Mailman-Approved-At: Wed, 02 Jul 2025 11:12:13 +0200
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

Hey Neil,
On Mon Jun 30, 2025 at 5:04 PM WEST, Neil Armstrong wrote:

> Move support of the pm8550 gpios to the newly introduced
> driver and drop the compatible entry and the read-only quirk
> at the same time from the old driver.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

LGTM,
Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
   Rui

> ---
>  drivers/gpio/qcom_pmic_gpio.c | 20 +-------------------
>  drivers/gpio/qcom_spmi_gpio.c |  1 +
>  2 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.=
c
> index cd9f3926ac41d84161b1e5311d9a99bb0b4a68ff..4458c55cd3da4d279b360b701=
348b50247036198 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -69,17 +69,6 @@
>  #define REG_EN_CTL             0x46
>  #define REG_EN_CTL_ENABLE      (1 << 7)
> =20
> -/**
> - * pmic_gpio_match_data - platform specific configuration
> - *
> - * @PMIC_MATCH_READONLY: treat all GPIOs as readonly, don't attempt to c=
onfigure them.
> - * This is a workaround for an unknown bug on some platforms where tryin=
g to write the
> - * GPIO configuration registers causes the board to hang.
> - */
> -enum pmic_gpio_quirks {
> -	QCOM_PMIC_QUIRK_READONLY =3D (1 << 0),
> -};
> -
>  struct qcom_pmic_gpio_data {
>  	uint32_t pid; /* Peripheral ID on SPMI bus */
>  	bool     lv_mv_type; /* If subtype is GPIO_LV(0x10) or GPIO_MV(0x11) */
> @@ -128,13 +117,8 @@ static int qcom_gpio_set_direction(struct udevice *d=
ev, unsigned int offset,
>  {
>  	struct qcom_pmic_gpio_data *plat =3D dev_get_plat(dev);
>  	uint32_t gpio_base =3D plat->pid + REG_OFFSET(offset);
> -	ulong quirks =3D dev_get_driver_data(dev);
>  	int ret =3D 0;
> =20
> -	/* Some PMICs don't like their GPIOs being configured */
> -	if (quirks & QCOM_PMIC_QUIRK_READONLY)
> -		return 0;
> -
>  	/* Disable the GPIO */
>  	ret =3D pmic_clrsetbits(dev->parent, gpio_base + REG_EN_CTL,
>  			      REG_EN_CTL_ENABLE, 0);
> @@ -278,7 +262,6 @@ static int qcom_gpio_bind(struct udevice *dev)
>  {
> =20
>  	struct qcom_pmic_gpio_data *plat =3D dev_get_plat(dev);
> -	ulong quirks =3D dev_get_driver_data(dev);
>  	struct udevice *child;
>  	struct driver *drv;
>  	int ret;
> @@ -292,7 +275,7 @@ static int qcom_gpio_bind(struct udevice *dev)
>  	/* Bind the GPIO driver as a child of the PMIC. */
>  	ret =3D device_bind_with_driver_data(dev, drv,
>  					   dev->name,
> -					   quirks, dev_ofnode(dev), &child);
> +					   0, dev_ofnode(dev), &child);
>  	if (ret)
>  		return log_msg_ret("bind", ret);
> =20
> @@ -365,7 +348,6 @@ static const struct udevice_id qcom_gpio_ids[] =3D {
>  	{ .compatible =3D "qcom,pms405-gpio" },
>  	{ .compatible =3D "qcom,pm6125-gpio" },
>  	{ .compatible =3D "qcom,pm8150-gpio" },
> -	{ .compatible =3D "qcom,pm8550-gpio", .data =3D QCOM_PMIC_QUIRK_READONL=
Y },
>  	{ }
>  };
> =20
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.=
c
> index 2bb0f0d10c32ff55d3fd5c61b9bc2999878bfea6..22c8072534e9188445f0aaef5=
336863fd1da7a75 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -743,6 +743,7 @@ static int qcom_spmi_pmic_gpio_probe(struct udevice *=
dev)
>  }
> =20
>  static const struct udevice_id qcom_spmi_pmic_gpio_ids[] =3D {
> +	{ .compatible =3D "qcom,pm8550-gpio" },
>  	{ .compatible =3D "qcom,pm8550b-gpio" },
>  	{ .compatible =3D "qcom,pm8550ve-gpio" },
>  	{ .compatible =3D "qcom,pm8550vs-gpio" },
>
> --=20
> 2.34.1



