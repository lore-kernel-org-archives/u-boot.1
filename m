Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B084DC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:27:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44D883523;
	Sat, 24 May 2025 06:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jIVZmVlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 116598353F; Sat, 24 May 2025 06:25:43 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E71C83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ad5a11c2942so83445166b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060740; x=1748665540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HRcNoDXLuTYbZmaY3+/vpflZ0kc6bF45caM0Sk0OHCo=;
 b=jIVZmVlDjG60cvScsM2daViL0hnEqkzlvWODVnbts1xcgsEPfKpMKdprK8BqdGp6vc
 2BvFZFP1wcA9+wNhe0ffzpWhHKmBkc+vt83evsRmydT37Ou1fMPlrBZbBT3kdkzbGbFc
 Z8edAKM79TMqRjLQHDfU0UOvcGhb7NAq4M1fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060740; x=1748665540;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRcNoDXLuTYbZmaY3+/vpflZ0kc6bF45caM0Sk0OHCo=;
 b=vmnTi85AjJl3kHH/pNBBVz7jKa07/3B1YIbkE3IJHH9XxBIgDPc8rftO/n66VcZm+y
 k/VM2GGXvOcyQsphM5gzstQNDBB5B1i8Aip/T/fneXgztGm4FxZvw+2LKbJsIKS1rQf5
 cEt4h46A073ryXHxQ20etZngFqWG0npXXogS1lzDYDcT0s+KcubZ6SrH6MGURriWRWGs
 tvee6GpEs/rPDU4JcVvc205e9C/zUlH1J0VgEcB2eVvrO4cSR4LqPfgX0JUbv+7uvL3+
 d0/xLQSU0zAT0/td3y1V0qOPk42eeRbbvp/Wio89xGeU0TYQB0FGgYS4hIw5X4K0BC1M
 Fpvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjybOIpCFeV74I/Zo/UcSNJ2ngNy8XLZwOfH550lqANZAT4yHJsIjunbXzroFoLRsUnNwj/Io=@lists.denx.de
X-Gm-Message-State: AOJu0YwSNsofKDQ8OgHDdR+Z9f9V3yu9nSj+UrOrzfv7I7DT9TQK7dHY
 RzGgsAjmqj3UvZr2uEChZK3dPZLJZnjCYMMcXzBbJppUm7XdxCgJov7OfvAg/j90rh/2ENdpV2J
 ElqmH8wRqWnkAqNOOyXbJcVxh5IrZSgFN17KWUQQV1XYmbbgp9gWGVFFA
X-Gm-Gg: ASbGnctsZpnkELA6AMdMHxv4sgkiwrjy6QrbIXNvmXfqX2GxvAicMprSDTX4e0Ce/F2
 a8brq0X9xNrOrjy4yRp1vqtp+DUP0qWw/ynY/7y+evRX/6oT8nax+eEljVd8BDv8iZduSBxFSD/
 DEnThrzTVeSwWEkZjZBmSZNEMVaLIHkkvQ9NNsfLremg==
X-Google-Smtp-Source: AGHT+IFTpxtzeJ5YdTfoH2CDyvEsyWMOnuYuz0U3NaAQnbNRmOl4MLQ+ynCbWX0XqfbzcGILPYsLc74sg5JltE/2w/0=
X-Received: by 2002:a17:907:26c9:b0:ad2:52c3:2083 with SMTP id
 a640c23a62f3a-ad85b0fa46dmr100992866b.28.1748060739925; Fri, 23 May 2025
 21:25:39 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:25:38 -0400
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:25:38 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-8-sjg@chromium.org>
References: <20250508072907.207175-8-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:25:38 -0400
X-Google-Sender-Auth: 1Hynubk3CS5LFGJGfqjcLIxQKak
X-Gm-Features: AX0GCFu6-sEEteiqi3cgqGnXm3QZI01PQsMswSA_qBZxDCpl1hGsRgfh-oUujfU
Message-ID: <CAFLszTjFxW0eA-_y_nkWbm_4UXwRbH6TcDx2R9rDjx=ZUTJeLQ@mail.gmail.com>
Subject: Re: [PATCH 07/20] patman: Correct use of str in code
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

Since str() is a reserved function we should not use it as a variable.
Fix this in the send module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/send.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
