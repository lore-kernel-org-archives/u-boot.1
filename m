Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F99AC10F16
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 12:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D3EE88BD9;
	Fri,  3 May 2024 14:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 454F1882FE; Fri,  3 May 2024 07:47:53 +0200 (CEST)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F28288348
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 07:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=qmem=MG=kaod.org=clg@ozlabs.org
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VW0FY3vl8z4wyq;
 Fri,  3 May 2024 15:47:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VW0FB315tz4wcn;
 Fri,  3 May 2024 15:47:25 +1000 (AEST)
Message-ID: <edc231c1-5b7e-4869-a31c-b6aa3f7cc904@kaod.org>
Date: Fri, 3 May 2024 07:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/81] spi: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Robert Marko <robert.marko@sartura.hr>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov
 <luka.perkov@sartura.hr>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-65-trini@konsulko.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240502013138.2383421-65-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 May 2024 14:36:07 +0200
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

On 5/2/24 03:31, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Anand Gore <anand.gore@broadcom.com>
> Cc: William Zhang <william.zhang@broadcom.com>
> Cc: Kursad Oney <kursad.oney@broadcom.com>
> Cc: Joel Peshkin <joel.peshkin@broadcom.com>
> Cc: Philippe Reynes <philippe.reynes@softathome.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>

For spi-aspeed-smc.c,


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.




