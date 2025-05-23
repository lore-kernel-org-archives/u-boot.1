Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C9BC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE22483311;
	Fri, 23 May 2025 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i/CHHHCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14387832EB; Fri, 23 May 2025 15:18:50 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289C5830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso13890992a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006327; x=1748611127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=co/ZyL8J9rImivS4wtKkUtzN7afxGE+i01EaVn7j8h0=;
 b=i/CHHHCebhllXXy2Ho9AG42YF6vBDSpHY4fCsnWjvE9QkmIHqs3DtARvZz7LZPHMTk
 XbRZZhkTw9Vx5nQeI3buMlZYVYE5Wyvf5SAKXgNzc++wHVCwAXiRki0u6WDdSJlI0PDW
 t102rxFmmlL+ihmss54c0Zt7WW42doK5XqUzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006327; x=1748611127;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=co/ZyL8J9rImivS4wtKkUtzN7afxGE+i01EaVn7j8h0=;
 b=hkxuaImsbD7ZKlqszrZ6q/gxnwlo/uWVIfauFRh/qBYGw4JRFyam/1U8Tf+1Z4oO3E
 QHe0ITJQ5i/TQ15ZA/S3EthuY6EMkws7x5g5Hv5nXp0zvXlE73OSGqU8OSxpF6piMqF/
 AZZVo55U6OLANu1wiryvmvbC0SB+C2ZA8FszZA6Z4n5Ua6IiyeXjDHfDuKDL+Z4loJlL
 6NnlpNUGRZRoKzOPQmW9/QAUgYnBRrfQuGkS96A9l+SwUzmQuE0GZ/vzjir1bJmASgBM
 +RlMCumjFthsRVC9R9fAY/kwpYCvnnpwLErgDJdmXZ+EJrULW8BuuHL/k7QrRb+pjbb3
 Uc2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx9a0mXZoRhfiEadYJSk6AiOmmbHeR3qs75jrucPfua7bK4/n4DC1BO2CkJkCzUxmXEMFBwac=@lists.denx.de
X-Gm-Message-State: AOJu0YxjVn7VgrtnWGFfw4Eka85MPE0dGiWb0cD43yGrCDowEY712pat
 Qozk4+FwURswPAS0vlgsFy9jdTQRW3xArJE6yFDc8Zoi4edimhkM7dkg3HDnxGC9IqbqdAEXOHm
 XUUY7X6csYW+wlf6Wyd9pPgkvCr3V/pFGI3qMGSM1
X-Gm-Gg: ASbGncsTTjbcq/9fPvhb3CFWYBqBBqDDtPPJ+n3koIjbogn2OF0K4aT1XZMU/PMJil5
 55O3aHZoL7eMWOp2rbi6lBCCLdyuXTGM3j8Jt7dVYGGBFKBm9Fd6rInJH6NJXg6Igg5z8miOaum
 G7baEYv27/IIBu7HRvfJsSqrlv3Cvgkf4i8Q==
X-Google-Smtp-Source: AGHT+IGB5nAplvt0BG5M3lDHY5R+WkaRs0CgpzrU6W5FliI91FkXWTPNoU2n8nHisB7soBBSBpewpaobTB0yagwMxic=
X-Received: by 2002:a17:906:f5a0:b0:aca:b72b:4576 with SMTP id
 a640c23a62f3a-ad52d509d1dmr2485067766b.33.1748006327603; Fri, 23 May 2025
 06:18:47 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:46 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:46 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-18-sjg@chromium.org>
References: <20250504132356.2317305-18-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:46 -0500
X-Google-Sender-Auth: MV2nVbZZuWSkdBreDn9BUlyzhY4
X-Gm-Features: AX0GCFv1XdW8wZ_BbS_EPJIW4WD2xqDOC9HHpggBzJJm043fEXaHGqBee2Ks6Kk
Message-ID: <CAFLszTj+AKR9CF1h9xpOdLRuYLR67rNe13whBEXxT1FOfi5ZnA@mail.gmail.com>
Subject: Re: [PATCH v2 17/30] patman: Move Patch and Review to patchwork module
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
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

These relate to information obtained from the patchwork server, so move
their definition into the new patchwork module.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/func_test.py |  21 +++----
 tools/patman/patchwork.py | 113 ++++++++++++++++++++++++++++++++++++
 tools/patman/status.py    | 119 ++------------------------------------
 3 files changed, 129 insertions(+), 124 deletions(-)

Applied to sjg/master, thanks!
