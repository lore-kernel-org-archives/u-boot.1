Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9949C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 20:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C049982B7C;
	Mon,  9 Jun 2025 22:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dEj+voPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D0380E9A; Mon,  9 Jun 2025 22:13:32 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26ECA82B18
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 22:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4067106dd56so3167726b6e.3
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749500009; x=1750104809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXb+8U813phKyNEkEN3UGlrq+qr+oi++PADmtVg9WkM=;
 b=dEj+voPOyPwOROVpefpiTx13CFXLXl89HPzAivX4PFsmyQ7F526IOMTjBVlBtxd4V7
 YuOD6WPBk7PWv5VG3CrgapK/8+DIOskSj+SeGt9M7GTUH93FyrFc3nHNQv5Wrm3KiibA
 OCRSUt81VqAQFstDxTw9pLahm8xiENYegA0/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749500009; x=1750104809;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXb+8U813phKyNEkEN3UGlrq+qr+oi++PADmtVg9WkM=;
 b=l7T5Pg+qNHUdWheTdeKGFkU6NZ8aOz4ltqbGl+8Ht+eQxQBK9IZaMCtGGk+RpZ1Nxu
 r0OixFgFZgWsc1CjZ3UaxFCj8l1j2Kcz7604lwp9tpOQ4XwU/plALtg0++ifrW60J/kn
 eCis8TovjrNGazqRwjntP6E/a9byADsDl5qYEEfYCBdxy11zw4lIwJMaVdlLy5JDYE4X
 xjMLZ55pGJ0+Huyosg6GBLd5WHXeCnVo05Gn3w1lLflZE4d1iUW0IsSLOtFCyIguPuf0
 dMBIBKbeqs9bW26OxqZ3FMp03AuIk2Jy2lEIBd0jQkM8GchJmPF7/a/qzcT1V7aJ2Ozi
 Y/SA==
X-Gm-Message-State: AOJu0Yw/6OBbOjgb52wfqlspnsWEuRtzqTBZnQdNJ9CT9rxeQ3XU3oIL
 D+ZeEVrA/dAnDZxMjNwnR/0CCt+bzpJwz0bNKCDFTP+HPvGYrS4unlyN6tfN/nfaxSAyqLjmk6o
 cKSzet3M=
X-Gm-Gg: ASbGncvnXAG8wjvYaAw/N0qM39OwBYaq01DjkoSq3bEnt5FZ21qDDVYXv+JhxUJMTd5
 k9fizNJi2kEZUKfuk6XbeOLMY0+toLYArWouHz5PbwELgX+eNewAcw81ePH5Fwwz/ZMh4Li1bsJ
 tCcbSlwURLPlueDLr/PYOjefTdDsI8dF85jqs6JA9i2nggmYy1HDr3//Uoa1LDKaEsqKa+1HRcs
 rJ4g+3FRa/vBk+uWxK5OjPVV4/uhPch2tu4Ntitwkq34wddkMUnAgO15Tw5HGZe5qEqrVcZJwwG
 uu00XfXUn1MattV21riDX1Nu1JCpBaUzsUAPiJlRPzbU3psMiJD6gTISACUDTLtuRIr3NDAXH92
 sNKOclIhJNTBVSZ5iHQt0fQ==
X-Google-Smtp-Source: AGHT+IGEyxB1mP3n1YNzSlv/WYpJRJOVcz7VDWfnNRraos6Rtw2PxXMdL4py7aKMXmV3KB3CWnF3Gg==
X-Received: by 2002:a05:6808:3a05:b0:406:6e4b:bd91 with SMTP id
 5614622812f47-4090509e7bfmr11818421b6e.7.1749500008913; 
 Mon, 09 Jun 2025 13:13:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4090692e00asm1933503b6e.3.2025.06.09.13.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 13:13:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
References: <20250607113218.208923-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] pylibfdt: correct license information
Message-Id: <174950000815.721141.3878670108799861484.b4-ty@konsulko.com>
Date: Mon, 09 Jun 2025 14:13:28 -0600
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

On Sat, 07 Jun 2025 13:32:17 +0200, Heinrich Schuchardt wrote:

> Setuptools 78.1.1 shows warnings:
> 
> * Pattern 'GPL' did not match any files.
> * Pattern 'BSD-2-Clause' did not match any files.
> * SetuptoolsDeprecationWarning: License classifiers are deprecated.
> 
> Cf. https://packaging.python.org/en/latest/guides/writing-pyproject-toml/#license
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pylibfdt: correct license information
      commit: 51ec8db23280bd6fdb0da2a0257603f21aaf6ef3
-- 
Tom


