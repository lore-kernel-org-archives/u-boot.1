Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF87C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 23:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F234086F7E;
	Wed, 29 Nov 2023 00:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="lTX44E0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F019786F34; Wed, 29 Nov 2023 00:06:01 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7944D875EA
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 00:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5484ef5e3d2so7867181a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1701212757; x=1701817557;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMID/n+o7kExg7/sJNUY2nF/ZDSipb3Q6l74zrKtbWk=;
 b=lTX44E0koZ6XH+KygRox/2xp3bqHqUUZL7/bo+RD+Zq+nDaog8H8FSc4ItjBU5/7Xs
 EOuuQ5OcFi/CaDkGterLqHxnnPZT2CmOgavC1N1YM1RQU+eOnQf+06ivPzP34CpUE9yP
 cuPOS1BTVp+ILqCzolC9qMZ3s2Tv3kmbAgI3Y84s5KJ6Tol2YmbStSKPMbG7t7+Gd4Ke
 dMl+UV8x9MdHUyaVH/4cgqje8ZoRnCSKRxyUGGYCR2oRfWd8sRKk5yMxo0mKhdqcPNFp
 WhH+vblJw0pBFBp7WGQfTmCirfW2OAAPzB1gB/5UOEIM3AJJzARwdKa9ZLYjY7h22Fqh
 XJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701212757; x=1701817557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMID/n+o7kExg7/sJNUY2nF/ZDSipb3Q6l74zrKtbWk=;
 b=iDTf+Bgd1G+Xw9vrtfa1O0QqB2RsnBrIrlzWUwgRMMfIqmexYARjrVqJFP4+oBK3Lj
 ady/01CBpB3hBtskUDJ1WaTrCy0WKlo+PtjSG7SWLZpjatVVeS29EPyR2JBYg8TH2lSa
 ZmHMRx4uSy9VemsoySoKdd8Ow7DddHr117yntus0JtvFRKGiOHIV/XJ5NxFbftFlquNE
 hRRtTefp9VarR6cY1gqIwc2IOYlXRT7/QsUVILoL6eKN9zOzc1vZoOXWgDtej171qy1B
 TSZL0V/Q6D3Qq+Xzplavx4Nl5psqI04asViAB8j7pfwR7f+XmvFxQ5Us7/qXiNnuqlCp
 0FSQ==
X-Gm-Message-State: AOJu0YycJO2PJi2DQ01S2UZb8goh2wW4Abv6/vBYAYeK140ITKfgfYQd
 AaaMUnB0RSBghGWFYH/s8rrKtZl788wcbiBEYLa7Ig==
X-Google-Smtp-Source: AGHT+IFDrHXDXms4zaUxbVsLdOrSrcUTbewQN0hRChLQJrs3rhJBGdG0CXA24yVGemoaxqK8+2vaK0mLZ0Bzz/l9V7Q=
X-Received: by 2002:a17:907:6b88:b0:a11:adc9:d14e with SMTP id
 rg8-20020a1709076b8800b00a11adc9d14emr4580454ejc.71.1701212756957; Tue, 28
 Nov 2023 15:05:56 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 28 Nov 2023 15:05:44 -0800
Message-ID: <CAJ+vNU3BRgqByLKGe0=D6omSb+p5zqwq2PCvOj0si7guZHsh+w@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de, Fabio Estevam <festevam@gmail.com>
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

On Mon, Nov 27, 2023 at 5:00=E2=80=AFAM Maxim Uvarov <maxim.uvarov@linaro.o=
rg> wrote:
>
> Hello,
>
> Please find updated version of lwip patches. Changes are in the
> changelog bellow.
>
> Thank you,
> Maxim.
>

Hi Maxim,

I've tried this series on my imx8mm-venice boards and find that basic
ping/dhcp/tftp breaks:
u-boot=3D> net list
eth0 : ethernet@30be0000 00:d0:12:78:f8:01 active
u-boot=3D> setenv ipaddr 192.168.1.1
u-boot=3D> ping 192.168.1.146
eth0: ethernet@30be0000 00:d0:12:78:f8:01 active
Using ethernet@30be0000 device
pinging addr: 192.168.1.146
ping_tmo: ping failed; host 192.168.1.146 is not alive
u-boot=3D> dhcp
init already done for ethernet@30be0000
dhcp_tmo 20/20
dhcp_tmo 19/20
dhcp_tmo 18/20
dhcp_tmo 17/20
dhcp_tmo 16/20
dhcp_tmo 15/20
dhcp_tmo 14/20
dhcp_tmo 13/20
dhcp_tmo 12/20
dhcp_tmo 11/20
dhcp_tmo 10/20
dhcp_tmo 9/20
dhcp_tmo 8/20
dhcp_tmo 7/20
dhcp_tmo 6/20
dhcp_tmo 5/20
dhcp_tmo 4/20
dhcp_tmo 3/20
dhcp_tmo 2/20
dhcp_tmo 1/20
dhcp_tmo 0/20
DHCP client timeout
u-boot=3D> tftpboot $loadaddr venice/Image
init already done for ethernet@30be0000
TFTP from server 192.168.1.146; our IP address is 192.168.1.1
Filename 'venice/Image'.
Load address: 0x48200000
Loading:
^ cntl-c after a minute or so of no output

Is there some basic config here that I may have wrong?

Also, while trying to see if I can determine where things broke I
noticed there is build breakage starting with 'net/lwip: integrate
lwIP library'
In file included from net/lwip/lwip-external/src/core/init.c:38:
./net/lwip/lwip-external/src/include/lwip/opt.h:51:10: fatal error: lwipopt=
s.h:
No such file or directory
   51 | #include "lwipopts.h"
      |          ^~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.build:256: net/lwip/lwip-external/src/core/i=
nit.o
] Error 1
make[1]: *** [scripts/Makefile.build:397: net/lwip] Error 2
make: *** [Makefile:1858: net] Error 2
make: *** Waiting for unfinished jobs....

We need to make sure that none of the patches within your series break
basic compilation or it makes it difficult for people to bisect
issues.

Best regards,

Tim
