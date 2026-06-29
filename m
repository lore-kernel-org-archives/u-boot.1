Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3869C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCBA84931;
	Mon, 29 Jun 2026 14:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JPLRWaCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92E984975; Mon, 29 Jun 2026 14:33:29 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D1A8490A
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 14:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5137040861;
 Mon, 29 Jun 2026 12:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1691F00A3A;
 Mon, 29 Jun 2026 12:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782736406;
 bh=ObbwfUZjPq8LALFoFY38JB3i2AJCLG1u5P0KrzzA6hk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=JPLRWaCaObMNbeoaMho9Y9g3RtR7LiGdxQLV31sWRcSpDgNSUyn+GbRH5jlgIHTnF
 RTGhM33tqEOaZDBmJnfDDC8XPYotDgKlY/0tdvt3oTei8cHW3nNGWFuwe3J6DFT2ay
 9WSV9wqd4lHwTdE8CAYq4ZAT+RHguTQTtcelOWfLb7iVniG81nY3451ygOYYWT5fCa
 sQzstpaIwaLoo9UGG+S8L77IBgqozhSzFfGflJ52KC2FgHbLfwvXAfNLzR5gRhvefS
 /hu9EkL0SG2C77X+5RmdVUl1NzUsBfQi+J7+m6oXTUpyeir3zNbdY7oVH8b9qFuR0c
 UdygZC4EjaDdg==
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
Subject: Re: [PATCH v2 2/3] usb: host: ehci-msm: Register ChipIdea UDC from
 glue wrapper
In-Reply-To: <20260527-msm8916-usb-v2-2-343e1e32e77b@samcday.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
 <20260527-msm8916-usb-v2-2-343e1e32e77b@samcday.com>
Date: Mon, 29 Jun 2026 14:33:23 +0200
Message-ID: <87bjctcyr0.fsf@kernel.org>
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

On Wed, May 27, 2026 at 00:37, Sam Day <me@samcday.com> wrote:

> When CONFIG_DM_USB_GADGET is enabled, the CI UDC driver needs to be
> explicitly bound. So we do this from the newly introduced glue driver.
>
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
