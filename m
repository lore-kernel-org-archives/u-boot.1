Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304AC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A4482162;
	Mon, 12 May 2025 23:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPJgFVNz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7012F80C83; Mon, 12 May 2025 23:51:42 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660A6829CD
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-30db1bd3bddso46979831fa.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747086700; x=1747691500; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WVcMUSDG5kslXYsrehFoaGOWUcd9jOGBgvWnZPMKqXA=;
 b=jPJgFVNzkp7WksCg6+HCc3zYFW3s2y5Q45Kto1Nu520j2vACDUdOYcU2aMRMgC6vnI
 u1r/hB+/68Hxf/qGMLxpqrP8YAfW/nS5BwHVO0ZSBuuMtYQv35LjQ4tzU9HAnYCxft8i
 vpopuleYAkxIL6a42zxU91l8vM2LK49BOYLRCaUXrfciu6jqPkreUCosmj1+Cj39VqBz
 ettdvMt7G5C+7hUweUhUN8reTyFUAKiZ63vuKWPTE7RezZCQ3dFw2MHCO/UMwFohYCYu
 M5htvKc3S9WamWemM1mTkeLeK6tjiKe+qIq6Hn4ZttVglk2efYfRAjbBKrmcrCsCrimL
 xAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086700; x=1747691500;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVcMUSDG5kslXYsrehFoaGOWUcd9jOGBgvWnZPMKqXA=;
 b=ZPKvtK3fx8q9oWdf5rnfeiY89cXo7vUPDh4/z8h6GeLXc1FYnssxyV4gbr0GIM6Se+
 2hvY6iYYAEPV6LOihj/jqARaWWGp4BCX3en5JEvn9UEzSdHzV2uFPW0DSpy5ityGRMe2
 UFFk+yZIrt83o4ZgiBofm3swqBg4ZANv7pjE2RaHAuUb4zkPe28RqNgTLeVb0r5BJ5Vj
 0sRtE2ng1nwj15xh5mseWBPdWehknZHeJZLoYDA5gfLrgPqGHXL4UyaPYjBouPtsXjrG
 XfJxGNzj5ZdvSjhx97/jcv4ZbnxOlMhc80MNGdH9G5DHM2I2+nn89ePSBAlkEwDATkgZ
 klVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtZmVMKpyJBfQB6023E6iX8kIlUGg9cyLDTJLVVdXOGi92zPzNS0me0pTo2Yde/sllzOOaG+0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2lAztRb0EPkK4fnMtl6qMSTH1X+Zesc/KqIy5DE8jA6LYj3wp
 a0M7GSxlzisI+Jc0AAJrWffQg+sPOf0ACHyWGPA/HIgwzDrwnQqND8j1O5cgm6pDUaSu7JMdaTb
 cNe3Jfg22qfsOiocAwoqyo4vc6bzYJA==
X-Gm-Gg: ASbGncsvfGgMGOZLu51ZYt1uUAEa36YouHE5MEWHP9xs+6c0SWX4iZCZTEhSbwLmpRj
 wP18PoG0OlyJoXHdF+pigRanj1uxEymjYZ3x+x4+tLnGFag/WHHtFkFgH+89rRTt9QsoVB03WHL
 PdIVGHcF0x51f5LqFIb9VsxDpZJb4gAB7pJfxHWhaQS6jr0NLyofleayA0OIEfNxz0
X-Google-Smtp-Source: AGHT+IFPTyl/FWJNNbgmb/EdMQxTs0Axar/JDwkbr7hH7qrgIBQBDt/ifzfHIZ3xkLPNSPQSKeln7ciIN5cIyNWnY/s=
X-Received: by 2002:a2e:a10f:0:b0:30b:b132:43e5 with SMTP id
 38308e7fff4ca-326c45dd34bmr64217861fa.19.1747086699567; Mon, 12 May 2025
 14:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250507083625.6195-1-dullfire.ref@yahoo.com>
 <20250507083625.6195-1-dullfire@yahoo.com>
In-Reply-To: <20250507083625.6195-1-dullfire@yahoo.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 12 May 2025 18:51:28 -0300
X-Gm-Features: AX0GCFuLTGYB-lLe5Xs3Pe-wZAoTJ0qR4Yt5WKWNQH1HkesLvR90b6WlIpaO-yQ
Message-ID: <CAOMZO5ALrt_3mLsizfww7vuvoWSoZBRMnfRju8B+irX538yWdw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Add FlexSPI support for i.MX RT1170
To: Jonathan Currier <dullfire@yahoo.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>, 
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, 
 Frank Li <Frank.Li@nxp.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Mark Brown <broonie@kernel.org>, u-boot@lists.denx.de
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

On Wed, May 7, 2025 at 5:36=E2=80=AFAM Jonathan Currier <dullfire@yahoo.com=
> wrote:
>
> The nxp_fspi driver is missing some per-device quirks that are needed
> for imxrt1170 support.
>
> Fortunately, linux (where the driver originated) has since added support
> for these qirks.
>
> This series cherry-picks the linux commit, then adds the imxrt1170
> usage of the quirks.
>
> I believe Jesse Taube is also working on this problem for the
> i.mxrt1050, however the patches I saw were quite a bit different, thus
> this RFC.
>
>
> Changes in v2:
> - Rebased to latest master
> - Seperated devicetree and binds to their own patch
> - Included imxrt1170-evk_defconfig changes missing in v1

Applied all, thanks.
