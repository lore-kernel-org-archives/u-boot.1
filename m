Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78233F3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079A5841D7;
	Sat, 11 Apr 2026 16:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RxEGKjrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F0E841DD; Sat, 11 Apr 2026 16:57:28 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA86B8419C
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so551684766b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919446; cv=none;
 d=google.com; s=arc-20240605;
 b=Qpi8PVxUdzBcu1Bnb9e9UCFJqjwbMhcnvKuL0f1lgx7XMdbgnfivI+QIl2n0xQtAnf
 NkF//tPoViZPvUQzFaWrKf3kap/jmItWhSJ1dkCTH1nb5Wsprbt8j0D8h69qw1VpxV1p
 kZnvqZQIE/AiPblFaXcwvf13TuW4lQma398qd4+mAYfREB2yI9LxEaX0q474+tfPIpSY
 ORR0V1n+H/desprHSjOOIrak4DdRE4EmCgH1/F8IOviSA6x28bZ3ZXkOsJKtkuLE1h7+
 jejY0oSO6hd/Z4XgjuUf8/vfT1HZprOT1xZZzpcfu1UzubnhNPp13J62Ecapb9rwd5R3
 vOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rjRTvVTtUOc/uRhfbmtJQ4TeJGs9Nflr0jJR6y6RNRM=;
 fh=KKUt9yEVI6n8Pyt9fY6HSHg+QVJbkB7ZdV0ReHkCPNU=;
 b=eD/D+XdqIpZEkwHIJeIcL2eMzX9+xQ9TNv2+KciR1u3RiZdHsIfgMn6XG+PXoymgyb
 WW9iQgFuNxHZoctl0I1lltjXbGgfQc55H+vyTlPVxMLN1UjDsp28YcRonbmgx+vSu73N
 Xhz6bXhuLnVBoyvkpAG5OTjRHv1V4B99YiquQsxYt6g/zir2t4nmnwPARgtgOMweCMYa
 05xnS7nI1IaZ41KGnkNFQ3A5FgnCpJT/1hbsVsfH8bauvxLwWiJewFFTOG6Gp/WCcIuk
 9UV8DrfqQEWaAUoSj8d2ssXvi/VfDfhZCxIWasNxZc6ICfRC7YZf3ejE23T3UOLP++RG
 jACw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919446; x=1776524246; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rjRTvVTtUOc/uRhfbmtJQ4TeJGs9Nflr0jJR6y6RNRM=;
 b=RxEGKjrByDMfHoAOLQChFdwtB+5WyYuWMtvF+lGdylw2z+QsNtlJGlZhS7hu3pO4Qi
 xHsELKvfrWcwJtNyZ1Y+kvLff6VaUrLIdtLhZ46uHiRjGCUbJK+9gNFm2sx93j2zyPAy
 MA7x1gu2qiPOod+0+ogYMcYKDmiShIsuPqRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919446; x=1776524246;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjRTvVTtUOc/uRhfbmtJQ4TeJGs9Nflr0jJR6y6RNRM=;
 b=FUxr6rnG7dNgFVkJDBNIZV9FFaJF2uheL1phV+plIKo+ggso2Rfuo4q214ttUMr+ix
 4SIStP4O8nT2tIUtnvjrVCce7Y7Lj65f0jZp9BRY110j/NGKlo0qJjHcp25KKwWaaYaT
 BI8vLPAvGe9PJX93ore6TqXirNIOEt17AgBllijcAfIQScB8jGCRBE8rQhHK+raz2c9s
 zptXmsQHN99UkL8eY10jSR4JhbU6M9XyURKb+3JuNOLqup0934bfL+RQG5W3ppNoyf6D
 vYK7E34TLFVdPhrfSfFSvwROYX6nrtog5hLJTe4yDymvhKnOn6Ieo1hh1dwwDk+ZH6U5
 bbvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4iTcUqoUuGrMTgJ6UiIs4Ket0ndfemiqHCB9zpihpDmCa16ILJGJXOPBnSK0D2u1C5pROvf8=@lists.denx.de
X-Gm-Message-State: AOJu0YyWmw+dAu2g2a+2DH7u2tNghi+24iwgH0Y3ZczwW03EPiE/94DP
 hnRHcjQaVNvPckmlXwlbCM6b/Hqr9bU0q1to0/tgOBCeotwaGyc8lryZXIzHPEaKH90LxUyX5ze
 2zuLviTH6bMoub+JO48nuQ4Y0V+4HtU8YFGuK4B9X
X-Gm-Gg: AeBDieuQ0VCGBT3Q5DeubTHBH2aJJDTfOViRM0m1dTO32dHN+KDfvIIOJrC13cFmmK3
 WT9LRUxnrJnfAU9dV0Kgumbslw57ZATPPOlmm0DzuT9zilSbW1UPVwWet6rpEX7F9fhkRfVHoVi
 p/msBUwihW4PxIpUam0NJRr6mpi3bFkggC/5VaV5FPZ1Q3UJXNBXvE6eyrGNvMsvN6/9+jAwKR3
 fcy091wTR8jVk7csh9ihkPPYDqE2ZpnUN88Zn5e44ZoVn1ScOWkkgnR1NezyLQUd215frSUf4oR
 bZ15v1O2UYvMxI0C
X-Received: by 2002:a17:907:c312:b0:b94:1224:c61e with SMTP id
 a640c23a62f3a-b9d72792e67mr394829166b.14.1775919446116; Sat, 11 Apr 2026
 07:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-5-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-5-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:57:05 -0600
X-Gm-Features: AQROBzDZcaja9MtI1F9p01XnAQBkCo_ZVQQ8lRiV0hvUqPtl-nCkGUs7XOPZifs
Message-ID: <CAFLszTjDdOqsE5CKbq7BjY2m=K4gJMC8b=WoWCvXydAsvzD4LQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] misc: fw_loader: implement request_firmware_size()
 OP
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
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

Hi Christian,

On 2026-04-09T13:32:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: implement request_firmware_size() OP
>
> It might be useful to get the firmware size before reading it to allocate
> the correct size. This is needed for case where the firmware size change
> across different firmware version and is not always the same. In such case
> the only way to handle this scenario is to allocate a big-enough buffer to
> read the firmware.
>
> To better handle this, introduce the request_firmware_size() OP to get the
> firmware size before reading it. This way proper buffer can be allocated
> and dynamic firmware size can be better supported.
>
> FS loader is updated to handle the new .get_size() handler.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
> drivers/misc/fw_loader/fs_loader.c        | 68 +++++++++++++++++++++++++------
>  drivers/misc/fw_loader/fw_loader-uclass.c | 19 +++++++++
>  drivers/misc/fw_loader/internal.h         |  7 ++++
>  include/fw_loader.h                       |  9 ++++
>  4 files changed, 91 insertions(+), 12 deletions(-)

The 'int' thing I mentioned in the last version is not that important,
so this is fine.

> diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
> @@ -32,6 +32,13 @@ struct fw_loader_ops {
> +     /**
> +      * get_size() - get firmware size from Firmware Loader driver
> +      *
> +      * @dev:        Firmware Loader device to get firmware size from
> +      */
> +     int (*get_size)(struct udevice *dev);

The kerneldoc is missing the Return: line documenting the return value
(size of firmware or negative errno).

Regards,
Simon
