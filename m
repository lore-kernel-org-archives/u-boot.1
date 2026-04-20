Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE4EEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6946284286;
	Mon, 20 Apr 2026 06:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdrsNv5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8044A80087; Mon, 20 Apr 2026 06:07:08 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C78084286
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-670f6ae9c7dso3413593a12.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658026; cv=none;
 d=google.com; s=arc-20240605;
 b=Yvwag0iQxZ720hwAewm1dSR1AHVbx2BTkArLL5/CN1S9Bb+aWVXH+FhT4SyKaqgBP2
 CKW+Lpw8b6pLTcOexYENbXZglN+PkdhJVbs/Wk3YeR7OgbfyGDRD53MUiEmqWy59OEYO
 EkvX2euqZst6S+YJCjz4d5zVoPDxSGNsPZQFIWABDZ8vCaDKULy69U1Jl8FDAqa5wKhQ
 wORqQyo8Qijz2Tb80FxP5yG3Y70dAVOYEdldHzJSJuHrSxfee6q7MqB3RUwFnuz9N18i
 YQ1yKMotjGY4CGDVUGUHUA/EBS2TjsEpuo3CnBnpXjDUilDdsLyNARq7mreqCEeMGIPv
 tKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wX0Tii1eoVbL1pPaCCWHw7nhC/y1UoljdUroTQnSPxY=;
 fh=lDfcvmqum5tG2Vtr2wpUhxlxUhLqQgW7WN6Cp0H2vR8=;
 b=NZ9BA+09j4UFT7Dwq6NvSO9J5r31Go5t3/uXhsJpbRUQgOChVPbsMS0N6FyLv5WKGp
 VDM18zrtkhesrnPybWKRJiUUhaijZB6xhgSSzNdYXcTN7Rm97HDCr1wFy91JZAskYAu6
 PfCLWahbjfvqxEKDlkNTBEYL8iM43XBjESGV2uBH8Qb0/GODQc+lvoJxDFXMU3jmI6BM
 bG4zg45tIokFO+04VvuzikllwEhTKACZUWHfNZ28gir2ONHCfBJZV5Dhpqei/5ZJaHLa
 npAIWXyZkfaj3fbDFUGg5aX6uLycwF7HeavjW3h/61o9pBi7zjBl1bX7/5gmQE1BBGKz
 BqQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658026; x=1777262826; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wX0Tii1eoVbL1pPaCCWHw7nhC/y1UoljdUroTQnSPxY=;
 b=XdrsNv5/X4qSgOM4FlNJ/hjZ+Qimb/BuEABS8/fUj/i1vYYw1wETKsHngOGhpeljn2
 tV1gjmkYQhipj+as20kUe6nb6R+ENZljdlarzpohAPD+UfA5D5V3yLnOYBsaabmcvgLr
 4MUHXCjGW1bZf/swrIpvWE7/rVrd7bjBzOHws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658026; x=1777262826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wX0Tii1eoVbL1pPaCCWHw7nhC/y1UoljdUroTQnSPxY=;
 b=Hi4Pxf7Fw79mV6gL94jHgv8GQqpVzsBdQiQKr12MIvGnnkwvHqMk6eT4KCZWvld8Jd
 YGOZb1JJWsTDXAPiC/XcBHbI9G4UxPKRLM7EqwAF28TlUeGm/1ydIRTTWWcaukKzHx48
 d1o+AmiqidH7TRVUIetBwnij2K5aR7wpOWB9sOHeI+RXbtIPqr1BQ14Np0Me6ZdKofcj
 YrN5z/S0l0t5hUVWSq0CM4gU36hdvV2v6nJvYZ15VGgfC48Bh/WjpOMUm7HXh+Q+LY2j
 ix3/x6iMRYZTZVYe9Oh7zV8ZwlKGCFvIuGiJCIWfiHpQuIOmVegc9nuI+S2eFMF6bK2c
 hmqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1iBayoWAqRsXBfpIkqnnAHVKxYLueFSr98KOCZwqMMyqa7ArcPHV/gr9yYBSrc3UAti8VGl8=@lists.denx.de
X-Gm-Message-State: AOJu0YwC3NZUDXRs0k4mq5q0I7Kr+W8A6wXsexqaY5SEMDHQu1Ziw0Zn
 Fu9FEjzMoUYQFqeVXFc8b5jkarHDC7IOzFODrCTdiXoMIfztA8uBDPW+B5FO/KyK5d5Lh6yKyhb
 ebuoctl/vC7rDb4WdR4Y4VpG00INHp7Oe54bsdyE/
X-Gm-Gg: AeBDiesetgrT3+TW1wb1CP4XDcjz3/7qy+Cqq0TDKYqlqfNuArDcIKQwK408DX+3kpC
 uSsNVYW8awRs2xb7cNmiQZLVfTwlhht09Deo64MZ88KAOn59/XU7FcBNKRW/2FZIItXsC4pLtAV
 EmACuxSs8coMGtkfm9t6WqmJninV4Uc45Io/Hptw3CTMvFa1wFnxMk/7Mb8x+FqviUSusGjoE4S
 DoITui84uKv8zCLJzzPzMBQndF6VOisvEaXthDPmWpEyc0Ltg98coZ/dKvTNtTVPaZ3Ha4OtT9F
 wQ/EhgaIYvdsBPRENv/mNwLi4qxkweQ=
X-Received: by 2002:a17:907:3da3:b0:b9c:77b3:a15c with SMTP id
 a640c23a62f3a-ba418882364mr512004466b.11.1776658026030; Sun, 19 Apr 2026
 21:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-5-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-5-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:46 +1200
X-Gm-Features: AQROBzDMSdoT2qrr5hacPVqqeHRgmM3pzR7OkIbqGBT_H09h6UDNqqY0RAotR8k
Message-ID: <CAFLszTjeyBpSeiVQZdHjdkK=hY3kFrY3Nf5KsQfy06rP93Z4eQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] image: add IH_TYPE_FATFS image type
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Aswin,

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> image: add IH_TYPE_FATFS image type
>
> Add a new image type IH_TYPE_FATFS to represent a raw FAT
> filesystem partition image. Register the type in the image
> type lookup table with short name "fatfs" and description
> "FAT Filesystem Image".
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> boot/image.c    | 1 +
>  include/image.h | 1 +
>  2 files changed, 2 insertions(+)

> diff --git a/boot/image.c b/boot/image.c
> @@ -136,6 +136,7 @@ static const table_entry_t uimage_type[] = {
>       {       IH_TYPE_FILESYSTEM, "filesystem", "Filesystem Image",   },
>       {       IH_TYPE_FIRMWARE,   "firmware",   "Firmware",           },
>       {       IH_TYPE_FLATDT,     "flat_dt",    "Flat Device Tree",   },
> +     {       IH_TYPE_FATFS,      "fatfs",      "FAT Filesystem Image",       },

The uimage_type table is sorted alphabetically by short name. The
entry fatfs should come before filesystem (f-a-t < f-i-l), not after
flat_dt

Regards,
Simon
