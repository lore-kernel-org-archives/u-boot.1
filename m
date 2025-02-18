Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82871C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 11:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE3F807F1;
	Tue, 18 Feb 2025 12:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvdnRL//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD56C809A4; Tue, 18 Feb 2025 12:38:23 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A5A807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 12:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5e02eba02e8so4542661a12.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 03:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739878701; x=1740483501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqOatRllJZs0c/NV+H9U/rQHbxeLx1PqBCmQ6DF7DeU=;
 b=mvdnRL//2EZSqb0jWBRDIbqudkBUP+E8sdvpg4KTlY6Tx0S6s+bS45HTu91i+9DfhH
 usYgXoK1j++jBvCNla1Ovd62BIRHgUOxYwlURXvAGGi21kFGzI3mpyW4tUZXCZbiJO0P
 u2KvgG/yN0vXdu1rwZuqXy6eNYlvOAWBnEByw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739878701; x=1740483501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqOatRllJZs0c/NV+H9U/rQHbxeLx1PqBCmQ6DF7DeU=;
 b=bo4C1R320pqSolXG/5c7zoqbqTBk/L0DTITVcEKH/4JWLaX8+WyzO1qmPYteUBA07Y
 f+IQ5xvYYkqV+gDjPg6zG2jukImrGXRrzJRcK9zhT7pERwA9IuJpVboD16RfDmwUYNan
 oK5mNvGVIdAP34WvAlAK6r6jlYhEzsZ+gKmfoXjFcS9EvGNx5uFRuKqgx5h3CUCDnZRy
 v8Ju8XaD7zjB7XQsGUQhYXfn6NLFtbIrEoYZo/1HzgWNtHr5H3z4ACrHrLThBkj78Gz7
 2KC4ZgbYmYOkbicjpFJtcQoC/E6qhYc8Y1GQfVXDIv1rbOYxP/eSzgs+9H381ByXGA8O
 HHCg==
X-Gm-Message-State: AOJu0YzDRLHHVlEwrB56U6eFNsmDSj7PRzkhyyCWhFGgqJEEI0sls+DS
 r8mBRoEeSANu8NZba/bqqXMmUAHrXI6/n0U8nL7jbvQwU4r6aj2XQ96UNXf8NNw5ZDk5sMwPPXY
 PdQ97PXOO03ODxpi/9zmfcGv2CtbFe/oxk0McnLumkwAm+eobzw==
X-Gm-Gg: ASbGnct8gkMdn4War6iZGkKU5BtW4UhFblI3VJd9+MHILpf29IRMGvel70SkAgiGCpi
 GglTxQj30wRtuli5mWbaUeQdOnv/7XsksS5H81vLNF2yX+cTg14trNPhug0B3XfV6IIddIV2JWQ
 ==
X-Google-Smtp-Source: AGHT+IEI/1CaKly4ArPZFu39t1hvmd2CKU7wbVJ84kay+xd56F8o2u6oyNjATbpOvuIIRbiJ375AOmXxWBzHk3XLXFk=
X-Received: by 2002:a17:907:1b12:b0:ab7:bfb1:99c3 with SMTP id
 a640c23a62f3a-abb70e323cdmr1530715566b.53.1739878701224; Tue, 18 Feb 2025
 03:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
 <20250213131104.186663-3-sughosh.ganu@linaro.org>
In-Reply-To: <20250213131104.186663-3-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 04:38:09 -0700
X-Gm-Features: AWEUYZnDsI9qwJ_YFKDQtXlyS-NgYqs57rfylNRb2Btlh7b4GRJQWns8ukbKBDU
Message-ID: <CAFLszThqvkcyBQf+Pn+7NsY_ERyP-mof+ic9-81z2wRQvmF3+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>,
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

Hi Sughosh,

On Thu, 13 Feb 2025 at 06:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The lmb_fix_over_lap_regions() function is called if the added region
> overlaps with an existing region. The function then fixes the overlap
> and removes the redundant region. However, it makes an assumption that
> the overlap would not encompass the existing region, and in such a
> scenario, it prints a message and returns without making the
> fix. Handle the case of an encompassing overlap also in the function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>
> Note: To be applied after an A-b/R-b/T-b from the original author
> of the lmb_fix_over_lap_regions() function on this
>
>  lib/lmb.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Would it be possible to go back through your dozen-or-so lmb patches
and add some tests?

Regards,
Simon
