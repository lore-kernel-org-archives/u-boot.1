Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664A7ECD6C1
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 16:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7147183CBD;
	Wed, 11 Feb 2026 17:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t9Kau3mQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617BD8367F; Wed, 11 Feb 2026 17:19:37 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5007C83A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 17:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfccba483eso2411942a34.0
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770826774; x=1771431574; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgSJ7cAxpQ4W5IkwOtJ9Y398j4KSiMra1OGehnTFeOs=;
 b=t9Kau3mQqWdqPSE5I67so4CNCx/1CUUyickca9xRtRHvtzHfhP/sc9qDOGkgldH+Lq
 3YP04MBgHEl3CMoV8xFrD6RFVhDK4kk0cHXAMg61OQB43xs/vv0UDQ066q97yKP68zUq
 2bokJxKlKKFmIOrPC9IRO+LHdpKes8NKREAAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770826774; x=1771431574;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xgSJ7cAxpQ4W5IkwOtJ9Y398j4KSiMra1OGehnTFeOs=;
 b=qRWcEUkGpuKYW5bTYDhFgYx2tZ6l6dBRmsuUr0kllU1+6ljGtK0gqbbdIe89dfuGG3
 IourRxHN3JSGQENnsGLbnaGK0L1fO+uIMzx/LGMf91Iwj9fzkH202397KnE8jdBtOwvY
 q3fzvq1lFtkXR1Ll/tU/WJf4nkBost5h5FCekOl6z9SazioCdGZL8MjbZ3k94FpNKQOS
 t+yBbJKqs+CNQAmd/lEz0r2eiptcBAwR1AVTRiqrEQ/H2D4XAUS8ke3g2qtGVEz+G3z8
 O3s5nv4Ph+CBzABh3SH+QIqKj2RZcMHvfNWjWrwFoHx4Km2OxjegMz7qcA9xp6YBWXt7
 FafA==
X-Gm-Message-State: AOJu0Yx2QJMAg1LLvUgizRXcCSVUlgCIRb6j7Fv2596+BvooCprTCHNn
 PxE7/HEFJeUO9cOWq+HFXi+OWgD6sschUKbk4fF0BUpV50urlcxJQlUBp/D5skYd9tk=
X-Gm-Gg: AZuq6aKBFRsr0fm2zEOqIAQZUiuutmDwXspdbUbOSxzJ39SlZw9b50cruSX6DVWEFy4
 G6ctLh4satmXeCd6n0zI5oXfncL6kt9DFbHu7Iy8/CffJsWrDl7K7PCQT/6sXgfOKvbtLQ11aZA
 OGi4BC/3gD9lEyRAbb7v5GktI82HdG5vDQ6RjuZOKcrQllBTLt5miv7hu6HyMWdCBrOlQS6ipOI
 /cqko9UTlKu1VEWxCUkpYhV7VAsytf0wMw0pxnxWhLZFxLolHERQgTf15Jgg17C1IyDnWgY3SSv
 SIHWqsqZhGYDVJiR8bTa6OFWOjZx+Vjd2nHCH4r64qG0T0iV5mefNrqwtkVKQqCRt6Jt0NBkPhq
 JmjcTH9uzGTAM/AgfBxZUNTZSsazpbPufru88BogS/SAmG/08fpGwIcHGOHPVXtnEzH1ZLT08DQ
 6rxmxkqqxN3wzvsfScw6F2URFBW0OwfnKMgICubTivn4KS/Ks2beo0p9f2Fu3/wDpbp1Y8NUREu
 Ss2ZPdiVJPQn+0bl9ItHLH3frd5mh7HkBCAaGVocBMsU/Qu5w==
X-Received: by 2002:a05:6830:6993:b0:7d4:5341:475b with SMTP id
 46e09a7af769-7d4998a497cmr3574639a34.22.1770826774013; 
 Wed, 11 Feb 2026 08:19:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a754b4bbsm1514279a34.11.2026.02.11.08.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:19:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Chris Morgan <macroalpha82@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <87ms1fl66o.fsf@kernel.org>
References: <87ms1fl66o.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20260211 into master
Message-Id: <177082677328.1650830.3773599043768106366.b4-ty@konsulko.com>
Date: Wed, 11 Feb 2026 10:19:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 11 Feb 2026 15:13:03 +0100, Mattijs Korpershoek wrote:

> Here is a PR for master
> 
> USB Gadget:
> * dwc3: Support ip and version type
> * dwc3: Increase controller halt timeout
> * dwc3: Don't send unintended link state change
> * dwc3: Improve reset sequence
> * dwc2: Move dr_mode check to bind to support RK3288/RK3506 with
>   2 DWC2 controllers
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


