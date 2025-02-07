Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD40C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 19:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0417801BE;
	Fri,  7 Feb 2025 20:13:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sUZv5Dju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E975801BE; Fri,  7 Feb 2025 20:13:22 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101948003E
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 20:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6e9317a2aso301474085a.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738955599; x=1739560399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHVUvddogRX3JotHjj3f23/X7hsmN+59ctn2cvqwbjE=;
 b=sUZv5DjuLxObK+q6VBqsoeiAh345HW9l7vGfQhlPLRYW5y/V4PBM7fEb8SXk1PvQsD
 diKELQXfB1WiA85OyJ/uGD2cnSnJ8Xg98paHAhIrfHyVMu/Y2jDQOhEKBxMkNHs/LEm8
 Wx+8m7b+XO84yAS8TQ2P8SzUiK6gqyIGVQLLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738955599; x=1739560399;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHVUvddogRX3JotHjj3f23/X7hsmN+59ctn2cvqwbjE=;
 b=LSBAIYXqaipn+t/aozdyf75eHE+CYMRfsH1eA4P1oxwzb1QQLMw4vXCCqbps1v6/D/
 ooi8fGN4uPQiYRnB+tBG6DI3XHuMRB/xn4nSAt0Cy5J+VhYTShUWmJEX7XHFmmKINYp8
 8hmHpfYfU3BbvuICXxiW7YrLNnFX/WNPBkpmEdRj+2zfDYqv7KqwkjBJFhuWASoXQnfG
 HoIw+AzCCu6+yi7xEQavJSqXz5KDq4YQRobx3qNsZNDtTHSJEEuU0g6TrrOte6J/4Jsp
 +wib3GyXkeZrn2hBZRlgWanPk3lCbUxshVHn6PqxWIkwhme9hqZqlQuiZlAQORD758kF
 N9Dg==
X-Gm-Message-State: AOJu0Yz4jqCkFA6h+fs5aLEkSUTxlvZqIYTgpl2sPJILlRkygU4qv7zc
 RCWjaQ8o+uWLkZltVr23qA1GW5vtLnXcjZksyC1VpC3ADsBKfj79B+2hjT3Xilk=
X-Gm-Gg: ASbGncuoWLlyXgSU6n3PTgDvcA/xCjo/3c3Q0GIiLqbKop80VwqfNIdOiNV1XH9k06a
 wFBfSNMQfqtzV1BDYWlFbmarqeAat3yYoe/LJ/UAoUZ9NXcr4Mr0Pt11mT5zYOSWiM1Ci6CD92l
 Ovz1dGU8H+ft9SicAK5FSvNHNX7eIx8y87rxiZq+jKwjLV5RhAPGcxkAyCWWy8ONw72z+7lqr/S
 meAprry7eYlIpau10pBrzvOvzh6k/MAmj6wv0NY1Rdpg4t0Q7FGk9rxUSG8algBchsNF0dMvA/t
 L2JfSlWsj/x0sQ==
X-Google-Smtp-Source: AGHT+IHh8NzphR+N61BN2SCkgW5SkEde4H/LCvPmmEBvUEnsbc7Yk8FeVbfGzKAJbIAtY6TBnWlTgA==
X-Received: by 2002:a05:620a:bcb:b0:7b6:fdb9:197e with SMTP id
 af79cd13be357-7c047eb2f1bmr504722785a.8.1738955598819; 
 Fri, 07 Feb 2025 11:13:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c041eb7ceasm222530485a.98.2025.02.07.11.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 11:13:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Heiko Schocher <hs@denx.de>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
In-Reply-To: <20250128135246.74838-1-hs@denx.de>
References: <20250128135246.74838-1-hs@denx.de>
Subject: Re: [PATCH v4 0/2] led: add function naming option from linux
Message-Id: <173895559685.3173139.14880472509057875794.b4-ty@konsulko.com>
Date: Fri, 07 Feb 2025 13:13:16 -0600
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

On Tue, 28 Jan 2025 14:52:44 +0100, Heiko Schocher wrote:

> in linux we have the option to create the name of a led
> optionally through the following properties:
> 
> - function
> - color
> - function-enumerator
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


