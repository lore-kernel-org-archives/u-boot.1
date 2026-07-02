Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D16C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4370B849C8;
	Thu,  2 Jul 2026 12:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KsQwny3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6020849FB; Thu,  2 Jul 2026 12:53:47 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB224846FD
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c125c082ee2so183576666b.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782989625; cv=none;
 d=google.com; s=arc-20260327;
 b=YZUXxbNko6yH598gN2Ydr9r1iFhk8s89QF4FC73/uhhUZTX56Sf4n9aXf1WdKO4x6d
 bOYpNZfXLrsD2RNg4OwFJpd9C7uuJCVM3FKKkUDYmxO44qbDeIWDLOXONoDbObC7lOEd
 JDEUeCtJtWUI3Sq8/ZWS7Bno76ImQ4+TPB68XJRnpNvOnV24jKWXnc1/hqcC5Cn+1bCZ
 NhuGtkYvXSvw2ZcUAk0nBVpgwderO1A93uArzRfncoNhPnIwOOmBYA+XQ8W3fMuMdaiD
 UanNyz8sOgbdVePi7gqubo4hyLJDSgRRX4nSEgicrPjeLtyDj+lppc84XRCcsLziZtK0
 PvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IkBvN1QRcau0TtEhaNtb6Cjo6Z9IG++85RfRgKSiX5M=;
 fh=h4ICnm4HBU3ysJ/05cwSBEf2H/taeJ/EYqSu43/1Q48=;
 b=owpuQJ8tfNlFb/e+Rz79RPEkPaLQDwmt0dI7yua17WBg6aNMCXo+29XipWGLMsSzAc
 ajfa7KnJkziU0lsNc6JoAcMVHt/BouA4H5aabIjjd4oOSH1WsF/dzhUew1trliKmsHCX
 7EHYmBawC7RXqRMG7/La1JXELMmUwr7mQxsxk+LBEYIWoYaf2aFLMHgAyx+l+gnyjhW7
 A0xVqBePAAhHohdGS01/SYJf/iUTBs1/8PVA31CTDATMevMOD2hQKQkZCwuF1JXRDPg6
 qKw837rtWqCCakWS6y13+zL3vAtr9qtpJeKGEZLrUf4nUFbeTfnEYtUK3wag7I/inKJE
 j7cA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782989625; x=1783594425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IkBvN1QRcau0TtEhaNtb6Cjo6Z9IG++85RfRgKSiX5M=;
 b=KsQwny3P7024hh2kzMVi9z9g/4Dv2C+hw+faNZvzCi/O2Df9e24Z1Aoby5KPaI7k3w
 0Xqo5UUSXN8npeCrbCQ/OIHmK7D4yKrMbBuZnlJk9YyJk9ldznVgdNAnjOndod6QPHKo
 CJaS2aYrwlczIw0i8xHmHzeeIdNSp9e9c3Tgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782989625; x=1783594425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IkBvN1QRcau0TtEhaNtb6Cjo6Z9IG++85RfRgKSiX5M=;
 b=L9lP4KhzZO6+Y7G1M3Jszn4+wxxwt4vPQgxpfGDVYSHQaycUhZXB5V03/u4WBj3L7V
 BhpOjYxTeKVDkcRFh3v+C4F53ziUeb3hTnxe49wPf7zkG3ERTGr6tD+csnajxcIUgqRK
 IN2r+r4O4WmbflOyJwuk4ClGxPFuO26fqsyu37MnAFYRE6QTe2i/kpv7UsB56wkIr4HS
 pPBFKPV6q8Dz1DIv1ZfV8ug7Wp2S9d0LVDIAEduZkMjI0fwaRHAoFtX9COy0LN2Kkd14
 cfQw6WV6eCwdYOoIh6mqpyipjJxGxOQuYsL6nlJaWSAnhpWec9kOhlOEhymjfM+fqUYO
 7fcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro43PaYyo+xx9pdReuHqChoeTNtqcjeT5MGTM0ASh1nMSnA5N+qOTCgIK6x2JKUJaQLK5/8LIM=@lists.denx.de
X-Gm-Message-State: AOJu0YwpO9exf2RJ51rF6JinAH5Ktd+aNxGXtMm8RiX82zwyn7AUP7v4
 qXDuRgARspgiIDW3f6N3oTJ8WpaDfZHiM8EkxKq1WSoVJFPt5Q36R/tCNuliQcXaG6elFo+g9FU
 3SjSbqhDucrqzgOpuXbXie+YFM66a+gEHYgr8DuGx
X-Gm-Gg: AfdE7cl2K42fyWXRsQmeGRlWpYczyzElwh/Dd63lUufR9DSseDv5GysDp5KAn+lNz69
 haMd2V/UBJWxv5aYPpsanpAFbVffSDimrSP6frB9A39XsNY8OaOO4CF4GZBZ+scvrUO7VtyYKWT
 0iJrFKZpl6o3rO53jeMJRX3NfNdZfboELPq09etHesG8XpW3JN2wtaz1wKaUQCFOApUPsNXL70x
 KsaNSdBIloBz0RpfZzOm4VbHHzLpqV3xLjqnzrTy4q0xIpiZ3AQ99vb1UN93/eVrWp21+TbBA==
X-Received: by 2002:a17:907:86a4:b0:c07:c935:7a43 with SMTP id
 a640c23a62f3a-c12a9d6b398mr243559566b.6.1782989625202; Thu, 02 Jul 2026
 03:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
 <20260702055744.2164975-5-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20260702055744.2164975-5-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:53:09 +0100
X-Gm-Features: AVVi8CfiOUdTUoxsvqFjrzqTRkTE_dnMVSfrciM9lY5-uN2Br59kz3YUfZgROTE
Message-ID: <CAFLszTje54iDV7TEQ0yy_XoxWHZyAcGcXphjazzjxk2H1vgKAw@mail.gmail.com>
Subject: Re: [PATCH v14 04/18] watchdog: renesas_wwdt: Convert to common
 field_{get, prep}() helpers
To: mikhail.kshevetskiy@iopsys.eu
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de, 
 Markus Gothe <markus.gothe@genexis.eu>, 
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-07-02T05:57:27, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
> watchdog: renesas_wwdt: Convert to common field_{get, prep}() helpers
>
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
> drivers/watchdog/renesas_wwdt.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
