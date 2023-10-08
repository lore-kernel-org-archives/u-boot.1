Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D2CE95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 18:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 287318652F;
	Sun,  8 Oct 2023 20:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YmjBhHr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BAC8652B; Sun,  8 Oct 2023 20:22:11 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841C386590
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 20:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso6664082a12.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696789329; x=1697394129; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiO+5o6+4Gt1jYTZMjjX7PyAh9mPpQJcgrNYe1dR8iU=;
 b=YmjBhHr/XVNz3iNnq+lcmzYGbC9p9pJf9IssDhbqIDajuiqx2DrbTtxnAY48yiRx/e
 PZANCT1vzVBkv9zx8z0qLZjHr+q9d/DcZF0bv0IfuFcTOwygv81xNkjw4o4pusbniNKg
 Qej4aViayKZOKn6/3QrRHYrpKK930d84cEqyUGUdVbiiMgnXAcnoOQweyq5Woz3hwFQj
 LiYMWQdzIn5He289GDIRyQwj6DOZEN7jx/CszunBSwyXopZQVZpOhs53eYS9xQkrGuG6
 KDku1L3bvgbQ3P/OmSit8UMmaTiTIMM6SXEa2G+towndFQbiSym5jZpPPAXKi9rziVW/
 yoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696789329; x=1697394129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiO+5o6+4Gt1jYTZMjjX7PyAh9mPpQJcgrNYe1dR8iU=;
 b=WQsSodo7egoMPtDvXD9GKYXEFZZ5/iCZyVkcWcVW0asEUtgkW5t8vpQrDCNcuIRHSG
 trl17M33uB/VtCrFZAj75etfwDZJiWUV479uBVebJF5w8wE93EjC6s5D1VOi2bftl9vC
 FM8c9ZimpKyaWZW4PcVXX8omFzejRJLMRW6JKrRv5dupRZ5F6CeX6mKsViKkaZPYS1ms
 nx2ZKIAJE1/8OiPGs7//aGsiD7TwKA4gOGfzhvspJ5xWpUxLpJcNqR7w+EeWXg7eka6m
 0hPS1mju7TgqxsaV63igTrDjpQpUQiNmpJl9LAlBkBFMSNzql4Y0vMu10kwa34BFTN6H
 jndQ==
X-Gm-Message-State: AOJu0Yzxbe+q4kBN7ZOzkva7eaYZjt1OmlPj3fNXdidafrsQAgyZNRAn
 CN5WpSfvHD95hO2gwqE365WfUOKoN1sj9TcnpVY=
X-Google-Smtp-Source: AGHT+IGnKZNjuvxGHhBmJwpuZhVvt+VKnDmBL7r78vECGCdynkX+26q7+jalKJF8uZJMgDmQAZzEbtLebG6V+j0dT0I=
X-Received: by 2002:aa7:c248:0:b0:534:6b51:83a3 with SMTP id
 y8-20020aa7c248000000b005346b5183a3mr12744798edo.1.1696789328710; Sun, 08 Oct
 2023 11:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231007155535.1699567-1-benwolsieffer@gmail.com>
In-Reply-To: <20231007155535.1699567-1-benwolsieffer@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 8 Oct 2023 19:21:57 +0100
Message-ID: <CALeDE9MX8FiayfjY=Wv2y3n9DBkTAqQsqnNjDkCXDDUeCSMLag@mail.gmail.com>
Subject: Re: [PATCH] arm: rpi: explicitly enumerate mmc boot targets
To: Ben Wolsieffer <benwolsieffer@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>
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

On Sat, Oct 7, 2023 at 4:55=E2=80=AFPM Ben Wolsieffer <benwolsieffer@gmail.=
com> wrote:
>
> Using the unqualified "mmc" boot target causes the Raspberry Pi 4 to
> fail to boot. c771e5b explains this approach as follows:
>
> > We don't need to specify the mmc devices individually, since they are
> > used in order from 0 to 2, and standard boot uses that order anyway.
>
> In practice, U-Boot first attempts to boot from the unconnected mmc1
> interface, and, when this fails, moves on to attempt the USB and network
> boot targets rather than trying mmc0.

Really? It shouldn't be enumerating it if it's not defined in device
tree, I've not seen this in my testing.

> This patch explicitly enumerates the mmc interfaces, causing each to be
> attempted in turn. This matches what is done on other boards, and allows
> the system to boot successfully.
>
> Fixes: c771e5b8c2 ("arm: rpi: Switch to standard boot")
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>  board/raspberrypi/rpi/rpi.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.en=
v
> index 30228285ed..02210b97b5 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -74,4 +74,4 @@ pxefile_addr_r=3D0x02500000
>  fdt_addr_r=3D0x02600000
>  ramdisk_addr_r=3D0x02700000
>
> -boot_targets=3Dmmc usb pxe dhcp
> +boot_targets=3Dmmc0 mmc1 mmc2 usb pxe dhcp

Why are you adding mmc1 and mmc2 if they're not connected?
