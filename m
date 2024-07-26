Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607C7C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBE8B88732;
	Fri, 26 Jul 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BvN8kg5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0FED88645; Fri, 26 Jul 2024 14:59:17 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B722888614
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5c691c6788eso469574eaf.2
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998754; x=1722603554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u97dWYz5KXqjXwKcXYpQ4iuqlG5cDpaSKARISxhwW6I=;
 b=BvN8kg5ki4WfpyLC/Ke7YTWHKpGTIWGq8avlgb2n9MfKixGr5MARZFkmGfbyvN9W4+
 WONb+m1Wg4I1RCiTBf3ach5cdvQuvwX7dq6WqL+9bFPzyB7HYPJi5Tk2nPg6TCVFboaM
 Jv8UqKj5abkTZr/UeDJE5y06r27DNNUawXgio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998754; x=1722603554;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u97dWYz5KXqjXwKcXYpQ4iuqlG5cDpaSKARISxhwW6I=;
 b=PXlhow53RrAFTfVZWUwP1gRu2uLJviTOb/+JGGUAMMx9gkbyfV01K98Yk24N5jyxru
 9h+nodqTyJPt/RLWNCXUQqaPfbmzswa8b73/5tcrSbQZCf8KBFmSazGHqsxbc+HlKLRZ
 q5Ci/rbmeCeMpE0E2hxk8x3SDw+qABCm/TvbiWI1igQ3O8n0JCEg8m/liSDLcjn4LhnV
 Ws09GYuhit390qTLBgxql97MfUYPd/4AsSEr54S7JlMVrhuPcyWqXQ8EIyDwaumACOgJ
 8oEtSn9wCGFwyHC13vjJnusmNO1dtDmmFGYSLAgV3pvkK2fOIki/ZOD40Fat5ZJ6PuV4
 Kp6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbptDCTB8k4evHf0iUjnSri7MOJ8/Y08RRgNr9xrxDvGvgozqdDVV855xjY4WPGIO0D7IDt9C3Vmu1JC+gpBZNKDFdbA==
X-Gm-Message-State: AOJu0Yzu/dnYPzzVbhaMYEWoGpjnQLkJ6ISS5PEKpMcdvsmACKa2nTur
 0jPBYeeht4XSou2Gkav2rDAQTbiNrdMMTpwcqY8Iaqeh8s0abF4dnDcwhRCJpftGx4hA0tcL8Y5
 PQiwDEXQzDiqwgK1RQwacJXBJFX7tzJAvYYxp
X-Google-Smtp-Source: AGHT+IGrhdgAr3JphwROhrm74T9WlLL0eWg0oD5V5XhbzPH9rWlVbjSRWovfUebloeLtnbYgB9SmQ2joS2M9jfN3KZg=
X-Received: by 2002:a05:6359:5fa9:b0:1ad:1d18:dc2a with SMTP id
 e5c5f4694b2df-1ad1d18ffe6mr66275155d.12.1721998754396; Fri, 26 Jul 2024
 05:59:14 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:12 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-7-sjg@chromium.org>
References: <20240717155712.2913651-7-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:12 -0700
X-Google-Sender-Auth: 7h-ngvAqWNkY602PLDb9oCUG778
Message-ID: <CAFLszTiCG_O-r8wpB00N5ep8tX1g4F62Qc=DyKQjPLsmh4Ug2w@mail.gmail.com>
Subject: Re: [PATCH 06/24] qconfig: Rename the doc link
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

This was missed during the renaming of the tool. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: ea4d6dead37 ("moveconfig: Rename the tool to qconfig")
---

 tools/qconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
