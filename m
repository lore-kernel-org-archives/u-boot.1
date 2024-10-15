Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67338D1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3712F88A9D;
	Tue, 15 Oct 2024 21:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n6cbpsRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6941888A4C; Tue, 15 Oct 2024 21:43:57 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BA888966
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b10ed5e7cdso632966985a.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021434; x=1729626234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uj18NNecbqDCHqAU/J/JYx3nTueq3E32XyF98KDwoKE=;
 b=n6cbpsRCEkxlDCRS5EaIt303nmTigSPJGKKw+RgxUi4VgHCuqR+cJG3urnUv5FzXX8
 YkVyBXXrmcSvOQj5Vkp/VOuHr+6jEkQdgLluMIx8tm3T80LW3qxCqFxzwXFr3N3wsSpB
 eCBzSHa81m9vFpO/h8oM/fmZxSNWq5ZE64ztk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021434; x=1729626234;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uj18NNecbqDCHqAU/J/JYx3nTueq3E32XyF98KDwoKE=;
 b=ptUs4RWm2ey0Oss95JSIuwGBEeCvMiPLHb29qCY7TjRfKiHR5WkfOlps2tUtvnpEOh
 n3umlA6uDou8pBM7gZb5Zq1uGq7uaG01LKChMaivgkMG/7tskvBe9mkKKMJ2gM7td0jq
 RpF72o7QdVXY8+2WnuyGgYW7pkkZA1wrSsbfSlQ2dnKvn1XfeMWQDK2IIIUCDr+Ofsfd
 jL4T/XNiTSQBkikWe4aV9oi2UnqXFqZoKQM5x2zzdhrf+3ZT6aG8fJjI4MNAqqN3l1/I
 cgzcdFNNziu5kH4eGkSIzwmN2vUkjFkjjnvnPTnmDXTKb9EIEhrP8dzRJYC+Yvfv9Wq/
 w46g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkgfi36sfwLdQ8K+4QPtpKpGD9s0xEe65+3m1p3iVmA6CEXsPjVd1eecfKpNk+FTzieglqSRA=@lists.denx.de
X-Gm-Message-State: AOJu0YyEf2NquFLR4WSo1MGf15x9130A5S8ApsLbeaQSxFXwft3cPKI0
 OtBhupzS9ElXwsU+4dHEbxg8do1xYOVDSplZuqjFQO95gEpPOzCVzth+ySVWUJ8=
X-Google-Smtp-Source: AGHT+IEJNwgZvWPMD1SpUapuSeJM9NszGEwy9JtuDhjhkuxZ3mNuNGcDV56cR7pDGIHR+PNoBXgyQg==
X-Received: by 2002:a05:620a:2455:b0:7b1:1352:66fa with SMTP id
 af79cd13be357-7b120fc3e5amr2007922485a.30.1729021434271; 
 Tue, 15 Oct 2024 12:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 u-boot@lists.denx.de
In-Reply-To: <20241009110854.9907-1-heinrich.schuchardt@canonical.com>
References: <20241009110854.9907-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 1/1] net/wget: set filesize
Message-Id: <172902143223.5381.18027785941800901328.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:52 -0600
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

On Wed, 09 Oct 2024 13:08:54 +0200, Heinrich Schuchardt wrote:

> After downloading a file with wget the file size may be needed in follow up
> actions, e.g.
> 
> * write file to device
> * calculate hash
> 
> Let wget set the environment variable filesize.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


