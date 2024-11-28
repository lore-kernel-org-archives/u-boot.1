Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0ACD69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420988987A;
	Thu, 28 Nov 2024 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jf0uqw9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0638B89877; Thu, 28 Nov 2024 16:45:47 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA030893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:45:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53de8ecb39bso1170021e87.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808744; x=1733413544; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DIOQrNcEg04w3e8Hcu07TGTlG7fuxdOEhy42P5t2WzQ=;
 b=Jf0uqw9awebgqPBNwIuBjIDZWp3iUY+vdDX4LfBT7OJGAyJdAuEbAL7I22C1gmyD9G
 /2wyBiECQVXTRhqub0Ib6HNAX6tjP7mxBQwgO2wN+m2Z1xQig8QtWR/kYwMLk21Vi+Y/
 WNgrSjAO5bDoirS0CpphcRQAS87HYVcSwGmSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808744; x=1733413544;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DIOQrNcEg04w3e8Hcu07TGTlG7fuxdOEhy42P5t2WzQ=;
 b=hj7QJfbYZD0HueL352vnWiyCl6nkfV4QRW/YB0CGgQOiSL+V8vHF9jvCEoKmR3GFeS
 vosgnk++lxshLNSMfAqRDdzJyFYhKuegLLKGESbRCwio7P6DPU8vCyed+ZRMsOOgYB0W
 KcoGStppoxgxYfhhhkn+FByi22s7JxAaycJGfOn+c0Xvhx3hkBE0ERqXNNd2B2djXF/G
 9ACc0Gn89AA0LHRjuB/BG27c01X+RYksWrPKeAxxdgHhvIzn5Muc+KnwGPzIAmX6Vzdq
 sou2QwdH0buexVVKOZz190JYemIYIDfapEhpmWGSnpAwob1DKE2cshTFxIIdDBuw4SPc
 4tZw==
X-Gm-Message-State: AOJu0YyQaEl6fVEo+q2dP8cJz93a5toE4BQ9HUk8Py1E9mleWO0Fxvwp
 XiLPrMq5eS326SAgYtt0ua+XHmIsU71glxO0ktAYJ40FEVmP/uDVs6suTQ3myhGlSJiDhI8ytmO
 SQe192Kr5WH9omtd/k7lxbldThnsb1ORH5lu2UXXmHJRl+ts=
X-Gm-Gg: ASbGncuGvCfmPlWZlLK7PnTxk8tRTGPjpZFX4wL4uuMJ9U15jypMHN4oyXYTWBDfNZF
 3iHTmxvdmkN16HnqZ5cf/TDxjtscZyIU=
X-Google-Smtp-Source: AGHT+IGFGqV5vn/mfu5yUhsWL8lcmkHs7LD0Lx9DoaN9RPHVmmMtNxoYb8dZwGno0GhjqfhDNPonN0IBvyGRvpK2J28=
X-Received: by 2002:a05:6512:3e1f:b0:53d:d65e:772a with SMTP id
 2adb3069b0e04-53df0111ec3mr4403732e87.47.1732808744244; Thu, 28 Nov 2024
 07:45:44 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-4-trini@konsulko.com>
In-Reply-To: <20241127172247.1488685-4-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:45:31 -0700
Message-ID: <CAFLszTgVoq54zfjY6ahxNa9JrTHga1fo_PQhCbn5MJPvoY3sDg@mail.gmail.com>
Subject: Re: [v6 03/12] docker: Add kernel.org x86_64 toolchain
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 27 Nov 2024 at 10:22, Tom Rini <trini@konsulko.com> wrote:
>
> Add in the x86_64 toolchain, but do not enforce using it for sandbox.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v6:
> - New patch
> ---
>  tools/docker/Dockerfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
