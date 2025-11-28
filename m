Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD03D116F3
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 12:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E92844C4;
	Fri, 28 Nov 2025 13:25:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y1b7rp4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A65844F4; Fri, 28 Nov 2025 13:25:01 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845E583B8A
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 13:24:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c75a5cb752so984079a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764332697; x=1764937497; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7bkAOgyRlNx2qGR9bpx7ExhDC2ZMz7KOBKLUdxsfMx4=;
 b=Y1b7rp4qIDLvtQHoI5oiavd9cRJ4W85IeN2Vge3XiBMXmC3KnbCooIGEMYZmRLlgDG
 GEd4qZHz/hns/ApRnRtZTVSu07ok30GnWQ+0BdNVA6rgmW9ZWBIldR1M4tTnW9U93jW6
 FfSVMmQDZNxPgZgSke8DYPq3FUc6416UsmA4Eu2BEmBbSq3GY04cOfvpjN8bGZDnkGXr
 ZfINlGK7497yzBPVYsDvfUFgu04o4UCDcU8ABMsjPm/U0BjYhOKGx+G+88VOvbANhJJz
 1hHwt8XIpV3D7sL97w023+Cv2LSwGY5l5NKT1hysl/HkUmXASf3EZDel3BpnLN7EUSYn
 I+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764332697; x=1764937497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7bkAOgyRlNx2qGR9bpx7ExhDC2ZMz7KOBKLUdxsfMx4=;
 b=vED5oOTGvt/9zNzXT4zbHj875Bx1LxiNh1OGTKPAjQaXFgxVe/TtfWnbsh+7JZlTKJ
 Vx/7ToN1Z0C8VJQNoALBbF83paeb0VJw6WehQG0iD9MOirW6W1Vwe915Cawab+t8wiq8
 SQePigkipBzXoa9qa/I5HbrcrcFQgKqtwOvVoK4qYBCT1PgJjh21RjJgJ4MZ4zE8/SM9
 fZaR8tWb2E2V5mMky93QKOmuhBv7J17J+Xx1Vw2t90vp8KJNWYgJkFK4SYZSZ+HgT3qd
 LrMrW3AuLUhs5tMIUk5LJMbMiPhNfS7SNx0Ux13Nlv08LH7jgUkx1HOtAwDrRuHeVCih
 XKNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVydjd0wQMAYMsxK3rxto89p5hTpAg0akGznPrS4Bz5qFlHm9N+kf7Ql33o9J1ZyD8yo71Nq2s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7FodXW1gl+j6qeEnxI0Cz/FIooKmUUu1RdHhEC/zNfUKX5xgM
 xc/czNJ03sinPOBkzwSCSDoZh+2cozGx7ZBLd6FyuiA++9OClWEL/W8rEa6Dhr7kFTBmOz5f5Yu
 T48f1ZxopD1ygo9jqUz94vB0eHXUjFJ4=
X-Gm-Gg: ASbGncvWczRrN0yatPWVvn/F7nF2U8kbneaQCOR9U5+1qkIoN8L7S1Tl1hC6KF8cOAk
 FQFGsz3VVlZXL0bX6rZxhQwpAfPYGk5emDkPCOl24yzonm/7UT17T8vTe6b5BdvRbn9puVtZaGG
 7v5sg02zM0qVTemruGoZH8V4mXJVcV5RwEConpZtCVLnWCV3q7GpcIdB1DvJNVBaafw0ChiNMJ5
 bo4IGcPKQSPLbhGbMrbZ2pjLQwa/yRsTmiayaJBsv7HCsSd4x4UTnjsBOkbar8SFeaO5aFSAhf9
 /LsNjw==
X-Google-Smtp-Source: AGHT+IF4NapSdvpCzKiD8mpDsEpXK058WD6eC0wZE7Xuqw/lPQp6aJJ6iWnk4Ff6hLyWDDWSbiNmz6woUHDd/fQvNtM=
X-Received: by 2002:a05:6830:90a:b0:7c7:5f09:878d with SMTP id
 46e09a7af769-7c798be7b39mr15539510a34.12.1764332697201; Fri, 28 Nov 2025
 04:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SCx8VyuMZfYbUH1pnqdPykJ-G_S3_ND+wVGHcu+7sBdwQ@mail.gmail.com>
In-Reply-To: <CAN7C2SCx8VyuMZfYbUH1pnqdPykJ-G_S3_ND+wVGHcu+7sBdwQ@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 20:24:45 +0800
X-Gm-Features: AWmQ_bnj8auqLpivd2tXaYS_pMV8Ln5xGV03Pjbw-KYEsR25Wk9uIJPBWHE2O3E
Message-ID: <CAN7C2SBM-6GLBZOMwn3pSt_LSdn+++VgUo5xKKsK8356AXm9Ug@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> BTW T.F. I want to point out a very important setup.
> By default the Altera trunk had turned on
>
>   =E2=94=82 =E2=94=82       [*] Enable U-Boot watchdog reset
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       [*] Automatically start watchdog timer
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       (10000) Watchdog timeout in msec
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       [ ] Enable Watchdog Timer support for IMX and=
 LSCH2 of NXP
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       [ ] i.MX7ULP watchdog
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       -*- Designware watchdog timer support
>                    =E2=94=82 =E2=94=82
>   =E2=94=82 =E2=94=82       [*] Enable driver model for watchdog timer dr=
ivers
>
> So maybe you can also reverse investigate on your side via real board.
> Removing all CYCLIC WDT drivers and all dst watchdog "okay" do
> not introduce sdram calibration issue?
>
> Lets cross check.

Hi T.F. and adding Alif as well.

Long story short it fails on Altera trunk as follow:
1: Altera trunk force enable the driver of DESIGNWARE_WATCHDOG
2: It is not allow to remove by default git pull
3: After manually remove via Kconfig modification

config TARGET_SOCFPGA_GEN5
bool
# select DESIGNWARE_WATCHDOG

4: The DESIGNWARE and all CYCLIC are turned off

DTS, .config had double confirmed the setup

Test result:

U-Boot SPL 2025.07-g35abb4f1cedc-dirty (Nov 28 2025 - 20:19:39 +0800)
SDRAM calibration failed.
### ERROR ### Please RESET the board ###

Long story short the inherent patch for this series is actually correct.
The WDT introduces calibration failures.

Thanks,
Brian
