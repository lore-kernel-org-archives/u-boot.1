Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8225CE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 15:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C3986C37;
	Mon, 25 Sep 2023 17:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F8386D44; Mon, 25 Sep 2023 16:56:13 +0200 (CEST)
Received: from mail.ltec.ch (mail.ltec.ch [95.143.48.181])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D276486B36
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 16:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=fb@ltec.ch
Received: from nebula.ltec ([172.27.11.2] helo=[172.27.11.35])
 by mail.ltec.ch with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <fb@ltec.ch>)
 id 1qkn04-00CsDy-91; Mon, 25 Sep 2023 16:55:52 +0200
Message-ID: <2a727cd4-bbda-409e-8d0e-1aafba182873@ltec.ch>
Date: Mon, 25 Sep 2023 16:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/38] spl: Use CONFIG_SPL... instead of
 CONFIG_..._SPL_...
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Adam Ford <aford173@gmail.com>,
 Alison Wang <alison.wang@nxp.com>, Allen Martin <amartin@nvidia.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>, Chin-Liang See <clsee@altera.com>,
 Dave Gerlach <d-gerlach@ti.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Fabio Estevam <festevam@denx.de>, Green Wan <green.wan@sifive.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 =?UTF-8?Q?Javier_Mart=C3=ADnez_Canillas?= <javier@dowhile0.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Peter.Chubb@data61.csiro.au,
 Philip Oberfichtner <pro@denx.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Raffaele RECALCATI <raffaele.recalcati@bticino.it>,
 Roger Quadros <rogerq@kernel.org>, Stefan Roese <sr@denx.de>,
 Teresa Remmet <t.remmet@phytec.de>, Tianrui Wei <tianrui-wei@outlook.com>,
 Tim Harvey <tharvey@gateworks.com>,
 Uri Mashiach <uri.mashiach@compulab.co.il>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, kernel@puri.sm,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20230924192536.1812799-1-sjg@chromium.org>
 <20230924192536.1812799-2-sjg@chromium.org>
From: Felix Brack <fb@ltec.ch>
In-Reply-To: <20230924192536.1812799-2-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 25 Sep 2023 17:01:15 +0200
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

Hi Simon,

On 24.09.23 21:24, Simon Glass wrote:
> We like to put the SPL first so it is clear that it relates to SPL. Rename
> various malloc-related options which have crept in, to stick to this
> convention.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Martyn Welch <martyn.welch@collabora.com>
> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
> 
> (no changes since v1)
> .....

I just tried to apply the patch to master for testing and got the
following result:

error: patch failed: configs/am335x_baltos_defconfig:18
error: configs/am335x_baltos_defconfig: patch does not apply
error: patch failed: configs/am335x_igep003x_defconfig:20
error: configs/am335x_igep003x_defconfig: patch does not apply
error: patch failed: configs/dh_imx6_defconfig:39
error: configs/dh_imx6_defconfig: patch does not apply
error: patch failed: configs/starfive_visionfive2_defconfig:47
error: configs/starfive_visionfive2_defconfig: patch does not apply

For what I want to test (changes for PDU001 board) this doesn't matter
however. I'm just not sure: should I go ahead with testing or wait for
an updated patch?

regards Felix
