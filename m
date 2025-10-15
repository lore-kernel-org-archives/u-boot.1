Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89505CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B95A5835A2;
	Wed, 15 Oct 2025 19:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="rCtGu4pt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1726C835B0; Wed, 15 Oct 2025 19:58:51 +0200 (CEST)
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84CCB8357F
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 19:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1760551127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pxf8UGTxgrhrQCFgr+BVBS1LlN7WyOfU6wrfL2utlJw=;
 b=rCtGu4ptjdKCMs30eNyVS8sJTlWr1byq+fjTnTOFj6sygF21ph/XQhGe7uckZmvf+G2MCS
 tJrm8EvG4xQXtMjiXX2azbZZDrqO2f0ISjkg1HpZviBCtir5dOwuzg0DgZ+mTqQBbdjLBa
 dMK28/fLKGYikRPc4swTdbwNA4wTOUknHopSTRvL8TftgHQnQkpTlbX1IkRLZNzTCfwjTH
 YEp+clUW4q6IKPI4rig1Wxb4I8S1Z7M1z6RxTgc0B6+AR73Y6E9tocxcjjsfsJZk+713LC
 hnSnBkKdFfwk7Hdxpa0+ANqG+HTzEzleBbC56l1nJzYfodr29ZaMjnsgYvrQcA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 17:58:45 +0000
Message-Id: <DDJ3ADEZWAMW.27UXI62EV28ZZ@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH v4 6/8] arm: dts: meson-gx-u-boot: add binman
 configuration for U-Boot SPL
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Quentin Schulz" <quentin.schulz@cherry.de>, "Ferass El Hafidi"
 <funderscore@postmarketos.org>, "Tom Rini" <trini@konsulko.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Peng Fan" <peng.fan@nxp.com>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, "Beniamino Galvani"
 <b.galvani@gmail.com>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
 <20251015-spl-gx-v4-6-f5d7fe03225b@postmarketos.org>
 <fc4dbf76-cba2-495c-a4e6-e3f9fc770690@cherry.de>
In-Reply-To: <fc4dbf76-cba2-495c-a4e6-e3f9fc770690@cherry.de>
X-Migadu-Flow: FLOW_OUT
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

On Wed Oct 15, 2025 at 5:11 PM UTC, Quentin Schulz wrote:
> <...>
>> diff --git a/arch/arm/dts/meson-gx-u-boot.dtsi b/arch/arm/dts/meson-gx-u=
-boot.dtsi
>> index 9e0620f395e..d05f869c06e 100644
>> --- a/arch/arm/dts/meson-gx-u-boot.dtsi
>> +++ b/arch/arm/dts/meson-gx-u-boot.dtsi
>> @@ -2,6 +2,7 @@
>>   /*
>>    * Copyright (c) 2019 BayLibre, SAS.
>>    * Author: Maxime Jourdan <mjourdan@baylibre.com>
>> + * Copyright (c) 2023 Ferass El Hafidi <funderscore@postmarketos.org>
>>    */
>>  =20
>>   / {
>> @@ -15,6 +16,16 @@
>>   	soc {
>>   		bootph-all;
>>   	};
>> +
>> +	chosen {
>> +		stdout-path =3D "serial0:115200n8";
>> +	};
>> +
>
> I don't believe this is required for binman so please split into its own=
=20
> commit with justification.
>

Sounds good to me, will do.

>> +#if defined(CONFIG_BINMAN)
>> +	binman: binman {
>> +		multiple-images;
>> +	};
>> +#endif
>>   };
>>  =20
>>   &vpu {
>> @@ -30,3 +41,134 @@
>>   	      <0x0 0xc883c000 0x0 0x1000>;
>>   	reg-names =3D "hdmitx", "hhi";
>>   };
>> +
>> +#if defined(CONFIG_MESON_GX) && defined(CONFIG_BINMAN)
>
> Isn't MESON_GX implied since we are in meson-gx-u-boot.dtsi?
>

Yeah, it is, so this is redundant.

>> +/* binman configuration on GXBB and GXL */
>> +
>> +#if defined(CONFIG_MESON_GXBB)
>> +#define BL31_ADDR 0x10100000
>> +#else /* GXL */
>> +#define BL31_ADDR 0x05100000
>> +#endif
>> +
>
> First question is... can't this be derived from the binary already?
>
> On Rockchip we do
>
> fit,load;
> fit,entry;
> fit,data;
>
> for OP-TEE OS and TF-A though we do split the binaries into multiple=20
> nodes (see @atf-SEQ and @tee-SEQ). I'm not sure if those properties are=
=20
> applicable to only tee and atf nodes without a node for each segment, if=
=20
> it isn't...
>
> I would highly recommend against doing this.
>
> I would instead have a
>
> arch/arm/dts/meson-gxbb-u-boot.dtsi with
>
> &fit {
>      atf {
>          entry =3D <0x10100000>;
>          load =3D <0x10100000>;
>      };
> };
>
> and have the default entry and load be 0x05100000 if that really is a=20
> sensible default (otherwise put none in meson-gx-u-boot.dtsi and declare=
=20
> it in each meson-gxXXX-u-boot.dtsi). Then your boards would include=20
> meson-gxbb-u-boot.dtsi instead of meson-gx-u-boot.dtsi (and the former=20
> DTSI would include the latter DTSI).
>

Will do.

> The benefit is that it makes it much clearer what would be required to=20
> support a new family/SoC of the Meson GX family. Or what exactly could=20
> differ between families. But also keeps the main -u-boot.dtsi readable=20
> (which is not that easy to do, see our horrendous rockchip-u-boot.dtsi :(=
 )
>

This patch series actually already adds support for all SoCs of the Meson G=
X
family.  Newer SoCs are too different from GX SoCs and need their own
-u-boot.dtsi (and init and all)...

>> +/*
>> + * On GXBB the base address of the SCP firmware doesn't matter as SPL w=
ill
>> + * send the firmware to the SCP anyway, and can get the base address fr=
om the
>> + * FIT. On GXL it matters, as BL31 is supposed to send the firmware, so=
 set the
>> + * base address to what GXL BL2 would load the binary to.
>> + */
>> +#define  SCP_ADDR 0x13c0000
>> +
>> +&binman {
>> +	u-boot-amlogic {
>> +		filename =3D "u-boot-meson-with-spl.bin";
>> +		pad-byte =3D <0xff>;
>> +
>> +		mkimage {
>> +			filename =3D "spl/u-boot-spl-signed.bin";
>> +#if defined(CONFIG_MESON_GXBB)
>> +			args =3D "-n", "gxbb", "-T", "amlimage";
>> +#elif defined(CONFIG_MESON_GXL)
>> +			args =3D "-n", "gxl", "-T", "amlimage";
>> +#endif
>
> Same here as suggested for the load address of TF-A.
>
> On Rockchip we use CONFIG_SYS_SOC but I don't think you can on Amlogic.
>
> You could set SYS_SOC depending on MESON_GXBB/MESON_GXL/... in=20
> arch/arm/mach-meson/Kconfig and be done with it, but there are some=20
> side-effects (read SYS_SOC doc).
>
> Another way is to add
>
> &binman {
>      mkimage {
>          args =3D "-n", "gxbb", "-T", "amlimage";
>      };
> };
>
> to arch/arm/dts/meson-gxbb-u-boot.dtsi.
>

I think this is what I'll go with. Thanks!

>> +
>> +			blob {
>> +				size =3D <0xb000>; /* The BootROM loads 48K max (header is 4K) */
>> +				filename =3D "spl/u-boot-spl.bin";
>> +			};
>
> I'm not sure this actually works? It would rely on a binary located at=20
> spl/u-boot-spl.bin, which binman doesn't seem to be generating? Either=20
> we;re missing something to generate it with binman, or something=20
> external to binman generates it?
>

spl/u-boot-spl.bin is generated on build-time, it's the U-Boot SPL
binary. And that does work according to my testing...

> Typically it is generated with:
>
> u-boot-spl {
> };
>

...but I think this is much cleaner, so I'll go with that.

> ?
>
> If you're trying to enforce a max size, then we have Kconfig symbols for=
=20
> those, probably SPL_MAX_SIZE and then I believe binman enforces those=20
> one way or another. If it doesn't, then many boards and architecture=20
> have a problem and we should fix that so you can rely on it.
>

I did know of SPL_MAX_SIZE... Might have just overlooked it though.
I think this should be the proper way to do this, yeah.

>> +		};
>> +
>> +		fit: fit {
>> +			description =3D "ATF and U-Boot images";
>> +			#address-cells =3D <1>;
>> +			fit,fdt-list =3D "of-list";
>> +			fit,external-offset =3D <CONFIG_FIT_EXTERNAL_OFFSET>;
>> +			fit,align =3D <512>;
>> +			offset =3D <CONFIG_SPL_PAD_TO>;
>> +
>> +			images {
>> +				u-boot {
>> +					description =3D "U-Boot";
>> +					type =3D "standalone";
>> +					os =3D "u-boot";
>> +					arch =3D "arm64";
>> +					compression =3D "none";
>> +					load =3D <CONFIG_TEXT_BASE>;
>> +					entry =3D <CONFIG_TEXT_BASE>;
>> +
>> +					u-boot-nodtb {
>> +					};
>
> Why no hash for U-Boot?
>
>> +				};
>> +
>> +				atf {
>> +					description =3D "ARM Trusted Firmware";
>> +					type =3D "firmware";
>> +					os =3D "arm-trusted-firmware";
>> +					arch =3D "arm64";
>> +					compression =3D "none";
>> +					load =3D <BL31_ADDR>;
>> +					entry =3D <BL31_ADDR>;
>> +
>> +					atf-bl31 {
>> +						filename =3D "bl31.bin";
>
> I believe this is already the case if you set BL31 environment variable=
=20
> to bl31.bin. I would simply remove it and let the user decide what's=20
> best for them. For binman this comes from the -a atf-bl31-path=3D${BL31}=
=20
> argument.
>
> The benefit is that you can now point to a BL31 outside of U-Boot's=20
> tree, which is super convenient for debugging TF-A, or with build=20
> systems like Yocto or Buildroot.
>

You can already point to a BL31 outside U-Boot's tree, and this is what
I've been always doing when testing.

But I think having it check for a bl31.bin inside the tree when $BL31 is
not set is a sane default IMO .. but correct me if I'm wrong and it's
considered poor practise.

>> +					};
>> +					hash {
>> +						algo =3D "sha256";
>> +					};
>
> This means your boards all need to have CONFIG_SPL_SHA256 if=20
> CONFIG_SPL_FIT_SIGNATURE is provided otherwise the hash cannot be=20
> verified. Please check if that is the case (enforced at the Kconfig=20
> symbol-level would be best).
>

ACK.

>> +				};
>> +
>> +				scp {
>> +					description =3D "SCP firmware";
>> +					type =3D "scp";
>> +					arch =3D "arm"; /* The Cortex-M core is used as SCP */
>> +					compression =3D "none";
>> +					load =3D <SCP_ADDR>;
>> +
>> +					scp {
>> +						filename =3D "scp.bin";
>> +					};
>
> I would recommend to attempt mimicking what's been done for atf-bl31=20
> (then you need to add a new argument to the lists of arguments for=20
> binman in the root Makefile). See above for benefits.
>

One can already `export SCP=3D../path/to/scp/firmware` and have binman use
that.

>> +					hash {
>> +						/*
>> +						 * The hash is used by the SCP and passed to it
>> +						 * by U-Boot SPL.
>> +						 */
>> +						algo =3D "sha256";
>> +					};
>> +				};
>> +
>> +				@fdt-SEQ {
>> +					description =3D "NAME";
>> +					type =3D "flat_dt";
>> +					compression =3D "none";
>
> why no hash for FDTs?
>
>> +				};
>> +
>> +			};
>> +			configurations {
>> +				default =3D "@config-DEFAULT-SEQ";
>> +				@config-SEQ {
>> +					description =3D "NAME.dtb";
>> +					fdt =3D "fdt-SEQ";
>> +					firmware =3D "atf";
>> +					loadables =3D "scp", "u-boot";
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>
> Is the below really related to adding binman configuration???
>

I'll split this to a new commit.

>> +&vpu {
>> +	/delete-property/ bootph-all;
>> +};
>> +
>> +&apb {
>> +	bootph-all;
>> +};
>> +
>> +&sd_emmc_b {
>> +	bootph-all;
>> +};
>> +
>> +&sd_emmc_c {
>> +	bootph-all;
>> +};
>> +#endif
>>=20
>
> Cheers,
> Quentin

Thanks for the review!

Best regards,
Ferass
