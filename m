Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE7C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9094D87931;
	Wed, 13 Dec 2023 21:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D7qE8C6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D0587906; Wed, 13 Dec 2023 21:39:46 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB5E8791F
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1f37fd4b53so912845566b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499983; x=1703104783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=anKxv2xDM/9SCww8NMeQOx5+q6L+pOBEt9Wfjq8PVro=;
 b=D7qE8C6cdT1ewpjTWoTpqtESN0ee0+alI+VOyYyR9NdtHlYNvk9A1V8sNIYFFbd0IU
 NnEy873J1UotZ3IDkXtYKlmv177mPKUmzdJM6f48xJXaUutECl27+NidxeJGAvtAoI/2
 Y25pptiYfQ9Cz/Vi2u/6djMIDlsaioLJXb/dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499983; x=1703104783;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anKxv2xDM/9SCww8NMeQOx5+q6L+pOBEt9Wfjq8PVro=;
 b=Xhc1DehGpY3v+pQ2kJhtYrHDB5EdQAnayqhkyv44CxOyykhmJwZsW/oU7k2noifv7j
 05QvdctrFAfvJwCyIjebReM/uI4dUsNDByXDt8iV1+ORtHau11ltGmqoESdbhig9LkxE
 EkJlnSjN86sn8zfZ/eBUihASIgZkOG/C4xtIcI5AF3bKiE5PloFtKU4rfreOhWUdtv4s
 6f/QnQ/8q5NatTL7ExIWm1LYvi+QolBJ0okBBxJX7uNLedj8f80c6W0wBVRZU3nEs1bo
 DFcu5fp+COZgPL2I8Lvt51HTJyELiVDeKR++9TnUKlJFWISYdyu1plWCdpVLFaQJC4rH
 2zYQ==
X-Gm-Message-State: AOJu0Yz0rOCBTri+/61uYyz11lmUq78y+q5FupXaukv8um7iGcW8xOr7
 bDpqOBKssoJmxcfhaOnq+02hF6gdu2Y151byhe9P0g==
X-Google-Smtp-Source: AGHT+IGZ5BwnDjH8zyryh5qERayUJ55MNnomtOBKnFl5PlYOhFSIpuqXopj4KQZAJCrVBfHq+au7EVEt+eQRNORhEC0=
X-Received: by 2002:a17:907:d92:b0:a1b:7b6f:7aad with SMTP id
 go18-20020a1709070d9200b00a1b7b6f7aadmr6145107ejc.92.1702499983048; Wed, 13
 Dec 2023 12:39:43 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:41 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-4-sjg@chromium.org>
References: <20231002011553.463514-4-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:41 -0800
X-Google-Sender-Auth: uJFXuixaLZboWG96IlxMIrLOnX4
Message-ID: <CAPnjgZ2Lgkb_HCdsrcW7xj2dP2P9T2hBzE9taZBOi0WPnsGBNA@mail.gmail.com>
Subject: Re: [PATCH 03/34] test: Add helper to skip to partial console line
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
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

Sometimes we need to skip to a line but it includes addresses or other
information which can vary depending on the runtime conditions.

Add a new ut_assert_skip_to_linen() which is similar to the existing
ut_assert_skip_to_line() function but only checks that the console line
matches up to the length of the provided string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/ut.h | 30 ++++++++++++++++++++++++++++++
 test/ut.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

Applied to u-boot-dm/next, thanks!
