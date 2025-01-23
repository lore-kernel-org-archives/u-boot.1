Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935C0C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43E9801B0;
	Thu, 23 Jan 2025 15:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jvm3digo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1847980214; Thu, 23 Jan 2025 15:20:30 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B13F80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso6583185e9.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737642026; x=1738246826;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p806atfZFAXimwedIUPDYi/eeiNiOFKbPtTpcuBWE2s=;
 b=jvm3digoSF5MyCb/ayMltuXjW9rhwd8DYxX8XY/f0UtV5OvSP/xHTEbysVXJSbMppU
 8egXHFYUBfP5Vd9GRNCIUWJBW+k/pgI95fc028j/8T2GH3itoOzfGznJK1ucNbdElERy
 t/hGyNpjPDvvS2TWYMqUVUI9d8qcrGistL99aJBADX2C4BIr9ZEhWh97tegf+YwB30BQ
 VrhpqMPqQqOnxSXxtMF3fdRQATmtv7nIA7OQv8txTIsdYZBDdWjeExeT/mK6twESr8A5
 rhSJQfp6+aVjDuzo7KBIQG9FpggOekGZ1eGIfG2fhIDPRsys3z3IELBbxfyoaqf03GFm
 Gedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737642026; x=1738246826;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p806atfZFAXimwedIUPDYi/eeiNiOFKbPtTpcuBWE2s=;
 b=QVH85NRTyR2IZ7dc+aFgEMAn2s4pOzH5T+5ukBb2YUYCHYKWxT0Cl5Vlxm6OYXj1Um
 Wlbq00auD1q9q3IZXYKIZI21MYJZAoxc7b6BaJESI579ivyVKn3HTXVPDTI7J9Jw9sFP
 aif+pBiyuZ7j7sUyrbX/X2WvPaHW/p/ko8wUYNYiRrZMbrFVt8w6t4CCIIoZM59r3KVj
 EPCxxR9VmZ5X2WpFw7RgVNCsS+Jy7jsuUQ9JAi33kzDWueC9R92JDhpFaOqvJ5F9JHfe
 SOQt7UhpLDtmMFrdCwO1yyzwfnSCuP4OXpIwv5POTkgES5Mc1rvdMD0IX4FBklCFEhYS
 yncw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmxgHsuq/Ec/DzLB7N8ronOKR/CeJ+So9QIWMegQUoZTGcVoQ6ihi22ef0TmaBrjofyXGYCaM=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm8hv6zH2WrVXWSR0o8aSM1EE2lgU9y4sU5Xg/odLLK/boa1+i
 Q7rFH09KdLturE0zm6FUDJBUmJYFieRz00Va1HHOzze4b/fmyR+SGP4NKxNbLEc=
X-Gm-Gg: ASbGnct7JYkxdj34Ox26BUBMTxuybAN+5HNakMXh6bff3nkOCMz4wM8JMvRDFbWW6Pj
 b9W43ItmjEZ/dZ43YVvJrSTmqOS2TfZVVbCtUSEWy3Oxtj+W55TDgwSjfI0xBEl8q0ulcMr4I4S
 00IChVR3lD92dwKCkKEsi/bLbPESc0n6dlKU9XNXPU6UeanwT3lLa+FsZjBL2Awm9NLcOiaIX3Q
 pMMKelqWDgUvwaYpCwpRdnBhyW+gw+Q3WtUXqnAX7fgr/0HNtwLco4I7ITICkQr5yA3mzPmBne7
 dDpDTyYGfRrlN/jFeGHV0QXdbjQ=
X-Google-Smtp-Source: AGHT+IHSJvHfsw5netFv6mjK53huM0JUCvdPIeEq1ujuRK6aHjZAiDsxa0Dv/Xm4oaoR04P221jOsQ==
X-Received: by 2002:a5d:5f51:0:b0:385:f092:e1a with SMTP id
 ffacd0b85a97d-38bf56551d9mr25406787f8f.11.1737642026478; 
 Thu, 23 Jan 2025 06:20:26 -0800 (PST)
Received: from [192.168.2.169] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf327df79sm19811915f8f.91.2025.01.23.06.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:20:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Nicolas Belin <nbelin@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Aaron Kling <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
References: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
Subject: Re: [PATCH] boot: android: Check kcmdline's for NULL in
 android_image_get_kernel()
Message-Id: <173764202516.267504.2600916685263608532.b4-ty@baylibre.com>
Date: Thu, 23 Jan 2025 15:20:25 +0100
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

On Mon, 13 Jan 2025 10:11:45 +0100, Mattijs Korpershoek wrote:
> kcmdline and kcmdline_extra strings can be NULL. In that case, we still
> read the content from 0x00000 and pass that to the kernel, which is
> completely wrong.
> 
> Fix android_image_get_kernel() to check for NULL before checking if
> they are empty strings.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: android: Check kcmdline's for NULL in android_image_get_kernel()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4e599aa73a386dd1ba5091937ef2fc388d01ddd2

--
Mattijs
