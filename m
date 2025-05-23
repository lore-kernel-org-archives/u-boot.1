Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054CFC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:19:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D450B8331C;
	Fri, 23 May 2025 15:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DGFX1RqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB28683280; Fri, 23 May 2025 15:18:43 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D58D0832FE
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so178647666b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006320; x=1748611120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ruugsc8X4gyKT4wD4a9iQ5bbUdUGeX2Vm0kBtCFh8F8=;
 b=DGFX1RqOzK+D9AbYExPxvkH5H+NKhE7V4MzuEoTyo/0PUwaJwkSmDi6ql+Oo10DU08
 HIypyQ8m9YznX4X/3vWBNFk8oAvjfhwxJ/Ltqp02YGpIDcOshMERgPFezdU+izt2+fbD
 LEhHcWlZfpJFdXoJIeiJcVKkO1Ehkwpc8qMrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006320; x=1748611120;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ruugsc8X4gyKT4wD4a9iQ5bbUdUGeX2Vm0kBtCFh8F8=;
 b=wQH7lIc1qZ/hqTrmk9mhPwWhSEy589wc9St89LQT3G92zr8xoVHLjFvkkKHolrotUd
 HABszmzoKlpq3ihhCQgeWmIivMmRliW3GSSTF9Fcby+KPMDXCsWIZ+TlNTJ8319VVYgo
 RtJm1iQ3d4EKW6F14+GRpJLadffNTrLtXtmzqwWF+8stuO+LQket/qXhgBPzDtMtgALn
 DxPgbY4UVUXJT6NxosofNuh+ePnIzXnFFifiXLMVJTjCLkImWK4doeirmALyQO4VbjE6
 gWfoaCkFhy6KLsEKoEuYu9fQwuMAPWnEBp0LyDSyf8Hqe0ZTU47CbQMPEL2ryKr/8BPG
 9VQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY0xN/FxnK3oCWDPWdXoEJKuOex9YET6Q9PtRbILDgFZIeQ/ZUKgd7rXJX5fP3iFStmTDBeXE=@lists.denx.de
X-Gm-Message-State: AOJu0YzK9Mnxbwu5vlV8dWJrvwXvOO1iV5DI7UBAQFpErLpNdb/Kw2Db
 q8w5yOzLGo6DGjb0p4ZjO8jHd/udnGxA+EmMz9MjGppj2c3eCKb2VheQCz2JGMq7+NuH6QgdXVv
 oESMsEIMxFOK7oJ14dnlTRYEHRHK38SY3bp63+xIc
X-Gm-Gg: ASbGncvZ34D2E2nbzrvNLQ9dCrnLS8d74TJOdLjPTTwTpUj3HdXpE9XRBy+290vxrEZ
 e2r3iQukpLYHwgvs/ZjpExRtGvKkcJbAmbMATjpU6OVtVCG38Rsqo5cJXiXQm0ZM+CVRl3KSTKy
 bIfhvryIURx5E6omwZFqBYTM4AkcvN8ujWww==
X-Google-Smtp-Source: AGHT+IFMexJ7FB4xO6jjZwSe1jmOiyZ+lpRV6DgNGcunTXLZy7TxNnFkJG4++i4yiA+jShqGZ/ATY1Sm5zNt/YYQYfw=
X-Received: by 2002:a17:907:9806:b0:ad5:d6b3:5cd5 with SMTP id
 a640c23a62f3a-ad64e2886e6mr288738266b.5.1748006320276; Fri, 23 May 2025
 06:18:40 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:39 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:38 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-21-sjg@chromium.org>
References: <20250504132356.2317305-21-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:38 -0500
X-Google-Sender-Auth: s76SjtOn2Y7_PdVduG6QqZL7whg
X-Gm-Features: AX0GCFv-vIgPMEfjUVpg3wERKxt5ai67AAdzmoFhHbDw7KRQGcxsYti2mBdPphg
Message-ID: <CAFLszTjx9wyU2Z3T2Dkhqg74GLwLeQjJDzoKKruTRKovhR2YSg@mail.gmail.com>
Subject: Re: [PATCH v2 20/30] patman: Split up check_and_show_status()
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This function has three phases:

- collecting things from patchwork
- doing some processing
- showing the results to the user / creating a branch

Refactor into two functions so we can eventually have the patchwork part
fully separated out.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |   5 +-
 tools/patman/status.py    | 107 +++++++++++++++++++++++++++++++-------
 2 files changed, 90 insertions(+), 22 deletions(-)

Applied to sjg/master, thanks!
