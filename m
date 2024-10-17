Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BF7D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE838890CA;
	Fri, 18 Oct 2024 01:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jI2mDqKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 074078912B; Fri, 18 Oct 2024 01:12:17 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99C78916E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe90c7c95so11722876d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206732; x=1729811532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N3CPcx6JSBmEA7AerCOJUe84RVb26i+nhDRZDVyniIM=;
 b=jI2mDqKeo5eAbi5P/cJXgA6n/ZRNkypuRfHhKOWHn/YZSESuyV7fww9e3KjBd+puq7
 0DqZzUEXZigos4HhS7LVXTST4ZTM8fNGS9BYiBYJPrEo8vx9pJJ25nxSzKE3cJSl2p4J
 KlMQiUSVDEX8t/n4n4eSKwkVh9jNzfgY7Sik0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206732; x=1729811532;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3CPcx6JSBmEA7AerCOJUe84RVb26i+nhDRZDVyniIM=;
 b=tTkPg44wjSqoYzEaNjYW0/bvw0iv65gQhcIWIiTW4qxxExMvO6IKMgU9wKGb3P8Hs1
 YOKLeUHlO/VtdtNTb0i1CNp06fXqFPrfNzJq9jY073xb8i5ArIGo6mzQL6NDQEbn3OxO
 njblx889tGQfkNTe0UwxNRdqUzrVPFhSmiW5zenv1evDrR+13/lh8c0aqpKQhl+TVYrN
 xVvhivKtDgta2k0pP54K7sY9+DY1ZvgnwIyJ2rSMdVf1h2toOqW066jLWzB6AehDWb+7
 SoY/uf/GLvAQttIhggS9dfTbM37+Whl80uKBsAHSxdr4SsBqdi88fJCwXptrgg5U87N8
 k6yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkF49IMoESr81b0cZ9hdOZ9RF2Ht6lZ967JuN3DsOaXjpc8rVf0aTneLeEmp0toIgCQ3xEur4=@lists.denx.de
X-Gm-Message-State: AOJu0YyOmvNq6j8H/2Q/twmfn3pwa7VSNv4c8UyjsIEvXWAbSfJFCL4G
 o8X6zO3FLPwUMyEf1NTOnNKUHN33Z6cwSwuvoFVMmZLJvwCgGP7Lnbwf84o8zO0yXPocV5IQXf/
 9DZynPuNM0FrfAeX9sRoZA+zK8f6G9Q3nYzai
X-Google-Smtp-Source: AGHT+IHPlvAxwdUAU6JMPcMhjfCZ+Tz7bXvpeuNhOTU9pySxFySjraVjMMLz1zDiccm8X2Pa+j1mwlADB0UJ0vBzGvQ=
X-Received: by 2002:a05:6214:448b:b0:6cb:9a5c:8265 with SMTP id
 6a1803df08f44-6cde164f4f0mr8587986d6.50.1729206732648; Thu, 17 Oct 2024
 16:12:12 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:12 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-5-sjg@chromium.org>
References: <20240828014429.3320011-5-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:12 -0700
X-Google-Sender-Auth: v5t4ZvSJdr7DeMkNIMSnWZjm69I
Message-ID: <CAFLszTjhkf8w3s8+rGLr-UsN2sDmGt=YKukgB+SNOq0yt4C2-g@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86: Sync up tsc_timer with Linux
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Since we are using the code from Linux, update it to the newer version
in v6.11

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/timer/tsc_timer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
