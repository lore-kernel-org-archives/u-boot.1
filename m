Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1C9E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C77728032B;
	Fri, 20 Dec 2024 05:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PQGhLIwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9AC8042F; Fri, 20 Dec 2024 05:05:23 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A84D080362
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso299837766b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667521; x=1735272321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cPtpfDgCHtwjuaD68hNUFfbGgc32TKMEm/JXZkT+a6Y=;
 b=PQGhLIwgTK9S5iaOs0ytWTKsvs7PifgAKDHib3+mdfseSCTkMcBANYdF7//N6RWqO9
 yKW0G/58dZ5wt1ckDUpoaWKNKKdrrVYCZnNVQKsY9EMN9mU5UpUJTIFFVkJ/q9jR1A1T
 qpp8SygHjDF8hGYDVFYkdnh/X/gVHq/5BFFYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667521; x=1735272321;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cPtpfDgCHtwjuaD68hNUFfbGgc32TKMEm/JXZkT+a6Y=;
 b=KYDTh0bwnf/d74SeVrfJ1fSx3A6bLOjneEan9e9wbU0uD2CWLmzUgJ1sy5zBhziQZY
 U8bnRPsJaSeAhvwV7haOa3WekEshPmApqP8JBoh88WNSVFE6pw2sFanoL5h8MbXw4eFV
 XcRkLJzF2ngZ2pDRZIZJs9m/dXNTYlou9jnPkZfy1yUWhZ5V4FWGXmxtRlTdn3tViWZx
 GpVi3AYi7gpfjpnJk5CUx+zOEl9pzUSpVISBY2bfHCBNUmEXoEoM6B4x6N3a7prKf2oL
 WMtM3ks1SKuetpaO0wvD7RU75wOdy5T9UtrAPGmFb+MJ+uN+bY+lVWpQCvqEFb0NiJqV
 jqrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhPl/GjIyk/NsZar4ha2mlPpIRlncuca+F/VBA3A0jcMjoUZIbU3DaM8cchQIBBWwso1Mxn3g=@lists.denx.de
X-Gm-Message-State: AOJu0YwUHsOIE0YmkelRQ3Ul+45VfS4+gHbVNEQtSAOuX0P3cu3awsT0
 uysbUmZcRtJZI9nHUQiTjKZ9E0lSAfmEPjNzHqvF8A5uQQ4PXSMFjb4G7PeC5rINGSgn8kAAoNW
 mU45qEAwuPiPgfMVP96LtbsGLFXBQf4QjsZ+6
X-Gm-Gg: ASbGncsbPx2Cd5/F7Lg8qc8NTsfuSSgnvmpKnK4X+5R1+6kYDtvUVAnifPxukBFA5C8
 4NuhE4nLzuHs88h0yQBv5y5mTrmFnS9jyPEz1YI8=
X-Google-Smtp-Source: AGHT+IEBbBi2oKw/ftkL1xhKbrF05iDf5ZxEidh2zXSC1zg+vzS2/PhtR9J8PRnlK0bU50iXEWrFguBfwTL5SE3jJXo=
X-Received: by 2002:a17:906:4789:b0:aab:da35:d95 with SMTP id
 a640c23a62f3a-aac3354a01dmr89208466b.44.1734667521141; Thu, 19 Dec 2024
 20:05:21 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:20 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-37-sjg@chromium.org>
References: <20241206023626.2456858-37-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:20 -0600
X-Google-Sender-Auth: TiNy4EYcEc4vwlzWDbbhDE3Svq4
Message-ID: <CAFLszTg0vO1reyn-RNw21-19QLpqp-JyQB6uuCU1qN-tJ_V=vA@mail.gmail.com>
Subject: Re: [PATCH v3 36/46] bootmeth_extlinux: Move pxe_context into plat
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nam Cao <namcao@linutronix.de>,
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

Move this struct into the plat data so that we can use it multiple times
during the boot process.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
