Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C64CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5431848AA;
	Wed, 27 May 2026 03:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJ+NB6Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3422284915; Wed, 27 May 2026 03:17:34 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443F984869
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd22b2abaa4so1789041966b.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844652; cv=none;
 d=google.com; s=arc-20240605;
 b=k11BwFvxW5HO9ZPo9coCIXbvHNELJH4rvBkf65YxvVkmo3eNE65ZnVfQ3PcZ3sqMzv
 4QdXQcpPrmdP/M2CabNemNHl+EnWGqnR00Bb1YWqWS1zAGRw5g0ieOcNuH6e+SndSdhO
 sQxOjKHrgG4oKWeTtUnukfamVQixTwEfjrb09wNNLUgUz1cyUAOOV+yPeB5bupgvThro
 eQ0W9HG37VfDTlU642JDlKkfGK26m+ES8D/oD0Ps4GFoueYyznFCkvnELVeu86Pzw+2I
 uidV7lPXKBtUr513/3bUWk2+MqwJiT6steqcu2o80lxJY2Fb+2tdAqEbRvXPEE+HpwHG
 eawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xXNrCcYvfHRqljekj3F7sPXq9jC9D0CqCKrFyIrr6wY=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=cUY0XU7rcvZcdP4/znf+MS3dhG/WJP1stOsUiVv62GeBqqK4R4dUY+8vFqD/T69UF1
 Eknsa2l8f8U3yH6e9IVP0YNc2CBM1bNluXdeTZFKIsU8B8H/RMvLnGijYJfefyTwvOWs
 Jl3wsPS8fWHjdzX3AqEor3+l8lNfzdOmxS5YIqPugBPgrrPpYoR22gaI4tOFEGdmgPlI
 4Byo5WgoNEm+MrK5PD3bOYddsbcJRQAnzohwcSxOo3f5lGyDCPeBE2Wobt1/jiZhPHYM
 wavruAbhj7/psj2DPIbhxHznR/dubfeNNyKJLMR8neenZHCrwwOnMToGj+KI7anpOKHg
 9uYg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844652; x=1780449452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xXNrCcYvfHRqljekj3F7sPXq9jC9D0CqCKrFyIrr6wY=;
 b=EJ+NB6MldtmTGMgNPFR5FsLbIVUERa09+2orar7Q7d85PMbyRcBOmFXlpLY1PCEdal
 4GNTqGikAW7xuA8ZMxgB6B8hSIP8QHKD+evKwrJ2VtMMH8/YpITT68TltmxxhmWVpZBp
 PB/KjNnSPro0pmzndtQ0vVR0+Xh6T51iJpBrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844652; x=1780449452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXNrCcYvfHRqljekj3F7sPXq9jC9D0CqCKrFyIrr6wY=;
 b=JIkfZ9pYfhqXAWHX47IgVyzcYDLWJOEEz80HNKycg1j2DQBFrUMy3t1EMIc6tfzYYK
 F+dsQiL31c9ODyVZBf0wxI2tAJ2d08I2BL6gBSluVkW5HMGtcYUHjbgxRTD3e2yVa0KP
 z1jZPdy3gHoUixzKEVmj6v7+eVSiR8UAUO6STbam+dsoKjSVH4ND01ZOLruwaHQvc/ri
 bpPjGel8oZMU+k8oU51kiDcF+T+4Li0FkeCRW/wWq0BZP/vfi4Jau1X/D072Z/H/8Dzx
 pHR9j+rLHMUeGL5LsR/8GelHhz58cgvKZ+5GUQeXkyz5DyLdXcPBqli/fG1xQdxH9sL6
 UHKg==
X-Gm-Message-State: AOJu0Yy+xdWvMs96soM3yn8x18UI2plWIQTw3dEe/jLEQJVUhDGkWInN
 pGyjRZC0kZ0W7qs9AbrQVSwKI+LHkuQo+tthotLkANE0QSybP2SxFmTPU55bqIk243K1FDDI08Y
 Wrz20e/P9MHKD+k3Iaz6OP7RSKhEVsg4oD/OaZnPv
X-Gm-Gg: Acq92OHU11Q4o5FsthqPbZujkWCAdXtqZx5Px9tDTR2nfAWANMrRK3zQVfa+dD3BSsV
 4Ol06lykmjdnVqZ9/3i39mWYHTqp0gmJGnR/P8OUt5zBlUlA+WWSJbrvXrEZEgfYOJZ9PhLJOD6
 ftRnl3TSs7EXLHI/1u3p0QuC+g8HwUEyDNKzOND11/zLuPOSkTODnROBAwl4o2mt3qc0HbPSfiX
 9Sf/ol8j539kHjkSomv+z7cno7CXLG1fXjWg1bY3qa51rDQ8R7paf/uWZEb4HpAGGuQWHH6hWlG
 3BWIfw==
X-Received: by 2002:a17:907:a789:b0:baf:19a8:b44b with SMTP id
 a640c23a62f3a-bdd276ccf77mr1285946566b.25.1779844651748; Tue, 26 May 2026
 18:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-2-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-2-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:17:13 -0500
X-Gm-Features: AVHnY4IZlX30L7sCplg-viNe1V7TMo39y_ZdkqXTuwhkQwpW3KsIoZg4KHSlTjk
Message-ID: <CAFLszTgXX9b_n1cgymLOStrV9+Fj4G1DXojyw1MGU6xmzUCBNA@mail.gmail.com>
Subject: Re: [PATCH 2/6] net: qe: dm_qe_uec: Use dev_read_addr()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: qe: dm_qe_uec: Use dev_read_addr()
>
> Use dev_read_addr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/net/qe/dm_qe_uec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
