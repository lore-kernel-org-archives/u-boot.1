Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F97D12D69
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0AB083FC6;
	Wed,  3 Dec 2025 15:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BB8dzGhE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496FD83FD3; Wed,  3 Dec 2025 15:27:54 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E3A83F9A
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5957e017378so7911065e87.3
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764772071; x=1765376871; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2ykHgeEuz/Rgyf2Hdu0FCT4GBqIVuK9Na1U97iizjk=;
 b=BB8dzGhEHzhdOeauEWpLu6TdFldf+28J61aCnvWy6QDFvHZc2Gypf+0M44vAvVoc01
 ohmiwwMz0LmKxqwc00A4GQft7lVzzjvuY12If2K30a7pMPYRkPKEuDYqjHaNs6g6GuM9
 +OZOKGVysf0KijCKirrVZGdWOO7obz3hZ/+Ao3MzusilVeomZSJjiV2/kSWEmSe8qtDx
 JFqQ3uV1knZvnO4hpBTWRAxN7JkJnY13uDefAsoXLyCssrPSyRXQ2Impu/1F9TLd5sI/
 eBubfF8lqmh0jbs5pilY8eSKQ3Tk9lAdpIS0TvcE88uUjkgQJjnICphqJJC1QqRCRNFG
 XfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764772071; x=1765376871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b2ykHgeEuz/Rgyf2Hdu0FCT4GBqIVuK9Na1U97iizjk=;
 b=b9zIoAGa+0WWwbZoSUErB4uSna/Gx/9eXqlNxEs/uS+I8ioOfyl34lFDyYGcXmK6fh
 jxtP73ntA+0rz/siUH8Zrsgdrqjb5HUT2j4Ayc/WTN18Iq47ggSDnazP0lXWV3dxAkV1
 pA94eAKfQjUyIqcaOVXRkpdbmbqllrWKsKW+O68QlafwT7SfHEZ444JIGfVLeHJeY7sv
 v34sn5sQggpkhQcrwuyv4VnsvU2KiyDl57iK9/IqKEv8H58GyqQGn2POCciUb9seQ/c5
 gXZudhc7q++yyhRPF+NY7i2Ruxpic8LDMArwyvNqGdFmpxHCZB7a0fkRj5iz0rkHLXXH
 +ndw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWorWu4PLw403Xm+t0yG/FKYh0iw+cvSttkJ0y2a01sZ/XesCTxO7k0FOJph85ISpXjZRLqRHo=@lists.denx.de
X-Gm-Message-State: AOJu0YwB0+T0vi+BdUV7wq3aczD1INwgFhLJzOJi91DUHbhvN52uTOSU
 fnw6DncFF97rjywVJ6bPsN1Q0MVRzKyGiPgKqAsxsb9hYCUTvO3DP1Nbs15L/+TnwsA4gJbSIWN
 Q0WJjZ0/rjMXloq3YyMm13cNBw9nAIP4=
X-Gm-Gg: ASbGncs8JHay+xLGF/Uot9uagx3xMtkI7qEcG1ibmL1pMcOUPcHyZaECrv3xEpvKdFq
 8JdByfNjMwwTORvIULN8O2AGqwr0ZNzObTX+mQoVFs/aEkto2YoPYdcZdMC7gnwXvOBWRdeaGFx
 GZVPYGJefrzdFCkwL+VdlPfpsj2STKtClKNORdwXYNlk3h7Pck1cJDe75VXTVFhLwhFSICguQ35
 zZMBvHbg44XFbOH2k4VlJN3sP8cyYWtqOXYdvFxZH7wI9GfBwfsdr6DAZsPY0xZ5jOpe0lUouvN
 NvJ3KOTlm7YDRzECBEnqzxoV2NQ=
X-Google-Smtp-Source: AGHT+IE6cer9vmCzLypCTWD0L9kaCiuIa01AA3lPESCpQuHaRikwiXxu5giJv9YhApHIJOC/LHynLa8EvDbFAU8rI20=
X-Received: by 2002:a05:6512:b96:b0:592:f2ac:779f with SMTP id
 2adb3069b0e04-597d3f4f69dmr1010439e87.18.1764772071345; Wed, 03 Dec 2025
 06:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
In-Reply-To: <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Dec 2025 11:27:39 -0300
X-Gm-Features: AWmQ_bmJJlI2V_mQzjbfXUFgYbMjz-cTW2ZyX7J_EqYhoqqEyHs8YLdJ3pf-LyM
Message-ID: <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
To: Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Francesco Valla <francesco@valla.it>, 
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
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

On Tue, Dec 2, 2025 at 7:05=E2=80=AFAM Joseph Guo <qijian.guo@nxp.com> wrot=
e:

> +&usdhc2 {
> +       fsl,signal-voltage-switch-extra-delay-ms =3D <8>;

Why does U-Boot need this property? It doesn't exist in Linux,

> +};
> +
> +&fec {
> +       compatible =3D "fsl,imx91-fec", "fsl,imx93-fec", "fsl,imx8mq-fec"=
;
> +       phy-reset-gpios =3D <&pcal6524 16 GPIO_ACTIVE_LOW>;
> +       phy-reset-duration =3D <15>;
> +       phy-reset-post-delay =3D <100>;

Using phy-reset-gpios is considered deprecated.

The PHY reset GPIO should be described inside the MDIO node.

> +&ethphy1 {
> +       reset-gpios =3D <&pcal6524 15 GPIO_ACTIVE_LOW>;
> +       reset-assert-us =3D <15000>;
> +       reset-deassert-us =3D <100000>;

Why is this inside the u-boot.dtsi instead of the main dts?


> +#define CFG_SYS_SDRAM_BASE     0x80000000
> +#define PHYS_SDRAM             0x80000000
> +#define PHYS_SDRAM_SIZE                0x80000000 /* 2GB DDR */

What about:

#define PHYS_SDRAM_SIZE   SIZE_2GB
