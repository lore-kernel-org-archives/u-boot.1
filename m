Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0127C3DA49
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 02:24:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179588874A;
	Wed, 17 Jul 2024 04:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lb4BGsc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C557D88768; Wed, 17 Jul 2024 04:24:42 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B525886FD
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 04:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c690949977so216889eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721183079; x=1721787879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/nNC+cniBo4JCbbauy1lLDVwDlP0Jkq8smYTCbwiSjY=;
 b=lb4BGsc5Lk2aQHSDHWwNeMWthX/QmG5eMl6nHwN4x6K1v+OrtNr+Dy16Pmk0joWAWl
 18RWujQg0p4ESDeAFIctgWTZjS3ISXdBDPx+NIc0FVQ76496CKCqgSSJUD7x1ipLFgNi
 uX+k2gV8/rioyoQafyF5m1Ayftftt4toM+OPQKbvsnhzd7ul41ZUKM3Dl0aXbh+PgniV
 EqExa3fV3SlH7Dj2FcaWcZgGPlxB85bkMcmnvJqCDSV1kA62B79U6/IxAK6NG/5KCxFF
 28NejX0Qh193iIUK3WDwcapa1LQ+HfROQYCUJEs10I750YbFEnO3mJaZWStGbhkTsrRm
 w+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721183079; x=1721787879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/nNC+cniBo4JCbbauy1lLDVwDlP0Jkq8smYTCbwiSjY=;
 b=qPj2+hbkaW0V3QXs9fLadFAOQG2sTkB5vAZoXI5ijDZ/BdwPVoigSQugc4ROZxaTxU
 FRg8nav7SOeWYV0El41LceMTaaSPxaX/WCcm0Ijwnnd8pqb3JODCCeNZnTR6EfREXE1r
 nIog6DipRIY6WcghTnDa4KNVcWowhGMOci56SaYDsMIEJKj5BdeRQvoavHa/R9jsHpiQ
 hDo8307jDZ42yHBTGaZ0pSJCIr9w5jzZBF+8k78jT73j8wRqKqfochTqY29bnXUj02+E
 m028Ic9IQBOi9PBTT3sMI9QfFQgo2wYmHSlhl+PeCwUyPOaiTQhsVR0VybMtYElk57cu
 SurA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCVugHKBLblICbjULrZay3wroz6mlgeK35AlPp2CpJTpJ130j9Ma7xbxYSBA1CD9nJM6GOHzsngbq8ub37kWcRFPwDtA==
X-Gm-Message-State: AOJu0Yx9C5gUfYNFMBJRMlborpOO7jG4oNL2fKYa4EGQ9iT7AZaTTdOa
 ww3pglW77BbTf18w1zSRDemQNNtjszNL8KCxitOfOK7eFGSHAffFUd+TwimbGoIjd2PKrKNcF1P
 YbV/zvMDOEXBJo+A2Hp9UdLqzlnc=
X-Google-Smtp-Source: AGHT+IGPYrmzXEv61W3OeTWApeY8bsp1CXaSu9T9r8gJ73UGakWUy+MAmFBntBKJ7KCyqdnaZffAjon1saYarqRWrlg=
X-Received: by 2002:a05:6820:1e0f:b0:5cc:64e5:d002 with SMTP id
 006d021491bc7-5d41c2158ffmr462819eaf.8.1721183079332; Tue, 16 Jul 2024
 19:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240626151522.83561-1-linux.amoon@gmail.com>
 <20240626151522.83561-2-linux.amoon@gmail.com>
In-Reply-To: <20240626151522.83561-2-linux.amoon@gmail.com>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 17 Jul 2024 11:24:28 +0900
Message-ID: <CALrBrZ27g5hSEKZ0qSLxKxOgXzuR7ONS6er7C_9kQLgBNr7oKw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] odroid: Fix target platform compilation issue on
 Odroid-XU3
To: Anand Moon <linux.amoon@gmail.com>
Cc: --Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


2024=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) 00:41, Anand Moon <linux.a=
moon@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Resolved a compilation issue where the build system attempted
> to compile for the Odroid-XU3 platform instead of the specified
> Exynos4412 platform due to an incorrect CONFIG_SYS_BOARD setting.
> Updated the Makefile to ensure that compilation only occurs for
> the Odroid-XU3 specified target platform.
>
> Now, object files will be generated only when building for the
> TARGET_ODROID platform.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Tested om Odroid-U3 and Odroid-XU4.
> ---
>  board/samsung/odroid/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/samsung/odroid/Makefile b/board/samsung/odroid/Makefil=
e
> index 5bf48313de..615c99f501 100644
> --- a/board/samsung/odroid/Makefile
> +++ b/board/samsung/odroid/Makefile
> @@ -3,4 +3,4 @@
>  # Copyright (c) 2014 Samsung Electronics Co., Ltd. All rights reserved.
>  # Przemyslaw Marczak <p.marczak@samsung.com>
>
> -obj-y  :=3D odroid.o
> +obj-$(CONFIG_TARGET_ODROID)    :=3D odroid.o
> --
> 2.44.0
>

applied to u-boot-samsung.

Thanks.
Minkyu Kang.
