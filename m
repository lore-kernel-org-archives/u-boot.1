Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01029C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 14:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025EB870EA;
	Wed,  3 Jan 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FXYnODSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FED87631; Wed,  3 Jan 2024 15:30:42 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0354086758
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 15:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28ba5cca7fdso1482161a91.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 06:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292238; x=1704897038; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TptG4wx/Mr3LyWDSEDVxwhKn416PFqH2bUm3tONanL0=;
 b=FXYnODSF4un4CUDkjGrl4nWvzHDeR/CCTZRQ5si5P0slaiAsPStxpakuMsIf3FuXnG
 iC/4PXvkViIaK6n1dh8OcQZMaPRkG42SG0XUNe4ldDHwz8UkAUkOo4P47RK/NiVzh/FQ
 51/l6l6Xe3eWrroKzewLVSE6HgbuZ6nOagvpoxQzN5cxutJFKN5EbDmKqJgILNPDb68e
 h4/z1Z4k3Ec1UUANNgC4vdqpHeNXG1X8zKy1I7idMUKElLW24XcheP5Dm2xUFfS/4guC
 gSOZiWStZymkP3J0RSjF3Y4NPfhMdr12JICfvCvmjAJRvXhEnomvAucOolPjnZOlLKBA
 KTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292238; x=1704897038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TptG4wx/Mr3LyWDSEDVxwhKn416PFqH2bUm3tONanL0=;
 b=wXia/ZtWEnXz+cVm2Y5GDxt24GvMT/s2bG3Ou2vagn4W0ge13+a2kOwqLyy7bA7nbT
 pXO/GsbRAzDr8LvtvrAQuYIK1wn3bmK5l5jsKlnWTe34SxTYZHg0Y/KktMzzGAs0w93m
 ZtclzPqgb3P1D8yH0URhmbSruyWStPhpUWz3BCzRTZUJN4racVbifTvcLtg/bn4QeJVd
 SdLxxc4r0aKLi+AaXkPGWMrlWCtQUZiIMJ3jq892apGN7uRk258P9jww9vlmraSqEVQw
 e+KiApSBX/zZVVhCdoXFS/lsmPhIT11Zr0oCkeJUmExc5fn8EtYLj3fPYED8t8qmyVNE
 n0nA==
X-Gm-Message-State: AOJu0Yzx43gto8A2Pi0V6tTmSztiurZk0xt50LhRAnuS0gJHXjLKXYkr
 tk9YKlxYIQF7i9+4y89fXKk6M/AG7czPlf9OaCpMk9fbGwg=
X-Google-Smtp-Source: AGHT+IGFOoAUpnVCESMrrSmKkemCfP611MjZ9W4beRJjB0rkc4fU8diyiW7PdREQJwdAUKjnURh0LL/v+B7aTVwRs4M=
X-Received: by 2002:a17:90a:8b11:b0:28b:a5ea:732e with SMTP id
 y17-20020a17090a8b1100b0028ba5ea732emr28111132pjn.2.1704292238207; Wed, 03
 Jan 2024 06:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231219-49026ec51e53dffb0c4d4e20@thorsis.com>
 <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
In-Reply-To: <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 11:30:26 -0300
Message-ID: <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

Hi Maxim,

On Tue, Jan 2, 2024 at 2:31=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.or=
g> wrote:
>
> Small update here. I made changes without any board limit size changes.
> Reordered patches to make them compile in sequence. I think I will do one
> more clean up and more testing,
> and after that will be able to send an updated version.
> Working tree is here: https://github.com/u-boot/u-boot/pull/434

In which boards have you tested the series?

I built from https://github.com/muvarov/u-boot/tree/master_lwip_test_v10, b=
ut
it does not work reliably on an imx8mn-evk board. (Actualy tftp worked
only once):

u-boot=3D> ping 192.168.0.16
init already done for ethernet@30be0000
Using ethernet@30be0000 device
pinging addr: 192.168.0.16
host 192.168.0.16 is alive
 3 ms
u-boot=3D> dhcp Image
init already done for ethernet@30be0000
dhcp using: 0:ethernet@30be0000
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
u-boot=3D> tftp Image
init already done for ethernet@30be0000
TFTP from server 192.168.0.16; our IP address is <NULL>
Filename 'Image'.
Load address: 0x42000000
Loading:########################################################
done
Bytes transferred =3D 19808768 (0x12e4200 hex)
u-boot=3D> tftp Image
init already done for ethernet@30be0000
TFTP from server 192.168.0.16; our IP address is <NULL>
Filename 'Image'.
Load address: 0x42000000
Loading:eth_send error -22
tftp_get err=3D-13
u-boot=3D> tftp Image
init already done for ethernet@30be0000
TFTP from server 192.168.0.16; our IP address is <NULL>
Filename 'Image'.
Load address: 0x42000000
Loading:eth_send error -22
tftp_get err=3D-13
u-boot=3D> tftp Image
init already done for ethernet@30be0000
TFTP from server 192.168.0.16; our IP address is <NULL>
Filename 'Image'.
Load address: 0x42000000
Loading:eth_send error -22
tftp_get err=3D-13

Rebooted the board and tried again:

u-boot=3D> ping 192.168.0.16
eth0: ethernet@30be0000 00:04:9f:06:33:d3 active
Using ethernet@30be0000 device
pinging addr: 192.168.0.16
ping_tmo: ping failed; host 192.168.0.16 is not alive
u-boot=3D>
