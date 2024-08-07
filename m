Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63748C52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE04588D4B;
	Wed,  7 Aug 2024 16:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=permerror (0-bit key) header.d=ltec.ch header.i=@ltec.ch header.b="/naPOdq1";
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ltec.ch header.i=@ltec.ch header.b="aa57FyhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D0588CEE; Wed,  7 Aug 2024 15:59:05 +0200 (CEST)
Received: from mail.ltec.ch (mail.ltec.ch [95.143.48.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397C688BB5
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 15:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=fb@ltec.ch
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed; d=ltec.ch
 ; s=ec-sel;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RGbqiFEPoXafORu6aEvhSVWU6ZTdmF9kH4fberXM/0=; b=/naPOdq1lJWbKaL0MUwwAwm6W2
 JSOqdIU+mONX82ubwlVqeU1nWQG3eRV7yQHxXOXCuhd3iAKJxUiiPfXQE2BQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ltec.ch;
 s=rsa-sel; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7RGbqiFEPoXafORu6aEvhSVWU6ZTdmF9kH4fberXM/0=; b=aa57FyhRQiU/Tl4i8IgWhQh5A1
 7cCBMbM//HKdCLDehX2SgpF2tUBA5OBecGTyXuj0qV/+MD6gG+l5aoUB+IMqW0b8tSBToL6vwEzRe
 a9Ti+Tn1f6D295cUM5NkEyRXZ1mTRIGjutw0PWQC2JrFgh9KtKccc6atKnAOlEkILEFIgtdKHTIxC
 weICGou403XEII1NpdWQdqd3zn06VrZFB7yLKpJtF+eodLJmlnIWxWS0bIoLXBQVjAH9EC6Gd7MIh
 3C5srNgV7Tt43xw2ukt5bQWwMlaPaXgx3QcyKWpj3Z2febu8pN8GLLSHgShLzbwWaIMOk+KcsHu+G
 DfhtuF4Q==;
Received: from nebula.ltec ([172.27.11.2] helo=[172.27.11.24])
 by mail.ltec.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <fb@ltec.ch>)
 id 1sbhBZ-003sTe-8Y; Wed, 07 Aug 2024 15:58:41 +0200
Message-ID: <5816ce27-2a8d-4981-afc6-dd7ebd01d72f@ltec.ch>
Date: Wed, 7 Aug 2024 15:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/20] configs: replace '# CONFIG_NET is not set' with
 CONFIG_NO_NET=y
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 Tom Rini <trini@konsulko.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, Wills Wang <wills.wang@live.com>,
 Rosy Song <rosysong@rosinson.com>, Mark Kettenis <kettenis@openbsd.org>,
 Wolfgang Wegner <w.wegner@astro-kom.de>, Stelian Pop <stelian@popies.net>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Trevor Woerner <twoerner@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Alexey Brodkin <abrodkin@synopsys.com>,
 Andy Yan <andy.yan@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <firbidden405@outlook.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 David Lechner <david@lechnology.com>, Johan Jonker <jbx6244@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Otavio Salvador
 <otavio@ossystems.com.br>, Eric Nelson <eric@nelint.com>,
 Peng Fan <peng.fan@nxp.com>, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Tianrui Wei <tianrui-wei@outlook.com>,
 Minkyu Kang <mk7.kang@samsung.com>, lixinde <lixinde@phytium.com.cn>,
 weichangzheng <weichangzheng@phytium.com.cn>, Ilko Iliev <iliev@ronetix.at>,
 Stefan Bosch <stefan_b@posteo.net>, Jaehoon Chung <jh80.chung@samsung.com>,
 Greg Gallagher <greg@embeddedgreg.com>, Mihai Sain
 <mihai.sain@microchip.com>, Sean Anderson <seanga2@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Kamil Lulko <kamil.lulko@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Sergey Temerkhanov <s.temerkhanov@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>, Usama Arif <usama.arif@arm.com>,
 Anastasiia Lukianenko <anastasiia_lukianenko@epam.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Michal Simek <michal.simek@amd.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Andrew Davis <afd@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Neal Gompa <neal@gompa.dev>,
 Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
 Bin Meng <bmeng.cn@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Pegorer Massimo <Massimo.Pegorer@vimar.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, TracyMg_Li <TracyMg_Li@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Andrii Chepurnyi <Andrii_Chepurnyi@epam.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <909b133b5ab321b19f988e904f07f6288ba12117.1721910373.git.jerome.forissier@linaro.org>
From: Felix Brack <fb@ltec.ch>
Content-Language: en-US
In-Reply-To: <909b133b5ab321b19f988e904f07f6288ba12117.1721910373.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 07 Aug 2024 16:37:37 +0200
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

On 25.07.24 14:57, Jerome Forissier wrote:

> The parent patch has made the networking stack a choice between NO_NET,
> NET and NET_LWIP. Therefore '# CONFIG_NET is not set' is now
> 'CONFIG_NO_NET=y'. Adjust the defconfigs accordingly. Note that this
> patch is intended to be folded in but is kept separate separate for now
> to make review easier.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

For the pdu001 board.

Tested-by: Felix Brack <fb@ltec.ch>
