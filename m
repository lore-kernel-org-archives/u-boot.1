Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66BD108E1DC
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 10:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078D283BC8;
	Thu, 19 Mar 2026 11:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ec7cBuRM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F59E83F00; Thu, 19 Mar 2026 11:30:45 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70FA683BC7
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 11:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b97e5956208so80071466b.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 03:30:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773916243; cv=none;
 d=google.com; s=arc-20240605;
 b=k3ucRmUHnFC1NqPAYmcC6XZKv9Fb0MXq+XwC4O9wUQhDtSTVLyKyUItZZtcEus+Ncb
 X24Zp0nA5lTL/hqLmdTsOlPsrrJad46Qo1FQG6iSdcJa0zufDYPPiYWMM/uGlcPGg/f3
 R/g9oovH1iu2Td0R0uL+cEfneqtF5bY6zFq5Kn1O7z/tZoXTz3zEcJAELhBMBnhowoYU
 33s5q/R1X89JDYGHhzqZ0p8Tt0U0YUJJOgr2ig62mdr4vcQpmKOBl9shWqacZQWXS4P8
 dWMfXb6D4e8jluYI+ls44g5jgdcwIicc+orcET5O5ByxXqIX6Zsuk4fVEPDncBCL8b4g
 0EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KV0BVENboFgXsdBTw8Zu3BsiiNwEQzGD0KwxH3aZOl8=;
 fh=xngVyBwTwU3QOXGXepwpodf7G7hXDDZApcpqxq9qTHg=;
 b=TvmCHHvE7ytjdJfNJuRD4oyUljFjIJh+1dA6xaIvaakIUTJ/J1+Pax2tAJCYcinLup
 IQM+SrXB4TQWPV7Vg6dC66GxqgHdcnR81dYdyKQuu34Q8N1MOoe3fD8cnz9V4xHoDNZm
 ZeZEoKL+xClpYU+W8yeOUsH2wVt4Xhem3gstcXV93YVXJW+jRuPBy+/PDHTQaa5QwMle
 1VCjqSXZwC6oO9lv9cCqbT2WDaWDSZSLHMlehmThRBcuZwpAl1Axxo644mpQHq1cE6Se
 T3QBKFOeNqqJjRiJaNNL5t8El0yK9jmR5Hdpcao5juv2jMxvTzUN5O+McFqI2nwVHbyh
 wGtA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773916243; x=1774521043;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KV0BVENboFgXsdBTw8Zu3BsiiNwEQzGD0KwxH3aZOl8=;
 b=Ec7cBuRM226MLXhtE1zAIT+Z2P8UxKQH5j0L09PpZJgrOhkQkjN561111b3dxRMnt8
 kpzSgN9vOHnZ0aKdPA/ZclTGuBF6VPK2hZg+R50njEVitqGVeFJpSNl+By2bAUuY2oaa
 04Hpwh9CWzEfkdKbAFsOuVO044SdK/sTXnQHcgFygMPsiR0/bgp5/yyrGl17U+K4yXxw
 cKbf8RBdRE4GSa/7S48lpBuQXhURP+2FMLID8K2nihY0SFPwtwf28BZ63DSwvGP02ago
 T494cXk4Ljq59H1FKDPtaZ6kLZ2SKKB7OOgX0nfk/FazHxG2OF4R1k5e1v4CngRZJKfD
 y+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773916243; x=1774521043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KV0BVENboFgXsdBTw8Zu3BsiiNwEQzGD0KwxH3aZOl8=;
 b=JmDXm/mQE3sI4gF4WQ1SABPTzWv3cUmh+k2qylRQJYpxo/q6ubjiEUqE3o8rD9+sx2
 prCKPefPz3esu9F5OabPmFO2yLaF5GYuDY4So6498gHKKJMgU4ZPEPi551/b6mPgFNHy
 DM6OMLun/D9prNg1DJ21fNBo+y6P+KbxzlDKuOyMew5037ZOzZe02ychgduMzYgEJ/Rk
 NyStAu6khy6B7WqGhUfMfG83OElsoZKreET2dl2BQ4jLnkpgxgyVIky7l8NOBr2U8V6r
 GBfdSRjoz9vdpT+d7st+bbCa+pQuMlKyfVMNpgEBSo2Kr/ENII/N7PBcD/SgeYae3ouF
 vnQg==
X-Gm-Message-State: AOJu0YxganKfmsJ+hKxdOV6nH0P9GnnmNsuOCYQpfmoEssFTbHBqOQxN
 6gY/3ErU5Ks/NybRadlk2sUA3n5+1zn9Lox/PhInpF9PKmpC57v/wQyYQWMLwYo1qces/QlQBea
 wTpg6hJnevb2XfJPbItfJD86u6oONau1gGTKQjARB8w==
X-Gm-Gg: ATEYQzz7KejZA3GdK7eNIfRqPhMeJw19LiC5D6xKTqvDP7qt1303S7NhIMJmag0dgSh
 O8aNCIgDJvcLUu+WA+FStIExeBpZAJsEddd7Wy9mFHGLVVyTZNxIapdhhdwU89wb7U9elgxtB2a
 DhVQ9F+RcijkL13Bx0YeugsYvmqYHVJLkLci132ItUW1hZUkRqexByMJPzIEvrpgs8Mxg4nHdOF
 7c3j/QQMPxJj8Sokj4xA/7NwEatWDj04f+ydFcoSil/PBE6hTIrq23qvD23LS/fUIrBc2gYnvis
 LrzfdCRymsNZhACHByroQIwQNxjCIN8QqWeiE8QBDHyqG+aj5YRiItx+boWOsBsGTCGVDIDg2WU
 Bu+mEeuZfKIZLKiRsRG3Xrnmr6g==
X-Received: by 2002:a17:907:84d:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b97f4a32186mr414705166b.56.1773916242686; Thu, 19 Mar 2026
 03:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-1-08c085d6b15d@oss.qualcomm.com>
In-Reply-To: <20260319-ufs_probe_clk-v1-1-08c085d6b15d@oss.qualcomm.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Mar 2026 11:30:35 +0100
X-Gm-Features: AaiRm50LPVJb_h7RlNUjdHhwnQ3AMTAYkZbcGyvbyX99wmupCf0LnLV3ct_UKz8
Message-ID: <CAEHHSvaNF7Fzpkc8DC7eC7v=MLH0uzw70CU03_NTZLLw8BaypQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] clk: qcom: clk-stub: Add compatibles for
 QCS615/SA8775P/SC7280
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Le jeu. 19 mars 2026 =C3=A0 10:37, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> a =C3=A9crit :
>
> Add RPMH clock compatible strings for QCS615, SA8775P, and SC7280
> SoCs to enable clock framework support on these platforms.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/clk/clk-stub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 117266ac778..6a178976cc3 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -49,7 +49,10 @@ static struct clk_ops stub_clk_ops =3D {
>  };
>
>  static const struct udevice_id stub_clk_ids[] =3D {
> +       { .compatible =3D "qcom,qcs615-rpmh-clk" },
>         { .compatible =3D "qcom,rpmcc" },
> +       { .compatible =3D "qcom,sa8775p-rpmh-clk" },
> +       { .compatible =3D "qcom,sc7280-rpmh-clk" },

This one already exist, so it is a duplicate. Drop it. Also update
commit message accordingly.
Unless you are trying to sort the compatible strings, in which case
you're missing "qcom,sc7180-rpmh-clk", and the sorting should be done
in a separate commit beforehand.

Cheers
Julien

>         { .compatible =3D "qcom,sdm670-rpmh-clk" },
>         { .compatible =3D "qcom,sdm845-rpmh-clk" },
>         { .compatible =3D "qcom,sc7180-rpmh-clk" },
> @@ -69,4 +72,3 @@ U_BOOT_DRIVER(clk_stub) =3D {
>         .of_match =3D stub_clk_ids,
>         .flags =3D DM_FLAG_DEFAULT_PD_CTRL_OFF,
>  };
> -
>
> --
> 2.34.1
>
