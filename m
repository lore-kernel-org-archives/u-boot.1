Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED95BE7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77379801F5;
	Fri, 10 Jan 2025 19:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pyf0LNbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F00A78036B; Fri, 10 Jan 2025 19:53:49 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7843800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 19:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-30219437e63so32601271fa.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 10:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736535227; x=1737140027; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nfcXsEtIqVb4f3IAJaoiZaQr/oizd+cj4AQVa0oY7lw=;
 b=Pyf0LNbr7KdtAnsX9ZTXYX3Tk2jB/UBQlcQKAbtdtlr56j1fKxqVbZrwOS42gcRFdt
 6+zUdKLqXomFzNwGlflwvN3D4WH0Lg92OFtojEM+UHDW3Pf6qLKxwWSzrSFu7lMQlRJh
 Fw0Igw/JOTk9Tlp23uXPyofNFH2YIU3hqk4IfB3fdoOicXYkHkgfMQP/QyhFPqJovcUG
 axl32Ox58IPV19XJloMtFHs3EEOpPQID/vSDxB6bxBCaE0KHNirwNkSnquMi6h4rIZ5n
 e4TQou7GlBp9contEoV1TqoAJjRDfJUe8hgUHCOBWWERl4feb/KiqTRrSb/8UAMgsety
 QlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736535227; x=1737140027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfcXsEtIqVb4f3IAJaoiZaQr/oizd+cj4AQVa0oY7lw=;
 b=t2GGPPspGi2kPSldLHsx1gILafzQ9wGZXEjZhlHx3ehGo1iI32Z8sIT2qMnvCzyZ9V
 ifApQwAWOZCHkhs4VhrFA94Ryl01zFaoo5gE9to4ZRNJhRwQWso5wopEF+cpYeEt1ir3
 CVHzd2JwOQAFgPIVzkSZMniCxvs0h/ooRjw7iQF3oZh+/F5hmq3do21Ogz/CAo0Ep26z
 XIejeUj5uwZhHBil/IJTzSBV7iuwgTtjI2sd7r5ABHz3AWlOGOSVa2CsJ6rsks/CJPKa
 xAXUV2J4x0mJqCMvaxD1T5P35WcqJigjiq/XM0Yx86unAlHqyTT0cPJjjoM4MYxR1Oc7
 JXDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpaoPIqmKUy7i8niaLyazDMRXjic3aGnqs2C26JXjVeT8dEC0ZC23bUHWrB15We4vkRBLDuJk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxjtfe83XLCpqL6UC8sK8wvGdTt3T8Vqyg2OQupvH+J0w8fFAvl
 HGc2gLNYyyEVA0dn/WASXl0FzDz+9CAWuFjz1/8ScP8AfZC8Bpx3ixmHEosna/vcYWXuZoqMRuZ
 BO98RZa/jNSACoYSFYGJVaX9tGuo=
X-Gm-Gg: ASbGncsA7zQwI+kcBkps6Zd7Otq18pKpZ5ICVTGf94cYlSleYiVrkYUUONcscmifBKT
 REK49npMLzbuW5Vqzd8j6KC4XrD9Y5Anm6auLIniNVkFVkixO2+PooTqu+1GXzYtjuq4wKA==
X-Google-Smtp-Source: AGHT+IFOa7MC9qD32rXW9w1RrJiWD1sS9TuNy/wjJieiPLGwBls9GN9Py9V3jjhZc/I1LqhkM8zbRxZGlANk8VdEikY=
X-Received: by 2002:a05:651c:1505:b0:2ff:b8f5:5a17 with SMTP id
 38308e7fff4ca-305fedd0bd4mr25449491fa.5.1736535226793; Fri, 10 Jan 2025
 10:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
 <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-13-d2c0acea6feb@bootlin.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 10 Jan 2025 15:53:35 -0300
X-Gm-Features: AbW1kvbXbPy6X9q_ZCHizZNKFOIdvBTjSiuRwuCWH1EuxBC6p1Cz4VohAKUwsx0
Message-ID: <CAOMZO5B2K64cc1v3yn26fXqHtEcsMf+eSj_Smm_vAr5shzfboQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] imx8mp_evk: Enable display support
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
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

Hi Peng,

On Fri, Jan 10, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> There is now support for the display pipeline using one LCD interface,
> the LDB bridge and of course the related media power domain controls.
>
> This is untested as I do not have the EVK but should be enough to use
> the display, using bmp, lcdputs and co. For console-like commands, it
> might be also needed to enable the VIDEO_CONSOLE explicitly using:
>
>      setenv stdout serial,vidconsole0

I have access to an imx8mp-evk but don't have an LVDS panel to test.

Could you please test this series on an imx8mp-evk + LVDS setup?

Thanks
