Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042DFC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 20:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770A382D21;
	Fri, 11 Jul 2025 22:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FmL3St1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0F4D828A2; Fri, 11 Jul 2025 22:00:47 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 511F0800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 22:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40ab5bd9088so1288282b6e.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752264044; x=1752868844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dz3RREp/wgNOCruHd8iaBO7NL4v4+tdoA2GvjjdFQpI=;
 b=FmL3St1aP6+GWCK/iccaHvvGnlrB3gWqMd7mFw7o4SnHBDjb/pcVCpfIqrPeZTO9b3
 U4yIEhvVnHneLVi9mtImLVGCr5k3VUPQtEzwMdj2t8UeWzAu0YuTeXCZeixWseJD7mjO
 8lhrGuvQj0NLd4yyk8nTlMZHwsOvmuWi3Y98g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752264044; x=1752868844;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dz3RREp/wgNOCruHd8iaBO7NL4v4+tdoA2GvjjdFQpI=;
 b=miiKIW1GRWzgBV8ZCFLlu4FFhglh/DIYqCf+8Du09JVhPEXAw38TPSa8XxPvi3oikO
 sr7G0AuIoDQAY3xIfVoOlCgV6L7DOPv1Eb8JD2XmBjP4EfGQb5o3GqF+Da1nOLvPFoXc
 AlKkOdEzkcMPjKmVvtSINI4vubNYcW+q7R3viocFF5tiQQuRIE9/YF3Ko0+XdUYIUh2d
 pGLls8erOtGxce1G0YA9hdv4uBeIP5BndDL2NqQHkFrUkK51F2Rz1YQfUVX0wDikOBi7
 AOAaWOajKMx8zJgTUvMXjVDrhy40NlpWM6x+v7rsKO1rZrHMjHm28IamwRk08UCHet3R
 /NUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbZveTs/GEw/3Y+veE0mahsfwklYK8k8mCdMwHVBTM59il3Od94EzLVIqT+WQYHNbo6BHysCs=@lists.denx.de
X-Gm-Message-State: AOJu0YySFRTledADZP2AssBZlrqFEMcP/AsQYX80VMuEG8MDoQ0w5fHW
 E1FO8++zOo+2h+d+70CfPiUofjrsqHsjc6DJgxjczSNIo92rAOe+acYgHY9Cd5m9T1g=
X-Gm-Gg: ASbGncuIj6vY8jh8g7gfOtR1zALprBOjeLeybAb6R+35PSFAx6vFsgXHhI5jsnxaLse
 iWanwUKK0wWSseu9QRt/xmUsVftG2333uS+avKqbtWFNMav+U2Jf3+hcba5/aDotbUBNJVv/zdL
 JWCkd5twQzqH61AHUGu1vymbYY9choaYGIe+Q3V0z6KMtBv4c6iQWKQDcFJDAHcQGTpk5v0qokD
 7sUVDyRQowgl+209/cVIazlC8t9uqaE0SVBWBoJ24U7TYeSeOqUgEkaZnui3vinp+2z+xpKePeX
 bnO+42px1IP7q7bhfGKKmmkuWWIq3JU45pK+3rAMB8aLUTJ2/3YoiQRPz5Mi13YZhJEvEu01O1c
 UbIYvY31544ayP+xQ266AqtJM0x8tegjTVdmvvid4DtJ225SfZqRDJeA=
X-Google-Smtp-Source: AGHT+IHUW5h6USCs+T+AxZIGdyLG9Upf7t8RxetQJQ6ODoPF2kQpFt4ikNsQ5TTqZs0v7btl/33X9w==
X-Received: by 2002:a05:6808:e82:b0:414:431:e1a7 with SMTP id
 5614622812f47-41511814f56mr3163867b6e.29.1752264043920; 
 Fri, 11 Jul 2025 13:00:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414161e2b74sm666516b6e.0.2025.07.11.13.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 13:00:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
References: <20250702134942.1483436-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1 0/2] Enable RNG support for KASLR on Toradex arm64
 TI SoMs
Message-Id: <175226404287.2365211.3638434488530487620.b4-ty@konsulko.com>
Date: Fri, 11 Jul 2025 14:00:42 -0600
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

On Wed, 02 Jul 2025 15:49:35 +0200, Emanuele Ghidoli wrote:

> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> This patch series enables RNG support to automatically populate /chosen/kaslr-seed on the following Toradex arm64 TI System on Modules:
> - Verdin AM62
> - Verdin AM62P
> 
> This improves kernel security by supporting Kernel Address Space Layout Randomization (KASLR) using a runtime-provided seed.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] configs: verdin-am62: enable RNG support for KASLR
      commit: 2d72a0bc43befa1a5c5b8de075f41240f227cfb6
[2/2] configs: verdin-am62p: enable RNG support for KASLR
      commit: ba57c79c6f778e006aba9cfea0601ce20b2db94b
-- 
Tom


