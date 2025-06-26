Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E42C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 22:17:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C289C82E6A;
	Fri, 27 Jun 2025 00:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LBxd8A+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8482DA1; Fri, 27 Jun 2025 00:16:01 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D027980E9A
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4067106dd56so1003827b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750976149; x=1751580949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwgxZmMzVTWam5WlNvg9nNuKw1Nl5sTJyUPJ04XBHWY=;
 b=LBxd8A+7LWBbiRfsgWMSlHLkqE2jt4CkCOIW8RZ+Rup7hDXtRw4iPgqgnih+QBXQoW
 aJPjmSK6NNvDLOVN0VJJ9xeE2/VBn1y/wvbxWGnjfrNdZAJ5ru5ZIVkz+OL/Wy0RdtBy
 fOhxSXpc+mG77CZpHZg3Sg3ERw5BejiZhCcHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976149; x=1751580949;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwgxZmMzVTWam5WlNvg9nNuKw1Nl5sTJyUPJ04XBHWY=;
 b=dl3u4TobYWNg6s4boP+WSNXCDjEHltEET9TB6BrdkQ3egCFhQqLWqgyhqD0lZCpIaI
 sW0CGRhJQpwyTzNfbQc3h9CfNw6nmRkBEKdNT+4dAV0Himkf33SpgItB2Il0Fh+UVRyM
 hX9i2gxF5JwrucQ7QHha8lsTXKU72IAI5+TofUbsMB80fKjFAD3x46KZEKfcjUcd1tnr
 VjxmILwe+HhQF0FriZCXdD6Fubfb1JmxnJgYIpS2Ay0SIN/ZCHXh4Q8G0dVY5YFlHFm/
 r6xr3RTKZHnCopdpZQ4f+FLUTnYntTASvHJAJd54gF2EFLaeF/NIwHv+dDefGPUymoyq
 1bvQ==
X-Gm-Message-State: AOJu0Yz0fbkd8FN4xvvhfiCIsC4hqSU+oJ9ujrnafuW9cXM+v8uFyhcK
 Cx2U0PwyelVNIIf6tXIkDkj7pLkAUbOO7SfVV/S4CuvTbzfRMQWejpk5i6XPmj1AF+c=
X-Gm-Gg: ASbGncu2RcNh+Uy3e6S0+2W0yR0upeQFMGAqMCfTebZgfIhdpcxaAr5II8OcLryej6o
 3QkcT0zRojVTuC6rEkxovNI1THdiDRPwm1K1QOJOBh8rIFrd9+v75a5UPhzhVHU00Wp7TctpmBj
 XztO4wjjG1jhlI6eAQjlqAGRXAXTJ2NvoSz0rnWbclz9wiw2kOtjqkHuFhNRVQlHEMNNeadp2rI
 A+BFXkvdG2m2sV8c8KQ2Duoj8dD7WQrSNrEubrOfdOrrR8hc7wJtLkClcvsAo4LGC85HGH6VkIL
 IUjG3wCHZGs0CydtImgyNPoJlcChFqTp2MTvYfdMCaUSyatIzfCAly3qTQ70WFlPzY+Llj5c+9D
 BidTitXD9VseAfbAcBC1MAQ==
X-Google-Smtp-Source: AGHT+IEfunbGeFFmx1G84ogNxJ/8iJ0fl0ivs0yh+wvM0gejB3vTnaVHIlRXFJjbjHAYCtaXq0o/Hw==
X-Received: by 2002:a05:6808:1914:b0:409:f8e:7282 with SMTP id
 5614622812f47-40b33c47449mr755453b6e.5.1750976149602; 
 Thu, 26 Jun 2025 15:15:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32289ce3sm129676b6e.6.2025.06.26.15.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:15:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Thiery <heiko.thiery@gmail.com>
Cc: Udit Kumar <u-kumar1@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Keerthy <j-keerthy@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Michael Walle <mwalle@kernel.org>, 
 =?utf-8?q?Thomas_Sch=C3=A4fer?= <thomas.schaefer@kontron.com>
In-Reply-To: <20250612115015.266601-1-heiko.thiery@gmail.com>
References: <20250612115015.266601-1-heiko.thiery@gmail.com>
Subject: Re: [PATCH] mach-k3: j722s: enable caches for the SPL stage
Message-Id: <175097614811.1909185.10197993837809441579.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 16:15:48 -0600
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

On Thu, 12 Jun 2025 13:50:15 +0200, Heiko Thiery wrote:

> This is same as done in 27cd65ca1bf1 ("mach-k3: am62ax: enable caches for the SPL stage").
> 
> This is resulting in ~2x speedup in the A53 SPL stage.
> 
> 

Applied to u-boot/next, thanks!

[1/1] mach-k3: j722s: enable caches for the SPL stage
      commit: cf2abe7b1e6d5a2266d14f801d4eb52edec39ed6
-- 
Tom


