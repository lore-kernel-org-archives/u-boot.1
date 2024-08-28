Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CC8C636F0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A19BC88901;
	Wed, 28 Aug 2024 20:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHWu5P8i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FEBD88916; Wed, 28 Aug 2024 20:26:53 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B591886A7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso31410646d6.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869610; x=1725474410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nm9L3upKuCoVBCm5TAzUoiFRaZrfRLknprEo/V0jCTE=;
 b=XHWu5P8iHSF6hit4p1zt1CSzqPJaexdNCob4gXQNb3uZZhmid+CKlvuqgVIg28KJlc
 x0S/Sag278CGF/w7cEU2E67htoXuVFcdnDZAsiVgk9lQPrqqm46P7deySRFbn1PS3iIM
 c7ewqm8MGcgfy+rZWu1TcXCjvzW4azXFPe6VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869610; x=1725474410;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nm9L3upKuCoVBCm5TAzUoiFRaZrfRLknprEo/V0jCTE=;
 b=J8ktIE7Yp63DjIcKg+QmkfH7rNhe98Bk7IDDPZf93Sk2myRJMVcDe+EFgR9YO2IY4T
 ZMO/dIQyUiTqzuZ8X57G3D2sdZpyZ+BqwW5Uz0tDs1eAhpK2I5DONofoCepCEsB/Nzh+
 HMRQYv7lADjEltR4N0LJcqNLiEx9xPWSE9Ct4tmuWTx7kpmaqYTBuNLaO9rz7mnHw3zK
 uJEnUFwfxppfho9Vxwo6hAsy6KvVPNLJiWV57PdIODxtM4k2TlS2rcnlcpBmJ/A4774m
 +AAVj0O8YPf9kCD3SuV9FD2640i4EJprv9G5qYHvseBd/c3O3qqyfYv9ZUAy5TBCZ4Bx
 guXg==
X-Gm-Message-State: AOJu0YysYFK93yMX+RNlKj8i9fBpT1vKKauYbuBQz8thiRA3je3cVVpw
 Pv09dVUQkIMfMkqocekmmfu3HN5vE867U1LRzcrdnLV//xls4ZuxE5auiNrjcxx3PAiZfQJDGWZ
 7VVqHFA==
X-Google-Smtp-Source: AGHT+IHhBPjVx+fdOpL2eZHu+0Mq6k8TfnKg3T5eGFd+pKnzkf33yo6fKaxkGyYZJgFJ0+EtUxGSLg==
X-Received: by 2002:a05:6214:3f92:b0:6c1:6a91:49b0 with SMTP id
 6a1803df08f44-6c33e6a9755mr4243036d6.51.1724869609948; 
 Wed, 28 Aug 2024 11:26:49 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de, 
 Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim.Moskalets@kaspersky.com
In-Reply-To: <20240817110222.31415-1-Maxim.Moskalets@kaspersky.com>
References: <20240817110222.31415-1-Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH] lib: move phdr increment to for loop heading
Message-Id: <172486960757.3064792.12091724523620174776.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 17 Aug 2024 14:02:22 +0300, Maxim Moskalets wrote:

> Shifting this pointer in the loop will be more logical when working
> with the code later, because you can see at a glance what exactly
> changes at each iteration. Moreover, the code remains equivalent
> because this variable is not used after the loop.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


