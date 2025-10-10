Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482FDCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 11:13:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A25EE83F6A;
	Fri, 10 Oct 2025 13:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gX7ys12+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC9F683F91; Fri, 10 Oct 2025 13:13:20 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E030583F69
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63a10267219so2640725a12.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760094798; x=1760699598; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zRLH+ojoamXHFJTFK8xmaH1SF/1Ucdy17+u1gu5oasY=;
 b=gX7ys12+r5dGvO4nicSf/20JeCW0FVUZWn5GrPHEuhUi2jm1pJWUGNNQzmuAFeO0Tm
 zL6hfbnVoVqScE+QC+CF1qvQ/aj5BniDT89q0iZU4NAji9MaVHSMvK1nDJb0QlB3c33G
 ZhyQhuMH3mDvAUfUCeDQRQYCXX0wyDOFISYkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760094798; x=1760699598;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zRLH+ojoamXHFJTFK8xmaH1SF/1Ucdy17+u1gu5oasY=;
 b=EbmS4cE30sZLjxvINyzXeMaY0IoBb5qCMyieqDedYxQa7SeMmH8C59Finz64uIjyu7
 XISXyYHnd0oMN8ukcfi4xTGkjPB/AXRcMd4UCZT6UY9ttK+3BXG+BGl3/B84GDRGzoK4
 bX/8xlFesXy0UtcMWXGaj2pRz/spbYzyqeWj6X/j3dheZYdbkDOJweqZU6BU9J9Xcf0s
 ErjpB0W1M+uzUYYwo4Yk0ON9kXTZB5j/oGQEdzMIb6N3TL5WHqaIG5eh5miaGANZnHev
 z7hC5+sVouxuYz1YsY7eSMJX/I+e76CzFod11Ey9cV1IlleDzgQCmAtQsXBH5AeKDLtE
 sD6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXthrczNtwGrm38t1HFYHSYk5bRVpaiirbG6FdzGQWfFmfIDneXLd6AAuo25YtneP0Gz9FfYvU=@lists.denx.de
X-Gm-Message-State: AOJu0YxahKIPKqe5OkCrJVQ7yxQaVg4JTHvbJN+0bCo6s6bxMoKjFP4G
 fRFc1A6thFxd8FhFULOnne0udF0aDvxydtkKi2mQSixREKyIhvftu4zVTTWzDIIHlSF3QpLS/mT
 5wso4iqRF08OUeG9NL0rJO3Q9Kj0FQx6RQgdezLeY
X-Gm-Gg: ASbGnctWX2mYpdBC67Tp2VZBxhmWabsEKsJgDeidp72q8D7buK80WWky5mUlK8AoEN5
 7GeK0c5dQjzHz3dtrs/zhG51LnvQtxFiLCR3EB6BbkmsBazpnQ12Uv86FOsOdwPJqVP4MSbo3qg
 cML7i6mzJVzk9bJ6q3K95UFi/AV4KQ+XF0mzjAXcUH9KTkp328xjMz8DRpO3irDAis6k6DlX3le
 9vBofqE3izW+iMsOtjLyQ==
X-Google-Smtp-Source: AGHT+IFHWEkWVNK8VJm98jXAvSkNgCJuJWi3qpxD+IwL6WSt9ch+5lFJ5EvkAboZlXe3uENAJ6K+7Rsm6yCZ93SDMX8=
X-Received: by 2002:a05:6402:350d:b0:639:f77d:6e5f with SMTP id
 4fb4d7f45d1cf-639f77d75d8mr6675719a12.17.1760094798354; Fri, 10 Oct 2025
 04:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-1-e09b39e54de5@bootlin.com>
In-Reply-To: <20251009-feature_sysboot_extension_board-v2-1-e09b39e54de5@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Oct 2025 12:13:04 +0100
X-Gm-Features: AS18NWC5y4cXjGSkGkVBCFpEIyMmpWGslqOL6PJheYsQf06CxMckX_H7GYt6rcM
Message-ID: <CAFLszTg=Tq9812czjKNkQ+sF74JBE12iO0XzX0LEWVO8b2zVzQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] MAINTAINERS: Add maintainer for extension board
 support
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

On Thu, 9 Oct 2025 at 15:50, Kory Maincent (TI.com)
<kory.maincent@bootlin.com> wrote:
>
> Add myself as maintainer for the extension board support that was
> originally added to track ongoing development and maintenance.
>
> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
