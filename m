Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E3EC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 17:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9041B82CD5;
	Thu, 19 Jun 2025 19:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0ttwdWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A54C82D83; Thu, 19 Jun 2025 19:04:03 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908FC82C65
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-408fa4be483so640350b6e.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750352639; x=1750957439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=chyKNJGLShtuAHfbP/XPNCSFwqsSuVfY0P6zEYJrYEU=;
 b=t0ttwdWyPsJdWNEEF8eDHYUItpbg2HHNkxY7w3J1bzQW+FNcjKs1RaqsgCJV95F6fY
 3xZOQBViQ1L+046uBCbavSCPnnPp1rqWR/gRstXZGetgjBZZEBUlePiv5mpFNRdc0hpi
 7jYEQvl4xNRGo17SrCruDHKBTvKIvYlcCsCsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750352639; x=1750957439;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chyKNJGLShtuAHfbP/XPNCSFwqsSuVfY0P6zEYJrYEU=;
 b=DsjrIcP8B35TEW+fR9TRRcROS+6QQSFGjUEWGSEypMIhB+DoOlLwlo79d+01AQuJWr
 b7YFBUDkLa0pLAnkMR7TxNpvbXkR9yLY8WMK2cBTjxqfK0smy45rEwxrip5EfpXXGHoF
 yiUZltAyq/ak7rFH7FKrgMVrdSezgcUZrjCOZ3qH6HUcsNfEhFI/7Af2oWEhI9eu15Z3
 fvDR4fTFVSyiMVJ/U6OYiWR1O0+zhteTwdmJx5azgleaP/kinw9P3eecmJ3OMQPS8IPk
 P4IhJ2eYk6jL4AuH+vdc/6MK1V0sVB8M91GiFm070rdforzbT0gGGnWl7u1fojbgKimm
 v2yg==
X-Gm-Message-State: AOJu0Ywf8zPIk/kH7mLOhneKJRi5ZpgpFxjNQo/8n9wcMa/v81yQ3Yv5
 hAEQABlXdrkKfHZU1Ia4imWXlJuM1bLYjiw36so9yt1AHeWxJoEuKUFVJvwyciVypkb9SSYp/tv
 e8MBVqLs=
X-Gm-Gg: ASbGncunkPj8jPNTVDrBN+FkzVGoIR95sCIxr7BUMs7s2SaxHt7FvaVoBa8qI4V8x+s
 xolgOS6dN+RUgP5dBF0KldZbYldYzfahdGwuiUzmjPwGyjAbd5OfzWFpHmt1Xrv6lFJlQx6ugPX
 DJb4foyR4rLpWTXBh9jmbdQF/iciCOvgkH6Nh7+pzzqTF+msDtt9QdlZk9JeXEWu3lNtLhcOeVY
 RYHhRWXf3HMQp6PyX75a0St3G5IBRyAxmOiMrbNiJAkwRSpewMZPb3VeIVCwWNDZ7f/LTRkrHb5
 N4T0GhkvNWsSH5NgxtR2HyWqAlZQVhtVYa//78YAtakAAPJ8sd1mH9JNH6M3j0Q7iyjxCvNL7OF
 PY4TFpVvNSGAXPSqevHkPmA==
X-Google-Smtp-Source: AGHT+IHdtvJPrJosdQYTI+ogtAFaZkSLrY1hG4P8a4ZOkIxfmImsjU00f5z3j4ugh86KsmpR9001bw==
X-Received: by 2002:a05:6808:1a17:b0:407:ab7a:66d8 with SMTP id
 5614622812f47-40a7c0f73b9mr16966141b6e.2.1750352639330; 
 Thu, 19 Jun 2025 10:03:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a741b8837sm2825644b6e.46.2025.06.19.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 10:03:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250618203306.181857-1-marek.vasut+renesas@mailbox.org>
References: <20250618203306.181857-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175035263840.2261309.2434483058453918041.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 11:03:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 18 Jun 2025 22:32:47 +0200, Marek Vasut wrote:

> The following changes since commit 17012e3068d047ad71460f039eeb0c3be63f82a0:
> 
>   Merge tag 'u-boot-dfu-20250616' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2025-06-16 07:53:11 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


