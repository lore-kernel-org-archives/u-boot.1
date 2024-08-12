Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BDCC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 22:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED84388842;
	Tue, 13 Aug 2024 00:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iZ2GOMkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111F788898; Tue, 13 Aug 2024 00:01:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651EE88842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 00:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1723500068; x=1724104868; i=xypron.glpk@gmx.de;
 bh=vryd7jCRuzjQ4z/ps7+9KTCMoOvZyCAUSrSttEGLtoQ=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iZ2GOMkTihnPB07LNHxYS9mQ0foLD54GKe6YApc6SnvwDB8+3zD+UUulaYyudCjz
 dMi59dwKty5uhvXveBj17tKAMr9uEqPTuRIPa/hQyPN5aTMwVDPfqriNED997gV3J
 ojshDo2mt4g1rhwOOGHkWZWJCFdQpAduE78ngNKXY5LUsSjb1g7J0Kjw6q9xT419/
 KNM3h0R3UkPBSCq7G98kKseDKk6Ye7r4nsp2VMHuDwTHeXX4TzKtlnn+WpkgQRhU+
 XOBkD0RlsimHOn+u0XipwS9/oL4w1gbyn9yFv39OyvWiwqcPgZJhWpa0xKuYiumjW
 5kN7bM/ostSyinw2XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.247.80]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpOT-1rxztS2cnp-00hF7Q; Tue, 13
 Aug 2024 00:01:08 +0200
Date: Tue, 13 Aug 2024 00:00:59 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Dmitry Dunaev <dunaev@tecon.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/9] led: turn LED ON on initial SW blink
User-Agent: K-9 Mail for Android
In-Reply-To: <20240812103254.26972-2-ansuelsmth@gmail.com>
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-2-ansuelsmth@gmail.com>
Message-ID: <BD52390C-A644-44EF-B691-2816E0F56770@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oQj407MlbTzzgxKRRpYyqkxHA2xFt0dm93O1bia+tCp84JfrZTQ
 pRlKQSzZppjStw5HdRMPwbNNNaMdaenwlfUpTMjJrVgIO617+5qkqDDlqyT4ySCJUyRjEXO
 6G2d01LBzn7OoYpMSH9DfJMoKmcHy0akEIgyAahPAYoWkXjZ5eoIWtHljHKrTaGUwozH0AL
 cWcWjxMtXycXuGgUopfCQ==
UI-OutboundReport: notjunk:1;M01:P0:o0v++ds/oC8=;7ybXshSt1G/fnl2dj/12xb5fK67
 sYBQ5HT3JxbHdpLXp2yYWkg1Ez++tYo2+c6zWhrUawwUDfYkht6CC+b9N0TINOy/+0DY0WMHI
 HMpr52vWpmqy58X9Qrk4xdVDF0D9OWkdouPncbGTyTWJ3YjSIBTryPsf4xUO58i3CaIw2aG04
 6KO7YV1R6lix9R7SHYyg5sT5kmyNXFq8TDZML7m2bT+NQhqF1GZtCoB2HWU2senyImONHugnO
 hyBWKkkCzf9HdvbRKJbulOObaobuBhHA80Z50oJgTI2J5LshuM47Te+b7LwYWINzCAY5kXTD2
 u02YtajCXIvV94kTlIF6X8Bqk5OWYQ6zLaitxqXwg4im+RgqRYy5Ag3s47zbevcmVAjutTVKr
 HC9HnUb5GXjldexFJjI5JRnQsH0DLrQSLKqbmbKX+GgAyRMRuirUwCYeR5KPJDwiz6axJFX3P
 /uHVVYfjPfUeXqlNRwIleLTLH/Py6S0Gba9J2R4J05G+3VFW50PrJAJE1+hLHrekwqfyZgmOg
 6hMoCs+5Sk2z52+pyYMHHHCndEgtaDpeeViloNkZw6YCO6wJ84DHrPRP4ur10Lap2zhYNwvCa
 bg8Qc2dVQjy1fxNWqod3ryaDVU3OUTeg0cAsIRtjNAYBR5eYFHRYjrYuSxDIp1SycaBbC7GNy
 ZH3SxXg54GsyTtcF7SiAodtGoZMXr41KI7jFsiMbsWI+drT5U+7bhgrGHMGJ+qPhdccTtuz52
 hjPL+XZutCj8RBvTr7H/6jT5KtE2tGeQQb+63WCkATbefUc3aH5wyq5qsPgiHOn16hygvGIG7
 UMcEd3LzT4dVVamM7eANBluA==
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



Am 12=2E August 2024 12:32:43 MESZ schrieb Christian Marangi <ansuelsmth@g=
mail=2Ecom>:
>We currently init the LED OFF when SW blink is triggered when
>on_state_change() is called=2E This can be problematic for very short
>period as the ON/OFF blink might never trigger=2E
>
>Turn LED ON on initial SW blink to handle this corner case and better
>display a LED blink from the user=2E

If the the prior state is on, blinking should start with off=2E

If the prior state is off, blinking should start with on=2E

Best regards

Heinrich


>
>Signed-off-by: Christian Marangi <ansuelsmth@gmail=2Ecom>
>---
> drivers/led/led_sw_blink=2Ec | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/led/led_sw_blink=2Ec b/drivers/led/led_sw_blink=2Ec
>index 9e36edbee47=2E=2E853278670b9 100644
>--- a/drivers/led/led_sw_blink=2Ec
>+++ b/drivers/led/led_sw_blink=2Ec
>@@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, enu=
m led_state_t state)
> 		return false;
>=20
> 	if (state =3D=3D LEDST_BLINK) {
>+		struct led_ops *ops =3D led_get_ops(dev);
>+
>+		ops->set_state(dev, LEDST_ON);
> 		/* start blinking on next led_sw_blink() call */
>-		sw_blink->state =3D LED_SW_BLINK_ST_OFF;
>+		sw_blink->state =3D LED_SW_BLINK_ST_ON;
> 		return true;
> 	}
>=20
