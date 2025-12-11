Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE14D41C09
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A963D83BFE;
	Thu, 11 Dec 2025 11:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRTnVBDh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF67B83CB5; Thu, 11 Dec 2025 09:26:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA2B83C7B
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 73D7E6014F;
 Thu, 11 Dec 2025 08:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943D2C4CEFB;
 Thu, 11 Dec 2025 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765441564;
 bh=+AKuawoORDAdxRucoqgyXV5vzew837ORs2SvcJ5P7Jo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RRTnVBDhgS9q2OIHx2HY50vymRCePPIrZGKH55jZkjUcI8otJBS6IVsN7Gr7nX2Va
 fR0BF63Eup5fWIWQi2s2FVpIgbkc+kBAmFgsRqDgVScL0aRUBdF/l0WA4teOBsHjlk
 yjVGX5bQDbyagxyWzt/hHkSsitKWMeO0RsO3oZ+psA3bAhaxZGDJhaQCI3V7qnDd+i
 sclijVodhdvkdouDLoXObqOf5jp2vjtCxwSF66uq6NQ/qZBm5oEJVWWxnsHd5MBpzi
 xfBu+3IEAhYoF+QtkzVVQglUsD+8XJ17nNg8uS87sHacTTegTql5iKlX822rp5z6D3
 W4HOaFBn2f3FA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun
 <chunfeng.yun@mediatek.com>, Igor Belwon
 <igor.belwon@mentallysanemainliners.org>, Stefan Roese
 <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, Vasileios
 Bimpikas <vasileios.bimpikas@analog.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Sumit Garg <sumit.garg@kernel.org>,
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sam Shih <sam.shih@mediatek.com>, David
 Lechner <dlechner@baylibre.com>, Ian Roberts <ian.roberts@timesys.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Schocher
 <hs@nabladev.com>, Duje =?utf-8?Q?Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH v2 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
In-Reply-To: <20251209-add-mt8188-support-v2-1-31dbfcf7303c@baylibre.com>
References: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
 <20251209-add-mt8188-support-v2-1-31dbfcf7303c@baylibre.com>
Date: Thu, 11 Dec 2025 09:26:01 +0100
Message-ID: <87bjk55srq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

Hi Julien,

Thank you for the patch.

On Tue, Dec 09, 2025 at 11:22, Julien Stephan <jstephan@baylibre.com> wrote:

> From: Julien Masson <jmasson@baylibre.com>
>
> This adds basic support for MediaTek MT8188 SoC.
>
> Add watchdog support by adding upstream compatible string.
>
> Add tphy support by adding "mediatek,generic-tphy-v2" compatible string
> in arch/arm/dts/mt8188-u-boot.dtsi
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
