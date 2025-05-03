Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0905C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 21:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A1E82935;
	Sat,  3 May 2025 23:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R5OduLx4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3E780EE5; Sat,  3 May 2025 23:26:42 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64E18219D
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 23:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb12so5072968a12.1
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746307600; x=1746912400; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=69QXLQ0TxCbHi+bGHTCRt5Ss9S5Fc001I8yOseqUpSk=;
 b=R5OduLx4fJNJ0cxrukr3zF3/Ic2/YX7qAFMb8GzBDn6cIO6sZZNstMd9jiuY6M2ul5
 f5fIT/I+oM7rWgDsauOSq6IJV9U8fedmmHWK8UTuCap+AuMlsCpa4WJ2GJexmUJYbee2
 uBtTzx8N/VTr5n46ULHfrfD4i3TqXd7akrlzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746307600; x=1746912400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=69QXLQ0TxCbHi+bGHTCRt5Ss9S5Fc001I8yOseqUpSk=;
 b=cMO+EDd0y0VK5seTQI8H0jF7xd27TeAgWl+KMlALPK+q5CTEqWRaXaTtzJx+BhP/Bv
 oROdmu7mcwjH5SVhBR8h2S7louR+Ch+uNl6yxK46n8VzxMD/rQAk40k2hGeEwFzD+8Np
 zKAuD31xxl/gcEWtDmRz4RngY2qSzyOMriHS1a4mYOxRj5UDNG5h63papLGl1dE+sze7
 sAuqx6oBba5Yd7VVPVaisEBXHgruPZ5ICTHcolERAx0y+baByUHtgqPF2J1d5z6TqSdJ
 iePqIYhpePPcFIBaA5ZGSBzR+8rXQCesAYBcKC63qtFU9D+NFamnF4i9rEbQ35ysIQ0r
 E5Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdKK0dzHe7wVAdQ5GZDyJ8bNkf/lq3WusNsOjt4BuU7zrbWCLPFWJWvkhHcArUGtym7UaBPUo=@lists.denx.de
X-Gm-Message-State: AOJu0Yybc3NQXUjvtBy+VdkB7GIEqALqvmN6jFidZsbgFjuqSIDPRrwT
 b8cU2d4rE+ImWKJgWY0nC4sx/JO54sOfg1ZUl9E8bi6WFaSsinPtI50pSKE9UPxyvAkhDDT6IZh
 XitFiBAr/H3bnzhbp6h5Q9ekSYGeTr1JPz1qMIIcnA+0c5CULWg==
X-Gm-Gg: ASbGnctXwwOV9x+OeQJ6uBJpnBxvRFGvooyaQyKtqMTJfdLwmZSG7yAbXpWqUQdL6VN
 7o6xdK0NRxXYJ08tXfPtNcnBe5PHQ44UV79EQjF7kGJ7vJpvRI9XwBjLM+Bb1zwRgyQez0/vV4G
 DHzwR37yp04XeuTjcJOWC+Hu4cVOz1gyaJcCnMKz7M0QkkI1l8yUgZOOI=
X-Google-Smtp-Source: AGHT+IHUMFeDnX1YT8+Hg9Ts6WIWs1KYKGKXufwwsc7XEfBSPtm/7r+yYEJWqr85VmwmmQCmzxD4GS7ET87L6R44gUI=
X-Received: by 2002:a05:6402:4406:b0:5f6:23b1:ab4b with SMTP id
 4fb4d7f45d1cf-5fab05dff85mr1873048a12.30.1746307600174; Sat, 03 May 2025
 14:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250503101424.48236-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250503101424.48236-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 May 2025 15:26:22 -0600
X-Gm-Features: ATxdqUGTprzDI42RX1OYydT8eJyd-wm24rbdqskzAGw3UDFo_XY-_3vPpyU5O7Q
Message-ID: <CAFLszTjCx7dhKCAokHhQPKu4BVm8ArodrRfw0mTKTQmcS5gFTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: describe u-boot-test-release
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Sat, 3 May 2025 at 04:14, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The scripts u-boot-test-release is called at the end of testing.
> Describe it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/develop/py_testing.rst | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
