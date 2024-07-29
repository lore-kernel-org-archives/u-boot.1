Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3CEC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E6DB88928;
	Mon, 29 Jul 2024 18:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gVHKz1M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24BF888867; Mon, 29 Jul 2024 18:19:46 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1ACE88905
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b5d3113168so20542456d6.2
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269980; x=1722874780; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VFfaq47opQfngIpMfQLxoaiSnBC068uZdTCM1MAZYbo=;
 b=gVHKz1M99YXE6BTrMw7f6nU2dn83Pq3jYolV6mtOUW+rzBjXilnK0PupAvevdaiwKf
 bIdgVJ9t3x/w4vMUUDgYKTvjLV+A1Sm0ImQlD71ngBvL1HO71sss5kQKYASTIAFwQ2GZ
 3ohfi3u04IGZ0dH4gJL9gCu48+ZbPWLhRhKZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269980; x=1722874780;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFfaq47opQfngIpMfQLxoaiSnBC068uZdTCM1MAZYbo=;
 b=sThX2NNGJJimJbnosE37uf8j+n5N5s5SCFBX4e8WZ4eHkqgUjLjJXYsTMIGQyAlCaA
 0Z8lYL6mhmfUcJQsvpxm7/WlfJyt7cCweVa4jPQCTGhACk9ZH+mxMwD0r3I2sNrUfk/i
 gbe28kJRRZO+/EE3EN4ZCIxwUgK0UZE/G7ZGsYGhaU7t1csv0ROl++n+UXTWlTNYWHI6
 o1UmZLZzDDCzntynwY22YBK14/JGJsVQ5IfNqbTQHEJNK2FzsWlSl0a7yrt+KoXhVCvi
 0tFRj9N0nZQ1zG12RsbX46cUFCeV5JQ7CU/slZQ5dVUTual4BTtLingYdtNucx6VEsba
 ScRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKU12RZZCVvuu/6J3X5BINbM1d/B8MBame1yP69+EFwRWfAChgVvakElBZ7XNbH+pJdKBWSQXYvXBlZctc3PiqJ/SCcQ==
X-Gm-Message-State: AOJu0Yy6Ktbrl2GK8aCeeQ2bBNvQEHMUPoookbR7Dyy7CLTtGQDCh0Mq
 khLH+dJWR7JTf4ReKOEHwzJy3Ry+C4X9bQmu4cmLreu99pgf7Xtz3oGn8PhfWa0485NYbX9N2A6
 PWkI+QZlQLFSDZcovGNeMZnFBQZ1JTb0YoKaQ
X-Google-Smtp-Source: AGHT+IHmWmfxQErxTUp1qeOdcDsw09LOhSZBJ9xFuR7A7OiK4YNsAOhJX6KytWIep6zGxBefo84gzsdy5MZdbFaUGXw=
X-Received: by 2002:a05:6214:20c6:b0:6b5:936d:e5e7 with SMTP id
 6a1803df08f44-6bb559fb49bmr133195586d6.18.1722269979809; Mon, 29 Jul 2024
 09:19:39 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-4-sjg@chromium.org>
References: <20240720104950.2730773-4-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:39 -0700
X-Google-Sender-Auth: 8WLZukPUB1Dp_sPDfiCMggOnHL4
Message-ID: <CAFLszTioLfuByO+kbZ1bXtoVA6fkpFzECu-bSv4qRi=y6=UDTg@mail.gmail.com>
Subject: Re: [PATCH 03/20] binman: Tidy up bintool docs
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

The docs have somehow got out of sync. Regenerate the file to fix the
problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/bintools.rst | 61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

Applied to u-boot-dm, thanks!
