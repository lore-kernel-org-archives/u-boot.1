Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C55CE9410D
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 03:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A0F83FFF;
	Wed, 31 Dec 2025 04:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="bqiYWXmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B3D84006; Wed, 31 Dec 2025 04:49:23 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F6A83FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso12360037b3a.2
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 19:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1767152958; x=1767757758; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wX9c7Etxkax1sX207H2c1h0k6th35OY+Dzf1xto0HyM=;
 b=bqiYWXmW8cWKQEPNOp9ilKX8BVZpRcp1NPSbAArQBQTMnefwmVvQm7x3wObWaLV4dN
 1WCgIlMpf1qms21BceI9WEbAp+veokNOms9wBw/7d2Gl15Bhga9ZRygzgAnT+rHpWzWK
 4LWvwsfgTfSxp1jbqGLxuDLPlA8Co+mx9l+KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767152958; x=1767757758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wX9c7Etxkax1sX207H2c1h0k6th35OY+Dzf1xto0HyM=;
 b=wYek/7htjqqbA/+ipVMd8MTHrgua3RjuugD8lxCbsZLvUzw0frpko5sbQzCgzhPq3c
 sU+a4N0N05B/o8uSXg8stIoJ2w9/KPiRJCE6eB+OX++GH2B7iPjiOV31rngiLididyOD
 Ifqcy20BBrXJU+vjsUpMQuT3yChjBBlMyGI77BXqO6S7f3Y7NzRfpXtvgmcMSW3EYDov
 Wtr+yCeze0WprGtSXaPSycqcewMqYYQtZCPTbHgcq26GuB5Rd5jZFi4OQZtgiNqMgpBi
 dVoQ/rFHhAnRmSP3Zc4Cx+tnMWm575iIdRGa1u0Id6dSjGc9HyMm2z0m/EkwHBzy8t9m
 7Mcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6kix6Vv9TAFu+zOkDKbhjBFFz1szdEBJH1idSkIUHl03MldWECozP+bEr6yC0C8xZdbXdJOU=@lists.denx.de
X-Gm-Message-State: AOJu0YxieW9RzFRMiM0fcKBM3QxFW93nH2gmP9R2lR5E4zgLhMJWg5Fm
 yOPvPhw/WaXB8cKClcir53e3ecQgq6x7WwcFw8aQp7zU7DR4HI9KQUiQ1cBpyPFaRdTMv+FRXbI
 2I6aCv9YsTLYULIgIwqEQqVYfrHmUTDCkKf+7LEW1cy9eHqTlvsE2FNOMIg==
X-Gm-Gg: AY/fxX64VibD7WLd3M62twgfCIRsbpyXlnvH4tzERj68zlbkzaJ+35sbYNho0TSX5vu
 xn7Pd7YLpr7ftkBc2vQJYjRYCZWtH9Zt9xNGW4tCfm4rZuqct1RHXcSCa7wLTP0Dkl6STggdCNc
 rBmTVrA/Is2WWzve/s66avq7J/TN+4zmn93LUMTUPpVAHnNBQUi/jD5p3TOtG9oK9p4XfEFb/EX
 t99MALVGQynAf+OeqfYL6kK6i+GHjSgCSdeM8sdxgYEs1WyBKoXl+/C2+vx2ROVauWKK6mS
X-Google-Smtp-Source: AGHT+IHBxIrBMO3U7fjKX1mCgHNcXE3t/Vv7uuxnIJpZ4z1zyV//Fza1OdJwTht9nzsrNsYVaO3CK27BM4acbjzGB+g=
X-Received: by 2002:a05:6a20:7489:b0:366:1953:1d30 with SMTP id
 adf61e73a8af0-376a81e2ab5mr30232660637.5.1767152958490; Tue, 30 Dec 2025
 19:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-3-visitorckw@gmail.com>
In-Reply-To: <20251230160112.3045527-3-visitorckw@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 31 Dec 2025 12:49:07 +0900
X-Gm-Features: AQt7F2prd7oWO4JcwILFRCBcsxbFw7no9hZA_36cHQrUBol_Z7PJmogioA6gseg
Message-ID: <CAFr9PX=x0bRe9FL=srwGt1YEdyF3KGDUzz4D+uKQYC1-hoP1GA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] timer: Add Goldfish timer driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Wed, 31 Dec 2025 at 01:01, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
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

>The link provided by Daniel [1] returned a 404 error.
>Since the implementation is straightforward, I wrote this driver from
>scratch.
>[1]: https://github.com/fifteenhex/u-boot/blob/mc68000/drivers/rtc/goldfish_timer.c

Oops, I moved it and force pushed. Sorry about that.

Works as expected.

Tested-by: Daniel Palmer <daniel@0x0f.com>
