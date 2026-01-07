Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB27CFD627
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:17:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74645839D7;
	Wed,  7 Jan 2026 14:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L6fErV4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1CE83AAC; Wed,  7 Jan 2026 14:17:06 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280FD83979
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F0C1D60018;
 Wed,  7 Jan 2026 13:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC75C4CEF7;
 Wed,  7 Jan 2026 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767791822;
 bh=YmVArRqU6IKjp7Z6Kkzp5SvL2Jo638z6pqOmPrc4XPw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L6fErV4rHc0c2M0zgXdxzOFi0XAGFzPP1oeJjHEXYKYFxlcc4Ipac20+M+d3qZP2t
 FrYZPQGujeOh5aupUzcxDPfOAtkjmqzQ/1DZoU7/mvaECIFSC6wcRyRxArCtH6hgjW
 pDFF29Fugkc18D0wcC+Hwx8UVFi0avWxpS4RWet6VR2wol39xYYbok9ImNoXNoFQQi
 Y3sktp78R7DzQNIyv41ZMXPmiZhqFhr+MgPyc4tWUySVMNbdjLWPkQnZFV4Q2xBHak
 yCxS+JBKV+Yzdf/ycK8yNEGcoJdDkSD9b1Eey4ngtPC6MeEhjs1deom0E9/qxrTZh8
 H8kjBP0CZ2mUQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: Re: [PATCH 1/4] dm: core: Support multiple drivers with same
 compatibles
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-1-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
 <20251126-topic-musb-probing-v2026-01-v1-1-ff8d8c487130@baylibre.com>
Date: Wed, 07 Jan 2026 14:16:59 +0100
Message-ID: <871pk11s1g.fsf@kernel.org>
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

Hi Markus,

Thank you for the patch.

On Wed, Nov 26, 2025 at 21:31, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Currently once a driver matched the compatible string of a device, other
> drivers are ignored. If the first matching driver returns -ENODEV, no
> other possibly matching drivers are iterated with that compatible of the
> device. Instead the next compatible in the list of compatibles is
> selected, assuming only one driver matches one compatible at a time.
>
> To be able to use the bind function to return -ENODEV and continue
> matching other drivers with the same compatible, move the for loop a bit
> to continue the for loop after -ENODEV was returned.
>
> This is required for ti-musb-host and ti-musb-peripheral which both
> match on the same device but differ based on the dr_mode DT property.
> Depending on this property, the driver is either UCLASS_USB or
> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> function and returning -ENODEV the other driver can probe instead.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/core/lists.c | 62 +++++++++++++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 30 deletions(-)
>
