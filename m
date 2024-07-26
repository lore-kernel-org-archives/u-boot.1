Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2701C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A520788701;
	Fri, 26 Jul 2024 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kcyMwvxg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DDB188645; Fri, 26 Jul 2024 14:59:14 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9B0886A6
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5d437791affso575705eaf.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998751; x=1722603551; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YGLUb669fOhBWE2CpPwA8rzcpjkuuyEQq2das5NuRr4=;
 b=kcyMwvxgb1WhCODg4ierSW6VYmfRehfeBd3rx7aQSrx9kyfsSNmXKgjbaQZwCM+K1f
 kAEWpmkcgveUj3qp9z/bJH1Z1pTAffik5qlcOZGCeYifExP1dZ0xgJbljmHy8uQN19bO
 nGsZrWLz9/73ZFTuW8kDV5isWjCplmnPtSHYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998751; x=1722603551;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGLUb669fOhBWE2CpPwA8rzcpjkuuyEQq2das5NuRr4=;
 b=odPlJH9s0axoU0bwgl/xTQLpmyoQj6yeZSrR/vJfqrfSHUvEA0klNxu+EGOzv5vgOh
 463xYdFQBrMyBO91CNGoayBJOLkVYHVBP/vi00RaKh7oG+aEDF3RjfzAockNvZ6IHMnL
 ovAwmN4SIkkue07IdvYhaNMA24imDKYrUIhh35HbzAiQAUachzHZlqyM2K6+NKYFzr59
 lilueCAuV9ap3IMJbVZLjXFmcM8Uoi62+FuY4c/lyZOq4uTuOjKfn9fWbkFZQG1nW4y7
 Uu0lDS11bu/O6zplMGKHK/HKAtueE7gcZIL5TtiBcBLfFUFw990preelU99ukcX+2O+d
 wXZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK1mejOWXeXYbwQlaq3fJcd3bIUD/4ScZVYPPsZrSnGCJanef0qt3FoniFSPZbK3opWiu7SwkGnmP9zV9e0YAtVPzDpQ==
X-Gm-Message-State: AOJu0YxUylK/2i9HViLqSlEnDPtfucx+U225kzYYNyuOC1GsCkQtuzRI
 +buKH9XwJ2+heaQ67E3mazu+L6l4EorNRdpE5RvYCZh2uhTeL/IkG1hUsbZVWOpjEdp3qWNAdnM
 aydq1aM8VZrDwyTK1uHneNzBRqczCMgjJDGi7
X-Google-Smtp-Source: AGHT+IHqAMjhT4Wo6B2PLsVhglUVeAZVlb2xLnqVGkpstORftrFbuwpvXgVH5dfi465xWVF562OxKTczAady5M+DO9g=
X-Received: by 2002:a05:6358:3417:b0:1a1:c19f:403a with SMTP id
 e5c5f4694b2df-1acfb8f1836mr538486155d.17.1721998750831; Fri, 26 Jul 2024
 05:59:10 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:08 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-10-sjg@chromium.org>
References: <20240717155712.2913651-10-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:08 -0700
X-Google-Sender-Auth: fZKQcZtnFhlAX0Xyicxmvz9kyTg
Message-ID: <CAFLszTgjsndN=t1Hp_eRXntGd_W7MaqVwG2zLeqPgpjcgrAhkw@mail.gmail.com>
Subject: Re: [PATCH 09/24] qconfig: Move arg checking to the top of main()
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

Check for 'test' as one of the possible operations for this tool,
moving the check above the implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Applied to u-boot-dm, thanks!
