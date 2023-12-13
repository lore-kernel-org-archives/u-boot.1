Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896ECC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2FC87831;
	Wed, 13 Dec 2023 17:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LTuNXHWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2AF8785D; Wed, 13 Dec 2023 17:34:38 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF4A87830
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28ae1de660bso230935a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702485274; x=1703090074; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plVkZBQpwM/VaDC5E1jkVyhMzsvDQ1H9n1HFeG67ld0=;
 b=LTuNXHWcTl9SJ6PZZ9y7pgqx26ncT1FSEmhDSA10/Pue2CIJBKvgyXQ3ifnv3U9B2B
 ud8ArE22GXmr3OEmJ8D6E++5cI8JmaV/ZhGNk2d2Pkof1m10+4QVaDBDEgOUpw86RucK
 HD23K9EINyH759FWd/lI39PJXl4CKWHiQx70eGPrg0BTSrg2OAM7b9+V4ZQFx68z1vkI
 MMjlxFgQelJSrgvPCACADiRI5R1LYeAp7F4NBEjyzsfs9Qhyfx5Ult8LbCyq95RXROCg
 u9W6Kqyoym2nlfYXOrHQJOT72ZGxs9mI7LLyntFScwp92uHcpYrVaUoK204qklgVh0tv
 7NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485274; x=1703090074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plVkZBQpwM/VaDC5E1jkVyhMzsvDQ1H9n1HFeG67ld0=;
 b=c7utK8W7kMUVzVTB6mq4nhclN+E9Wg5TBLnc9Q0ADnDF79l3IgBi2aG0ZR7hmJHFbV
 hwDj1hjkVt2PIZWYlHhUnvpF4aTAujo7+PM4/45RQfjB+iGAwZl9+CwcO7wh84YVdL4u
 iQIsu7529/AMOSeD5riftbz0Nw0EFvrTiZ3magRpob036O9wjYK8rpCWrkbuvKKcw1ZV
 YobL2oTD+EV8+s+evzcKJcXfKSKXtvhOW+53aHBneNwDy57kHHMpB9VVZ8DnwPDUWpr5
 6kdZOM9cndghMNwBHMqAUFJdRBvXcsXZaHkD0xDsXYwA62fxitsEgSLt834mSb14o1cO
 PM1Q==
X-Gm-Message-State: AOJu0Yxla0xkmobqqNu+KKPRgtswdGYTb8p/+fwYGN4kZmFWvFNK8Op7
 WRvznFzCF61hjlRlx6hWSHHSD9IQr5Wlx2jmpLo=
X-Google-Smtp-Source: AGHT+IEEiHwFrth4xLMqOGe0rE8y25Oq1N1j5gUeEeaXnXs98JEjzrB2naicgzLwP8bj4WkO/0en4gt+318TQSP+utA=
X-Received: by 2002:a17:90a:4b46:b0:28a:f1fa:3da1 with SMTP id
 o6-20020a17090a4b4600b0028af1fa3da1mr1109086pjl.3.1702485274317; Wed, 13 Dec
 2023 08:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20231109162401.38941-1-hiago.franco@toradex.com>
In-Reply-To: <20231109162401.38941-1-hiago.franco@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:34:21 -0300
Message-ID: <CAOMZO5B9UzOkDxT=rd9-x_t4ZgPASNMAKp0nMPFiTF-r3=jQXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] apalis/colibri imx6/imx6ull/imx7: Add fastboot supp
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>
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

On Thu, Nov 9, 2023 at 9:44=E2=80=AFPM Hiago De Franco <hiagofranco@gmail.c=
om> wrote:
>
> This patch series introduces Fastboot support on all Apalis iMX6,
> Colibri iMX6, Colibri iMX6ULL and Colibri iMX7 machines. It includes the
> necessary configurations in their respective defconfig files and
> implements logic in the boards files to determine whether SDP or Fastboot
> will be utilized.
>
> Hiago De Franco (2):
>   apalis/colibri imx6/imx6ull/imx7: defconfig: Enable fastboot support
>   board: apalis/colibri imx6/imx6ull/imx7: Add fastboot bootcmd support

Applied all to u-boot-imx next, thanks.
