Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E22C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4436584A6F;
	Mon, 29 Jun 2026 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AhxrtJsQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6433F84A1C; Mon, 29 Jun 2026 11:16:27 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839A3849EF
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c126553552dso106416866b.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 02:16:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782724585; cv=none;
 d=google.com; s=arc-20260327;
 b=qP+bEU5JRanzErpSQxlbn3vecw7fH9QdkTwaHY0xY96ed+YQPMH8Kb4pMLWhsOp4Qc
 wJhoTyf2FA+CCHZEhaDWNC23/aACAyOi92+EmMqPOc1qUh1NogPvqXRYqbj/f13b5CFw
 r3XOq6mjlv0grZDGsCKCd63IJKkDwQXUqTeTP4i6x9CuFy/wD4TvOn2rz9+8VYhN5njR
 3vFosA1++71WaOfQNLkNAqv1guyTVV9zJd9vlMPr/xHgOhKQ7w6MME8Oy9/AIOyhjWDr
 fwffmI449Zq/W1dXgSWzPBcGdpqHz5/lKmXiCETDG2CaR/t2xAzHC2iRvQMIle3csLKC
 0RuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ym4soPYGYa3qM1p5AdExARMS43kwK/QpIRRFn3U/suM=;
 fh=R/3aM2gUKvvP6xmWvhGmE7hI2iAkmLBRuUcEOhNJn8A=;
 b=SdWEMXJUcX7aKV1HU7QigVI2hEUfpGoTZ9/divQT016zOIapmqfQIUyY7q74d5Hlm9
 tk4Xu0bnPimLJIgk04MKu5EgWsk3QLSFfyXVZ6+Z5wg8jH/W1SJQu/WM2pFRt+E2FIFg
 6KrgM/22Wg9MDBplJ4z2fritFpvC+E/ZVobVbmSas+1GudIa8FAHezpjOyb+D7bElAHm
 Ra8ns2MYQtPjHDo73bO3tzPJ6BkhbFKIiLzi4rQYzI+qcW+M6nfWO3zBqXVmdaxd2EP0
 y9dYunqLS/RU37zZ0IW4JT4NGRmSiV/1J1hV9aox/7yux2OaIBd5kRzSmz8GWbueeYkD
 sl2A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782724585; x=1783329385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ym4soPYGYa3qM1p5AdExARMS43kwK/QpIRRFn3U/suM=;
 b=AhxrtJsQIkAuPXM5ENIuYXXFKKnkBGO1ZLUHbP++PEKWwgDBN6fcTiHsnOuFQwcF8e
 9/GZtAUYEDgeNdxQ9s7YdlMtiUUsK5u1uJRO0yvhS2PQYLFSwFIPxQNbohzjZCYWjqeW
 Cp1eDuewSjYvRRdtt415HXRR5ZQ4ia/XyNnaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782724585; x=1783329385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ym4soPYGYa3qM1p5AdExARMS43kwK/QpIRRFn3U/suM=;
 b=gh+kG/z+cKstySXhmPxh3ibYgb05AXCd5L9AjZk6RQO2ZnVUY0rHOa+OST7jy4Y/lM
 RhLGCwVjTzDWyhxoLaLI1dOZ0aDWrLpEf7Xlca/zxoVQQGHDxviErVhnc3zzYgaTBiOx
 JHany49tW7KZr6joDSYoeDJgEvmr6gDYQlvOXTHcu3qZlJtAW5i1BXbk1wLJ4nrS99xu
 ZGpw/WF0rzTi6dhntvl46M6xClI9jhDgqovhxQMCmYFXzGowdXMV2FBXXeT3psxbMUGg
 fr+FfFuVUTGB+C4NW0LA/jAAl4jKk2GNKaxytxE6u7UtpFihPaKEDYhp2DX+NUg3k7fo
 Ra2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2Rr27Hhb32qfzvZetU635PJSuaLRmlDtzSML9JEoVVIUAvqZLGBZI4ojuvnSDWGIePPcVcbg=@lists.denx.de
X-Gm-Message-State: AOJu0YwZR6yCkVKGDgoYDFHAWjdJjuqaha7FQWFiDFGb3dF7mif9jeFg
 Em3cB4AEOpqxP7sTInqydkB4pAIpXYsQrX9DPSwaedFgjxGeMLT6o5OmLxccYra1yBzMRCIALZJ
 MUo1zfFHc2t4XnMPWf/K/uZzhUB2jdAhKd/VHk2SP
X-Gm-Gg: AfdE7cnHIrmG4j4VtKN1PXxNvocBzIibhfBHcPRSVfkQ+MiSWdXf3Tq96yDsOuFIfMk
 xWZHJa5CsthMSJ8Kbd06XFUX2ZWOhXQf/eVEsdAU1cd9W8/r4KFno73L3DK/zm+eraOMO4hbCQU
 2wL9E7WNQ+/XzmUYEJk8P6242rxzt53WhDeyrwYGNwO/BIcQCTqaHCcrgQQuBfSujcdd5WXxwU5
 RmwebdLLCLJ7h+511+toyLLu5sanMtq4C3ToRXndxs380DX6wCp1ILV+8LbspUPbmCRjdc7Lg==
X-Received: by 2002:a17:907:724d:b0:c12:27fc:22ee with SMTP id
 a640c23a62f3a-c1227fc3b5amr515230566b.14.1782724584988; Mon, 29 Jun 2026
 02:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-8-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260623064804.3988799-8-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jun 2026 10:16:06 +0100
X-Gm-Features: AVVi8CdCjP0UT6ADKrouahOGur0QUMmpkw8ui97emRxMvJNdPphrP4njSlz4y80
Message-ID: <CAFLszTgKaArOxbT-s3qMgozOmT84p4mxXTZ7-OhuO-RYmrWyvw@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] mach-snapdragon: Add initial support for IPQ5210
 SPL
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, marek.vasut+renesas@mailbox.org, 
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com, alchark@gmail.com, 
 mkorpershoek@kernel.org, dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, ycliang@andestech.com, n-francis@ti.com, 
 mateuslima.ti@gmail.com, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 philip.molloy@analog.com, ravi@prevas.dk, sughosh.ganu@arm.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
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

On 2026-06-23T06:47:53, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> mach-snapdragon: Add initial support for IPQ5210 SPL
>
> Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
> console init, identifying the boot media, loading the additional
> firmware binaries to setup DDR, TFA and eventually jump to U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> arch/arm/Kconfig                            |   5 +-
>  arch/arm/mach-snapdragon/Makefile           |   3 +
>  arch/arm/mach-snapdragon/include/mach/spl.h |  14 +
>  arch/arm/mach-snapdragon/spl.c              | 544 ++++++++++++++++++++++++++++
>  board/qualcomm/ipq5210/Makefile             |   3 +
>  board/qualcomm/ipq5210/spl-ipq5210.c        | 159 ++++++++
>  include/configs/ipq5210.h                   |  11 +
>  7 files changed, 737 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
