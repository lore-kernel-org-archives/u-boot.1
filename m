Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC328CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD88783B55;
	Tue, 11 Nov 2025 13:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3MaGwV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E4B83015; Tue, 11 Nov 2025 13:58:36 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3502983B55
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b5a8184144dso546658066b.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 04:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762865914; x=1763470714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v4d52rx9QfnT6y3SM6r7AaWMmeVwcE76O5MUFJZ0E28=;
 b=f3MaGwV1fj1Ynu1mHYwAgJS8fSr7Q4fkZwi8C6stzTDEWi80bxsO7muGCy5TjM9moS
 4b2WZBEXfZdZl5hrfbLGgyrN7tcLoKZbJp6JeFxq206D1cjqJ+22LszdPDEVByTon9CX
 4j9zB5INs7o3idQRWyU+37YT+BsVZWYoR4o1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762865914; x=1763470714;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4d52rx9QfnT6y3SM6r7AaWMmeVwcE76O5MUFJZ0E28=;
 b=ULz86aU9/ivHFe0TfDgBjheXmJIPqLV5sQEYORGK8ETFE/P+wbk4JNGYMYc0dPA3sX
 N5UCSaDOtB5CVZAgMvqRP3zHQvjeBCdvewj5wUNOJIHODWETqwBh7VChDq1unJ0otTwx
 /D69KhPtmR4/c6hVGxYl2+Enq8NTrEp7zCQOUs8eoAMq3EqHA0DYmp3TC55bZhXtC0YP
 3xdiHWbC4BTqRneSfav96z7qO76/25xzetYuDxpZiQS+wnZ214/2ozNHUCWOHOYWT3hP
 LOSoGimttn+Rst06D6aDhzWSy9Bso+ZlCTSPz4OjQ9aPexOvEzm7fCF08ucB75KI9B2F
 V+FA==
X-Gm-Message-State: AOJu0YxjqUKdV1MJ5ZCkNTX+7Vq9v4eCjnWcHr0iwJ0OQGCCG+d678At
 XeYSKr0awwQJ6IYsp4B0yPiOEwTWMTXJYXwxnwCXUuyyJYuAYk5BhBCEn4iAXwKphBXznjSGD1R
 SLaKHmQl552/+HZoB2uYnXeHvcWwh/v6JxUsBBbQePprSWDWrEB8=
X-Gm-Gg: ASbGncsylkQ7bGozs2nOOrGQof5Pe/4187BV36BhjYS5L5/brFuHKFRudhH4ALn79Bm
 I/L0kheMbOehbfbQDdO/S6wIi/Q2alokVigtA5atIfHWhQqz2XQgNa5Y4C7H1k1+5npsQrKR9wV
 5qeMisV6QDVnJcS7lk4S2mZo8SxAR5bv1Me2r/nmM5fyQW2fpFNWbVUf8DPB5ZIhw79L8F1fGti
 AAJ0DO7r7mrs+bskT0rHzRROvhhP95GA2Il/akhFwBoWrzltlkXsVkV21Xr0FU6dOyOjUueucjE
 REus
X-Google-Smtp-Source: AGHT+IFZER7AxKm7qPC7akawALoCP9QPJ2ySXqyUL568QTrvFGqBBziw69sr7C/uDafewhYHGY15jE85q0WXbZx4pGQ=
X-Received: by 2002:a17:907:3e10:b0:b73:2299:b891 with SMTP id
 a640c23a62f3a-b732299b912mr204602566b.8.1762865913608; Tue, 11 Nov 2025
 04:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20251110154231.2629710-1-trini@konsulko.com>
In-Reply-To: <20251110154231.2629710-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Nov 2025 05:58:22 -0700
X-Gm-Features: AWmQ_bm595rPRVPhUuCjjfrgnRZnPwxUwRKPWQ21PYg_o03o1wj5RQfwXKWkSHk
Message-ID: <CAFLszTjQmOR=5rUara7mAhccL6_epEYa76Ca6Rm-1T2qJSsuxw@mail.gmail.com>
Subject: Re: [PATCH] Gitlab: Add a "sage-lab" stage to access a board farm
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

Hi Tom,

On Mon, 10 Nov 2025 at 08:42, Tom Rini <trini@konsulko.com> wrote:
>
> This is the Gitlab side of adding support for the board lab connected to
> the "konsulko-sage" runner. On the software side, this lab uses only
> upstream labgrid. On the hardware side, each device under test is
> connected to its own exporter (typically a Raspberry Pi 4) that must be
> turned on (and cleanly turned off) as part of a given test cycle.
>
> Add support for testing on a SolidRun Hummingboard 2 (imx6), Raspberry
> Pi 3 and Raspberry Pi 4. In all cases, we enable additional options to
> run more tests on the board. As we have some networking tests, we test
> both the legacy network stack and lwIP. In the case of Pi platforms, we
> test all of 32bit configuration, plain configuration and rpi_arm64, and
> again with and without lwIP.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Note that for the Pi platforms we enable/disable CMD_BOOTEFI_SELFTEST
> based on overall binary size. I've created
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/issues/2
> to track addressing that issue.
> ---
>  .gitlab-ci-sage-lab.yml | 182 ++++++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml          |   5 ++
>  2 files changed, 187 insertions(+)
>  create mode 100644 .gitlab-ci-sage-lab.yml

Would it be possible to add some docs about this? Does the exporting
rpi do a full system boot and then run some scripts to load things
onto the board, then shut down?

Regards,
Simon
