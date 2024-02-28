Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D512AC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 15:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085F287933;
	Wed, 28 Feb 2024 16:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qgoFd64t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B3A87B3D; Wed, 28 Feb 2024 16:48:50 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E96B877B1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 16:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jaswinder.singh@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68f748cdc8bso23630786d6.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709135326; x=1709740126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sYBNLUW4dQNK6JRB4fHa1231W3M/mMZ+JrDIvTKc83E=;
 b=qgoFd64tUX1vGu3sS9unZ8ZyuNye1x/xqw+OlM7lP0IOcayCaX2B2RJXLMANJuWMR7
 TG6owYn/v6yOyndlOvPDi1iAwKaNbkkl9XtBtH1QGoQ/CL6TKX9wZt8cFCAwin7WOSBf
 qXCTpMlUZg2V7ZjW2NbZg6gOlSpapCQuFd99LntpVUzutGvfgDn3oFmYpoolzp1GIC4Y
 8ldaXfzPXXRIu5RsefeiD41USUjkDxjW2D3v1Tbp7YDx4itgRFHpMypRXJohZyv9W2DF
 +zeBcPumjfbiGRuq7eN6e+fil2k6IBeD5FAxLCd+K9TjSvh99Io6TqNeY40sDWcAM8Hy
 WrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709135326; x=1709740126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYBNLUW4dQNK6JRB4fHa1231W3M/mMZ+JrDIvTKc83E=;
 b=toF+YMEq3o7eV7wUmWaQNNorLa2QMP+/kSdn42Etus9RgmvbPe2b8ekiEJonWCErIx
 lOWKBF7i4wtndzmokdGhY8NjIv4e7FIACG0sHaTgBJ3LcKDd9nrWYIEd5skouheYVV0Q
 nZpgJcRy3TsAS5d6PKF/q1MnrLmbP9vSqOkKrmSiiUIDVX6NQTSZkDrJArcM9//XZYbQ
 PHkZ6XrtNd0U0Z+EKD5E7hTtNufwBL6DP/JCA6Bj5FrPxxCO/CWDzaOgRv1pkW9qrhPr
 rNerF//uB93ZiTqEXaZv48HPCPRc8zq0bPRACxwn0Z6lHfxnAyfqbtA3sp9knwqT4YoF
 wmwQ==
X-Gm-Message-State: AOJu0YwQ6XYak2GyTPsg8VlOnwE5rw6T8PE6P/76r7X9TFrnbRmeNxXx
 lklxzMoWzRGPz9Y3vC9LHoDqAjOEzUTyZ96su6m75YFJYjFOlq0OsM7Sgt+EG/dLHy2yF6nFtYj
 TcNm00Eon6B1r/SJRMhlUWDNkVnqdXN9Umf6w1g==
X-Google-Smtp-Source: AGHT+IGIYc1EjkYPS9KoUy33NkFZi2FiRavyIT2pPSnz6wpaVE14h5AEjb9KJJG32+/pEXLNMLVbaoOJYjoddG3W2Z8=
X-Received: by 2002:a05:6214:300a:b0:690:197d:e235 with SMTP id
 ke10-20020a056214300a00b00690197de235mr5713297qvb.37.1709135321670; Wed, 28
 Feb 2024 07:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20240228055344.2335332-1-kojima.masahisa@socionext.com>
In-Reply-To: <20240228055344.2335332-1-kojima.masahisa@socionext.com>
From: Jassi Brar <jaswinder.singh@linaro.org>
Date: Wed, 28 Feb 2024 09:48:30 -0600
Message-ID: <CAJe_Zhfjpzi1Ds0_Csbis-3NenDUwHXxeha0Fpn=49kKp3WVJg@mail.gmail.com>
Subject: Re: [PATCH v2] FWU: developerbox: read boot index from NOR flash
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 27 Feb 2024 at 23:53, Masahisa Kojima
<kojima.masahisa@socionext.com> wrote:
>
> The FWU Multi Bank Update feature allows the platform to boot the
> firmware images from one of the partitions(banks).
> On the Developerbox, SCP-firmware running on the SCB(Cortex-M3)
> passes the value of the boot index on the NOR flash.
> Add a function to read the boot index value from the NOR flash.
>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>

Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
