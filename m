Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F97CCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9919D84099;
	Mon, 11 May 2026 15:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GJ740ziG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF40583F14; Mon, 11 May 2026 15:08:33 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249D0800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so712593166b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778504911; cv=none;
 d=google.com; s=arc-20240605;
 b=gYGfY9EPUSB6FwUqD4wOaSGMrQMS80jwndSBlFuUgg0RP/3WnILMlwnb9rJkn5utSc
 O9oiOCPFfx1GzIj8RCRBLKZvJLUFWXSfJez4wnKr/OklDJn5WpIiTMFYs6QPQjXHohYH
 KZqg5ARZOgGz2bJtR+09e6c+BtpposSr6t39ErNlo0eALc4OC6VYpXk2dxODnNpMblew
 PtfB+7USV/RI6p53j9y9tje6krHUlEi1HoXfH1AhntA94848Ce3ScHmY8n76fo5b8A0L
 OgbSywqKjhN6v1Xlydvy1DgWO3NJE6pLW2+5rJCehAACM0BAQbnj9Qy2KrN+U+rUuVHi
 DOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QW3zQECjuykThUsAwCt27hKCvgw6z91tFFaKuZDpXGY=;
 fh=DHWba/x7tuoorNirX1jlfatUYioWd7qRviNee1YRGB0=;
 b=jTq3ZETqYuhMi9XoJhLNhNQRrd4hNRLh0BxnvUgOPTLgmQ9+MjH5XOl9FcUpu0XfF2
 gEnl2Cbu9EJ6K+TnS5TXGPb60PnZoB5YahNAUO9lAZMpwmcX95aR0F0DqQ8FCKCmRUB5
 MN5b1gKQZrRBpA64JqFQSltOMV2g+gNcT8L8wrX9mLiwNYvZvpnuu8SN28liCiQvWpkX
 AI9sQfom2NxgyfnUgHoCKTyAsp71B/EHcRyYZPJ3CIEfx02YdgC9eYxThpeJD2/SK2ZU
 K0Df1/l5bGBv0BHiX6TX2u2ynep9TcFw6Eo7QSdyU+9NKd1AF8z+GzzLCmcTOzXj+ZVu
 /4lA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778504911; x=1779109711; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QW3zQECjuykThUsAwCt27hKCvgw6z91tFFaKuZDpXGY=;
 b=GJ740ziGnQtPumJlzlZptWBjUgeEw/RU9kxn8dExnD2bJ09MDvqXNklV4/c290Y6bO
 hk4ylNRkUigpN6QBwodJALmXZ8lNPbDAstzMYqkB9eVK2q8aVELwJxTdWjULgsdYqsRH
 EzgYulbzjDa9WRJwFY3i/rCdKOrrSvqUduhe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504911; x=1779109711;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QW3zQECjuykThUsAwCt27hKCvgw6z91tFFaKuZDpXGY=;
 b=L+o0g6BS/SzOd+5J5UjT2CPevB37ed9GIvAqu1g1sKG28cDeGCN0QQ3zkyXIXYQ2+b
 RXCXSVF/PxryDd/LinyDgIj9pTk0ZWlQo+9YDLaTkEb88Ro69DJHrQCS2iGzuhiS5+x8
 upXzdCd+QufQERd1fYM3LWO/DZqhgbiRiJILSY+mSObxvdXC2iGlYodtMGDryqDR6/W3
 Fg09pgWGk/dJ7uX9WpkIjyYk09aPdW8sXPILOOFHHjEC8SdElFOhKqk1XGc048A6JjVw
 APM08Y6unzXMYGY01lG0HuIZcU4oUls9XGl3qmf5lx2LPYAF4Esbn4mHUK7iaaQVOv8D
 fRlw==
X-Gm-Message-State: AOJu0YwVJ0mD83RKzB6KASMvrk1BfZMFr5e0Kw2ehwaWDjjsPrHRIcJp
 wVHcJHe7R1kUYlnZ8X3BKqJHqDp6+ejABB0C591wIajAYGW/1z2pDKpDHbNDSBnrJrJveSF1Caj
 Eb5FJVAeimqKM3vDuCG4KTf/SqZkR4LXJptlYNH1O
X-Gm-Gg: Acq92OHAlqGZMrpfdIOnSH6LDHl78KOc1pctNfwGNA/Wb1PoS65+S5JAC2G0JO1cDdS
 di66jkR2UBxO9NpMU08UKmTu2pJPbB7ulUcZYWoyHdwpG5P9KYad32/SsaQhq68rXecEZmJzFBG
 DaHF4CVmQK2mtCFvUmqCGbDs8+YvJhwRq4XvExS4vYuY0vEEIRrIxHgFGdQM8HGo23P+F/5TmmS
 mC3IPVSk+EGhoac2t3LxLmASM4rACrApT+OrOoLdCB20Z4FA9TlWRIriG4lPUYbZn1E5XRQz7Rv
 WNYEg98LtGnucWhu
X-Received: by 2002:a17:907:2683:b0:bc5:1329:a1c8 with SMTP id
 a640c23a62f3a-bc56cd305ccmr1432641566b.31.1778504911474; Mon, 11 May 2026
 06:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-4-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:07:58 -0600
X-Gm-Features: AVHnY4JH0la4b-6W_CX31hUAqW9VQi8KCLkmA6CZ64gEag2iwdpU7nc0bKWP3C4
Message-ID: <CAFLszThrvykd2S0QUz2ZOvb9iYQ+NuDxd=Gwj9FtAWLNmw=8yA@mail.gmail.com>
Subject: Re: [PATCH 04/11] video: console: normal: Staticize and constify
 driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: console: normal: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>
> drivers/video/console_normal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
