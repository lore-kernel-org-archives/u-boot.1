Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7181BCDB482
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8062F86E8E;
	Thu, 12 Oct 2023 05:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/a4xs+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1235086E9F; Thu, 12 Oct 2023 05:44:34 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB9686EA6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d818d65f23cso548652276.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082265; x=1697687065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2cuGUDxrjzA5Dgagul4TcUlPbADssJm3eN5HsF+6AIM=;
 b=m/a4xs+4EXK8kBZvUjlf/+TgZAmo4G+myEGfLfFpCUJ87snnIyLuxfBSWNEyzaVfma
 P2Ue24Wd5Ir4oIc1RG7UVRyseLQ0ClWTZXb3t8NZ0v3ts+67OLySTM0P/6jKa9mYViNq
 QLTbMvzpeo6mHqvzWTcLxlXaU0/Y1iDY+EJyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082265; x=1697687065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cuGUDxrjzA5Dgagul4TcUlPbADssJm3eN5HsF+6AIM=;
 b=Tj+G6aOb0gsSZfz3V4WJUTFHi6bkQ9Ut4PVm9PolszP0N1kq5w9u8aU2OX2uo5w1B7
 ji4VdzGAztVZx7K6UdEAIaXSK2F2HXMqohZA+7A3pYzo4lPaJigDx37IuPJynQG0TX5X
 /iRUEoHawqNP8AavA4d86FvMfdxzaVaMSH+Q5+ZGwqHZkxrcjDjT7x9WQIi+/FxgBKo8
 wDPJNI4rlFBEYyFUn61DpaIrweXclT6aV8Lv3ec0w1WTaNz/P6A1wSlb9PpKSQ36DqYb
 VpMtDpk8vdPjAuIADl9/7F78QwB3lJqUAPtD22b4hDqbFiCau+T0Iz4la+D5LuqVSOhY
 HCjQ==
X-Gm-Message-State: AOJu0YxUi7XzIQY+tOVWoM3rJ3azLa3qFFqOWqInxIeTDPxF7TTO5S4H
 ieQGY1DbaXhup3coRXLdkFBfrjzSUFqekWtsoU4Thw==
X-Google-Smtp-Source: AGHT+IEbeLUwn1xTeK/RZj2gcG91RKJpzcvdFBXi/aBt+1o9FWuv1GJQadhSHgb2zbhiU2qfeH3N8KKpSFHSSnjXte4=
X-Received: by 2002:a25:8447:0:b0:d9a:bfe4:d827 with SMTP id
 r7-20020a258447000000b00d9abfe4d827mr1037687ybm.19.1697082263672; Wed, 11 Oct
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-4-sughosh.ganu@linaro.org>
In-Reply-To: <20231010091059.375036-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:46 -0700
Message-ID: <CAPnjgZ3T5uwJv_S8Z_6-ZcwtbHC8T25N7NNhBkBybJZBtFpjuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] binman: capsule: Remove superfluous
 [address,size]-cells properties
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
> The #address-cells and #size-cells are not needed for running the
> capsule generation binman tests. Remove the superfluous properties.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * New patch based on review comment from Simon.
>
>  tools/binman/test/311_capsule.dts               | 3 ---
>  tools/binman/test/312_capsule_signed.dts        | 3 ---
>  tools/binman/test/313_capsule_version.dts       | 3 ---
>  tools/binman/test/314_capsule_signed_ver.dts    | 3 ---
>  tools/binman/test/315_capsule_oemflags.dts      | 3 ---
>  tools/binman/test/316_capsule_missing_key.dts   | 3 ---
>  tools/binman/test/317_capsule_missing_index.dts | 3 ---
>  tools/binman/test/318_capsule_missing_guid.dts  | 3 ---
>  8 files changed, 24 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
