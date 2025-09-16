Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45676CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D00F8329F;
	Wed, 17 Sep 2025 00:06:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nahRFqzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFF78329F; Wed, 17 Sep 2025 00:06:38 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 649198319C
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-750b77699b4so4649024a34.2
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758060395; x=1758665195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mD3yXKV19PBIJ5d3Wt35cEwBjnZz3kosufvNI5QQoI=;
 b=nahRFqzyDWiMjjIYxsnwj63tjjmaXCuqe58cEGbOVWj1FivM7hohkGxmKoUnNb6YHr
 9wwIp9Cw/XSpwGeKx8jeHgqup+uMIjEieKtC3g4hYXWbCCvqczf2qcnP4tlvP7vLw/P/
 f7xyKnkaV3e2OvZwcD/iBbRlf5mG0BVta4Xv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758060395; x=1758665195;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4mD3yXKV19PBIJ5d3Wt35cEwBjnZz3kosufvNI5QQoI=;
 b=NOqOBivSgWFCzWim66AYQvvUdaVte+glHED8s9Y5XHMlDiokHw1u0dOfskvz2ER5IG
 UELXZQ10Wl24X24InKYF99nOg7dKaY8bwNgzu04JvDj8F+k21paAPXJP2in59gSRyB4U
 NdcZwuQGH+mCaS3QA0yMpj3P0fFPj+GikB6AUv09qzx7zQ4cnDjPNtEBB9EB2t4tXZHM
 VRvxULRKbrUJkUBGXHUGnEW/xKk9JNW7YTdBtAm3jbdWcTKqKGiV5uP//pcGEVowx+T3
 Tq+8MY8ugWmoYhHihGp4N9jU6/YE3JejDKZvsbi+DBI9zktnn264rU00Y0hGPOEZcjYH
 qujA==
X-Gm-Message-State: AOJu0YzRHiJ+bOguxtbkrNh2hN05asT30lR2DkWTUCHDdum6tdFjYHTz
 Ivs6mwy/kL4fgcMNMhvdxrnYg/I2yoLno+i9Ao9PGXT18dmqVzN3Ee4DKrTbz45uTHo=
X-Gm-Gg: ASbGnctso8HRBgO06iEhb5SwXEOVbB29PFiGOAioUol8PzBaeBsT609XPOGioMqkMNV
 QSXHrmCWgByXWoeKOtlPDcdcIzjrU7ykkUjBc8j5L+rToK4hOMrVGTnuOtizvi8xpvlMZSjDjn1
 FUvh+v7kCW3fSbOgUD5fMNYXEXKQPz63+HVkoE55ua2U6hFrSIYIKBNvRGNUwsocZ7xbPWrv6SW
 HABlx6n/BKyHeNphn6/L+D0eGOa+YipW0ZgR8zfeiJRLsuCq37vI8G17ezsHgE5kWVZHKr2cEUm
 13+HEN8Fu7p1Dn1QEviGA4wj/sA5Ga3dzizUrNaW2Az1njIfedEYqBG+m3mB0iV3OAgO+s6nwMo
 1W1sMKBwWYdSUO70RrPLrp4MbQS4LdyBUpRKr3PMYYDiVswrBFqcucN7AM9GF1eLKfw==
X-Google-Smtp-Source: AGHT+IFQSkUzEEokb1dilaCxIOzEdUQq8TLGBOlAbI9bps+WSERnDTRZAOhPIUDr+c6uNlHljjixww==
X-Received: by 2002:a05:6808:2f16:b0:43d:326c:6ebe with SMTP id
 5614622812f47-43d326c7674mr3644355b6e.31.1758060395125; 
 Tue, 16 Sep 2025 15:06:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3500050b6e.20.2025.09.16.15.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 15:06:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, adsp-linux@analog.com
In-Reply-To: <20250905112509.2443775-2-philip@philipmolloy.com>
References: <20250905112509.2443775-1-philip@philipmolloy.com>
 <20250905112509.2443775-2-philip@philipmolloy.com>
Subject: Re: [PATCH 1/1] gpio: adp5588: Add ADP5587 as compatible
Message-Id: <175806039381.649628.16170852399493646335.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 16:06:33 -0600
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

On Fri, 05 Sep 2025 11:25:13 +0000, Philip Molloy wrote:

> The ADP5587 is a simpler version of the ADP5588. The ADP5588 can
> configure two pins, C8 and C9, as GPIOs or light sensors. The ADP5587
> does not include the light sensors.
> 
> 

Applied to u-boot/next, thanks!

[1/1] gpio: adp5588: Add ADP5587 as compatible
      commit: 41d9ac102536a07f8561533873bb8e772e61d54a
-- 
Tom


