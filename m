Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84242D69119
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A896689D1C;
	Thu, 28 Nov 2024 16:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDzHLDPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A02989D0A; Thu, 28 Nov 2024 16:46:14 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40E88988F
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:46:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso796868a91.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808770; x=1733413570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fC9tT9sRjmnDfz4DD51qYRNBm+25QtB19Y5vqnPMUS0=;
 b=VDzHLDPHRrYu8NtPm2NqvrJAVDb4vv3J1M9b/Km3yQrw15JUHpPEwtDEoKpeR+wPyR
 cvuNSGJCWebzUHzjWh1ncivHSrzvqmzZrJ4pMpp4ZnHUGw/s8JmINkr/eDa6aIUMxZu3
 NlVZM8c+mD0HrE+aE/6CNY3g6IIStKjHC6a3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808770; x=1733413570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fC9tT9sRjmnDfz4DD51qYRNBm+25QtB19Y5vqnPMUS0=;
 b=iungME3BEBVjGGTcC07u6lzzAYECrE/PneQGETRT8Qy5XHvNb13i5gTDGVff/FGrK+
 OxIi300InXp8BYGsj5y6mOdwLpqyS+gVVmQ0eJkH7QT+Rs2bxyDaMMA3WCEVNyrmMss8
 j3KvEebqL+8Wmnj7HBXsaNV9YInBXctNUziTvWXGcCLCZ3fi2GJPLfC3/iMSpFim/mlQ
 Sa3xMCVhb3ZEWD6z4M+jE+5v9OAsMMDyWmZKmkqgOlzIspngZM+pIybBTnB5VeQHAvkJ
 yhqzrMYhzIT4BeXgImIHHpzp+7KYJJW0OEucp4HO/f+vE3j0UTeTT91jRqwa6jwPfcpb
 Etsw==
X-Gm-Message-State: AOJu0YwnTy6ljlSngxaMc7gsEj+/VxvWnm4oFIsuS1pNUVwNuAiz5bH2
 MNz8PjuUGTeoLLc62TQ2Y5W0xq8ael+6MrTQc5bBS3YOESTvSjtlM/90w7Dn4jF3xqLDEEXI7Fq
 37AVsoV2Ysi6pqDP6t/hyxaR617IruoTNLAyQSkBkze1y5wQ=
X-Gm-Gg: ASbGncvCmUpJlA0fMc9w4T7FuM2tjFmaKQ5ogQZJkWVD0LmNeKhV+lIdmYdiadB+8dk
 ov1X2xXSBotKT5b/ilOpdiM3JkBlnx0Y=
X-Google-Smtp-Source: AGHT+IHxgfN5u3sa83ItnJ/wRF7a/H9+0jpNbZ61rk4LDPCFCudfpDOaXp7UHmQm/a+RDZMK2jqK9X7qzc2H9KoZKUA=
X-Received: by 2002:a17:90b:1e46:b0:2ea:9f38:9934 with SMTP id
 98e67ed59e1d1-2ee08ed4425mr8473192a91.21.1732808770376; Thu, 28 Nov 2024
 07:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <20241127172247.1488685-6-trini@konsulko.com>
In-Reply-To: <20241127172247.1488685-6-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 08:45:40 -0700
Message-ID: <CAFLszTh23FucEvDvDQe6T3FV-aqJvm00Z+Sw+wnr+494qrj8BQ@mail.gmail.com>
Subject: Re: [v6 05/12] docker: Update to grub-2.12
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

On Wed, 27 Nov 2024 at 10:23, Tom Rini <trini@konsulko.com> wrote:
>
> The current release of grub is 2.12 and it will be good to pick this up
> now so that we can update other parts of our stack.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v6:
> - New patch
> ---
>  tools/docker/Dockerfile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
