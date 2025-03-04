Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F5BC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3A6812C8;
	Tue,  4 Mar 2025 16:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ag1YxciK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07678801CF; Tue,  4 Mar 2025 16:37:11 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18ACF812BB
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-abf538f7be0so529732966b.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102628; x=1741707428; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bghUajhDUBxX85UD8+He/KJ2Y2dKhtXIigx8F8vuZvc=;
 b=ag1YxciKpaG5XGIQedt3DwO/ZdodKE+pkaSVSFkzCL2LWvGN6PNW1Glo4QP0ySmrCV
 ihxiDX5bjnzSKNy0LgYfvulcog3p5JhX7bLTE3Z+qoVY3yws43biTy2YwvetwV+Q8ZO3
 r1UgKynxhps8L8zWlbnqud9lxV9uWjEGCOlZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102628; x=1741707428;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bghUajhDUBxX85UD8+He/KJ2Y2dKhtXIigx8F8vuZvc=;
 b=aRlwe1wvLXJE1nR25z0ydhrrPm5tTgedAYxUfpRvho0DK2qtaKkuR5pVjkUjXfzw5x
 ghwfvJcU7EMmIKNfy0kP9ZdIy6ssCYdpgWCTCUjkgvWSAk6WY9zvoW6HyVWKPrPnF3l9
 +VS1SKMQAsMLcGDCJ/m18bq3tPlULfZfEXivrFk5JYA5VkDVvFsMiJo73bHjI8DXKMyZ
 QjfgyUDXuAOBvEncOMNhVoLWEdRuRLXQ71IRTRTobwfUbFHOG9iiPbu4FvBZDC0oqSku
 GHxc2HFum2g9sTkaxCnqinvfz3yK5MM73Dck3pddOegKrh7ZQ43cG7FUxgbm7UZiB+zW
 05vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdazCZY7Ypg9cmzVMHUNELPE6d5YQnexeY6KOckORV3qIRNOEmoedTBDXRpic/aIEiEU/PJB0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9Hze8X9ljNbHTXE/eOA1BcO7u1gLbAhR1Yafn6su8qq83Cwgo
 VZ15/HB11xAl+7nVHMW8PpF2+UZYWX642gkCgdyJon8fyygtEqCPt6Ypb9Ra2Cl25XFek2UfT7F
 yfK15HKQOhQ3eF/zA9Bj0UclcwFR1kkWhdmBJ
X-Gm-Gg: ASbGncu9LCsAHePWzCsxovwmGaM/jItOAr0t4fboMkmlplQ5S37d9uSslBHOYywKiob
 bKv1D+P9R16p/HXoIIXAZECCHba7UsFVER5B2N5FY8cCMeO8+0LlIhzMX5TcgddjerreV+7Zchp
 5bPY/Zhic6zigFrddcPzW3cs2pSlI=
X-Google-Smtp-Source: AGHT+IES2MuilOd84u8MIrD2r4nvW8a4Zutm4YfFNQKZjZqjFQ7Bp7PlX1eYgvRxYzyKGDpBSI5RIGjEAKQdPOabkMM=
X-Received: by 2002:a17:906:b6c4:b0:abf:3cb2:1c04 with SMTP id
 a640c23a62f3a-abf3cb2202dmr1576301966b.9.1741102628525; Tue, 04 Mar 2025
 07:37:08 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 09:37:06 -0600
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 09:37:06 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-5-sjg@chromium.org>
References: <20241018030027.842749-5-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 09:37:06 -0600
X-Google-Sender-Auth: lOjriN-JmJc0QkIoiSNMc27tEqk
X-Gm-Features: AQ5f1JoN6zjgy543sJlajsSxuXtSgtKT9WlGp5qhI7lKpBp08YvUrtjaw_UF8x8
Message-ID: <CAFLszThBSqcugAx0CbgxMJ9vm5EeXpHRcWZ7KryRWfzG5mY0Qg@mail.gmail.com>
Subject: Re: [PATCH 4/8] membuf: Include stdbool
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, Ion Agorria <ion@agorria.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This uses a bool type so include the required header.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h | 2 ++
 1 file changed, 2 insertions(+)

Applied to sjg/master, thanks!
