Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF22C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2DE9878D1;
	Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gSYCXOn7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA63187896; Wed, 13 Dec 2023 21:39:24 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8482787882
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a1fae88e66eso407326166b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499961; x=1703104761; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5JRGtozDDE8KPz7ThxmhJI/VF5ifkSFTGI4r1IgCdb8=;
 b=gSYCXOn7NeDYZQ4EOaT+lU95tlmEmWDWxOp28jFMNiFbQvXltiDfnnMe5GtgPa1P45
 VC579kcyYcIxF8xbKb8Uz+I3KSeMH5h2An6/555nMiKoPggElyp4vh9wgV0zCKjMakN2
 7TftJ/lDYHLp/Vczifpe6DmG3ruiTai9cgYu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499961; x=1703104761;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5JRGtozDDE8KPz7ThxmhJI/VF5ifkSFTGI4r1IgCdb8=;
 b=ooDtlmEDCzlRNdN7e/aVa1ddMHZZDwQrbXynxtV0xy8pg3aVlyTbTN2tN40mEVx0nL
 3VKTy4YWuykHokR4kmeW3SnvZqXRhnD3REXrE7MU+9KleWecyVdrucj6w2iZNaIAQnI+
 ojBpVvwYDlOIam14kOOHY6ZN+QRJXWBPjFH6gfiVgpVZ7BEz+kgEcXSrQaXz9IRiVmax
 54WE7n+SJ9oBKdufYA+QRjtPy2HP4Ivc/RZC5VklJ+fiFI+w/dmLUW/gvd8uh+JD/aqf
 JbvW2r0Fh/IpzIMJCHSQcrneVJ04cOT9f7qdsoH21JH10e3qdXjHfECsPOvgUjTDUmpy
 kfSQ==
X-Gm-Message-State: AOJu0YxUNnXVf4nJZxcXXF4kLIzuFrInuEdE8cxLZBrmzgFrd+Ayi7UE
 VUHP/6ObCjd2eHJJFFyF3rzn2DonhCFJhsDyDJKWeQ==
X-Google-Smtp-Source: AGHT+IEHZ8xVEi6WnZJszcx6RCa9FBEZpoHbewiT2aCkaNwc5jKnxg2Wzhl9GUq7wNefGEOjjjaIgj5UatH3IEQEjig=
X-Received: by 2002:a17:907:7f11:b0:a1d:8d09:c8f8 with SMTP id
 qf17-20020a1709077f1100b00a1d8d09c8f8mr5549830ejc.74.1702499960897; Wed, 13
 Dec 2023 12:39:20 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:19 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0SDY7UKeUyt+spaou3wJ=Wr3+B8BXSM+0QX05UjURZ1Q@mail.gmail.com>
References: <CAPnjgZ0SDY7UKeUyt+spaou3wJ=Wr3+B8BXSM+0QX05UjURZ1Q@mail.gmail.com>
 <20231112235356.12260-1-heinrich.schuchardt@canonical.com>
Date: Wed, 13 Dec 2023 12:39:19 -0800
X-Google-Sender-Auth: WhklQhXvg_hb0f2gzKCOOAEjwhY
Message-ID: <CAPnjgZ2SOCoLufKOJ=z0qP7hxFV-pp+Piz0fJPZ9-jLZ+gue2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] acpi: cannot have RSDT above 4 GiB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Sun, 12 Nov 2023 at 16:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The field RsdtAddress has only 32 bit. The RSDT table cannot be located
> beyond 4 GiB.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Avoid superfluous 0 assignment. RSDP is already zeroed out.
>         Use constants form linux/sizes.h
> ---
>  lib/acpi/base.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!
