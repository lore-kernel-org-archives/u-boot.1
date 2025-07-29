Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED12C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26A682BA1;
	Tue, 29 Jul 2025 17:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QOgMERmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F44282BA7; Tue, 29 Jul 2025 17:20:41 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390BC82063
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73e65c09828so2636730a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753802438; x=1754407238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbNIstRZiTuknH/RguL7BwnjZjDYRFSsYmilnN8pxhs=;
 b=QOgMERmQkW9OLUG5eC0e0+8V0T2uh/73cbSV136SjoaSxUzlsLxio8hmDMNh8lcn+n
 sGTPvib7GPJZR2GAU+Dir/uLowUpv2lFqXCfHjMCy5O6/ny3DtcUagArLFm8EvA0OOnC
 uB+8EyWYQTzpT6RZC6GgxD+s5WhY7PYmkxbwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753802438; x=1754407238;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbNIstRZiTuknH/RguL7BwnjZjDYRFSsYmilnN8pxhs=;
 b=QfP3UwHJDEEMX5F7DRCQec43c8zU3nYUPrnmPxFky0Xc9AK5Tr3EihEtIqQlrhRGT1
 24EQKv8RaSDXQlF7kS09cPQyX202zH359ajU+mg6IpQfl3OxK0qoi/DKhXx8jCHoZve0
 uS2SBjFJPjf0V9Ds8DgvbNVEVlIsp2ynQHvXtKfbBNB+D0hUY5QGNH+icyrzpdVPvpIU
 0GiFZ/sPYGobADx4Nxmsce6+XFS4nTqukWNoAs0Mry9OMq/PyyNcz3IE8fXqbjVwxYP0
 6rJjZHafHpx0vaszE5s0XZ/81rMU98NieOklcrkKdQE4689Tuf7Z1HxiiRS/LbR2DVT0
 hk4g==
X-Gm-Message-State: AOJu0YwsqEeDrlw1ZLzhI1gx7q+35S1pcwpFDHP1Zvhg+2ZcsBJQs3lp
 Q38hevtlUlkjkJKXjQOqXsPQIl3KYlPz9SmdXaezKCnukP6A7aWsoBMWbZoNff15rt2o8PfLwTg
 9SWC/01s=
X-Gm-Gg: ASbGncvBWf0yitkPGH6X+tD+XzNOyQJNooHzYxgsxqSTb9TN3EptwoTPRZ2JzIvtHfs
 KHQSrVmPl+XEQRcqW0/mBUvqGl/zLGSqxSmEfHIK3vqSQTbsxdjIjKf2WAk0I/J7LyEVLc4bAqm
 g7P3G6t+SWYrIJkS/WD3vJH/Jstkr7SZ2yUCX8wVHgC/gWeRlpnzhZGKaFte3kpNBHCIybNyTL9
 8ewoEzZRPkb9+ddXWfJOgyedBbyIMdZVMidcL9K/RcYHcoGGbaRD1aeZ91FpOBqflOijqNns2gg
 AkhWT78kmqM0kTQ1Npfcy/K/0QMCTGP/uAJE5nHsq51rc1reb7ZpXdI46j6s5q91cFmleKNISBs
 WJpUaMfeq3Cip6lHXQc8vAEnWbYpMBNfTivnEWM32HrLHuloMOZ4f4mk=
X-Google-Smtp-Source: AGHT+IGjEeLpDhLILcBzZTgBdA4szWev1HOmre7I9HBAtUEtaSFnsuDgp0BOqQbhNHFz4zai7eINbA==
X-Received: by 2002:a05:6830:b94:b0:73e:a023:63a9 with SMTP id
 46e09a7af769-74177cb9d1emr128303a34.17.1753802437398; 
 Tue, 29 Jul 2025 08:20:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f4ad64sm1553959a34.1.2025.07.29.08.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:20:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>
In-Reply-To: <26a13b67-9c3f-4206-9af9-49fac4a80d07@linaro.org>
References: <26a13b67-9c3f-4206-9af9-49fac4a80d07@linaro.org>
Subject: Re: [PULL] u-boot-at91-2025.10-b
Message-Id: <175380243649.1918831.4396194080002391408.b4-ty@konsulko.com>
Date: Tue, 29 Jul 2025 09:20:36 -0600
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

On Tue, 29 Jul 2025 10:42:17 +0300, Eugen Hristev wrote:

> Please pull tag u-boot-at91-2025.10-b , the second set of at91 features
> and fixes for the next 2025.10 cycle.
> 
> This feature set includes the addition of new sama7d65 SoC and a new
> board named sama7d65-curiosity.
> 
> Thanks,
> Eugen
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


