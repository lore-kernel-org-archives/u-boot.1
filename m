Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F76CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7302483971;
	Tue,  4 Nov 2025 19:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iK81VzPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9296D83655; Tue,  4 Nov 2025 19:02:15 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676268003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-378d6fa5aebso58412861fa.2
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279333; x=1762884133; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLILA74UBSfoMRW/bTifKs91/CXjLdy9wRCCd7sPF4c=;
 b=iK81VzPat3yiOrs/cEDGtJr26A43yB51qTO6sVudeDr2C0aPZqHZKXj0S2JeUfsJYb
 U1wQcYhL1xPNFb7qrKxf7BtXRndC0PkTkFIh5wUtk1NAhBA4x4Av2nHTJiml/fCvH4iN
 iF25BcsjQVI1iZF5NwmM/pOq+EAi82RLpPxpqQoHU5x/pwqzKZHUg78vzAu74PlUsb+e
 Zl1g4thqjzx/pwAgoZs2wrSA837bjc8WMyYdgWSewmJYfR8UxuqBf/D8UXgq1n33oiLY
 KvFmUg5Hj2TrqgwXbExkL1h+l4Qeqxd9Q9TQTLnk6B9XZacFXcaEvlid0jEVphVZWyDY
 aNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279333; x=1762884133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DLILA74UBSfoMRW/bTifKs91/CXjLdy9wRCCd7sPF4c=;
 b=r73qOfnmbUEkKsxfsvT2nBk8stOvYQq9WalM58uZkq5c3IA8u47nBdBpnCfuPifJqN
 6B1PvP4epUQqFRu9tY+k3jk3H0iCe+B2ugSp7uKJRXpCj0jAfhS9Z9nyxeNy9RckJI8b
 jvgqTLU18RlY5nSAoCvpOq3V/BFrhAK9uBTcXJABrSaQoOnJhUALA8xJkY+l6D68KNiQ
 LflecCNdZhf6wFbOzbKqSpRoF5vDwNDmEXNPPigIlBHqHcFMXFWgmsMnVwcpqRkJXkWq
 zNFE5Bo5ELV3A6uoFn1BSIF15juORTjXw6mRcC0DkaFJbOMLquUtE+M1N3rG55VIWcCe
 A0lw==
X-Gm-Message-State: AOJu0YxGN1EM66Jk7Z1kFdzyWgUgLK7DyPsUpSVWXaGXmLFyVzJob44K
 pWQOm/xcUedLx4wjBvMYRRPmqGsemt8h8paL9NlNb32xAm8aL0i5CjrXri4O6l05LGSSVK3UU6U
 LVewpji287FhYsUrZme5VzVMwHqzYRuE=
X-Gm-Gg: ASbGncv3b3c2/GI5ImFOU2bOziUEXLpqCGkvazKetpn+O0sV7TvCXCjidW4n61RAWms
 AM8NXHaJyPYqIx19NDLUMQo+IP0QLtR5KiPlDQQmvTuhNMjcjxypbZNSbs0T4WW65511YeQ9Srj
 F+xzK8GsBWpk5LaK14IourtoN/uM9f4pBdUrYkdPTaOW/Itpxriiw4RtvnK8AHv12vP4Fckhk5D
 eMHc1vq28qISUzAtSSZiWev8bb6f6cCAtsJvFCCe0fU+tnup1sLEaZQVgNSG2GXnyvnVS6mK1vW
 MNA64dG0j8k96dRk
X-Google-Smtp-Source: AGHT+IF0ddukjMFdNInKthiHR2O2zyPO9P0d5g8pph5cZXYr64I/MX7P0MjJg5uu0VpKVs6evFZTC0zed0vQTc3Zjvo=
X-Received: by 2002:a2e:a9a4:0:b0:37a:44c7:73f9 with SMTP id
 38308e7fff4ca-37a5147b28amr610991fa.27.1762279332288; Tue, 04 Nov 2025
 10:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:01:59 -0300
X-Gm-Features: AWmQ_bkrnl0aceVl-vA3DGQHDObcRTfwWyKhg1nEVOtOhbmX6b0WPfxBHW2sy30
Message-ID: <CAOMZO5DQ00cUEOL=0kZj_npSLHnvevOyQMRq9wczHwFaa0gRNw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] Enable USB and ENETC on i.MX943 EVK
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Roger Quadros <rogerq@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Nov 2025 19:32:17 +0100
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

On Mon, Oct 27, 2025 at 11:47=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:

> Changes for v4:
>  - Add i.MX94-specific conditional compilation in PATCH 4.
>
> CI: https://github.com/u-boot/u-boot/pull/824/checks

Applied the series, thanks.
