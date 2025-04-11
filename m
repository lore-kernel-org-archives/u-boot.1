Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07A0C369AB
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 18:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0CC84205;
	Fri, 11 Apr 2025 20:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E8bOSoeo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51177841DF; Fri, 11 Apr 2025 20:10:38 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F057841F2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 20:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bbc03d436so1371481a34.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744395034; x=1744999834; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQp+1mR07m4A+EPKTZSa6BzZPJXEuNX4TLLYH74uGE8=;
 b=E8bOSoeooz0DApCkC7RmP8i7S5H7BujBJ/Io1iLoKG1qBjZ7EnnLe6W3RuX215Oq+t
 LyM8vIMZmoAjCrori2bcfFF/ZRK/CImX38gKVjkgEl0mrtxFFrUWrSn7Cb2SPQeyp9rG
 T3DRI4yOVhs3UsPHbdDK0FMoYDijvTOv84UFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744395034; x=1744999834;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQp+1mR07m4A+EPKTZSa6BzZPJXEuNX4TLLYH74uGE8=;
 b=UYFBauHbqmvp0qla4ic0BFXnshmX0/AJdkTnPElgXm2qPdjs2GzFKYrb/r1406i+rD
 8RhxTX3VDWkH2IykwyHwc0+zc17uzpKzcL8AYnoySfyVhp68fCmMMo2iQP3RSjkk2rve
 6YRD5Yiz9kv4tjA17Ay6p0aHZrAmpdwsObB16EQG/JUcjLBTNxmOtsFGCM6VyQz4rywC
 /7NJr5G0mwUkcyiwfcsdIgxXwrCAJ7pHPFX47W/DwjwoSiseYdcA6SGGaUKNR87K1pzY
 ej7UbrHmNMHwjysqUNqp+Z1mcJCLqhf4w5x/FlXeDat2AO874x5eSwDXP6SPovWWUVJw
 ZJGg==
X-Gm-Message-State: AOJu0Yy0Iowiq/vg8/J5ZB2PtV5pz/i5SXc+TSrf0ScLgzscTAYoJD0U
 SEWIm2/RY4Z2Y1jt0XjoXWuYaIX1SJMAuOlE2twQPbK+Ew/jJkK5C4+SWkcTP0HLl22flbmdEMG
 dCtM=
X-Gm-Gg: ASbGncv3RaaOTu4/cqrRkxMgqCKeZJYLfJkb1hOm0frihad/5CWf9+V/X2Pj6FniG2O
 g3v5GfB980RIjZzcFLXUvjBJcnvVGv2PFEGMTIaabTfw2zD5SOpm31XrwNB8PQMuBGG9vu6GOPr
 o43GK/q2syW5YFlbDH0KbNPx8RBRtSkgcBUHHy2q/mFn7MNv8Sy28kI+EmWNiscGetJQlFRO1Zi
 qtpTGbn3DP75CUGkIUyAsRaRTpoiAm91G9iUAzmBajx9F00lEGzgqxMvrD68kIhwB6bdwgW4NkK
 FTFXndG11vtF+gac0GNCi+Yc+naHq4rcL+yLL2aH1d/COyWy+GkIvprtgEI7UBIP7Za0mk2Gx5X
 S5tX8+qGIxJU=
X-Google-Smtp-Source: AGHT+IE8H2viBBv2MOy4qmT9XXjo2k5Vjr/JsWn3I7aNaP4dMMbK5DLEXjm+t10eakmRVQsCZ55KAg==
X-Received: by 2002:a9d:3e06:0:b0:72b:8889:8224 with SMTP id
 46e09a7af769-72e862fc710mr2041959a34.10.1744395033864; 
 Fri, 11 Apr 2025 11:10:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096a20194sm1261969fac.30.2025.04.11.11.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 11:10:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adriano.cordova@canonical.com>, Bryan Brattlof <bb@ti.com>, 
 =?utf-8?q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Pawel Kochanowski <pkochanowski@sii.pl>, Simon Glass <sjg@chromium.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <f7894cc5-7f47-4b75-a722-7c0e67c3c7df@gmx.de>
References: <f7894cc5-7f47-4b75-a722-7c0e67c3c7df@gmx.de>
Subject: Re: Pull request efi-2025-07-rc1
Message-Id: <174439503254.3256164.8969124570025638814.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 12:10:32 -0600
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

On Fri, 11 Apr 2025 14:57:55 +0200, Heinrich Schuchardt wrote:

> The following changes since commit cb7555e93075114fe4af0adb806877ac4d4ef80d:
> 
>    Merge patch series "*** Add Ethernet boot support for AM62Ax +
> phyCORE-AM62 SoMs ***" (2025-04-10 15:04:09 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-07-rc1
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


