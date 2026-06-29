Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A05CC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6414E84931;
	Mon, 29 Jun 2026 14:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DYmw9ZIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD7784987; Mon, 29 Jun 2026 14:34:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B72C8490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F105860008;
 Mon, 29 Jun 2026 12:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC471F000E9;
 Mon, 29 Jun 2026 12:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782736443;
 bh=ZJ1RZ9uMqIN3jgXwspIFjk2vC2HnQvNaqUC2PmtuG6U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=DYmw9ZIC3sDj/Dxd8BWtdyMFV6gW3AqKaRHauAoQskzTJ5VIiNOLAzqPEjdpDyOFW
 yoOQqOOQZXpBHCpiz1azpTBg30XN/7e5t+55Q64E2ZykUY3ilu4i409/47oTftR304
 Z3hphnL601IglXxjSjoF/qZBvHTq6/Mpqf2StQzLejau/ydHVBiwTQkj41ANx9Mz/G
 SSCVmthquYLW9e2tHWdmFf7YcoWggmb0kpUIoAsdJPVFSZuDmo41OpZSi66EdJEF7F
 lT4zHg7hdkNt8jJkoMXER+L7sHUYOYPvwLK1YcKjqSzH6zdYhmpBVNbjYz9p6tCQmM
 nKbS3DDiPMRkQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom
 Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Quentin Schulz
 <quentin.schulz@cherry.de>, Kever Yang <kever.yang@rock-chips.com>, Peter
 Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, George
 Chan <gchan9527@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Petr =?utf-8?Q?Bene=C5=A1?=
 <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, Aswin
 Murugan <aswin.murugan@oss.qualcomm.com>, Paul Sajna
 <sajattack@postmarketos.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Varadarajan Narayanan
 <varadarajan.narayanan@oss.qualcomm.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Luca
 Weiss <luca.weiss@fairphone.com>, Sam Day <me@samcday.com>
Subject: Re: [PATCH v2 3/3] qcom_defconfig: Enable MSM8916 USB PHY +
 ChipIdea UDC
In-Reply-To: <20260527-msm8916-usb-v2-3-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
 <20260527-msm8916-usb-v2-3-343e1e32e77b@samcday.com>
Date: Mon, 29 Jun 2026 14:34:01 +0200
Message-ID: <878q7xcypy.fsf@kernel.org>
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

Hi Sam,

Thank you for the patch.

On Wed, May 27, 2026 at 00:38, Sam Day <me@samcday.com> wrote:

> Now that the ChipIdea UDC driver supports USB Gadget driver model, we
> can enable it alongside the dwc3 generic driver.
>
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
