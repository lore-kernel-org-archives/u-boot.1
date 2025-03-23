Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CFC28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEE181FDE;
	Sun, 23 Mar 2025 13:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cMfQqu0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC8882006; Sun, 23 Mar 2025 13:23:54 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB8781F6B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso15876055e9.3
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742732632; x=1743337432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GWINQhEf3bvRFeXH/KZ/WkLlnUjwf83G9/Pzik/HTu0=;
 b=cMfQqu0wzrtcLfM5o8tGAflO8iFFNAB2jbJged36zQy1Xyynr9O/M4PXU8Xpf4XE7s
 tTjqEogtv9sTtRaqHDeSK2cKWFFEWpuaZxGM4bvV0pfmE84mIDZWBAjFaup0S2uleue4
 CdQ3iocTdl3WZfHW7qPLZ5jDDwbJs7u4dduxz6jaYm5qflHb89rNKxb5ABX6mTYblPxk
 5H96TgaV9sWOHbg5tsqcbpsmvddsibG/i5hsOgRyxSufVKlUcDP23nKvivGnP1q4FuiU
 t1l3bRlZZ/gOQZuyYgxgBoFjk5nnDozj2AtKi3f5rd3vJtC22WOjBMvXrhAcj6+UuhMp
 bhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742732632; x=1743337432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWINQhEf3bvRFeXH/KZ/WkLlnUjwf83G9/Pzik/HTu0=;
 b=dL8MsHhz2os6+HhNC3fFrotopmPJ59rPoMJjEDh8QChIGlKUOoxa/zuCT7a8Um64tI
 CAzj+ApS9LPfkWy6J7CpsdRc68ixw1GCewc+cAYl6yfWAW5PMlqNPMR56wtHrZpkcF3k
 kFJlEK0/SFqnIL9fOjPJkF8tZCbdhxmrlCl7P4PFjxFZ91zzf+FEm1Wa8aKLev/Qw/wl
 OGAO2hmIn7V9Vm7v+buAGBtUFCl38ILSfxMtBWgbjzSpR8GhDnVU+zLQ1dFI63jNHt8m
 v126Je3c9ssKCNWsFdq4g+YDSiSRRVY5TdmjIpCA1I+bcw3hVHSh+MpoqyTfYYi1sEO+
 vtog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd70dDsNjDzOqCf7x9ziWYlB1cDrJu17zl5E9F8978vFE9cAg0IB2VYy9Zh7AcMjImC4slkUs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt0+bcwI57GOMlsid903rB5ap64rIXum8QBENth5jnaXFJwztl
 vyuL7kJ5WUchgyhqzz2I8a7kcjwIavaQIoG8DaTv8e/H3HOCLIs8
X-Gm-Gg: ASbGncuF31dg2pMg3QIUHb9OTFgpIJ8kMNXek+37OXPpoinJPiJZiI0Hug3d/FQknMm
 bqlO7YvGBMRigMm/AHG51o4n7gfvV187tJjzJW1WLnCgfwV4bTdD+A6aW8ZL3U9VBGn/3CxRLO9
 rOcPGoxm32toTE7+rmW/Q6qe7o6oqBbyWM0Kzoo6NkPSHwRcrgtDIO17lynFd31YKgjjPmlLfF9
 CFIgxELR5SARxVto4zW0vlnETAUvNIcjX7U1gpqBIF33C0V5KR4yp6bunZApXgRshMInnBIXGSa
 Ni4gP5W3bsFAf5RXV2wx9XLxh27mxbNmfgrlDX8n3ZIq9N7jk0YcTmMEA94nQyCwFtgGB6BTOPw
 /2TGR5Y8zTy1A7mmxvuUL
X-Google-Smtp-Source: AGHT+IHWYIDykrSkcWLVoOhLr5WYBU8J30jGqcWppneK8eNXcXJO0NcDVZn5clllrdSb2RyUQ7vtUg==
X-Received: by 2002:a05:600c:4684:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43d509eccf1mr78920555e9.8.1742732631755; 
 Sun, 23 Mar 2025 05:23:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5536sm7850102f8f.54.2025.03.23.05.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:23:51 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 25/34] sunxi: arm64: boot0.h: move fel_stash_addr variable
 to the front
Date: Sun, 23 Mar 2025 13:23:50 +0100
Message-ID: <3865744.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20250323113544.7933-26-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-26-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne nedelja, 23. marec 2025 ob 12:35:35 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> To be able to return to the BootROM when booting via the FEL USB
> protocol, we need to save the CPU state very early, which we need to do
> in the embedded AArch32 code. At the moment the pointer to the buffer for
> that state is located *after* the code, which makes the PC relative
> code fragile: adding or removing instructions will change the distance
> to that pointer variable.
> The "new" Allwinner A523 SoC requires more state to be saved (GICv3
> system registers), but we must do that *only* on that SoC. Conditional
> compilation sounds like the easiest solution, but would mean that the
> distance to that pointer would change.
>=20
> Solve this rather easily by moving the pointer to the *front* of the
> code: we load that pointer in the first instructions, so the distance
> would always stay the same. Later in the code we won't need PC relative
> addressing anymore, so this code can grow or shrink easily, for instance
> due to conditional compilation.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


