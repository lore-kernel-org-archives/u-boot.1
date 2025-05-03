Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22ABC3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DAC82893;
	Sat,  3 May 2025 18:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Onqcqfu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33038290A; Sat,  3 May 2025 18:31:38 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A20682905
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3f94b7bd964so2433047b6e.1
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289895; x=1746894695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTyHf4usH1sApJXl4hdbeckYVhHxkAYU3/22ye6Io44=;
 b=Onqcqfu5d4VMJYMNn8h3k43d48BtY0WgKv7jdL7/M5JAJmxfBo/vg/f6V+dzfxu1ma
 o3mONUZ9uxI9g1a+dobYK/kThozOIngZLdwcPwjDDc0n7IbHmzOv3nZ8d3whPXZ2f8U2
 VZ2I80/ZwwaBKW9KVxosqzEi/+WMHy2Xo5d2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289895; x=1746894695;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DTyHf4usH1sApJXl4hdbeckYVhHxkAYU3/22ye6Io44=;
 b=aYqf05aLjMHsRTyTEBhE6h5TAK6VZcmFMakfqNwCGYFX3LXI647lNluEDw1lYkleEh
 Hix+EodyHTp0oS5vPvLdyneGbR2jjfc0UE2/aNghCeqCRkZ/Iba9+Dt0rNrLBqrxIv8/
 ijP4Pp22WjMbYWs+Ryj9YoZDdN8K9zNS3kRwPVc27+dF9C1RWlABmhuqWzz17EGGUiz1
 uhqM+xNBxMiEfnpnTdBwjHR5m7A/x/oGkBlHYu9nkkHLwYWNXjWxW0wHtDLYxN0kCdxH
 GZIdajXHi1AOGpQ20CjRadeZDtkIKbayTG1WnPXEeyAIi6PiY+xsLH780DwQffCHPXNo
 /5JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8uoetqO6HvSqDdxv2HoQUhtUduBd0OqTT7FhhLbhSDeRVT1j4jZ0B4ij63ueZESkupTkl4m4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0YI8elCKJxzYDUU32ViK0phohHhE70rZlM6Sw6FFuMbO4/SXx
 je3pZkzisGcExTeXYJ6swCr/hL3Gv+F/CVpTp9OaiXD/g6FXjtvE/6Dp/GQpf7U=
X-Gm-Gg: ASbGncsB1O4FPnnNHL2dct8g/GAY+ejjKABptGZBJbKYXKZMgrHb20evl85xuUj0fHf
 2bHb87UrTOE770Bd1GOAGyH35qLwWnYdxHY1m3GSbvKMkyubAcD2mUrPMNh/93fe2y0SKQI6A4o
 DhGbJdg7Jvaq48W4qW7gWiP+wpgEVtZgGa+78DjGTjGAWv8xO2VPoKfPAgt+3SREz7gTaXUF1Wm
 B2H+stpTm2T/S4i5Iv7huLGnJkMfGiRMNd2VSn/csOmIcF5EP7tBI/Mx7eoV5QOL7r3B9+hGsjq
 sBOAlwMDLZ8h3QjqUTQaq0WLGEHgwLbUlGvvwZIlZ5T9hSWPNjb66ZFr3+M6nH/YKuxHfnOBYYX
 k
X-Google-Smtp-Source: AGHT+IF00QVXW6Y4p11j2ul53i8yEv+YEFJB40alS2dZWae80/rUTNZfNJmcS//AoyPoMxu4wSfAEw==
X-Received: by 2002:a05:6808:80ae:b0:403:3973:23d7 with SMTP id
 5614622812f47-4035a55cf08mr822612b6e.11.1746289894987; 
 Sat, 03 May 2025 09:31:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250425173120.141503-1-nm@ti.com>
References: <20250425173120.141503-1-nm@ti.com>
Subject: Re: [PATCH 0/9] board: beagle: beagley-ai: Cleanups and stdboot
Message-Id: <174628989369.1571566.5670970325344450292.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 25 Apr 2025 12:31:10 -0500, Nishanth Menon wrote:

> Spin 3 of the series.
> Just happened to get a BeagleY-AI at desk and happened to test master
> branch (7dd49a9264a6 drivers: scsi: Add 'erase' support), noticed a few
> issues which were rather easy to solve.. so, here we go:
> 
> Current series is based off:
> master 9d3f1ebaf875 ("tools/make_pip: Use venv when invoking pip")
> 
> [...]

Applied to u-boot/master, thanks!

[1/9] board: beagle: beagley-ai: Add pattern match for MAINTAINERS
      commit: ef4d9621376ef9e2048fc935b7cc7c8aa70b4b06
[2/9] arch: arm: dts: k3-am67a-beagley-ai-u-boot: Mark main_gpio1 as bootph-all
      commit: 6f478ce788e9137ede4b085330d35ff91b919285
[3/9] beagle: beagley-ai: env: Set up the boot devices and boot methods
      commit: d096ff98c88143d58e32e017a607f54b61c22cac
[4/9] beagle: beagley-ai: env: Setup scripts for LED control
      commit: b522c3031e34b72c416a83fb542adb954f754f3d
[5/9] beagle: beagley-ai: env: Enable DFU env options
      commit: ca24877039074c4585ed87d58b2e7edc15217d80
[6/9] configs: am67a_beagley_ai*: Use saveddefconfig
      commit: 4786f89c1222fe52cc1d0d594588f1e2d488fdd8
[7/9] configs:am67a_beagley_ai*: Drop un-necessary config options
      commit: 208ac0681edba07601af30815ed50052a6286f06
[8/9] configs: am67a_beagley_ai_a53: Enable additional features
      commit: f8924c373bf88beb366fb1807def93714a9d5508
[9/9] doc: beagle: Add BeagleY-AI documentation
      commit: 9f5f9965960fa3019c27609bc1baedfd0ab4bfe6
-- 
Tom


