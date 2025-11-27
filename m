Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B32BCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 22:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2343844C4;
	Thu, 27 Nov 2025 23:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ikjJ+9a7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE0C844C5; Thu, 27 Nov 2025 23:04:27 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DE58449C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 23:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c7613db390so585576a34.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764281063; x=1764885863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WJ7vS25KXKGVVHm8AdDalmZ3Si9Ucek3DbPnLLA8DdU=;
 b=ikjJ+9a7vjl8f0obcCWL9g/U4Za3QYWSlAuWE9UZnED930DCz5AQAlcvjy3Uf6fowN
 D6r1o5So4paCbYzyWOpPzOE9xChXypt69pi73uHdb0fksISzkzEEwc3hR4P9MQ6gZc59
 cI9SQzawckfGBylOau2dYF3Hpbbr6PjowhCufSCtH3ShbhpnFr+MfUXE6M54G5Bn2CYO
 xoPaR2w0sbhdswiRtPcqzRvVHbzZgbMIj/nmJxnXLRMg1F9+J5x8hnHBWXipYUQQas5c
 +detxOYX9L5QeirBfl5SPBeGWKaQ4XrxBsLop0IK4MKow2ebZg3fIdnovccjL74jI66/
 KONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764281063; x=1764885863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJ7vS25KXKGVVHm8AdDalmZ3Si9Ucek3DbPnLLA8DdU=;
 b=uoXmDc/QmWpsY9XqtE+Bo3NM6lzNp8+MeIpx5cBHzUdbLOlP46C8bKIKmbKRVcFiTN
 uUDlTIt21qjHuk/Y8u5GwOsonKD59OrjuEHuztcHuK5LfW+XGfK8T05UYuexKF/i+XCy
 hRC0bSJDZu18gs7DXy/5NoDXLuoH0W/+WEuQ0z/+sIE5Yt4+cVn0xHFp7abw/pyhiVzK
 oQmwFGgXLhJ2G2Is33790A3Ti3h1fw9VEWLTCZWiFqk1PgaEsMucM3Xc7+MjkemxGMlh
 pYOA6qJduz6+fHH4Vca3aAoEW+dg9RGcGdZsutT6PKswP/Qsd2wWehfpGdiJGHHcfo9w
 31Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgQWJ7NWUg2oyNDSARy/tuZPswN8DKqRtHBys0RrhpF6D7NMIfVx1rRgfF5Ox21mwz+VHWuvU=@lists.denx.de
X-Gm-Message-State: AOJu0YxD6HM2WJe1zZZ805pGzvMuZCw8XHOOJDxMdzVK6kxVE4PniC5t
 IGuT3KNQBxs5G/1V5yKaFPqung3ii9EU26nsRiDC/b0y83G03Ucfl9Yj2PPq0q84MgTuIlnhuBk
 gZlWp+Pko7ZkiXixTUlPsJEvU8oE+fi0=
X-Gm-Gg: ASbGnct/eDhnUIgJTEx+wWHM9xXPkK0O87zvP1YAhriaeDP3TrwhVGNxOnC7Pnwibqs
 jF/JfEWk3jNII9DYHur790IzU6vqY5nivcrpozIcjjmHnXb4dzTJM0z1vFE/ejlOrs06qgCi3nz
 EQHIrJrnUuTpQsLATxH1iorImpwrgrSztAvBhcmzHlN6GzFdtUjP+63AOCR6IJl+HApE5LMibTg
 YcEG21aC+t6FmmI2Ps+Q0nDt454Lw2mBZRI0oAzqDWAjUfOfcvas/E48AvkW/2FVb7PLHc=
X-Google-Smtp-Source: AGHT+IEqnX6Kku8tcVoZ8I9VBTtpgfEjc7mDCUpwwnt8z+mBI/pbnXHp5z+QbJcGG3rHQ7P1RkrPXfgC64G46mUjx/M=
X-Received: by 2002:a05:6830:71a9:b0:7c7:1e8a:c9d8 with SMTP id
 46e09a7af769-7c798e031efmr11708081a34.36.1764281063293; Thu, 27 Nov 2025
 14:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
In-Reply-To: <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 28 Nov 2025 06:04:11 +0800
X-Gm-Features: AWmQ_blGCZLNKRyRdW7l6QYZX9JuS0_NmgqE_Ueg8xazdxkEilZjeDNYmfmRIZU
Message-ID: <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>, "Chee,
 Tien Fong" <tienfong.chee@altera.com>, 
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi all

> > CMD_CYCLIC is enabled by default ("default y") if its dependencies are
> > met (that is "CYCLIC" as specified by "depends on CYCLIC" in
> > cmd/Kconfig). So when you enable CONFIG_CYCLIC via menuconfig, it
> > enables (by default) CMD_CYCLIC as well. But you can disable it if you
> > don't need it for example. If you add a "select OPTION" in an option in
> > Kconfig, you cannot disable OPTION anymore.
> >
> > CMD_CYCLIC is not required, so you shouldn't "depends on" or "select" it.
>
> Yes this patch had removed it by cross-check via real board on the fail
> calibration issue. But CYCLIC and CYCLIC_SPL still a must to fix the issue.
>
> Brian

Would Altera also confirm this issue a bit?
I can repeat this issue by a fresh pull build.

Thanks,
Brian
