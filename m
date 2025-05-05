Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD6AC3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63168213D;
	Mon,  5 May 2025 14:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=chewies-net.20230601.gappssmtp.com header.i=@chewies-net.20230601.gappssmtp.com header.b="V7Y7mk8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F31181F7E; Mon,  5 May 2025 13:57:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E1380BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 13:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=chewies.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=raz@chewies.net
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso22859366b.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chewies-net.20230601.gappssmtp.com; s=20230601; t=1746446246; x=1747051046;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cz9204thALwygq5pb5iv94d9PsoxiBfRcwOeexHh2ko=;
 b=V7Y7mk8UFOgsMEtnL7iNaessv9BxNXV055SPiANipBhR6mEEkJAXYrwTZa+ZpWSXBv
 fHoKod6H8RnN5MhThWwZ789+hvlBYX9MG8nzEVrKIPcm3LSZE2xwZxpKYIzp37ONFnt8
 /QboRquV7UAOGoDTw2IEzC+nHaRCWQESdVH5aZMCNYvnM+aCJA3u1zIPvVPy9jeFIzM2
 lrPKEf0seWaq+6LIbHX6q8aPRr1ohAmQ6OqDp8hhd7i2+Z/GGchdKKTzp2llo/A+NMX9
 ZIqpbvpVbNR09CWcX93CgsGK8ep+GJ3gQSU738DamVcOngFJtE01WIaqR7FuxqVIXjvT
 2Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746446246; x=1747051046;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cz9204thALwygq5pb5iv94d9PsoxiBfRcwOeexHh2ko=;
 b=WsqWn2r6zZ+E+eow/eGvE7ZXLqhB7fI/XHXr195Qeyv9fArOS7ee3TeSLcTgVRB/zV
 mllHH8S1fm7dmp/jR0vBg8beWuAU2UBxpTyw3TNVEXLPnUbNNqGaSj5eEAYZPJrIrWPU
 /zMcLJA7Q/9mBGZaz4hVNy2wvBU9GyWd+LQzyjPOgA42F0+lAX9nP/JHZen54fgfUccK
 GutkANmyTxIBNAahfsKfzvCddMe4kchpQsGyEZcucE4A3bS0lcXooRHK6UCCiYbSHwSb
 5SBM/funChHQZl+M3KdRBPfgZ3jLqLVpfxjcQ0nLBfN7QwGJKVt5umQzCLhlBE/8kbcJ
 +SOw==
X-Gm-Message-State: AOJu0Yx5brxuWkrZvytfh5WOD2VCQv9dGCCyWWappJdBc3iYwnn7pxL8
 pFrQ+CCqfLYgp2mYrflsZbc8mrvXHkGxlV0/oe2BEDITomW5Q/8CK7hqvhsunFs4sGQMVrfvBp1
 PD3MqOoBrDSpCecB0hllhqvwnL4+29Vn2W5HT
X-Gm-Gg: ASbGncsy0bcPwoGcXgqPRwk9J1LsfYAWSuSmbUgx/shkvvSD/gDLBywkVfRkAYq+Pm4
 bXzIZcL6GLNZaSyd/XynaaSXsG5kAmNHUoTktWbv6n6Bw/jO00SKOv5k6gdA3ePWSwnGU3dPw8i
 9yXsZ4QhFykx1z12c3bvA=
X-Google-Smtp-Source: AGHT+IG5pXqbOSY5LRIkAYuR+FZDlL1W5qAAW9lVh3fATnQS6jZmSGJEAsAVuYq1xm1ejAs3YnkUigf7mEMz+BKK9HE=
X-Received: by 2002:a17:907:9707:b0:ace:da41:a037 with SMTP id
 a640c23a62f3a-ad1a4ab7cd7mr628839466b.42.1746446246411; Mon, 05 May 2025
 04:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUiLubXaPGZsE6y_X6mBTD1ZK-2w82fbRD5z8+MKvDZtZKOtA@mail.gmail.com>
 <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
In-Reply-To: <f073dad7-337e-499a-8cb5-9dae0842de17@linaro.org>
From: Wayne Schroeder <raz@chewies.net>
Date: Mon, 5 May 2025 06:57:14 -0500
X-Gm-Features: ATxdqUErTqOPiJBwH0MUNhMj9SeKwQI9gpJe3JUIs3lEO1gBgWFQXwc5mUNFHwY
Message-ID: <CAEUiLuZ+5Y6+TQsq6XrGeMJb5UVGtf5BsoAdK6R2JNY=vLFUOA@mail.gmail.com>
Subject: Re: Odroid n2+ usb broken on reboot
To: neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 linux-amlogic@lists.infradead.org
X-Mailman-Approved-At: Mon, 05 May 2025 14:38:02 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

It works at reboot with USB reset, but fails at a fresh power on now.  I
had to remove it unfortunately.

On Mon, May 5, 2025, 2:07=E2=80=AFAM <neil.armstrong@linaro.org> wrote:

> Hi,
>
> +CC u-boot-amlogic@groups.io
> +CC linux-amlogic@lists.infradead.org
>
> On 05/05/2025 00:34, Wayne Schroeder wrote:
> > Hello.  I am not sure if this is a bug, or even related to u-boot, but =
I
> am
> > reporting it here because it was easiest to resolve via a u-boot change=
.
> >
> > I am using u-boot-2025.04 (source) with a mainline linux from Arch Linu=
x
> > Arm.
> > Linux alarm 6.14.4-1-aarch64-ARCH #1 SMP PREEMPT_DYNAMIC Sat Apr 26
> > 13:02:01 MDT 2025 aarch64 GNU/Linux
> >
> > On my odroid-n2+, the USB ports work on the first boot after power.  If=
 I
> > run shutdown -r now, or hit ctl-alt-del and otherwise reboot the system=
,
> > the usb ports do not function at the next or subsequent boot up.
>
> I think it's a very long term issue, USB lacks a proper reset at probe on
> warm reset, does USB still work from U-Boot after the reboot ?
>
> >
> > My apologies if this is not applicable to u-boot because it is a linux
> > issue--I am not sure what the source of the issue is, but adjusting the
> > u-boot .config after make odroid-n2_defconfig resolved the issue
> entirely.
> >
> > I am booting via extlinux/extlinux.conf and have adjusted my
> > CONFIG_BOOTCOMMAND before build to execute a usb reset prior to the
> > existing run distro_bootcmd.
> >
> > CONFIG_BOOTCOMMAND=3D"usb reset; run distro_bootcmd"
>
> I'm pretty sure there's driver callbacks we should implement to do the
> same here, I need to check.
>
> >
> > This has allowed me to reboot the system and successfully have access t=
o
> > the USB devices such as my keyboard, mouse, and root file system on USB=
3
> > SSD.
> >
> > Thanks!
> >
> > Wayne
>
>
