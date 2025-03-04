Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D5AC282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 01:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F8680786;
	Tue,  4 Mar 2025 02:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="nCvfNsOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C8F80842; Tue,  4 Mar 2025 02:04:59 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA648059D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 02:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Z6HXM5hK6z9tSN;
 Tue,  4 Mar 2025 01:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1741050292; bh=ichD/7o0RToFqEdoBCbdslgZg+lhh/wyolwsjkwzFfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nCvfNsOno+IttnCYjhDoaq9hg/wzCbrrfoPWi4rVvtA672aqNG9NYicokjdF433Ta
 c3T+EZlg2IEec8x0GGAUGaNhqsvYo2kB1xPu18DcBfomkb61Tt35z9n67KRUJaGgSA
 klJ/chKmq6VUlPqCoG35zalvoaG7y2NKXYW2we5s=
X-Riseup-User-ID: E646EFFF993C9E2E4ADCF3A47AADCC6EEE9229F437D7202FEF828528F93F6D5B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z6HXH2mbnzJnKW;
 Tue,  4 Mar 2025 01:04:47 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v2 06/11] video: rockchip: Add VOP2 support
Date: Tue, 04 Mar 2025 08:04:37 +0700
Message-ID: <5752412.31r3eYUQgx@melttower>
In-Reply-To: <cbd6a15b-61b1-4466-9d84-d80d98ec8720@rock-chips.com>
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <2377708.irdbgypaU6@melttower>
 <cbd6a15b-61b1-4466-9d84-d80d98ec8720@rock-chips.com>
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

Hi Chaoyi Chen,

On Monday, March 3, 2025 9:48:14=E2=80=AFAM UTC Chaoyi Chen wrote:
> Hi Dang,
>=20
> On 2025/3/2 12:09, Dang Huynh wrote:
> >>> +	struct rk3568_vop_esmart *esmart =3D priv->regs +
> >=20
> > VOP2_ESMART_OFFSET(0);
> >=20
> >> You are assuming that the RK356X is always used ESMART0, which general=
ly
> >> works. But considering
> >> that there are multiple Video Ports and different Video Ports may have
> >> different primary win,
> >> selecting the appropriate win can simplifies the processing for U-Boot
> >> to Kernel transitions in the future.
> >>=20
> >> It's a good idea to implement the win selection as a configurable
> >> parameter, or we can consider the
> >> default win used for different Video Ports.
> >=20
> > ESMART0 is configured to the desired video port on U-Boot. VOP2 should =
be
> > reconfigured by Linux.
>=20
> That make sense.  But would this be a problem if it is to be displayed
> on multiple video ports (HDMI & MIPI DSI)
>=20
> at the same time? I've only tested HDMI so far.
U-Boot doesn't support multiple displays, so it doesn't seem to be a issue.


