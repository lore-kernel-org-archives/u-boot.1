Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3661AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20AC80250;
	Tue, 17 Dec 2024 15:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XDPlb6Mi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C9680245; Tue, 17 Dec 2024 15:00:54 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F22180224
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so878819466b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734444051; x=1735048851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bAhvmsOoqE7yn+E+31E/dlrDWEtTHBgDDJkTFZQ1kjE=;
 b=XDPlb6MitriSRPL6d04hbKBmQdAPQI+YQ++Y7iSSxwguLeQ1+WEHsgTBH2GC4M3ciF
 hKJsZL6hDQ7fttQ+Qd9oXf6x7+OL2FnGej7iUF58C/OkX15vetREiOqDCLADLT5Dcmpc
 L6QrrPAkLJ1/byE/gMcqZyVnzW14NohJqbTC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444051; x=1735048851;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bAhvmsOoqE7yn+E+31E/dlrDWEtTHBgDDJkTFZQ1kjE=;
 b=QXkj3mPjf998vWaYHEhKVZIDRGrKUa0DVqnj1JE2py4pceggpV0zs8Dw4EfGYi50kY
 pgsFS+6Euwi3lK3+2gOy4NdmWczuZUBwTphJjxXAQhxazdgvwaycveXVIIjnCZCWddOn
 uNbOVsCyqlXfPsJdnAHWi+H1eCBUu5OjWfTYysvSvaBBLDTZW0c6gqCejyHUob1tj42i
 k4IKLXZfJtlIAm5zC+exZfpxdv8FIv/F60cbPyZUx6lpPnTTlwUaBnNkOeRqLvjsEU1H
 0MlRv+8jrgdi3ja34Tc+4gXSxgd7x21lQSgDoeMM2bUbrgoknIngwkBy8RIVPX2qCLha
 vWDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMw8jqx6+KurvHnbcIVaX7qeIBf+1Iqa30Yz2JlQmKJQfdXKht8i9uZUVtVOBszaBMQ6VbyOw=@lists.denx.de
X-Gm-Message-State: AOJu0YzZMr6wQ0iEeuO3/ottOtK2JWMmZRdG1aJhY4WE6gS7IqLsk5AJ
 7iLNUidCoIoc28LNhx2uZH3pKHRX5ogxQQZ0LQeT9xuXAEAbWEadniPSaa4bY1GMAekwd0PYEe3
 xiSaaPCTCDdVKseiB/VPQ+ZPNchNQhoZ4mlFZ
X-Gm-Gg: ASbGnctZuVexHMdmJYamMC2f7iSr52LnwdOC55pFva1FkCzTg9hGv+CEdo2yJAtI1C1
 nZv3rCP2JCix8wh3jL02KrwWhpeEJZgbpN2gCGJs=
X-Google-Smtp-Source: AGHT+IEjweJMEutkC8RnNZDfX2ZkG9f3lDK9NtyCcKpz17M4ioOPoUGWc6oMQzBBh1XgHfujVPX7BBb0SssgLRA4vFc=
X-Received: by 2002:a17:906:2931:b0:aa6:85d0:1486 with SMTP id
 a640c23a62f3a-aab77ee9688mr1415778766b.54.1734444051401; Tue, 17 Dec 2024
 06:00:51 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 08:00:50 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211004503.3775922-4-sjg@chromium.org>
References: <20241211004503.3775922-4-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 08:00:50 -0600
X-Google-Sender-Auth: 5zh077P5lJYqtV4ZwgRsRQqxeQM
Message-ID: <CAFLszTh5E7NyK2N2u7u+MWavySTPF2Arz-qLQ+ydsfE450YFVQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: Switch over to OF_SEPARATE for the app
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
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

Now that we can support a separate devicetree, enable this for the
EFI-app builds.

Drop the Makefile-warning exception since we don't need it anymore.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                        | 2 +-
 configs/efi-x86_app32_defconfig | 1 -
 configs/efi-x86_app64_defconfig | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

Applied to sjg/master, thanks!
