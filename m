Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B09BC47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:02:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CA1A8793E;
	Thu,  4 Jan 2024 16:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TPWLBJVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568568792C; Thu,  4 Jan 2024 16:02:37 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D87C8792C
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a28ac851523so73198266b.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704380554; x=1704985354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9S8UhysrkPyHvuTemolN9VC0zHENJbwb7RA1SWrw7KM=;
 b=TPWLBJVqTeZfuzoxDJ2WA1pKfeknaEQBz1arGWUFx93g4e98awkAhuzRye3UbCYiQX
 xwUYFlVuuQ7TJhQyB3Lg63+F1AvyGMIaCNkrcJLZPHUlsFxVdd3Re6Bbmvijc5mRgWfU
 XYP1YjrhRZoKNlugz2rhOi725U3Jym9KOxouqNbl+3akTFQ+Lx791EgxNcaGEKvuF1+g
 mWC8IcGWWFkpaqXq8cAcF41ldSkB19S7Fvemrr0H8soKQWGKFp2g4LSq8WIyoJ2vtiUH
 Bv9A8czDN8oBQVKDPe/BL8MFHGZ7grdX4SslGsCjsI7cZDPSuJMex7D2WbX5snfD0sbe
 hZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704380554; x=1704985354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9S8UhysrkPyHvuTemolN9VC0zHENJbwb7RA1SWrw7KM=;
 b=FI/7gjYTO6TQyIu4sa5fYp8cVAEXts7AC+eLcqVIys//jnFw15RQWIQYCwozuw8EaJ
 38OD4PCE/bCrb6HJp/6Kurgx8H8OirOSKqo4dSg/tvzGEMeCT7ZOG4KuP0K7Isqvg3Y/
 6lp8RYTgOBDhQU/0tZ4uump1C5kjMWjqgVcz/PB+MLn3r34Gt6sLaz8g53qC2YwBgZ1+
 5OV2/3v0ke4RE10mNbL3evuKRaopPXHeATlyU+M42grnAY40wGWHKlHwwb5KcK8ZPAIs
 Dfk818v3nwY2TNHpBQTRyHEcP19FwNhhmBMQh15ZMy0S6Gl6wdVO38i2rZLLJpoKV8jg
 zmPA==
X-Gm-Message-State: AOJu0Yy9B1xhH7pm9f3hl9a0ZSbsMQq8zYobCqRYgNGUhXxOPx8Vy08u
 /kSWh+3gpO5nW/c9c+UtCVQkr097Up295fsX1hXDDKV/j7DZoA==
X-Google-Smtp-Source: AGHT+IGOrI5pzFLgO+FoX6ukZGrmeZNnEx2s69b3SqyH9JuWgupcivxNPWbUTH+6RX+CEs53rmp8tPswV+eqzzi1MQI=
X-Received: by 2002:a17:906:6b87:b0:a28:2947:ca96 with SMTP id
 l7-20020a1709066b8700b00a282947ca96mr423597ejr.54.1704380553749; Thu, 04 Jan
 2024 07:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231219-49026ec51e53dffb0c4d4e20@thorsis.com>
 <CAD8XO3buXi_0dJQzh2HSirym3VD1C-rugCsmbrsE-nuN-VVS7Q@mail.gmail.com>
 <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BWibgnQKTreqCfTOioaUYnEZPoUVs4290OSs3k82x8bQ@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Thu, 4 Jan 2024 21:02:21 +0600
Message-ID: <CAD8XO3aXShwQGKzqqYO9GAoAV2SbQFx0Fys3G_ZonTQCWQCAJg@mail.gmail.com>
Subject: Re: [PATHv11 00/43] net/lwip: add lwip library for the network stack
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, goldsimon@gmx.de
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

On Wed, 3 Jan 2024 at 20:30, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Maxim,
>
> On Tue, Jan 2, 2024 at 2:31=E2=80=AFPM Maxim Uvarov <maxim.uvarov@linaro.=
org>
> wrote:
> >
> > Small update here. I made changes without any board limit size changes.
> > Reordered patches to make them compile in sequence. I think I will do o=
ne
> > more clean up and more testing,
> > and after that will be able to send an updated version.
> > Working tree is here: https://github.com/u-boot/u-boot/pull/434
>
> In which boards have you tested the series?
>
>
CI tests this in all qemu emulated boards. I tested it locally on Raspberry
Pi - works well. This version did not
yet tested on imx8, but the previous version worked on eth0, did not work
on eth1.  So I plan to continue testing
these patches on different boards. But in general it's the upper layer then
drivers and theoretically has to work on any
board. But in fact different boards work in different ways and behaviour is
different with their qemu model. So I'm a little bit confused
how to test and debug these patches on board which I don't have physical
access...


> I built from https://github.com/muvarov/u-boot/tree/master_lwip_test_v10,
> but
> it does not work reliably on an imx8mn-evk board. (Actualy tftp worked
> only once):
>
> u-boot=3D> ping 192.168.0.16
> init already done for ethernet@30be0000
> Using ethernet@30be0000 device
> pinging addr: 192.168.0.16
> host 192.168.0.16 is alive
>  3 ms
>

It looks like it worked here.


> u-boot=3D> dhcp Image
>

and this command did not get a dhcp response and unset IP address.
Because there is no IP address then all tftp commands fail. The reasons
might be different:
- no MAC address
- device is not active
- remote DHCP server does not answer for this request

init already done for ethernet@30be0000
> dhcp using: 0:ethernet@30be0000
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
> u-boot=3D> tftp Image
> init already done for ethernet@30be0000
> TFTP from server 192.168.0.16; our IP address is <NULL>
> Filename 'Image'.
> Load address: 0x42000000
> Loading:########################################################
> done
> Bytes transferred =3D 19808768 (0x12e4200 hex)
> u-boot=3D> tftp Image
> init already done for ethernet@30be0000
> TFTP from server 192.168.0.16; our IP address is <NULL>
> Filename 'Image'.
> Load address: 0x42000000
> Loading:eth_send error -22
>

ok. eth_send() is a function which actually sends a packet. It checks if
the device is active or not.
        if (!eth_is_active(current))
                return -EINVAL;
I think eth_init() or something else is missing this specific board. But I
don't have any idea how to fix it
without physical access to this board or a way to reproduce it on some
other board.
'ethact' - is a variable to choose an active net device.


> tftp_get err=3D-13
> u-boot=3D> tftp Image
> init already done for ethernet@30be0000
> TFTP from server 192.168.0.16; our IP address is <NULL>
> Filename 'Image'.
> Load address: 0x42000000
> Loading:eth_send error -22
> tftp_get err=3D-13
> u-boot=3D> tftp Image
> init already done for ethernet@30be0000
> TFTP from server 192.168.0.16; our IP address is <NULL>
> Filename 'Image'.
> Load address: 0x42000000
> Loading:eth_send error -22
> tftp_get err=3D-13
>
> Rebooted the board and tried again:
>
> u-boot=3D> ping 192.168.0.16
>

that is really strange, after reboot you should get the initial stage.
You can type 'lwip list' and 'net list' to check if there is an IP address
for
active device set.

eth0: ethernet@30be0000 00:04:9f:06:33:d3 active
> Using ethernet@30be0000 device
> pinging addr: 192.168.0.16
> ping_tmo: ping failed; host 192.168.0.16 is not alive
> u-boot=3D>
>
