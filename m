Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B3BCD0425
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A39483E0E;
	Tue,  6 Jan 2026 00:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+KEJNEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D2D83E62; Tue,  6 Jan 2026 00:30:51 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D0E283E21
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so92348766b.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655849; x=1768260649; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aT4cyC0+/zsCCu0DV9uExKEW1lsfx0ZlzUdfRu+p+KM=;
 b=l+KEJNEVCFTZ7L/8LFF26SfgvpqK6VPq27KgTn5u5m5Q7z6TNYd3PYPTzePnc49Sa/
 wgvPj2J25mOaY3eKsa4g/Hb4HzD4Ia6vkx+BK8W3sNQnxrs5cSapM85zOIm/SE26AoNI
 gdgpeuiyAbTR1R7SFpiErsu0ZOkgwxZc8dDAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655849; x=1768260649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aT4cyC0+/zsCCu0DV9uExKEW1lsfx0ZlzUdfRu+p+KM=;
 b=gMMvCn0+Faat/SkXS8FOPdUHy9saG9c98Vcsc18+GvFrroB4k3SfaKJ3Vrg7yJ8eLS
 rlUnVCez+wTHwMZ3dx0oX8aGNmuUg9BAUmI+sYU5tiqagklVqAOAZ4yD7Ss/jqNKclte
 0kLS4TwTnBPWw+i7YDR09q7tE7mATPUmS4gepvpNqlKwkkN/EmAK2r6ZwcrAs169p6t2
 Mm1C8iFZ2trhWMN1F8Hj8kfNqlSzC8Jbh05xH9aQmhmPV0s43wtyatp7BLas/NnhNAGk
 JHskLjtIA1k5ZZyv4oPem8Vz9ETj5GOBEVzWjWMiWqZ7eIXJLxqOKrvTpVf1w0hyCl3w
 iwlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRbM9PeJapJx9X7PaDXMTGCynd88jAshU3JiJPDJCWV4facG8f3ZravWURAxqh3DzaOAZTFU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUitzBEzJLcCiLQ0HaxpTv9F/UiS84T/3NFXSwvA/8Zbt7RT/H
 /O1A87uNFBpVOSGeVDNqVZ+R3XOjDiVS9mFknR1Fg6HuqqsMd5cQUE9m23xNwO6D78kveBfWNTk
 1iMirYYuuN0w78HpXmymb41PxjB/ZsXZRLJ6LoYCTqSuKQ723DcQ=
X-Gm-Gg: AY/fxX51C2A8xUaKHVz3F42rE5tZoXfTt9cK3w3YSr4/xN6RAI2WdCYypkVIKDTd8qH
 FvXUMhvLL7uzokdew/MHYJJafpwmza6KH2IGZ3oS2oZeZn81+9yQRlc+Ql74j13/BYCDMd9rIFQ
 7+mTME9MajMh4PiAI1txuYGIHRUBpE9r357sRbhHBJy42F5kyAO4lbkbiEJf9bxx8zJ6ndI4TX9
 aBwFx9GyJHA68njT31b/w1SqM4YxDnDOP2ht423SWOccx43pivhGz/JziBKkijx7TXiGw==
X-Google-Smtp-Source: AGHT+IHt4nlL/HXarjrfyWxiLUDA4SJqb2H7SppWnLJaYf6pfT4/tPDxjHhQe4gar1CPXx0nN++Fn/TeWlIqCjtiNAk=
X-Received: by 2002:a17:907:1c88:b0:b73:7ac4:a5f with SMTP id
 a640c23a62f3a-b8426a84deemr133594166b.21.1767655848966; Mon, 05 Jan 2026
 15:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-3-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-3-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:25 -0700
X-Gm-Features: AQt7F2r2D7puRrSCjCXNrWpgo1dHIZhUOKolSPWL71G-s7GtNIaH77MgaxOsGjg
Message-ID: <CAFLszTjBFGeWS8QoVRGWq44LMjUgDpE7B3ssFLY0sZHZrLfG5Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] timer: Add Goldfish timer driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Add support for the Goldfish timer driver. This driver utilizes the
> Goldfish RTC hardware to provide a nanosecond-resolution timer. This
> virtual device is commonly found in QEMU virtual machines (such as the
> m68k virt machine) and Android emulators.
>
> The driver implements the standard U-Boot timer UCLASS interface,
> exposing a 64-bit monotonically increasing counter with a 1GHz clock
> rate derived from the RTC registers.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@0x0f.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
>
>  MAINTAINERS                    |  6 +++
>  drivers/timer/Kconfig          |  8 ++++
>  drivers/timer/Makefile         |  1 +
>  drivers/timer/goldfish_timer.c | 81 ++++++++++++++++++++++++++++++++++
>  include/goldfish_timer.h       | 13 ++++++
>  5 files changed, 109 insertions(+)
>  create mode 100644 drivers/timer/goldfish_timer.c
>  create mode 100644 include/goldfish_timer.h

Reviewed-by: Simon Glass <simon.glass@canonical.com>

You can also implement timer_get_boot_us() if you want to use bootstage.
