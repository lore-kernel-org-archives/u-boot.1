Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBDE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 13:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 843B880655;
	Mon, 23 Dec 2024 14:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbH+n1ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2269E806FB; Mon, 23 Dec 2024 14:19:36 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94AC8062B
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 14:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401e6efffcso5053994e87.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734959973; x=1735564773; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSoNQyEPKaTTIr0BdBZSj6dl5CvduTgonmP8p2L7SEk=;
 b=nbH+n1llydUNPWMn+GNWxdMHDNd2Na0Qcc35E60kDz2/+CWtJqSxsaOpbbH7Nhtycf
 8UCe8VL9BWzLef8sxG5uTtYovH7Q8+WtcWHD44Brap9Dp5inge73YR2FeGroaL8vEPhQ
 1Kd6nELHBQ68OjfsoXoAQrTDVvrDYnJZgWWtyaHQd8XUK1vSXLWeEu46u91SEN47c90C
 RrHzkoAycMboBYEGmsjqwj0lbW4JMQDSf+taHnFPu43v/YH2GC6sBPnFBiHAEuouOk4A
 xI0JUni+pMx3R8/QTbWBjO8Q0CFdDSx2weoefPweDGiH/5h0UW7NJ7YSVueCKymj0Gd2
 wr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734959973; x=1735564773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSoNQyEPKaTTIr0BdBZSj6dl5CvduTgonmP8p2L7SEk=;
 b=FOHdfqIo1/ygERMRj5veAl8bdshdLjGxtUNo/E8vYRtL6QEI1RYLNtq1YmpLIjR5AM
 cR+lSjUo716f7H2hnnJ8ZTUXeQcE9STwuyV3WXQIUyIRo8WGoYhs6MXuvEBjYdFd1nSM
 bS78uKHRMQDcgLZMXwZgFrjr/8NvDHk4MTEQQeu1dC/4z0NSU26/rSLBkmPjAcmyOkge
 ROiQ9eWYImm2BTQ4YDtZvehkknpozVHXn2gxhXsSoHL7zNJ2sG4iOs9Wj8B78jZbW8NC
 z4o7HVRxnKpv0CkqtSWIiwkprwm0aypACwJhdTaqPm7XPeWgAHnE5XhKg+Eqwut0sHXw
 iVTA==
X-Gm-Message-State: AOJu0YzOW9G1U01V6D/XJfsuox6MPEVF5hwkdctzuupuaRb4OpF9n7Lc
 3/SFgZCOi7Qk2jzysPWZd+fAX1wBqZyLQYqnJl+z6upazDnXhMuL5r3mycc9rzdr9ERWeuran+0
 UmozFaW0zlqe6q5WEIjBnMAJ1gBE=
X-Gm-Gg: ASbGncvL5JRPdo3Ri0EYN09MZqTT3d8nqzd7AhfeiBljxI+e/tlyRr4TpgdGeph/0Pv
 AKc5ojiwl2qyhcK4CKMLcDDDshWOB1lUfMqm75pGe/4aY9WSyqGsnlpKDWfKss0UIgV9B
X-Google-Smtp-Source: AGHT+IHF6k3yVVq4OuBMkdYEAkgzzLt3W0/I+R4ol01f2D72QGBNBObAs5BRxNPmrQgJBFG/gshzwMWZWccS/g9r9GY=
X-Received: by 2002:a05:6512:2398:b0:540:1c16:f2f7 with SMTP id
 2adb3069b0e04-54229538abcmr3428714e87.14.1734959972860; Mon, 23 Dec 2024
 05:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20241218194224.1867039-1-tharvey@gateworks.com>
In-Reply-To: <20241218194224.1867039-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 23 Dec 2024 10:19:21 -0300
Message-ID: <CAOMZO5BATJ5Uqtv7_RQQg3PRGO3S96vOxDb0r_MJ20pMxdPv1Q@mail.gmail.com>
Subject: Re: [PATCH] spi: mxc_spi: use proper clock for SPI bus
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>
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

On Wed, Dec 18, 2024 at 4:42=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> The mxc_get_clock function is around for compatibility with older
> drivers that are not clock aware. In this case asking for the clk for
> MXC_CSPI_CLK does not take into account there are multiple SPI busses on
> modern IMX SoC's and it will return the clock for the first bus which
> may not be used or configured.
>
> In the case you are not using the first bus you will not get the proper
> clock. Fix this by obtaining the clock rate from the bus clock.
>
> This resolves an invalid SPI clock frequency configuration for SPI2 on a
> board where SPI1 is not used.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx/next, thanks.
