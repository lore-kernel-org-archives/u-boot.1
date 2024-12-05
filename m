Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB4E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CDF8919B;
	Thu,  5 Dec 2024 20:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dLHl/qMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1F18907B; Thu,  5 Dec 2024 20:55:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0A798903B
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3ab136815so598540a12.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428510; x=1734033310; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WTKTi/y157uB6rWGpNXBF+Pbcl792MNf4ePdSW5C3/Y=;
 b=dLHl/qMoKvXrs1v5vZDit9qYNC0voOoziv74s4gcZ8516qEPFYK3WtcGQ2DpBCu6bm
 CjLt5daJtuJGLD+EgBmMnc2PV77BFeo24J/2+Fm8sTqAZpOcEiwLt7sCNKjM+CzE24Am
 uEXfF/mLFGRUOFgLENcbAvYICuBgNhlT+1euk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428510; x=1734033310;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WTKTi/y157uB6rWGpNXBF+Pbcl792MNf4ePdSW5C3/Y=;
 b=ZyxSOQzVPQAjDbcEzGAiWd6kmZsOwLc3UzjRrfpgCHttdVqT7WkxkoUuDhmkg+fuz1
 3kCv8lK7ajZ0FM7Dqyb388uLj0ApXgx/cgFFPHSNr0RuYJIrO/D9H9JGgO66F6bAVw2j
 QetUnwZ5vg+Qkqgelmbhlw9w6pm9fRzhUNViF8y6MrmP0ewenKx24gJQTYGKycvUazvi
 z+NzmIRwOozu+rPuuOshf48jCX1aplrUvyeWqsnKtoHd+9aP53og6ElVBQgz5JlAO3JT
 A2EV1G7XkWKQm8FRi/qK+ZaKawkdPeM0mLKbLA0MCfegXlhGHXwGdROKXhh3Wk7qwgXA
 122A==
X-Gm-Message-State: AOJu0Yz5Oaot9tK6CCb2hJiVQgX4NPR9hPL0sI1tDeJlKsxC53MNfYOY
 bKia1EyRs2db+HCVp1YgOe/HeJYw5uBe2NXgGosEwT+jKv9wdWRzoKfpEs7jCgSXNkdqeXJUD44
 qDGaGXC9TczXJJ3yW8oO5qt/e6/uYs6M+tFicNgdIOR+w7gQ=
X-Gm-Gg: ASbGnctMXK5W6ZRy9VFfrj/SNOr9A6raXrPQWK3YeJXA6Cn+qqrecKKoe4pVSlGGwTk
 0WP4nQ4QTLPU4BKTWJpxrHSABl7Ww8P/R
X-Google-Smtp-Source: AGHT+IHlSLrsPwTbEqEpyKosb5Og4TWcYWU7NmhJwY6pPHEYX1QaoqAGo15rYOZt5cJSMqtlJkgtMAxm/LKxUGCWkM0=
X-Received: by 2002:a17:907:2716:b0:aa5:3e46:96f6 with SMTP id
 a640c23a62f3a-aa63a1877ddmr6450866b.31.1733428510114; Thu, 05 Dec 2024
 11:55:10 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:09 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241202133934.GC2457179@bill-the-cat>
References: <20241202133934.GC2457179@bill-the-cat>
 <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-9-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:09 -0600
X-Google-Sender-Auth: wTq5gxg9VwnLnTZK8R_IZnJQyYY
Message-ID: <CAFLszThSruWSi+AevAHPDg=oYQvk9twE8ua5vabRvYpJ=5vZrw@mail.gmail.com>
Subject: Re: [PATCH 8/8] CI: Drop broken boards from sjg lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>
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

On Sun, Dec 01, 2024 at 07:42:36AM -0700, Simon Glass wrote:

> Some of the boards have developed problems since the last passing run.
>
> Disable these while diagnosis is ongoing.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

I'd rather not merge this since we don't need to pass or run this stage
by default.

-- 
Tom

Applied to ci/master, thanks!
