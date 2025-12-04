Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B23D2069D
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A9083B48;
	Thu,  4 Dec 2025 15:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KBrNiL/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7607883B4A; Thu,  4 Dec 2025 15:03:29 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D23183B1E
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-37e56b0712aso7790231fa.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 06:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764857007; x=1765461807; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y9E789lbLDE3ipogijPVvvtspCXoGcYkxeic+vTVaX4=;
 b=KBrNiL/WUVpBx9Pf7pz6XFrJN4vwwApeKKTwGcKTXqkqxxFFDfhurW/FlVrgyIQ/4z
 KbYfXQE/dK37eTy2GJ3OovHmf6HWPgdtS8ulrPiuj/KZKPiJ7z3o0LKf7EQpb9FN9OWg
 QVfUw1M5U6oBD4NLKcqqi2YPmI3nRAhdi0+/rrRsQyOcrHtHWDe12rOCatcDqdzLeCMM
 CaZnoldgPyuHrIe3mTS95iEIpWCh1+MIZpreSNzHIJfOcUy9+xprH5td8ngcxBTUIz9e
 NvMm/3LrwgZzH0NIvteUIBfF6SXRwq2Rm2YZUYiCXzn4JdBazImFEM0gzPLO4Ui/zzGw
 v/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764857007; x=1765461807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y9E789lbLDE3ipogijPVvvtspCXoGcYkxeic+vTVaX4=;
 b=GRnbGym4BqwoIJWpLpbq47+as7Ck7WU6+ExHeBj4B8/xOlSwKosC6nivYWHQyO43f1
 mo4wO/KUphrBXp6OxP23GcRvhHlzHkbGpP9NQ9M3dZRo5tUHIU8Nxv3T7UPXmUQaSVbu
 a+7VC649Zph8uVQBdYYOnhuC7MbLg33wH8CEpzMn+9p7N9LTTgWHe+0vhHvCtjE0e2yt
 GsKc3hFrEyJfaMoXOZ8tAS00Hdmkku0VqAqvdoF+AH5sC8xe7PmBM6X6d40C2gIot5+s
 Kgqim13FAlhFNErKVhKzK8YDOdl/SfamaiElluA07qJvLVECVVVAMlkPxOatBZv9dKvx
 vEBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjc2ISI8Dg+v9XLLofsJBoodXi7qEOrUXSh/t4Hr7cL/WrH9ZuKIuM3sqVAOVPq4K0Nr3a/bo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+5l0FrVbi5kojPnaHzPK21WY4qolcZXPFzCz0r+U9qQGQ8gjc
 fP7YOlNkGpNb7sc3egamLqlCrvCH8z4Dtk8jit00KYKvmX8DC2i7IYzPuh52Hq0HgVciD/xhkwI
 GtTQI8/QP1ZHnHOMc2hSah1l3mCQO6Gc=
X-Gm-Gg: ASbGncvrEM325cFRaNvtyvu9qIv/YD1BGWN6wkl7yFR/v2SADfZejKUn222oLOCddNN
 Q23Tmw8rz0Qm+DuiV+uFZt8DdYdabDpZVgKFYjYZ2ndtDmOX9lTuY4CO3BGkLLr933XPQ6kETb9
 zk/H25LgVA8IYR4w9zRzsiT4yyAupHEhM6jLa7UN2iIOTW9xc+0YpPFWJ9m6IS24BXIvWkRN5Bm
 dcHfVw9BPmpbDQECxg2S8/QYoWvkcXfWDxnlGMpcNDwBUl2J7V4BccIRDdWFjZ5HyM4Vf9obBLc
 rOfmJpigD3dtj1bMAzd34xM7iAI8ZxpYZerXRRg=
X-Google-Smtp-Source: AGHT+IG/VjeswEW8gWeJXlGOHXxlsMZZHqOXlPLKbDhz3MCtGXO1ql7tU+kb6wwl9GKsybbPNBBjFS6pQU6g8HS24SQ=
X-Received: by 2002:a2e:8083:0:b0:37a:7b74:fe13 with SMTP id
 38308e7fff4ca-37e63959171mr16522531fa.45.1764857006352; Thu, 04 Dec 2025
 06:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
 <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
 <93024512-1ab0-4fdd-aed0-f52849528c21@oss.nxp.com>
In-Reply-To: <93024512-1ab0-4fdd-aed0-f52849528c21@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 4 Dec 2025 11:03:15 -0300
X-Gm-Features: AWmQ_blYn16FW7b2fsu7mNd6iZgZsVxG6dDoNVi9ayQl_slXcB-fd_PZlIiSGN0
Message-ID: <CAOMZO5B+NtDy1WOgOF71F2OzrpNzbDeUctvOKk5eK55H9Z4f6g@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
To: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Cc: Joseph Guo <qijian.guo@nxp.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Francesco Valla <francesco@valla.it>, 
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
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

Hi Joseph,

On Thu, Dec 4, 2025 at 4:12=E2=80=AFAM Joseph Guo (OSS) <qijian.guo@oss.nxp=
.com> wrote:

> Hi Fabio,
>
> USDHC2 is for SD card and its initial stage is at u-boot.
> The IO voltage switch from 3.3v to 1.8v need extra 8ms time on some
> platform. I also tested without this delay, SD card can work as SD3.0 on
> imx91 frdm platform.
>
> I prefer to remain this to avoid potential risk as 91evk 93evk 93frdm
> all remain this property.

I understand that a few NXP boards use this
fsl,signal-voltage-switch-extra-delay-ms property.

Linux does not use it. U-Boot should not use it either. Whatever
solution the kernel applies to provide this delay, let's use it in
U-Boot.

I would really appreciate it if you could investigate this with the
NXP folks and try to remove this custom property from U-Boot.

Let's keep the U-Bot dts files as close as possible with Linux.

I appreciate your understanding and cooperation.

Thanks
