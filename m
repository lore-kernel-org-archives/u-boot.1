Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D7ECD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D447B846A0;
	Tue,  5 May 2026 07:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WMnopdtu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6058280086; Tue,  5 May 2026 07:42:32 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BEE980086
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c0bda7f15so4857269d50.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:42:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959748; cv=none;
 d=google.com; s=arc-20240605;
 b=GkgZ3P586i1G33Jjo910bYJc0ARG15ubvinX8dHclhMCz5BUj4fQ+z+/krVyTkATp9
 vmrGono05nRFUazYQcsdiKcb1p44XX5NKqohVXuiMykEmevpegTENzkIoZz1c7sIYika
 cJEEAYH+d3gI8u580AZ7YhI2fygjpbG9YQ1DR+cZiyr31mniyMDc0CfluGVpXEBjIiMK
 zBIguZooVX2XzoSXHCS6MzhNGSm+T3kVuBK8lFpVVKoirkYtBz8+3iaYxDrZlPTgQb/V
 wNqH3KDdIryWxmFZeWEWN5xPdLgfiOpYms1cc+2aP6rkvm2v4aKV2WXGV5G97JgqnzH5
 eAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0kxCDkU3t4rArYYlmKOpuEydmYfM4w9r4uQ1C8xDA2g=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=bw0UD86H25bmwsfv54vKRKou8ivafspSkSG2xBN5TgNhMw8vwR9TP/DcxAMACi+iic
 RahbdjYd9u3lawoKIz1i8kG07uQw++XqTmfGgYjiGAfkEKwg12pRPy31EJIuoHC3VWsh
 5Sk0w82KMLM0U+3vzNP77+mZKN/eZhbcZ3Sj9eyH23Sw9fGfMJaxuAkMG1c7IOT8ER2q
 tFVB2k188RVt7Tll8w74M0b4ZxuEf5mne9oaz8FNBK9e2ixOXXh3A245V7GeAudFpGV1
 xZaDa4R5N9pDWvvebu7/l9GUjzatLSyOtNlpkIUYxEN1YjIb0+DjysXXDs3vrt/ZJ1DW
 hhWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959748; x=1778564548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0kxCDkU3t4rArYYlmKOpuEydmYfM4w9r4uQ1C8xDA2g=;
 b=WMnopdtuURkKLe5KCYyFGeNwceM7V24IWesKvpEcX1m1ndbm8jBI1YqjCP5pZHuEiZ
 ew/XmUUjSfH5T6HamDcX7YeLEK3aqViwOJDovPlr51R4UI/U8CG37+eoEEiw/04hUXQL
 WHugDYu6UYJBHZl/bHDe5adHI7gtj8LI3/eU8ML0FBkXHFPJhinrHQJu4QP+Ym9iEwk3
 vF+ev1a3iuQNKy3D9HLQ4BZcYA4W8em8DjuXhC+SoNTSx7BUSwtXH4PWQ+NqJlTUCNch
 BabknLQ7XW2j8XVlny85UF1L0cwo8njULbqvf2z0WCgT5xXkBpSFz4I7G8snwwQlPmhD
 Vtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959748; x=1778564548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kxCDkU3t4rArYYlmKOpuEydmYfM4w9r4uQ1C8xDA2g=;
 b=Zswwe7HiB2+jtdw2e1GduwGz5jNVZvmqin5B/vNB+xebXuUgjLlanalQoX/StwJzPf
 0jVMccDx2xzDksr7VwYOgXO+0pDBJFxgZGGgMGtkLFGvLvKBVPObIc2RSX8rTUnw1DGk
 mFktlHXNmFP0MFoGZ04YHOdqy+fhAC5neD1JtknBLVK/0bWDpLpucnS0ohgxgZiRyZOq
 lu0edG7VxIFD1GuvyvBLcgJC3tRWRCUun0Pf9cFhcqd51Sqfw3d9qCsLT2Asmza18a5a
 HSkTSD3HeoKL96qiujc8iiykim0xrQljWr3F3LeOdZB0g71tGw85tZBRd2JeU19/Yqh3
 KgCA==
X-Gm-Message-State: AOJu0YwRLquN0FOMk0wJP56wR18RaryMLty65x5Hw8+OoNtOamkkw8f7
 k1wEsvOM6u11Cn762qIg+NSfQMF13OzmBy7yy/MTLGp+dQ6lbycYJPr+lROsBlleflTW7mBX03w
 v+0s50BnxEHvM3WO5eXf4kFi/MXTtQkxfU64BSbW75A==
X-Gm-Gg: AeBDievFP+5X+T0qfRLkYlBWn5gmVeBECkSa5LgbJu1P117XGqz9nbArUz7ZGOLJ2jR
 jJQNfC+nvqZEmq2V5vDYzPfV1oms7XOwucdIwZTHkfBYX6qft/XEWhMDJkzMZD+d87eMw2S1rE3
 4p9kDRnhu+fBmzytw1daFy/ofCXDIEY5yd3pP1Ar1XWEJd2mRi6mzjD+JWplRKS4wbc2ncy1ltm
 ZxAZjBAz2MjypbIGQS4H/Hjh1Wxw+bgRiCxaXPhXmlxeH3syID/zRviqyPW8u3X/BqmHXOj7rSr
 LCe/huWA060nMOZoAllSCTS3X444XSprHqcbq6JFAC8JbnFYZIsERUPVCqkl0c0+4HNp+J3ISfx
 /wDSMmo92Gj0C7uuPkf+bNOHK/lVu3U4KldqSYE6ahNYCfNVmipsFGRE3h7YHKvQRe/izHUrXO6
 /r7jB7SsPEHe6gRmgZOkUw6t27vA+19UMbma9UHnL6UFdRdgb2Iuly2JhO1DcNsLB4pWhfC2x47
 bMsKTpBXtSrtfoWvER6NtAv8M3uoOuR5b1DbFtIB2xoiAUpnWXs7CPHbhBiM3icAj3WimkC6msg
 YsKGrLNyoZU8EbmeFnb/BSzGIvUeh58abarssCYPA2NjSOfdsfP2jYw5c6myeeiQ98DT6NGNR1o
 GbqN7/MEun6uiKa0+IcRIELL/U8M=
X-Received: by 2002:a53:d8c5:0:b0:654:6ccc:69e9 with SMTP id
 956f58d0204a3-65c3db550f5mr10184365d50.51.1777959748264; Mon, 04 May 2026
 22:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-4-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-4-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:41:51 +0300
X-Gm-Features: AVHnY4LUoYY7R3Bb0wArFZ4Xm8fvMAYIbm5UnIE_YhEseDKKajr5Fcsov_etBv4
Message-ID: <CAC_iWjLjQ4C2qpQ9FVUAQu3_46hV+Fq9mu8u0SwMUBRbfLCspA@mail.gmail.com>
Subject: Re: [PATCH RFC next 04/18] kbuild: re-enable int-in-bool-context
 warning
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit a3bc88645e9293f5aaac9c05a185d9f1c0594c6c ]
>
> Original commit log:
>
>   This warning was disabled by commit bd664f6b3e37 ("disable new
>   gcc-7.1.1 warnings for now") just because it was too noisy.
>
>   Thanks to Arnd Bergmann, all warnings have been fixed. Now, we are
>   ready to re-enable it.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index eb61df70838..0404657dac6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -897,7 +897,6 @@ KBUILD_CFLAGS       += $(call cc-option,-fno-delete-null-pointer-checks,)
>  KBUILD_CFLAGS  += $(call cc-disable-warning,frame-address,)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, format-truncation)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
> -KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
>  KBUILD_CFLAGS  += $(call cc-disable-warning, address-of-packed-member)
>
>  ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
>
> --
> 2.54.0
>
