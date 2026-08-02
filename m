Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19241C55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 04:35:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E894E60635;
	Sun,  2 Aug 2026 04:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UhbEMh6uHgUO; Sun,  2 Aug 2026 04:35:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4654B60675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785645327;
	bh=l7Mo5ER+cf0XGLsPOVmz9xCt/GjswD8CPp6vbN5Yhn8=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=d7ESHIA1uEszFsXXLCAmuabQ1NIB7swIr7aWfH8REZHEIjW5O8nCnn1gcUYAJNe0a
	 IbshuDFMyhF3c4MyjHVSnXZurA3cOW702Gv7OV4Z2vGfjVJP3etyxyhoEd1hy54TVt
	 LJrR7a4qpyWL2ih0Yy4DMasSvWcKV3BoHhOHZD2JkofnA87nBsAohUEN+1jy12GgHN
	 yy3HxkoETg14HUvH5PsV9dQsH5Tuox1KJNWt3k8r59D3fBAZY1VNHsixDom3UcH0ln
	 omhHx4Up5dgQLos5uanIt26rOz0FoNR62OoJO7LROqzkBh/DWBfyRAc2sl6Srn2fDR
	 OmqaYQK9RlUzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4654B60675;
	Sun,  2 Aug 2026 04:35:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BBABFE3
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61D20403A1
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:36:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mwtp0s7xXCH8 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 03:36:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3FDB84033D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3FDB84033D
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FDB84033D
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:36:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCQSc73HSz8txY;
 Sun, 02 Aug 2026 05:36:00 +0200 (CEST)
Message-ID: <c1f95e20-d00b-4ef4-9371-31a025a848aa@mailbox.org>
Date: Sun, 2 Aug 2026 05:34:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 04/17] gpio: dwapb_gpio: Enable all clocks
To: Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, Stanley Chu
 <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>,
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar
 <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-4-af2ce80db9d8@linaro.org>
Content-Language: en-US
In-Reply-To: <20260731-rzn1-2026-07-v1-4-af2ce80db9d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b5505d5f35fa22e47f4
X-MBO-RS-META: 5ju6czeh98h9um4hk3xfrf7d5ewwazez
X-Mailman-Approved-At: Sun, 02 Aug 2026 04:35:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7Mo5ER+cf0XGLsPOVmz9xCt/GjswD8CPp6vbN5Yhn8=;
 b=CHDliTyqW1Fgq2nriIQrgZrGdtAKI2mBUf+KMpb3opl1xh/xwRUzBX5/sqnt1uXvwnj2Ds
 K5APvVcwtMwpd2ti8F6LouG6M6CNkToBy9G2xswY392kFXt/jxCQdl1/8ng02k2Blei6l0
 KyRyEIXZe4qTGP+NofNUnFPXAtY3u1ZxsRKwcQg9HPZh0IU7GsTinTVp6yZU6t54a8MKSJ
 4FwKw6nCOBpIZXHpWnnQk1mePzQQbeOeJMJvqE5DddmKgsanKoNssZ9f0rlUBwOUm62Tas
 yKRogSfDNcUlfD5ouayIMT6d6gJ0kQcJfMIsiW4qOxfZvCbqabDeakbFJ4No7g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7Mo5ER+cf0XGLsPOVmz9xCt/GjswD8CPp6vbN5Yhn8=;
 b=HrZTJbWSaaSyki98tiq/G9SKWLcm5Oenr6jLCCB8cRfiVUwD7plP5VsQtWo9FvC3jYvJ3X
 k5p1oMTTmhAWyuP3AeA75O0jDD3kR5qhnOgDhsTrdi8idUtnPy91QJde0aMpf90VRIdyMo
 YccjTwIc3UEEYCjm2XtcO6FACHdPWxFrVwI3SjdzhmtDZcPLNz9MGsG5MFcWAAggLR/rVl
 tN5bAv+mp0s9JhvS3xZXlXrG/87HWhG8cUobYjZK5YYZLPcAd942d3U3C4DNwIghd2/tlA
 p7bgmKiqv4H/e2RMiLgU8mmc5Im3I0KntHkYEQ8Wjxk9dm2+5rskEBaSFVqOkg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=CHDliTyq; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HrZTJbWS
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/31/26 6:33 PM, Ralph Siemsen wrote:
> On some SoC (such as RZ/N1) it is necessary to enable clocks prior to
> using the register interface.
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   drivers/gpio/dwapb_gpio.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/dwapb_gpio.c b/drivers/gpio/dwapb_gpio.c
> index 7ab48780332..6fa50a2c2af 100644
> --- a/drivers/gpio/dwapb_gpio.c
> +++ b/drivers/gpio/dwapb_gpio.c
> @@ -7,6 +7,7 @@
>   
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> +#include <clk.h>
>   #include <dm/device.h>
>   #include <dm/device-internal.h>
>   #include <dm/device_compat.h>
> @@ -28,6 +29,7 @@
>   
>   struct gpio_dwapb_priv {
>   	struct reset_ctl_bulk	resets;
> +	struct clk_bulk		clks;
>   };
>   
>   struct gpio_dwapb_plat {
> @@ -136,8 +138,13 @@ static int gpio_dwapb_probe(struct udevice *dev)
>   {
>   	struct gpio_dev_priv *priv = dev_get_uclass_priv(dev);
>   	struct gpio_dwapb_plat *plat = dev_get_plat(dev);
> +	struct gpio_dwapb_priv *dw_priv = dev_get_priv(dev);
>   
>   	if (!plat) {
> +		/* Enable clocks on parent device only */
> +		if (clk_get_bulk(dev, &dw_priv->clks) == 0)

You do need to handle return value here.
