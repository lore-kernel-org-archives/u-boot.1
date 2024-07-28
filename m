Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F2C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA8D8878A;
	Sun, 28 Jul 2024 21:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EIcSFtZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA7A886F3; Sun, 28 Jul 2024 21:36:17 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C632A87F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so14192416d6.2
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195375; x=1722800175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CNl5ZjXR5lM2cdJo1jsBSa+SHh8KPEROjqG3pTCjiKA=;
 b=EIcSFtZMwZKRNy5rMlJp/kNV44tZM6a+njqBAx/WOyM4wdnRGjHSWP410hIlxhx/DN
 GNmE0A8Aq7HZ/2Gh6gM6VCt7xFBpj5r+SFItz/zj0t2oQEKKCVUvMQYXG7lsnokHOIlP
 7fd6EUQxDPcDNdmRI4ZyMH+fTInVzkLV3A8iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195375; x=1722800175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CNl5ZjXR5lM2cdJo1jsBSa+SHh8KPEROjqG3pTCjiKA=;
 b=qZ4ISdn5ZHS19TTsI6bkhi6tAtgjWtLLq+4h98kLaAeek+iAl6JDMNJsPaPjgET+Bb
 cIxQYLtMQBnBtwdGJRvIbDOK/oY0hacGBUxDbgWZmvEHJtYx7T4jMflB58iezKmQ5GkL
 8etokUqvKT252inmzshPxstdA5bs3mCcp221qbeRsTxnjxH2PiVzbumDugiuHAbW5UTh
 rqYm4xauB0Nz83L77MAezY5keVUCZ1iAxZ3QjySro1kYztS9b2q737jdcYOekCDOY0V4
 +VYbT6H9gFBGqVpaIQCaktNj6eDEfp3K8ROdRnkHtlCy1TWEbqv1i4C7NVnDMujTWcAW
 achQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKwlt/zdVrPAtCE8pU1mQ709cFVDDjc/q3LtkZHI8YFVZytDlEZfkB+UaQLjTQdQpEQcSzgE+9h/D82eZqsi3AINVkTg==
X-Gm-Message-State: AOJu0YyZzp0JdLJV60pP268a/t7DWG2eRuqhc2SCFRn5n6pqntWabp9B
 e+udhnNGuRHICvykl3bqwvCAhbDQsEEZzwjHJ5qL2qxYmoUWsCqYWYkNfMGSQFplIxID9ZjjcXt
 XRqp6g4PX5nI9WSKw158r6z82gUp1rN7/QMY07iMVPTkFToM=
X-Google-Smtp-Source: AGHT+IEJNblZRjo5yaKOtmGud+GRWCeeLN3NaVKb7orgBDxEPkIJcIOC8emHVFj+e+po2xZWf9g5Zi1jvqkQI/5iSbM=
X-Received: by 2002:a05:6214:f6a:b0:6b5:413a:3f96 with SMTP id
 6a1803df08f44-6bb559bc83amr69617126d6.10.1722195374645; Sun, 28 Jul 2024
 12:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
 <20240725194716.32232-2-ddrokosov@salutedevices.com>
In-Reply-To: <20240725194716.32232-2-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:03 -0600
Message-ID: <CAFLszTg47UN4Dd6A9_PsHyxByyf9FgCLk2KRcHPhxu4cw+bJPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] cmd: ab_select: fix indentation problems for
 --no-dec parameter
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Thu, 25 Jul 2024 at 14:55, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> Command ab_select has wrong help description from indentation
> perspective.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  cmd/ab_select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
