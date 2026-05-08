Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EBFCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 23:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1517884DFC;
	Sat,  9 May 2026 01:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OOes3b7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A8E84DC4; Sat,  9 May 2026 01:14:46 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D47D84CE3
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 01:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dd73b7c757so1348326a34.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778282083; x=1778886883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLyEvqxsUcAx8maulCyO5wilOgsSboBxxMifQRKdpBo=;
 b=OOes3b7f0WG2BtKh+FdgHoq3sEFVdyFdZQ1gyVsYsoY6BSVlVdyRX7PwGPRBVV8pZH
 n65e1kwqjKJ5lmP8ibyzbqTrtXhntzDrNXQsb2vLVvjXAXp0WSPdPS5yxX/otFA7A+Fe
 +6uSOiWKMXRPxejqO6FvvBeE6OI36nzPdl+UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778282083; x=1778886883;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLyEvqxsUcAx8maulCyO5wilOgsSboBxxMifQRKdpBo=;
 b=ZRWAHqrv0q04NBtFhJ5MVuN3o5jIOEU9UwyUDY6rwrGbsPjMxmTTkv1SJEBSjRldPQ
 7bEPz0E0sFc7vXpI/IPUVFAOGtASxBfqkB19zXPY65v4ivWrAuchLFEyS7A05rS2EAB+
 f+yFER0WIlkWLlGNFwLyByuS3hUyfjGAKFd/ZiVZuE4SPPi8aQWKl5HtlvPaFb02oEDi
 xsObkBszj/2TXRPIN/eqr5waIUuT+4B+bmolyJKeRYewY3sU7Z731a4Fx7A3jDeqTSXL
 Q8Ov0BeZO9769bOHdkzXFem4BLsSA1YYjrC+jnLwX5sGCDMi1AJCiD4T9ghWLRawx4h8
 peRw==
X-Gm-Message-State: AOJu0Yyy1EkKIi38Xod5mg88NVoFOTjLzdp0HF47j9xnlUFyM8mmAmVD
 RHWX3ht1veEWnHh6uk/v4vgMp76dYHxm7B5M3P2idC1TwTOIx65KZjzuKmUxAuFKh6UStZIlBZ6
 /19h1fPwSbv6f
X-Gm-Gg: AeBDieuIEsjzk/SvL4fBXX2CtnIGCACK2D5M8sSh55rdYLpCaBflXDj3E83JYDZMw85
 MKcwRg/D0Eb5n/3SrWlwYGyj4PZ1j74H9cP5P7TRD9ig8eut3gCaGiA/GWXqoMK1qePviVBIAdP
 ftgqbTze/IqSSRbAoWf0Vq7iGuYeiIpp4pqkgUsbvBTH6agUjSHQ20rhG57Q8gRRhEuND7Mgdog
 CgcYCORouNh7CcYWwAA4Qbf/qfwyiwMOqGTPAP9sj8yJGJbhUNEXO/dBOzOgm9cN/UHghCF2ByJ
 H/c6l+Em3ESjyLiVIawUBS150L1xEnYNMPp4NB3XpQ1nid0ssHLRZAdmmL9O0ZBtWdCgGDN7wP/
 T5oE4Lne1OWDq8kjrVDkKmYJmkedmo44WnBO6K/1GeuTTB8zEQklNu40mDM5aofIeAeekHH/rIt
 Xt3OXhDlgEh79tjwncXMvDKWwYQugJYu9vQlMBQi9axUVBlP+UqXOe3hdQtJIJ1tSu/SRPNxVcp
 +h9AEyRPTwAWkA3iF43aCjLQ1BjTRlgxgr2e0pAXL82wl+wLBAeZBCM1kmh
X-Received: by 2002:a05:6830:908:b0:7de:495a:cf80 with SMTP id
 46e09a7af769-7e3821282ecmr195136a34.16.1778282082988; 
 Fri, 08 May 2026 16:14:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm2005082a34.5.2026.05.08.16.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 16:14:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20260501055112.3966757-1-aristo.chen@canonical.com>
References: <20260420074827.3917463-1-aristo.chen@canonical.com>
 <20260501055112.3966757-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 1/1] test: fit: Use shared make_fname from fit_util
Message-Id: <177828208195.1997265.16702012102780690252.b4-ty@konsulko.com>
Date: Fri, 08 May 2026 17:14:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 01 May 2026 05:51:04 +0000, Aristo Chen wrote:

> test_fit.py declares a local make_fname closure that is byte-identical
> to fit_util.make_fname. Drop the local copy and call the shared helper
> at all seven call sites so there is one definition to maintain.
> 
> No behavioural change. Both implementations return
> os.path.join(ubman.config.build_dir, basename).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] test: fit: Use shared make_fname from fit_util
      commit: 28eed2103cc3eb8ef4c07ce514114961c0414aab
-- 
Tom


