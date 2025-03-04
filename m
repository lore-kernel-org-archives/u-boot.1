Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706B4C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915BD80F56;
	Tue,  4 Mar 2025 16:37:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lF7x18NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3680F56; Tue,  4 Mar 2025 16:37:14 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371A8801CF
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abf5e1a6cd3so530188466b.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102631; x=1741707431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZubfHuE1AoSuwrATW9cz1WnPosgybc9Kt254M+7S+f8=;
 b=lF7x18NZ1ra4NrOwjo2nPhe3UKsdgmuBoCMX4hvgK+HkvuWuZU3Y8wAi64+58nU0uf
 twNDaPFv9eeSfhDSX1PJDvctJfDx33vatpGKQl+vKxe3BbE7O6mJhMZZ9qwPFaG5WgxG
 JWn8hPA46IvKXK1duDhbv4W9SnkzsTQlRj/TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102632; x=1741707432;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZubfHuE1AoSuwrATW9cz1WnPosgybc9Kt254M+7S+f8=;
 b=kBA9x5js3jEgAt3i8BCcGfFjF+CWiguGmbHkInQe7l5uf8OGI0Ap3LfOE/n0igTtvT
 cnTZ3nbSmRAk+mUN5ToWdm8UnWanwVw6V/L0civP0ZVddM5RgiMzyMX9xDWv7NXvBVS5
 pyIcp3KRCYf9MiIkKzABJwggDNN0a0tw0hTlgjiXTY1Ufy65G4SW94IubSUG47kPdf8o
 iR4l+w7mC3ZlCLHUuFLGk5FyJvUno59g/XcU84nYXiq8VnAJ68UnXeeiqo8ekKM9i5to
 hmbmoYD7JjO2i+HjsqIy4Ag92y1Sh3vCjJSKiq+w6D78QNTNGTS1b+pfu0wEu+fyN40u
 C0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7yEH3kbZrvxgk1hAH/bRtjPyjVZmsWY8zl0kXH1TcV8XWzKkvRL4/arLkazJf8gdpqBWpEZE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6oS4VgEjnJZSZLYS8XnNxzA6y3PXIxvEC2RnLSDQNAVAB+sGh
 393APvVYWy5LNCbE7kiaKOkjxnYlwVjrWlY1CcqzrvE4gRxHHpUuFJafvTlbYzIHHgNSSO57A7T
 ntDnm0VfaEc3LcWMfzBv6Cv6VRxCgrfW9IRPz
X-Gm-Gg: ASbGncuomf3PNEA4Z/yRH7oAIVKRrJD+uPpfjTZfb3KZ0q4Gbl75PHgQ8VLS1f/nf9G
 qu9y+Pvwu3luXNNXnzYd++uzK4TxCjPXqC0cXgOTVJth1/3GZla1dQh3fG+GwJXE/5J03eWjKI6
 KrSqy/UKrneC1l8rvHhYp3RALvv5U=
X-Google-Smtp-Source: AGHT+IHLaPf4OTw+Kffezg9iWTfsX5oc9rY5EEb5vqVsw6GLsFko8jWnA3JGl5XKYzKDaM7OVpexNzoc/sJBfEdpEl4=
X-Received: by 2002:a17:907:6d27:b0:abf:7a26:c485 with SMTP id
 a640c23a62f3a-abf7a26c67fmr771551966b.50.1741102631641; Tue, 04 Mar 2025
 07:37:11 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:37:09 -0800
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Mar 2025 07:37:09 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241018030027.842749-4-sjg@chromium.org>
References: <20241018030027.842749-4-sjg@chromium.org>
 <20241018030027.842749-1-sjg@chromium.org>
Date: Tue, 4 Mar 2025 07:37:09 -0800
X-Google-Sender-Auth: SJALiyQmU-33_QWk4i-HUR1ZE1c
X-Gm-Features: AQ5f1Jq3dvkm44Yv6abX_jsTIHkx6GCRKdOsJWUa68r2pzxu4PQDwh-KoN_4x6Y
Message-ID: <CAFLszTg8UgN8ER5h51Nii2jeu6etGqqZthfb-5TyD_+entx5HA@mail.gmail.com>
Subject: Re: [PATCH 3/8] membuf: Rename struct
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Marek Vasut <marex@denx.de>, Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Rename the struct to match the function prefix and filenames.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/include/asm/serial.h |  2 +-
 boot/bootmeth_extlinux.c          |  2 +-
 common/console.c                  | 24 +++++++++---------
 drivers/usb/emul/sandbox_keyb.c   |  2 +-
 include/asm-generic/global_data.h |  4 +--
 include/membuf.h                  | 42 +++++++++++++++----------------
 lib/membuf.c                      | 42 +++++++++++++++----------------
 7 files changed, 59 insertions(+), 59 deletions(-)

Applied to sjg/master, thanks!
