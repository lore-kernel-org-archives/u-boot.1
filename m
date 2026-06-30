Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFD4C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 08:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5560184A60;
	Tue, 30 Jun 2026 10:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lcrY8uuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF7284A65; Tue, 30 Jun 2026 10:01:05 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F4884A35
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B6B4600DA;
 Tue, 30 Jun 2026 08:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AFB1F00A3A;
 Tue, 30 Jun 2026 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782806461;
 bh=oTR6fMc5QHTDhTRmAOyuLwykEKa7xbPm6m1MWYiuO5A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lcrY8uuRtlPcp1arhh3CJ8qpLB6aWOokU1VIqhMR/eXfrPR6KoBkKvJH2HK6GzEZA
 QDw1ktdeJuf9OIEq/kt6voBexpIIEZ9ZDZps4lh7Cm3+Oteq9RUJckIrGCTumKNtvg
 QKUeJbP7MeS37UB93ECzq1orhOvRb1FLte9GwZaeBQMYI61IGhcmjGNbGeeAHwH9gr
 9rPq8eawfeC+bJRn1sTSqgYFrhJJIARhr+2MOCY8PeIfb9keOcUqxB7l7m9i3OeGoK
 zcu5D1roifyIhaSJGGe6sDEPRSAhlnFxN1/myh7jWOvRGPdpZntcGbUoKt6c5keZ6i
 uFne+zlfN7MHw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Kever Yang
 <kever.yang@rock-chips.com>, Peter Robinson <pbrobinson@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>, Balaji
 Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Herve Codina
 <herve.codina@bootlin.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese
 <stefan.roese@mailbox.org>, Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>, David Lechner
 <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller support
In-Reply-To: <267c7ac5-01f2-4cf1-b0e6-7aa5f5ee224e@mailbox.org>
References: <20260625-rzn1-usbf-v1-0-0e1a38f7b82c@bootlin.com>
 <20260625-rzn1-usbf-v1-2-0e1a38f7b82c@bootlin.com>
 <267c7ac5-01f2-4cf1-b0e6-7aa5f5ee224e@mailbox.org>
Date: Tue, 30 Jun 2026 10:00:58 +0200
Message-ID: <87bjcs8nk5.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello,

On Thu, Jun 25, 2026 at 14:35, Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 6/25/26 11:05 AM, Romain Gantois wrote:
>> From: Herve Codina <herve.codina@bootlin.com>
>>=20
>> Add support for the Renesas USBF controller. This is an USB2.0 UDC
>> controller available in the RZ/N1 SoC.
>>=20
>> This driver was originally written by Herv=C3=A9 Codina for the Linux ke=
rnel.
>> Suspend/resume features have been removed in this U-Boot port.
> If this was ported from Linux, please include in the commit message from=
=20
> which commit SHA in the Linux kernel this was ported from.

I agree with Marek. Having a reference so that we can compare properly
with linux is important. It helps when the linux driver evolves as well,
to port future changes from there into U-Boot.

Without the linux SHA it's very difficult to to review this patch.
