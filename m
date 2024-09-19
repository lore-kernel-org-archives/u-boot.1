Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0717CF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23D27892A2;
	Thu, 19 Sep 2024 19:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="snZgum/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959BC892B4; Thu, 19 Sep 2024 19:21:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0228863E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1726766449; x=1727371249; i=xypron.glpk@gmx.de;
 bh=pVJASUexzH8R5WB9+9FMuBPkw9dUmg7hfU04IarAzx4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=snZgum/agqeoZC1sJvuYnzgBYzcTsFZQc8pMQiJWxegdrcgcV4k9U9E//vBWfqBn
 MHJscb3QyAG7wg/Y5PT9Eyt8x7cZ1Hh/YnbbPlEnfNzCAdzJp2Mrcn8TQz7qp4Ptk
 pWM3pdtRm/ZBpZdEkVWXeMm3vQczIGOGyCQdTgwwc+dyJ5tx1CgX3N1hjrKf1075i
 crEFMUebAvMqre6NBolC7uQK6n4A3pY8dU+GZ+PiQj+uLJMvNyzX9v4KEJr3N4tqF
 QdaJehJBuZQPPAh6QXJKfOTV6v5A+FTzr6tv3eDeltNizCuHvuheTWKGHp+oLsByy
 2lK/K/LzYsLGtLbjrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JmN-1srboe1g1Z-00B5Dv; Thu, 19
 Sep 2024 19:20:49 +0200
Message-ID: <c73e6496-9b16-4ab0-ac6a-d6a075d5d38a@gmx.de>
Date: Thu, 19 Sep 2024 19:20:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] led: turn LED ON on initial SW blink
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, Dmitry Dunaev
 <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-2-ansuelsmth@gmail.com>
 <BD52390C-A644-44EF-B691-2816E0F56770@gmx.de>
 <66c71efa.050a0220.1f7dd.ecb2@mx.google.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <66c71efa.050a0220.1f7dd.ecb2@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lSTXUse0DaPbK74Y2P1Yy1se6UebVo7PE6g7NnRzbqWNyTL+CeQ
 0PoHtaRvogzyJ/RCC3UAsRTQArck6AfzfuW+Mmy0+DOsuET6GnV+NINSLAYxGKRD2CNnm5v
 5tmCb4/gjJax+0kiQk6xGopEKftLsfJW209ky+GrasucWb0DkHgQ4bXc45bnH0CKbPeht2P
 LPcIcaSRHXtGajPAV/0Ew==
UI-OutboundReport: notjunk:1;M01:P0:1yG2zU7rL/k=;xnYPDvYYjePv0gE1S2XpRfFEfdv
 3nuZWz/JwfJZvvytJfWlsKF+T2cULjGU2KAuZ7PispVxK4hfXVWtkSiiZ3/aU6mJ/aKWf97zr
 Ny9ym8t14ZUYPJv7YcAXGd/3LGAwikqUsRnmAbyCx5VL0Nv9NbclBQoiPYsd5RDq4B/WKdtU9
 tl33495Mtx87uT85ICx/4CC1GIV/MrLOJF3QHEtt3KkPPRzKBcaS5T6v3f6AfFTnylfgQip5o
 7G3K+/VpmhBJBeEN2EVnNBtGWIByrOQFCyep8udyqHlnfpGs7AdxYnp5AXZQ6Svmx8lFDca1X
 a8Lugk/mpg3OqyzKfrn690dfycOobU8YL4yv5yS1vvCn+W3BKa1ZK8fSoT/EEhatFEKu7LtW0
 dhhahg+364ZqVPN1afRNSLOeNh86w5VO4Hdcltopz9KL2DmH+FxyZ3mZm9e5YD/jg5k68mZ0m
 G4zbUWUetO8ZQAS5DtThikYKFrXIZIiwHW+sypurGQNp0mcxkhtnDgKriRmvFtGjOc3LPJxhE
 9RylSH4JzqVAG6iJ70iQrEbppgSlVQO+lnwS07iFnR1uNBYfOxDd7GXqIAN/+3m0Yzuln+DEc
 D861pGjPZgVajdEdnVCwPzhwmWsaL/7ZaC+rdkh1Q/7hpdZ4fKvnk3w3nLJc7yUj4JdOn2zFE
 9am/iL2dZWyDv5d4UbGtfN+ttpl9ZZazMe0cCmluDiiXYRsb9IXYfUkpUOIpObTzV9+m1xdAV
 75MLX7a9Eb7VXL4p0/Xo/dBiU81TVyv+qpKy+vV8bnXOfkRufNXjtnTKWfvii7yeD9c/C8mKm
 GwMpToV9pFkFCczd6YI2u02A==
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

On 22.08.24 12:47, Christian Marangi wrote:
> On Tue, Aug 13, 2024 at 12:00:59AM +0200, Heinrich Schuchardt wrote:
>>
>>
>> Am 12. August 2024 12:32:43 MESZ schrieb Christian Marangi <ansuelsmth@=
gmail.com>:
>>> We currently init the LED OFF when SW blink is triggered when
>>> on_state_change() is called. This can be problematic for very short
>>> period as the ON/OFF blink might never trigger.
>>>
>>> Turn LED ON on initial SW blink to handle this corner case and better
>>> display a LED blink from the user.
>>
>> If the the prior state is on, blinking should start with off.
>>
>> If the prior state is off, blinking should start with on.
>>
>
> A bit confused. You mean I should improve the commit description or the
> code needs to he changed to reflect this and check the LED status before
> applying the BLINK?

The code should take the prior state of the LED into account. When
enabling blinking the on/off state of the LED should change immediately.

Best regards

Heinrich

>
>>
>>
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>> drivers/led/led_sw_blink.c | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
>>> index 9e36edbee47..853278670b9 100644
>>> --- a/drivers/led/led_sw_blink.c
>>> +++ b/drivers/led/led_sw_blink.c
>>> @@ -103,8 +103,11 @@ bool led_sw_on_state_change(struct udevice *dev, =
enum led_state_t state)
>>> 		return false;
>>>
>>> 	if (state =3D=3D LEDST_BLINK) {
>>> +		struct led_ops *ops =3D led_get_ops(dev);
>>> +
>>> +		ops->set_state(dev, LEDST_ON);
>>> 		/* start blinking on next led_sw_blink() call */
>>> -		sw_blink->state =3D LED_SW_BLINK_ST_OFF;
>>> +		sw_blink->state =3D LED_SW_BLINK_ST_ON;
>>> 		return true;
>>> 	}
>>>
>

