Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE67C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2975A87AAF;
	Mon,  8 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9Hqr4pp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8CE87A99; Mon,  8 Jan 2024 01:16:32 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B672387A84
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-680a06cc763so14528066d6.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672983; x=1705277783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jKPzaEf4pBTVQqWTT+1+LsFwH49Hii3nn5wwG6B9NUs=;
 b=P9Hqr4ppFJlZUK7KdcQw8Q34Z8AGDNG7C1Gs1eKJ1YqBgmtgh4DBbQA0wvLXD2auiU
 0di+NLR8VpiZEjxlYn44KxyRgOsI27adC5W1LD5r0DvHgu8ty+hVYAoagJ5H2vYTiOyU
 LKBp3i9uWqXQH4Vr0qXDJx/HS5V/iMUP8hoWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672983; x=1705277783;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jKPzaEf4pBTVQqWTT+1+LsFwH49Hii3nn5wwG6B9NUs=;
 b=OZbMUU2X+EGcu534XuvNdGH3YZ+uwnm+Cb3b+KUPzjsvayPpyK9+/gf08wrwBClx8w
 QiLhm+igb98nQkUPyRUBv9oVgUnJqq3hI+Kg4gqz61rXcg4DkTRi1TpAR7QkNvA+t1+n
 nRGeUNpFhcJBLunvVKGrri4MrF0rgEOx3AWWhfnSX/p3woYpeyE0JaqvDkeaixCC9Jhs
 JOfB/5VU9v0O3zpwZ90SWesqvxDSAPeMgEyQ1yRkk7mHsbYZpXmd8e48FR3noNBVqsDR
 zM00zEDU++9tNapTF7PvtspyIveRy0A2hdYmWBOjFZQ6yJzI8+y/2QZQFi+kO+q0k2w/
 iajA==
X-Gm-Message-State: AOJu0YyOUmSwd1gXrXW9QAe7/ksIacXXE3bMHwX73YIqbDZveVZ/KBGw
 01YSR5clpwiEx+CQDemctlFqZoEMGLgy6Fgy4Zk6TqNwks8j
X-Google-Smtp-Source: AGHT+IEv/uqZdy/YhH8XOdfTI3oJfrfKifG6k9nt3zdp3dctJCMErqVXixXLyF1s9K5fL2ob6WJd9Z+yvpXchft1XUs=
X-Received: by 2002:a05:6214:2341:b0:67f:1503:3095 with SMTP id
 hu1-20020a056214234100b0067f15033095mr4160087qvb.12.1704672983589; Sun, 07
 Jan 2024 16:16:23 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:23 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJi5hvTZCO0LgSaT6qmOskRrwbxHGCSiHwxyybdfu5gxg@mail.gmail.com>
References: <CAC_iWjJi5hvTZCO0LgSaT6qmOskRrwbxHGCSiHwxyybdfu5gxg@mail.gmail.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-10-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:23 -0600
X-Google-Sender-Auth: 5wsLwm5AKEZqSXOvg8FSsAGe1CI
Message-ID: <CAFLszTgx-KxZghNyKoVpiTe7Ec0DWw+ZnXAiKFw7uzR293qFxQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] arm: enable support for QEMU firmware tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, 
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

On Tue, 19 Dec 2023 at 17:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enable the QEMU firmware interface if ACPI tables are to be supported on
> the QEMU platform.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v4:
>         no change
> v3:
>         no change
> v2:
>         new patch
> ---
>  board/emulation/qemu-arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
Applied to u-boot-dm/next, thanks!
