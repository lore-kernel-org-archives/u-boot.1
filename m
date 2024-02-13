Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21C1C48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 08:28:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE68D87D1F;
	Tue, 13 Feb 2024 09:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zMwjg44w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB6087D38; Tue, 13 Feb 2024 09:28:27 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33C9D87CDC
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 09:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so3386784f8f.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 00:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707812902; x=1708417702;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncFcEWll8pMU1+aQ5DkZUqDqWRE78XCIGIqwVGyRvqM=;
 b=zMwjg44wPWmX94tUPXss50/VtsNXyX552U3o3fhOsDIh+IIa+zjz2ex1ISXs3jLLTk
 BD1z9Ez2CwChecEcOwnbpEGAVFFlhrhoea4RDG+bWjCCt1cY5o8wo5zTMC0qkjOfXkfa
 HCmP5ktAdBTt4x69RLS6vnSoNswU8Yram9nzMiwiN3NVCXG7FVqvVlqzd3TUjhFfi2MN
 JRZwNa8Q4vr/IE9nMNkn0whSsOdZCSBid8807QgQDXRtormQk0yvBgoJLLIWL0p1lkay
 1DsjfWZDhfF8huiErwHu3RuMSGesXZ6eUeWLlZPM39YLc5LF6LTEPghh3Z4TRpQjWqpZ
 Em9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707812902; x=1708417702;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncFcEWll8pMU1+aQ5DkZUqDqWRE78XCIGIqwVGyRvqM=;
 b=KxBDYWxvIjcy5c4D94Z7ylSMs9jS8FdOdJJ8xXF9y0aWrk2sOhIy2e1K4m5tgKrcQt
 cgqacHa5qrpxL/FC64B32GVnkuc7/orsrYWuetndo6Ts+91iDZZ9xfxTQpEzoOEswGp6
 QKNIBNUkzK6HX9tjkUZdAeRrkck0+EIz1ed8FzZOP3/GP+PuP4v9a+kt18LcGg3urcsO
 k0WO4kaaHiUG0QgXxH/GRDElXDD5ozTxSooyNshwE557QZnMdlqkoUgmhTt3RVAeS/ye
 UZPQRqQyNq1cYQhcB/s2HyCQ47wKH1lMf+6NGXOGorf681iBtGcgMuNorXzpDQID1NsP
 d13Q==
X-Gm-Message-State: AOJu0YxQ3sZUWO8rAHP6rfgQ38Xsd3Dxi2WkVKH6JnMjbOQq5fI9wnmo
 j6h8BLSBSBEHPFfZmt7HXSVM/rPuX917ftvBeKuf4pWHflii3DCyyUzK1O148Ls=
X-Google-Smtp-Source: AGHT+IHLQh4UykOAF2+b3v8mUXVH3tCcCFIB9lnx9mTuZ6odkgmMsSJ03I5AFsv2+6nMCZzxnTvkxg==
X-Received: by 2002:adf:fd10:0:b0:33b:4f10:f2b8 with SMTP id
 e16-20020adffd10000000b0033b4f10f2b8mr5351167wrr.43.1707812902552; 
 Tue, 13 Feb 2024 00:28:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUWs0H4Sos15pJwJ5YU250aVxSIAHMvXM6pA5TQYUFGpGfd/YAmgDX/by3W1C9TyKiUioFCWG2cDsLU2Dr5jEgYUxP+DlJcIWxI33sEIwI6yoUjAV/uWG+gNS6AlP+uSKrvTi3OTwApIYaOSW3rI7VPEdpTflqbdKTLPy50ZK0LZwaZ7ctAGKotJkZqbEzbCAaSfQ5W9Dwoh1gNpMJbajTkozb/MZnY9YcCy9eiws1VRAUhsU50bPGiJFle6sMc/oQbG1AHid5GPNYXx7DOQy4//Oh9abYeM/O9G12BtIn+8XeZSZ4EkumjrphAWwzuAL6HYefPwYGg+WKv+Ja2bJU7cXZgFHTizw==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 i14-20020a5d558e000000b0033929310ae4sm8884836wrv.73.2024.02.13.00.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 00:28:22 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [RESEND PATCH v1] MAINTAINERS: add custodian tree info for AVB/AB
In-Reply-To: <20240213073638.1125429-1-igor.opaniuk@foundries.io>
References: <20240213073638.1125429-1-igor.opaniuk@foundries.io>
Date: Tue, 13 Feb 2024 09:28:21 +0100
Message-ID: <878r3og44a.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Igor,

Thank you for the patch.

On mar., f=C3=A9vr. 13, 2024 at 08:36, Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Add information about a custodian tree [1] for AVB/AB, which is
> maintained by Mattijs Korpershoek.
>
> [1] https://source.denx.de/u-boot/custodians/u-boot-dfu
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46ba17647f3..32f3ee30710 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -62,6 +62,7 @@ M:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  R:	Sam Protsenko <semen.protsenko@linaro.org>
>  S:	Maintained
> +T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
>  F:	boot/android_ab.c
>  F:	cmd/ab_select.c
>  F:	doc/android/ab.rst
> @@ -72,6 +73,7 @@ ANDROID AVB
>  M:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  S:	Maintained
> +T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
>  F:	cmd/avb.c
>  F:	common/avb_verify.c
>  F:	doc/android/avb2.rst
> --=20
> 2.34.1
