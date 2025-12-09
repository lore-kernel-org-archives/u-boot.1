Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30B6D3B7FF
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 16:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E406C80FA1;
	Tue,  9 Dec 2025 17:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hVe+t9XI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BB483015; Tue,  9 Dec 2025 17:33:51 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACDF4807B1
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=robh@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D8E260127
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2542AC4CEF5
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765298021;
 bh=zAo4u+2G7zXpvaVGLUSGJ+lz0fMS+Ely1qMGWEXmSRs=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hVe+t9XIU3SrqXCjge7+KIteupgvqU8MvIpKM/1BYGJTgp/+qPatmwPJkKR/jYJJl
 UV5ehEH3u3qiCXaheekfBrQ8aDg1B6uppoWGYO0+gkVuvLRQaYrkM5R41XK+IQMesO
 tmMUdy1OdQtVVrDYDtGIuhfUVWfk7D/vYJ2S6rywDKHhhC3mTZ5UpZooJz1x4mUfEE
 pf6fIoMVPgOL1LSI/22H+TgPvwFSMqXgfSbk3aW56Wdh2FO1jZc2zGA89BIpzLWcQl
 H0OLoWKGUxO5tO2CdzPNjYNJL2LXMSRxMmHleqZBUlESY9qxocFlXnq6Jkt/4LWO0Z
 Ulx1r2OX3BHiQ==
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6431b0a1948so9916254a12.3
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 08:33:41 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWtZaKYns5xFHpOK4zkbEs6LcUbqbb5Ltu9fu4R3gWv4nhssGw0Jc9hKHPMff9FrVoUJHZsUAc=@lists.denx.de
X-Gm-Message-State: AOJu0YxYK6ejdcNM1D83cWPZNeRTifgUT2+Duheqn6P6T982cMJnyo9d
 jcFA87q70ROEyIj+zm6O1S8TLd8Dw3KpOLTRxvTl2RIsRpv5Q3pRvCuuWykOMw4x3neQ8s9JQcH
 C7mtjHe7Ogu6I2MgJezUqwJROd5Vvrg==
X-Google-Smtp-Source: AGHT+IHWQUeVvWQsencdQPX0UFonukQ0LAUTjVcIZEYb3I46uJ2HOFsNrEQOxJ/CKtlhqOscN9IHsgzV1cJmnWvhUmU=
X-Received: by 2002:a05:6402:1444:b0:63c:1d4a:afc4 with SMTP id
 4fb4d7f45d1cf-64919c041d6mr9911727a12.4.1765298019711; Tue, 09 Dec 2025
 08:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20251127154752.589691-1-frazer.carsley@arm.com>
 <20251201090424.34519-1-frazer.carsley@arm.com>
 <20251201090424.34519-2-frazer.carsley@arm.com>
In-Reply-To: <20251201090424.34519-2-frazer.carsley@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Dec 2025 10:33:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhhyZhNUQP2x178yeRRBkSWvpev_+_bM3OyDON=JZ2aA@mail.gmail.com>
X-Gm-Features: AQt7F2qG9oOi0zSBa0-7VJnizKmIkiHGE-d7TZzauZCD9DGjGxEIz1P-tsjXMqw
Message-ID: <CAL_JsqJhhyZhNUQP2x178yeRRBkSWvpev_+_bM3OyDON=JZ2aA@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] corstone1000: Add Cortex-A320 support on FVP
To: Frazer Carsley <frazer.carsley@arm.com>
Cc: abdellatif.elkhlifi@arm.com, harsimransingh.tungal@arm.com, 
 hugues.kambampiana@arm.com, u-boot@lists.denx.de
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

On Mon, Dec 1, 2025 at 3:05=E2=80=AFAM Frazer Carsley <frazer.carsley@arm.c=
om> wrote:
>
> Enable Cortex-A320 support on the Corstone-1000 platform
> (including FVP) and update the device tree to support the integrated
> Ethos-U85 NPU and GIC-600 interrupt controller. These updates make
> the platform fully compatible with Cortex-A320 while retaining
> backward compatibility with Cortex-A35 and GIC-400.

TLDR: This needs to be a new platform. We really should have a new
name here rather than trying to reuse corstone-1000.

> **Cortex-A320 enablement**
>
> * Extend Corstone-1000 compatibility list to include `cortex-a320`.
> * Ensure build and device-tree logic support both Cortex-A35 and
>   Cortex-A320 configurations.
>
> **Ethos-U85 integration**
>
> * Add `/ethosu@1a050000` node describing the NPU register block at
>   `0x1A050000`.
> * Introduce associated reserved memory regions:
>   * `ethosu_sram@02400000`: 2 MiB on-chip SRAM (`no-map`).
>   * `ethosu_reserved@A0000000`: 32 MiB DDR carve-out
>      (`shared-dma-pool`).
> * Connect memory regions through `memory-region` and `sram` phandles.
> * Add `dma-ranges`, interrupt spec, `region-cfgs`, `cs-region`, and
>   `ethosu-mem-config` for full driver support.
> * Enable the NPU node conditionally via `CONFIG_ETHOS_U85`.
>
> **GICv3/GIC-600 support**
>
> * Introduce `CONFIG_GIC_V3` to toggle between GIC-400 (v2) and
>   GIC-600 (v3).
> * Add full GICv3 node guarded by `#ifdef CONFIG_GIC_V3`.
> * Adjust `cpu@1..3` `reg` values to `0x100/0x200/0x300` under
>   GICv3 (keep `0x1/0x2/0x3` for GIC-400).
> * Update Ethos-U85 interrupt assignment to **SPI 16** to align with
>   the new interrupt map.
>
> These updates align the Corstone-1000 platform with Arm=E2=80=99s latest
> Cortex-A320 and Ethos-U85 configurations and ensure proper interrupt
> and memory mapping for both secure and non-secure domains.
>
> Signed-off-by: Frazer Carsley <frazer.carsley@arm.com>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> ---
>  arch/arm/dts/corstone1000-fvp-u-boot.dtsi | 18 +++++-
>  arch/arm/dts/corstone1000-u-boot.dtsi     | 76 +++++++++++++++++++++++
>  arch/arm/include/asm/armv8/cpu.h          |  1 +
>  board/armltd/corstone1000/Kconfig         |  7 +++
>  4 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/corstone1000-fvp-u-boot.dtsi b/arch/arm/dts/cor=
stone1000-fvp-u-boot.dtsi
> index 6b89d653417..0539e6c092a 100644
> --- a/arch/arm/dts/corstone1000-fvp-u-boot.dtsi
> +++ b/arch/arm/dts/corstone1000-fvp-u-boot.dtsi
> @@ -17,24 +17,36 @@
>  &{/cpus} {
>         cpu1: cpu@1 {
>                 device_type =3D "cpu";
> -               compatible =3D "arm,cortex-a35";
> +               compatible =3D "arm,cortex-a35","arm,cortex-a320";

Not a valid combination. A35 is not backwards compatible with A320. We
don't ever have fallbacks on Arm cores.

> +#ifdef CONFIG_GIC_V3
> +               reg =3D <0x100>;
> +#else
>                 reg =3D <0x1>;
> +#endif

Do use ifdefs in DT like this. Upstream builds need to have both. And
now your unit-address is wrong in one case.

>                 enable-method =3D "psci";
>                 next-level-cache =3D <&L2_0>;
>         };

> diff --git a/arch/arm/dts/corstone1000-u-boot.dtsi b/arch/arm/dts/corston=
e1000-u-boot.dtsi
> index b29ac74217e..206403ea9a5 100644
> --- a/arch/arm/dts/corstone1000-u-boot.dtsi
> +++ b/arch/arm/dts/corstone1000-u-boot.dtsi
> @@ -29,6 +29,15 @@
>         };
>  };
>
> +&{/cpus} {
> +       cpu: cpu@0 {
> +               device_type =3D "cpu";
> +               compatible =3D "arm,cortex-a35","arm,cortex-a320";
> +               reg =3D <0>;
> +               next-level-cache =3D <&L2_0>;
> +       };
> +};
> +
>  &{/soc} {
>         extsys0: remoteproc@1a010310 {
>                 compatible =3D "arm,corstone1000-extsys";
> @@ -37,3 +46,70 @@
>                 firmware-name =3D "es_flashfw.elf";
>         };
>  };
> +
> +#ifdef CONFIG_ETHOS_U85
> +&{/reserved-memory} {
> +       ethosu_sram: ethosu_sram@02400000 {

SRAM does not belong in reserved-memory. I believe I pointed out these
issues internally.

> +               reg =3D <0x02400000 0x200000>;
> +               no-map;
> +       };
> +
> +       ethosu_reserved: ethosu_reserved@A0000000 {

Upstream is not going to use this.

> +               compatible =3D "shared-dma-pool";
> +               reg =3D <0xA0000000 0x02000000>;
> +               no-map;
> +       };
> +};
> +
> +/ {
> +       ethosu: ethosu@1A050000 {
> +               compatible =3D "arm,ethosu-direct";

This binding will never be accepted. The upstream binding is here[1].

> +
> +               // Base address and size of NPU registers
> +               reg =3D <0x1A050000 0x4000>;
> +
> +               memory-region =3D <&ethosu_reserved>;
> +               sram =3D <&ethosu_sram>;
> +
> +               // Address mappings to translate between bus addresses (N=
PU) and physical host CPU addresses
> +               dma-ranges =3D <0x02400000 0x02400000 0x200000>,
> +               <0xA0000000 0xA0000000 0x02000000>;
> +
> +               interrupts =3D <0 16 4>;
> +               interrupt-names =3D "irq";
> +
> +               // Memory region configuration
> +               region-cfgs =3D <3 3 0 3 3 3 3 3>;
> +
> +               // Memory regions used for the command stream
> +               cs-region =3D <2>;
> +
> +               // Memory interface configuration for Ethos-U85
> +               ethosu_mem_config {
> +                       compatible =3D "arm,ethosu-mem-config";
> +                       // <beats outstanding_read outstanding_write>
> +                       sram =3D <0 64 32>;
> +                       ext  =3D <1 64 32>;
> +                       // <mem_domain mem_type axi_port>
> +                       configs =3D <0 0 0>,
> +                       <0 0 0>,
> +                       <0 0 1>,
> +                       <0 0 1>;
> +               };
> +       };
> +};
> +#endif
> +#ifdef CONFIG_GIC_V3
> +gic: &{/interrupt-controller@1c000000} {
> +               compatible =3D "arm,gic-v3";
> +               #interrupt-cells =3D <3>;
> +               #address-cells =3D <1>;
> +               #size-cells =3D <1>;
> +               ranges;
> +               interrupt-controller;
> +               reg =3D <0x1c000000 0x00010000>,
> +               <0x1c040000 0x00080000>;
> +               interrupts =3D <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +       };
> +#endif
> +
> diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv=
8/cpu.h
> index 4dbb589aab8..ffd8f8f358f 100644
> --- a/arch/arm/include/asm/armv8/cpu.h
> +++ b/arch/arm/include/asm/armv8/cpu.h
> @@ -8,6 +8,7 @@
>  #define MIDR_PARTNUM_CORTEX_A57                0xD07
>  #define MIDR_PARTNUM_CORTEX_A72                0xD08
>  #define MIDR_PARTNUM_CORTEX_A76                0xD0B
> +#define MIDR_PARTNUM_CORTEX_A320               0xD8F
>  #define MIDR_PARTNUM_SHIFT             0x4
>  #define MIDR_PARTNUM_MASK              (0xFFF << MIDR_PARTNUM_SHIFT)
>
> diff --git a/board/armltd/corstone1000/Kconfig b/board/armltd/corstone100=
0/Kconfig
> index 709674d4cf7..9476d64d0b0 100644
> --- a/board/armltd/corstone1000/Kconfig
> +++ b/board/armltd/corstone1000/Kconfig
> @@ -9,4 +9,11 @@ config SYS_VENDOR
>  config SYS_CONFIG_NAME
>         default "corstone1000"
>
> +config ETHOS_U85
> +       bool "Enable Arm Ethos-U85 NPU support"
> +       default n

Why would u-boot care about ethosu?

Rob

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/npu/arm,ethos.yaml
