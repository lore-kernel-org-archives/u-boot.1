Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F896CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4507983FCF;
	Fri, 10 Oct 2025 13:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OqZQl8qj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB70F83FDD; Fri, 10 Oct 2025 13:13:24 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D596E83FC1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63163a6556bso3912851a12.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094802; x=1760699602; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8XirfqgDOMFooeSAlPupMg1KhfkZ528b3zeHQnkHCV0=;
 b=OqZQl8qjdSVKPHFSubFLjnK92Jmy0RTmJa4RYom/zJ0L9mQh+mmUIng75QZWddo/Is
 /cHwUHGg+d+41whIinvBohoYPe+3SF1zNg1FLggY1D9QN2AfHm2FYYLV2dNkJ9iAWJkq
 bwWPr/VzHUrdlLLPNqZPp1q9wJojvpZy9zGSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094802; x=1760699602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8XirfqgDOMFooeSAlPupMg1KhfkZ528b3zeHQnkHCV0=;
 b=aFTPtKPNu1omF4mba30sIvqybCmeuTuLdPBgaopzgEA/4QJ0mwFsatidDrCijJtnkf
 K4AHVRfxajqZTAkZoVJ4RAMA6D+vnCmF5DfAdj2+rVGroYCUjUh3Em3gFlumh/LSYeuE
 ZqtxiAXCZUzkYBfmgxydrvOhBr1RkZJR1IwDdOW+cdMBsxjeMJSYxuclKEYEaa74Ix4O
 LtEfGlMO7qUXEc7yqAHfeD/8axN35PiDOFLeBgx4skCHHAii2djVbYY48NgMkcSiWwDR
 tYMsh5aDsbuKgFI9pSIU7zmvg9f8qHlPNYNR/t+IvLzi1kItunIV4HdC1ij09JCt7jgr
 C62Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DWStt18xTOJ2/UiHz6qx5AI8TPbKrcV1MfKTq4og6Yp3WnSNnyEJBaWP2quJbzuXwYYq6BU=@lists.denx.de
X-Gm-Message-State: AOJu0YwLLE7YOgmwvm3G0k6u+UcGyE2J9ip/Lqvzo9wj7s8/4NDl4PYG
 20CHooHdM3ObThppgIaybR2rdK5BxH+WZldeWPqWG+qqumkEYOaQI9BW4D+qifjflPJIn3o0wQO
 QhgWUIXluObccv17ey6BH8LKWIf18h5g1bhqzzlBs
X-Gm-Gg: ASbGncsuDd4zmoaAd5rQzFWaSESdKXTN7vdmBxRyG6N8G2r7Evpa+PvJAwouPW5nPxh
 AdbCvRz9LILjwjEJW+82NfGqVc61hy+oyiZsccmqnUUnZJrIqbQzGBU55FZk4tA5lXbcBS+04Rn
 GjeXCRSRKqAlG05nFAIGdkrNYKx4pKNiB8Ab2Nt/MNDFe72NWHSi/7AtoXUPmXIxUo+1/rrpQWR
 1r+ehLQhXqWCXe1TOdiJaSVJ3FSLAmu
X-Google-Smtp-Source: AGHT+IFtUpZSe8IDbAZF3prpuMfNnRWpRYsPVNHSA7COPfgitaLr50PWKyzCp7dCn+QdEbg7N6n+GXf5EC9wAVr/2xk=
X-Received: by 2002:a05:6402:254c:b0:62a:a4f0:7e4f with SMTP id
 4fb4d7f45d1cf-639d5c52babmr9494175a12.29.1760094802296; Fri, 10 Oct 2025
 04:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-2-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-2-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:05 +0100
X-Gm-Features: AS18NWDziZB_7tCe7Jg302WL3W3bWKRU9wT5UxQouRw1MdkFU4kXnnkJADam1FA
Message-ID: <CAFLszTiM+HwkeT5Fi_fQchqpLxyHZ+-_Ykqs4b4OCBWWyvW30Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] boot: Move extension board support from cmd/ to
 boot/
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede <hdegoede@redhat.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

Hi Kory,

On Thu, 9 Oct 2025 at 15:50, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Relocate extension board support from cmd/ to boot/ directory in
> preparation for converting the extension framework to use UCLASS.
> Also improve code style by applying reverse Christmas tree ordering.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  MAINTAINERS               |  1 +
>  boot/Kconfig              |  3 ++
>  boot/Makefile             |  1 +
>  boot/extension.c          | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/Kconfig               |  3 --
>  cmd/extension_board.c     | 99 ++---------------------------------------------
>  include/extension_board.h | 16 ++++++++
>  7 files changed, 122 insertions(+), 98 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I didn't know the name for this, but I like this style too. Just in
time for Christmas!

Regards,
Simon
