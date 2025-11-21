Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB79BCFC281
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 20:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FC3839A8;
	Fri, 21 Nov 2025 21:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CNHzKVic";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2524483A5A; Fri, 21 Nov 2025 21:51:15 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A26B8394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 21:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dCnSH0VXxz9tgp;
 Fri, 21 Nov 2025 21:51:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763758271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NbfbZoGFaC5KEWbMtttxrF9ZipfL+NfjBY/0Q7HPSc=;
 b=CNHzKVic0/hkW3qqwh38q3fp7oU4BVAQU0YZIdh3MEv5wL1AAB8B9rnoycyQlA8oA1LUBh
 ioCa6G4n5UtafDQvsoMTzKDMSnPEu6gnEz+NeLUYjphwVQZTrIlXPHCu+p8r6yZPNs//wI
 avbr2GV8U6GkIEkZnH5Sbs8ORD/fHwVCicsGWLGMUN/oa6pHCtahO9MFz4mMH1vefL7mdX
 mWx2NW/IWh/XbCXKrNMbyuHqxJcXEPktvy2YTbeJBPmrVmLvoK3exaMs7vUajcUs5E+9/W
 AWXONqxNathQecBiAfTJ/QZIjC8nWUfeDn+da2gPFMzLh9VEbwlrfj7v6A/UEg==
Message-ID: <18e034ad-8904-499b-a07f-034a5c01bc0b@mailbox.org>
Date: Fri, 21 Nov 2025 21:51:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
To: Markus Schneider-Pargmann <msp@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
 <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
 <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
 <423d52bd-2446-47de-b6bc-4ee61fd0c23e@mailbox.org>
 <DEEMMP7ISZ9P.BP6XAE07Y26S@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DEEMMP7ISZ9P.BP6XAE07Y26S@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ocqdw3u5az1jjwweijj5x6grdu5tqwzu
X-MBO-RS-ID: 7bb4ed908ef7704cd18
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

On 11/21/25 8:40 PM, Markus Schneider-Pargmann wrote:

Hello Markus,

> I rechecked the compatible lists, but they do not have two different
> matching compatibles, mostly just one matches to a driver.
> 
> But I think I may know why there was no issue with this. Grepping the
> config symbols it seems there is no config in which both drivers are
> actually enabled at the same time:
> 
>    configs/renesas_rcar64.config:CONFIG_RENESAS_RPC_SPI=y
>    configs/renesas_rza1.config:CONFIG_RENESAS_RPC_SPI=y
> 
>    configs/r8a77990_ebisu_defconfig:CONFIG_RENESAS_RPC_HF=y
>    configs/r8a77995_draak_defconfig:CONFIG_RENESAS_RPC_HF=y
>    configs/rcar3_salvator-x_defconfig:CONFIG_RENESAS_RPC_HF=y
>    configs/rcar3_ulcb_defconfig:CONFIG_RENESAS_RPC_HF=y
These ^ configs include renesas_rcar64.config , see this:

$  make rcar3_ulcb_defconfig ; grep RENESAS_RPC .config
...
CONFIG_RENESAS_RPC_HF=y
CONFIG_RENESAS_RPC_SPI=y

