Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E93C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 13:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A82B8874C;
	Fri, 26 Jul 2024 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N7PSvVq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 775C0886A0; Fri, 26 Jul 2024 14:59:18 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 683E088570
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-663dd13c0bbso20761827b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998755; x=1722603555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hxwyVVq4rpZDZCxO0ZDnB9eqyihX7dSRdioLF7MADtE=;
 b=N7PSvVq4m29hTlItp8LWMHN982UnfJZMGBdbW94myMH9k1AuNgJ5piVHIafaj7MM2J
 98/Nv2pML4FXsZrWmBZspOe/kFoXaG5/XZp5qJbg7FHP0JrbL/gpumA7hbHY/keWJARX
 qEfvvgUNctVcGx+68gm5AH83WNxIn7+JO1dxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998755; x=1722603555;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxwyVVq4rpZDZCxO0ZDnB9eqyihX7dSRdioLF7MADtE=;
 b=kUQaS0I9NFSTYcB+WNEL6JrLLrliVP3WL1EtMqqcdiQS3nux+PhWhkghotHPeaJkaV
 IFgWq3DpVDeah6d/RGMyWPOPektclaFLCI1XFSbuS38bSAwIJ4lJOc2icOoMxHajoN54
 aQEFh+6vGYdRcMKayoNfYbBvom5+mKx2Nq25acR35M/hubvphBOh7G2oJKGIrG1zxyw2
 n9rtakpwsUw+NqkeAeMnQVW8fhWVxwC4VeHEF2eehxyFtCV4px22e8t884XX5isyNnmf
 6k+2xpMg7QxLKVIrvAaZ6oQvVait81O1xv7O9ypAixiOZxDyyB+GfaMpv3UXWy9uiZeT
 0exQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9WL9npOilth2J8mX51uexPvxjGpM+1J0W3b8EEOFHoMRHp0X5vMsumx0skZJUf5Y61DgHfaQ5YPl1/33gin10ghNgBA==
X-Gm-Message-State: AOJu0Yww68ljOR8FEelmp6SyV0MNmIKPmCh4jiFjBfMhaorEh1eWW6MZ
 rWBEMpPvjexE6HD5EHhTAeA0s5YHcsQg0gOFpa2qJ65M+EdnwoMa7KsLi4ctslZLzjqBrBHwzmW
 GlJBdRLEQuok9AhCJCvAEEx0cIyk3n7ocpq6e
X-Google-Smtp-Source: AGHT+IEtFSHtm5hy/Qn8Y6QrCPXrz+LIBB4NJVsvGX5N/jFGzzGwOt4UA5w70NbBYpgnxfMU07ythvw8jO0lLdQ01YQ=
X-Received: by 2002:a81:844c:0:b0:632:7161:d16c with SMTP id
 00721157ae682-67514c47c13mr64346067b3.28.1721998755305; Fri, 26 Jul 2024
 05:59:15 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:59:12 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-6-sjg@chromium.org>
References: <20240717155712.2913651-6-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:59:12 -0700
X-Google-Sender-Auth: 6hUlyD-JUP2TxRPLCxWWKZHI5hk
Message-ID: <CAFLszTjSHqrHsEoYaH7cPU-rptTLYU3QQZ-yx=nFhtDyDLtZZg@mail.gmail.com>
Subject: Re: [PATCH 05/24] qconfig: Correct format string in do_imply_config()
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

One of the strings was converted incorrectly. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 1bd43060b3e ("moveconfig: Use f strings where possible")
---

 tools/qconfig.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
