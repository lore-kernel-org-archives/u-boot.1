Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09FC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 19:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5558F888A1;
	Tue, 30 Jul 2024 21:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jNq+3LW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4149A888A4; Tue, 30 Jul 2024 21:44:49 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3381688806
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 21:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6b796667348so2233276d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722368686; x=1722973486; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rW0yoKcPytJRCjq88pi30B98/dUkTSp94vCGVqBQt6I=;
 b=jNq+3LW2DnWcLg8NcSiZuum6zClfbPwH8wbB7vvuC+/+uhbf+HHLYrji5gmo8Cf9z2
 OOVp/b3HN9zsrqfBWIbJAhGvSTsmr9xYEcoQ3JrQc5qYhg7Gtr5JWz2mQ5e8moRUXBfH
 ogPOU/Hqln1+utaqRG7T+cEtJEhGqjcRf39zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722368686; x=1722973486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rW0yoKcPytJRCjq88pi30B98/dUkTSp94vCGVqBQt6I=;
 b=dRpS6LnrkdV932kl0OkjG3zF8zDCrLFXHAcq09uFPE2wU8RS0Bp4QJCSeVzb5D0P3z
 I5yWDA/xuhnUhIX6tRrcMmg/+ULeheaFXEC1YBVK0jHlB/dRPFCJi+dWa7gVqwdZGwkX
 Eeru//lLq9q8Og8cudk/1RArkIBVIShtdLuYBtfXNRWVDVDh5Ow3zyI8oBVNoYzGK7ZZ
 /i03VEcPEPAwbt7nsMSUE/Vpy+ZjMGnpaO8aGSgeWrMMr0hKNOHKBh9of3Bs/F+FQC03
 /mdHT5Hjci44vRO9DxSVzAsKqm6USWMj295SgUbQskoLOe3Rd1bxTCg0/HcAUUmDDLtT
 ZvQw==
X-Gm-Message-State: AOJu0YwcBAa0tBeuT+w0mtGIZY7k/h7SRgAK9RrcDeQRZ0jxNWZadJ0P
 pT3RkZRJHy3cQC0BI9rdZbzWux0s33cBlXvHx/D54VRoHT/ww3gV624Z6F7tWFOqqaeB0mVMOCc
 foW9c5lOFPpq/uJ8/NvZGQ1Nz/ERLliSyFL2Y
X-Google-Smtp-Source: AGHT+IFUVZcQNo+OYbrxBD/pxzvZw1fWotp2uShPXowIhgWkt1eiI+JLFUpuh9LW/cWPY/6FXFLvm5m2VLPTE/UYnLM=
X-Received: by 2002:a0c:c48f:0:b0:6b5:2de3:32b0 with SMTP id
 6a1803df08f44-6bb77fb12b6mr50581906d6.7.1722368686107; Tue, 30 Jul 2024
 12:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 30 Jul 2024 13:44:35 -0600
Message-ID: <CAFLszThczkPKHEsn3ovKBgWc25xh_mc7yQ0SnsAzjyYhznwQ4g@mail.gmail.com>
Subject: Re: [PATCH 1/5] linux: list: add a function to count list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 30 Jul 2024 at 05:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a function to count the nodes of a list.
>
> Taken from linux 6.11-rc1 tag commit 8400291e289e.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/linux/list.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
