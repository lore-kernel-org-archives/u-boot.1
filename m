Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC95D6CFA2
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 18:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9DF8397D;
	Thu, 22 Jan 2026 19:48:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gG1wbDVW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED5683A6A; Thu, 22 Jan 2026 19:48:09 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90BD680077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 19:48:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-385b9be0759so11527641fa.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 10:48:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769107684; cv=none;
 d=google.com; s=arc-20240605;
 b=fg6AyXXzG1OMD2s/2b2lkrEgFV2YMJVEil9RCBw2F9//m/C+nBuirjXT2UZaAycyWW
 hgh5buyu4AT85h/WimVFlZ3oqXRSummke4DQIavJtCe9i+8TPH0qhbOL/dodENghRttD
 70+PJaiuZhzqbri2sLfMHnerBwm5tl0J1f28CEcAsur2qCXJUsQIm+4l2p932kTEVWFN
 0fXP0MkAdOE7nLj4YmHvfN1EoBTbpxV/5QOJhHOL3exu6D/sWBYUiVW/MCXqVTiAYi2n
 lQRUNW3XE3BGzjiEWqR52uw36LxkoyGvUR6Cuf1lVBTFZlBSRkev86w2ekfraJA0ScFE
 N2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GS4NRNbWk5QNqzYgxz+0yHNYGDvdDTMUbC0EcxzCRMw=;
 fh=Rbg0/vmMBpKyz4/PdkuTW7qZ4LYeD5uU8zyq2ojUFF4=;
 b=AfnihfwCh0hBbKP3fmWTJJuUB1+DSDmalQzTJdxMho3LuCV2plMcMmXoDnlscrYOo3
 4/UuHgL9qivvODDDeZgoNyMbZoMa9hMXQ0PxwU1hVb1JqIabczp8Q1Q+TaPbi5r4qXHR
 F4y0Kk1I8DZkadaibDLZ15lYyYF1sT/A9pvsa0pXXVyw+BRcH9+2thfpdtzYjFLXm2tW
 M1nQMe+AzBMkg2NjCiuJvfaBky+EEj/8+LLbhPi7MQau0GkcpErjP6EaKvpf5f970iWa
 laWaTM6pKimGBlYLlY8hx61RQdP2YX9DQf8TpFdlpEnezmg9uuyChFRQCLJXUycILYm0
 BFpA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769107684; x=1769712484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GS4NRNbWk5QNqzYgxz+0yHNYGDvdDTMUbC0EcxzCRMw=;
 b=gG1wbDVWB0RGQ4TiCEINa2+iDAN3d9tR46e4PJF7+cfmkfxQjGHLaIG6i5vRR+x02l
 xaaFiojhvyCnTJVKy8lVywsizzUsmI+19mXHZUdS03zI3ktoiiS3Ckv5ZKELu4ucZa8/
 vmgYUmZCVmuHQzQC0QHfHwJDKQmknqFpwsmU+oY5oI+RDAgskwtn//OiQp36wZu+MVme
 IjKlwRAy5mwTrHt3s40KtF563V4saR5G6kfssW/ePkMpwx3rsXPeaZZiPPFnvs6OdVVZ
 lZF90fzSdgeIokMoa+8AmC9IYKOzlnlFQF4J+TVUXRyOoAngk2jF/+jdVANRXkK2cSL9
 /pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769107684; x=1769712484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GS4NRNbWk5QNqzYgxz+0yHNYGDvdDTMUbC0EcxzCRMw=;
 b=H0USNefL7c2X97VlzJax4V1cjjzxygcPv630seU53o5ilkKxmsYJsSz/XGmnqBJWwp
 vHz9MXRnfQNJm5m/LaD3KwYHqpIOyp3IWIKZBM9ZT7el3UCyYHrUSd7OpYeQOvDlKWwK
 vsgqMnipx1Uimio5XuvI6R8lSD9XJQqqpObSC1HAvT5kYyNcwO2ZtOpsYvaAyiopnzgm
 /AsAx9tjzY5mJJOR/jkEGcwbimgKjlK5bEP7iCUT/cmPeUUiKt9w1nNYiqhYpFQ+n6BN
 3Xm8wwhBaMlpCMyr+7YiRaR11FWbVsLK1WOftCrDuHb9OgaNIkM9Onq5QF02Fnp7Er3X
 yYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIwIA8vUxbn2lmGd6eO+Bj1rJtI3BMupIfgSX5gkAznIfoJ5mvIG+6CDRNANJ0mVZFbRbPI0M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywa554kT2oF+XVOaNA5o14xqP+M+EjJ6iKDl8YbGsknc9qD9Izs
 RQujLAb3Xa7iFQ2ePVluGqJzBmrLRGEJCZbSvOJvP+Ho43LHImkQoy7MuanrclKje1xAd+Qi75H
 NsLMg4mEfWCDWRpIYQLyymeUjD9fNlbw=
X-Gm-Gg: AZuq6aKBWBXq+YXnR3izUILUstvtJ4BybLbb2Mo55qTMYWBdMXKNmzvAMKPiF7dyFz4
 D6TaRpz+oMmfv1Ek5lZKW6PMpzJvAeAibKS7TxK+lxylPFSbLyPPKngm9jtIarvdosaVmOzCzEM
 cEDs1p2LTyzsLSkqRHlp0tLClZUjU47j6YGXn82omAqEKvslLRV4BbKV+fFJstl8gutK/QAsj6j
 PFRzg8dFQswIVj4WL7xMVS0mAd6nMcjzyzzSKmGfTIa2PqAMwMk8oGqtPzJq1ONiBfQBLNODjX0
 ohrchUE2PBbVOFYi8NrwTCooZyE=
X-Received: by 2002:a2e:be27:0:b0:37a:34e2:88e7 with SMTP id
 38308e7fff4ca-385da028b39mr1013551fa.22.1769107683881; Thu, 22 Jan 2026
 10:48:03 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com>
 <CAOMZO5COTa3ykhF8XZyzmJ0QZNotK4USo0LrH0XBJLogatfXFQ@mail.gmail.com>
 <040e129c-44ca-4a59-828f-d37c6e41d3b2@mailbox.org>
 <20260122142323.GX3416603@bill-the-cat>
In-Reply-To: <20260122142323.GX3416603@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Jan 2026 15:47:52 -0300
X-Gm-Features: AZwV_QhihS7-pvnNkslgNUZ_LUda99W-KKBgXUBP9lPotsGm69se8ZhDYVerSkA
Message-ID: <CAOMZO5AZiBajXK1b6Mse9LPwHEzhJSM_-OcQs4BsnbXP3WzuxA@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Michal Simek <michal.simek@amd.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

Hi Tom and Marek,

On Thu, Jan 22, 2026 at 11:23=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:

> We did that, yes. I'm not sure what Fabio is running in to here..

Let me share more information with you.

The board I am working on is based on Rockchip RV1103 (ARMv7) and will
submit it upstream soon.

The board was booting fin last week. Yesterday, after rebasing it
against the top of the tree U-Boot, the board no longer boots.

The boot error is:

Missing DTB
spl_early_init() failed: -2
### ERROR ### Please RESET the board ###

After running "git bisect", I found Tom's commit 8b0ebe054bb3 ("arm:
Update linker scripts to ensure appended device tree is aligned") to
be the guilty one.

If I partially revert the arm/cpu/u-boot-spl.lds change, as shown
below, the board boots again:

--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -51,9 +51,9 @@ SECTIONS
                __rel_dyn_start =3D .;
                *(.rel*)
                __rel_dyn_end =3D .;
-               . =3D ALIGN(8);
        }

+       . =3D ALIGN(8);
        _image_binary_end =3D .;
        _end =3D .;

With Tom's commit applied (failing case), the spl/u-boot-spl.map looks
like this:

.rel.dyn        0x0000000000015cac        0x4
                0x0000000000015cac                __rel_dyn_start =3D .
 *(.rel*)
 .rel.iplt      0x0000000000015cac        0x0 arch/arm/cpu/armv7/start.o
                0x0000000000015cac                __rel_dyn_end =3D .
                0x0000000000015cb0                . =3D ALIGN (0x8)
 *fill*         0x0000000000015cac        0x4
                0x0000000000015cb0                _image_binary_end =3D .
                0x0000000000015cb0                _end =3D .

With the partial revert above (booting case):

.rel.dyn        0x0000000000015cac        0x0
                0x0000000000015cac                __rel_dyn_start =3D .
 *(.rel*)
 .rel.iplt      0x0000000000015cac        0x0 arch/arm/cpu/armv7/start.o
                0x0000000000015cac                __rel_dyn_end =3D .
                0x0000000000015cb0                . =3D ALIGN (0x8)
                0x0000000000015cb0                _image_binary_end =3D .
                0x0000000000015cb0                _end =3D .

Basically, in the good case, .rel.dyn is zero. In the failing case:
.rel.dyn is 0x4 and *fill* is 0x4 as well.

This change messes with dtb being found in SPL.

What would be a proper fix?

Thanks
