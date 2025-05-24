Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D7C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63B92834EC;
	Sat, 24 May 2025 07:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EmC0neSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D07834B6; Sat, 24 May 2025 07:05:51 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95AB583303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso60549266b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063148; x=1748667948; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5MS8kE3gbQX6v2o2DhBpc8kzknJeogNPaivimv6Hyc0=;
 b=EmC0neSJdtipuoOnD2YgbA6+RPIjmNPmYXTFbXZ2TZCjpabi0Hpd4hTgImH2RyJ4Vn
 391wgIS8QVN/y9lv+t6CGIM23/TqKpr6vmQS7QZ+ccJCzk+dZdM/zhCc7/osieVn7Qel
 tQG0uEzChLN55Z+EWOm4YpCVWU+zz6HZfJZq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063148; x=1748667948;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MS8kE3gbQX6v2o2DhBpc8kzknJeogNPaivimv6Hyc0=;
 b=hWbcW1HQcSgznx76jauY3L06NP3YjekVT0l7KrJpjX5xydm5aYjwtw8Oi6M7MvmPcl
 pp1QTEVhO2Qt3uyRsHl7g88SGzjDJ5o2sPA1KPnVy2+uWwBawYFx291mwCj3wOyA3M9e
 UQINAU+4CUDv8d4BXNwVHNDR/S01r8WWVpk6AvZBdE/LTJhXwWVX3iJc8D/++SmHTNzs
 R5hFn8OfsJt7TSiO5xdWcZO03gOAzRhaxGfT3A/ImbwBadTOXfv3QBxyT3G07lVa4ZVo
 CskHAiDr0LbQqMPss6HuK1UgI9fAbgeU5i8sEDXYvJIyksKRVhuvwZWZo9ZTU7lC8xEv
 pRwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSXN9aMi9uwFTOaNa98lxoT/BJgA+VlZowN5IG6jdHTmQug07vvJGO6c2b/YPAM2UJlyTeIBU=@lists.denx.de
X-Gm-Message-State: AOJu0YxQh+IOhyCG860QgwFxfCGYqOE2zPWUrI53JFziIyIF6u2+YrLH
 Aoym7eP2Z3MeGxKLYImmA/g+1uCRGhCwM6zIQEJRUOEWjKCDaqWRYlMT5MERlEBRogI3HwR2ODf
 MguRv2kks5AJfFRkgvfNDwThkAPmpVr9VZ6g1+cy8
X-Gm-Gg: ASbGncvE+YFmFHtM1g2Y8NnEyCHGZeXi+v/7R7aCn08LGoe1U1G/N7T0muwUYhZMDdx
 9XONpf+ZO5QPmRXqj4YNVdEKci/fIzPttsPBzxf3a+Hg/g29ovan8nrn3xzu+iy7JXx9YQXFce0
 qbKqSmyEIq3eOEhRyaw/640enACJWZ498=
X-Google-Smtp-Source: AGHT+IH7v7iTeLDeyu88GQqZNxfngqqbrwm05HI0ZFvMhLQfygLmho3LWGoLow2nV6dka1Y+reX0niY/ZbwtUuDNLlw=
X-Received: by 2002:a17:907:9482:b0:ad2:532e:abe9 with SMTP id
 a640c23a62f3a-ad85b120478mr149957266b.1.1748063148039; Fri, 23 May 2025
 22:05:48 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:47 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:46 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-22-sjg@chromium.org>
References: <20250510110535.1453745-22-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:46 -0500
X-Google-Sender-Auth: QbzeFN8RZ9x_kagTUTmYcewDJLI
X-Gm-Features: AX0GCFs1DEnGNg5XGxPCCLh11ilBH0V5RoB8S_JEf92Tf8iwuF1IgQltHwY-WA4
Message-ID: <CAFLszThri1YVGMDbdufw0DqSJGQ5GaBzCO3if0+EUtcbopE4cg@mail.gmail.com>
Subject: Re: [PATCH 21/25] patman: Update send function to return whether it
 sent
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Indicate whether 'git send-email' was actually called, so that we don't
bother waiting for patchwork to receive our series if it wasn't.

The 'git send-email' seems to always return a code of 0 even if nothing
was sent, so we cannot use clues there. Ideally we would watch the
output to determine which patches were sent and which not, but that is
left for another day.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/send.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

Applied to sjg/master, thanks!
