Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC22CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 818308307F;
	Mon, 11 Aug 2025 18:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fsqc6/5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567F831E1; Mon, 11 Aug 2025 18:46:32 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96B68304F
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mcarausu@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-33245e653bbso29773031fa.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754930789; x=1755535589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L0pB9haaurtUtb0uEZBNgOUo0jSGhPLXk8dw5uZpKVY=;
 b=fsqc6/5Lxvo500HcVYRCuPKIVm1gr8rWsYLQDx7v+c8ACTHhJS7N0iZGRTQmtRZJNQ
 ZdDn/tQIQsNiWvrlRYg4AYr0EAxo/IbOUVoz37GYfNThwXth+nfXICmNWYuW/hzdTFBN
 cKllzSHM4SuPPAhgduHebaqHKIifTi2EndH5/7ZTzgsSlXrQWDKVSL3LTZTzlvjqv9Nl
 9YfV70citrzdk1pJa7+HnlPg5B4E94RcF91e34oMq918U0As3Dc8UE9+FtXb3gR1bnv7
 BRHxu2c+OT52Meza+eqiMdw+STmD3MwbxGJmFq7KGYI+dMaGhYqJJ3LQKezE0na+OFeL
 maNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754930789; x=1755535589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L0pB9haaurtUtb0uEZBNgOUo0jSGhPLXk8dw5uZpKVY=;
 b=gm+YV1DB9yv4SQSn6fmH6RvUKGCMq6znsoaekFYxEZUkbOke4UxKo7tqVc6oeMb1cZ
 AecYN7mZAylGPmyBr+6OMtFCMhMsn9OEE8ZFoRRiPlUxJ+KfVZkcZ68QkuWiirZRrNFb
 pO4Px2jAEKPBoxTRHJzdcgZ+JSOCYzI1WdtKv9IWo0TTJuaNrgCfBSnNxt/sFb5pGmen
 SjQpXtSPEaOo5ngT1a8IGi2asmlM32us+Sz3bUmH39XUaF5/l8xu1oCP4pzRgZGVbExY
 nbKlpex6Oeb5SDIWgO1JGYuGr3B6IzL5FxFRqFupzCR6uuTX5rI98PJFKLhynHRJNd2Y
 FzZg==
X-Gm-Message-State: AOJu0Yw28qYAOG/eBwXZVUEiyR64Kyq60K9EfR78d2LOKr9npWTDiHfH
 tv2oc+h/v5xXH+tAcmCLylm8Ux+PgfIXUVJzfK5S6l4n3L0lh5Q3VBUcwDRya6nWECYoIsTkeyP
 fsA+P26+QO9quuL1oJCEW+1/GlWR9DC48yd7L
X-Gm-Gg: ASbGncvLYP6XKSqYuAm3iYQsSUyriJiZyCvSqU4MoIJcjsCNNv5dGT0B5HwuxtPcA5V
 SUcSShT5ZgYDJGp11i2cWwhHL1g3PUVhSSTwGTs5XMJqoIpZ4elxWo92u2JW+f4KALTV4Updj43
 B3qrtbxavVl5dy753v3WVF03DVfiSMjKJJQniki3fp2/eTJE8OMTJ95R4DrTfKjC++bbdBJhTXQ
 WLevadXn3S3Hk4Y
X-Google-Smtp-Source: AGHT+IGLfxYdH9G2nsoE6ucuqwIr8S+zEG/DAOjGGc3iaNrl5W6cQoRybTriIT4NWEf5JCF152Vt/wYOlrP4DzL2LZM=
X-Received: by 2002:a05:651c:3247:20b0:332:643d:7f49 with SMTP id
 38308e7fff4ca-333d7a70475mr661061fa.9.1754930788797; Mon, 11 Aug 2025
 09:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMFYzVwEtRBndhOaog8wStZeBTZvei_gdZ8=6xM2y1=SU5R1cg@mail.gmail.com>
 <112df3eb-96b0-47bd-8fdf-258e25bfb390@cherry.de>
In-Reply-To: <112df3eb-96b0-47bd-8fdf-258e25bfb390@cherry.de>
From: Mircea Carausu <mcarausu@gmail.com>
Date: Mon, 11 Aug 2025 09:46:16 -0700
X-Gm-Features: Ac12FXzDBtGkCHIwZk-qmS4x4E8fN8Nc0ZeJXSQCIzYj_1XtimrY-In2p9cJ_8c
Message-ID: <CAMFYzVyLLzhH8u565AvTxBYL_5_g0WLjpaw8Pb61PytyxdTM5Q@mail.gmail.com>
Subject: Re: How to avoid the need to run 'env default' command on modified
 env variable
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
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

Hi Quentin,
Thank you for your reply.
I wish it would be that simple:
- as mentioned we are using RAUC for firmware upgrade (https://rauc.io/)
and A/B partitions. RAUC needs some u-boot env variables to point to the
active slot to load and it maintains a retry count.
(all of this is implemented with help from u-boot env variables, which have
to be writable).
I thought of erasing the entire u-boot env or corrupting the CRC signature
to force loading the defaults. I can do that from Linux also - prior to
reboot.
In this way I lose two things:
 - the active slot info that RAUC uses to point to the partition I just
programmed.
- the MAC address of the eth interfaces - perhaps for this there is a flag
to protect it (i.e. write once type of attribute).

I can think of working around these  obstacles - just fearing I am
reinventing the wheel when u-boot may already have a simpler way - hence
the question.
If there is no simple way in u-boot I will probably end up writing a RAUC
hook to do some of the automation  I need before rebooting.
Thank you,
Mircea


On Mon, Aug 11, 2025 at 9:00=E2=80=AFAM Quentin Schulz <quentin.schulz@cher=
ry.de>
wrote:

> Hi Mirceam
>
> On 8/11/25 6:30 AM, Mircea Carausu wrote:
> > [You don't often get email from mcarausu@gmail.com. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi All,
> > apologies in advance if my question is trivial:
> >
> > I am changing some critical variables in the read-only / compiled-in
> > section of u-boot env variables via CFG_EXTRA_ENV_SETTINGS in
> > include/configs/<my_board.h>
> > All I want is to have them take effect automatically (i.e. without havi=
ng
> > the need to stop in u-boot console and issue the env default command).
> > I see the new values if I use the env default command.
> > Since I am applying the new config via a RAUC bundle and some systems a=
re
> > using automated testing it is not practical to issue env default on eac=
h
> > board.
> > Is there a way of telling u-boot to load / use the read-only / built-in
> > values instead of the ones stored in env storage?
>
> Build U-Boot without external environment support?
>
> E.g. with only ENV_IS_NOWHERE?
>
> You can also entirely and permanently erase the stored environment with
> `env erase` if you have CONFIG_CMD_ERASEENV enabled.
>
> If that's not fitting your use-case can you provide more information
> please?
>
> Cheers,
> Quentin
>
