Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95DCC54E41
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 07:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C09587D33;
	Wed, 28 Feb 2024 08:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e3QoSwKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB3E87D33; Wed, 28 Feb 2024 08:09:21 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89AEC87E7B
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:09:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d2509c66daso73139201fa.3
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 23:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709104158; x=1709708958; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vrz7hvkV6ZdL728XEWeqg5BUTSWI9mi+pbdtixH016c=;
 b=e3QoSwKqJzHB3cAFNzBMQMyb70k89VU/pQWdeNJuN4uQBzd5k3Ix1blQ96VkbTzB39
 aQNHcsncAeHATJ/vvauV9el7/RpSjPCqPhjAtH+atilqDmrMlB9vBUE7MgJJHqsK7M5W
 quUhr7kqvNrUvoM/cPmtDkyxl65V62A7IZPGAZjEZb7uav9S1S82UYbtBXMPcmpnYwGi
 wU8FruxeJ/Ju+qGNnV7GbYoY2KF878FTdEzp2zK4CysKm+og1MHcrSWEwIptYuedKUKi
 Bl/tsa0IuTZaYq6VccwQHC/05T2k/QXBq0ZFwjTREQ2OkQjX378K91UiMLlAG4Ri+/GS
 PNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709104158; x=1709708958;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vrz7hvkV6ZdL728XEWeqg5BUTSWI9mi+pbdtixH016c=;
 b=F/mimS2Tf6ZKC+3cEubIi6aSFlloBijGQo9Y1rsPhG6DZ+Yz1g7iayrTNOSTPXgGdP
 UVF3B/FYP+VK4fShOxz0ZZlKLTJ/mKjaun49XpZRb+/FwfHfcAqhxftBAsX+IheQCxcR
 xesv7/WRiBbE863heZe5bqDub9DiN5OtYaYPzMtLXE3427ctO0P7IrPdJ3CZmOWOITLP
 0BG3HZ1xyf2N0bNn0mKis6E9fJGMyeGgPbPVpdQCZ0tPWAVefqX5wlMAvrnjx5fAN86G
 YSWLZr2nm/xzXKO56zEpgNZseeICBgizkcPCmrz5dQmgX8gwELG14ih3buVHkSmWSwI1
 wOpA==
X-Gm-Message-State: AOJu0YzfakNFEnyvtniefCsSsMBbiYVb8Xa+fK8wDIkS53Ej7ob3C60E
 dm6GrcuxDeZnhubnrnOKuxaI4Fcx7nuocS66Dz9jNFCHjaAExa+hbTf4dZgLNVk=
X-Google-Smtp-Source: AGHT+IHobriT1cn0Z2XxHqn2bCg6zWHpMcegLgxMkljfMcamR8a+wUu+K6CVeBMnp4Tv9mY9BVysEQ==
X-Received: by 2002:a05:6512:ea8:b0:513:1cae:4783 with SMTP id
 bi40-20020a0565120ea800b005131cae4783mr306094lfb.60.1709104157750; 
 Tue, 27 Feb 2024 23:09:17 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c488500b004127de1ba84sm1334485wmp.0.2024.02.27.23.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 23:09:17 -0800 (PST)
Date: Wed, 28 Feb 2024 10:09:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
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

On Tue, Feb 27, 2024 at 04:40:01PM +0100, Sébastien Szymanski wrote:
> Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with
> linux") removed the display timings from the board device tree whereas
> they are still needed by the mxsfb driver.
> Add the timings back (the correct ones) in the
> imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> opos6uldev.env file.
> 
> Update the opos6uldev_defconfig file so that the LCD turns on at boot.
> 
> Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device trees with linux")
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Huh.  This is the commit that did that upstream.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d9aa4d4fca67823838fe9861456201430c545e69

It's interesting how the timings in linux were always slightly different
from in u-boot.

regards,
dan carpenter


