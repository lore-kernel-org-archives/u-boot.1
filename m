Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D909C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1337A810EA;
	Fri, 28 Mar 2025 13:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UqEPZ5XJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FE5810F4; Fri, 28 Mar 2025 13:11:35 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76F858082A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:11:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1659951f8f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743163893; x=1743768693; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+VvMso7w0wLEK/0XwuSQxnmsW1WokoiEJlEzL/X7yQY=;
 b=UqEPZ5XJoY5P9W+jSyzInZ+P6XTmfKlbUpdlVKeCCo8oatGGdHI785XzaWouUc0zDr
 y6oR9VicrQTsbOFG44WRtE2YBWNvHNGnpTa/NOFKVXRwrWuKIZ9RF4BigH9I98xxykbv
 fmv6r0PefTldIn+K3HioB6Ph9p6NjRosxBZ0CwqaAKd4VtgkXxicAgqnjbiWyY0HePVd
 tQc1nLY1s6fchfsJZP+x9NVLZnbA6Rm3hgRLFUEp56zOtyHG80pQ5ix9fyNOg+5F2xNB
 xL2zFYfwmVsFQ+WoXFB97QnINeDAUJwJAOFFZV254KeuTnF+r7DqYQEHCL114FqZbw4d
 AVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743163893; x=1743768693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+VvMso7w0wLEK/0XwuSQxnmsW1WokoiEJlEzL/X7yQY=;
 b=gZJE50skKCx9CGFYCOl6LXC6e/evO5fkMKkEbZuMRH73idnInECVOjONFhirIz6uvI
 eawtgUsRtRlBrbBzYgCOTT4BkIgQEJwpb/G7spnwN8dyEDf9chOAyFAbTrdxFEy9BXU/
 gInUo4PVMyafM4NdNn27Bp+HFChDYmyTdVPkOyInv+2PHTz7SeZ96GQjKu9AqeWc7zsj
 CNLMGne0RtG8xIHbuJp5Q7Xn8AkRvibhDtL9ZBmi6HCaeAopMmFsfEetEdztBdWSnbRh
 3/VpC0qxM449Um5SsE/naLHSBFGoBVN0YPKEdO4OAp2vvGZshPEXwDIEJot1e9OERL1Y
 xNSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPvjcSzMIOgf9NXS/RfCrHcZXZKIgRn0WBzgVRWWxdA9TQcvJ/kLr6XU+hqVW2D1Fh5VWhZ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzXDy3/Haj/qN2XH/xojTKoY+QCX+amsKTZyZIdkAkCRl6GS3e6
 fGQZPOZgzwkP8hQu0VwsN/HMczH93xdTSMNvO5WW3XcZV3Rtq0nEhjNYE2O6YOtNt4XWIqAT9Qk
 QWD7QbR+ZyB36LlwIPV63e2b6A0GHJc3f7f7nQg==
X-Gm-Gg: ASbGncuCPe9CFtVJDsfm0M4UIuN6VPl1LZw6UgzMswHYxgjkS90/gaELsS3eT13whOR
 t3SOfDOh+geVSWsHmvxNyxLMuZvgWF+bpndcTgchms5tvaS76vwjMNnEDBwcfShi27O4Bpw/DuO
 Ao+VcKgyrfXMpiMXTsjhLr914nwyIMo4/0QGy4YSA0WYoypAw7VzvoWixWQK0=
X-Google-Smtp-Source: AGHT+IEA4u1VHVgf/4VFYoV8OFD22PkKEf8/0peIw2J6EnTHdrstaZnNRY8p8nffAWPI/5swET8I4u7fbbv26nNwK7Y=
X-Received: by 2002:a5d:64c3:0:b0:390:e62e:f31f with SMTP id
 ffacd0b85a97d-39ad173e892mr7063096f8f.3.1743163888016; Fri, 28 Mar 2025
 05:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250328104011.1837872-1-caleb.connolly@linaro.org>
In-Reply-To: <20250328104011.1837872-1-caleb.connolly@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Fri, 28 Mar 2025 12:11:17 +0000
X-Gm-Features: AQ5f1JqOSYmztv8qCZ_TNIqOVT8zKXz4bnv3X9_DPxngd2PD6cfCBMyekgX4Bu0
Message-ID: <CACr-zFCxnVG5iiqY6BZbA+HwkWBeDtk8t0=dSdaytb+dq84PdA@mail.gmail.com>
Subject: Re: [PATCH] qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sam Day <me@samcday.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Caleb,

On Fri, 28 Mar 2025 at 10:40, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> A single U-Boot binary can be run on many different Qualcomm boards just
> by booting with a different DTB.
>
> Simplify the build process for this by enabling OF_UPSTREAM_BUILD_VENDOR
> so that all the DTBs will be available after building U-Boot once.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Acked-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ba4d38d100e0..a12a5d17b406 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -40,8 +40,9 @@ CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_RNG=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>  CONFIG_USE_DEFAULT_ENV_FILE=y
>  CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
> --
> 2.49.0
>
