Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BEDC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF85878CF;
	Wed, 13 Dec 2023 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S4wjWARe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF0DD8788E; Wed, 13 Dec 2023 21:39:27 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB3C8787A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a22f59c6af8so170693266b.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499965; x=1703104765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8RFdl2I9rMPjDvKU5JlfeNKvtWG1I+DbYDHqOUCceBs=;
 b=S4wjWARebWjMcBDJhrtCrnqVWPRnO0JrbXcjdToy0rPnW0QfcRHsb/5LJCZykw9HbP
 rGlnWM6IQOK3bo9zpl8S0N4jknx4z78XVSoAZcZ7dKHMGgANVB0C4HL+LYcsa4MdFaL/
 Nxn34v1ByEGo7YfMn+dpNtTZ/ZDa93fhULA1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499965; x=1703104765;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8RFdl2I9rMPjDvKU5JlfeNKvtWG1I+DbYDHqOUCceBs=;
 b=IxmKYJ/Ib97FZguDTuFRvmWN6134SLhxdPPHV4BlgpXgYA9KMlmaMSzh4G2xGoHHup
 HLLXjky7cn8tr5g+lpk98dOEwVggCUxsMm9Tpo2r3Jf4uW+wXy0H2gzF9o6Wo7MlYXp6
 x5MRUU6Thgpvod+rbhsQowpKJxywKzwhRCoHQWHs/Rg9UL7ZFHCk0NqIkO24hn6dxSd5
 kRBwD3j97EbHAvt2CieWXqPTipc2J5ZKep1PAC2nDFRJmeRNd13nWq/fbJVHJSoJCI7H
 ti3gfa/IbzxzTDCxykDps8nB/F3QU9OARdwD1Puvs/xkweFJXhoNRcH0La0iri/XnITD
 elZw==
X-Gm-Message-State: AOJu0Yxcp6sguowUwSyTUYrcxyQ8wDNJoxAcDyaZ3bASJET9PZHcmXUY
 2aDg2d5yic55u4vwqV2240cAV9KD6rd2+BEJMpO8Ig==
X-Google-Smtp-Source: AGHT+IG9iZIPfDGHwZpJGqynGo5PBajY1dnBsQiuvvY1JA2vGJiUJgp1SLqSG/LETUhYyrI/WPBF3GBKOWf80vPC5a4=
X-Received: by 2002:a17:906:20d8:b0:a19:a19a:ea97 with SMTP id
 c24-20020a17090620d800b00a19a19aea97mr4338296ejc.80.1702499965223; Wed, 13
 Dec 2023 12:39:25 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:23 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231112182248.GE6601@bill-the-cat>
References: <20231112182248.GE6601@bill-the-cat>
 <20231112152754.130399-1-sjg@chromium.org>
 <20231112152754.130399-5-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:23 -0800
X-Google-Sender-Auth: 5c-CqabOMmjfR8Rjzs9mwvzn9jU
Message-ID: <CAPnjgZ0mS-Z8D3XEgrF27X6gC8EFGG-_jHTUkUiMeCzuKAoJPA@mail.gmail.com>
Subject: Re: [PATCH 4/7] fdt: ppc: Drop extra size for ramdisk
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Andy Fleming <afleming@gmail.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Safae Ouajih <souajih@baylibre.com>, Stefan Roese <sr@denx.de>,
 Wolfgang Denk <wd@denx.de>, Simon Glass <sjg@chromium.org>
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

On Sun, Nov 12, 2023 at 08:27:47AM -0700, Simon Glass wrote:

> This code dates from around 2008:
>
>    56844a22b76 powerpc: Fix bootm to boot up again with a Ramdisk
>
> Since then we have added FDT relocation which provides enough space
> for expansion. We have also added all sorts of fixups earlier in
> image_setup_libfdt() which require more space, with ramdisk being the
> least of them.
>
> Therefore this extra hack for ramdisk seems unnecessary. Drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm/next, thanks!
