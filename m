Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC05C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 19:10:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1BDF87B84;
	Thu, 25 Jan 2024 20:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JyV0d0ZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9737987B84; Thu, 25 Jan 2024 20:10:05 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E1787B53
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 20:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2904c81f26eso696264a91.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 11:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706209802; x=1706814602; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXYGp0gdR8MeQP37l23YzHSQCbmXJW2ZY9y9BMvaNQQ=;
 b=JyV0d0ZFpkSy9lfpA9Ho4KiL66poRAc7GNtqT+n2Xdh7AzdzfNajxlqrt/70FQ6/nv
 vcvcmfuTOe8Z/DDsuacAq67Y3exEFH3XwK+Yn0Ud8ShheaSmBSC+mfhjmjnD2+2vwoe2
 kxyEb9CwvwaIay1pYnk3jlKXXJ5h/VD5sxvlWIs4m7+uHnu8utPZYrP2yfW1H3mg6ndk
 ClsvQhtWS6s3mIodS6/WDuWb3+enqsof75h9hotSBM1CtvUBf4rVh3xV9HFQsEQnj2X4
 1ge24c7EUUNLZ8Svw2G/6MeRzog7pvvkCWMDznWYtGBg0UtncOjhFjqi5ftVTIzcEZZY
 LNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706209802; x=1706814602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXYGp0gdR8MeQP37l23YzHSQCbmXJW2ZY9y9BMvaNQQ=;
 b=WDzZKGjlKAdx0icFVapV56DG86p0pxYQjhucdh5W7YZ3kferhLKUfALtU3tXHpyiNw
 xe1EcJ0r5z0rWsx+PjWrpwnB7sh1wi4q416/zA93mWCuyCjFw4MuuXt9AOeQok16TWnu
 xlXp6vUrCdokQOzGO7HOZylWuknszvloCUMu9A4/zyXlw3i9ou2ExkgL8fcVG5LgzGAV
 HBQQrk7+9K05yNnr2wFAtDfdyHamhLE4YuCPi0kepsYw+9/ZCzb5aJS0jlb1gkMY5epP
 HlbQnhn1OXa5XZb+NaebVQeD3nf7e2Gv+bOAAxhDK6fybdq8MA9Ar+evBqFaPpr6TTfx
 Zb+Q==
X-Gm-Message-State: AOJu0YzERKYT8VElIBbuzN0UdxEKWYkBSbVCAthKObzDNAbQiAYxQMPT
 biw5MS3OwS1T8U/a+e5rguFhurizWRte+zD13Cqx0aBETj8L0gwV1YjfPu6byGuv9uWnV+RMrv4
 lp0awQsjviVlZa2t4xbU5XnGchFjVncrz
X-Google-Smtp-Source: AGHT+IFr1Bi8ASSJg8WriCEJz2eU0mr3MQIA8t7QpAVWGyQQ5D6h5r7rM/NN8o9MBU/5VW7ELeZ+55oDhI1XHHg+xoA=
X-Received: by 2002:a17:90a:e7c2:b0:290:f5aa:f74d with SMTP id
 kb2-20020a17090ae7c200b00290f5aaf74dmr152473pjb.2.1706209801545; Thu, 25 Jan
 2024 11:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20240125164503.32097-1-othacehe@gnu.org>
In-Reply-To: <20240125164503.32097-1-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 25 Jan 2024 16:09:49 -0300
Message-ID: <CAOMZO5D9Sb-Z1jdyBhEhn+HogLokNd+RZ-5jvekP0fDp0g2J=g@mail.gmail.com>
Subject: Re: [PATCH v3] board: phytec: phycore-imx93: Add phyBOARD-Segin-i.MX93
 support
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, Wadim Egorov <w.egorov@phytec.de>, 
 Yannic Moog <Y.Moog@phytec.de>, Primoz Fiser <primoz.fiser@norik.com>,
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

On Thu, Jan 25, 2024 at 1:45=E2=80=AFPM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:

> +ipaddr=3D192.168.3.11
> +serverip=3D192.168.3.10
> +netmask=3D255.255.255.0

Please remove these hardcoded IP addresses.
