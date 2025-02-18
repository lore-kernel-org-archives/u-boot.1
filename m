Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEF7C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 16:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B55880BA8;
	Tue, 18 Feb 2025 17:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOVDhn2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E455480C98; Tue, 18 Feb 2025 17:31:00 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A562780646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 17:30:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220e6028214so97712205ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739896257; x=1740501057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmELqag7UwbzVoRf2ddCAhydLku4fOWsAcEXHIdCzao=;
 b=QOVDhn2u+lqYypnLMYDQSqYq5A5THH3oTH0hyznqko2M+FPi3PhSYAgUCbzRg8qmrC
 G6V4NupARJ42xtd1SVChv+J/vVQua8PBn9BWiYZKGXZuGjYoQBVWWR0rd3HZsu8hI2hx
 AEQml1ajJs0utEh5wLY1S3Tdz7NQJi2SKQ+M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896257; x=1740501057;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmELqag7UwbzVoRf2ddCAhydLku4fOWsAcEXHIdCzao=;
 b=MFl4Hv+1Yu1MPCEkbCIDPkRm+9AoGDy5x4clho9Kxrabra/59wCKHviCXYSenB4TkA
 evxB3nu+uQkYZVu+0t7hvAOzg7toWeWyiqGwpvI0QFbSW+L+APl5oJlbUK/Y23HNVsFo
 QUh/ehZT5cZeyWQS27nTBH884rywZNLi6YKeaXQjeFofVhLNaq0zEeKW2Cx2sn80N3Nk
 Pd3phA6/NL4HEcfQxATQzK3hO4/BZgCjuJ1rdApqt3bdZsjriSxQDFHa2x0MVEd0w5MZ
 EpFRFkt0YTXH01mWYJsYBGAsqbJ1KCgoYTloNpOuwhv3SMQYAeial3tEk8W9c/aazICm
 D2+g==
X-Gm-Message-State: AOJu0Yz5oCA5gAop393BSbnqy4jqQkgEkkYyR4lCUEzEtnGx1g8lUfbw
 7uSRfs5TkIsIZHCz7C9q57RjTB6hWp2q/a65Ki11RIHidxUNH9kVCB8QRXG8TFF8qn1qIVDyNX5
 p
X-Gm-Gg: ASbGncth9G2QMXHEX+KjBYnKi8Rhm5xnxztfAnogsxnayr7keuL2sJJ6Ot/pr12tk+T
 ELHjiYQwYg8XwP4VhnS8jEkutZyXuXLAsggHfA/Pt4dFRKIHqOSsTiw/EJlDunhUAaKn7IaFfr7
 53Ti3SN6oIiWxglGtiSii8tBppyLjNgJb9QdR7ZpyjHm655qgiSE/S0sIWC+3DR2aCi57yXLOEx
 sxzL4nftKg/aMPvJ9lLI4u9J1WAW8Vug9oJSfAxQxVm3eMrG3kOMQ9Er7W+MJlMt8DGTnKb0gUY
 6LSANfn1Gth9
X-Google-Smtp-Source: AGHT+IEZKw1ufgDo5bAKClxtqK2UySisNSd0BRNLtd4VYRuJgtuRvKqCPxy1nWRPE6PV6UxD3lU83g==
X-Received: by 2002:a05:6a20:43a0:b0:1e6:5323:58cb with SMTP id
 adf61e73a8af0-1ee8cb8141amr26920357637.23.1739896257269; 
 Tue, 18 Feb 2025 08:30:57 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7327b465bafsm4398019b3a.51.2025.02.18.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:30:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250206092857.46510-1-ilias.apalodimas@linaro.org>
References: <20250206092857.46510-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tpm: unconstify tpm_tis_chip_data
Message-Id: <173989625645.448390.14820124268799679205.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 10:30:56 -0600
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

On Thu, 06 Feb 2025 11:28:56 +0200, Ilias Apalodimas wrote:

> The struct contains an iomem pointer that we later remap and update.
> Remove const from the struct definition.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


