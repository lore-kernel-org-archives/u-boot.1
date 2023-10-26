Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8CCC25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 19:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F4B87BB5;
	Thu, 26 Oct 2023 21:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4WT/Wq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6499C87B90; Thu, 26 Oct 2023 21:49:54 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1E787B7C
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 21:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7b6f67c708eso596000241.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698349791; x=1698954591; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vSXeNqwDR/bXUYX6Qk5it4MetKCTYpZx/EBqvOm/nQ=;
 b=b4WT/Wq+1gzpXPif6S2XP2Y8O8s9jHtvHgtChXG6Qf4OxsqtjkwFxbo26KRTYHD8aj
 tVVPPghT93LpOQowEppX37RTqYGO+b+WnPDZq/zjK9KPzASu4orVgzo0N29NaNU0zXxu
 AwUJ3IZXcBGohbr/BypcD0WzQ63IgLSlMRhw6vp3NfGrKPfhyyWt1zqOWeKm+vYMX/xR
 jkkvYiWldzxl25NrgP+6dRQBsjIrBb+OwjWVpzCXxwAXUmkkCyhwogW3YWzqf7oZJ8nx
 gC1OGtUrDoID5BETYD7Tqn8WjFkAGaicrbbEX7+8yoLZI3hfngxYFy44Ozw+7eyDvxrv
 Hq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698349791; x=1698954591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vSXeNqwDR/bXUYX6Qk5it4MetKCTYpZx/EBqvOm/nQ=;
 b=EYbtM2V6sRGfl9BtockT2Ixmlamq+Cp0euMwrlyGWhlRIp1cMWxRULxXmnRY1Kmty/
 JN/As9mbDfC9a0+T6ugBtTl70++1l0KICDhQ/YcxYldv5MrcXU4bzLtHjYQcQtZKwrv5
 gLAajLDdpkBqjcvRYvyPudSma62DqUlwd9KDPw1NfqFlCnIEXJrz2Ui6TfqkWzxUT/Z4
 8zPzmoF9JQDUTEV/njTwDNCQrIkdB4oUk+HnOvnVJLH12ReCds6PZ8sn6mWz+wpCZ9FS
 USikw6ak5X38oaI+RaCzgOR9nOnd6cu1u0IriQkVWtxZ5pYfiehnQP14m+7JmmfHYSNa
 8IIw==
X-Gm-Message-State: AOJu0YxBIxg3yF7mkooqFcDEdZHJSVTS8D/MSkpRkw9ogljaWB/atAv9
 gU+XRqFIT+JDjvldpr/w6Srvzlr8r+tzn2Sr3GA=
X-Google-Smtp-Source: AGHT+IFL0KXb4Vj6nWi8xwAQLd0pRVU/cRGrYnZOaNiks5ywMXc/P/Uz6kYPuHjldc+KihzErysyGXLt3B21r6Rlldo=
X-Received: by 2002:a05:6102:e0c:b0:457:bf3a:e7dd with SMTP id
 o12-20020a0561020e0c00b00457bf3ae7ddmr767917vst.23.1698349790813; Thu, 26 Oct
 2023 12:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231026122413.4116-1-p-mantena@ti.com>
In-Reply-To: <20231026122413.4116-1-p-mantena@ti.com>
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Thu, 26 Oct 2023 22:49:39 +0300
Message-ID: <CAJs94Ebs7wzAAPa-tOz8nDNCB4=3P3WQk0hJs-1KEsPbCBJiMQ@mail.gmail.com>
Subject: Re: [PATCH v2] board: ti: common: board_detect: Fix EEPROM offset
 read for 1-byte
To: Prasanth Babu Mantena <p-mantena@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 jkridner@beagleboard.org, robertcnelson@gmail.com, u-boot@lists.denx.de, 
 nm@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-nandan@ti.com, 
 n-francis@ti.com
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

=D1=87=D1=82, 26 =D0=BE=D0=BA=D1=82. 2023=E2=80=AF=D0=B3. =D0=B2 15:24, Pra=
santh Babu Mantena <p-mantena@ti.com>:
>
> EEPROM detection logic in ti_i2c_eeprom_get() involves reading the total
> size followed by reading 1-byte size with an offset 1. This commit fixes
> the header matching issue in commit 9f393a2d7af8 ("board: ti: common:
> board_detect: Fix EEPROM read quirk for 2-byte").
>
> In the previous commit, the value with one offset is being read into
> offset_test, but the pointer used to match was still ep. ep is the
> pointer where previously read data is stored, resulting in an invalid
> comparision of the values. The intent is to identify bad 2-byte
> addressing eerpoms, which respond to the initial 1-byte addressing
> request and gets stuck on the succesive reads. After successive read
> with an offset 1, the 1-byte data is compared with the second byte of
> the header to ensure it as a valid 1byte addressing eeprom.
> This is taken care by comparing proper first byte value from, header
> with an offset 1 byte, to offset_test having the 1-byte data read from ee=
prom.
>
> Fixes: 9f393a2d7af8 (board: ti: common: board_detect: Fix EEPROM read qui=
rk for 2-byte)
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>

Tested-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>

At least I see no regressions here.

> ---
> v2 <--> v1:
> Fix inplace for the else condition of CONFIG_IS_ENABLED(DM_I2C).
> Improved commit message.
>
>  board/ti/common/board_detect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/common/board_detect.c b/board/ti/common/board_detec=
t.c
> index 9a53884c98..869f7a47f8 100644
> --- a/board/ti/common/board_detect.c
> +++ b/board/ti/common/board_detect.c
> @@ -128,7 +128,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_a=
ddr, int dev_addr,
>
>         rc =3D dm_i2c_read(dev, 0x1, &offset_test, sizeof(offset_test));
>
> -       if (*((u32 *)ep) !=3D (header & 0xFF))
> +       if (offset_test !=3D ((header >> 8) & 0xFF))
>                 one_byte_addressing =3D false;
>
>         /* Corrupted data??? */
> @@ -180,7 +180,7 @@ static int __maybe_unused ti_i2c_eeprom_get(int bus_a=
ddr, int dev_addr,
>
>         rc =3D i2c_read(dev_addr, 0x1, byte, &offset_test, sizeof(offset_=
test));
>
> -       if (*((u32 *)ep) !=3D (header & 0xFF))
> +       if (offset_test !=3D ((header >> 8) & 0xFF))
>                 one_byte_addressing =3D false;
>
>         /* Corrupted data??? */
> --
> 2.39.0
>


--=20
With best regards,
Matwey V. Kornilov
