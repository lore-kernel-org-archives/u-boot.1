Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19589E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603D680446;
	Fri, 20 Dec 2024 05:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X2sMOcZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A698037B; Fri, 20 Dec 2024 05:06:06 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6531080087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so243003566b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667563; x=1735272363; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gPeqdda/bw4vngxjlnNgYfgKaaCLvN4FNRBGx4NryKA=;
 b=X2sMOcZHUJt/KDRhLchjD+TRKjZOLwEafL1ASYukKvXbl3IKNDw8hdMlFlNwCy1Glq
 Srd72tL8Gl8zsizBz2yeOeJDl1qU2oG6A7J8BLsiq7WhbVEFJ6D1gPyHmsANO+A3fK8R
 9b87tUOIcMTzwPLHh58rASGVYH9jnsYFkrFT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667563; x=1735272363;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gPeqdda/bw4vngxjlnNgYfgKaaCLvN4FNRBGx4NryKA=;
 b=jDcUf6CVN7yS/hLcxttnxVxNsqnA+WG5iieoMvdKkvV15I1y4R6lEffP4ChaR1xGRR
 ldZEeA41TRW1RQBgTF8QgZXs/SDrFEKWfQCJcy8O0wL1blcF77POZXmp/jUkRzC5MZxW
 FTkr0E0IzUCyIsJ9RBIl8EpihbjjS/HFUD/NAHPctKAD6UTfYr/jF/BsuiNCXczz1eRX
 eaNYVrJHuRVPPJXTlfHuc/iQqoXbC6uzurontMiQ62+dPu412zbLenijjdWzH52LZs69
 K/51qU0d4KOJmOPbmPajGUbn05Zk9K7ffdEDWsxXLOgwJhYD1KBwnGV1fTcj/U6hWJHw
 LnWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ+4iaJPdxByu0eWrnBzYhVA1QI+AN+E0m14yOtZb95FQz6a6pub/dVHhKYxRUmZ9xbHYUIXI=@lists.denx.de
X-Gm-Message-State: AOJu0YxiQZtNXH41VsAJtmdgdTDYbn79KQrB56a0j+lhQ+CPKtwEk4Bo
 wIUks0vv45nIjrFQQ2He4gFJc6JShh4iutiBwXSEEa7rW2hJgrPLkWltLd8/02vZjZC/eKMi4wE
 Ur+eihpqSI0HVNLWhqAUk8UYTmWGBkZe8iU/D
X-Gm-Gg: ASbGncsHamMFOadvf1lYP9fhw+0QVugAykGb4pFN8ojYMU7ZaCLPNRqP3DmXZRExaPy
 8BGGU+nZ8OUlZxQ+KnI8kv8aa8TG/lmXa/5BfIPs=
X-Google-Smtp-Source: AGHT+IHqGdd15umqU3PQEy6Qc71Hxf30q9z4rjaO8KMk5fBmxJV0DsV5jOnkInlZ37PTbCJIpe6/C/aLn5zFSOO/TDE=
X-Received: by 2002:a17:907:2da1:b0:aab:8a9d:6d81 with SMTP id
 a640c23a62f3a-aac346507c8mr85294266b.44.1734667562912; Thu, 19 Dec 2024
 20:06:02 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:01 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-23-sjg@chromium.org>
References: <20241206023626.2456858-23-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:01 -0800
X-Google-Sender-Auth: -XSSWLiiwOCnm96pddkqoOF-kxc
Message-ID: <CAFLszThYJS5koz9d_FcTv3+CgsT49Y-xRXq8t1r1eNRqD5YTaw@mail.gmail.com>
Subject: Re: [PATCH v3 22/46] net: Tidy up the comments to parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This function is a bit vague as to what it does. Expand the comment a
little, to specify which args are provided and which variables are
updated.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 cmd/net.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
