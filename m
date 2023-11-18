Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CEFC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8AE874BA;
	Sat, 18 Nov 2023 18:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ia0uhlNl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BE76874B1; Sat, 18 Nov 2023 18:11:47 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A89A86FEF
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-daf26d84100so3027547276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327496; x=1700932296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U2ENk60jD78q6umOz2sz2kWGEfLW1ME9R7TIENygeDI=;
 b=ia0uhlNlNcdopZy8+zwytLWmCx47/MJujoTCmojE8IUBMFKaLhsUZlAPibCDMiD/Zg
 jIXdLVtwB24enXa37otEsxS10E3yiw3Y/LGpS6AslU0avGdakdscvDU2XXnU89UAgobU
 xzn8AfxMy8sglW3eq0fKDqhgCNdZrkPOLI4y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327496; x=1700932296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2ENk60jD78q6umOz2sz2kWGEfLW1ME9R7TIENygeDI=;
 b=TvB0XmBnll0h9fINniRooMWwdmvTsPtEykFgVe5R/7odwst1GvuJmL5rGyJgGXNv/6
 GwXm1pbdfk/k7PxrFjzmCnlbc0UXiE5M8qsOtZgRyWF5juUYSRBNThN03Ez7v1xLcIr+
 i2J/znEmGUnzDR1vcWqt/YZnmDNQ8wEJITXS7OrR8OTUtqF8DS2pFaSj3txkpphSwUHR
 8255tcT4GphKZWq83Ky7txAGZLAf2LIgT0s4bnprAAnTCvNgi6E3me0o+W/3SY+OIpwK
 ayF8AgNpuHxshq2BqzNmYzfjyYVPKp/ueew3nmaOqM++qDZ9I19jlzp/W9KF8+5Mv9IK
 D9ZA==
X-Gm-Message-State: AOJu0YxuTy1HtUu+xW3GyQYtAXHtjabgvOrKwT4s7ZDQAC0RRDpGSOz/
 Ik1U4nct7M55t7LUbw96WoSNgg2Imx2+7piHgPdb9Q==
X-Google-Smtp-Source: AGHT+IGoMaPaaf3Ctyx6DvYQuUlc9u1WdvdOmusTlVjEtbyY3rvMrmDF9LZarXshoVoByWuhnPzmpdNqQ2R1JIhDkyg=
X-Received: by 2002:a05:6902:212:b0:da0:29e2:d29 with SMTP id
 j18-20020a056902021200b00da029e20d29mr2337159ybs.42.1700327495606; Sat, 18
 Nov 2023 09:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20231117212039.1210784-1-i@shantur.com>
 <20231117212039.1210784-5-i@shantur.com>
In-Reply-To: <20231117212039.1210784-5-i@shantur.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:09 -0700
Message-ID: <CAPnjgZ0kS9y24UtAs8qvCGzu98j-_k_t4X4-MdHePuXVFmRTow@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] bootflow: bootmeth_efi: don't free buffer
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, xypron.glpk@gmx.de
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

On Fri, 17 Nov 2023 at 14:22, Shantur Rathore <i@shantur.com> wrote:
>
> bootmeth_efi doesn't allocate any buffer to load efi in any case.
> enable static buffer flag for all cases.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
> ---
>  boot/bootmeth_efi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
