Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FBBC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 19:22:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD3F8496E;
	Wed,  8 Jul 2026 21:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="K0kpTAoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4505D8497A; Wed,  8 Jul 2026 21:22:32 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6342C8407E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 21:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-448cf99c133so157115fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783538548; x=1784143348; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cZBfsGx4GloStYGtAxTSCOwGhmT6sNYTiC0jkpF4V88=;
 b=K0kpTAoh0cylb7Q/wO94FUOHib7uqs7WwH4MLXFWA9snMCqk8u0kv8aAGMA9763d4d
 dG45ftWQD7g7sayV9GXAldUhoU66flK+bebZDzaHZ+JwDrOjJnTRiTKmjyJDH2O82x2q
 couKRoRBnjgdX9frvfKngKF1fnrdXKwtx6OCqIFba7e+ofKja69kllUhbeYBS6JOxq/U
 RLWDCxHtoOv3hSe6nqGXq4qZEH7kDLT+thMfFfkCf8abZdUKExJRU1+V7MFpKs5pPbZn
 K104YJv1yB50TFRYF9zSvM2WKqrotP14Rn8iL31Gp31G/Zpam/35xpovqdZalji13IFr
 GyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783538548; x=1784143348;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZBfsGx4GloStYGtAxTSCOwGhmT6sNYTiC0jkpF4V88=;
 b=JTK6usc6oOJ+WXuqxVcSKVZpN+sPx0AqEYZp8XsN4Wq0VIEfzpjmTAY1jxDHD9dXw/
 D4n1aB9U4MsWiYmXoL7t6NzgrNxZQl7n35UeND2CBZ/NX8L+lyCr1zcUrICcez7iTkLC
 VsTwvmN8DPFtBCf1pfdrEbrwpMK3hHPvVDjDl57Qzf0+PbSsGPjYgiob5psu7SernGIo
 C32Ax0PcWn++pKoBvQdTnqXa5p7QpBeVck74I34tvYu4zh/spWXZulyH4zR6Jwde/um+
 fafsOjK1qtFx0enPNniwiqDxVoBrrLi9rPHom0mXYe+Eqvn/vrcZpeR3QZf9xcVJWsfC
 eE3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1WqBSP5w/z/zbRW6FpdoNeZWR840p/HQ+QF2AebF2NDgWdfGG2TsB9f0t+fKv2TbMMhQK/Vs=@lists.denx.de
X-Gm-Message-State: AOJu0YyW1NUe8aR9u+t++kGtm5MXt2+BIL5qFgngw+xOPf5uQa0BypTZ
 VdlmFyqmef59G38Q6eVpenLZWyVwi3uWRGhqpzDdb0rGMK/O2QRzsFNZznuB0NXKIIA=
X-Gm-Gg: AfdE7clSdF5rEHIr2VarhY419XQvoOOSLOEmOYTOLtkEVUQ633UE3+vFF5i89TgAMBw
 NYJNAaa9pAvtPbfBTPpCBybHNF3gOdJnzczWL81V/xbhtSplyNZKeD+KWC+SX9npq5+l1D9WQFc
 JhGf8DlwgTT7nH7G75sVupo2XwIZuYTYw0KibZB3gX3LoRW0WYaiCY4krvBgwJXpp8M9gYDc+D4
 rvaFHa4nXgJ57wk+KsbZTGhEupJZ+I4H6OssW+LVJ7i6/SvxBo4uh6f+EtCDshrAuWswWnxHiyO
 cwuSxKRHRzoU53QDHTpayRFX5g/8mDvHnPaU1pPuek8B0qGbaWwAGEZlIPR0F5+wH+LV6WGJWh1
 2JuexCeiTTJNWty1qQ9QB8hd2JU2+Gz1/sIYo+Fdld2Ab31lSFrig5mEk1xAh5Ki27P2CG6RKpk
 5VlkxH0wruJ52r+6pjEYR0UPXpAsCfElq/DcZDmBYo2qBz8+bg7BDHKv8Os7hENSs=
X-Received: by 2002:a05:6870:888f:b0:42c:552:f70f with SMTP id
 586e51a60fabf-45118c7030emr4822293fac.16.1783538547794; 
 Wed, 08 Jul 2026 12:22:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30?
 ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5fa20fsm16189382fac.16.2026.07.08.12.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 12:22:27 -0700 (PDT)
Message-ID: <b1f44c11-f537-422a-acef-b805bdefad07@baylibre.com>
Date: Wed, 8 Jul 2026 14:22:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] bootstd: add a firmware-owned devicetree source
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, Anshul Dalal <anshuld@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia <floss@jetm.me>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Michal Simek <michal.simek@amd.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>
References: <20260706-ccaione-upstream-ebbr-v1-0-e742cdd6abe5@baylibre.com>
 <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260706-ccaione-upstream-ebbr-v1-1-e742cdd6abe5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 7/6/26 10:06 AM, Carlo Caione wrote:
> Platforms following EBBR / Arm SystemReady IR keep the devicetree on
> a firmware-owned partition, updated independently of the operating
> system, rather than shipping it in the OS image or on the EFI System
> Partition. U-Boot has no generic way to source the devicetree from such
> a partition, so vendors carry out-of-tree machinery for it.
> 
> Add a bootstd helper, firmware_fdt_load(), that assembles the OS
> devicetree from a FIT manifest carried on that partition: the FIT images
> hold the base DTB and its overlays, and each FIT configuration names one
> bootable combination through its 'fdt' property.
> 
> The partition is described in the control devicetree: the bootstd node
> carries a 'firmware-fdt-source' phandle to a source node, a child of
> the media device owning the partition, which identifies it by GPT type
> UUID and/or name. The 'boot_dtb' environment variable may pin an A/B
> partition number.
> 
> The error semantics are fail closed: -ENOENT strictly means "no source
> configured" (the only case where callers may fall back to their normal
> devicetree); once a source is configured, any assembly failure is
> fatal, and downstream -ENOENT codes (missing manifest, missing FIT
> configuration) are remapped so a missing or bad firmware devicetree is
> never silently replaced by an unverified one. Manifest images carrying
> a 'load' property are rejected so a misbuilt manifest cannot overwrite
> arbitrary memory.
> 

...

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> new file mode 100644
> index 00000000000..952299f1e1b
> --- /dev/null
> +++ b/boot/firmware_fdt.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Firmware-owned devicetree (FDT) source.
> + *
> + * Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
> + * firmware-owned partition rather than in the OS image or the EFI System
> + * Partition. The devicetree is carried by a FIT manifest on that partition:
> + * the FIT images hold the base DTB and its overlays, and each FIT
> + * configuration names one bootable combination through its 'fdt' property.
> + *
> + * The partition is described by the control devicetree: the bootstd node
> + * carries a 'firmware-fdt-source' phandle to a source node, a child of the
> + * media device that owns the partition, e.g.:
> + *
> + *	bootstd {
> + *		compatible = "u-boot,boot-std";
> + *		firmware-fdt-source = <&fw_fdt>;
> + *	};
> + *	&mmc0 {
> + *		fw_fdt: firmware-fdt {
> + *			compatible = "u-boot,firmware-fdt-block";
> + *			partition-type-uuid = "....";	(GPT type UUID)
> + *			partition-name = "firmware";	(optional fallback)
> + *			filename = "fdt.itb";		(optional, the default)
> + *		};
> + *	};

I have some doubts that it is safe to add arbitrary child nodes to
arbitrary storage controller devices like this. Many of these devices
already define child nodes in their bindings, so this could break
drivers that expect a certain type of child node already. (And also
break validation against the binding schemas.)

So it seems like it should go under /bootstd if this is u-boot-only
or /options [1] if we want to try to make it generic for other bootloaders.
And it could just have a phandle to reference the target block device
provider or just reference it by name (to match using alias).

[1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/options.yaml
