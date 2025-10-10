Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0D2CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FAC84051;
	Fri, 10 Oct 2025 18:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dOiv2ly3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1827B84248; Fri, 10 Oct 2025 18:14:46 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2340184248
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7bd8909c682so1432256a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 09:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760112882; x=1760717682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyYY1wbvSXokmmlaejgLiLbVOk0x78wiGrtjpnXZzyo=;
 b=dOiv2ly3lEukv1rWFU1SZNh9ym+L76q8HsR98PzEUVjh4ukn5/QAJcFnNSd+vS63Ck
 FqVOnBsh1wjp1xLjHijSmyI2q8/FqhLyl6vpPWll+u2a/ZTNaqc3vFbEKb9k7A1uZKw2
 CYpyzGgAnY0CEr2atMPQaU4IH91qI7hCC/mj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760112882; x=1760717682;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyYY1wbvSXokmmlaejgLiLbVOk0x78wiGrtjpnXZzyo=;
 b=tjNb4Irs0bTN4Au4aN3TKS21+DBr+O3nluflRmD5oMgSrfTPqJolBduVnHjwV7DD6D
 k+/3vZdFULBFzxWQtB6eLqvosnFsMIIVAhUmglkD9Hnfy1ZB281wK2NTt1WA+rdwTLqV
 PrEV9WIGqqt6NWwKJpMiKo9tAegfj+sL4NYZHAnaRL6DQhD2cwCrWmPnPMtFLx3hvmql
 zb1S1/U7ADS6I7wC5jXsdj7DYQH/C27oSd3w4NWd1mwSKw8d1YMs0bfvsr3//Qk7cPcn
 OqPnT57G2vG4iNpV/bmyaB2mRSSwmoWoGC5seaLs5few9gKMjR/jkIpGHa8ibZnjNJpp
 wQ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiy3BqrpLoqBVkWU4B8NPsd0y9tz6HAON95HwlT6d5jf817cvpImd+zOtMUAbUZ3IF960h99I=@lists.denx.de
X-Gm-Message-State: AOJu0YwMRauoHT1A5rC3N+SIqiU5wCqP8CLE6o5jYwOMN4NPtpPga2GT
 EyOBsSkJVraBu2qTqUruFnQ/5wwLz3ZT9uEWDP1ELpwmhzSgyTQo/UxosE2hcUqQbed/19DEU7y
 ZyL6e7rk=
X-Gm-Gg: ASbGnctojgzLHpdsh8x56tPdu/I0cauycQN3LlGmwtwwJhgbCoJkvk9rG1tiooo9cbh
 n8Cr3BvjprIsB8I4i/+8n6sXZImnTgLJsNmVPpBgyKrDLva7afmizwVS7IvTbTIMMXdUHtMRHOZ
 RPdYRfBdn2nHYcplXH6ROXlNHQrqAyWS8D/WvLY7D2eXlZIKmqrGKYTSufzUb9NOj8ErhfnfUgp
 LjxRUw68boHcjMzYz5pPPiHhCpdJkRv9aWqo9XOUBfId5bEGw/QRroHzO8y7d2peyDEexJqgcbi
 PctGZh2OeHqljlbKMXrpLjoS4FQYjbPpRk3howoCdhofrOeITRv5G3pxINNzLBUSVYDQEI7VhzV
 xJahUk2qOEeEhrSaUoJWQUixH3MdO8qLoncGgz7xI6PR9FA2VeWVM6YRn4/QyHrd8bWLWkQP7qK
 RZQtc=
X-Google-Smtp-Source: AGHT+IGyg7xqrzPjSIKBKg1YUa8KrMMBlbHMaK19x6ASgkP3I9hF39kTmQ3aV+A2XB4J5kv4DsZOOw==
X-Received: by 2002:a05:6808:350b:b0:441:8f74:f29 with SMTP id
 5614622812f47-4418f741f53mr3208370b6e.67.1760112881857; 
 Fri, 10 Oct 2025 09:14:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889cb7dsm716496b6e.8.2025.10.10.09.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 09:14:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <CAOf5uwkie65Tsfnmg_5suGzfMZCM0usPEkjDyQkjcS_aDcobZw@mail.gmail.com>
References: <CAOf5uwkie65Tsfnmg_5suGzfMZCM0usPEkjDyQkjcS_aDcobZw@mail.gmail.com>
Subject: Re: Pull request for uboot-nand-05102025
Message-Id: <176011288116.1158309.3128614917340127104.b4-ty@konsulko.com>
Date: Fri, 10 Oct 2025 10:14:41 -0600
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

On Fri, 10 Oct 2025 07:38:57 +0200, Michael Nazzareno Trimarchi wrote:

> The following changes since commit dc6c80056e21a27e28e1be62ac724302ef526841:
> 
>   global: Add expected space between '#include' and directive
> (2025-10-04 13:31:01 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git uboot-05102025
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


