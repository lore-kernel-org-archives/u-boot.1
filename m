Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E5DC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05FE3888D7;
	Mon, 29 Jul 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JK6Vd/XX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4B7888E5; Mon, 29 Jul 2024 18:19:43 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6441888FA
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b791cddfcbso13558156d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269979; x=1722874779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KV2/SzPJye6JyH4gUdRo8xlq9O7LJDaJd4gRjJ9/lRA=;
 b=JK6Vd/XXrZbMhsKc8KDoc6O26q68cXtXKlo72D9r8zttv5+u3TdG79OfxNZjQ8AHkd
 CE32IJa64UWlC9BNM0STV5C4lBXfrttiFXJHiRlE/nOmNKbefU/CpBmT9GgCTbRwpMDk
 LSYw/5C45wkEfr7togiM+xs7wOtTpS8jQuL6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269979; x=1722874779;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KV2/SzPJye6JyH4gUdRo8xlq9O7LJDaJd4gRjJ9/lRA=;
 b=XpoY8J/8kD181ufVFoICsw7wRa6jnaXKzuPKYR7cC7ReHKfJYycd2/Dhpzynmh1on4
 +wuwE2zvzDLxSj9YuRyJMoII5puTsUDnC/3Qb7cl+Q+wy1cGv2DpTQcuCahTyqcgmCKA
 aBaY3/WJWY6TFszX+gMUHWFqXRKnF512u1sLINDD3+OYKZ12QcDIwAAc9t0qhe/JrbvK
 Hi2QiMB/cVa0am/d7Tlmd+LHRpbjqjdNRcJ54kI0abuo7o4zAT94KbIT4nYw2KXrSpt4
 7ioRnOjM7GCjlirq6NZ0En8RKTQEaWb7VM+7W3kwPJpncJImtebxQPivzngas0YkvcqR
 EGRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEabrNinlCN5NzB8K18c2q35PvzIm3f70nYgiEIBFHnxa1cy5sQ+FU4VPEvE9EXUoYJCk8qZdnWrbRPq6V4knmzgiyqg==
X-Gm-Message-State: AOJu0Yz5fajB+AYR1VCGNDbFxkMwasScpq2kgr5IfT4ubHlNp4MtOi/M
 SAN1DkQDGEa1bjt1XmzQfv7X+HjEj6jQ9A6Sw9QVr7KZFT+Yy9Q4ZnAao7ZWklnaEKwT1WD+HjR
 zivL1iSzViUwlxKrJF3GuuLwIui9nhcbhCGeA
X-Google-Smtp-Source: AGHT+IGuPQpilDqGSxhCRnr+JCK2FT11ZAmSaBWxU3xPW1hZk4aHA9/2zLidroq1Mu/V5eNaYlKw4qHbDXhxWX75vLU=
X-Received: by 2002:a05:6214:21a9:b0:6b5:e190:435 with SMTP id
 6a1803df08f44-6bb55aca12cmr68125806d6.50.1722269979504; Mon, 29 Jul 2024
 09:19:39 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-5-sjg@chromium.org>
References: <20240720104950.2730773-5-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:39 -0700
X-Google-Sender-Auth: uJHixLas-5W9Enlf6eh379i4-34
Message-ID: <CAFLszTgJUpOOj5U3-oU5v23gqr9MA47pgjbXzxSu5OPHa-Lsmg@mail.gmail.com>
Subject: Re: [PATCH 04/20] binman: Tidy up comment for
 Bintoolfdt_add_pubkey.run()
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
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

This function returns a value, so add documentation for it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/btool/fdt_add_pubkey.py | 4 ++++
 1 file changed, 4 insertions(+)

Applied to u-boot-dm, thanks!
