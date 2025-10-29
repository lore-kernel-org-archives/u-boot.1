Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FA5CCF9EE
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 18:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E69835FE;
	Wed, 29 Oct 2025 19:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ofNu4ztz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD2F8331F; Wed, 29 Oct 2025 19:08:05 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38CBE800B6
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 19:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44dabf29d02so110664b6e.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761761282; x=1762366082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZeIFLdzrxFSQr0r1gdNhpviOlg28Xrq7JbPbkkBZWEU=;
 b=ofNu4ztz3u0i2k+NG1uXsLOvMTgz4YhpQcfkXF5QCnzXTidjCmoqIF6LspWvOmhsL3
 cgPGLTUsC99gLK+ABC9bgAGduwTVnyOY8tDpyMH7cPnakNlyQ4/1jFny7Xj+LpX8TMcM
 7oCyesEvEVyc66Vhb/AVghi4acHPhT0mDhWu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761761282; x=1762366082;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeIFLdzrxFSQr0r1gdNhpviOlg28Xrq7JbPbkkBZWEU=;
 b=ns90HsGi+3OIM3h6rL9/aLVV8GT6aWcLblpvJezLVlLOUT9RrP9KH7VZSUi4g3Iv4B
 VjPcTuoR9uvwNHPdzBfkjnxq0xt8PoANGjVLVlBMVzZ1tUdeoQdL4bt94aBfMxSi2+Cx
 aDjWhqsvZzu73X0i47zuVCv9WzigcGgUsC40q3H61m0AF8tW9xbg1Udrge24m9qE/TAI
 LRglHOP6D1L1IwHCBw9YwQ9YP9zLAdTCHFkM7FkhipKbsP1gjPx/PFjhCXmRc0TmHFrU
 WuFekduSdE+HcYaIiklwXZJE/sWimlOkjqMXcZwO/Ita0gqNOdUHg8Sm3I+KTnmriRHN
 t90A==
X-Gm-Message-State: AOJu0YxQ4nfHIQwL1Uiia4lOZz9Ve+DbjvWQEilzgNpSCYD235mb8R21
 V+Ej6kXEPyzMq2OyRUA+QyxD44JBmK/xfLYuZWkaz7LBHOI9LsPZjGLXR2Xt92T0rbs=
X-Gm-Gg: ASbGncvwTtaUf/3Lu1DxYdGyeK+6HNZ5fFIZH5hs0Qf8smB+9jcTYwSuBMaAJtgvUbX
 0Q8OmbJNE4JJ2YjaIl80e2+n1nNv+Llw/nkErwPAecsJTO5sagbhL+gVB4DVhrjAp2c3daShaa6
 N2fl1Y3RLIthkclqi5/tPVxYy0wFuu/VhJJZcBmrI8s5PuivOUeigwLFfisAuJZ9hrrBoX+wf9h
 UKK2t3BmS9By9Aj+PD3gv53L7NrolCYB+vkyB0DBy2jXrg4Qfrg02pLlYlnw2PWaStTpXC7Pgib
 Zkmmaiq3aC89lO5faII2BTyB81/oKSLovDaCVSo2WtARqcIw2Z4y8BWzdPhLVAVVAOMrEhgY4MT
 XVohIXRbXHABVK8iYzgzihTtx5UJu71u8IdfUsMrornGs/+/rP0+PWLQ2bf2zPDhW5OQnsEOyUw
 rLLPbGOgRIzuRkEP/y4s/orsd1RpfWcn3ZkGWINw==
X-Google-Smtp-Source: AGHT+IHtKhHoptkl/1FYGMcel4tpT8fQGlrBltLXNiSR5px3iXwoN3HYQM+8pXXunEzfcRd1Jhr9sQ==
X-Received: by 2002:a05:6808:3a15:b0:43f:1684:8308 with SMTP id
 5614622812f47-44f89e62445mr64373b6e.40.1761761281912; 
 Wed, 29 Oct 2025 11:08:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e93e0esm3555356b6e.17.2025.10.29.11.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 11:08:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <df0e58ef-a00c-41b7-a872-7be468d92252@linaro.org>
References: <df0e58ef-a00c-41b7-a872-7be468d92252@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20251029
Message-Id: <176176128105.2497692.4580895272506404644.b4-ty@konsulko.com>
Date: Wed, 29 Oct 2025 12:08:01 -0600
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

On Wed, 29 Oct 2025 11:55:50 +0100, Neil Armstrong wrote:

> This is a set of UFS changes, including fixes and cleanup plus 3 new
> platforms support.
> 
> Thanks,
> Neil
> 
> The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


