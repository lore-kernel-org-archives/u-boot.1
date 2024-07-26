Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B16C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E5E88709;
	Fri, 26 Jul 2024 14:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A663cL2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5031F88700; Fri, 26 Jul 2024 14:59:15 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ABC7881BA
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b79293a858so3137846d6.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998752; x=1722603552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8dbc7GNT+s/vCg9dkilELWQrbSGnSoF57yaaFY7X/p0=;
 b=A663cL2HszgCbf0N3V65+FV8JkfSra2p2KcKXJNkX194PsrF24SV6UEtNnTFaUK+o2
 +yPgvseTH7D/A84Nb9u1k1RBS4kbL5u5Xnii8zY1JNeAp/x8T5vyzo2K5jVoe8tAYdfo
 jttVSd3kzsfjJT9JEMz4hWNihRF7ZydXirB+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998752; x=1722603552;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8dbc7GNT+s/vCg9dkilELWQrbSGnSoF57yaaFY7X/p0=;
 b=Rx7Cy4/dGgzGim3WAUJjwChBAheqjKTQxJWUuDq4V3GcSvpyo1dPaggRVPCQSkty13
 vwKQyTAihPfT+nk740c8tUy54W7Xh+w75dVjlfQ5TY3QS4kMPz+UnK8CaF8zyCzdhZls
 reJ9SJpkOA2y3XgshtFoWLeM5A1T2sLaSguwg0Pz5JFV+nNN3NAodaLjMX73aYIDSq6V
 b8Wc+RSPMDLPN2Gzylsh3kSVsE/eyK9UM7DHGlvf8tDcE+HpQ/LdwTdYAbfYJCjmpeD2
 sfXGtJsms252HWsP6/1peIPdj+4dhuhSS7a4f442b2Cqz5Ys0AhyjS83/QAEmFiqNGLT
 H1rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQj0rP37OnmzS+BDwO+3HO3971m5yyTa2zB15sgQ1r7CrY6OBxxO/x16a1GENQX+Dkswarig20ftSXIEBCoYk8vur7Qg==
X-Gm-Message-State: AOJu0Yz65VrJOpvrA8NC/7/5vTgFjOSS3yJihThdnmeYxod3FCP/iB4H
 /ZcQrML2Nyazxk1DlCpv9JE2W3mxzAVDIWVIwlnssxxPCtK+lj6+t7dmlJ7Xx1y05ecirv9cLO7
 JbUQJi4J69fZiXSQJcxX3xEYun82eHhVZrkSriQiZcP/WK08=
X-Google-Smtp-Source: AGHT+IFOtWgxtw77F1SQckGiDz9OTWISOUJcy18wZHhT8U0zYRVu5+juY0GbXTONEDR/twyZGuCgPZzV+Fav99chF5Y=
X-Received: by 2002:a05:6214:e8f:b0:6b0:63ab:b7ba with SMTP id
 6a1803df08f44-6bb3c9e1baemr76277256d6.15.1721998752199; Fri, 26 Jul 2024
 05:59:12 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:10 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-9-sjg@chromium.org>
References: <20240717155712.2913651-9-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:10 -0700
X-Google-Sender-Auth: g8iArobemKgekocqqTWjYLZeXgA
Message-ID: <CAFLszThqwTyn1DRAB3B+uTPaG1U=o6mF_7o9iGkfOKxxNyY1hQ@mail.gmail.com>
Subject: Re: [PATCH 08/24] qconfig: Move arg checking a little higher
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

Check for scan_source as one of the possible operations for this tool,
moving the check above the scan_source implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
