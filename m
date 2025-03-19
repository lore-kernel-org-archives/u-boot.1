Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68852C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 16:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928E181E47;
	Wed, 19 Mar 2025 17:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B3Nw/TIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A28D81E6C; Wed, 19 Mar 2025 17:15:10 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA3581E18
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 17:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5499659e669so7917715e87.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742400908; x=1743005708; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J+JdifLGDVRJwUkEulRc/7wSixbPlVH9y3lU5vErxc=;
 b=B3Nw/TIrOP83Y9+v0lJTv44x2nIqYAqMLL+1vFtyNvQPH/+I+CJStFcRe3Jxj5BhKA
 ALuJfkvfVzKmIFFM9p+OFdcuhpU8DWiC4wVOG5r4KqMGIqKRC2HmuG/TYXu/KHYc4u8P
 U+mGdttZZmrD2MAjorE++Gr7zdLPgMShmWCRhPTrE2iS3qdUsNXPnvgLKgz9LX6tCiGm
 Tbc1pE0V1VPVlBlXkn2l4TIAX6ZN4lS0HD0NLsmHnVIq1LyfuQLr11ydYY0qshOXDiQH
 529cDjwCFRZqHgvq6o5j2xqFREh/wUPO6d1h5A7ebqOP21T18qKnwcwN6IHqyeLNpexC
 rbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742400908; x=1743005708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8J+JdifLGDVRJwUkEulRc/7wSixbPlVH9y3lU5vErxc=;
 b=P9/E2df6pvYPcAuGd9F+lymmFxf62RFGl8VslHi2d05zBagB4BqkxFOo9an1+5dHz9
 Us3q5oYIfmhf2NHyd79gbXgeLPm6yeWDLdxMh6q62AvZvuhCXqzHgq/0SHWAXEnsSLEA
 R24FT8hEYbVZhkeMXFRZEnHKw3IJ7kB+odhBgdeyH5op04oidJ+/JgjR34R7MtgUvpqM
 au81Es/gOOHdkKuBWyn342YWnN4EEqdloMCKDFtD3YmNEVNjpnMsHjju4K23o4GiGFkt
 bXs12fg3slyyba7JuNtyGNgJ6DRjn9NfJffKrwAb48woynHe7sI+2C03IyEOR6wNofiK
 a+mw==
X-Gm-Message-State: AOJu0YxRngZlBDEi2x2BUH/E6VVYT8cSF0jhH+++ubpT99buCpunpcKH
 4blJp/LtjBQjsbdtpfMcuBz8fzYxjeQ6nIKPVbZe87i8O50QB4rjdoHrBUZWgsD184VHBdAXXR2
 bFmbyGYdNJvMwHp7SreTkaOA8cSY=
X-Gm-Gg: ASbGncskP0L/HajjI4GtIVf5xkrL4I/n8aqaK0w4mFyAh1Ic3qgvLluSr9g/VHMK2B1
 DWHKPLG8z55NzNioHw9rzDSH0Mq58MnSabnumyaeBEbgo1O1Hl2ab7C/mq35wVIKj7wWjxKPOMt
 HP+poxwXBN6+lN8Qd8DDoy/S5GKtGgD7ifH+oEId/YLN7sdhboWlnMPyKe7A==
X-Google-Smtp-Source: AGHT+IFs02BJv/w6ykj560TEsU6GAe1ktu7TcgQ+UIg5X42b8Msb40zIiCUHTZM6sHDiV/OW0JtqSvBwMs8rAf5oKUQ=
X-Received: by 2002:a05:6512:318c:b0:545:bb6:8e41 with SMTP id
 2adb3069b0e04-54acb22441fmr1311105e87.52.1742400907252; Wed, 19 Mar 2025
 09:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250318233849.587520-1-aford173@gmail.com>
 <20250318233849.587520-2-aford173@gmail.com>
In-Reply-To: <20250318233849.587520-2-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Mar 2025 13:14:55 -0300
X-Gm-Features: AQ5f1JoXSvzMcX_ZQHjs0LfLjGeTJSUmkbDVqJKtiPi1xhQQfaF7ZlmKp-ckw10
Message-ID: <CAOMZO5Ah3zG50Do_kGx=63RmX16hFrrgzsBk6Zgm6tQoB-VTLg@mail.gmail.com>
Subject: Re: [PATCH V3 01/10] clk: imx6q: Properly handle imx6qp ECSPI clk_sels
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Tim Harvey <tharvey@gateworks.com>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Peter Robinson <pbrobinson@gmail.com>
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

On Tue, Mar 18, 2025 at 8:42=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:

> +       if (of_machine_is_compatible("fsl,imx6qp")

Missing closing parenthesis.

> -       clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
> -              imx_clk_divider("ecspi_root", "pll3_60m", base + 0x38, 19,=
 6));
> +       if (of_machine_is_compatible("fsl,imx6qp")

Same here.
