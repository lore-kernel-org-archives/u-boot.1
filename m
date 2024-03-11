Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DFFC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18D7087EB2;
	Mon, 11 Mar 2024 14:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hy4dABaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B76E87F04; Mon, 11 Mar 2024 14:10:06 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888DD87D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dd3c6c8dbbso6615125ad.1
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710162599; x=1710767399; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A38HzNwSz/oJREpK4+7m/94kkl4X4allw06/mQFvIwU=;
 b=hy4dABaw1HMGgznIrbEmjfQkcThjspyh0in7Ycg45n5OyB9zVZ3Y+DcCh82z6aOKjJ
 C+0wPMU/XYp7FMPHSzzwtZm2eIq8xkXkBz0ugKsmp8jHWxk7n1HmzlQ3NqaYLk6OyeWA
 AM6tVHLvXPJAINvk9aVZxjpOrSrE/tqrgSx8aomZV2gAkQZ1I7qOltF10b/hTno0Bd4w
 xP+Xq6o36YecGJOiyCP2Mpo+QPybo886IV0Ykpa3Owry6gQMawEusJKTSx4NlK8oIvUc
 AdND1zzY50u5rj49Dte+gBqk9KZ+hOhFIdf3OxgHPThMSuvNFqQX8btyepFu1bNKzcEE
 G9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710162599; x=1710767399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A38HzNwSz/oJREpK4+7m/94kkl4X4allw06/mQFvIwU=;
 b=ZcfMfAhD8pv2iAeiAp5rJJL1hq3KLsxoRtZntIJ0bG/uzl2INd4b/m7Vc9Q8LuBYgZ
 P4OBo8me0aeh7rpbnMOeoq2Nbom0szGCtazQi9rour57ECyzArOCf69NfA1cn6V4+mTF
 C5ZKasiOVvlpM8kO8OGyaJyW9COeMu22R6oRijtLL6aUyvroPNH+ueihzwMjBQnBNgdr
 AfXCrkc1d4Wcl1dCxfWNl1UFp09huanlu9WcuYmfWeJc4BC4Km/x06k6LcfLlWBGDkNm
 tWpUnDZDLZty7W5WDBMOIco15psEXOkNEcattlSoolYIBnmRS9BAg7PFSzRgkuplftrA
 zz6w==
X-Gm-Message-State: AOJu0Yyo0AR0kWGy6DNeeIH8dwbzAg8d96kpUSWteac3kheB4g9RZSmz
 8Ytt60hg4GDiMBmhqKeZqo3P3R+Ke6zESCbizfZiwCswNAgaONfA68i5t/LqfL3vBgNNzgfC0a1
 0uPbgDqvrTvKoIERDHI8xWu1J5Dc=
X-Google-Smtp-Source: AGHT+IG6SNiV6rqmbUSDYj7LsSXb1RFvHeEvCB+Aq3lsrXyZ0wA2cDCtTRs+bC/3zV5L3xoT3SgQX6Cqk/arEUDiBwY=
X-Received: by 2002:a17:90a:e612:b0:29b:cc5a:c00a with SMTP id
 j18-20020a17090ae61200b0029bcc5ac00amr4289299pjy.3.1710162598881; Mon, 11 Mar
 2024 06:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240310165903.69275-1-aford173@gmail.com>
In-Reply-To: <20240310165903.69275-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 11 Mar 2024 10:09:47 -0300
Message-ID: <CAOMZO5COVckpMs5RYTWLw=8LJ7r5jTTi_XSAsbgVX8Pse_xZCg@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mp-beacon-kit: Resync DTS with Linux 6.8
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com, 
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tim Harvey <tharvey@gateworks.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
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

On Sun, Mar 10, 2024 at 1:59=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The device tree has evolved over time, so re-sync.  This also
> partial reverts one change on the PCIe, because U-Boot doesn't
> have a proper driver.  However, since the clock is configured
> to generate a 100MHz reference clock by default, a proper driver
> isn't really necessary.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
