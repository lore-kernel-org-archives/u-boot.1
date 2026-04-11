Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1C4F3ED54
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6A8084118;
	Sat, 11 Apr 2026 16:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LgdTSZ7T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8BF583DC9; Sat, 11 Apr 2026 16:37:56 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA3384118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-66dd1b5bb6aso4705731a12.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:37:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775918274; cv=none;
 d=google.com; s=arc-20240605;
 b=F8/3slCqN3Ym37juhjAwYZgsMQF4bK4roa+JZCzftoLPpluHLiKtdNm66UrHyqthD4
 +8fy6AxeL5ybSj0zw7AQ5AGTqGHWuakeIvwYQExiJ+lEHav/YJCRFlRvKOQb0BRIUhrv
 bboLBPLxYX5jY5QP/9aKtBc3zJpjdQMU3f43i4xtXCVHnDS8fzHj58rN1SGDKp+D7M4R
 LTKejoOifdDZtH1wSvuE96/6BacwISG20MOcLUBBI6gZcI9xKQ7TWw177avulD/Ra2kp
 HQiA3fCASqRH8dHcKq0Ks4fbk1yuyo+vE66vjFlSfNNDw/sdSrR2PK9NsMUUKwWaSPY0
 vHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H6qFPUeq29Dtze02cprcCQdnQ9QjfipwBxmcDiMwg9w=;
 fh=35nKWv1O9z9T1bPSK6xao9AAOuPRXzcikuMsULB6ie4=;
 b=AfqIG7H7skFMbT+ixq6W1MZxfevfhUBX1r0K9g2i/Omnmg40H8tI8WSLHLsXliF8/d
 mZOg2tvILI3YXFkYgv3Qrc4Tm1Ae0QS6qxVWUO7AlB61XjgVhmXqI6cs51z5M991fqQ0
 NWK5P9Oo1jFlOlfJeng278Iv+Ozbs1Sb8YTfCG6FjV1qh01Cih7UKYzdZsYwi/tTegvH
 AaSLT/QZFXFpFnbYTMmqOpVu81fDfYzmB2pUvgUcV5Dnm+LPes4cgTPAJw+r4PLzlv0L
 j3PJ8VPPpz7/YnijDPq2DehQzX98oS72adn8M0EOQl8Vx7lkrcxZUmRWle8SoP+yYfwZ
 eboA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775918274; x=1776523074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H6qFPUeq29Dtze02cprcCQdnQ9QjfipwBxmcDiMwg9w=;
 b=LgdTSZ7Tkvi2B97M8Krk6sXJDfTNCWfX7/PeM4Xz2PDXFUaWUsLtbL6D+lGQ5zsoV9
 EYcq7ZJByRiME9RRJPDYINwelpXkCcOcwWOZB8eHoiZU2U3t/WfMYJcV/JgeqhrFf3Wa
 FkhBfUJJNXPdxY+ezelxTxclSgG/jiLIj8PjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775918274; x=1776523074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6qFPUeq29Dtze02cprcCQdnQ9QjfipwBxmcDiMwg9w=;
 b=Q0/vXXZfPb3UrbK7L1/juyrE/hNDdbJeS8dOgN1iBDJTeQWZkzfh0LRkauYakAyNKl
 KRQHkj7qzvDIGpEKumc+DHvYJ8RulLVIMtyg2iItqCi32HBJOgF1WSJ8ZfLGYMwEZtSp
 GZUu0RNkz/d2zeGHnORqfCU4Q8Sc1X0t4qkkRmDNJ680NoX8FzVT5pjbCb8glraU/htC
 51QroWbiLB2v/tAERHnnWMdZeQ9EyKxq3KHRbb8OA8qMzCAAgOZ6hXYExdJ+u3bA9wM8
 mJnxSFIA6w3empclumRMShVk63k8xNlpx2mx14l4hJDduej15cu/0vPux4JdH1q2JLnW
 QqLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi4qeh++YA+wiESHqAs87wDpl2o3g041GO5VrHTp3132rMR5cxRZ8rJMe7pe3STG46HicHAoM=@lists.denx.de
X-Gm-Message-State: AOJu0YwZcrNl0eUPFep3v6Z3UpR+NDEiYtKs0HRII0DiY3lOBXjarFb+
 hBZNPFnuDiITI8H71gSkpLHctxSC6acEk9/PZpUNLYsymqj2AFpC3hXCJv1c9Mw+OqbyMtSaiIr
 8F+8+IdF+ja/YKCnlmFprHa72B1XvqM8eijO0fdXa
X-Gm-Gg: AeBDietT7MHylRdKXwU4/f6Uira6cLrn7R0oCul9Hf52nNn52Y0ncOHIKAedQ7Ud3/I
 DOjB3hidEk1G11378BAiZv/pic6KRoZf/ANrlkrhhhrSAL+kTmAXxtvZ/Pqquo3ZRShO5wpVnG2
 jrBBcnZiWeTpZtyr/Z2Q+bLNGmDY/mP1vnzLec+5HdiU3nGtZh0ffou6P6R4EeiL1neU0eUx2Zs
 s1yiK0Bu6jyLnZJNLD1eRJldMxzOPZ2+nA3kdVc7+WsatKeT8aWwuWPqDa2+EubZ2c8xLOw8HKh
 TzMUJA==
X-Received: by 2002:a17:906:6a2a:b0:b9d:75d7:fb74 with SMTP id
 a640c23a62f3a-b9d75d83c4fmr356730766b.20.1775918273729; Sat, 11 Apr 2026
 07:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260405144944.41074-1-lucienzx159@gmail.com>
 <20260405144944.41074-2-lucienzx159@gmail.com>
In-Reply-To: <20260405144944.41074-2-lucienzx159@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:37:40 -0600
X-Gm-Features: AQROBzASgjdNX82wW4kABrQG8M8dsRfjsAm7sSISuKhp8fJ5rVniWAdyz91vJcU
Message-ID: <CAFLszTj_einDasc5rRzt4KjyLuG2AS+=Y5w6H14aHuE43-dx1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] phy: add common PHY properties support
To: lucienzx159@gmail.com
Cc: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com, ericwouds@gmail.com, 
 kabel@kernel.org, frank-w@public-files.de, daniel@makrotopia.org, 
 ansuelsmth@gmail.com, mkorpershoek@kernel.org, skylake.huang@mediatek.com, 
 lucien.jheng@airoha.com, u-boot@lists.denx.de
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

Hi Lucien,

On 2026-04-05T14:49:40, Lucien.Jheng <lucienzx159@gmail.com> wrote:
> phy: add common PHY properties support
>
> Add a new PHY_COMMON_PROPS library that provides helper functions for
> PHY drivers to read standardized polarity properties from the device
> tree node:
>
>   - phy_get_rx_polarity() / phy_get_tx_polarity()
>   - phy_get_manual_rx_polarity() / phy_get_manual_tx_polarity()
>
> The dt-bindings/phy/phy.h header with PHY_POL_NORMAL, PHY_POL_INVERT,
> and PHY_POL_AUTO constants is provided via dts/upstream/include, which
> is already in the build include path.
>
> Ported from Merge tag 'phy-for-7.0':
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
>
> Link: https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>
> drivers/phy/Kconfig                  |   8 +
>  drivers/phy/Makefile                 |   1 +
>  drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++++++++++
>  include/linux/phy/phy-common-props.h |  69 +++++++++
>  4 files changed, 364 insertions(+)

> diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
> @@ -74,6 +74,10 @@ static int ofnode_get_u32_prop_for_name(ofnode node, const char *name,
> +     if (!name) {
> +             printf("Error: Lookup key inside \"%s\" is mandatory\n",
> +                    names_title);

In U-Boot drivers, error messages typically use log_err() or pr_err()
rather than printf(). This applies to the other printf() calls in this
file as well. Please can you switch to pr_err() for consistency? Also
note that these errors consume code space, so you could use
log_debug() if you don't want to do that.

Regards,
Simon
