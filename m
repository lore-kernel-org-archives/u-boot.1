Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB39C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505EF88645;
	Fri, 26 Jul 2024 14:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OebXCHdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9760886FF; Fri, 26 Jul 2024 14:59:12 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C8B885A8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b79c969329so3056976d6.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998749; x=1722603549; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ddwU17NIsUHlzkS3CaSP4Ot7HlT1QyTgMk9LKu8dH8s=;
 b=OebXCHdbbwQFq5Gfg0SSnS29E/XIqufiRpjzYDgii9X69SC0XhC4ZpNzUD+GkCGIj+
 odIcvFWGlh8GTnQIotuY59I8+mHn7eJ2Vzi/0vax+eJQztz2MF3ntjqaqJGp0Ll5UfC8
 sJzflALIE+5Cpi7siTRP9yzv2SPkCHTDGQnNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998749; x=1722603549;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ddwU17NIsUHlzkS3CaSP4Ot7HlT1QyTgMk9LKu8dH8s=;
 b=QEvsB5RsV6VC7dw2t7OoWPt99bMOAkQD/BqPhNvshiRRghvE6va9p7ShwqWdYFFbt1
 HCs93lH55A6e9lAyYP+Sq9PobbJoILThXy6YhbQn6TaGkY1CRi81wCfgwfgmzpkvyO5E
 VbKkwHxya7gG2xiXk9zodTkqppuIMboWj/26sjM9s0WQ2+psS5AipN63OoTiJVqDbATW
 etX4zqkWA3kiJCAh9HXwGFCJpvWk/PYO0E1RuGTHCxIpJHPmFepQ6BgnPcyegzgXK+s7
 U4Pg8ygxfH7GBh7iWWG7UMAOoopdhFnkAixV7lJiEhRKjxV2lWMczCYCi3B2Ji520ttx
 e+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV427wFvgPNuUHF9YIEypYveJrLk8RrRYSVzOZCcwfMGLpxA2Yvn21IgopQ8VJU0dCmIas7zNsIKvpS4ciqu2XIsodI6w==
X-Gm-Message-State: AOJu0Yz3gzmHHgdPc7is3onFWU1Jzu9RbGJy+dQ0Df88NzGA7N4jGjYb
 gbUVL5TkFor6AY+ie7pRTKE8eUb0MvkMohGLJ3/jquhzcqHEPFFxP+6fN6NRYRAtvnaSIQVPbmm
 A9BShWg91Z+Gh0haieThAfTNTzt1gwpewNGIi
X-Google-Smtp-Source: AGHT+IHTE8uUTwXHKlnKCjmNLTuIsDPZeykQDmxERjmNeIje01DXOxgOj/80kb1WHeAwhazG+WsqRgbkwQ+ARoq+oNs=
X-Received: by 2002:a05:6214:f64:b0:6b5:dff6:cac0 with SMTP id
 6a1803df08f44-6bb40827b29mr65594136d6.21.1721998749569; Fri, 26 Jul 2024
 05:59:09 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:07 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-11-sjg@chromium.org>
References: <20240717155712.2913651-11-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:07 -0700
X-Google-Sender-Auth: BZ6KqBFXAghLlH3PEtO5Syk1W_Q
Message-ID: <CAFLszTiATL7HUwRC1HKLEiWyUH93hh4WheaSsto5fNwA1gDAoQ@mail.gmail.com>
Subject: Re: [PATCH 10/24] qconfig: Move getting the colour to where it is
 needed
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

Move this assignment down to just above where it is needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
