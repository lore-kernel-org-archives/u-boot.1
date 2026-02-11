Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322D2E9E30A
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F319283DBF;
	Wed, 11 Feb 2026 14:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="niZ7IY66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F02A83D5D; Wed, 11 Feb 2026 14:54:31 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE43C83E63
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43638a33157so1708844f8f.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 05:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770818060; x=1771422860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnWgu8Uj5oK/WGW9z942sB0XdVZAoCmCBsmAuh78Sos=;
 b=niZ7IY66oBB3PUPCyB0uR3TIHC/jZUAuTsAo7sSVMUHF6TcyGGUinmXJ5TjiLlvQl2
 laZneidNIqXjFxFSkg/MjBFpY2YpTwr9VH4hkbbvTsBpov58en/AJPgj5a/+K8+uj45I
 LfcMzknM4bB5/EI7hmxxUof/mZoLs99xJZFitWDYo8u/aYFHwLiILlLn9WxQMVTrQgeC
 QQG1+vNLThvQ9zycDOjN994jYNUCtpm4GQegKGU3W27uvRUSr5PW591e968cEhdzjSLa
 +ym9SQPdX+Zm7+hWhMweZU27NVx+7d2de0TMH+04YXCFcBv1B1JVuJ1yyocuSw38tWH0
 OE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770818060; x=1771422860;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnWgu8Uj5oK/WGW9z942sB0XdVZAoCmCBsmAuh78Sos=;
 b=hR15J52VJ5DEhTMArQ2dfBqI1UJ3Fqyn45dKiS7GOaNimw+xg65q8aBuhwZSBT85Ur
 7zIRxhayBNSbjWqF7y0ihE3YjZckNqCCqRx8e3hL+j/8gUd6Wjl6ut82JsnWVgB+gw83
 VDRk8UPXNdG+0BPhMWcCJ7k6F00FHaCM7YSI6VEVw193lGqBAoiDz51fZ/jRCAfM5EUD
 r09/8JvjFPkLIvZdARhZG60BMVVXoudatzV11fgFFa9AZQxLI5oJTSADiJOh4S/vws/A
 zkcVSqe18Q2z4qHKhFYL+3QIrbPMLrbkb4qasOi4jJNekn5KoKMAdN5zganRy14fiWUG
 XZHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIY2RskTFmC8TCBg5JPpLNuGjG20i8dCurj8s10j7FOPoa4r8XRZPJAyRJ4Wu+11d5qLRLRBc=@lists.denx.de
X-Gm-Message-State: AOJu0YzNXqS94PG/69KZrAfqUL06Fep+X2U39V/Cg42AYzuPaPGIh/aR
 cUSPDohxduFasURNvbnd7aowX4++nJArLqIa+5upQaS01+tN7l4c2H5/jDJBjbyJf7k=
X-Gm-Gg: AZuq6aKwDMql48EX3uFzu9ZSH1orCbxNidNxAnEHS2zWhd83/cACaZI0wzxpagQLxVK
 0+38KocCazc+84KLm499ZXKRu0EEE+HIsdyq6yz5OBd6U/U0WZ4z0tYiVZcsLYAvJdLoNHEzAyr
 u0GZrFtObFdsbLJD8YIy9E8MvbauIZrEILgCqBSzw0D73AHdebMzwMaUFlhnUjE2+XTXJtArlxc
 4PGSFSaxUGWK+lDSwGs3kqbNvzYsVY2eUsv3+iSieNpuQ3AFVWAFH5OpVnZAhFhkkum3rBNgzol
 vwbAu59wfqF65nyxG4PetqCJo9/GZOEPFjo238ELQ2/VziDcRWnqEcppdKoW2AoIQq3yJN7p48i
 YuJEsGAPjgVxWSOuaw6XhoBZefHmSORqK8tWln6pfUb+tN9m3kCRqU0ohJ6Ho9fjTjeuclasTsO
 8/kkRZUKvBK9YSrYQt79u3EwnsiZBkcHTht2IUwd9yO5w9swu/nTOPvtjXAcZMP6fJ2uav25K7
X-Received: by 2002:a05:6000:24c2:b0:437:6839:d5e with SMTP id
 ffacd0b85a97d-43768390f8dmr20067103f8f.13.1770818060115; 
 Wed, 11 Feb 2026 05:54:20 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d746a3sm5009466f8f.17.2026.02.11.05.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 05:54:19 -0800 (PST)
Message-ID: <bebb1333-5bde-40cc-b9e8-b1a1bf506e9f@linaro.org>
Date: Wed, 11 Feb 2026 14:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add FIT multi-DTB selection for Qualcomm platforms
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, quic_varada@quicinc.com,
 me@samcday.com, sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com, marek.vasut+renesas@mailbox.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

On 29/01/2026 19:48, Aswin Murugan wrote:
> This series adds dynamic device tree selection from FIT images for
> Qualcomm Snapdragon platforms, enabling U-Boot to select the
> appropriate DTB based on hardware parameters detected from SMEM.
> 
> Qualcomm fit based DTB format is documented in [1]
> The fit image contains only DTB, while the kernel will be part of UKI image.

Excited to see support for this!

Without getting too deep into patch review yet, I have some high level
feedback with this approach.

Regarding SMEM, did you take a look at my old series refactoring that?
I'd like to resend it if you guys didn't pick it up yet.

The main issue that still needs to be solved is how we deal with the
multiple incompatible versions of the "ram_partition_table", this needs
to be detected and handled properly at runtime. Are there relevant
version fields in SMEM we can check?

Of note, with the smem refactor it won't be part of the driver model, it
will just look-up the SMEM node manually and use a global since that
vastly simplifies things since it can be called from so many contexts
including before the DM is set up.

> 
> The implementation consists of three parts:
> 
> 1. SMEM cache infrastructure: Provides cached access to commonly
>    used SMEM data (socinfo, RAM partitions) to avoid redundant
>    lookups during boot. Includes socinfo header from Linux kernel
>    for SoC identification.

This is definitely an overcomplication of the problem... Is there even a
time save here?

With new SMEM the udevice will go, the RAM partition table and socinfo
you should only fetch once and pass them around.

> 
> 2. FIT multi-DTB selection: Implements the core selection logic
>    that reads hardware parameters from SMEM, parses metadata DTB,
>    matches FIT configurations, and loads the selected DTB with
>    overlays. Integrates with EFI boot flow by setting fdt_addr.
> 
> 3. Platform configuration: Enables the feature by default and
>    configures platform-specific IMEM sizes needed for storage
>    type detection (QCM6490/QCS615: 0x2B000, QCS9100: 0x59000).

I'm not suuuuper comfortable with this, particularly with zero
documentation on how to derive this value. I'm a little confused since I
thought the shared struct lived directly at SCL_IMEM_BASE? Or does this
vary per-platform?

I believe the right way to handle this would be to get this modelled
properly in DT, the whole imem region can be modelled as a reserved
memory node with a compatible string and a property describing the
offset of the shared imem data. Is this something you guys can push
upstream?

In the mean time, rather than offload this to the defconfig please just
drop in a table to map from SoC compatible (e.g. qcom,sc7280) to the
address of the shared imem cookie. Though this would very much be a
workaround until this can be modelled correctly in DT.

Kind regards,
> 
> [1] https://github.com/qualcomm-linux/qcom-dtb-metadata/blob/main/Documentation.md
> 
> ---
> Changes in v2:
> - In v1, a combined DTB format was used for multi-DTB support. Based on
>   feedback, v2 implements FIT-based DTB selection instead.
> - Link to v1: https://lore.kernel.org/all/20260106122134.2047864-1-aswin.murugan@oss.qualcomm.com/
> 
> Aswin Murugan (3):
>   mach-snapdragon: Add generic SMEM cache infrastructure
>   mach-snapdragon: Add FIT multi-DTB selection support
>   configs: snapdragon: Enable FIT multi-DTB and configure IMEM
> 
>  arch/arm/mach-snapdragon/Kconfig             |   18 +
>  arch/arm/mach-snapdragon/Makefile            |    1 +
>  arch/arm/mach-snapdragon/board.c             |  112 ++
>  arch/arm/mach-snapdragon/qcom-priv.h         |   10 +
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.c | 1237 ++++++++++++++++++
>  arch/arm/mach-snapdragon/qcom_fit_multidtb.h |  170 +++
>  arch/arm/mach-snapdragon/rampart.h           |  236 ++++
>  configs/qcm6490_defconfig                    |    2 +
>  configs/qcom_defconfig                       |    2 +
>  configs/qcom_qcs615_defconfig                |    2 +
>  configs/qcom_qcs9100_defconfig               |    1 +
>  include/soc/qcom/socinfo.h                   |  114 ++
>  12 files changed, 1905 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.c
>  create mode 100644 arch/arm/mach-snapdragon/qcom_fit_multidtb.h
>  create mode 100644 arch/arm/mach-snapdragon/rampart.h
>  create mode 100644 include/soc/qcom/socinfo.h
> 

-- 
// Casey (she/her)

