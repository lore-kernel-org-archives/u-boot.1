Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33887C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44ECD8770C;
	Sun,  3 Dec 2023 18:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="br/YJUfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D73608753C; Sun,  3 Dec 2023 18:44:52 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01CA876DA
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a196f84d217so353955666b.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625489; x=1702230289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3fj9Bgvhp8D8wOmvX0U7r1j34Tz5873QvoWfLyZNLZo=;
 b=br/YJUfqYZhuPQchTBLQIbvwtNnPM3B46b5RdqSAjdgR2YFBpXAK+nyFPNFC5OREQv
 a+75NwW2EYO/HV85wGIsgxkJ0Lzab4l3w1mqGzDot0sK1tqM6a2DvQ+iRqv0YNszbBL7
 iSyJVASOU8c0sLDKwk8+yR23nyaDFkBRSCOiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625489; x=1702230289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3fj9Bgvhp8D8wOmvX0U7r1j34Tz5873QvoWfLyZNLZo=;
 b=Dq6mQcTbK086PlW9MBvAQlX2WkygJ7RpVlu7nZZDIGKGT+LhSzULrCei4VAWzejWj6
 8Eo1IbDNhGcZGQTX57nB7hvJ6S3HbJkiMyekQhZOpB/5GY4ONyyvL863Gujt1vf55kK4
 uS1EbO7a2PYvxz8sMJwFUBWdjvj93CjjRbPMNyKaXI3A8JMvJK+4s9AE31lu+8eydHuE
 pvwpdghPmRup0L8OBrogAJT7pbdQKMvslfULbJU2MnWDaUimcXi/Yey9CPhBFMauTi6b
 W8XIDpJiIckhb1hzzdL04tj27+Eew4FmX42MVK+CT0OM9UItEaeYQ2UBtXJqNHq+hhSb
 AaQw==
X-Gm-Message-State: AOJu0YyvoIhLcz0DmxcJjKH/g/OGX2ZAdSDOas6goeeKD2g0oO1EZSUo
 w6ALyP75HDrk5hkGM7T+ONi7ArongqP6oY8R3Znou2BOGcd1arpYTTPC0w==
X-Google-Smtp-Source: AGHT+IGRPrA+EgjxNWwSsVABE59OrqE4V2yId0l8SrWo8qT6pgUFx2O4yOLMzdW2MFw3EM9NtR4vRRXqofK+XwCncC8=
X-Received: by 2002:a17:906:7395:b0:a19:a1ba:8cd9 with SMTP id
 f21-20020a170906739500b00a19a1ba8cd9mr2488103ejl.119.1701625489172; Sun, 03
 Dec 2023 09:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
 <20231202205255.169670-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231202205255.169670-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:27 -0700
Message-ID: <CAPnjgZ0zyLv1BymKxYtR29k1C-N228KJQk+F6_BG2Wouqj0Qfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] command: Move command completion temporary buffer to
 stack
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 2 Dec 2023 at 13:53, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The command completion temporary buffer seems to be only
> used by the argv tokenizer, move it to stack. This saves
> 2 kiB from the binary size (depends on configuration) per:
> $ aarch64-linux-gnu-readelf -s u-boot | sort -n -k 3
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  common/command.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
