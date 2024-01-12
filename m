Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E8C47258
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F614879E2;
	Fri, 12 Jan 2024 16:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="FnSEmkwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB451879E6; Fri, 12 Jan 2024 16:12:08 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B46B879A3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e766937ddso7546460e87.3
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1705072326; x=1705677126; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjoVQrp/kTZaNrjGLzKSCutbMVs/rWXFM+84wLDvIts=;
 b=FnSEmkwUNz86sY2+B5ga23jct6snkLjyfQRHkZQ5M7v8kpOUmQ9iqduad25HporkzS
 VXxaa2AtZ0/fq++lrYQzVO/ynhAyEAV/M2pUGTm7JLJO3Dcx2m7SaUoJk9tUkrkZLbsH
 u2eq+x8VWUXYWJ/wHHW/l0/ECBaTz7UOfzoLPFGgDOwakGxgK65AYfHX+T1yq8nZNLh3
 HPn2sz8HLSqvmlT/pRkB2z1zJagLaBH/gpHoc2jbW3JKtxO0/7hEWSKWwCSwF6X9H208
 Wj2xQXHMUudVPUycJUQsIziatne6/daDYSV7d3M3pbqosioJawseXgKGNQ4vCHvQ3ZZI
 FIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705072326; x=1705677126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjoVQrp/kTZaNrjGLzKSCutbMVs/rWXFM+84wLDvIts=;
 b=YMrzI4+eYY2jlhBP3R53Szgw+C9bhDio6JJARKFQl+U9Hs5wvCtMo3AJ1ne/fy7KKd
 2TwVYZHcfx1H7QnNIJUfApZeZJbl1NsxM8WZN/UqMWugll9SUnfh7Kqetzi93o3OrkhX
 JbvYoaghepuaVql+2zRT4045EIlbfdMhwsXx3Y0RAXop6wByKXvhwAuMCbYQqD+wtE4n
 oNLafNdsK/Vj2bk1C6zYnVwA/+kQ5nZnUlqWeCRdX+cEAKSLu/Z+EDajF8uvKHPJwFN4
 EAWN9YGiNiO3Yrj+VIhvgCxg8keRqipNH48r0ukHPd6Nx5FqwAn8y/c7WL/sU8T7pVqe
 pVXQ==
X-Gm-Message-State: AOJu0YyX+9ST2Nt6tFYr+oRM7VJVINcpFbE3UGKLJ9aGEN0rS24wso1K
 64B00a7XDjUooNteoeQ+a2g6IyN7SABY8fni94s23Y1lHjzESw==
X-Google-Smtp-Source: AGHT+IHdkX8nHlZAyu6ccZAgSYkok0rImhagRz7AG8vw3tMuhChh724vK9c9NhvULiBtTZNR+m9mQc7mOcPahvyERPs=
X-Received: by 2002:a19:3852:0:b0:50e:7e1a:6ef4 with SMTP id
 d18-20020a193852000000b0050e7e1a6ef4mr582141lfj.102.1705072325699; Fri, 12
 Jan 2024 07:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 12 Jan 2024 16:11:54 +0100
Message-ID: <CAL6CDMGKC8_kTsPXYa1CVPajb3Z1k=Ps7uEV_X3Q1Dj3K1kpTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add Mattijs for Android AB
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
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

On Fri, Jan 12, 2024 at 9:41=E2=80=AFAM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=3Digor.opaniuk@gmail.com
>
> I'm interested in helping with maintaining the android_ab
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
>
> Add myself as maintainer for Android AB.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fec063a242f..3c73d8c35c4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -59,6 +59,7 @@ F:    lib/acpi/
>
>  ANDROID AB
>  M:     Igor Opaniuk <igor.opaniuk@gmail.com>
> +M:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  R:     Sam Protsenko <semen.protsenko@linaro.org>
>  S:     Maintained
>  F:     boot/android_ab.c
>
> --
> 2.43.0
>

Acked-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
