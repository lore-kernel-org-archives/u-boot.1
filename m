Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A6CD3B7C1
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E921C89B87;
	Tue, 26 Nov 2024 09:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wjqsvWZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BE389BEB; Tue, 26 Nov 2024 09:59:56 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 604BD89B73
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a8640763so672245e9.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732611594; x=1733216394;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LD8MmZIJbHnKQDfo8crB9BO5AKF2k0n8EcSatAkd2M=;
 b=wjqsvWZn4BkIWDDtsQZyLIQRUf2ZjZ0EU3PZovbUZJZwYhvONACHP4C9d4JFP800qn
 V9rophX8zYd/aAaMgxCGxpF7UWcXvXqKksFDnEIXVrRmiTGLUHNwpu0qBqqKh1Oiqre/
 N1vm+hsLy1B7mjLQkeuN6vBwaQHuaBgTU0MPFTU3KlmZDc8udYvHXnHs7BBtdONybyVS
 OxVi5bQyL3b0dlT+67WUQzcn0JgmNYoSlIp6G6NpHBZ65NFELdtquE54Z0B3v1rg8HQl
 JIjCdH/vrWwjGoLCmAE5H3oSkh3fpFtx9GFel9/GCVsFDSEm+QRNbuBTxoRsvpp9k61k
 dTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732611594; x=1733216394;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LD8MmZIJbHnKQDfo8crB9BO5AKF2k0n8EcSatAkd2M=;
 b=B67n2TpjJAU7+dy58RdBaquAf1RZKcbcghiCySy/ZbZZzXGc26lU8BXCDY+7xJ2Pcw
 r9bWSGvORcbaYQ8lz7K59xwBHEeXmaL+cgQ8g37IC+TfQGRDyozfUqrH6I4niCnmlUXn
 2oQWthKCmkdiipEIO/o6O/F/NcUDB4GyFEGTQ673pd1FMSC2PmnGr6ce3W8iYnKP0yaf
 YUNgvHA+Nk9gdbizEZkJnZ++Q3q+7P55axKCLfsuWIl9RoG4zOPH9e+EAn0gBYmh8VBn
 FeFB7Dgz3nlreOVSiAr1SWU3U6tPlzonJZBQLACwinhgbGZ1OQ1Ly7cwe7s/CLrQiKlc
 gVKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlKj4MA1Vg9htv4fapCy32OTOjA34lO1EhNRtyN1vuAoNhPFryIuSlZ0aKSlbeO6JIndoMf54=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7T3UUGce7SPSYUS9SFPjOrN3Jv2fB2+iV2irBwQPxZ6JU4v6C
 Ug4dcGru+MYGCW+4pbE7jMMqL0W0oRQvOqFcltf2ICPIow7Q3k0xoX7lF+gvfeY=
X-Gm-Gg: ASbGncuVKSjTCEz1uz8KrZZQmxLcdMOZDWRpI/kdcNZii+dR361aiNjFAJ+Crxoey6H
 J6nqqoEzygT867e879WKEMSGLbZ90TOrBmEthYZB1rnoprFNwJ438EUqu+RVh8yOBrG4l8cIQ8E
 fEmyR+NhghV9ZOX39pAEwihkU1G2ySuTmuWELEiMuTU0WseHohDASmRi9UfJ9KLFoMQYqqobIhf
 WsoOA43pXbGKJFOPLAKN813IRjvEuy6Oc6D14pcgEGJhv37qpjWX6Q1uMVI+g==
X-Google-Smtp-Source: AGHT+IGlIzDqKNHLyRs9NkK/IDChm6kHRFW9xWqhYxKWt+SCBWQzWkZ4yr60+g9SsHS9aiFmdkU/+A==
X-Received: by 2002:a05:600c:4f47:b0:431:5aea:964 with SMTP id
 5b1f17b1804b1-433ce42882bmr135821765e9.19.1732611593933; 
 Tue, 26 Nov 2024 00:59:53 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde10eabsm157632215e9.13.2024.11.26.00.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:59:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io
In-Reply-To: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
References: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
Subject: Re: [PATCH v4 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Message-Id: <173261159203.11812.5321569268294652228.b4-ty@baylibre.com>
Date: Tue, 26 Nov 2024 09:59:52 +0100
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

On Tue, 26 Nov 2024 09:06:08 +0100, Guillaume La Roque wrote:
> Actually bootmethod android only support android boot image version 4
> and with AB image, some old platform wtill use android boot image
> version 2 with AB or without AB slot.
> 
> This patchset add support of both version 2 and non-AB slot images.
> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/5] bootstd: android: add support of bootimage v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/51a2fc40d399888ee45c452d2f40fa1b0cb1456e
[2/5] bootstd: android: add non-A/B image support
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/9ef8b3bf8a1062c69a2417b850c30b39255f61bd
[3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/86e931535cf6c2014ef384bd7cacea94aadf1645
[4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/83a6ae671680010ae52e83554c431b095fe2b5d5
[5/5] bootstd: Add test for Android boot image v2
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/126254ab97691a93902d8fe02fdff0a783921c39

--
Mattijs
