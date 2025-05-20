Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEA5C3DA6D
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 12:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EA982B00;
	Tue, 20 May 2025 14:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EYrjTQFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AF782B7E; Tue, 20 May 2025 14:00:56 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D93EB82A8D
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 14:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-32923999549so12413811fa.2
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747742454; x=1748347254; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBxtQzWtE7caQmxQ7Y3aftleTvqs0g1c0f3yQLKcwzw=;
 b=EYrjTQFWzItjcvyjjqgLq21LJqH4/u/CV2h0dbJZmfdq8yuokxtNYO0Ec7STLwExo8
 Tqg9xzmuyZDkclz5inIATFjZxIr0c1TUqcgbmLOVdmWUXl187Xa10GpTp7LDpby9q6G9
 QF9dguz7YKXJTmmDyrG+syxr4y5RLmUHo5JCtYjYkYtt942Yijk7Iyhe2gLkoQyBVqO+
 uQj1yfpQjjtsy6IcrbalXFlW7LVii4A1O0f7Z4rOBifi/RzXJ/1H3J6IAXw1zrt24YHZ
 kqAutj1Q1tYL4aZkuikjstKY4jgveSfpZphhF5yBIX0pLIm5W7jPLAIyZBFAPoUvkeFI
 mTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747742454; x=1748347254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBxtQzWtE7caQmxQ7Y3aftleTvqs0g1c0f3yQLKcwzw=;
 b=NKPg6atqDX2AbqDZd2t42TSsmSb8Cad4MspxSVeKxSu5jZoSMSwVTP+/FAtKWuDuTB
 r6Ov0WflHseJ4HgIvhQJz3+2cDtcadecBLeJh7xVCHqs/BmyzVEt3k7VV/XN6LTf4KjO
 oAoV6fJnoRZ8Tdwx61+WwDQwMP9HqgjTInepT4IJm7iZgGhK4w1dLso90zw+IB0QsFlU
 GytAWKVpiCiwD1kDz+tJ7zz1GUK0oW/fLicJWBwFCthsX6xU7sXM3BHQQ7I3Q8Jl9cpu
 Th4bYgJ+qdJr3MZPnA0rb13726BGovcdvVKFDg5JJpqRsqrIVDjvgJ6rzxhccpaqD3nJ
 G5tw==
X-Gm-Message-State: AOJu0YxUnxZmact/L++axgFNDb8j5fRMu6ov/EhJGEUkELMhNIXW8H0Q
 Ol6UMT5QFa+Kw/d4YYSoIu1/QQ4YR3hVqmqS6njEwQJSY+FOSuKk8iW5y0Rf7ndL7ZZMpsxeyAl
 fTI4jq07L/I2RnXp1USLslCKCEFA6k3M=
X-Gm-Gg: ASbGnct9b5SGbGGZWZBUeykbbOSCPm5S46zuPVnQiCisHOwru7mhYszgac1V9X3RzlR
 Js04uGeaq8KOZfpAoAMCVc0xYhMgyNTJIFu3pvGn3HiEuBjX/jcsF7ZZEZwTj2lCFXSIntOqxvB
 8lrNMtIW3lWPO6xZH/H5tWS1Q+Mjpzm9ix5ab37aKNJrL5UlcGZq8D0DQvWs90WBE=
X-Google-Smtp-Source: AGHT+IH9WRcNUG2y++p0iH8Dd2qeUS5160spN0mwTw6Csl5YLhbKIlvAYaeeS6YKuWOeXFGR+sK81ZzFBjobx6a/zc8=
X-Received: by 2002:a05:651c:110b:b0:30b:d17b:26aa with SMTP id
 38308e7fff4ca-328076e8964mr51863541fa.2.1747742453908; Tue, 20 May 2025
 05:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250520090241.926812-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20250520090241.926812-1-dario.binacchi@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 May 2025 09:00:41 -0300
X-Gm-Features: AX0GCFvWDIFlix4TBBpvjzVcg7Zg64B08rcAn6es0KklAuXIvsPtzE5AmCyIxg0
Message-ID: <CAOMZO5CRVhRhHu9eWDk2mG_Q2Yf1jP5M8BQFyN=8R4c4T=KBbg@mail.gmail.com>
Subject: Re: [PATCH] board: freescale: imx8mn_evk: let clock system enable
 UART clock
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 20, 2025 at 6:02=E2=80=AFAM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> From: Michael Trimarchi <michael@amarulasolutions.com>
>
> Now that the UART driver can enable the required clocks, remove
> the hard-coded clock enable.
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thanks for the cleanup:

Tested-by: Fabio Estevam <festevam@gmail.com>
