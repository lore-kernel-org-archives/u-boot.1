Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956CECAC5A8
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 09:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169FA830CA;
	Sun, 21 Sep 2025 11:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="hVzU0UK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56895831A4; Sun, 21 Sep 2025 11:03:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E0B82B07
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 11:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1758445395; x=1759050195; i=frank-w@public-files.de;
 bh=iDHvUwpdEXNgYDIwCZBM76aDSqTNKE4NYpqTP844NNc=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hVzU0UK2kxn56d2eI5bBC68s4pZ9SnNGhteu+CSmKXK/ibkbYg0PgXl87NtJStg/
 vYUhOOzCFW7bdyhPeUObMLf9p9vJCnFM5gznd41bPoYMfvWwdzT6x8yJUH+tiX6ft
 /OK7NBTwaZ/IqprFCBFHjK814j5ERbS4ZAikp/dtmG8emvs0il4SM8NJTZuUihKxC
 ibwctvn5LA81KvwBODfh6Kk7RE2exKyncZcN/lfEYLEch+HbHWdZd7yyTNuMpnSBb
 kHBabenWw0jF59XuyY4Mem/bxfGfnNEfRFqOwEkfdluNlFureU3DS0jh3qXut4Rva
 lzsSuGMIO/1/CH0yTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.144.255] ([217.61.144.255]) by
 trinity-msg-rest-gmx-gmx-live-646f7b8dfd-24vr4 (via HTTP); Sun, 21 Sep 2025
 09:03:14 +0000
MIME-Version: 1.0
Message-ID: <trinity-9c95f31d-257e-4486-b833-df15865a5e55-1758445394693@trinity-msg-rest-gmx-gmx-live-646f7b8dfd-24vr4>
From: Frank Wunderlich <frank-w@public-files.de>
To: devel@easynet.dev, u-boot@lists.denx.de
Cc: devel@easynet.dev
Subject: Aw: [PATCH] MT7988 add LED Blue/Green + WPS/Reset Button
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 09:03:14 +0000
In-Reply-To: <20250920163536.1096800-1-devel@easynet.dev>
References: <20250920163536.1096800-1-devel@easynet.dev>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:aJ2YXBu3D2pO5CTHlUofurE0jxup0CVTm8kgKCdyBgnWohHfBdUMPEPhSxhAK+FxWsD89
 DElaku+MXZf25ozXQiBiKQWxB49ke2QUH9TeuOF68ERyMvwoHuXuuuIVnt9TkxU1B+AIQx44PTL6
 QJcxIWOgzUj+tExN+5XS7e16JLP41yJItPrgNCfwYA32aZTO+geCI6k2k9mXd8m4TxrOY1um/LnU
 kgiGxELgGb80ZFr0s2DO6LKFzSoq/jZ7jW86MQmzPDF9p2qgfvkYNpAWg8i0PWnWusBbv7nOypAD
 3QiE8F8c8jrK7t8xL1rdyklwwnbdWVyvTdR05ySmQxrr5nzn8EDBeWsvRc1nq7YTg0=
UI-OutboundReport: notjunk:1;M01:P0:ImhcjINBiOg=;J6iRhZJS6RL+I6jzrBv4gOEPWr3
 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
 nLFN5FmlLYbRd29MwKG7RiwGg9MOXACnrc=
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

Hi

> Gesendet: Samstag, 20. September 2025 um 18:35
> Von: EasyNetDev <devel@easynet.dev>
> An: u-boot@lists.denx.de
> CC: EasyNetDev <devel@easynet.dev>
> Betreff: [PATCH] MT7988 add LED Blue/Green + WPS/Reset Button
>
> MT7988 is missing LED Blue and Green from DTS.
> EEPROM is hard wired to LED Green and you can't use it without
> LED support.
> WPS/Reset button is just for future customization of the U-Boot booting.
>=20
> Signed-off-by: EasyNetDev <devel@easynet.dev>

please use real name here :)

> ---
>  arch/arm/dts/mt7988-rfb.dts    | 23 +++++++++++++++++++++++
>  arch/arm/dts/mt7988-sd-rfb.dts | 23 +++++++++++++++++++++++
>  2 files changed, 46 insertions(+)

i'm not sure if RFB (which dts you are patching) has also green/blue led a=
nd the buttons.

If you really need this, you have to create an own devicetree for BPI-R4 (=
i guess you are
using this board).

btw. in uboot eeprom can be written without setting the green led...someho=
w pinctrl driver
behaves differently (or pin is already initialized to work).

regards Frank

