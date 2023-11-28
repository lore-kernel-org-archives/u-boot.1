Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BB0C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 23:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECC287788;
	Wed, 29 Nov 2023 00:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGqs7TG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 032F887779; Wed, 29 Nov 2023 00:21:18 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3F8386F7E
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 00:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2858eda2919so1228430a91.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701213674; x=1701818474; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTEizfZjcoLmjnIQRQtHoTsQb23fJN6wLS6I2FIxSAg=;
 b=AGqs7TG6veHvwabVyaRJKqk+EKb9+c3uk/HAAAPgfyqBWFUlM1O4h696h0BLRKx2ZM
 t1b+8USqp2Jvg3yFqRSnRyX8zgIB+QHGw8VP6zg/x1cIAsk7ZfmfsY1ehMnDvpcKiIHo
 zpOJ8z7Snfa1y+gha8gjC7/HFXDMyRMwDvU8Oz1JUPWAdpez/5b1a9SdPYxdQGry3csb
 x6IItQoEzHSyqVgYvbw+onTOlqhBxced211CuB5S8vWauQ3drcMlue1NXna23pOtEiEB
 Qe2TbUiH/bLrjP85OsJ8/Qs1xD5opsN0LRpDjFICx3hNzlWUioa29TAs5TgX1k4X026k
 NVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701213674; x=1701818474;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTEizfZjcoLmjnIQRQtHoTsQb23fJN6wLS6I2FIxSAg=;
 b=Sy1Vgd7Ht8yywv93CLEBneGHYAGpXw9YKWE0UwN04GqBzmysIgn3kS5CX1su6qj9iY
 VY+6y9leWMwYLDMRd6MTeSQTf716Av5sUAp0AZ1B+iRsKnS+QpcGNY+UHg95O/bWzDKp
 YY5FtJ27DBNBzVwIvUpfv9mmmn5jcTn+479die+TZ7JrKkyvqxNMvdkJcRMAZvJafaio
 nz+Sez7h3Bi1pzWCJB3YR1+awfWKRaHiSq3M11p6q+nkHEVxcA+XykU7/dPIdll5LX2T
 Ui7ZHxDQXvbfnKT2W9lfw+VdE4RWjLVYBBlZqudhul05KtspTvUw8E3G0KgTGh8Pcw/m
 3QNA==
X-Gm-Message-State: AOJu0YwE0WL2rNE1DAkCErrEmlVVb/3m2HgKtv5c8IX/11ugm6Ps1yVf
 jsi6cYz5iiNyO27/E6rmy+0QxBElrjCFiLhKtgw=
X-Google-Smtp-Source: AGHT+IH6r4nMdqHM/pIfR3uSPXq6O7Di0/uFnbt8RFEw/yXqDBOFNXzW7FFWuTfZ5OyAUMM/UnRvb39ukqZspq1TKLg=
X-Received: by 2002:a17:90a:d258:b0:285:b6b1:a55e with SMTP id
 o24-20020a17090ad25800b00285b6b1a55emr11594997pjw.3.1701213674111; Tue, 28
 Nov 2023 15:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
In-Reply-To: <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 28 Nov 2023 20:21:03 -0300
Message-ID: <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Tim Harvey <tharvey@gateworks.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, trini@konsulko.com, goldsimon@gmx.de
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

Hi Tim and Maxim,

On Tue, Nov 28, 2023 at 8:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:

> Hi Maxim,
>
> I've tried this series on my imx8mm-venice boards and find that basic
> ping/dhcp/tftp breaks:
> u-boot=3D> net list
> eth0 : ethernet@30be0000 00:d0:12:78:f8:01 active
> u-boot=3D> setenv ipaddr 192.168.1.1
> u-boot=3D> ping 192.168.1.146
> eth0: ethernet@30be0000 00:d0:12:78:f8:01 active
> Using ethernet@30be0000 device
> pinging addr: 192.168.1.146
> ping_tmo: ping failed; host 192.168.1.146 is not alive
> u-boot=3D> dhcp
> init already done for ethernet@30be0000
> dhcp_tmo 20/20
> dhcp_tmo 19/20
> dhcp_tmo 18/20
> dhcp_tmo 17/20
> dhcp_tmo 16/20
> dhcp_tmo 15/20
> dhcp_tmo 14/20
> dhcp_tmo 13/20
> dhcp_tmo 12/20
> dhcp_tmo 11/20
> dhcp_tmo 10/20
> dhcp_tmo 9/20
> dhcp_tmo 8/20
> dhcp_tmo 7/20
> dhcp_tmo 6/20
> dhcp_tmo 5/20
> dhcp_tmo 4/20
> dhcp_tmo 3/20
> dhcp_tmo 2/20
> dhcp_tmo 1/20
> dhcp_tmo 0/20
> DHCP client timeout

I got the same result on a custom imx8mn-based board.

> u-boot=3D> tftpboot $loadaddr venice/Image
> init already done for ethernet@30be0000
> TFTP from server 192.168.1.146; our IP address is 192.168.1.1
> Filename 'venice/Image'.
> Load address: 0x48200000
> Loading:
> ^ cntl-c after a minute or so of no output
>
> Is there some basic config here that I may have wrong?
>
> Also, while trying to see if I can determine where things broke I
> noticed there is build breakage starting with 'net/lwip: integrate
> lwIP library'
> In file included from net/lwip/lwip-external/src/core/init.c:38:
> ./net/lwip/lwip-external/src/include/lwip/opt.h:51:10: fatal error: lwipo=
pts.h:
> No such file or directory
>    51 | #include "lwipopts.h"
>       |          ^~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.build:256: net/lwip/lwip-external/src/core=
/init.o
> ] Error 1
> make[1]: *** [scripts/Makefile.build:397: net/lwip] Error 2
> make: *** [Makefile:1858: net] Error 2

I haven't noticed this build error here though. I applied Maxim's
series against master.
