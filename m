Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07946C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 01:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A6A8801FB;
	Thu, 27 Feb 2025 02:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkkfDhjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C90B805C3; Thu, 27 Feb 2025 02:47:58 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63BB98006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 02:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5452efeb87aso372453e87.3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740620875; x=1741225675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iw8buDFfFUcTmmGb1L9EThbHGnqHpeqzYLh7KDW6hbg=;
 b=ZkkfDhjdctZA8hdroDj9SyGECmT3a1KD5l4kCt1zyuF9b+YExPHFiH9oX0S5lGi6Pf
 13SDEkfBhLr5N2A1v1jrKKYS9K7HGefbMq485gogHY7qgaGdBRB1K9wh/CbHiJi0K6x/
 /oovlS3GrXSnxCrQ/peWbUgbORpVBYLWZ03GHOy1+mNX6+ANCHIOgMufka1yKH2am9u3
 K3JoGRoDLiTuuiH7Gwz92lyqD7ks3UrSd38vxP/C6GZ2kSFEO804npRhME+2RsHseVpX
 ehQzXjJdpouYrh55acBAEzPppiQ8+GqyV6iYzxuy2KAQiWf/xe6z9HCkHgtYSy35yrXs
 jA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740620875; x=1741225675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iw8buDFfFUcTmmGb1L9EThbHGnqHpeqzYLh7KDW6hbg=;
 b=mwr8B6zPdVUY275djV+Gnp5yBR0Kg8pNcHLjeCyx8Rpzc6ph4GyXvc1zxQyyvjbSxY
 7cXZ5QvTdj43k0ObTpX2bbC2M4WL3C7Swlb/Dr80TwEyHAABwPthLIAKw544hZoMFLw2
 J5oNoPf/J1wYVL+NPhIpbxKoHVUED+5IpaYzi2CJ28syQhtq304IBhkTEyT6tK/8Pghx
 mOM4P+E0KzrJJ8M3dm1ZxbSUCb12Uzkt2DmuSlJ7/x6yIPg96a0NwVkdJEN8sFa6Cyra
 pVY8DNRDHcLWlphPQVEvKLBkSTG15zgacGlUT6NeX+T9eLmKsNNxGZjqlOeTHm2s3fji
 rCHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWathCeCnWk/KFNSdOviwFmsk48FLpuD6wJbMMivkgsy7UpeFqQL4SNtZHNNF33bUrLCJXKQcY=@lists.denx.de
X-Gm-Message-State: AOJu0YzfoeEOmJuH5m21+fH6uxevtuVavXDdmhPL66tzZBZQEhk9VseH
 zU5m6+g5oRdJHcFfaI8s0CZbeEPo3rY13R7VSR+puzhSCOvmxzIjjgJN6YNCxHVw+k6gQWW6+U3
 H5Qjoik/Hku59BzXdOwc6aJhN9Wk=
X-Gm-Gg: ASbGnctoXAp+gIcBLcpVss0BB4LNQZIMpfiGrnDoEoSh7KZmQANTjTQpFdhBVgwKlq+
 o66g5SaSArL43STC0MuT9JUIviOdyUPnm8hfQFSxk4ITGH6rDzaRgY0LbkcoLqUj2ay5FQDE3uu
 V1LoRpKju6QV0549L8hSKGFivqWTvkL40XGPzekek=
X-Google-Smtp-Source: AGHT+IH6mn6Tup1u2ZAoyaQUgCRiP5VgDQih0uqXfnnIYw4Ul6g8KO5Yiu8ZSfsnS9vYS1ZGstnUE6/gBLeS5NiqWFI=
X-Received: by 2002:a05:6512:130c:b0:545:2953:1667 with SMTP id
 2adb3069b0e04-5493c57a2eamr3820320e87.13.1740620875259; Wed, 26 Feb 2025
 17:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
 <20250227005524.GP2640854@bill-the-cat>
In-Reply-To: <20250227005524.GP2640854@bill-the-cat>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 26 Feb 2025 22:47:43 -0300
X-Gm-Features: AQ5f1JqO8vbt73O3xbh6FqqmQWT-Va0zNcNfuNX57Vf4bgByFLRadgX2fmHW324
Message-ID: <CAOMZO5CMHA3QZKd_6uO_u3hj29KWe4dvYsY5SLaDNznbWegY6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: Tom Rini <trini@konsulko.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ludwig Nussel <ludwig.nussel@siemens.com>
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

On Wed, Feb 26, 2025 at 9:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> But what part of things here is trying to call "sysboot" as a command?

This is my first time using bootstd, and I am not familiar with it.

I got a 'Unknown command 'sysboot' error as shown below:

mmc1 is current device
Scanning mmc 1:1...
Found /boot/extlinux/extlinux.conf
Unknown command 'sysboot' - try 'help'
EXTLINUX FAILED: continuing...
Loading Boot0000 'mmc 1' failed
Loading Boot0001 'mmc 0' failed
EFI boot manager: Cannot load any image
u-boot=3D>

That's the reason I added CONFIG_CMD_SYSBOOT=3Dy into the defconfig.

If there is another way not to use sysboot, please let me know.
