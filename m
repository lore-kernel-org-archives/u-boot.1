Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F076C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 684B1882FE;
	Wed, 12 Jun 2024 22:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z+BdwtVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF938859C; Wed, 12 Jun 2024 22:24:32 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FF4882FE
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6afc61f9a2eso3088976d6.0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223869; x=1718828669; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UwvRR9/LyevGc/mNV49/TN7Zg0iQ/Z4oeDIXW99fE9U=;
 b=Z+BdwtVFBN6sWoKdk/Z0COgg+4JuWRflYtQYRO380WF1DmsLw0gaNiBZWNq0BR3VWh
 Xl6N++SKtOusX3p7nod+0CDFo4Y2Jfq5wptlYWqpjsIhhr4EKArCirpADciBcyNYoB3C
 pimCzLNnFZ8fI3yULLtlSctQehyXI+I0B9USU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223869; x=1718828669;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UwvRR9/LyevGc/mNV49/TN7Zg0iQ/Z4oeDIXW99fE9U=;
 b=qFen2HsedMZfDUCkh1uVJA6id8GNpZuid2rMB1zDtu6S7sQb0yWL4L8j9F9qWxEhwf
 dDObrGBuI8TZ8iW9x9tN3v0YSOWx2746PmdLjR/5SfN8TUWNqxdjSZYrxC4bAUlq5mjo
 S1tMKkc2lDYEVpqkq0w350PuQ83LxLECxe1qlofSX++ucAxPJ6BhC1s5vPnuf/a1C4Qm
 q/N/kJ5d8eAj7EyN0Dxl2kokkFU4rLA/YUrGE15LGJal+vaM8QYhujoAh86T7icIIVfq
 4X3DqYq1HUZdYmayO3UGMUqOtCX44Ssx8JO4vL0O99LvbsRXDjx8dyapAc4+LYBjtNSA
 Nn5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXhtnFXV4lrBieXtGETIKTDboRKnPGq4OU5UFNH357fKqyUPmCqbjoRF+Et4aI0g8FwKZXYyfmw1nML3ORLzwEMc6nTQ==
X-Gm-Message-State: AOJu0YwYUh7xgIKeq/8iByliFhjJ2mAvGYmIt+3Ak5vPbt9OUYaEhBIt
 487dWvo8RMzF7XWBFXI1mEIq9Yh1NHOEMwlyCo1d9uKUMq+nYvGnS/ma4besWENCKhjrpe0JEAI
 LZeilXenlzwKdu+M0zGYSM8hU8S0Zrt6SkZ6XVcpUHzbfhd1jtg==
X-Google-Smtp-Source: AGHT+IGa4x1kF4aMoyl6Xjfvy7rZjkOo03crxKYCwGheDRdOd+7ISRCZ3bA86a2x1M5XHPSjnAQ8u1GmEYCOkBuC5TQ=
X-Received: by 2002:a0c:e18c:0:b0:6b2:a507:9fe5 with SMTP id
 6a1803df08f44-6b2a507a12dmr1452056d6.2.1718223869548; Wed, 12 Jun 2024
 13:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240612-bootflow-efi-crash-v1-0-27b71b0ff08a@cherry.de>
 <20240612-bootflow-efi-crash-v1-1-27b71b0ff08a@cherry.de>
In-Reply-To: <20240612-bootflow-efi-crash-v1-1-27b71b0ff08a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:18 -0600
Message-ID: <CAFLszTiJBetLZqASO_EJqkC_J5N7GND0wpgL8zr7Q82cTsA65w@mail.gmail.com>
Subject: Re: [PATCH 1/4] cmd: fix typo in CMD_BOOTMETH help text
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
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

On Wed, 12 Jun 2024 at 08:58, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> It's bootmeths and not bootmethds.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  cmd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
