Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3A5C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B87480805;
	Tue,  4 Mar 2025 16:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NpPlgklW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBF080805; Tue,  4 Mar 2025 16:49:26 +0100 (CET)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400C581253
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-abf3cf3d142so511994566b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741103304; x=1741708104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bM6HdsrlC9+gstv3YHBs7wmZyQihbd1OhDTQ17QOw1o=;
 b=NpPlgklWKjI+rc6gTdVGvXTn1S2tWIvitZJ8AVH4yW6umohYM7YMapA01c6e+Bj4Tb
 uO2FvIVHD0WkN0vOKpovBMI1VxqCfG7zf6+IOs+5mz7UBqXMNRRxk9Do7S/JuNU3Llx8
 y0m2EgmhCeQnD+K7ogQ4LNHpxphCS1msEXjw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741103304; x=1741708104;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bM6HdsrlC9+gstv3YHBs7wmZyQihbd1OhDTQ17QOw1o=;
 b=NyecU+nAhEn6ADPvoz7Tiqu4B8FKAVp+gBND7ClAxQcumTLO4mBA6no2KTKzN2Ys6j
 5Yf/rpf6WLjL++pRLNt9ey6oKiOmdxlshg1bb+V9mN0LTchOzpfW+2oOfNpvQojRhU89
 yeHfOSTydwSb9gMeuUTHBoUzql0RRoLr0bPXhwwjr/B09QHoM/Ou+6rdA/erVQePk/gy
 ZTliNj4bKEE7ebJIhn0YqSbxqVNLWP9pddxcUjtz6Zfu5FZAX7SWITZwuAZqyLTRbcli
 dID7BheFpwIQT8U/NYwEfaAXuOG5RkcopZuwmr4B6u9OQZRF3jI8tbwy5S//HxLqV66J
 MpBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2j/5C+cN8kUk4/e36nrh5xoaL23A4CM5TGKL0Ygb1BmZ6Hkp/5wWrMz/ANpc1G7zNsapgirk=@lists.denx.de
X-Gm-Message-State: AOJu0YzvQLGROqbeBGZNjUgnmOrZYNlUSjDqFQatiwr5gKUNs5icSM1C
 YXsGFFvDPCmkonquq0PpXAP0pBmqXOF67AuL6dvns53l3WZV6yUGkLxBDaDcpi83X9LCS2DIo+V
 thyj7Y4mL0/pkW9rZ7PQ0uhUtB7/exjRx1YqO
X-Gm-Gg: ASbGnctHaOPD2gz7/WilBOUhZNZx9QyVqzN+Jacp7ZLerznWP/CTTcAe5KjRMAAPoZ/
 2rAM7hTs7PmTy18+LyFuBy87hAKFmTututkgZovhdIM1Pxg5IyYXSR8h4p1Nf2//L4gZ7zFvEAw
 4IKDHIfZMosFeTsF1p5TiGc849PKQ=
X-Google-Smtp-Source: AGHT+IEB9QKwzRQE+P5N6uNhD+hX999MLX2lrhi6EsxgVqp4uLDs3b0QGfSd2XaRC1D92KmQuoaCN3vpXi6L6mwlDps=
X-Received: by 2002:a05:6402:4316:b0:5dc:9589:9f64 with SMTP id
 4fb4d7f45d1cf-5e4d6ad8c0dmr47037256a12.13.1741103303826; Tue, 04 Mar 2025
 07:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20250224120214.147646-1-clamor95@gmail.com>
 <20250224120214.147646-5-clamor95@gmail.com>
In-Reply-To: <20250224120214.147646-5-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:48:10 -0700
X-Gm-Features: AQ5f1JoXskSAsSOL8BmN9mrDuMlKHpSx4Eta1ZzcwBYKHru9oBIBrpQWEA9zdSs
Message-ID: <CAFLszThZQ8a6QK_xH3UtZDcjOgjj-LCsAFd4h0T_8z3brBoVjQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] test: dm: add video bridge tests
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 05:03, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Add tests for video bridge ops.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  arch/sandbox/dts/test.dts | 46 +++++++++++++++++++++++++++
>  configs/sandbox_defconfig |  2 ++
>  test/dm/Makefile          |  1 +
>  test/dm/video_bridge.c    | 67 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 test/dm/video_bridge.c

Reviewed-by: Simon Glass <sjg@chromium.org>
