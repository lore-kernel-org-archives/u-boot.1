Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F889C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AABD482A76;
	Tue,  3 Jun 2025 16:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Xpr7GcFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78CFE82AA7; Tue,  3 Jun 2025 16:20:20 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6219182998
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4e591544d42so1877210137.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748960417; x=1749565217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DxD2xl993nvRoxNeVTqN4tCNknRUyZYMe7AXRNBjuk=;
 b=Xpr7GcFS1dooCoRFquRmZFQaYSIlqltSBrA7C5QtgK72U/T0CSZvpOFjKo33FfOQ+1
 VJW6b5yaZlSzEGk8JefOKZgICTca7QvhcQYHgPAwEaux+JSrW9n1i64FFlWXR+MzoENo
 VKb7AGlUuN5Bwxx/8hcp93pTLNsvdpOvary20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748960417; x=1749565217;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DxD2xl993nvRoxNeVTqN4tCNknRUyZYMe7AXRNBjuk=;
 b=ncyyk0/MwfOGPOOCLpdk6D3esHacPTQtk8xhkD3lIx5/eNRjsDghs/uktQy3PH9iZo
 PlkHBe02xK8lbGktHksDIHO3ZZQvnlnbztA+i2RzUfUf4z6Owtw6j9M4iEdTTrufOzoK
 CoOxVlIJUi5Kei5TswOXz5vuBpP3OQj0SY6RVyyPZxDqRWw2zdEG/2cVqhb0ZA4eaN8e
 53B9jhfoEbVc7OZzlJoa+qyR5WQrthqSicKHNf5IS2AtlYR7AXLeVKtrfZk/BFYbSXCQ
 D3j72MqqY2wyMr6zwlkjRY0iXJfI4I9oXXhAwauYgl67b2UUL7aet6D0crtd8lJHPt/r
 O5gw==
X-Gm-Message-State: AOJu0YyvIbwB9sYHSMkG8yh8oDVV8eVp5aKx6L9CCSdHjqOLCt1OUJuS
 b9ZLva5wpG57cb9h5UZpvTRquwJajE/DBeOiTcSeaMct6D7FbjeknsY9pmO2+3aUbr3ZRYDVbmE
 fp5dtobo=
X-Gm-Gg: ASbGnctvuAHMxTMs8tFKK80JYL9uVmjjKSzSCYca9ne9eoaumxnsQ/GrnhzK8PYqmWv
 SdgWY8utLsDPtwhQFT5Mi5Cb1R1e9YRgIa6l/apyIPPNktjPWWDjn7zOvWeo7htQus5Cbw0CMot
 O/OOlJ55BDGLWTGqSN7xqkxxgKYoCRL5tP+ysXuic7ZBcY4tcHsAfnnPIM0FXmdU6UWHuQlc8eU
 hVGjevFRmpSlX57BZzzZU6Qj3//Pg5mkxR+CD959GTPwAsngeG7HL9vpf4ZMZ5xqlDTWVYpqSQ7
 SF/OPXkaO8jnCMjbzF2VCp6ZzQzfW410AXDduZtC0hDnMHA2OJKfsF1Z9OZFC83qHCXHnwfESlR
 E7mlreLQWgPXFwXngiGOwiQ==
X-Google-Smtp-Source: AGHT+IE4wggpkLIid0J2Wjao4oP5ANmyB9dnekz0lw5OJPi6QwWsuaHiz5k628BjY+il+tJqzaIbhg==
X-Received: by 2002:a05:6830:3988:b0:72b:992b:e50 with SMTP id
 46e09a7af769-737624a212cmr10064319a34.21.1748960406028; 
 Tue, 03 Jun 2025 07:20:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9f4050sm1893281a34.69.2025.06.03.07.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:20:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20250518160316.112532-1-marek.vasut@mailbox.org>
References: <20250518160316.112532-1-marek.vasut@mailbox.org>
Subject: Re: [PATCH v2] ARM: Align image end to 8 bytes to fit DT alignment
Message-Id: <174896040528.1462766.8995267178379871775.b4-ty@konsulko.com>
Date: Tue, 03 Jun 2025 08:20:05 -0600
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

On Sun, 18 May 2025 18:02:58 +0200, Marek Vasut wrote:

> Align U-Boot image end to 8 bytes to make sure DT alignment requirement
> is fulfilled. This fixes a possible failure in fdt_find_separate() in
> case the U-Boot image is aligned to 4 Bytes and DT is appended at the
> end at already 8 Byte aligned offset.
> 
> 

Applied to u-boot/next, thanks!

[1/1] ARM: Align image end to 8 bytes to fit DT alignment
      commit: 52caad0d14a3d6de34d69929c6e795f62c623a00
-- 
Tom


