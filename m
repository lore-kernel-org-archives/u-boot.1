Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF8FCD5BAB
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 23:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8645846DE;
	Fri, 22 May 2026 01:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e8QULwkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63956846DE; Fri, 22 May 2026 01:28:01 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CF19846CF
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bcc9fdc959cso1251438066b.2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779406079; cv=none;
 d=google.com; s=arc-20240605;
 b=eXtPvRKmUYFmcXglcUnh4mCa/ZXddMAe2RDAtlZDaS1yk+9sZDkFpPj/+yeHpQYrSg
 9URObNuG7t+pn1uJAuKVc+KVwfL+F+UYl63KKioy9KTQexISOMa6cLh05xCQYwkFRsDc
 b4THAE6rpGbDrN4GYtbAGI5d+FvG75ZXrnWJtS9f2tW/B9VX/bKnQcCX1mudTroHPgcn
 TllyCoBLySjcGMTqwf8EX9R62VbBpnT1/QraUhV6vOQSSo1obf1+VfuzCw8tlWMye8sy
 OC2Hfq4kZpNZVhF8gSDTBbEEhnhM+lK3K2qiwqsrs/aUDblpIAAMzlisGIOalGAYdO5b
 o0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vVodZrOa5QsMBF75HSxgURk20p1M3jvmg5uv00oTobI=;
 fh=UkYpimHuii4GqZdH6RdYCPYjv6GSF2hCxymjSk0mzuY=;
 b=iQrfyp+tYc4unML33wr6gQluXDsGG/jB0looHwbHXi3XpdQfSCyOhFcExwkmtlVyfF
 Jm5oaYqJk4M/XMIVSljZkNc5SVmT4Ggt7xmKCaKNPTCfKq8u12G2ffOW8tQVwd3ZE82m
 0ZI8ll+JvonJ8VvmdZfVecSOJLZ9zvoqGwNIlmIiHMrf5OjpjILj3s4ICEwbk7JfFRQn
 pJbNx0KvYEi0s4UFDOf+yNatgPQGES1ZPWTp5iSJ+5MLOWwoN8/GzgH0RND3nhtV9O4s
 JYH08f4qOa0rYFRP/3kqrMnOTNKTskbAbgZwbrrkJparPu08920rNvTNUvCAPqGOJykc
 3TiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779406079; x=1780010879; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vVodZrOa5QsMBF75HSxgURk20p1M3jvmg5uv00oTobI=;
 b=e8QULwkOXQSZiLzRKqFQxtrH9C5Ot7Oiu9lUlW9cqWTvYaQ4sv2S6GzOMhPM07GFIG
 z+64kDTHYU4OMKLGj+3E0NE3ctgUMzBj60NWqRg9u02gJMK4p0s/nYJqLqK2OK5e51NW
 OPe/iyXmhfehKiH/eUeFh0I7wLrXDd9wFKlYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779406079; x=1780010879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVodZrOa5QsMBF75HSxgURk20p1M3jvmg5uv00oTobI=;
 b=HzB+2/STJg5LNLjeYuk/E4cD1nMmAMvD61olyvq3pMlzIspQ078poJ8Sd9fVgeDXcL
 VrxlvjLFF6ASKxfZBu6YsC1b7tVTG9HyPdXA/b4fJG+xciwFdBkRe0mSc9OJxaIIsVQx
 OYKLX89VOMuu32m8rcElMVyieaWclf3Pe0KqbTw4QXiMQ5viReY9Z1k4qbd8dLZiGFoM
 pWEzkYAXXXp71vGXrwPe+2SK07sCO/7AVjtUyEbe8JQeRreDi6WdJZO3Gpb7GnE/j4n8
 FQm/BrLyyspNOJXYI/l0wKfVZK1Y8Qanu35b296OuYAcU2mbXiH3mfYw5H5zUUGSC8MD
 /2IQ==
X-Gm-Message-State: AOJu0YxnJynANEUQa+0ZpVF1lBFyNFxnk0yexh46BSSizqT/HMAeGld+
 xbfrdnXvbVqhHM8XhTF9OX3BxvPDbSnvIdg+95I3HsSLH7Ed6Abrh3ntyhmb+lDkYZ36Dj1Ssra
 2ZwR/cUempWQ98uMSjJukCb2SLNQeGVSG6cxMTUVO
X-Gm-Gg: Acq92OFJBCqhj6Is8/W749mii5LIpwo/zmJ6FgzmZYFasIQJ5wMUL5UQECPEBkPJ4/n
 +RGSdPXWw2JWcKNFleSE3Z2owfJDJfaYW6YQk1X08hrjQuLiQq7+F0S0dIgyfDtpI8QIYfAg7Ie
 zy/MA74s5vM44Q0J1gGzdLrhQMWg+a27drMtpmfTCoWPCSJLnJR+BMdhQ8XlAlInBZaFJl5hoJ8
 R44SpeZkyk7mMO9BZ3+14l9Kmk/XaFA9+7lXLJ1kSqu+Gwaxk8+qT0xpnpS0JubCmsuxvpsJk+2
 fCnA21ofMwMc30qU
X-Received: by 2002:a17:907:74a:b0:bcf:5de8:567f with SMTP id
 a640c23a62f3a-bdd2580c412mr74095966b.28.1779406078713; Thu, 21 May 2026
 16:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260519152101.716714-1-trini@konsulko.com>
 <20260519152101.716714-2-trini@konsulko.com>
In-Reply-To: <20260519152101.716714-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 21 May 2026 17:27:44 -0600
X-Gm-Features: AVHnY4LvrJd6-KPBt3rj_4bOdcJX4KUQADYNTOPHqItNmO5dV6KMppGAq_9u5-4
Message-ID: <CAFLszTiW4KeYVwme4neSQJ5WWHWa+KVyxP3uPMkoeCk90H60=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] bootdev: Fix the case where the driver ops field is
 null.
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On 2026-05-19T15:18:15, Tom Rini <trini@konsulko.com> wrote:
> bootdev: Fix the case where the driver ops field is null.
>
> In the case where a bootdev does not have a custom get_bootflow function
> but instead relies on default_get_bootflow to provide one,
> bootdev_get_bootflow was not handling the case where ops was simply not
> set. Restructure the function to check for "ops && ops->get_bootflow"
> and add appropriate log_debug calls for both cases.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> boot/bootdev-uclass.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
