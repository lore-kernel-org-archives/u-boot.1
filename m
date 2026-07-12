Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EBEC44501
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7658490A;
	Sun, 12 Jul 2026 20:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n2D18oz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6526284A0B; Sun, 12 Jul 2026 20:30:02 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC4184852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso5359779a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 11:29:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783880999; cv=none;
 d=google.com; s=arc-20260327;
 b=QTqSHsxoqjHecxT5MFAQC3OkUNn5AqAeaMYQkGGrSSz6QfQf2WkqXfONK+a/zKGbci
 nmTMYKEfnTu/2IY1YaexayvYRfX97kCfZN68E1XlEHkAZhBMO64P3nR9OGoEefy0h1oZ
 YaBI3JegW9SACMIKA110EbKG83+Q3RHck7lS2ZwTIsHxuIb+jWFOq3w4Eu9Lfc4VcvBD
 ZDvsQtbyDHsrAVwl4X93HDxsuqDrMu+kNu4YKtAC3ugNBoxIlWXTMF0TV9ngnkEEAGZl
 dB3Zuz3FhKnT7QdIQjVBf06InJnxHOEBM87iNNymUtoqeT9oxmBcq/kNosy4jM00WeI1
 OAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9hjGB28dcWKaAn8LTSgAkqrGpKloo9XgIywalVaOEFM=;
 fh=b2dw2sP0xL0jj44XDLzDpQNb2LOkvh3JKsgs1MaWELM=;
 b=olMTjpoQM9zVk+SGgzlEc5IRrNUxeaRnTyA80q2NMRgsqsbtLS//VVsTuYWbEGxPvl
 NzLC6eZWmbYNxUyh+MRqnNhjabZlrYZkbikC+fqFwGXn8IvHGfZ/dXIuDk2idhRL8ESp
 Ur8w/zvcj64aWThvTm3zbpx9LLY1IWslbWIXBsh+Yq05diVd3EqNxjs1PUfJRg4Mwllw
 0dVpui4X8dRhNmsov0D/utInMfk6bFyswHG5VEo4JlXYHctIagzJk5OKNN5OtNl/GVau
 sS0gLQK8z8WC6eRMv9LTpw8R9LSyBRT1mXab2gkSYDoe6CeIfLZwh3WWRBsLWrRMMhCY
 ytDA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783880999; x=1784485799; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9hjGB28dcWKaAn8LTSgAkqrGpKloo9XgIywalVaOEFM=;
 b=n2D18oz3OBpK6kW4QtMV4A9Te9ybw82XJf5/38R6HzZLBSjWCrWtZN3yejAr9NWt5G
 8nnvIBtgQpG1f5JeQk1DgBE8eKM6nLIKrqN8TRKx06rCazOifwLas2vgifafkumQh1nR
 IYK/uFRnrrRFTCvAibiROcb6B2O3+jx6RJsoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783880999; x=1784485799;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9hjGB28dcWKaAn8LTSgAkqrGpKloo9XgIywalVaOEFM=;
 b=kNzVUBms2wluPDrMLlG6jzHQt6+uNA+Wkw4mNfekO9zlF9Q6uVV2Q3cAce8zNRAFU/
 P1FmQCVmzXgSMg5YKnGPVAxwJes0my9X04ak4CQoFB5OuKG5AImMOfHO+pqh6RSmGV9a
 fH8eXHvTrvsI1BqbaaPl1KIqS+3B1vJygVmtq5VPVkPTKmt7q65AxiYKxYVWxDSTt335
 AGEKiEPhXgd7ExzzPMpQBKVeFASO5ebPygtHQ+ELSALZ4G2u1ZZgbkUShCO+tBj3xBPK
 Uh/XQzP1w4zGMkHH2GYfovtBKawVR/AvYyfcQowb7omxHtOEPNP8IZKh+1LNIXWOEbLi
 Jtxw==
X-Gm-Message-State: AOJu0YwcTC1iO+I2QUMCVMCLsxjz5PLFbqv7WAB7gosSa+WG69hH+f4O
 sH1CdMlYJJ6l/UrrYxUVFo4VTyXOtFQODOuCJ9IGAFgf2taP77cOlpxqYbnlPZtpsieWe2kF1XV
 PJ8xPNcXuD9+Ar4o+a6d4Y0UgYA1ZvhE8ClWCg1Dz
X-Gm-Gg: AfdE7clb9r6ITZjhE2wLJCIVXR3hxoyjPnoPGjc1vvHlAFZ9FooPJJyOO2rVU59bkVQ
 EK+er6XMO+4KvIGwHcRpErTh2y6+6BhjUaziTsmJyPremqYjzbDfW0DbJF/6gHk/bfiP6LN4ZfK
 4rk9nIgfgjVYElkCK+6IHGPvZPC70MHXPXcEHMadlKOP+8UuvIz3mf1T8mgXgP7waulgLJj9KOU
 Kz9qaLZOr/akEdIyUGiNxqj6xvS57PfwEweNQckCUzmd8u17AWBPXfvkpBWBkspGLkJG+Q=
X-Received: by 2002:a05:6402:5293:b0:698:1504:bb1e with SMTP id
 4fb4d7f45d1cf-69c5f12ca48mr2434907a12.29.1783880999151; Sun, 12 Jul 2026
 11:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260711133903.106411-1-marex@nabladev.com>
In-Reply-To: <20260711133903.106411-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Jul 2026 12:29:47 -0600
X-Gm-Features: AUfX_mxh1S5XHrOAz5rrggfMJSKowP1Q__1UAwa60jnuXFU86KXK9gt-eo6AR7c
Message-ID: <CAFLszTjc8S-W-AkbmHOFtLYhkvGi6eS6ge6ozZjGw42DtVrLkA@mail.gmail.com>
Subject: Re: [PATCH] cmd: date: Handle -ENOSYS return from dm_rtc_reset()
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, Alexander Feilke <alexander.feilke@ew.tq-group.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
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

On 2026-07-11T13:38:37, Marek Vasut <marex@nabladev.com> wrote:
> cmd: date: Handle -ENOSYS return from dm_rtc_reset()
>
> In case dm_rtc_reset() returns -ENOSYS, it means the .reset callback
> in RTC driver is not implemented, likely because the callback is not
> needed. Handle the -ENOSYS return code as success and proceed, else
> the 'date reset' invocation incorrectly prints a bogus warning:
> "## Failed to set date after RTC reset".
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> cmd/date.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
