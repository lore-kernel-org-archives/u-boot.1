Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2244C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 05:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C743583FEE;
	Sun, 28 Jun 2026 07:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Ev98k1FZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C0684105; Sun, 28 Jun 2026 07:07:48 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F59805D7
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 07:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=brainfault.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=anup@brainfault.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so19822055e9.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 22:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782623265; cv=none;
 d=google.com; s=arc-20260327;
 b=KNpg7LPPBOuWMv4yaRq8DgpxfiNipyCPO9+iM+DhaawP8f3ZI6Aih1qtw5wkMyBpCd
 3MVpjp2ajhFa4SUM5JfZ8Xo5WS4sR+PFze9PzKUowS9XyHno2NLP+TRtHXaG20o/DvHM
 Na3dedTZ8Uau1HcN9WJEKlVc9srXEWKx7ox0CAqTqtbBvhaMjwaZ3IKb1zrKZfbpzcLQ
 gFSEoYl6pg7WeEjW23GLCO+QxnLu1+HoCvd8dtVIGDMQumDxw3rEedjqa4nlMmXvrLNd
 LU7DSEsEqVS48vR4/VbbTzQJYcoXsedzj/w4m+gIhruY1QSPIKLXIDtG4VWug6HT0Xfe
 qcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xcaBujDZdmGC8Bg3jI8ZHcU2mirFLjl80BIrKd/vqUM=;
 fh=lK03Y/hOXGj9PPvrT2SbyOp8ekwN8gnZxsWTHrj6mws=;
 b=p6TGlIhXR8T9TMVwEf3SGFssDNX2Gow2MTSr/qEE2jjjOA3GeB6eyJE80JQAvHXDFF
 0OFu1i1z+RNUFsecOIl96CruhipBAdOh5Dy10lPxU8CQkTYfSQsVF2Mz0nI9iJDDvhfm
 SllBvOgWtdDR8yvE/6KZ2TDQCGJIU2+zp2ftFleI9g0JlEZUknAav/zMstzT7906WpJK
 DTDpu3zHPtlxX4828NpnV/qI7dm9A46nHsJc/WcqKpX3vLTVSiScuH+XWXJwPvREkJ0k
 TagJMe1jllXLbIsI1UvdDi2KYXHNP+0JQLzmzWmu7m4YCycw9o2ucg0xzHobjziWS37o
 6eNA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1782623265; x=1783228065;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcaBujDZdmGC8Bg3jI8ZHcU2mirFLjl80BIrKd/vqUM=;
 b=Ev98k1FZr1Y4wGqC71R5EhAM8ZIU18xT20lM+ARsWtu4bTmtTpF/yi5bzyFAHLA/WV
 wZTRcZerBRhdVYb7ANcUDCQZIC7ujEDK6AkPsTLDl6k8wK6OpJES7+tPXnxpxe9mYl/l
 Uo6l9ZiOSb4ZNAPeM9tZSMQmtJJNc7nfYY30VmosnHJ2HZ94T3TjFPFPltQa7ly7sBls
 rlKbTQ8sArW2twibcDJ5fKcX7wMN9kxkh18Bat1JlyTJZ9Voyz23vFBZj54Lg+RvPdmy
 VyggbTwZdM6WON0x3rbiHg26jR0+l82eWnWHxSYADdF52vdxGvPKKt4+GA67wExHEPNl
 Ltlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782623265; x=1783228065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xcaBujDZdmGC8Bg3jI8ZHcU2mirFLjl80BIrKd/vqUM=;
 b=ahSq5u7CkX66S27RjdMQRxP2L0OpkXpl5aecWYpypcWgjS5+Udp+CPQtc/bhk9EM2k
 m/6IwaiQeNLAXWWyNzfZ9wKE6EUsx9epQ6FP1Ubrg6J9iRsT5tzH3vI6W/Hxqvr2tMl1
 Hs/h+WQLzhh+s3LKg6n5UNdzujzCSykZ15Uml2x7nrM/L5uZMUYjen1pglPG/RV/2sBY
 a0PfgEO7HdPU2HsyK4L2LiYJIiws+zC4Kg4QRvyC3A6TgM+I3brdH1k+Yvqd5Y5wUeEU
 miscXV57gMyWH/RSk/Kr6/K+EcRLalEqQ4ECejKlwgNf6ljRlFwGBmKOkxvhy+YZt3+w
 9bWg==
X-Gm-Message-State: AOJu0YxQwpIyTpyXabVol3E9Jbtwh//9seeRw/Yp2H75sJXlpmf4Ozvs
 2l6i2/gkDHtVui4calZdca7f46XN9QSbKCw9znnrOvkJv/QWGrjjnOWHtxN8xKrQDd6gnSJ1okK
 w3+gcd3rxzXec9LPWFOkjMLfoa1YpXJzjXOCDSvqCjA==
X-Gm-Gg: AfdE7cnSOnYQqRT5urohlzUYyLxbvzLzb4+WjtwhwXDAxAQrKIHIsUJ55Ftq4ql+sqi
 hjMOWvmh6DzAumI0u5sMw6dptAvTIU/ULVlJgdGVlQ/MgYKK3z5zW2HUSQLIiwWzCJkoI+gijEa
 y+g2YXihqCMERsNm+sgWlkF9OkJMFuNSz3K9EYHj56q6K/KqWiOq6jqu8bxp8k+K9Fn7Ukxsno0
 K6lc5ltrC+1efP7m52bP4GEgpKE57DA4HB3GmqgHPREys3D7+Xcwruf8re4+fbfaDeCzO7ZfiIp
 9yn8pxFGW8vACo8AAICkFxrSq1hARKDYHpYur4gutym7Ef771ELgm2LXUTmcvsHr97UzVtAWpU7
 ISiM9ANfAQROcS6c=
X-Received: by 2002:a05:600c:3f0c:b0:493:a677:1782 with SMTP id
 5b1f17b1804b1-493a67718bbmr17073315e9.35.1782623264864; Sat, 27 Jun 2026
 22:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260626201613.1035208-1-charles.perry@microchip.com>
In-Reply-To: <20260626201613.1035208-1-charles.perry@microchip.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 28 Jun 2026 10:37:33 +0530
X-Gm-Features: AVVi8Cc84u2jDMWrpmwVDd9qYK37HXcXYaM9KFwq2PvL7yjn_HsUaTDGXZCxP9o
Message-ID: <CAAhSdy1+2wkCz-nzKM+=aVk4hPUXJpiEZjyq0O+vLOO89iTuFQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add support for RPMI to U-Boot
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, Rahul Pathak <rahul@summations.net>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
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

On Sat, Jun 27, 2026 at 1:46=E2=80=AFAM Charles Perry
<charles.perry@microchip.com> wrote:
>
> Hello,
>
> This series adds support for RISC-V Platform Management Interface (RPMI) =
to
> U-Boot. RPMI is an OS-agnostic protocol for communication between an
> Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
> goals and purpose of RPMI are similar to ARM's SCMI.
>
> This patchset first adds an abstraction layer for the transport
> (UCLASS_RPMI), then adds two transport layer (SBI MPXY and shared memory)
> and finally adds two client, or service group in RPMI jargon: Clock and
> device power service groups.
>
> This series also include a sandbox mode for which the RPMI transport
> doesn't attach to a firmware but contains a simulation of a firmware. Thi=
s
> reuses code from librpmi [2] to create the message responses.
>
> Apart from the spec [1], this series reuses code from the Linux SBI MPXY
> driver [3], OpenSBI shared memory transport [4] and Linux RPMI clock driv=
er
> [5].
>
> This was tested on a PIC64-HPSC SoC which features an application cluster
> and a system controller with isolated address spaces, hence the need for
> RPMI.  I've tested the interoperability between RPMI clients and transpor=
ts
> with an S-Mode U-boot (using the MPXY transport) and M-Mode U-Boot (using
> shared memory transport) and the following device tree fragment:
>
> ```
>         firmware {
>                 rpmi: mailbox@7000000000 {
>                         compatible =3D "riscv,rpmi-shmem-mbox";
>                         reg =3D <0x70 0x00000000 0x0 0x3000>,
>                                 <0x70 0x00003000 0x0 0x3000>,
>                                 <0x70 0x00006000 0x0 0x1000>,
>                                 <0x70 0x00007000 0x0 0x1000>;
>                         reg-names =3D "a2p-req", "p2a-ack", "p2a-req", "a=
2p-ack";
>                         riscv,slot-size =3D <64>;
>                         #mbox-cells =3D <1>;
>                 };
>
> ifndef CONFIG_RISCV_MMODE
>                 clock-service {
>                         compatible =3D "riscv,rpmi-mpxy-clock";
>                         mboxes =3D <&rpmi 0x8>;
>                         riscv,sbi-mpxy-channel-id =3D <0x1000>;
>                 };
>
>                 device-power-service {
>                         compatible =3D "riscv,rpmi-mpxy-device-power";
>                         mboxes =3D <&rpmi 0x9>;
>                         riscv,sbi-mpxy-channel-id =3D <0x1001>;
>                 };
>
>                 mpxy_mbox: mailbox {
>                         compatible =3D "riscv,sbi-mpxy-mbox";
>                         #mbox-cells =3D <2>;
>                 };
> endif
>
>                 sysc_clk: clock-controller {
>                         compatible =3D "riscv,rpmi-clock";
> ifdef CONFIG_RISCV_MMODE
>                         mboxes =3D <&rpmi 0x8>;
> else
>                         mboxes =3D <&mpxy_mbox 0x1000 0x0>;
> endif
>                         #clock-cells =3D <1>;
>                 };
>
>                 sysc_dpwr: power-domain-controller {
>                         compatible =3D "riscv,rpmi-device-power";
> ifdef CONFIG_RISCV_MMODE
>                         mboxes =3D <&rpmi 0x9>;
> else
>                         mboxes =3D <&mpxy_mbox 0x1001 0x0>;
> endif
>                         #power-domain-cells =3D <1>;
>                 };
>         };
> ```
>
> [1]: https://github.com/riscv-non-isa/riscv-rpmi
> [2]: https://github.com/riscv-software-src/librpmi
> [3]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/mailbox/risc=
v-sbi-mpxy-mbox.c
> [4]: https://elixir.bootlin.com/opensbi/v1.8.1/source/lib/utils/mailbox/f=
dt_mailbox_rpmi_shmem.c
> [5]: https://elixir.bootlin.com/linux/v7.0.10/source/drivers/clk/clk-rpmi=
.c
>
> Cc: Rahul Pathak <rahul@summations.net>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Romain Caritey <romain.caritey@microchip.com>
> Cc: Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
>
> Charles Perry (7):
>   firmware: add support for RPMI
>   firmware: rpmi: add support for the SBI MPXY transport
>   firmware: rpmi: add support for shared memory transport
>   drivers: clk: add support for RPMI clocks
>   drivers: power: add support for RPMI power domains
>   firmware: rpmi: add a test and a sandbox driver
>   firmware: rpmi: add a test and sandbox for device power

I have a more general question.

Why add separate firmware framework for RPMI ?

You can just extend the existing U-Boot mailbox framework
and just like we have in Linux. The separate transport drivers
will be mailbox-controller drivers and each service group will
have a separate mailbox-client driver under appropriate driver
subsystem.

>
>  MAINTAINERS                                |   9 +
>  arch/riscv/include/asm/sbi.h               |  57 +++
>  arch/sandbox/dts/test.dts                  |  23 +
>  configs/sandbox_defconfig                  |   3 +
>  drivers/clk/Kconfig                        |   7 +
>  drivers/clk/Makefile                       |   1 +
>  drivers/clk/clk_rpmi.c                     | 346 +++++++++++++++
>  drivers/firmware/Kconfig                   |   1 +
>  drivers/firmware/Makefile                  |   1 +
>  drivers/firmware/rpmi/Kconfig              |  27 ++
>  drivers/firmware/rpmi/Makefile             |   4 +
>  drivers/firmware/rpmi/rpmi-sandbox-clock.c | 446 +++++++++++++++++++
>  drivers/firmware/rpmi/rpmi-sandbox-power.c | 174 ++++++++
>  drivers/firmware/rpmi/rpmi-sandbox.c       | 158 +++++++
>  drivers/firmware/rpmi/rpmi-sandbox.h       |  48 +++
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c      | 449 +++++++++++++++++++
>  drivers/firmware/rpmi/rpmi-shmem.c         | 474 +++++++++++++++++++++
>  drivers/firmware/rpmi/rpmi-uclass.c        | 138 ++++++
>  drivers/power/domain/Kconfig               |   7 +
>  drivers/power/domain/Makefile              |   1 +
>  drivers/power/domain/rpmi-power-domain.c   | 229 ++++++++++
>  include/dm/uclass-id.h                     |   1 +
>  include/rpmi-uclass.h                      |  79 ++++
>  include/rpmi.h                             | 159 +++++++
>  include/rpmi_proto.h                       | 143 +++++++
>  test/dm/Makefile                           |   1 +
>  test/dm/rpmi.c                             |  69 +++
>  27 files changed, 3055 insertions(+)
>  create mode 100644 drivers/clk/clk_rpmi.c
>  create mode 100644 drivers/firmware/rpmi/Kconfig
>  create mode 100644 drivers/firmware/rpmi/Makefile
>  create mode 100644 drivers/firmware/rpmi/rpmi-sandbox-clock.c
>  create mode 100644 drivers/firmware/rpmi/rpmi-sandbox-power.c
>  create mode 100644 drivers/firmware/rpmi/rpmi-sandbox.c
>  create mode 100644 drivers/firmware/rpmi/rpmi-sandbox.h
>  create mode 100644 drivers/firmware/rpmi/rpmi-sbi-mpxy.c
>  create mode 100644 drivers/firmware/rpmi/rpmi-shmem.c
>  create mode 100644 drivers/firmware/rpmi/rpmi-uclass.c
>  create mode 100644 drivers/power/domain/rpmi-power-domain.c
>  create mode 100644 include/rpmi-uclass.h
>  create mode 100644 include/rpmi.h
>  create mode 100644 include/rpmi_proto.h
>  create mode 100644 test/dm/rpmi.c
>
> --
> 2.47.3
>

Regards,
Anup
