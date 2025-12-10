Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7AED3B9AB
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 20:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3819083D07;
	Wed, 10 Dec 2025 21:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oU0I3qSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1787483CB5; Wed, 10 Dec 2025 21:45:30 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F4E83A26
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3ed151e8fc3so137723fac.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765399526; x=1766004326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbg8G5Qh/CspTRPycAm0AS5DoKyQh1r5T+duIoxypK8=;
 b=oU0I3qSUTAOzHWtvtJjZxd3i+QuKj6HdRKG32IIFCN/pzl8laOdT798grG4l6Avn3X
 J3KiWPdIp6jBKMOIx8NP1OXXWNUQS+eCLRdcseqAK7ejfSTVn6K4FLWmTXkbCm+leeBG
 ejVp5uJof4Sr8LDGJs15tqkwfoV3J6Bq7WhtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765399526; x=1766004326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sbg8G5Qh/CspTRPycAm0AS5DoKyQh1r5T+duIoxypK8=;
 b=XVlyfHRerSyYk3U5j2XKC7bWHU/w4nq0jwAwcgh/DP8jF4uHAnEAKb8P0L1rAVZnZa
 p6nMadpY32XJooMCqOGF9y1FtYXQrJmX/ZUH4psJEBhPBEB1Nqh4MbmPHu9snBpUd0Zx
 +UU+YjaYVVDuw9xUPpB/+XwBnwKIPfwjirW5WcRJymktNMirdzLyMEOqQ2NS1FeS0zC3
 wiDQ2WAsLX/JoRi6Jw+KyL2Lp+Y/gtjfoFxLIGU7gJwtSLWG6WJ6VROTuj+/dE4fEF3S
 M0q0zfscXqhVHlX8DhEkz+GguTjmow7TVGN5Q1hbsQDnhDqfjF8qiG947BMhufTNPe9F
 0/qA==
X-Gm-Message-State: AOJu0Yw8b5mwlRi+cAh/tuFw68YiSJ+vFP/Ns6lBwU8snbxFJunFiEZe
 G5eyESQgRchJ66LhljGkNjyQrbSq/iEM1U5S4Zue/3wxTA4ZZHp0AtaBc0cvMxvTJAw=
X-Gm-Gg: AY/fxX65urBoZ3tzDokw498Dv68BME6Da8pRM4fuyyr5l9OIcQY2d0tNM1/bLt6kvJC
 8i4c3D7hbP06K4UYipfbWNSqfZ1aD0gE/HMCdZLTw/2wyMOtggTnKG2qiREBaalPkRm+pOJ0rE2
 bZHhYoeeRYbPAH8E3dVwaAtxXdbIZ2GT52D7Kv6VQijtRRBI2tGDbm/ySqdV+VMUujzvd8hjKrt
 CUhk2PVs1/idVsA6VYZkcZ2K0DnwoS+4lMLDp1BGv+J3OIYZaiqP7hVjy4sJTWL+brlCx5QUpao
 NpfcwgSh9j6r5p4rW/wIwBRQLUmqFJiUleTzH/vVQQpOkWSI2I9W8/wbKyhF2MtShadCAQiJB3S
 +ag0Vh+yMHO/BpEcUUxh74zKWiN7m3aN2zV2hSQOumOn59TsbWuhvx/+PrQ7At6CKOCujwjZeUg
 hcJUBKHXdYWcbSj0+KwuT4xOeQ0ZjV0LEr6fOWhEK1rIM/WoQO
X-Google-Smtp-Source: AGHT+IHHInkQZtjeDroMfqqKTYTDv3+PRh35s9aXdUOO8ZpKEklxXRnOdw3rQD9/OgciJTGVgIt+3A==
X-Received: by 2002:a05:6870:a68f:b0:3f5:4172:1f with SMTP id
 586e51a60fabf-3f5bdcfa6bdmr2342716fac.56.1765399525907; 
 Wed, 10 Dec 2025 12:45:25 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d4e70030sm485887fac.6.2025.12.10.12.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:45:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>
In-Reply-To: <20251128110304.63138-1-jeremie.dautheribes@bootlin.com>
References: <20251128110304.63138-1-jeremie.dautheribes@bootlin.com>
Subject: Re: [PATCH v2] binman: blob_dtb: improve error message when SPL is
 not found
Message-Id: <176539952464.3502425.3281227177260356323.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 14:45:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 28 Nov 2025 12:03:04 +0100, Jérémie Dautheribes wrote:

> When using binman with the '-a spl-dtb=y' flag, if the SPL blob is not
> found, binman throws a cryptic error message:
> binman: 'NoneType' object has no attribute 'startswith'
> 
> Let's improve the error message to explicitly state which SPL blob is
> missing.
> This is particularly useful when binman is used as a standalone tool
> outside the U-Boot source tree.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] binman: blob_dtb: improve error message when SPL is not found
      commit: 66be03b7ee19444b23aae3990a434a7470fc1641
-- 
Tom


