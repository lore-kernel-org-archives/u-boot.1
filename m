Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3A8CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2EFB86E5D;
	Thu, 12 Oct 2023 05:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D6BZz+3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CB8D86E29; Thu, 12 Oct 2023 05:44:33 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC0186E54
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7d532da4bso6853177b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082260; x=1697687060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=57fsVnEC7PeNblN7yMSq4QpP6ti1/8yG5SU/flYLusY=;
 b=D6BZz+3cybrz793sIgFVtfAwwW6xWikK0D5Gu6IHmOIaVL/rxdo8qPncY8aN79UDZC
 qmG3c2tgZ9uJn/N8LKB14H63gcfHDP1SeZ5vIjmr0gqPlwEamxatnp8jO9Yzu9Qz+A5A
 qgMRe1wowKG0z9SAwIkgO9avWZgWPNzAvRjjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082260; x=1697687060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57fsVnEC7PeNblN7yMSq4QpP6ti1/8yG5SU/flYLusY=;
 b=B/BLbod91MMv4HEGRx5QuWfC+mYmbGGbObi7DkkXNoBlanOkGGU/HuVf7CHepjcFGU
 FGdNe1eDRWuxWBYXgI+HEvk7DQR5Og/nuXp9/5SHugg1xOHBugjzXuOIglJTC53Ovruw
 KbBLEi6csTJdIq7E8nHK3i5iOLrvtaq+PoZ573EvdDw3e0TVhWmTWlksiecxKp7UdV9X
 yucoQWxQvAIqkMBijDUHIamqqwmFeEjdsQll/URnf+bo6WQWWZ797yeqQK+gIl1+jk6N
 b9hY+h33cG3DXGxQ73OWUdB3OWCo6ENDHZ/462dRR65cJM2njGS8/2E8HovmxSSNMKih
 Y0+Q==
X-Gm-Message-State: AOJu0YzWHkryH+OWHQ3vB8zieiDFYfUq8cCXeU+sONjEeE5Q6BeZVWAK
 s7q1azXDmW0DLhzev861hE5IPtP0DSG77EHJfvfGBg==
X-Google-Smtp-Source: AGHT+IEsr9oj4Fuy4ugD1qiCRGR73/GP/1THoOWCnNfLTY4Yu4GpH2XzWIJ0bFtQ8kFNE1FmMHfhT2thinn6uTnp6hs=
X-Received: by 2002:a0d:c104:0:b0:571:11ea:b2dd with SMTP id
 c4-20020a0dc104000000b0057111eab2ddmr23593231ywd.32.1697082259829; Wed, 11
 Oct 2023 20:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-3-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-3-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:33 -0700
Message-ID: <CAPnjgZ2ndYDp-gRC+_fHMFmwbMchD1jHLvJ0YGSVNzA6uHhLqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] ufs: Add a line feed to the end of some dev_xxx()
 messages
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> Add a line feed to improve readability of some dev_xxx() messages.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  drivers/ufs/ufs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
