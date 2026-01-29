Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5ACD61033
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 17:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47F884067;
	Thu, 29 Jan 2026 18:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NfCqIt6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEBCF84073; Thu, 29 Jan 2026 18:19:03 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DDC184073
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 18:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfd8ca8191so449192a34.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 09:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769707140; x=1770311940; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U+1MDrnbgNgTIsu3qQmA1kWdfDNzyqS8ahZ7wr22Seo=;
 b=NfCqIt6c/RX2KqsC3pYGjtoDBQV4yZyi4rKA3ltWWNsQYPokpQ16Dysw1ITJaut7xY
 fR+a0E9h7GrM7zGcEBpGScj5xZ2ELIrnVkQ8HC6UZBQntOgZSgcS/ot2P+jgeoY34RtA
 +i5eMfJfciNrBVPSfRwzk0/Kqi4jUhMIEVhS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769707140; x=1770311940;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U+1MDrnbgNgTIsu3qQmA1kWdfDNzyqS8ahZ7wr22Seo=;
 b=rIiw14UpHr2NF78xO0eyfGMt3rEwmYaFdZmUftvp7gAQMWtutgXme6a+FLLmm4+SbX
 RJY3Bb6LqEs2tGyHlVvo8wdzesx4qDK35J8IoNJBBu+hJFTEEgvSLCEgvHR0/lanbY/C
 7YLe2eZFAXlP+hkkIoYRaEyR2a5Ge/GCHdU1OJ+mR9O6XyxoFvBM7VAUrSddV0nS6Oku
 Yl+HGSLtRLpu7TWjbTfvyin8koVypAb7wwKIL47z9MdjI2pVeB6nCE8ecOu9qRDm7bHp
 dIpb3BFiRW1jGVg6wX98WT7njYQKui/9RbUTH+jNCzQMPH+RSoY7Cj+p8GFRi671c1qA
 6MUg==
X-Gm-Message-State: AOJu0Yz0AoDe9N84bY+TH8ix4FThVTCNFxzWTH+PZ+e6FI5BqQT/83jn
 9kPZJ2bI0YSRg3Vpf25FbgAO3w0jafTdsEAywQ4RnFUnWhrFqTdO8ev9qb92obFesLF8or9F21Y
 6Dey1X7k=
X-Gm-Gg: AZuq6aJjLxQuCwD2KhH1CuE5Ld//7E6B24Rqbn9+HFd5tm0RpE8VKNhHnowoEEaMwzC
 3Nr4mmXm4WQwzOlM7jb4sYhqSIGWyyBi68Fp6ATE9c1/uI4t0Nm5M43FAzG0XJM5pyqjd9diLZJ
 qTyj42bcSSXeCJbF6jkly3vKVySHQSpR7ROSPQ5ZgiDt6CPnMCMoE4+al6afK9VcJOzjNNOjs0k
 5XeijLKT/pY9BjrUK8xkyOASFidDCoJ0S3s8h8gBlffAqj4XkxAqEPFhIiABogfhH/Heu4twdQS
 M1Pm5LjisLXY5m6B/VRqUiw+iblfSwhfCSSCyK+xf1xWHqHc4wUzW85RlRXCdUYS3GoanO5cBh8
 6U/k9PV8l2+3jxSmb/nk3nvFpt8JPHhwh5cNATo6FTNS1h+UIBObak2jMO/qVyNtJkkok7QGDJb
 4qnzex7/ZQZ9rC+q5/YIspwSOJu3yggseMyZVmN1gKQHva/M0GC2F8QhhaQCivzqnaj08Ub84el
 TE0dc+KMqzbyvba5stwayxwRooyev0HEsD7pd6gI4WE3wsm
X-Received: by 2002:a05:6808:130e:b0:45f:1387:973b with SMTP id
 5614622812f47-45f34b0f786mr155003b6e.6.1769707139955; 
 Thu, 29 Jan 2026 09:18:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08d894f5sm3413822b6e.5.2026.01.29.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:18:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kaustabh Chakraborty <kauschluss@disroot.org>
In-Reply-To: <20260124-dts-exynos-vendor-v2-1-89eb2866d43a@disroot.org>
References: <20260124-dts-exynos-vendor-v2-1-89eb2866d43a@disroot.org>
Subject: Re: [PATCH v2] dts: add Exynos vendor support for OF_UPSTREAM_VENDOR
Message-Id: <176970713909.2054445.15186258563030519767.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 11:18:59 -0600
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

On Sat, 24 Jan 2026 22:28:24 +0530, Kaustabh Chakraborty wrote:

> When building Exynos boards, configure OF_UPSTREAM_VENDOR to build all
> device trees in:
>  - "samsung/" for 32-bit ARM platforms.
>  - "exynos/" for 64-bit ARM platforms.
> 
> 

Applied to u-boot/master, thanks!

[1/1] dts: add Exynos vendor support for OF_UPSTREAM_VENDOR
      commit: 7c612df6a4007e3545c33c020210df61826b8788
-- 
Tom


