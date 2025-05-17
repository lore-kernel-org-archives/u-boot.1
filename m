Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7493C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 20:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30379808AF;
	Sat, 17 May 2025 22:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fSb2obee";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657168091A; Sat, 17 May 2025 22:28:10 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7552C8004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-54b1095625dso3914573e87.0
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 13:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747513688; x=1748118488; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6uhLhfR9d79D9BTTYcdXePUCNFUOTz2lsqBH3GflqY=;
 b=fSb2obeerQQWMN6Nz5LM1IWNQUcXcme11WuvooA3jPFbA1qdrJj9dl2v9qLMYc8FWL
 RRON86JJFcgY5e037I1zBnQuW+W2M/3sWAvDz7EaDtjjMx7SJqEgZEmVWYmeKwAjjWRc
 uCdWfEKyMEFoB9UUGifCMRZcfZiJX6ufmlW2rdREQQUnQrWnk6lNToyN5esex4Q43rWT
 PGhfk4KSF+AUcCYkkAbq1AhA89wDRUuEFIxGdvZUYDFyZBMpaf/HoeeZA7jFtSABZOhg
 50iU2yzIc/XR9mNxfYULy4P3zvuwj2DpVU5cBMRS3T4tC+k4SY6zMYhHFAMwBVHmV06q
 16JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747513688; x=1748118488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P6uhLhfR9d79D9BTTYcdXePUCNFUOTz2lsqBH3GflqY=;
 b=jgDWvPLrKiWsCm78Nokq81ZtObv0Dr3B6KYt4uOTMQWAEe5Qmv4drJSi1bYwAuyMHV
 OhpHq/CkX6OvQdrw3C2MaEaUMV6mQXXzTKxOzOgbCo/Tq1ddUOnH4AwOd3/u47WuD5iN
 jW5Pmxey7w5Ly6Cg3c/1bpTO2kyBMYdQsYUQFS4uOl+hyf/rz/0zTX21XzuJeh82JvZe
 61osUZlz0wqjroVgRCT835MbKlFE6OLWnguyIJcor4KyGhUQjcpZS3WqoNQh230VZKu5
 hc2lZN4kUQbJGXiHDwqZBUuENouvW0dArw7R2iaYDq3pbzLDqU5rtS+RIHOLSEyTxUT5
 JuUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsqohMN4dRFrZEa3OglFUXBd6EcWzCwTNHi3GlX9DGpCoPuqNnflKaQrmK8NIjOKVzRxWnQMU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx59bdqhONRKLSi5cBkX0CTl03ngx4WJTwCOj84vQ0ojV81ktOC
 EOW4EFQ2e6ioLiTZUgHShqDXDBrbil3454bw+WvN3/pbE6Ju2ASEWRK4/oNgrLxh7AVsmZzSbD2
 kHEF/AVInk202xjXAFCwBYsxkksart28=
X-Gm-Gg: ASbGnct9E/eVLD4bvxElM92E7wd10s1NUCXgKD2OxQAuQxBShu74Y9nqYgNp0tJYHrQ
 WIVHvz7KcQ7KJm+NE8EdOg0njDC5b2RpjUFD48MtlPhBdKhutevARu4pwR419rxT3KM9xinKwTX
 namoIVGyOp4Dkmf6kfFIWaGQCO8b+XXgNFtY+nHvlQC9A5udRkzgDd7KscdJaLQi3l9CvG5+tHz
 w==
X-Google-Smtp-Source: AGHT+IGR+FI+wiO0MusPDyBLuqA3n2527bWvlaHDyNorShPS5ksTblFPBN9R2KrcCF7NXe2edAeXGgUYTFEqWQQ9ylw=
X-Received: by 2002:a05:6512:2915:b0:54e:8db5:68ef with SMTP id
 2adb3069b0e04-550e71d137amr2069410e87.24.1747513687564; Sat, 17 May 2025
 13:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
 <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
 <CAOMZO5Ac3NdTu=rWJ4e=YR5t=ck+qbNbf9SH3zikUghqMineMQ@mail.gmail.com>
 <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
In-Reply-To: <CAOf5uwnfC0nLBy1QhcDe_VpqE9LGh5fKV_Br4_=rZxMBNHw1ww@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 17 May 2025 17:27:55 -0300
X-Gm-Features: AX0GCFtspxoFwtr5k31pfNDKji1RnlpRtE6vzMUT9zCoEn4Bx0toeyUSkm9yOJM
Message-ID: <CAOMZO5AcUbYa0+40jZ=2a1dxO7D+tif82Arkguf_vVsP=CkzAA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
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

On Sat, May 17, 2025 at 5:15=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> Can you please point me to an example of a tested board?

I have just tested the top-of-tree U-Boot on an imx8mn evk board:

U-Boot SPL 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -0300)
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
SEC0:  RNG instantiated
Normal Boot
Trying to boot from BOOTROM
Boot Stage: Primary boot
image offset 0x8000, pagesize 0x200, ivt offset 0x0
NOTICE:  Do not release JR0 to NS as it can be used by HAB
NOTICE:  BL31: v2.12.0(release):v2.12.0
NOTICE:  BL31: Built : 17:16:49, May 17 2025


U-Boot 2025.07-rc2-00018-g126a88d49bca (May 17 2025 - 17:21:14 -0300)

CPU:   NXP i.MX8MNano Quad Rev1.0 A53 at 1200 MHz
CPU:   Consumer temperature grade (0C to 95C) at 32C
Model: NXP i.MX8MNano DDR4 EVK board
DRAM:  2 GiB
Core:  180 devices, 23 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0
u-boot=3D>

Make sure you are using the most recent U-Boot. We had some imx8m
clock drive hickups after 2025.04.
