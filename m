Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0749E94115
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 20:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19AC586DB8;
	Fri,  6 Oct 2023 22:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L126s2m7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB95386DD5; Fri,  6 Oct 2023 22:31:12 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EF3986ACF
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 22:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-57b811a6ce8so1381317eaf.3
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696624269; x=1697229069; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WTT4KORJ0Uc7a6rbK+g4mzGEx04akjAmS75CeYL+VhI=;
 b=L126s2m79iaKyvaGrYr+agPcILRYzlwO+cHh/XQCEImwCeKD5VqNtRb00qRt+QrTun
 r1D+KJ5B+/mes05u7vD4Wi35aD828NhoXzd6F42g5VhnOE4vatbX+whKPCyXN9tvLGB8
 HbRKhjUR4pK0gmakeIPNCmouqEndtXWb7ZfZm6WyYNDolwGFIDF2rKk1aapbnyJ1lnpK
 A6ugn8A/V+nvJfIA6LZa9oo8sAoi9NDixxtHq3UM/2AgWwtGcpQSW459NjDm5SsII+Hw
 L6fCf5b5nJYPy0S2oaig/FYJanxdGPoWifhJ+St7lZ4Y2BiVQk7z9E72WxqY004TkLAG
 a29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696624269; x=1697229069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTT4KORJ0Uc7a6rbK+g4mzGEx04akjAmS75CeYL+VhI=;
 b=HcMkrErVYbesBkIWJrqpmtB6pl0ZC6wPkEDY4iNoDrg9thnGSMhVvKQoAbrxnVPkNm
 sisAMQIgNzLEcwVefRhneNwWOvaDD5BCZrK2PCgnj7T7HNflv6+0Lb/ThnhhSg4oxhph
 cjFKyTI2sY31M6yECxIcNwjlYP8rXqWqJwZo3rELRSwmt4T7hP8mfJGVd13oWygbU7sZ
 Fs6YG2Fzzvi1j9aeaKcFwOUwdlLNUJMnkbPf56cvaVZcSzvzexxN+ykOhR61aKYchVRU
 4QYllNLuNVFqwC/BWC/ZCq/U23+kJjTuNmebgXQ/RZ7iXxKwpM1uS3f69zdS3hVSq5nB
 GTzA==
X-Gm-Message-State: AOJu0YxSkJGMbcHKDdgPxKv3ZIzO+18x6riKb0cv0a8lD8siqt6bwAeS
 RNHJGs4cPpc5IkUYNEgfdlMf0SkegZOalKhpYVk=
X-Google-Smtp-Source: AGHT+IGQkkwYyD02Eq0B6CtynHL0dPvD+Dk4PK9YkPPkrO/B3Kvd64cXqfHxHs3Z79qQUEs/cZ7Y4N4eGfhTmFv5dIw=
X-Received: by 2002:a4a:3946:0:b0:57b:6c85:972 with SMTP id
 x6-20020a4a3946000000b0057b6c850972mr9109137oog.0.1696624269070; Fri, 06 Oct
 2023 13:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231006122439.10720-1-debrabander@gmail.com>
In-Reply-To: <20231006122439.10720-1-debrabander@gmail.com>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Fri, 6 Oct 2023 23:30:58 +0300
Message-ID: <CAGi-RU+=4cvY3xcyidTNErVLFNKg+cM+Qmfc7AdWaqDemm9b7A@mail.gmail.com>
Subject: Re: [PATCH] net: phy: TI DP83869 fix invalid clock delay configuration
To: Frank de Brabander <debrabander@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 6, 2023 at 3:24=E2=80=AFPM Frank de Brabander <debrabander@gmai=
l.com> wrote:
>
> Setting the clock delay from the device tree settings
> rx-internal-delay-ps and tx-internal-delay-ps was broken:
>
>  - The expected value in the device tree is suppose to be a
>    delay in picoseconds, but the driver only allowed an array index.
>  - Driver converted this array index to the actual delay in
>    picoseconds and tried to apply this in the device register. This
>    however is not a valid register value. The actual logic here was
>    reversed, it converted an register representation of the delay to
>    the device tree delay in picoseconds.
>
> Only when the internal delays were NOT configured in the device tree
> and they default value of 7 (=3D2000ps) was used, a valid value was
> loaded in the register.
>
> Signed-off-by: Frank de Brabander <debrabander@gmail.com>
> ---
>  drivers/net/phy/dp83869.c | 53 +++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
> index 8d32d73b07..f9d4782580 100644
> --- a/drivers/net/phy/dp83869.c
> +++ b/drivers/net/phy/dp83869.c
> @@ -81,7 +81,10 @@
>
>  /* RGMIIDCTL bits */
>  #define DP83869_RGMII_TX_CLK_DELAY_SHIFT       4
> -#define DP83869_CLK_DELAY_DEF                          7
> +#define DP83869_CLK_DELAY_STEP                 250
> +#define DP83869_CLK_DELAY_MIN                  250
> +#define DP83869_CLK_DELAY_MAX                  4000
> +#define DP83869_CLK_DELAY_DEFAULT              2000
>
>  /* CFG2 bits */
>  #define MII_DP83869_CFG2_SPEEDOPT_10EN         0x0040
> @@ -157,10 +160,6 @@ static int dp83869_config_port_mirroring(struct phy_=
device *phydev)
>         return 0;
>  }
>
> -static const int dp83869_internal_delay[] =3D {250, 500, 750, 1000, 1250=
, 1500,
> -                                            1750, 2000, 2250, 2500, 2750=
, 3000,
> -                                            3250, 3500, 3750, 4000};
> -
>  static int dp83869_set_strapped_mode(struct phy_device *phydev)
>  {
>         struct dp83869_private *dp83869 =3D phydev->priv;
> @@ -183,7 +182,6 @@ static int dp83869_set_strapped_mode(struct phy_devic=
e *phydev)
>  static int dp83869_of_init(struct phy_device *phydev)
>  {
>         struct dp83869_private * const dp83869 =3D phydev->priv;
> -       const int delay_entries =3D ARRAY_SIZE(dp83869_internal_delay);
>         int ret;
>         ofnode node;
>
> @@ -238,32 +236,45 @@ static int dp83869_of_init(struct phy_device *phyde=
v)
>         dp83869->tx_fifo_depth =3D ofnode_read_s32_default(node, "tx-fifo=
-depth",
>                                                          DP83869_PHYCR_FI=
FO_DEPTH_4_B_NIB);
>
> +       /* Internal clock delay values can be configured in steps of
> +        * 250ps (0.25ns). The register field for clock delay is 4-bits w=
ide,
> +        * the values range from 0b0000 for 0.25ns to 0b1111 for 4ns.
> +        */
> +
>         /* RX delay *must* be specified if internal delay of RX is used. =
*/
>         if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
>             phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_RXID) {
> -               dp83869->rx_int_delay =3D ofnode_read_u32_default(node, "=
rx-internal-delay-ps",
> -                                                               DP83869_C=
LK_DELAY_DEF);
> -               if (dp83869->rx_int_delay > delay_entries) {
> -                       dp83869->rx_int_delay =3D DP83869_CLK_DELAY_DEF;
> -                       pr_debug("rx-internal-delay-ps not set/invalid, d=
efault to %ups\n",
> -                                dp83869_internal_delay[dp83869->rx_int_d=
elay]);
> +               dp83869->rx_int_delay =3D ofnode_read_u32_default(node,
> +                       "rx-internal-delay-ps", DP83869_CLK_DELAY_DEFAULT=
);
> +               if (dp83869->rx_int_delay > DP83869_CLK_DELAY_MAX ||
> +                   dp83869->rx_int_delay < DP83869_CLK_DELAY_MIN ||
> +                   dp83869->rx_int_delay % DP83869_CLK_DELAY_STEP) {
> +                       dp83869->rx_int_delay =3D DP83869_CLK_DELAY_DEFAU=
LT;
> +                       pr_warn("rx-internal-delay-ps not set/invalid, de=
fault"
> +                               " to %ups\n", DP83869_CLK_DELAY_DEFAULT);
>                 }
>
> -               dp83869->rx_int_delay =3D dp83869_internal_delay[dp83869-=
>rx_int_delay];
> +               dp83869->rx_int_delay =3D
> +                       (dp83869->rx_int_delay - DP83869_CLK_DELAY_STEP)
> +                       / DP83869_CLK_DELAY_STEP;
>         }
>
> -       /* TX delay *must* be specified if internal delay of RX is used. =
*/
> +       /* TX delay *must* be specified if internal delay of TX is used. =
*/
>         if (phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_ID ||
>             phydev->interface =3D=3D PHY_INTERFACE_MODE_RGMII_TXID) {
> -               dp83869->tx_int_delay =3D ofnode_read_u32_default(node, "=
tx-internal-delay-ps",
> -                                                               DP83869_C=
LK_DELAY_DEF);
> -               if (dp83869->tx_int_delay > delay_entries) {
> -                       dp83869->tx_int_delay =3D DP83869_CLK_DELAY_DEF;
> -                       pr_debug("tx-internal-delay-ps not set/invalid, d=
efault to %ups\n",
> -                                dp83869_internal_delay[dp83869->tx_int_d=
elay]);
> +               dp83869->tx_int_delay =3D ofnode_read_u32_default(node,
> +                       "tx-internal-delay-ps", DP83869_CLK_DELAY_DEFAULT=
);
> +               if (dp83869->tx_int_delay > DP83869_CLK_DELAY_MAX ||
> +                   dp83869->tx_int_delay < DP83869_CLK_DELAY_MIN ||
> +                   dp83869->tx_int_delay % DP83869_CLK_DELAY_STEP) {
> +                       dp83869->tx_int_delay =3D DP83869_CLK_DELAY_DEFAU=
LT;
> +                       pr_warn("tx-internal-delay-ps not set/invalid, de=
fault"
> +                               " to %ups\n", DP83869_CLK_DELAY_DEFAULT);
>                 }
>
> -               dp83869->tx_int_delay =3D dp83869_internal_delay[dp83869-=
>tx_int_delay];
> +               dp83869->tx_int_delay =3D
> +                       (dp83869->tx_int_delay - DP83869_CLK_DELAY_STEP)
> +                       / DP83869_CLK_DELAY_STEP;
>         }
>
>         return 0;
> --
> 2.30.2
>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
