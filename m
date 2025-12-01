Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14869D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADBF483C02;
	Mon,  1 Dec 2025 17:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPrrd9xK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4630D83B81; Mon,  1 Dec 2025 17:03:39 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEE683B91
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so2740339a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605015; x=1765209815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goEvcDj5jy4C6beON6+OQeVft9ik2r0Bh7I+s8SnsR4=;
 b=jPrrd9xKnaX5EY5wpYOigPyhNXCHlu691s2+dfNFRW5r40+c2I0Z3I/gRgYDROdGWS
 wpSAnbCCEfy1nb3ocLohxPdAKoHkWDD8MU9kzLIWWaBvLXzTFEL0FlleO9B6f+qi0rOQ
 32VATFvrFk+TMCI9c+0+s/PmEhQeAQQ4G8xzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605015; x=1765209815;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=goEvcDj5jy4C6beON6+OQeVft9ik2r0Bh7I+s8SnsR4=;
 b=adXFNuVa5WMiTTBgEYs/HukYPi4H0eqpmSMt0FrJ0Op1y3dxI+oyz5DTn0dMN1bEjo
 AA43297+YJsdOOOWVXXyzTEhNBvwXVhy1io48hZtvvhEm3JSIZmgfyxbjhcteFi4Imem
 LfChlahzTfSiR82esU/8eTTMz+aeXvrUOnRAPW9QX7OZdndPRpJ6gYrlYx+O6cSK9mr7
 6Fhc/eyorTzVJoOB/UAvx3WaHHNGq3U8uYfTcGmjH8aCnXlbKVpkpRZ2LDPktP68rsa7
 EeluWNaV7RceMa8lwYimlVmp6dv9MbQ9Cy/tgQos8rAxvUoilxrqpwNH+KnYUyYmG8nv
 7ecQ==
X-Gm-Message-State: AOJu0YwjMSxdK11tqpUlZ5JpQEe8zX5VMh1z5Yf9NsowSLM6yVqnmG6G
 oAU0+fNIsB2CITeQzwGT5Zj4/XutItPniQYFvFro5qOkFtB2d3wM1OYRjD4omKujOe845v8ffiY
 UaJ7qqac=
X-Gm-Gg: ASbGnctrjnR9eQ4OD2uvss6s0FNRiLvw75nePNH7yc9Ob6zXFFYnACilqkqMv+Rdhv6
 tPM75ntmLfgDd33zPVBmsGkFqPnjxAXfu57nfxnTxunJejpdFgaNoB9CU7bwRyIlO1Kc4v+LfI9
 Hj4uNrOgk1l9aZcaeKVEusamNehoFbVv9uuISCm1NFDWZg6z9NG2IsZCD1fziGGHTI8xSrJQ4b7
 qJ9jPsziQ6qxxxW05QhV3wMTb7qrUzoy271I7kq/eWbOxgYsdQVmo9t+0o2seE9dHSlfZhHsDZj
 FaR/dvAjiIdWUKCGGzPc2cCobpK17KqikT3zJMdAJQs533waOBhzr3B1yreGQBnAOQ9npYfq1bi
 I8pVHuN282/qWWdR8wJ/52MBQ9MUvVPbgePJZN7dNJVoQAM5D6TsNBaKnyab9msojvJ9f2sXXvz
 RBVX+wxw9Kux800ClBXkLc2+HcEpnW/61UIAB50cJ8aP/Kof2C
X-Google-Smtp-Source: AGHT+IEJIhe+9v7KcxEVueIxqMzIXsgWWI12pjNcemwqB/ABAFXvV7gzJFCHzPQy1O0p3kHd3S4CAg==
X-Received: by 2002:a05:6830:3509:b0:7c7:55da:91e with SMTP id
 46e09a7af769-7c798c9be45mr20740051a34.13.1764605015252; 
 Mon, 01 Dec 2025 08:03:35 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de>
References: <20251121-pkcs11-ci-v1-1-8ba6da56c2f5@cherry.de>
Subject: Re: [PATCH] CI: add libengine-pkcs11-openssl package for pkcs11
Message-Id: <176460501440.1117748.18364275471932559549.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:34 -0600
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

On Fri, 21 Nov 2025 18:10:54 +0100, Quentin Schulz wrote:

> In the future, we'll need proper pkcs11 support so that we can validate
> mkimage/binman works well with pkcs11 OpenSSL engine/provider via
> softhsm2-util (already installed).
> 
> 

Applied to u-boot/next, thanks!

[1/1] CI: add libengine-pkcs11-openssl package for pkcs11
      commit: d69c937b309f57462ba046c72657060d76503cb3
-- 
Tom


