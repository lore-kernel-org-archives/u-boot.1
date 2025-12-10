Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2FBD3E77E
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 20:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CC483CAA;
	Wed, 10 Dec 2025 21:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fVWTbipm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D8A83CD2; Wed, 10 Dec 2025 21:45:27 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9147983A26
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso166398fac.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765399523; x=1766004323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fay5/QCHOKaqJdvWzqd0h6KAAWz8VCX3tCx+I3tneA4=;
 b=fVWTbipmPAO7Sms2Apj7GcbsAtMoTTMkrSm2OF233+79gav91iWaIdxyLN5q27M8yH
 uEyBh5Qwb1+0MerWYjoFytHSwa/uEqkUwj9OQTa4bTGaw9uj9PG8nES8acYiiNpaxnNW
 M5e/Rrf6Xvlfhg7up3+DzlhVbLh7EMLxegBig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765399523; x=1766004323;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fay5/QCHOKaqJdvWzqd0h6KAAWz8VCX3tCx+I3tneA4=;
 b=svH/Q0Ot0L44v3ZXVg4VduArOB8OdP3+ntwUj5y9oGkBAq11180I+HT/PfKz9fI2J+
 we4PvT1dIdq0agLfLbLHHokDvUHy6WeBT35S6eNx33dFikGLw5Xon392nIEsLIl0cc6t
 EqtyptoYh/2q+1J7YEmasS5Bln+DMXJ6qHKFsxMa7ZU+T6mIaHhsAfZYAh3PNToEpbix
 Env7FUSwq/GYXSxQoppIEryR2Tn5lQhGhbopAOs7dawoOfbLKF45Vbsrr0bKE6jbyHAv
 aaEIedpAav3Lj3fD8j3JW6enIozOyTNiVPeH0pDlmJP6FuXC376LL9DY9LkmjQeUCkyR
 VYqg==
X-Gm-Message-State: AOJu0Yw1Aqv18S1Wx88KYkRgidb6VINDDkwkik6G1Hh1TwtD9TPX7SAM
 r4mP9bwFRNRTG0TjlqskS+blsOalja0G6oWQJoKzGFgBjxJeY1lz6FzBTsEocnH/3vktITc2asO
 dWjUZCRw=
X-Gm-Gg: AY/fxX5aS68vZCv2tc4zJmgsbxBYetSivhKu6BwE4qiEzUEMwRnOOWxIy63c7FpMMuU
 VN845g6dZQKdJNeoToBabzQz/KwlTFIdqpfCCwXMRUFgX2Iwe0cNnzwAurooKYyxdnjECaaX905
 uUuP4gJB5Ps66Cak40gwlksOSTPBViXWxpBrB7fdwGARqDyLLbUsNVmuXj50aoSsA9L7XNd0hsx
 D+UYPAbo8L0zK23yVNJUUrxQ6TqnGxDZ09oGx2Q/jcq60nKeuMpqcDMoNToJfkuWKC+5oMVDvCy
 kJwbi2ffqAS3EbC+TvWOIhob+Ie7KDsXL/hR2FaUjCaZ7zw+GAYDhY5lwIPg95AoUWZ1kfsHfHZ
 R/jv+kivNZjC7q/hNU1fvNM/IE5/SeXSwHbC1W/gRkayMC2zxFsoTbDyX9zb2xG8hBR4u5O9Pcv
 RShjfgLIgyVG9fq4A/rLbiUgRSYzuoyTwzO3QlU9XmSe5YeeOZ
X-Google-Smtp-Source: AGHT+IHbCiHUu6ebju5Zjni9tc2wXW9VxGRhhAhYMCDLQv7QMyIF1/t47rzge4KV1Sj3Khf06ecQMA==
X-Received: by 2002:a05:6870:d205:b0:33f:b3dc:23cf with SMTP id
 586e51a60fabf-3f5bdca73f9mr2306281fac.50.1765399522619; 
 Wed, 10 Dec 2025 12:45:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e70030sm485887fac.6.2025.12.10.12.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:45:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251112211942.1429056-1-trini@konsulko.com>
References: <20251112211942.1429056-1-trini@konsulko.com>
Subject: Re: [PATCH] fs/jffs2: Make depend on !64BIT
Message-Id: <176539952188.3502425.17716436100612180849.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 14:45:21 -0600
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

On Wed, 12 Nov 2025 15:19:42 -0600, Tom Rini wrote:

> Building this code on 64bit platforms leads to warnings (and so errors
> in CI). Rather than rework the code, as this is a deprecated filesystem,
> don't try and disallow building on 64bit hosts.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs/jffs2: Make depend on !64BIT
      commit: 57ff26c4240c5050aa96f8cb2e8aaa6f55d71459
-- 
Tom


