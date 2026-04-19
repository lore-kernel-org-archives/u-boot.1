Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D4CEA71A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 15:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AC9F83E81;
	Sun, 19 Apr 2026 17:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Eagxpc/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435C984181; Sun, 19 Apr 2026 17:36:38 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA1B183B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-483487335c2so20533325e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776612995; x=1777217795;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZK4BEPWxJWdf90VIxZqqJDYj6hv5y97XCfIMGjCbUrQ=;
 b=Eagxpc/lYkDh0qdI3y1CUKROadssHv7VPAxql1cZfpVE9e7JJeY6Ndg10v26APCIUF
 PK1Dmr/yOs6we0hPnRae2GHfVoCETScqHFcIhVHsVYKbJWFEOST420/J8REIsW3f2juu
 Jaj1b6YRfmjJZ1FZwl4sz4vEez8jXTfsQZ0Lo4c+WNtCQEaZBoqqwgtIAUiYOIQxv5dR
 ie9DX8tZRGXc9/yJ+DWpItOuXswf7oteD0miVcDyWC8ak3kU4nx4rdNx0lQk69lQvV2F
 9V5iGsmDx8qqMkmDJBLgvT7VCEuhPrTL9nEgTRUZRplh6vOdDZa1s2XBReqJ02+6bczJ
 t3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776612995; x=1777217795;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZK4BEPWxJWdf90VIxZqqJDYj6hv5y97XCfIMGjCbUrQ=;
 b=hNfBF4hpXHAtKGWtPZiuQiCMpFDqBOvXjEAz4tEEmetCFAQlJc1Hg2mDEtsg4hCx+W
 fTaPs52plR174Hoccxm12oAljwgQ8eEuHBxL4tv8J+jLLkGDuREbmB/BItLQBeRvSVhO
 n7uT9k72HNYZATiAe3mRmKrZAes821WhNcEzQx40qHb8MMqVLUfyIiBubStclBq+eekC
 WkgMlklfulksJL6wsR9rGLeuzF30LTOlYNM3Nm4/ue4haG0QoDZdW82zrRYKXEeU43Ed
 /o+JgGBFJPCwQaEJSP/HJmJZ/3zixK/7RAs2ldLGZ4OmsMNL2K+LmsjLI9rfmMVBjvve
 Y0Qw==
X-Gm-Message-State: AOJu0Yys45tK9ychAPfJ9Kq5ZqR/6xrgocgkshOGfx/KT085IocDMXTJ
 XqasWDP4MMh8iYYFH008D1GpTZllFojRxK3/22m4AmkwcxJzgOkLqfQ4dnGSm0G6bXU=
X-Gm-Gg: AeBDiesEpCOZW7UCpzh2x0vb75iy85g5FZrRVKo3TTjsQ8yiCAEc2TqN15j+ilR9r2/
 i9RXZ54JEoGvTP13jEVhGUJVeJt1io2KNINghKELFiegV5VjopeBsyAvWdkISoGYKb1FV4HmjoW
 iKxHwvpQVKR7Xh3UVimFc0GIMP7fSqYnMNfn5T9RfBOuC7OdQgBYwP8LlaL65kNg3vi6fSdDeyp
 bvInS2w5VKu9PHbiQepJ//zlgVHWIW+J3APY2CDUjLkFEfv9kkJ2ouKtV5NBwGELljjHJc0Qs4m
 t4AwI0Q+8Dh26f8HAgGC5sQpERMYRxMpOtI8PZzq2qjxcgJTwUkPjqcGW8n4xYZ78oXgt9NdMFb
 EYYVZxKQ9Qh3ejDeZlnUXHsnYPVAGO62OkRfQJIQevYJZmntflky78BHsyAkxkSTEuCVO+fo6QA
 tbSRhKkL7+1SCFVfFsRj1DD6P2/Q==
X-Received: by 2002:a05:600c:a116:b0:485:b6dd:5066 with SMTP id
 5b1f17b1804b1-488fb7471dbmr104734485e9.7.1776612995160; 
 Sun, 19 Apr 2026 08:36:35 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm200486625e9.15.2026.04.19.08.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:36:34 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=10054df2e6719f3e8c9e827d031fb12a919bc8251179070fa11c5d120a07;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 19 Apr 2026 17:35:58 +0200
Message-Id: <DHX8QE2PJQNL.227YQ1FK7JBGG@baylibre.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, "Maarten Brock"
 <Maarten.Brock@sttls.nl>, "kory maincent" <kory.maincent@bootlin.com>,
 <sbellary@baylibre.com>, "romain gantois" <romain.gantois@bootlin.com>,
 "pratheesh" <pratheesh@ti.com>, "j-rameshbabu" <j-rameshbabu@ti.com>,
 "praneeth" <praneeth@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "srk" <srk@ti.com>, "rogerq" <rogerq@ti.com>, "danishanwar"
 <danishanwar@ti.com>, "m-malladi" <m-malladi@ti.com>, "krishna"
 <krishna@couthit.com>, "mohan" <mohan@couthit.com>, "pmohan"
 <pmohan@couthit.com>, "basharath" <basharath@couthit.com>
Subject: Re: [PATCH] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Parvathi Pudi" <parvathi@couthit.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260407082402.2311644-1-parvathi@couthit.com>
 <DHUF0R06L66I.OSJLU3XXXRAJ@baylibre.com>
 <1738882833.949820.1776427607139.JavaMail.zimbra@couthit.local>
In-Reply-To: <1738882833.949820.1776427607139.JavaMail.zimbra@couthit.local>
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

--10054df2e6719f3e8c9e827d031fb12a919bc8251179070fa11c5d120a07
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Parvathi,

On Fri Apr 17, 2026 at 2:06 PM CEST, Parvathi Pudi wrote:
> Hi Markus,
> =20
>> On Tue Apr 7, 2026 at 10:22 AM CEST, Parvathi Pudi wrote:
>>> This patch removes the static MDIO pinmux configuration from
>>> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
>>> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
>>> were always configured for CPSW in mux.c, which could lead to
>>> unnecessary pin ownership and conflicts in scenarios where CPSW
>>> is not used.
>>>
>>> With this change, the MDIO pins are configured only when required,
>>> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
>>> This approach keeps Ethernet boot behavior intact and provides cleaner
>>> separation between CPSW and other Ethernet use cases.
>>=20
>> Do you have a specific use case here?
>>=20
>
> We have an ICSSM PRUETH Ethernet use case. The existing static MDIO pinmu=
x
> configuration has been hard-coded for CPSW. Based on the hardware jumper
> setting we configure the MDIO either for CPSW or for the ICSSM PRUETH use=
 case.
>
>>>
>>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>>> ---
>>>  board/ti/am335x/board.c | 22 ++++++++++++++++++++++
>>>  board/ti/am335x/mux.c   |  2 --
>>>  2 files changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
>>> index 90e37a8d913..abeab809387 100644
>>> --- a/board/ti/am335x/board.c
>>> +++ b/board/ti/am335x/board.c
>>> @@ -61,6 +61,18 @@ DECLARE_GLOBAL_DATA_PTR;
>>>  #define GPIO_ETH0_MODE		GPIO_TO_PIN(0, 11)
>>>  #define GPIO_ETH1_MODE		GPIO_TO_PIN(1, 26)
>>> =20
>>> +#define AM335X_PIN_MDIO	0x948
>>> +#define AM335X_PIN_MDC		0x94c
>>=20
>> These two are not aligned when applied.
>>=20
>
> We will fix this in the next version.
>
>>> +
>>> +#define GPIO_MDIO_DATA		CTRL_BASE + AM335X_PIN_MDIO
>>> +#define GPIO_MDIO_CLK		CTRL_BASE + AM335X_PIN_MDC
>>> +
>>> +/* Enabling MDIO_DATA by setting MUX_MODE to 0, RXACTIVE, PULLUP_EN bi=
ts */
>>> +#define PAD_CONFIG_MDIO_DATA	0x30
>>> +
>>> +/* Enabling MDIO_CLK by setting MUX_MODE to 0, PULLUP_EN bit */
>>> +#define PAD_CONFIG_MDIO_CLK	0x10
>>> +
>>>  static struct ctrl_dev *cdev =3D (struct ctrl_dev *)CTRL_DEVICE_BASE;
>>> =20
>>>  #define GPIO0_RISINGDETECT	(AM33XX_GPIO0_BASE + OMAP_GPIO_RISINGDETECT=
)
>>> @@ -779,6 +791,16 @@ int board_init(void)
>>>  			hang();
>>>  		}
>>> =20
>>> +		if (!eth0_is_mii || !eth1_is_mii) {
>>=20
>> eth0_is_mii and eth1_is_mii is the same, as it was checked in the
>> if condition above this one. You could make this an else if as well if
>> you like.
>>=20
>
> Sure, we will clean it up in the next version.
>
>>> +			/* Set the Mux Mode to MDIO_DATA */
>>> +			reg =3D readl(GPIO_MDIO_DATA);
>>> +			writel(reg & PAD_CONFIG_MDIO_DATA, GPIO_MDIO_DATA);
>>> +
>>> +			/* Set the Mux Mode to MDIO_CLK */
>>=20
>> Please remove comments for code that shows the same thing.
>>=20
>
> We will fix this in the next version.
>
>>> +			reg =3D readl(GPIO_MDIO_CLK);
>>> +			writel(reg & PAD_CONFIG_MDIO_CLK, GPIO_MDIO_CLK);
>>=20
>> Could you do the same thing in enable_board_pin_mux()? Or would it be
>> possible to reuse mux.h here to avoid redefining values etc.?
>>=20
>> Why do you use reg & PAD_CONFIG_MDIO_CLK instead of writing
>> PAD_CONFIG_MDIO_CLK directly and skip the read?
>>=20
>
> enable_board_pin_mux() runs before the jumper state is known, so we can't
> use it here. We'll reuse the existing macros from mux.h instead to avoid
> the redefinition's.
>
>>> +		}
>>> +
>>=20
>> This snippet is in the section guarded by these:
>>=20
>>  #if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) ||=
 \
>>    (defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
>>    if (board_is_icev2()) {
>>=20
>> Is this the same as for the original pinmux setup?
>>=20
>
> We have not changed the original pinmux setup.
> Can you please elaborate bit more on this?

Yes, I specifically meant the #if defined(...) conditions that are
present for the if block in which you added the new code. The MDIO
configuration is now only executed when CONFIG_CLOCK_SYNTHESIZER is set
(and CONFIG_SPL_ETH for SPL builds). Is this intentional and the same
condition as it was running in the pinmux code?

Best
Markus

--10054df2e6719f3e8c9e827d031fb12a919bc8251179070fa11c5d120a07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaeT2XxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlND
FwEAusg3FKPxvxXtklC20tkBWdhvUV0Jiidu1MpAzZFWCvwA/jDTsVVVYmwdbRrp
UwpkRgmltV/AwQKzc7E/S/eL33cF
=uzA+
-----END PGP SIGNATURE-----

--10054df2e6719f3e8c9e827d031fb12a919bc8251179070fa11c5d120a07--
