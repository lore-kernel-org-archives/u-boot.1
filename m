Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A7C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 10:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 144C087A4E;
	Thu, 14 Dec 2023 11:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HvPkcLMe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8338687A56; Thu, 14 Dec 2023 11:33:01 +0100 (CET)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F8E878AA
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 11:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ca5b616de0so224750a12.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 02:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702549977; x=1703154777; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n5vU2XMTk7CRW+Mb+MJUFMR5+S0dQKsGpZ2eJxVwIJM=;
 b=HvPkcLMe6JopZV/Er8P/RvYKlWL5G69GeglAqDjyv4deFQRcNHszSXysTdN/aZKKw/
 8TWxaJUKRgJYPeLG9JIXturZZL37p9gXBNrTNB77G3vxx6609hqGv04NhsWH4DW1ZEsV
 d31lA5P5sXZXR08kI3Y2vFmXCMhdY8nLaZSA4Wvjtqh0aQrNq+VWB9cybNE2wkuofCvS
 MgpJwj/WT38PnBDTktZ1XlsiGswp058DhHy+5cnPc1U1584PVKn5y74rCh8hNFbRz0fE
 Q8hAmmk8oVJa/83wSH2YKhrCt1cTI/aPvjRYDcGLFmHt9CwG8VzvYwgbMrp1CODipSNZ
 MnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702549977; x=1703154777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n5vU2XMTk7CRW+Mb+MJUFMR5+S0dQKsGpZ2eJxVwIJM=;
 b=w++zQWQJE3TrilndrtNDWIoM0/vI1ypqyTvSgk1yEsjSIozF4cS9tGoaY232pNCLvf
 LGe9u0bC/1OIZ5gpHC8Ef0MnAsaxPV3BJYBkL9s9Jlm4SImCDKv50fQnP+fAM8L5w+Ml
 oY3NCYdeIvqkB0Si2Zo8ZnP0SBxIfJOIdSq9T8dxQQ16xaqh9fdu46GXLCVS5cmAHUDc
 dtw5+vCNnzFqNHmy2MRWXzDfqsG8qG+TPt16KJJgOSKn/bSapOSCW6Y89MOCMkR3mWtw
 w07x1/9IY/xxhUNLxVcCybOs0rb7+ncK0pXIb4CmbJSLVJOV7mEBqjTRYgzp8qDQJpeh
 9DsQ==
X-Gm-Message-State: AOJu0YwKXKkRzYzsBiJgU0dxZ/Ga72qZKYh/fkN7fOKE/DtAFrhBWTGT
 N4V5+A29mRVeBvIqYGveSZjgjcaRjxHtSH9a0qs=
X-Google-Smtp-Source: AGHT+IGfWUrkOJBHwsKkxhfjNsmo0NhUITFZAXFxY2Gbx2zlQ0+yU321vm09L42H278bD8DnVAldGzGZbhjhdBp1JfY=
X-Received: by 2002:a05:6a21:328b:b0:187:ccb6:ddf1 with SMTP id
 yt11-20020a056a21328b00b00187ccb6ddf1mr21474635pzb.0.1702549977628; Thu, 14
 Dec 2023 02:32:57 -0800 (PST)
MIME-Version: 1.0
References: <20231104163243.117404-1-marex@denx.de>
 <20231104163243.117404-2-marex@denx.de>
In-Reply-To: <20231104163243.117404-2-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Dec 2023 07:32:46 -0300
Message-ID: <CAOMZO5A6unCOGn8FHinc63_9=915zAAzO2z4-ay6wZZ-se4D4A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: imx8mp: Enable TCP, IPv6,
 wget on DH i.MX8MP DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Nov 4, 2023 at 1:32=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable support for TCP protocol, wget, and IPv6 on this platform.
> The former two allow users download payload into the U-Boot from
> a web server, which may be more convenient or easier to set up
> than TFTP server. The later is enabled to future proof the IP
> stack on this platform.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot-imx next, thanks.
