Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6764DC47DB3
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 03:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E8187BCB;
	Tue, 30 Jan 2024 04:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NwqWQMGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA89687BC6; Tue, 30 Jan 2024 04:00:11 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3990A87BCB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 04:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gch981213@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc64926af85so2785790276.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 19:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706583604; x=1707188404; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9AinedqN5a23j8ZNdRuRz3oB1vBeWeHq7pPCHPeFpYI=;
 b=NwqWQMGutoeQ83W2dLI+2nA0PLTmL/76/MEhwkU/mhF83h77PBx1W/T1u6opxrBLAC
 JrkoKsLhIudy+t5+sONt0K5348ZfHFpiW/O2B1+uMrSKLPSm0Zi9SB81fyRbY/ZvVX7D
 0B2zC9Hlfronu6tNUcDjk3iqG1VR/qX3zGB9hbe6JfPjMCqfNeyc+N8cxNUlavZZM8LK
 IDfs5bktUoyQ9rogpjyZdgEOzLpmTTg56GmOdK3NpHDP37MDPFX9gggiRptOQ08gvimE
 EYQZqZvOrRKKyDpNU9Mksp5+jcA124xo0LFGtIjpmHwJAVi38pm3uDiAx384swjuZGb5
 2UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706583604; x=1707188404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AinedqN5a23j8ZNdRuRz3oB1vBeWeHq7pPCHPeFpYI=;
 b=mH0aOeTMQ8/oJCiDQv2uosvDGo5fqkwT4Ajc0I4iYDWtQDvoH28iYl2jc8UV706AhV
 cvzqsDi1My/qXyDz+NiQI3m2SLS37El4LS/XWsLngttjcziOlO9BKWxJwC6DY1/jr7Sx
 bmIawbvSw41DdR3JmNIwvxTeRyfnxmdUqUV8ughWJagEhP0T/2uninogTLfUMhvlC7Kq
 freKCMM52My6dIYwkOwB/mIUbWe+b3vz+tNhlXtEf1ZJ/E+OjFFDt8PJRu1771hnuMnJ
 yel333T/BngB1U0JDXt0c1yCfR+EZBhpxtw2wHc6dUcDw8rPtrY55cdHAEUZeVLohXC7
 k8NA==
X-Gm-Message-State: AOJu0YxvyI6GA/l6Yc50AtSBSfCMKcTgY/PgSteVSB/+HPpkOp08bMgw
 mDnlEJISXYmPxOzgWWwgV+mzH8026+9bXfGB6jahE73x2pvi4Q9Sy9UCrKhMWEY0GHDwcEl46xh
 IHWrQFdK4UwRbhCFuBBZ6N19ZcQ8=
X-Google-Smtp-Source: AGHT+IGGbkcyqEhUK6J+QjJKin3B2BB5a3FyF8ieekc1Tt5hc6phHe/Zn3a53JXvgVFC2vZvrdVAfa5Vahkn0ASZ35A=
X-Received: by 2002:a25:eb0a:0:b0:dc2:5436:7acd with SMTP id
 d10-20020a25eb0a000000b00dc254367acdmr3450207ybs.42.1706583603875; Mon, 29
 Jan 2024 19:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20231228052915.121433-1-gch981213@gmail.com>
 <20240121011528.3fb06011@minigeek.lan>
 <20240129165555.63ddd462@donnerap.manchester.arm.com>
In-Reply-To: <20240129165555.63ddd462@donnerap.manchester.arm.com>
From: Chuanhong Guo <gch981213@gmail.com>
Date: Tue, 30 Jan 2024 10:59:52 +0800
Message-ID: <CAJsYDVLTW7PvUF8Gc+8YL+xgrrZmCNJpQM-dMriF3=r2sajU_w@mail.gmail.com>
Subject: Re: [PATCH] sunxi: add defconfig for nanopi_duo2
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, 
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>
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

Hi!

On Tue, Jan 30, 2024 at 12:56=E2=80=AFAM Andre Przywara <andre.przywara@arm=
.com> wrote:
>
> > Judging by the DT, this board has USB-OTG wired up correctly, so we
> > should enable it, by adding:
> > CONFIG_USB_MUSB_GADGET=3Dy
> > This would allow access to USB Ethernet, fastboot or UMS devices, which
> > prove to be quite useful for U-Boot.
>
> So I merged this patch, after adding the USB_MUSB_GADGET option.
> I just see that the CI complained about a missing maintainer entry, I wil=
l
> fix this up in a follow-up patch.

Oops. I forgot to follow up your previous email.

This board does have a working USB OTG port.
Thanks for fixing the patch for me!

--=20
Regards,
Chuanhong Guo
