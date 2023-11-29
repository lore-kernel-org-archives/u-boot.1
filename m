Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4590DC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 00:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5011A86D12;
	Wed, 29 Nov 2023 01:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="0lAXk8Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D93B86D93; Wed, 29 Nov 2023 01:10:43 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A330486BFA
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 01:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a00d5b0ec44so848895866b.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 16:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1701216638; x=1701821438;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4LrE0IUnHg5C2ih9O5bf47BmuQHK9vBOmy5sGjwimw=;
 b=0lAXk8UzZzO+GdQhLQdtZjNJCYz042TxnZlCjZZ0HryNqLD7Hp3/KHZ5TNKTAUIqHW
 PXZTbeSg8HSSxoy46/MJ1IBcxRbpYncalAM1FPWQS7aWsSN4BhSGusoPp08HSWZ6im4x
 qT+UzUFEWU6zAy179o8vbl53SQ5bEa2soYEgR/Z6js4lb2hmT53zROpDhgjKtWLCHy/9
 r+4tfLDCi9VvZ5FigXwjlNsLXMoKhyVAY4ffhlFK1EByY30zjWqP1CYhwMa8Jyi87nPy
 3B2EzbSnqLWhi92wJF5wja8rd+1fpY3+HSYKKQCiXELKgWYEEaOdO8NeUtT5dPvhiV3o
 hCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701216638; x=1701821438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4LrE0IUnHg5C2ih9O5bf47BmuQHK9vBOmy5sGjwimw=;
 b=eOmou8FPN4gbo56DGY2zubdqfYusVlXf/CkJe/3ZraZ7Q02cs3B95H7y272pocFiM4
 wZrRDBXqJdT1nv8Oinou6ISpygxGSackBoYKe8uN9IGFJQwqPhNph0NmJrhcB0i4pSqI
 aKQSH3RfxxFlerLQXLUKptW8KnSV+D5OcKW/kBkAui4uiXIwv14bEbGA4nX+ohkYwD9h
 0dQtgBdcGHsEdYyleNvmGK2UCCm7SKjQsw9xsD1jrsHHBfvf5vpv/xE2Kb+y8qYHplqj
 mpnmupErPITx7zsnm3zKw63OJXv40P3PfvHSQgsgab/vPIw4y8/tYksItjOwnGjRm13p
 l8gQ==
X-Gm-Message-State: AOJu0Yx9AFCMIeemhQmglhSKK4XFHa8joOGha6w9XTiUp+ybzU/bMAO2
 EQKEBakTwt/8WZF4eXIK/8XFZFb7/L5aOrVGj88IEg==
X-Google-Smtp-Source: AGHT+IHw/vWAVbLp4FZPPOj6xrWN/g2PrYDUft0SjHXtfLivkHwxibVB6oATj13Y5u3GWQT1e7rW3p/XG75N0jy1vzE=
X-Received: by 2002:a17:907:1603:b0:a16:f36f:7517 with SMTP id
 cw3-20020a170907160300b00a16f36f7517mr741825ejd.56.1701216638013; Tue, 28 Nov
 2023 16:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
 <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
In-Reply-To: <CAOMZO5Dj6RUB1ktE9Adp0UzwGev1Rub7KBPOVC=GOGb45feAbg@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 28 Nov 2023 16:10:24 -0800
Message-ID: <CAJ+vNU3Nun6WWGq-1+ZNUwsEkQXuE4NE+AUiU_ttr+Y+AbXDhA@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Fabio Estevam <festevam@gmail.com>
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

On Tue, Nov 28, 2023 at 3:21=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim and Maxim,
>
> On Tue, Nov 28, 2023 at 8:05=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
>
> > Hi Maxim,
> >
> > I've tried this series on my imx8mm-venice boards and find that basic
> > ping/dhcp/tftp breaks:
> > u-boot=3D> net list
> > eth0 : ethernet@30be0000 00:d0:12:78:f8:01 active
> > u-boot=3D> setenv ipaddr 192.168.1.1
> > u-boot=3D> ping 192.168.1.146
> > eth0: ethernet@30be0000 00:d0:12:78:f8:01 active
> > Using ethernet@30be0000 device
> > pinging addr: 192.168.1.146
> > ping_tmo: ping failed; host 192.168.1.146 is not alive
> > u-boot=3D> dhcp
> > init already done for ethernet@30be0000
> > dhcp_tmo 20/20
> > dhcp_tmo 19/20
> > dhcp_tmo 18/20
> > dhcp_tmo 17/20
> > dhcp_tmo 16/20
> > dhcp_tmo 15/20
> > dhcp_tmo 14/20
> > dhcp_tmo 13/20
> > dhcp_tmo 12/20
> > dhcp_tmo 11/20
> > dhcp_tmo 10/20
> > dhcp_tmo 9/20
> > dhcp_tmo 8/20
> > dhcp_tmo 7/20
> > dhcp_tmo 6/20
> > dhcp_tmo 5/20
> > dhcp_tmo 4/20
> > dhcp_tmo 3/20
> > dhcp_tmo 2/20
> > dhcp_tmo 1/20
> > dhcp_tmo 0/20
> > DHCP client timeout
>
> I got the same result on a custom imx8mn-based board.
>
> > u-boot=3D> tftpboot $loadaddr venice/Image
> > init already done for ethernet@30be0000
> > TFTP from server 192.168.1.146; our IP address is 192.168.1.1
> > Filename 'venice/Image'.
> > Load address: 0x48200000
> > Loading:
> > ^ cntl-c after a minute or so of no output
> >
> > Is there some basic config here that I may have wrong?
> >
> > Also, while trying to see if I can determine where things broke I
> > noticed there is build breakage starting with 'net/lwip: integrate
> > lwIP library'
> > In file included from net/lwip/lwip-external/src/core/init.c:38:
> > ./net/lwip/lwip-external/src/include/lwip/opt.h:51:10: fatal error: lwi=
popts.h:
> > No such file or directory
> >    51 | #include "lwipopts.h"
> >       |          ^~~~~~~~~~~~
> > compilation terminated.
> > make[2]: *** [scripts/Makefile.build:256: net/lwip/lwip-external/src/co=
re/init.o
> > ] Error 1
> > make[1]: *** [scripts/Makefile.build:397: net/lwip] Error 2
> > make: *** [Makefile:1858: net] Error 2
>
> I haven't noticed this build error here though. I applied Maxim's
> series against master.

Fabio,

You won't see this build issue with the entire series applied... only
with the patches up to and including 'net/lwip: integrate lwIP
library'. My point was there are points in the series where
compilation fails which is not ok.

Tim
