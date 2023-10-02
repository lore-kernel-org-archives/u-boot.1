Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD83E74911
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 18:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAEEA8718A;
	Mon,  2 Oct 2023 20:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HACDFdwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6438712A; Mon,  2 Oct 2023 20:56:52 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B7A87184
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 20:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-991c786369cso6572866b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696273010; x=1696877810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9gE7hA6lp3TqJIlEEjUO3K3frMMsFhISs74OokpoLyY=;
 b=HACDFdwznwCONUFDOVGNOGYrLeRunBBgHntFCoEwK3+jaFjCqZ7FPu4jli4iJ0vXP2
 OdSbs6vu98d9/kco7UTvrTWnxJCuBGh5iOM9wMtrER5pAN2Ha7ZTiGPEBxug8SBPy8YQ
 hZxXuYtJEXi2umjR0e30p1f5N6IiejGEp47Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696273010; x=1696877810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9gE7hA6lp3TqJIlEEjUO3K3frMMsFhISs74OokpoLyY=;
 b=P1EoB1JT5ZfpBZuBwe2de1opzgNZ6CSwjNPd7JAa90TNDgdK+QcbKgdYMrd7pttoeN
 oGL0VaD6MQ5J9SfkATccmkRWpQJON7PSmokCCTAFrfjoNr0fyaGX1Kq9XC7Fd/plD+wE
 baDiqd73SPI+dxw/wTvlTUWYWbKobGnfCtceHdFfhgV8QlxBIpJWIbm+0ZXARofcM8lX
 OgwwcTmhFND7V8Q7CKWz8qYGcBAeWZBdwIGijHcyxnr1HOYyDH4ZVgmA+dCb3fkGkviv
 hywVIg1q3PpoPpgTslxI7HVOQ4ccgD7LR7OizFym3mqABrz4acN2AQYE4J2ornzCboZD
 AIPw==
X-Gm-Message-State: AOJu0YxilaJZbMqpx5IWEc1mApnvPxj+XVFU3D8JKKRk30JVO+KVrJnE
 lZt7BVv/zqlnqLD9/S+nS//096sgMT0cI5pYBhAB3ibzVxI7ShRoMpg=
X-Google-Smtp-Source: AGHT+IH+11sZSZTMVSwK8YjMPpY05HJ3BAVGINyc+U4sUdd1C4lmMhHo0mWMhBet2Dlh4dsJMF8vCiu5poh9kxT3F18=
X-Received: by 2002:a17:907:2722:b0:99d:ddae:f5d4 with SMTP id
 d2-20020a170907272200b0099dddaef5d4mr10801740ejl.44.1696273010249; Mon, 02
 Oct 2023 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002080014.1861669-1-lars@bitbiz.be>
In-Reply-To: <20231002080014.1861669-1-lars@bitbiz.be>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Oct 2023 12:56:24 -0600
Message-ID: <CAPnjgZ07_X5UhPm6dVZV+wfp7qeHV95WVzTv5Y+MJiVj6xZYHg@mail.gmail.com>
Subject: Re: [PATCH 1/2] checkpatch: skip fdtdec_* check for tools
To: lars@bitbiz.be
Cc: u-boot@lists.denx.de
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

On Mon, 2 Oct 2023 at 02:01, Lars Feyaerts <lars@bitbiz.be> wrote:
>
> Have checkpatch.pl skip warnings for use of fdtdec_* functions in
> ooling; livetree isn't used there.
>
> Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
> ---
>
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
