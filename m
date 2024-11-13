Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C02D637D2
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 23:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF8D8955E;
	Thu, 14 Nov 2024 00:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="orUoNIWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E178904A; Thu, 14 Nov 2024 00:51:01 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFCB89390
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 00:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5ee354637b4so4270074eaf.3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731541858; x=1732146658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmNpw+/B/frmuvV7xvo8lgz598RusbmIJ9gsXYmcLig=;
 b=orUoNIWvqWCKMXwUVOxqWlDTRMtj4pbyEQvwHUXQeDKZdRACKybPT+PTtKBSX9qK01
 1KF9O0Z2qaYocfvLsMH4tSAmYFc4jwyCjvCSU5ck0Pq0mNYfYsLJIuK6RuZQ97sVyUyS
 FAl/kWHTfSl+DXe2ZxODTP5BzL+ZE8hRjEvos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731541858; x=1732146658;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bmNpw+/B/frmuvV7xvo8lgz598RusbmIJ9gsXYmcLig=;
 b=iiGykfR0hsjkfuR4aq0T8gXaA8dMeE3f0H6HFGwj6jrgbEUV4KeOqqFj+0NFJfRPu8
 4ZRLTI+BqiM5nQgPoB2eez/QZmSGo0pBEsmszpa4735TETRYDppD3uynOZiEACv3Kc7s
 zbUMPrQHFr1ywv/nwI8DteUq77HafAqdajZ76hC7kJ60xHO7cxLhBkqR/TcEe8Q0Ntnb
 TT30MccbuWIMZ6QrRR8eCo4XASjCIjdBI/XRpOEhhyFEhgtUrMcqCUfXEx2R8/n55dfS
 /QbmP+5dbg0DEa1a2MQyvMgyzFWsVZVatrp6EJSmd8j7pjeFUNOgPbmcqFALizhecUI5
 fKLA==
X-Gm-Message-State: AOJu0YwFbNwhhQmwmfLuu54TpVFcE6o5UYO4Rw0gIrLxAojOBV8cCAmw
 Kawp4nQe5HRhNKt1nTpv3VCAwpED47hk9FS4TZYU4g7i2U4MmFUEkRhORaO1V1o=
X-Google-Smtp-Source: AGHT+IFkS7vd0gZwnD9Lz8tr8GK7jUp46zksVA/+UWSsBFAJU/DsM8rvSZYIHwmZl3HcfSHzGHifrA==
X-Received: by 2002:a05:6870:4687:b0:277:e641:5659 with SMTP id
 586e51a60fabf-29560359b9amr18368501fac.35.1731541858055; 
 Wed, 13 Nov 2024 15:50:58 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee4950f85asm3361505eaf.11.2024.11.13.15.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 15:50:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
In-Reply-To: <20241102193615.431681-1-sjg@chromium.org>
References: <20241102193615.431681-1-sjg@chromium.org>
Subject: Re: [PATCH v3] sandbox: Add a build without CMDLINE
Message-Id: <173154185604.2076886.3575157670365516444.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 17:50:56 -0600
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

On Sat, 02 Nov 2024 13:36:11 -0600, Simon Glass wrote:

> Sometimes this breaks, so add a build to keep it working. Since sandbox
> enables a lot of options, it is a good board to use. The new config is
> created simply by copying the existing sandbox and turning off CMDLINE
> 
> Once we have tests for non-CMDLINE operation, this can be adjusted to
> run those tests.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


