Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A2D41D67
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0B7830E4;
	Thu, 11 Dec 2025 17:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="knYmJC9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866E38367F; Thu, 11 Dec 2025 17:27:39 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB1698309A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:27:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2e3c3a83so152084f8f.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765470451; x=1766075251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQwYtVauKLbeyoqSg/f0IBtDSm0J4Au2GIrCQ1YM/mg=;
 b=knYmJC9lpgLCOtSbYRigoUvATjDjG0jYIpwXYWIxK+Ei3C2XDEgOFiJf5ny0y5IY6k
 fcGTM0pRjNa0UF6PWiTNR7brEgWrOsMj7qk/LgbQPTFqeFQxh1hb46KBDKcitAZuuog+
 hFibIaoqIAEWztxV7cPXTAF6759cN2Rsu6U1hbnni9Oq5vBI6z29l2vN1F8JKIhY6ZYk
 4nsAzRCK3TsCkuIBLlK7vzD1SrS22+ljm2Pv6PNQ64ONUaVYAq3Z/do4ECmp9R4Jf5Ze
 KkXO5TtrTaZrlK2n5CmMmPlEHHUbDVo27uZiRnHYhx7SSqr+F42ZKNhAo52Ia/RKiKFC
 yr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765470451; x=1766075251;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vQwYtVauKLbeyoqSg/f0IBtDSm0J4Au2GIrCQ1YM/mg=;
 b=OrcnlcI11hS/M9JASUwk3dZarfJFtVsu9rzjOilVUbKfcDt1XYAw5vyCNeMxSCcKuo
 +ZvtjUrU09P7EGjRW6nQLX3iGk92AMhpZJiWnwBuu9uLBHI4sZSM40M8icTkxPxiW0Dv
 u8t1ETLht9rmfvkB0XJ1eHztU4HWrc5gZhWnJpqY3Jt1Zf1oGwIR0uiaOGbBKYfwJWDx
 qWIMR0M1b7644149ehO6oxJ4WspktQ9zAqMzfDq/aBQEjSTufv72IJ1CcWRVwzxh2z3W
 CqEwsZxC8cjzNufyYob2bLyNRpwEoB3PxdRFJ9JKyV87lvQeuKSoHJLoGZjZfraWN/Oh
 LEfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx6v7uUb0O2QTSNYOV34jVoP4ut33ckG7oMZF/xMJ1LCiKK/RxFZ2k1HhOWfkl+oRvW3xOOGk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyuk8SvtClH/3wEyX0pCb/Nt78/FEwQKjRZOMYz3jOY/tF4G4VR
 boIjCt+D5R3qYvUJ0549ZvZDlDJ5L6BySm4oNsovA1Bb+pLTrOfO1nFN4vkbyCo5lHY=
X-Gm-Gg: AY/fxX4/1NnbpPNML+ege909ZkkgpoLaxrPUH8r6cUJVLlPPH7D53ooGMnBSzZfQCFF
 JAGpOYAVvh8V2BwHjm1XJJfe+/6HMgfWRQWObkdpWvNac3La6QpfVtdVBIaqMteBz7URyNNLTnz
 f1yjkO4ZZzeXz5Pn7JU54kARb1TyJEYjuPV+23GEozTKCfcStdUFO8BxYu8sNKilzihSAqmf3uO
 Z+fn6nUrD8/J0lCsqN0pq39sa5H0UyJospYqYkaRTTvMolQ6THqdsi5bJxiKB402LOxAwHxjHxf
 7ljkTBg459xuadTR41MhvbkfY5xGFLjCz6fvh1RG9a1+nvrtrT7GY2G4m4mpb3CyHuqBXbwHR9A
 Hnj2GApnpFc9NvVGsu+f3tSnlsByYHWLlx7qDEgkjyQgHxP/jU0eNQE6FvLxP7Iua6ZRBtNr9Bb
 L1OhdsU00tWNej3lBb8RdXMNqK1+lOhzC/Bb3JbrPN4w==
X-Google-Smtp-Source: AGHT+IF12nHvAdLntGJPxxraDO4j0b5MOWL6ZLfeqFv+RmiZ1Zqu/GtxjdeWVVJDp61Ox8pg2M0N2g==
X-Received: by 2002:a05:6000:2212:b0:42f:9faa:50c8 with SMTP id
 ffacd0b85a97d-42fa39d22f6mr7205296f8f.20.1765470450895; 
 Thu, 11 Dec 2025 08:27:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a6671asm7190325f8f.1.2025.12.11.08.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:27:30 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Tom Rini <trini@konsulko.com>, Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
References: <20251211-meson-capsule-v4-0-59f126ba4115@postmarketos.org>
Subject: Re: [PATCH v4 0/2] Support EFI capsule updates across Amlogic boards
Message-Id: <176547045026.3578357.8412051397714751321.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 17:27:30 +0100
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

Hi,

On Thu, 11 Dec 2025 15:36:59 +0000, Ferass El Hafidi wrote:
> Currently EFI capsule updates are only supported on the following
> Amlogic-based boards:
> 
>  - Libre Computer AML-S805X-AC
>  - Libre Computer AML-A311D-CC
>  - Libre Computer AML-S905D3-CC
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] arm: meson: add support for EFI capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1bb973b4db6c07b7765b92e93e596907e8b8b469
[2/2] board: libre-computer: use common Amlogic EFI capsule support
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/6e844dd4df6765e5e772b5606a675c16fe98d9ac

-- 
Neil

