Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0267CCD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 20:05:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 917D484869;
	Tue, 19 May 2026 22:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D21E84928; Tue, 19 May 2026 18:32:45 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E41884936
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux@timmermann.space
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gKgFR0Lp6z9vN7;
 Tue, 19 May 2026 18:32:43 +0200 (CEST)
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of linux@timmermann.space designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=linux@timmermann.space
Date: Tue, 19 May 2026 18:32:34 +0200
From: Lukas Timmermann <linux@timmermann.space>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>, Minkyu Kang <mk7.kang@samsung.com>
Subject: Re: [PATCH RFC v3 0/2] Modern pinctrl for Exynos5250 devices
Message-ID: <agyIf6anB0ZMRd3y@archstation>
References: <20260506-pinctrl-exyno5250-v3-0-11649fe82210@timmermann.space>
 <b55bd93a-d117-411d-8cb2-3c5f7c8d64c2@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b55bd93a-d117-411d-8cb2-3c5f7c8d64c2@cherry.de>
X-Rspamd-Queue-Id: 4gKgFR0Lp6z9vN7
X-Mailman-Approved-At: Tue, 19 May 2026 22:05:20 +0200
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

On Wed, May 06, 2026 at 03:14:11PM +0200, Quentin Schulz wrote:
> Hi Lukas,
> 
> On 5/6/26 1:13 AM, Lukas Timmermann wrote:
> > This patch series adds the necessary files to use a modern pinctrl driver
> > with an exynos5250 SoC. The changes are well tested and are working.
> > 
> > In contrast to v1, this reenables GPIO functionality. But as I'm still
> > lacking experience, I'm not quite sure on how to prevent s5p_gpio to
> > load when using upstream DTS in a clean way. Because of that, this
> > patch series is marked as an RFC.
> > checkpatch complains about using #ifdef.
> > 
> 
> We already have an issue with samsung,exynos78x0-gpio so we'd need a similar
> work-around for that one.
> 
> An easy way to sort this out would be to know if we know of devices which
> are still using the old binding? Qualcomm is rather special, is Samsung
> Exynos also special with regard to how it handles Device Trees? Do we get it
> from an earlier boot stage or is everything coming from U-Boot itself? If
> the latter, we can always migrate the existing devices to the new binding
> and remove support for the old binding and with it the same compatible in
> two drivers. Another question would be, does it make sense for both drivers
> to be compiled? If not (e.g. it's only pinctrl IPs inside an SoC and there's
> only one pinctrl device per SoC, so if your device supports the new binding,
> you only need the new driver). Then we can add a
> depends on !PINCTRL_EXYNOS5250
> for CONFIG_S5P (we probably should have a different symbol for the GPIO
> driver though, maybe CONFIG_GPIO_S5P?).
> 
> Cheers,
> Quentin

I'm sorry. Some of these Infos should've been in my original message:

This driver replaces the pinctrl functionality in the old s5p_gpio
driver. It doesn't replace GPIO functionality itself. So both drivers
have to be compiled in order to work with modern upstream DTs. This
driver binds the older s5p_gpio driver during its own binding.

The pinctrl dt-bindings are incompatible to each other. This driver fixes
pinctrl with upstream DTs and the older one must be used on it's own
when relying on U-Boots deprecated DTs.

DTs are provided by U-Boot itself, at least that's the case on my device
(exynos5250-manta).

If I understood you correctly, we could modify the deprecated exynos5250.dtsi 
to fix this situation. But I don't know about possible side effects
and I'm not that experienced in kernel/bootloader development. Is this an option?

I had split the gpio symbol into it's own thing before and could add that
back into v4 but it's functionally the same. (Both drivers needed for
upstream DT)

Best regards,
Lukas
