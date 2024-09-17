Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC755C36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7282588D9E;
	Tue, 17 Sep 2024 14:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbyiFfu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5FC88DE9; Tue, 17 Sep 2024 14:18:26 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048FA88D7E
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f75f116d11so46500211fa.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575504; x=1727180304; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W11PFOmyCXw/dJHygtIWdjUFcjjLyXCxfVdQmqpgWA0=;
 b=WbyiFfu1Kw5mqJZmQaCj3WTZcbtKtcNBedFuKOEhq9svkzTGcwODtFa71cqul/4mpI
 PZYej8r9FF9YwwKhy8nabxkxZjLUBJXe5PwRYlbp7NW7QQjM4oTrvzR0B5zqg+CTYXbZ
 ytasowOEbth+U0QgXYV6Ndg6zY9+wq7UvPBDpkaiaJDjQAOC0q9ybZkQ8bWYIcphUUtE
 KwqgL3o5vrg7Og6HAXTIcAkxJwK9ha8XVIMPo1sd6iMJnvnoNh4SWV9nBGvGjMeK5AWN
 YAz0hW5IURsNtEMsqFnHDSypMRW7G47mhlFLu+wqoXqBATRry2Q8Hjacb7Phsi82PpZF
 w9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575504; x=1727180304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W11PFOmyCXw/dJHygtIWdjUFcjjLyXCxfVdQmqpgWA0=;
 b=LIv2o7rc9zGXEofrPORDE9vxGFXakbEo3OrvSiGr8irDDocpjrcJKrS6905AFRas81
 ujYplt1OGiLDYrxsVws4oTvFAnXp/zphxvinrpcPyOQ5d2IqtF4bduexeGzhq8IG2Mpa
 MWMYuMlW/JNNmOLPYurye9prfStixqN4BG3tMc5XKYbp1KAWYDOFVp4x7rFOjs9hIk1w
 lkE2mWzIw2bG7ux9f6kAf81zc2qE6uG6kJCgAS+LGPckldcrOXUgGYYKrrplzj+ukqVL
 UZjvAREQ7Mcd0F4HfoSc646OzSVVt28jset4qAwVvynlSJPKhMrqaJgTOEurIrn0nkJv
 +2PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrWI70enjZRlvl29XTbYDzYDKC3EP/TwO1MVA665quksDeFCDH8nwlLW9TrZd8hzZbj7Rm6kk=@lists.denx.de
X-Gm-Message-State: AOJu0YwyHazvv8Ldb6Vh5Zz4IaUU4BikZD+u+xaXyw9Fomv+p64BzcJM
 GTCuLEF2fOjFcqcLzejE4iIkQIlvDOmEmAZd7CkuWbGhjRk7Na5j80efz9S+pXYvxP/hoOuPjZl
 Uioj2YFyTL2eBIEn3DoP3xpaRt8Y=
X-Google-Smtp-Source: AGHT+IG9h0C1I7eX9awTCfrBSDrgiB/nGxxzjvKWQMGdTjqgai5ZrluLHrBpjyPEnEvxdd3q7NpTC06ikCBtaEnPMiw=
X-Received: by 2002:a2e:4c11:0:b0:2ec:55b5:ed45 with SMTP id
 38308e7fff4ca-2f791a09176mr57967701fa.24.1726575503831; Tue, 17 Sep 2024
 05:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-3-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-3-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:18:12 -0300
Message-ID: <CAOMZO5ARJo-orF1sepn923LL3okr7xcux39AXRTVx9-4SJ3XVg@mail.gmail.com>
Subject: Re: [PATCH 03/21] imx9: soc: Serial No align with rom setting
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>, Ye Li <ye.li@nxp.com>
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

Subject could be improved:

imx9: soc: Align UID endianness with ROM

On Mon, Sep 16, 2024 at 11:30=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Frank Li <Frank.Li@nxp.com>
>
> ROM use UID[0] and UID[1] as serial number with big endian when usb seria=
l
> download.
