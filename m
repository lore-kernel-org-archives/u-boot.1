Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5078C02187
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 20:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FCD800CF;
	Sun, 19 Jan 2025 21:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="o2jMfCpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD556801CF; Sun, 19 Jan 2025 21:07:03 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB73D80085
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 21:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YbkyV2cN0z9wq5;
 Sun, 19 Jan 2025 20:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737317218; bh=goOUn0xKh9gigGO7GunYiBoEPQe1pzK0EhGHPY8aH1M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o2jMfCpyx3BjK4zVofPzzj/P+3BQPMkvFOJNDc9DPo1HUDqrsHfunkTbgaUFK8wJq
 PNRJE1sm3TLi37uFHs43HlOq5t7/n++8bdTTxqAhz+hBfJK2fimSTrrEu8RY+ysFs4
 PSDlaKwVzHjddBy8zqSnVBo1T5Zn/Jig3ad82PCs=
X-Riseup-User-ID: A8825B9C8E261D4939C43F4099D1FD1536E0EEA9D2D2ECD6D02A6E07D9466400
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YbkyQ0ZRxzJrZn;
 Sun, 19 Jan 2025 20:06:53 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Ondrej Jirman <megi@xff.cz>, Dragan Simic <dsimic@manjaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 10/10] configs: pinetab2-rk3566: Enable video and USB
 keyboard
Date: Sun, 19 Jan 2025 20:06:44 +0000
Message-ID: <6474453.DvuYhMxLoT@melttower>
In-Reply-To: <46543de3-e368-42d2-a42a-031f14b31d54@kwiboo.se>
References: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
 <20250116-vop2-pt2-v1-10-c9d646b53930@riseup.net>
 <46543de3-e368-42d2-a42a-031f14b31d54@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi Jonas,

On Sunday, January 19, 2025 2:08:37=E2=80=AFPM UTC Jonas Karlman wrote:
> Hi Dang,
>=20
> On 2025-01-16 10:15, Dang Huynh wrote:
> > +CONFIG_CLK_CCF=3Dy
> > +CONFIG_CLK_COMPOSITE_CCF=3Dy
>=20
> Is CCF and COMPOSITE_CCF needed?
Yes, it's required to turn on and set video port clock. COMPOSITE_CCF=20
shouldn't be needed.

>=20
> > +CONFIG_VIDEO_DT_SIMPLEFB=3Dy
>=20
> I do not see a simple-framebuffer compatible, is VIDEO_DT_SIMPLEFB
> needed?
It shoudln't be needed, whoops.

>=20
> Regards,
> Jonas
>



