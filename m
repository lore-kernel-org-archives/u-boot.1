Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F670CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9904B848EB;
	Thu,  4 Jun 2026 14:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="p20BvU86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05748486A; Thu,  4 Jun 2026 09:51:17 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69426844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 09:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2E79FC6344D;
 Thu,  4 Jun 2026 07:51:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0658D5FEF7;
 Thu,  4 Jun 2026 07:51:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 307BD106A17BD; 
 Thu,  4 Jun 2026 09:51:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780559473; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=mIa9EFXdk2LdzLrqi7FqOQS0SR7a8i7aPEyn8xufIxA=;
 b=p20BvU86YNncg6wdyR4YuamEn4AgUKx2qTymgUNWKZ9XH1vPA7DPX0E+K2r54RmZGiNrtd
 ci89oTCgo11d6adzgnilLpqbKg4067NgoOsTKU5gyn6IUAAjzItWlZAAQlDrjye5FthOkI
 zbdJWS+T0awUX6N8VPzHYIcuoMgdarzk98I7PPEpAkj6/g30AmA2UkFB3Gs+h66f3xxs7Y
 JpL6NqKlo8iwx+FuALUIsaqbI4bXtRnh+Y7W/iirPKBlhEY0ko9a/h+Uv2R1W7VmgXmSGM
 579L0V8n1qWqFwtHF9I7YQs9f/qFaaobDWvZnVnd/G9AHuJEMoe5wVO6ZAeNkg==
Message-ID: <046255c0-2a21-4f1f-b6b9-135e2e376da5@bootlin.com>
Date: Thu, 4 Jun 2026 09:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] arm: omap: Add back omap4 support
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Hi all,

On 5/21/26 8:45 AM, Bastien Curutchet wrote:
> Hi all,
> 
> This series aims to add back the omap4 support. This support was removed
> by commit b0ee3fe642c ("arm: ti: Remove omap4 platform support") because
> at that moment, none of the OMAP4-based boards had done the migration to
> DM_I2C.
> My use case is an old product based on the Variscite's omap4 system on
> module. I needed to upgrade U-Boot on it for security reasons. I think
> that this work could benefit to other people who may have same kind of
> product to maintain.
> 
> Patch 1 to 3 remove the omap's clock driver dependency to the AM33xx
> as it is also present in omap4 platforms. I tested these changes on the
> beaglebone black to ensure I didn't break the AM33xx case.
> 
> Patch 4 & 5 revert the deletion of the omap4 support. The revert makes
> checkpatch.pl angry. I fixed quite a lots of warnings already but it
> remains two kinds of warnings:
> - CamelCase on timings structure, I left the CamelCase because IMHO it's
>    more readable this way.
> - #ifdef CONFIG_XYZ shouldn't be used anymore. I left one of this because
>    I didn't find a clean way to get rid of it.
> 
> Patch 6 adds support for the Variscite's system on module. This system on
> module is supported by the Linux project through
> ti/omap/omap4-var-som-om44.dtsi
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
> Changes in v2:
> - PATCH 5: Set myself as OMAP4 maintainer
> - PATCH 6: Set SYS_CONFIG_NAME to ti_omap4_common to get rid of omap4_var_som.h
> - Link to v1: https://lore.kernel.org/r/20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com
> 

Gentle ping here, has anyone had time to take a look at this ?


Best regards,
Bastien
