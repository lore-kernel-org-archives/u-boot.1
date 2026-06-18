Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3ECD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF152849AE;
	Thu, 18 Jun 2026 17:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SbNALYyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4E1849C5; Thu, 18 Jun 2026 17:11:56 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53B28460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-695f5ae95e1so1165824a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781795514; cv=none;
 d=google.com; s=arc-20240605;
 b=OCqW1ujw1JLbUtUcsMZjcC0GqXqMqDne49FW7SwlpMSGDVYtMSCtSraXJWazteDqAi
 qsFc7nHenqjVyvlY9E89B4B2Oj0IXQxNpYmp1NINaF9Tlt4kF/dDPZUTnwfpsjAmfQ7n
 rDGWI4/3Ba7xLN6GR4IBJxayTLq8Q4WSlNIgaLpnwxwfiLcJkzb9jCTIMauUmg/yCXk/
 DTQZ8F1uMaZp4l8MUzTQEFQPYdPUaCUexOIYbEEoqZBnVtmbt3vrLdKDWw+DIe4dDkf7
 V/LTeRiZsfAjY2bnaRNUkO/lSIDRsdeDTv3qZiunFpDz+iyh1ycZtcqT4T8e+lUzH7H6
 pf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4xUWlUee19ToWuq4pfo3ZYeXOMCfOqGZgiaJmbHMJLo=;
 fh=9yTjFfFb8FrOmKKKT7SbI/aqtqgnfkFojmDfdoXnctQ=;
 b=Wco4J8SOZr4wXl8IgY8y8zQ8K62WuS9fP7313TIr46VBB1bSXkRTJcwPVwprRP4E1Y
 dAQGkD+vtam0alGUNktXbdG/JH5N5OwawleHQZfsX5RVXTLJFPDKFEOGWNOjzxd3g2yz
 VYoeC4W1y9EeBaVvXalCCY896XK2OMnQRtT+jnEmAFoIJN9Ame9qD04ar4hg5LI75ifU
 OOulmYaIJq5qiUk9ZEXMpTfV6HvGp1GJ4UXzAXmYU4i850fJcx7uxf98jTEDCvkqxdHK
 7+AZMRvjJxPupEIvQxiDCXXA6SoNv/YlkhQaZGUeFQESQi+mhImph9J3UfCrgpVDwEDw
 Wzdw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781795514; x=1782400314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xUWlUee19ToWuq4pfo3ZYeXOMCfOqGZgiaJmbHMJLo=;
 b=SbNALYyWK5VHy3xKIWo2195mryxKU/UW4xOr1hcevNT7IesUw0yjvW2+BnlTJHX4HI
 ieyJ6FO9sr0pEY4ZpsrMSzdbwlzbb1fBHMWfbrEfWMX1ML+vqoG+lA0UgLi58gy38kuq
 y98DZy3D+3nOtg7HWV8eYXQuKihCZNthIPVvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795514; x=1782400314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xUWlUee19ToWuq4pfo3ZYeXOMCfOqGZgiaJmbHMJLo=;
 b=CDFHxQFeQYPxyz2FbThCflmFsIzaS4A6dLlLrIJljeVcaDtV7DyHt4We1o5n4jY4B0
 dGLsjXLO2jZG578+UL+nnYOcB/8OT6YGigWCIeo2Uw7TcQvHAjQAVu7dI07zYf7N9Zxl
 bNGreC7r9wYr8ff6qEe9CeFB4bdPiuENONFHdQfjzMkpNw/UuY1lbqXeBGHFHiLCKzVw
 O6FNfYsdo5jl2NE6OfMtsB43PqVl1A6Q4LvBvwNaRSPR2wygtcLiBUommPgw5zm2tBKp
 hKy+mPQr19+H405p/hWFnhzSX7jA5dPtAzVpmcpl8rhq7fVUJeQ+vgC7ORO7Y3Zn98mB
 hXIA==
X-Gm-Message-State: AOJu0Yx0YR8CKMVJznQPeMemzwv+B61Sk8gngpJut6vV6r0JPLToya7Z
 YTJ7ugDpgayvuWBJUMreTGKQWU6/ATg+rUzeplaCtvH+zfZ2OkugIE1m22juDeYWYxCcMo0tWz2
 1jgjLR8+0ragP7WnHSbY7Zv/iVpO43qQLoQcRZHjk
X-Gm-Gg: AfdE7cl/hBhN9L4Sckz+H76Ec5cOgpKGU32us8LF3hcTi54FueuD15VobCgTDxKqrfE
 aIUG1i/VT7vst2aQ+gbVqMYGtv9W2L2xzoYfr5zFVHSndaZQSB0txKPhvJVCLjXu/+GBFJRuBYk
 EhJtZrbT4opyKXfgu5JXPrLwQFt46h5kFs0GkNlbQyz5N8+C2RZBXcCzuFbFpYDfu+wJt4goFnF
 uNOBG8kuaC9DPZ6H6LrOEnupdKoW/IfJFYjlCDiK2bB4AXWrn+eCgfJ1yxgWwexMF9V9Wj4iQ==
X-Received: by 2002:a05:6402:5242:b0:695:c058:794d with SMTP id
 4fb4d7f45d1cf-695c0587a60mr2057263a12.14.1781795514147; Thu, 18 Jun 2026
 08:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260617-qcs6490-rubikpi3-v1-0-495f618a1e4c@thundersoft.com>
 <20260617-qcs6490-rubikpi3-v1-3-495f618a1e4c@thundersoft.com>
In-Reply-To: <20260617-qcs6490-rubikpi3-v1-3-495f618a1e4c@thundersoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:11:41 +0100
X-Gm-Features: AVVi8Cf3JjKEprPszVodLymL8owH_grXbbfQPuwavX0VfIQYYmAsnTk_ylf57_g
Message-ID: <CAFLszTgc0zOkcRnJbVXzVH5J7==fdEg=OQJ0cMtey7-GQB8Dpw@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: board: qualcomm: Document RUBIK Pi 3
To: hongyang.zhao@thundersoft.com
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Roger Shimizu <rosh@debian.org>
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

Hi Hongyang,

On 2026-06-17T10:56:10, Hongyang Zhao <hongyang.zhao@thundersoft.com> wrote:
> doc: board: qualcomm: Document RUBIK Pi 3
>
> Add build and flashing instructions for running U-Boot on the
> Thundercomm RUBIK Pi 3 and include the page in the Qualcomm board
> documentation index.
>
> Signed-off-by: Hongyang Zhao <hongyang.zhao@thundersoft.com>
>
> doc/board/qualcomm/index.rst    |  1 +
>  doc/board/qualcomm/rubikpi3.rst | 51 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

> diff --git a/doc/board/qualcomm/rubikpi3.rst b/doc/board/qualcomm/rubikpi3.rst
> @@ -0,0 +1,51 @@
> +Note that fastboot may not be available after replacing the original firmware.
> +To restore the original firmware, or to install a new version of U-Boot, EDL
> +mode can be used with the firehose loader binary appropriate for the board.
> +
> +A tool like bkerler's edl_ can be used for flashing::
> +
> +  $ edl.py --loader /path/to/prog_firehose_ddr.elf w uefi_a u-boot.mbn

Please can you describe how to enter EDL mode on this board? The
rb3gen2 page points the reader at the Qualcomm Linux documentation -
without similar guidance here, a user who bricks the board has no
obvious recovery path.

> diff --git a/doc/board/qualcomm/rubikpi3.rst b/doc/board/qualcomm/rubikpi3.rst
> @@ -0,0 +1,51 @@
> +First, set up `CROSS_COMPILE for aarch64. Then, build U-Boot for
> +qcs6490_rubikpi3`::
> +
> +  $ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +  $ make qcs6490_rubikpi3_defconfig

Since you are renaming the defconfig in v2, remember to update the
build instructions and heading reference here to match.

Regards,
Simon
