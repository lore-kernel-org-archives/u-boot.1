Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C6D109E528
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:07:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C34A840F1;
	Thu, 26 Mar 2026 00:06:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nVhTTKLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE1183F00; Thu, 26 Mar 2026 00:06:07 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D042483FBC
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-467d9ca391cso157372b6e.3
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479961; x=1775084761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=burDVnk4VhsoDeDX2bLEpqoj7LoMMJ62EfDOk7TeMkA=;
 b=nVhTTKLhH3AuFfY7uJBrlljMJZT7v9nKHRnCAqYG6Vdp0OID7OK1dS1BkqVSPIIcNE
 aI6r2cW4FJ+bynx0q1LewxLZd/1qsODwrwMo5P7GlAJJYPbMWZ2aiem6gqDW/l3EFzEk
 GOmx2tvG1SfvadWl7UcZu5jawjznrgPF/TSbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479961; x=1775084761;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=burDVnk4VhsoDeDX2bLEpqoj7LoMMJ62EfDOk7TeMkA=;
 b=eW6uvr/kyUjR8tNyBJixXQiwqPLWbOx2OnKmVnNvEYmOnkzF9J45wixHZehAYWyXwp
 P44iqF/umHs8PDjY+V1ocl9sfplkjmi5rD/MUnWwY6h/y5PDkbvlWA0YIeC++nSdRmmv
 bN7NlM7zjvNfHz9swNCHVy1w/xYX+0GIECPzSPNupOhKq5TA5bPys0L1N5OwxKhrtKlr
 zP46w2coKwWF+e7UpeX4YWfwZ4foGDvbFW994MupQqVhHkLJego6O32Wkd4bAQ/bryyB
 SCXTw7yRov2IykPIc/d0i52A+akQ4exzwcgIcX3Vb3rS36OPmgBYEUBch/IQ8ubYkMPR
 lmrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvr5HGV1YmKJHAcOhZuAiWTir3+7tolbkjY6lLhB7vHDPeHUP59i5mzLqpRjYeuYT8r+6HPK0=@lists.denx.de
X-Gm-Message-State: AOJu0YzuXrw2344AdDzyNVTOPdqUyJ7Wq4YFPylMirM63fdniO6RjQnr
 cUn0wgpdHIvDj94FEAgosZddQRMsdffxQsO2rCvqXrR73EylyNQ3/SwS3R/3nK4401wg5iFRdxY
 J9SAA2lo=
X-Gm-Gg: ATEYQzw8JzKhF1xpkFtMfNaUhH8wBiAq/+FRwT4aaovPreTF0AOZp5H7y0rMyeKz+ql
 8g9xBLzHfWYCsgIJtsgqhgqcGQXmlTTmz4au/tn0tvWBc8im5Q73J6U4QQiwNCG0Ekn/AnHkY8M
 B2QsaE2xWSDrQ+UuZs56KmjjsLl0GLh0lEF7ynLQ0oSiOcy647ZKBPvjXDq4WG/u/ShpOWCu1uL
 yt37+P0A8RZRsQW6uEn492TlfAEjisqrElmQGRGULfADi343FIN9lq4fuuKHFejAzasCNuQAdRJ
 kGXNFZwMW0idYFwEuA5/m6ia/aBwlrPw0CjsjrpfkWIq+ew8QGviUlZun8kW6YaNWqA2S9OWJ8z
 EDfwyO/hK3xVx1DKmqUmtAj2jgdkU6V1fzhYreZkQOXTUniKXU04nA1kklGOS1p9CXC+As8Z3F4
 PRY7XJi0CDl106rei1PRBDVXcpkG9BSAsE9iC8A45pE02YbfQ4UXFYhOZV69L6FR2UDw+2XyOSt
 d/mZPnx847Qph3d5nXLVEgig5zaAqC3e4dvRRH94M6L6KI=
X-Received: by 2002:a05:6808:1907:b0:467:3f4:9077 with SMTP id
 5614622812f47-46a5c836ea2mr2705136b6e.51.1774479961263; 
 Wed, 25 Mar 2026 16:06:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:06:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
References: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
Subject: Re: [PATCH 0/3] test/py: gpio: cleanups and improvement
Message-Id: <177447996005.3508238.12060287195076267193.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:06:00 -0600
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

On Thu, 12 Mar 2026 15:33:38 -0500, David Lechner wrote:

> I wanted to do some quick tests to make sure gpios were working without
> having to dig out a schematic. Which means I didn't want to set any GPIO
> as an output first without checking. So the main point here is the last
> patch which allows gpio_op_pin to be optional and skip the test instead
> of failing with exception. This works similar to several other config
> options that are already optional in this module.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] test/py: gpio: remove unused imports
      commit: b02b0a0c6cb1b977718d05182ac492f04c996561
[2/3] test/py: gpio: removing trailing semicolons
      commit: 908db6c647ce1cf265f0bafd98578ad903c16a04
[3/3] test/py: gpio: allow omitting gpio_op_pin
      commit: 0f101dac8fb6792f981c78ccd7a284e553ce5764
-- 
Tom


