Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FD2EC1116
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3608482BF2;
	Mon, 23 Feb 2026 18:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lq51QQmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C286A83935; Mon, 23 Feb 2026 18:51:00 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D022E80077
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6580dbdb41eso6038054a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:50:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869058; cv=none;
 d=google.com; s=arc-20240605;
 b=bRaIW9x7yNZeqbH/3Tzne4wrtXksdkZ5C3uDAi596YCGV2a01b77CyhZn5EZBX3hti
 Gk5E5U+xCGsUfRhXNpYXyGqrTYJHLpRXS85sj9u68O7pQJlS4CUAXpkh3joOv9qJL/Mk
 7mUmcX9fVMuXevo3VapQKNTA3tHmV+X9vgVy900MJvk6wWta6h/OBCQAIFk8mYnBE7aY
 eXAbO4T4Se1Wdzk9bFJMq2SewLYaorj750C0wi3uoFzdCfbIOxkQYUEUZrFFt2Nkkb3U
 u7PLAXBeK1sOp94gDO7+4LyrxuYgcmF37JLYlZjyPa635okFio4E9VWYbXd5OFfALxeI
 NcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/fE4Ssv0DP0tb3l52xcaienPjOgkTQq3bz0zZd1R3So=;
 fh=HnsLlpVhzwN7uih7Ak2yI4wYc3mQPSEfV2n79G1UCUM=;
 b=Q6196S64HlLXvWauHYAzXDEYPIurJCSxcC5GJE8UwCZCsAMMJJCR4Ji0XXI+amHftP
 KTRS1XsgW8g8VEIWq4eeJKY6S6tq/xDsk5eZXgXD1bPv3QCke1IyUopRRl8sih9RUslJ
 dLsulYnv9FPacmQuQQOrUfVVaKAAWWr9RE3W5dao7JceuUTYKv6gEg5LAuuNAFTyywj5
 pcAB4q65jcOHVTE1RIYa14dH6yxIStSNYhBz1NhcK84olH0qxty+p/xbr5ymlBw07RwZ
 YxF/g4J9H7hCkPtTH6z1V2NYMJ2QBfKYtYplTI+kLJI/Q27IH54bvuBaMLyf1XYOKPdk
 pxWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869058; x=1772473858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/fE4Ssv0DP0tb3l52xcaienPjOgkTQq3bz0zZd1R3So=;
 b=lq51QQmfFUKq0ZgWYSojcmhh0GKkz3f/QSkvtvlY1GGACCVBQzdsUODSEKxSIrx86H
 ThYD1C5FcGKTsgqXLONv+nMwSeB/8BtFDIz/2qrkFDeOc4ueUIVSskwvLPvIH0T7p4Dq
 vTxX1HprL9t5yhcCN151RTTDTgzSCxC5CHEBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869058; x=1772473858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fE4Ssv0DP0tb3l52xcaienPjOgkTQq3bz0zZd1R3So=;
 b=AVWtSIuhWMe8GjglWgC9ndgWCUKMVHebbGnOowqOVf/EqRqxvkIuoj7SH7tcvVeIsk
 N7fBbQiNs2Kx80nfTjPUA0lwWzTmXfTlaN8gzgVJjUN+FtQJ02nVnnauRoJ2NPmNntQe
 MDRII4YMJBaxqGMf9EIsSMtL3JWUZF/ZIk7FKyzsWgMSLUuMEAjcvwFAMXvyAYOo2e+i
 5s/iiE/az8axjOXtIaJ9ZsC4U/gTyvmQiJmG8JPT3XCLPB/OZZ6j3F40Hngy2FrErY3V
 cXVCJHLHQdM2OWuxRg+G5MdemnOSG4Z44teKYO+JUbAZZIPfcmi1WmSMZrFgzXyPHa59
 Dlmw==
X-Gm-Message-State: AOJu0Ywwvi2wgYjxZeyp4uRyUDKHM5z5+soR0kvOF6tM5I/GDMW2qV5r
 3SCf9VqjEoNyi0nBG2CMuBiqtaPhHaTNrV+vIwZaGb7BBWw6ampHZeHE7+UsLIXLP6FNeZvTXNV
 tIVfzAVdowmfk6otM87TjrNVYv5WnVNKlCu1+dWgK
X-Gm-Gg: ATEYQzyy2KbK9+inYGUTD+e4cJTWsOz/M7rx4IZEkx+cstk+rn+hmK84eCE46wOmv3r
 E2LIXqtSby7AXOYrNcLytJl6HznA6mphd4wgIhd90hxO8lw1hBWk2cxjJ6YjL/OVOOKotGGyQHW
 VHvjf/ae3164uXlHZueXO1qvoY3TbBYMddSSlUPHe7e01Q1qO11V1358m1AetXtyu0MOAkQe0ys
 iAjJrwLHgCnU08TvIoc9z1dciZOY8jrlOpwXikSoeavTOIUr1wZgXRytZmRe7yz6MCql8FG8beh
 HWmb0PhWh5PmECWe
X-Received: by 2002:a05:6402:40c1:b0:65b:9699:7785 with SMTP id
 4fb4d7f45d1cf-65ea4ee7c0bmr5712178a12.10.1771869058258; Mon, 23 Feb 2026
 09:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
 <20260221094252.3103034-3-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260221094252.3103034-3-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:50:45 -0700
X-Gm-Features: AaiRm51ZA5Ss2-eQOfQlbXz6vsdavFcOHhPZum_JVxDdGPLxpT31Scw58i0QcVM
Message-ID: <CAFLszTh_VvaPayYm5dLmYSoO64BEV3ZMjufecc1QchNvus2aXg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] spi: sandbox_spi: support wordlen setup
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

On Sat, 21 Feb 2026 at 02:43, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> The driver currently ignores the word length configuration. Implement
> the set_wordlen operation to store and track the current word length.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>  drivers/spi/sandbox_spi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>

Reviewed-by: Simon Glass <simon.glass@canonical.com>
