Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1407FCD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF5F80087;
	Wed, 10 Jun 2026 10:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="ZhB5MlUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 863AE83FEC; Wed, 10 Jun 2026 10:12:54 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C3AD80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490ac357c55so69036815e9.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781079171; x=1781683971; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YqvQcKTbKTTsX+5s1Oc67hQFMa0FjhsOu5YY1zPxFZs=;
 b=ZhB5MlUDoQph6SSGr4T7Plle6Wpb3FXwhLz8cgGfjYyWQXi6nNOt+yMlI43Q298mGi
 PSTqT3TCxhzfAGItzHInCnT4/OLZPp+pT4nyfgONT/8daqY8GNrdAEF5+YVzuixrouuC
 KA9f0tkxBzFa7SdEEiUeVXVwtNSvCWUf25D6/f17rkgrjllqjmGjRKtTx+oh7TRYRlBd
 fPCVXlJoPcjX+gihoEnzzxAEx9miX0EP+yHVrPKvE756BaTZc0wBY1txH3ygHhp9GdPB
 JIPSsrrdetxt3W+mPjucB7S2sLDU9aJc6wdqFdrOn0jkosgKYgQ3RtRZI6ujl/PnpRcm
 RvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781079171; x=1781683971;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqvQcKTbKTTsX+5s1Oc67hQFMa0FjhsOu5YY1zPxFZs=;
 b=khZ2EmyuwohWEGbv4Of6ewreUUhrR5v/FQZqzw9afVNROCiKia9IiJBK1Z7BIbGk+X
 MKbNNzZRUkDepgBxXNIgkpjMV2qdlaImHtiEB5YjbkM87T0LbcBU828qY6Pn68ho13tX
 V83Z8h0zFOLMfIs+3cZHiZqskdjuW1w4O540U2DSU2vJ+3YXiACYaAZ0kwv5Ei8lplL4
 nqF6Y/JNeGDKExVULuKuWE7LMHCWIdNnp8o/AX7K/tkaOh0pLFU+g9XCxkIJYys6/9XC
 qJJXFcPbR8Nki9MSDoTqrEuwOuNhg+tiOx4q50y5eQVxLefYAv0WUK8OPUuN5U7L5VG1
 0IZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iKABs3qfr29VlTEu9hpgmGtwcLMIeA2zv5gO9Do5zCh7dF8KUUFn+udfpDDVeR0z7KH4RBpg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4NqDDnXRavOE98TZxsEpuD1XGgFvmj2+dhU1gPYXpN7ZQUNVA
 ugZd/Ms3nFuow1+yEF+BIW/YkpAnBncl6VVC8HI4wYygGeZdKoNdWliJ7HPQ2TyXEPc=
X-Gm-Gg: Acq92OH33kVgc9Aj59bbyAOx5BCbw5pgTjiqXcHTVOFizouOD0b6lJgRrvSk8r9nnxP
 Pyv78rMPpAmHJqA44ovQw0Ve5pk0MBRE4ma5qjBUrif7ihMvI3MPEtGN+KZIGOvI3QK9ZJreqKW
 iCkR3lAx8qbP1bl5aWEWe1eqUnGk06xOKpoW/1/Hflu/TAsp4dFDLWIm4z4umRd1dURSKqfqSGP
 wrpm8NWSh9AqBYAW01fK3wZ51FFBcRseA4GtF68nTOXvCKWqFjp9KZu8BCbhpD66Zh1YqWZVTcj
 5R86trqiYI6ld7TSF+loyVajnNWtIbbxBVtiHSHbjjeHgdEQr+nMeUkt16s5NFFEJ9Rs7V1YfXS
 FdIHukzODfX75P4KAkeaXVYjmxL5Mb8AMsiCPUK3yReO4wzuo+JtSBebvSzJg6jn9cftMamjxy3
 ZG1ut3JGO+vjMf6NjOqp9Mj11/dVZqNg==
X-Received: by 2002:a05:600c:35d4:b0:490:b8d3:5dcc with SMTP id
 5b1f17b1804b1-490c25e4634mr402517605e9.19.1781079171436; 
 Wed, 10 Jun 2026 01:12:51 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:6881:1355:3b75:b347])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bda4fd52sm537770815e9.0.2026.06.10.01.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 01:12:50 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d9f726b75bc119adffc1b1bc695b2314a2a6af9af8b5cd0eb33a5e2e8ab8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Jun 2026 10:12:42 +0200
Message-Id: <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
Cc: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>, "U-Boot" <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Paresh Bhagat" <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260609181006.460401-1-p-bhagat@ti.com>
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
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

--d9f726b75bc119adffc1b1bc695b2314a2a6af9af8b5cd0eb33a5e2e8ab8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Paresh,

On Tue Jun 9, 2026 at 8:10 PM CEST, Paresh Bhagat wrote:
> This patch series addresses DM firmware reserved memory fixup for AM62a
> and AM62d:
>
> 1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups to
>    be applied before passing dtb to kernel.
>
> 2. DM firmware reserved memory region is insufficient to accommodate the
>    binary. Analysis of the DM firmware binary using objdump reveals that
>    the resource_table section and .stack section occupies memory from
>    0x9c900000 to 0x9e608000. So increase the reserved region size from
>    0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.

I am wondering why you chose 0x1f00000 and not 0x1d08000?

Also for am62a the firmware linker file says it is shorter:
    /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
    DDR                         : ORIGIN =3D 0x9CAA5000 LENGTH =3D 0x1B5B00=
0

    https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main/exampl=
es/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos/ti-arm=
-clang/linker.cmd#L175

I am wondering what is correct, the linker file or the objdump you did?

> 3. The existing fdt_fixup_reserved_memory() used a delete/recreate
>    approach which corrupted phandle references to DM node, causing DM
>    initialization failures. Fixed it by updating nodes in-place using
>    fdt_setprop() to preserve original phandles.

I haven't looked at the code yet, why do you use a fixup instead of
fixing the devicetree?

Best
Markus

>
> This patch will need the dts to be updated for both AM62a and AM62d i.e.
> rename wkup_r5fss0_core0_memory_region node from "memory@9c900000" to
> "dm@9c900000".
>
> Boot logs
> https://gist.github.com/paresh-bhagat/e64523fe5134a02754fdbdaff864fcd1
> https://gist.github.com/paresh-bhagat/b578d602010db09d62d2be3b2709fc5a
>
> Paresh Bhagat (4):
>   arm: mach-k3: Fix phandle corruption in fdt fixup
>   arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
>   arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
>   arm: mach-k3: Add DM reserved memory fixup
>
>  arch/arm/mach-k3/Kconfig        | 16 ++++++++++++++++
>  arch/arm/mach-k3/am62ax/Kconfig |  1 +
>  arch/arm/mach-k3/common_fdt.c   | 34 +++++++++++++++++++++++----------
>  3 files changed, 41 insertions(+), 10 deletions(-)


--d9f726b75bc119adffc1b1bc695b2314a2a6af9af8b5cd0eb33a5e2e8ab8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaikcehsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPE
bQD/UPUuhjT51EmAU3jpPaxEGTGJMIay71gCfmpeV7j2M+QBAKjEYf2m6vOSUKrr
giyoI9mzkqFLDX9oHvGW7JIBtIgE
=A0b/
-----END PGP SIGNATURE-----

--d9f726b75bc119adffc1b1bc695b2314a2a6af9af8b5cd0eb33a5e2e8ab8--
