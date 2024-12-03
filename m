Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46559E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CFF896A6;
	Tue,  3 Dec 2024 20:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bb2DrWc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 041E8896A4; Tue,  3 Dec 2024 20:39:37 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 132ED88E7B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d0c8ba475bso4805149a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254774; x=1733859574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/CPOtr3zdiCwC/pcZJY9kcndeh0Ym4zMxmxJVmL9Ea0=;
 b=Bb2DrWc5gYlp/TtSA6Y0+7IlKYjxtDeP+SEoTYGfNL5INSuUnJ4RHGsLYdbruP5ALz
 /vpYeIWkjXKbGzUCfumyQ77ZnzAERU4Z171I47wx4MparkgV55psosea2VkqW7t0D3Fn
 YCpJlXz2f0pf1LcKD3UfHzOsZHeLkRMEJPST8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254774; x=1733859574;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/CPOtr3zdiCwC/pcZJY9kcndeh0Ym4zMxmxJVmL9Ea0=;
 b=gdITNlaEJuwMCgCCxwrkm8F5GtyJYeQuN9NCQW//6LFLuE8WeGJQvqDaDq88XKKSkU
 exwZ6GCn1XKF8ony27PgOmw0cdq8ORsIhafSPW6nEoMLrKw86FjK3DueuuC+xpMUQdst
 0HxUuN5mydPyafIWjK93IGMTyHhmlImQPPMuUYw4JzwARL1ikmqVzLjACWPj8EZHfrdh
 UW18xTO8N7lZlHUezLYdGhEuQEGeCEbXxethBZqI364h32pEEAPp3ZCOWJxQqtN1z8CN
 hcp0c4/geB7I7/9LkSSYqVHtmBbGaTTf2A1ccr3dkJgU4RX1Z4BRv6jpOukcfCHcYXCd
 od5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMPlphh71vmNRw1a7Jv4O5Tll44zhiMMpxswKbjHpDMGrFefzj8OiH/xVcSjpeuJmUViicZ2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YzYatmdEJSoaUYYsdzF+yweGxioXcq6ppRV/zvYqrB9q4NfgODc
 smJGy4BLe/2w+rTYN9CS4c423vtif3PK5xFbmN1ZNla7Bxk8mo4VjU9T3nd4ZCXDVRrlSmDvV32
 4lnWN1QCmr8GfAYb4It3N6bC9zHztN5ber85h
X-Gm-Gg: ASbGnctrG8+CSopYgGVtOptKcQrR5lKwAy191cwLsdxLAy5tkgLPxuVDuU7NTy6fG+E
 7z9vD8S7NHEWkHoQPC++shLp3LEGt6gfn
X-Google-Smtp-Source: AGHT+IGEzDyE7y2JY1C18EEyqcOowHMuY/7Wonec7s4pR4+M4Xsr99n+ECm+a3M8zmP486L/IC+AIyE3izE5LUk0WsY=
X-Received: by 2002:a17:907:a08:b0:aa5:4d96:ec7 with SMTP id
 a640c23a62f3a-aa5f7f244ebmr455184566b.44.1733254774603; Tue, 03 Dec 2024
 11:39:34 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:32 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-19-sjg@chromium.org>
References: <20241103003322.626036-19-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:32 +0000
X-Google-Sender-Auth: UDnP_7xvBYVYtRKm4LS0er3KrHg
Message-ID: <CAFLszTi_+84K6PJKVSJLskTLJpD8bXb6c8KTwa_3YA_qeUYSQg@mail.gmail.com>
Subject: Re: [PATCH v3 18/25] sunxi: Drop status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sunxi/board.c | 6 ------
 1 file changed, 6 deletions(-)

Applied to ci/master, thanks!
