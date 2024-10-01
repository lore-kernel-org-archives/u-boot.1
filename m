Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2F4CE7CF7
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 08:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B60589174;
	Tue,  1 Oct 2024 10:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KASd7YwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD72F89171; Tue,  1 Oct 2024 10:57:49 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634E889141
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 10:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37cd1ccaf71so2570641f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727773067; x=1728377867;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48UjEXG6FjT07LLssLAb4dIIZE/+OOmfbTJRfuJiucA=;
 b=KASd7YwGfpzZVHgyjNBeocNbdk7zucIOTG8Nwyd/LYOaZep3YKlklhaD4GtTgGeX9b
 QKEJXscddLBKIzdDwC+nLEUydNXt81IuEEgW90RGOKOf2eyQLiblulH6Ma7AStiw/l/n
 wsx8dvFouj4/1NrjB/hj3VqbmO3Ub+jcUErFKoFApEhrFmEhNbDZAawQw3Q0nw40iedK
 RMzvuKTEldQA+VKfyvbTdln3hb94bJiw8VapGqn5HIZYjF5KHs9hDdfPXYFMHLLLYrdG
 GpsXRK7IbjqRUnNAIr3h1UilFsVahN375vw8c7UDfPSxgVxolx6cLN1YrIpieoTbUZNz
 GH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727773067; x=1728377867;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48UjEXG6FjT07LLssLAb4dIIZE/+OOmfbTJRfuJiucA=;
 b=poh6JTPy5DwFVdHdQ/qAZEE7Zju5/kgD3ik7Z/j4yWKJecRunFqLAP7MUHHB1JP0O0
 FlIaZaEZkd5TbtoE5Ap2HHccnrFCpM/CKLMnagYde6zrrjm3fRvnpcVQM1N/DOS9Dv6W
 mXZIOpt9bHa0CYigWq9cQGv2Gdc3rs6UJmErmrnuAcrA5hAMUhgP+SHf1s/bnef/HlFB
 DGs2QO2Fv9hHmmVxwVEQTznQE0lki7YCXJeVuby3RtIc++tyJhcPqY6qqeYppBAf8XKf
 Svz+9lF84LpH2PX93j5kI4f4ISnT9rNA2QeylJGJuqvbpkB8C2ueMSZzGeXVKAijQazO
 BWAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSM4HfvsSk9RBslsrp4l0wEf1gRa864tqY2JhFpwe9xZB6mkByAkP6IoXfQfS4MlnvRhQLHRM=@lists.denx.de
X-Gm-Message-State: AOJu0YyyS4VzWSYXdcCWvG8p7Ekgxfqb1QW8rm6/Zv8tcaCJVRsrYVQv
 gWo1gph19/6258qiymbVuInOk9/WGQWHQ+madqAHxWHr3nftUhWXF7ZRFHti2Do6Mjq0OmS3awL
 y
X-Google-Smtp-Source: AGHT+IHmKX0v3vKdUVeOzHHW7pMXsxQBtZ2hGtCCavjslZ5g2RDnC3j9zlVsIKdkeKGPBnyv56DP+w==
X-Received: by 2002:adf:f441:0:b0:377:94b:4f51 with SMTP id
 ffacd0b85a97d-37cf28ace0fmr1259525f8f.22.1727773066705; 
 Tue, 01 Oct 2024 01:57:46 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6867sm11243252f8f.49.2024.10.01.01.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 01:57:46 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20240912-bootmeth-bootloader-version-v2-1-76d4c0b45024@baylibre.com>
References: <20240912-bootmeth-bootloader-version-v2-1-76d4c0b45024@baylibre.com>
Subject: Re: [PATCH v2] bootstd: android: Add U-Boot version to cmdline
Message-Id: <172777306531.48360.810397128922975984.b4-ty@baylibre.com>
Date: Tue, 01 Oct 2024 10:57:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Thu, 12 Sep 2024 16:00:01 +0200, Mattijs Korpershoek wrote:
> When booting into Android fastbootd (a subset of recovery), the default
> UI shows the bootloader version in the screen [1].
> This is done via the ro.bootloader property which should come from the
> bootloader.
> 
> Provide the U-Boot version via a kernel commandline argument so that
> fastbootd can show it properly on the screen.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/1] bootstd: android: Add U-Boot version to cmdline
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/3af5b851b4c66c63ad0036d4a10ea5b67e7827a1

--
Mattijs
