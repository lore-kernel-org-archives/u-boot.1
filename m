Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54086CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:41:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1CBB8423A;
	Thu,  9 Oct 2025 21:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMTtJMME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 192928427F; Thu,  9 Oct 2025 21:41:45 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C28283C94
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57f1b88354eso1417588e87.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760038902; x=1760643702; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ZNqup2UyCEIQ+fXtU90pfIWTTzwIkJrs7zpdbAW+3g=;
 b=gMTtJMMEFfLz0RR3iM63llSDX1rzvwQ3+6wOiZ9y2bqn/Z8aH1pYynN6p2iov4t2PW
 eRL4H4gebUKV37Pm+7rZThL5uab9kEa6Vu2ka3L3JjWiPL/2awgof29S5Bh/ZFBeoBw/
 gKlUlY6RVcU/TUEIwFbrDToNxDdxWkq276HeFpsdiIDhZnDSmIfJqq2WT4+07LkFzY5C
 wALzGBvOtpY1WdslPX1RoP87G8I9K9CThPNHcmtV6moNf+Dw6oW9PdgzHLwti3m5H/P+
 9KHywkSIKKnuNBZ1y/q8enDpowRveG7YpN6Zoj2v1MRTyK34u3In+jAKSfKlYjH5tZtz
 cpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760038902; x=1760643702;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4ZNqup2UyCEIQ+fXtU90pfIWTTzwIkJrs7zpdbAW+3g=;
 b=mGDugwrqJ0ihgOWTEJfR/UJdaL//j5TBaEzl+5uxWTOuLxXVd7BIB2TpWV08bHyZyX
 D13gAWpkmun/pn2p2Pb0FOBrOzqIn9ANNE2ZEIScaLAwBcpfs/5vR3hjTN4QSZW/LfBr
 KO3i6StKcF5+4pekijQ5zVPr182FL+yfoxA78kJNmIgMpmov4Kx81mM7nMKDEN8nv+HK
 jGLZrPsW71TTYqD7lEe4Y5dTEwmXLn1tCD6/w8zFTW6yn1Wk7QGVlNvwZ30WZPOGrN7I
 vEOuA51hDUhW+vmmN2nSaZL5+higTAu5W6/gSCp07pBuZeHoEg4wjE3sZTgB7vkq6NdR
 roZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcnUBqyr9jRCAsGpr9Uthr3pNke3oW4+tsDJ51fmjYC/KymmVXSOELJtOHrvWZApNrky6WcV0=@lists.denx.de
X-Gm-Message-State: AOJu0YzjAWCBqFbhhxAq/VZs0oIYyCZ+0plltxHyGKGxnLu4q0Zm0lkF
 4kS2Gd02JH51kjFpqoeZ/6HXBoJquW32JEKRf5bbdwvv0NcPQl1OH8AL57Yf94jr66llJ8Yxqch
 MLDQrqQm/4ylVFw+kLYrhfFOS24MXXCw=
X-Gm-Gg: ASbGncsXKDz0/+Qx/O8ruRqgWxaC1cn13evMlwMFktpoiW/6T70yrZL/HEvk4e2SiiS
 VgRm+2YlNda+5xj9LvSsV7fL4c0wplvmz/MFtTDeV7PtVm/et4xo+Y4lm6FH5ztGfM0tDl7S9h2
 1mOLrNU7mJioyXmZdenyExXbW7i7Qzrj+Gl28FtdlOqooJqRmbjhYHn9AikH9hTOH/Pq/GBEno6
 UezITXVp2LAsDc1MPs7lz81GXnaAod1jqlHljX5B/RotXo5yaCbUAEE/t9Wo34=
X-Google-Smtp-Source: AGHT+IFiRx78y4bfrb6PH8h5ZzXhzYUyVa/vYgM7YAkE4C3bT14LSPVbfc1mPmW1b26/31wc8bUscsUzeUP0/420t9c=
X-Received: by 2002:a05:6512:68b:b0:576:d5d0:bb81 with SMTP id
 2adb3069b0e04-5906dae6c4fmr2276268e87.37.1760038902280; Thu, 09 Oct 2025
 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251009162946.1872137-1-ernest.vanhoecke@toradex.com>
In-Reply-To: <20251009162946.1872137-1-ernest.vanhoecke@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 9 Oct 2025 16:41:30 -0300
X-Gm-Features: AS18NWC_U6o98cMDE9hPoLiSdL8yZH-t23JFoWnxqFlvwVAgvXJzKPcG5MkcvsY
Message-ID: <CAOMZO5AtMspuWzJVpxh04CcJ8wAW6=BUyx8J3kW7HRrhWfcFfA@mail.gmail.com>
Subject: Re: [PATCH v2] arm: dts: imx8mp-toradex-smarc: migrate to OF_UPSTREAM
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
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

On Thu, Oct 9, 2025 at 1:30=E2=80=AFPM Ernest Van Hoecke
<ernestvanhoecke@gmail.com> wrote:
>
> Enable CONFIG_OF_UPSTREAM to receive automatic device tree updates for
> the Toradex SMARC iMX8MP.
>
> Remove the now obsolete device tree files:
> - imx8mp-toradex-smarc-dev.dts
> - imx8mp-toradex-smarc.dtsi
>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
