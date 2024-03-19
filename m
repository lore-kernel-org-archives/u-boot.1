Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD2AC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C2A87F16;
	Tue, 19 Mar 2024 14:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b73wbx6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8147F88018; Tue, 19 Mar 2024 14:02:12 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED3C87EF4
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e7224cb3f2so1545412b3a.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710853328; x=1711458128; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNqPLKH57Ai3tx+OQUG+RQ2iZn9A+aQooM7WPyvSyS8=;
 b=b73wbx6xAU/45V3HYWXhU4YuT/MjuINiODB9wgqqAnMPHUjYWQHQIRKMSLnzfQmWsR
 IcUDS+rIX+fIBfsMhQrSr2yOV8uH/sG8TWVnrzSJKFdDKzmzoQmONVsP+nMQhcuDpPKg
 aqvD8tlCe8k1qe3RiwStlC7doHY3c2t7Ytg9bCd3tBOm13VLao9wIJo1ivAqrv9iIuCw
 6/qyguzHTgs8HmD8E43wg3j88BxRUkGRp8ztvZgHH805k3o5HKYuctat7zwqnhGF/cqx
 EJemm0qm8PYGoNOBLSREZTZJrElzHlf7Z2h+xn3emV9Gw9GAyB/oTL6eFFzY64C0Fp4P
 dxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853328; x=1711458128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNqPLKH57Ai3tx+OQUG+RQ2iZn9A+aQooM7WPyvSyS8=;
 b=R2hoiYxBjqmsefnww+f+71Grtv8kKeu7lS8DvkruDX+sAFUyuip2OAAVL3A4FwVZs2
 2mZdl04yVszvykU8HOV1AVeFkBe6JoGJT6hmWXxWsUSF7AdZx5cYgBIqN/JDqW6FKmQg
 Voe/B6RGO0TaSI4cEkMkS448zUfAky8044jyE2JKG64KsgEF2I0oZe2fHN/QzxKUKQm4
 8cYT62dXZQ6vrEvX5iCdv//YqlNZyklyjTkAWphQqF6pHIGnpI/uUv53McwPFNcxM7ma
 Hrl7RFlKkM2hrfG/6pe6kGE1eTpjdWSNNV1SuFqLt8uaxm5iyUZtUxjYEtWK0XTYuUz9
 aIbw==
X-Gm-Message-State: AOJu0Yz2C55oA3cWx1BrI/9+lb7+8EwDvvMI7DZG7SCx0LMtTxxOBVsV
 7DWsG8nd9bbeZPOW/+KZ7rYyJYNp7VgnhXTD8j7pGCMq94HdnbKiIUwWKJ0MFWNcpvLcmg9Tkw1
 J8qPy4a51COgWWzW4/mnTNzNiOFM=
X-Google-Smtp-Source: AGHT+IHjmSmag420LyhGTmQ/yFjPc6SkKDiTXFpsaGRgVFhuuANhPky5PJOKNyzHKo8pI+Xhmp6o52Y3UcPP9wtzl6c=
X-Received: by 2002:a17:902:e5d0:b0:1e0:10c1:628c with SMTP id
 u16-20020a170902e5d000b001e010c1628cmr3526787plf.12.1710853327013; Tue, 19
 Mar 2024 06:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 19 Mar 2024 08:01:55 -0500
Message-ID: <CAHCN7xJi0K-fXjR2SVU7MX7hbZs618ciCjBCjSBqtNoNkTNSoQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add missing OF_UPSTREAM Makefile for 32bit ARM
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 18, 2024 at 10:03=E2=80=AFAM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Copy dts/upstream/src/arm64/Makefile into dts/upstream/src/arm/Makefile
> and create a commit. This makes 32bit ARM buildable with OF_UPSTREAM .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Tested-by: Adam Ford <aford173@gmail.com> #am3517-evm

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  dts/upstream/src/arm/Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 dts/upstream/src/arm/Makefile
>
> diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefil=
e
> new file mode 100644
> index 00000000000..9a8f6aa3584
> --- /dev/null
> +++ b/dts/upstream/src/arm/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets +=3D $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS +=3D -a 0x8
> +
> +PHONY +=3D dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files :=3D */*.dtb */*.dtbo
> --
> 2.43.0
>
