Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F49D2F33D
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 16:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D8D808AF;
	Tue, 13 Jan 2026 17:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cl+ZVBJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB76808AF; Tue, 13 Jan 2026 17:13:27 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F87B80B98
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 17:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65b73eacdfcso1753852eaf.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768320802; x=1768925602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MjZGTMU+82Y3HjPlLF/7b1Hpv/CSdyZTHOcMZz7x4o=;
 b=Cl+ZVBJ6O/jptCJOxmvdP755EIgN0poPgJHGtTM8TcI6qi/8oJSAxtiNaWqOb9kNzz
 DnkK7AAZuXZ9pz0tVaxeUHp6nPWAYwy4cu3+3HV69L374uGtAazpFuu29Nk4k2YMr7QO
 Q1Hup0XnQm6oLiZisDOQBcTgrXXho0uS13GEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768320802; x=1768925602;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MjZGTMU+82Y3HjPlLF/7b1Hpv/CSdyZTHOcMZz7x4o=;
 b=N7SX7hYvS9U3Dxxd1iZkmpjV4lJoq1ViKbbM/ei2aS85kOGEZvqdzj2h1gGRhGeC+3
 iiGioLKCrnuCJg7xyOqBBm8Ne/8FSnvYKNUPAHCQmtAToGigmdAjZ8dCDQEvdAi692Gw
 6kqN1v95u65LE8/N5RH02ZA//gk60YrXSR5tqj6JKvqfmAQMgn4nGtHoyaOs0bPyRIlB
 LNeR0vee3KhnEmde+7aPezXOcStsjgCzqXmkQvNbCEzbvtshVrFoLXFIF2gBbxARy3TR
 u+3FjHK0JZnl7H5X9Hiq0T4xgsXeAKSAg2qK652AZ1CufXiCg1IZCBc2We5OLuH/qDtt
 pF2g==
X-Gm-Message-State: AOJu0YyuUgkQlKJ8HFiaqhRqJ79XOl6XunwRe0h2UuN+nxdvciK5szaP
 3taYDg6lHm67U9h7DFZ6mF/KmF4qPaOvyWZoKWQFHAWHGqRMd82JpZ+4r5OJ5ZBfGt0=
X-Gm-Gg: AY/fxX7DeDMDeRSEwhnpq7mVqHPv3dCO6a9MuuaIwo2q1uE3T3lkAQIobNq60ynYYBO
 x3V/GsfvYR7yfbCxfr9zgiFeDyZ/Es8jHTU0D56YPinsOHHNdnvwbqMftz/a9zMnHilNOdeGJtT
 zL6FIdkmIy4nY5BFwR4DQc5aJg+rAM04uYGKcRPAaGHnAN9IAiyn34Yb2sZtOmlKtloUMHMXNiE
 uWHIeiPOiu72pmslpD7IY3SmMQvb3EWsXOJDWRU94VNV5YUMASlIdxl4qStWVYeCH9ui+Bpkp0Z
 d05eR62u5mHxVFENdLNJAulhBAN/oeoQnOMhFFvGkk+xFkBT7A7/iCPxrfvm7xfYmHzK6VMhyqW
 JAq3KoP3A0MNrFVLPIiPHJvUWmjcsAVGigrVdA7ElcL6LAfDL+A8RBVbcKyrdBTRXh+LZlmXRhK
 P4SRCmbKi/tble1pFWMncqrFI9BP5auumSHgJglH15p0xWnwhHy9K+JyUzZWXfH7g6vqfp+U77T
 YGq2S7a/RY648kGZ0eqztVn3bEHqEFQTPSTRw==
X-Google-Smtp-Source: AGHT+IFjOBFkB9wEbD6KSDoW0jHSH+6Cf2wIHeXmYv7+bHfkZzZI9/lNFeVkGPUGpy2OB+qHYAd+bw==
X-Received: by 2002:a05:6820:4d5c:10b0:65f:5296:8558 with SMTP id
 006d021491bc7-65f54f79fe6mr8336092eaf.63.1768320802153; 
 Tue, 13 Jan 2026 08:13:22 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm8575162eaf.16.2026.01.13.08.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 08:13:21 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20260103001759.182898-1-marek.vasut+renesas@mailbox.org>
References: <20260103001759.182898-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] misc: Add fixed-layout support
Message-Id: <176832080148.2039494.423415495170852185.b4-ty@konsulko.com>
Date: Tue, 13 Jan 2026 10:13:21 -0600
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

On Sat, 03 Jan 2026 01:17:31 +0100, Marek Vasut wrote:

> The "fixed-layout" nvmem controller subnode used to be optional wrapper
> around nvmem controller cells subnodes. The "fixed-layout" node is now
> mandatory in most cases, but in order to support both recent and legacy
> DTs, both variants have to be supported.
> 
> Implement support for the "fixed-layout" node in the most trivial manner,
> check whether the nvmem cell supernode is compatible with "fixed-layout"
> and if it is, proceed one level above it to find the nvmem controller.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] misc: Add fixed-layout support
      commit: 6014f87b03d2c54e34aa574dcec375804c030860
-- 
Tom


