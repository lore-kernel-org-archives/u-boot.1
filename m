Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A496CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDF786EB7;
	Thu, 12 Oct 2023 05:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aTzP2W38";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF3AE86EB9; Thu, 12 Oct 2023 05:44:35 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3C386E8F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7db1f864bso6267157b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ffo7Cua3JPk6Bor8VreQZwl0OVJSm7qieW5rjbLWN+s=;
 b=aTzP2W38G/lC5WCI4GxaiiuveoW1MHBQwrPN4Qehi7Goeg+T7bhS1qrr2QCqhZosNz
 7oIQKNyfGtfhVp7wHRZ0C/qKfs3DHRrr6WRhKvnfjR1pKwEB4tkABMCLCSlNXqVGSn8x
 jwUztfJ6TcMVfguZ5sXNPH5x38iswumHB5vcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ffo7Cua3JPk6Bor8VreQZwl0OVJSm7qieW5rjbLWN+s=;
 b=v1xq2PrGKeDHC90NXnkDh53Tgl/aloP1+SEW4YABA3LWidkx5ZuflvMgyar+gfwsLM
 QjGO8DYwbY6pQRCvTo59Jx779W85lkP+dLg82NQ0fv4NcyO0QRTbswPibmmJk5tcuNGw
 Ds1xIgxYeSRqL8YtrXAROSvC2KrngKHz6aZ0y2GO0IAEZVEiPWqvIPpMo8ZXjLOBlI8t
 pXK18uJ3wUodMv19FK6GzBA8s5+L/QP+1FOzNln1xNL+SkKHFPJnQgX74Gj6Fefum8xq
 5Uj+U5ErPUTGOldtYHfJOiuZy7nE2V+8DmlNdA4XBw9MLMcL7PHZcSfUK66Q7QGGJn6d
 pEbA==
X-Gm-Message-State: AOJu0Yyklv5dfhC6z8zxXPmr+fB4sjn3SWA+hXh8V6bDx0aCKNuLO35N
 bqdT9k8A2Zls6xa7hYpHawO1ORI61c9ZyxHOlIpDaw==
X-Google-Smtp-Source: AGHT+IGPN/2mDZtc5B7XnffTcAW/5/uHuaOSEggjndWJDcaeYeGRRGLFkzTqmBYGq2JaHKn+cPnko2hXo5I8FtutLm8=
X-Received: by 2002:a81:8782:0:b0:577:51cd:1b4a with SMTP id
 x124-20020a818782000000b0057751cd1b4amr26275576ywf.41.1697082263660; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-5-sughosh.ganu@linaro.org>
In-Reply-To: <20231010091059.375036-5-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:47 -0700
Message-ID: <CAPnjgZ1HiyVOJy7RsmNFOq3iQaVCUfyv7ED0akNiSz1DmZLYDw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] binman: capsule: Use dumped capsule header
 contents for verification
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 10 Oct 2023 at 02:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The various fields of a generated capsule are currently verified
> through hard-coded offsets. Use the dump-capsule feature for dumping
> the capsule header contents and use those for capsule verification.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Move the get_binman_test_guid() function outside the
>   Entry_efi_capsule class so that it can be called from outside the
>   module.
> * Use lowercase characters in the GUID values
> * Add comments for the _GetCapsuleHeaders() function.
> * Use a simple dict in _GetCapsuleHeaders() for storing the capsule
>   header values dumped by the mkeficapsule tool.
>
>  tools/binman/etype/efi_capsule.py |  24 +++++--
>  tools/binman/ftest.py             | 105 ++++++++++++++++++------------
>  2 files changed, 82 insertions(+), 47 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
