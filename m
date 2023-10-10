Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C6CD80A1
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 10:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143AB86C67;
	Tue, 10 Oct 2023 12:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCZKrgYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6253E86C9B; Tue, 10 Oct 2023 12:22:24 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ED5786940
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 12:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5346b64f17aso9697409a12.2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 03:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696933338; x=1697538138; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/limYv85+Bffk32cql7bTZyebEA6mf+L3vEszdnqvEI=;
 b=SCZKrgYiUdyf7z341lzf/x1WjJR09oWUiNmnehwxffnwAFCtbxnRbZAkP+CGVjlrZx
 tcbPDR2zserR4p8s/G4TDCdJUpPeD+bq81W8mcBsOGHK/li8rJbruiHm6vW1H3K3daA4
 XewP8AIrWJVGbaPjYjFgPtOwWgm86i59F6GJfyXvI1Z4Q2C+QLmT4Z//Y6pgULfC511c
 io+qw+EkTqURLEOpR8yMgBIt1GnPlD76o8EBDrAWtM0X/sphwAfTGoElLlA4/+4ZqfW8
 3SnwQEmqyogYANXF76UbfaSoiSvu9Q33avxBAgrrnoLxRxpmVzr5DEPS8qKLOQmh2xA2
 T5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696933338; x=1697538138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/limYv85+Bffk32cql7bTZyebEA6mf+L3vEszdnqvEI=;
 b=U/FXja/IZHd4/wDKAhmpZ2It56E23+8uoCGTOLBo6bQHCLsG1K22Nk1Xx89r1Gy+u/
 QgNbaEyePeAYeMAqTev6esn2X+NRlKD6cEN4lZv9cubiP2+hgDfLef3gIu2w9ACe0irm
 DE3NtK+h+cYwyeIMmKSDYUzFHMR5K5Y8Uh9jOQBC6t3fHLs+N75+dv9E5Vp0aMQbsGOe
 jviV+a2uwIwGlXrFDkrMme59vY9HoFXgb3p/dbW2+0pX+XWkjz1o3YJtYVjP448nPdQd
 iKdOUNTXDEW51aVZgFl1/KBooaRVR8mumZkrPn0aJZx56zhQwpsnd5UiREHuycBkg2aw
 +M2Q==
X-Gm-Message-State: AOJu0YwpPU9dqdeedgBZQrcAqlRGw71DzvC5+fd7tUPcXYM9kznnNevq
 B6kqu1k8e22mWzHCS3fAqUHSjUF1VgU2hJ+CwWc=
X-Google-Smtp-Source: AGHT+IGGcf7UccCvUKR+Z0yNk/UeNDgpQFfzb5sbam5GUHvGs2VudP1SZSHDBcnNYtIqC+XKiIjYanrX9bTB1FfwAOY=
X-Received: by 2002:aa7:c695:0:b0:523:4acb:7f41 with SMTP id
 n21-20020aa7c695000000b005234acb7f41mr16076234edq.14.1696933337550; Tue, 10
 Oct 2023 03:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
In-Reply-To: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 10 Oct 2023 11:22:06 +0100
Message-ID: <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
To: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: "mbrugger@suse.com" <mbrugger@suse.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Tue, Oct 10, 2023 at 10:26=E2=80=AFAM Guillaume Gardet
<Guillaume.Gardet@arm.com> wrote:
>
> Hi,
>
> U-Boot 2023.10 does not boot from uSD on RPi4.
> This has been found on openSUSE Tumbleweed. The only diff we need is:
>   -CONFIG_OF_EMBED=3Dy
>   +CONFIG_OF_BOARD=3Dy
> To use firmware provided Device Tree. But that should not affect the mmc =
behavior too much, I think.

I've been booting Fedora fine on a RPi4 BUT there's issues with the
display turning off [1] when the accelerated display modules load
(vc4) as a result of this patch set. Can you confirm if that's the
same problem you're seeing?

[1] https://lists.denx.de/pipermail/u-boot/2023-October/533158.html

> 'git bisect' points to:
> **********
> commit c771e5b8c2a186fb072b6c6f571d4a3cc86efba9
> Author: Simon Glass <sjg@chromium.org>
> Date:   Thu Jul 27 15:54:28 2023 -0600
>
>     arm: rpi: Switch to standard boot
>
>     Drop use of the distro scripts and use standard boot instead.
>
>     We don't need to specify the mmc devices individually, since they are
>     used in order from 0 to 2, and standard boot uses that order anyway.
>
>     Signed-off-by: Simon Glass <sjg@chromium.org>
> **********
>
> The following patch fixes the boot from uSD on RPi4 (not tested on RPi3 n=
or RPi Zero 2 W):
> **********
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
> **********
>
> So, the comment from Simon " We don't need to specify the mmc devices ind=
ividually, since they are used in order from 0 to 2, and standard boot uses=
 that order anyway" seems wrong for the RPi4 case.
>
> Cheers,
> Guillaume
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
