Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F839C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C960A87AB1;
	Fri, 12 Jan 2024 14:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E6tHLEm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045F687A98; Fri, 12 Jan 2024 14:46:24 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F92587AC2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce9555d42eso4901708a12.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705067180; x=1705671980; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wt9gANHO2Flvg//KPgc+gp1VYhzVIegxb+uZl9qzeoY=;
 b=E6tHLEm/9tS1AjYs+OMf/iYsEqfCNBOeD8YPH46DlXO5Y/e46M2WCUPzrOYm+P7avF
 GhhAGllACAmSpYB5W0Q/YAX/Whkiec8nYyp+E1Mre8f4dAWT7ODYgx5pNiDbkBLFtVQS
 oT+CidzjvhAXLCvlOHMnz4MZnv9nGk0/Fx2Rk1AVojAtLjSSaWL4VV3L4GU6b786vcw8
 n5kr3Xgj7ttGfi5i81VbL7rRZD8oi4t3zcJUEQbvUvtKnlzveAChTvz7y/b8Snre6CuG
 P774kdBHyGi+xxS3s3H/8LfFMDx6mSmno7kB9P72+RuYNC7f1D8IJFxm6FY/r4wtHRNP
 PTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067180; x=1705671980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wt9gANHO2Flvg//KPgc+gp1VYhzVIegxb+uZl9qzeoY=;
 b=aVBnvcOlmc9uZuEd0B7iHaFHTx22UoiCceQ7upMN+FuyFs2/KxvIu2rrMFNhxPR8sH
 W8HJXgGGz5x2edK3p/o/tJOgFSAzvCmcVOX++SotxQktr2avj79fg2f42Tl/sykMvEI9
 fd8UVHaOqWU0ml3jHYGJf3O8CZ5sc1HUQrPCGmApp3bMW2L4MB9IoD6F2iraH+bpuM5F
 NPTRAm0n++PXvzavF4nMg+XKgGn1J+7VDVe6aPKByrm/va6sKvNkKWareKLsJ0Xaa2+s
 H/sl3eH36C2J6ryOpsTAWrf7L0dC0XceK89cwuEjnm0ClsQkDtNWmd2upnP/kGzj84WG
 QN2g==
X-Gm-Message-State: AOJu0Yy9XKzQlKVV8ywmRQoYb5SZ88rQkHQEhcNFMt+rAxmjXxON/+A9
 7XsILkXnMORW4u17xCWB+kp1XLCaxUsAPopyBEGxZ9QD5yDiBQ==
X-Google-Smtp-Source: AGHT+IHFSICLiBX9nWHG1FctCXEQyWsHP6c9kEXvyatM8Nn+MdxUUJQ5SpXTBbzk0ISaehhScHxk5t3rGfXbVVZ265k=
X-Received: by 2002:a05:6a20:394a:b0:19a:4e80:2152 with SMTP id
 r10-20020a056a20394a00b0019a4e802152mr1261237pzg.83.1705067179715; Fri, 12
 Jan 2024 05:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
In-Reply-To: <20240112-maintainers-ab-v1-1-f2a538eab18a@baylibre.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 12 Jan 2024 07:46:08 -0600
Message-ID: <CAPLW+4kbC27kv2r4riVUvT5XaCBhG+VREEAvD31Fzg5cN9tb9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add Mattijs for Android AB
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 u-boot@lists.denx.de
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

On Fri, Jan 12, 2024 at 2:40=E2=80=AFAM Mattijs Korpershoek
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

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

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
