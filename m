Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F5DFD45F9
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 00:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA7083642;
	Thu, 26 Feb 2026 01:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FOQp/h3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA5A283AA9; Thu, 26 Feb 2026 01:08:17 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A8082A9E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 01:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-389e4330e32so2888251fa.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:08:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772064495; cv=none;
 d=google.com; s=arc-20240605;
 b=fwNMxf6o5cnyiROX8aS9cxDiFW6YYNjaKbKIB7r9slXLpZ8Tz2Gcg+tOzIxAyJm533
 JX2AZ1wnd5EASKGK0Hp98PL7ureEAgRer0WYAcz/YKxTJW68I4XepZU+PO2GkBMBhXKG
 M3u9pRlWcoypdSLN0qUeaeRms4UV8AlrpKcCnm7ywGY3V37PZU9lOp/KMWU4Ic32nPvQ
 upVQMe4Tp9Yy0AxTlEY2u3029r3+rMQfwozfoHr/NgrQh7tEKKb5kb9Nz03jIRSNd9WA
 1Ge94PccpuVQv2ogXccqt28wT6KsP+1PH3cLV4ql2N0JQKUIAJD5mYRylTRMccty+MsZ
 k+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8tpiJ17/sTTAXkkXn1NTA5Wfe3yijXOkdD5CSA6PVzk=;
 fh=urGbQOMliqaLlie5jqCIOhJo4ixxK6vDBewjmeEsa5c=;
 b=gx6zuJuqlLsXenfzP8kvSzue4vVN5bdQKUOVd8TznOHSeDJkVAx9mFdfOECBG8bGyO
 68TcauuWyiVatrmwVM17QUgQMyu7zQYlW3uHsVd1UWQu2zp/JsVOQuUwwh9FxqKyDcCp
 OGXIucfjyUXFqLpTwIlkSBDzWOc1UU8eTDdYHK0CU22qzFdfl+PHfmV8PlAGr3HJC/9F
 6EOVDW7VMqPlCabEXhC/ESy93qyiQb/gCJE5dc5/M3WZ0UhZe5dbi3jO2tALtZ8Wt5kJ
 L4xvRWYSZtDC9uqWVZ50JqL7jlJGm8zAAD+rLi1v7yzj7ctELghK259tfUVCU4RGZXfb
 2QZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772064495; x=1772669295; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tpiJ17/sTTAXkkXn1NTA5Wfe3yijXOkdD5CSA6PVzk=;
 b=FOQp/h3jNfjCi3G8sS62rRSjWPl9ZSA+es/onBfI/tXw2bu92g6oQuWWxXJgx4jjZZ
 zCjMQayh/ORnpekrcIOH0/mRaXXbwTyw6t7fNpfb21nf1dlQDscRKSPsfAkpELfVPM1V
 luOJhCgUlryNJPMtTwA/bx3IR529ghsI4jP5L9jWIZsn6PG9wZSlxZM+4PVhZLqPesr3
 xStwp4ymjwEI443oO6jSsBLtRKjBaP5XUQa+xeGXZMQiT8G/p7+ajozR08wKaqBdIw0e
 EJ2J3B95B4uLy7TuyP0NSkF624XChuMV4nYmKXlKEZo73OD77Q9/hNDeoMOmWLbR9eVO
 +DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772064495; x=1772669295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8tpiJ17/sTTAXkkXn1NTA5Wfe3yijXOkdD5CSA6PVzk=;
 b=V6HUrxnAzQh2pT93g2SkvmhVbTG8+Wtw4CKCk60t1nRYLm22oEmJWliBXxE3hoPl4T
 iSHAZatt+3Z4yVBMLiOfI3oPnuyBQlQpmLkLqgUU/1mxzKxr/sNFKvEA9hW4AEKQoN52
 FY+zn/7eSByxW+kknRuwfzidn5B+xcRMTUcaWbvn0937F8YmaY9SnPak/etujN1GGcfK
 Yzb0edIUw/8D8EU81pRuckrCMrfYgNMpEpt0C+bCwlwf60C05Ndpqxu4v0MLboQAJuIl
 GvzJvTKUNeVzW+DIB/zt6H72DZZkvp8OJw9H38wCsUAP1K2t1/pdX4lIdH871eMXjvC0
 3i0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeL5ZpXUk/GIPKo27lVBIPJ/On08bbx+TJ1hAQwvp1lXc8ZxlBLCFSgepr2s8Mu6UjNrh1+sY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7NrkbI0OyaE7i4qnsU8tt4j0i2k9Qvq1EoZ5QhMKFEOX6WyKf
 71b3FseXHWYfLZykxanHCcYIKzyTUaPWk1/jRGkSxYXnIt5nHGnRjgjPPO9fBW609EqrVB9aw9Y
 xox1VD8ktxt1MumtzjYNR49oRqZgtDY4=
X-Gm-Gg: ATEYQzxLrFm/zjKTG0VCE7jKMpddQ39Q1bGJhwMXf2rUy4BQO06SEpEwt7clHEfXJob
 BBLRgaEJp040GERqRRC1x2HSWo+rFRxLXN+llEqD1jICXaWgT5mTTYBQPst9BzMVUMmgGPWh4zi
 AR/qjlHcW6d9yOu1RjJ7OQlh629c5vjnUTpVNMpxDOnISf1/s2tc9ZjiV/nXjiPCvdu3X7IKeqd
 H54VvxGyy031xAIk3UG2rX4NBQoV19uzPChFycQ0X1p7S3/GhSjRisY9ECqlMSdH9cfkuaxjYH3
 a2cp2dqDs1M1a2UMSIMM7MMT74Qf8WMF5KVOrx2h/df6Pq+xs7ExKQrnW8/mYJXQyi1xYaCZqlr
 4kt9MGg==
X-Received: by 2002:a05:6512:39d5:b0:5a0:c5ae:ff28 with SMTP id
 2adb3069b0e04-5a109da2bc8mr109524e87.39.1772064494947; Wed, 25 Feb 2026
 16:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20260220031232.1254728-1-festevam@gmail.com>
 <fecf9c20-f5a5-d9f6-ddc0-dc8db483922d@gmail.com>
 <82b70e8b-3adb-5c0e-cf98-d5f501e0bc48@gmail.com>
In-Reply-To: <82b70e8b-3adb-5c0e-cf98-d5f501e0bc48@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 25 Feb 2026 21:08:03 -0300
X-Gm-Features: AaiRm52496xstdIjheqJLRLE-_UwTjifI0IVIk4MQgwDEWIF08bZVWSI1ySkshU
Message-ID: <CAOMZO5C9BwWosjdgJFPX8XMsrqo_rQLeTn9PLFi9JRoLw+-yag@mail.gmail.com>
Subject: Re: [PATCH v2] spl: Add generic SPL MTD loader support
To: Sean Anderson <seanga2@gmail.com>
Cc: michael@amarulasolutions.com, u-boot@lists.denx.de, trini@konsulko.com, 
 dinesh.maniyam@altera.com, a-dutta@ti.com, a-nandan@ti.com, jonas@kwiboo.se, 
 Fabio Estevam <festevam@nabladev.com>
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

Hi Sean,

On Wed, Feb 25, 2026 at 4:45=E2=80=AFPM Sean Anderson <seanga2@gmail.com> w=
rote:

> Actually, I don't think this is correct. NAND devices have have multiple =
MTDs for each
> CS, and SPI-NOR devices are UCLASS_SPI_FLASH and not UCLASS_MTD. So I thi=
nk it's better
> to do something like
>
>         mtd_probe_devices();
>         switch (bootdev->boot_device) {
>         case BOOT_DEVICE_NAND:
>                 mtd =3D get_mtd_device_nm(CONFIG_SPL_MTD_NAND_NAME);
>                 break;
>         case BOOT_DEVICE_SPI:
>                 mtd =3D get_mtd_device_nm(CONFIG_SPL_MTD_SPI_FLASH_NAME);
>                 break;
>         default:
>                 mtd =3D ERR_PTR(-ENODEV);
>                 break;
>         }
>         if (IS_ERR(mtd)) {
>                 ret =3D PTR_ERR(mtd);
>                 goto out;
>         }
...

> > Actually, if CONFIG_SPL_NAND_SUPPORT is enabled then the native nand lo=
ader is compiled.
> > Maybe we should add a separate Kconfig for it (CONFIG_SPL_NAND_LOAD) de=
faulting to
> > SPL_NAND_SUPPORT. Then users can disable the "native" load method if th=
ey want to use MTD.
>
> I have a patch for this that I will try to send this week.

If you would like to prepare a patch for the generic SPL MTD loader,
I'll be glad to test it.

Thanks
