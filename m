Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F53BC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B21888680;
	Fri, 26 Jul 2024 14:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fnF8S/Gt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5F2885B6; Fri, 26 Jul 2024 14:59:04 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA5088860C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b7a4668f07so3281456d6.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998741; x=1722603541; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ycZsDVE9LezsVVgLuuEFgWOp3eVcedSMFNLPuCPCp44=;
 b=fnF8S/GtWHjgNmKLTF1jcLTV/spfyPUA+Ml5EHXmeUxc3WbXIwvEgHvGR7NO+3gSo5
 95Dvg33K/Eh2b0fatYDOWeVzWrRQ1Hnlo3Hyr2bMPPYG9WWi87ukCBBhUg0qLFa6YYvg
 uEZNsIyMwvtVJGlzpjauHpe9m5cZqXbIOvWZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998741; x=1722603541;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ycZsDVE9LezsVVgLuuEFgWOp3eVcedSMFNLPuCPCp44=;
 b=sjFoRS1oIaig9XBwBH3qQu6UoMdrxkzXhgTOZBFIr7+XERQHZr88D+ed4AplaWeMr+
 AfT7O4Ei2YLCKvwpcX0c4U2sMK3L2hDWre6RJVuQ9zOWyI8eawJclUZr5Yq5+CY3xgy6
 HEW3nIac4KyZT2Loz7ioypvsymYmItCdfXZVwo8IWnwL8T9q5e/LXc0vRr9HquyIZoEh
 gr2zK9+MF9kiflEAzmBrUeGgDvxicQ+C3FoBqBMLGfZyrsLc231nlgDstDkJTPhfW6Y/
 T8KmeL+LtYFI9tDsiEmK5Y5TZNwCQSYOhlHqclRB/H6ZQ+euKw1uIwvoLLHxh+csXeck
 vxJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhCCmCt5VfUeL4wR9u4jTLqdUAYbyn1JVbAPTpiAsG5JLmiA+VU1YyEA7ybopg4FbuNHrPX7pZDdRfFvYHYbcNJ5X5Og==
X-Gm-Message-State: AOJu0Yxq4ydrQrUCjMij0HrylH80HP1eV3Q7uLSqqfhNc8lhEd029Wmv
 ol0erJ0DkY82lvrp/eb4OHz5DYr4H51CRa9Vk52xenZusCUOPo+FVGPZyeIWUS0gCiaWxFKZevz
 +2LbhXe3nMIhQAq0k7bi1FOq/Bjt7wpxsEb7t
X-Google-Smtp-Source: AGHT+IHvDDMgW6WTFXHnyBrZ0tUwBjjVH/5dZ4WA6oHpS2czd4jopWtRF0Fh3gNloizKhCkQsqBEeYsXxM9TAzorPOY=
X-Received: by 2002:a05:6214:40c:b0:6bb:52ee:71d1 with SMTP id
 6a1803df08f44-6bb52ee79a2mr5283946d6.43.1721998741616; Fri, 26 Jul 2024
 05:59:01 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:59 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-17-sjg@chromium.org>
References: <20240717155712.2913651-17-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:59 -0700
X-Google-Sender-Auth: XEIwtFedJEp9jdHE3zh8Uu1oL4w
Message-ID: <CAFLszTjeajNV93ZXjskNKbE-K0H9D762c1NJjgoBSuD4c=ZT8Q@mail.gmail.com>
Subject: Re: [PATCH 16/24] qconfig: Add a return value to do_find_config()
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

Return an exit code so we can use this function like do_tests().
Refactor the caller to handle this.

Reduce the size of main() by putting this code into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Applied to u-boot-dm, thanks!
