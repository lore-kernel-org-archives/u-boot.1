Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C163EC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC2C87EEE;
	Tue,  9 Jul 2024 11:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dhPgC7FU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306C687F5C; Tue,  9 Jul 2024 11:33:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C36BC87EBD
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-426602e8050so19422915e9.2
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720517592; x=1721122392;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fkOcvZMsaPuGJ05gZQblSrQrkYx2+JsCD16MX/l2fQY=;
 b=dhPgC7FUV70wXPew/DN1mjdAag/9TRGlIKb6EypYCmad02V0t7WV8qhqfHuDBy3oRq
 sxzwcViWrseW2oPxJ+uFELk7YEIXJfkJ0+/EmyoAUSScjhLwfn/H4ezT8hhquPtMlxdL
 gVtRvrAI/+cQQiYjPFyoc9N8UEpS7zJbbRsjyJBVzwPWZx5Fifec7mgtCaHB6jjP16qv
 LYGUMf3i/DoxP43c33SDp4k7aVmKsmTsLEOWEwIhUXb/zgtUYvctKnT9GKlgI4Lt/ra+
 8t/+PcNYcMcaKExx/fjCe6+l05cnXNnZ3f81QV5nKWPhdSvq+qB13WAkzwl8TN1+bEyO
 tq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517592; x=1721122392;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkOcvZMsaPuGJ05gZQblSrQrkYx2+JsCD16MX/l2fQY=;
 b=Kg3/z1Vdd3QlikLVff+3vXDhPnHVdr2x/NjVGE5KapiOu2ZeleSc0CdqORY2fiqEpx
 BvTCTpKqPCRCQyFdSt50irfZPX43mLWV+1zitPnw82jczHSLTSwNCIdPCKkHuRtg8ROJ
 Z/6IpG0O6oSVMyU+dI1mrUIsiqpWmb3TmwryQ0EiWWeuxg+WnSGaVhMPgkZSJzR36QnS
 czZxaE5o/7XXWx8+JSIeTe+0gZ48gh7mgLPLHR3UKUtg0ei+JTy9PtrTjzFCDHW1j3sK
 Q1GyBQh/spNBPB0cNlS9nr2xiAgeL3CDpzN0GAQZHjLKgRVb8YLKJtIoun43JMCWbqet
 CuxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJbaH/S2ufzAqzNWRr6Xua8mKlhCVzz+mkCpmsOjPfkA3T8uLfLignlMr19Pq/MvUCZQXC7d+mnpeFSkfB6IO9bZvxZw==
X-Gm-Message-State: AOJu0YzKFlmJ2DjFUez5b1LX5/SUG85jQuiqi/kRAjP3wlKy+Dy/O8C7
 6elHUCTLcKod1Nn+brtm1Ytuu9XR8fNYEnHMwCywUSZ0IKYX+cwqlsVecGyHSI0=
X-Google-Smtp-Source: AGHT+IHAs4jORzKOyb0OsU90YHmJY0heFzV30ooLeiuG4tQQnpaiPLDx+X3DxrgHBC1MoHOml3hflg==
X-Received: by 2002:a05:600c:2247:b0:426:5dc8:6a6a with SMTP id
 5b1f17b1804b1-426707d7fd6mr13616365e9.21.1720517591994; 
 Tue, 09 Jul 2024 02:33:11 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266857c28esm84767895e9.2.2024.07.09.02.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:33:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Fabio Estevam <festevam@gmail.com>, Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>, Jonas Karlman <jonas@kwiboo.se>,
 Mathieu Othacehe <othacehe@gnu.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, Xavier Drudis
 Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 3/3] phy: test: Implement sandbox PHY .set_mode and
 DM test
In-Reply-To: <20240617173740.80822-3-marek.vasut+renesas@mailbox.org>
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
 <20240617173740.80822-3-marek.vasut+renesas@mailbox.org>
Date: Tue, 09 Jul 2024 11:33:09 +0200
Message-ID: <87msmqj4fe.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.

On lun., juin 17, 2024 at 19:36, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Implement trivial extension to the sandbox PHY, which makes it pretend
> to support selecting USB Host mode and nothing else. Any other mode is
> rejected with -EINVAL. Any submode except for default submode 0 is
> rejected with -EOPNOTSUPP . The implementation behaves in this trivial
> way to permit easy unit testing using test which is also added in this
> commit.
>
> To run the test, use e.g. sandbox64_defconfig and run U-Boot as follows:
> $ ./u-boot -Tc 'ut dm phy_setup'
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
> V2: New patch
> ---
>  drivers/phy/sandbox-phy.c | 13 +++++++++++++
>  test/dm/phy.c             |  7 +++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/phy/sandbox-phy.c b/drivers/phy/sandbox-phy.c
> index b159147a765..e70d20432e0 100644
> --- a/drivers/phy/sandbox-phy.c
> +++ b/drivers/phy/sandbox-phy.c
> @@ -72,6 +72,18 @@ static int sandbox_phy_exit(struct phy *phy)
>  	return 0;
>  }
>  
> +static int
> +sandbox_phy_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	if (submode)
> +		return -EOPNOTSUPP;
> +
> +	if (mode != PHY_MODE_USB_HOST)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static int sandbox_phy_bind(struct udevice *dev)
>  {
>  	if (dev_get_driver_data(dev) != DRIVER_DATA)
> @@ -96,6 +108,7 @@ static struct phy_ops sandbox_phy_ops = {
>  	.power_off = sandbox_phy_power_off,
>  	.init = sandbox_phy_init,
>  	.exit = sandbox_phy_exit,
> +	.set_mode = sandbox_phy_set_mode,
>  };
>  
>  static const struct udevice_id sandbox_phy_ids[] = {
> diff --git a/test/dm/phy.c b/test/dm/phy.c
> index a90881b12ab..a93aa83ab10 100644
> --- a/test/dm/phy.c
> +++ b/test/dm/phy.c
> @@ -246,6 +246,13 @@ static int dm_test_phy_setup(struct unit_test_state *uts)
>  	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
>  	ut_assertok(generic_shutdown_phy(&phy));
>  
> +	/* set_mode as USB Host passes, anything else is not supported */
> +	ut_assertok(generic_setup_phy(parent, &phy, 0, PHY_MODE_USB_HOST, 0));
> +	ut_assertok(generic_phy_set_mode(&phy, PHY_MODE_USB_HOST, 0));
> +	ut_asserteq(-EOPNOTSUPP, generic_phy_set_mode(&phy, PHY_MODE_USB_HOST, 1));
> +	ut_asserteq(-EINVAL, generic_phy_set_mode(&phy, PHY_MODE_USB_DEVICE, 0));
> +	ut_assertok(generic_shutdown_phy(&phy));
> +
>  	/* power_off fail with -EIO */
>  	ut_assertok(generic_setup_phy(parent, &phy, 1, PHY_MODE_USB_HOST, 0));
>  	ut_asserteq(-EIO, generic_shutdown_phy(&phy));
> -- 
> 2.43.0
