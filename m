Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0873CFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 515248412A;
	Fri, 21 Nov 2025 00:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cL/bnmKL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F14B84132; Fri, 21 Nov 2025 00:40:48 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F32D8405F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b735b89501fso162895366b.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763682045; x=1764286845; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lOGcB2qioTLkOFpemH1havyRj7QXUzSBGNbxOIlufFQ=;
 b=cL/bnmKLHt88E5fy0ucglrSEM7arePHomlFqwBqClakQFSSgYhTEKAgWZrAa0S/VCn
 jyfW5E1Pc2l3L7SJpXA0T4O9hsmkEPG2PmDMhkrQtB/xwyCulAh31WrLjrWuOkCdW5o+
 UWMuLE82KpoOgDlKIY/vk3eMBxu8Qa0j1wICw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763682045; x=1764286845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOGcB2qioTLkOFpemH1havyRj7QXUzSBGNbxOIlufFQ=;
 b=vySyUz6TUQqD6Z7mCuLluNW8jHKmc/YtboLtvBMItqVIPWs6h4iHTtOPgfMJPZydHk
 ylUGRhROCnWvUYYXu34eMj+Yul83k8mJdiIkbzMt+5ZAMa+Yzm0yJL5dppPxQeQtJrUm
 kY6Oajxtayr6zhDT+CzKqyR6HQIGh6ixV7SrJ43uOTkNHGQY4pMTherMvih3Q5fEKoqK
 DGoPcepjXCNeQIfsHY4rqj4qWBGKW0nIsnpm8mQ9UgmsTdmPftPXEQuvULIR1+bRBnDH
 qXVK8VReLCEepaHV6CHSBZmgnrLPCI8iiTbuF7rGS93p1fQqgTMp4Nt/8sfeO4oc9SB0
 vjhQ==
X-Gm-Message-State: AOJu0Yx6jigIuaAeOIW/CPv2PAo1fH2UQOknpRq6BlL1Rv0gM8nroqM6
 IWvQ6huqL1udaU6HDR4aC+XUjx+BmHQVrfac2oeMHyjFbJy2Wf0dZuLZzZdnVRaZMrrVjhoUIJw
 m48gwZa1bugaOI0uprJ2awd30eMmZcEgvnShRGoBf
X-Gm-Gg: ASbGncskaJGwO/PbOLqUMveIgUv5Yjmzin365S+xTT7HRhw2zhvjZuIjIx7NNoBfknP
 bYvvu7q1Ror1rztGdZtv3ePs7v+IdIVURAlroI6V1qWHzVXE7r7SHnpWM7nsyEn50IEHND4okPz
 uoAhd+36wHd/Li9/NDeS9diE0+tLuRKt/mAmcMOq+8avok3R4WMnf/3j/vB/nVmyp6hPb4TBj8L
 D6NC31Zu8G2x6fGdDyN3PUAVfVBx/78fSqTni7cOX9O3D1uDiSI31Im4Ks9OrV97HOu2w==
X-Google-Smtp-Source: AGHT+IFFUuFMt9ud/zWaWpKdvAB5XCjzm/n1fVzxFsztK3uMZ2qtSXdaPfVCDbmTQysZmvopaUPSuxRaL47sKBv+8bc=
X-Received: by 2002:a17:907:971e:b0:b73:9fea:330a with SMTP id
 a640c23a62f3a-b767158cd9emr14769266b.17.1763682045467; Thu, 20 Nov 2025
 15:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20251120085057.549221-1-adriana@arista.com>
In-Reply-To: <20251120085057.549221-1-adriana@arista.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Nov 2025 16:40:32 -0700
X-Gm-Features: AWmQ_bmw3dF_5MMD1dDBixQaQdCA91WssReHi_myxXMyRn--6HbdKpcNlqbSgI8
Message-ID: <CAFLszThQ1YJ1pCnjtD7Hgcdm6BVe_r5zwm8kR5qvL=fuu_29TQ@mail.gmail.com>
Subject: Re: [PATCH v5] boot/bootfdt: Add smbios3-entrypoint to FDT for
 non-EFI boots
To: Adriana Nicolae <adriana@arista.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, ddrokosov@salutedevices.com, 
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de, 
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org, 
 joao.goncalves@toradex.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 20 Nov 2025 at 01:51, Adriana Nicolae <adriana@arista.com> wrote:
>
> From: adriana <adriana@arista.com>
>
> The Linux kernel can discover SMBIOS tables through two primary methods:
> 1. Via EFI tables, when using EFI boot;
> 2. Via the 'smbios3-entrypoint' property in the /chosen node of the
> device tree.
>
> When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
> "bootz", or "booti"), the kernel relies on the device tree to detect
> the hardware. If SMBIOS tables are available in U-Boot, they should
> be passed to the kernel via this device tree property.
>
> This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
> address into the device tree if there is a table generated by U-boot.
> The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
> for specific boards to select custom SMBIOS addresses.
>
> The changes in this patch are added in the context of supporting this
> device tree property in linux kernel:
> https://lkml.org/lkml/2025/10/24/1393
>
> Device tree schema was updated to include the "smbios3-entrypoint" node
> in pull request: https://github.com/devicetree-org/dt-schema/pull/177
>
> Signed-off-by: Adriana Nicolae <adriana@arista.com>
> ---
> Changes in v5:
>   - Allocate 4KiB extra space for fdt blob and align it to 8 bytes.
>
> Changes in v4:
>   - Remove weak function board_fdt_chosen_smbios(), replace with
>     gd_smbios_start();
>   - Return -EAGAIN in test if GENERATE_SMBIOS_TABLE is not enabled;
>   - Remove unnecessary fdt cleanup at the end of the test;
>   - Added missing newlines at the end of the modified files.
>
> Changes in v3:
>   - Moved "board_fdt_chosen_smbios" function to lib/smbios.c
>   - Return physical address of smbios entry and use map_sysmem to
>     access the entry point;
>   - Removed check for config enabled and added check for
>     GENERATE_SMBIOS_TABLE;
>   - Add test to check that smbios entry address is added into fdt;
>
> Changes in v2:
>   - Renamed device tree property to "smbios3-entrypoint".
>   - Removed redundant check for CONFIG_SMBIOS.
> ---
>  boot/fdt_support.c | 19 ++++++++++++++++++
>  test/dm/fdtdec.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
