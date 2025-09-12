Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB31CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 22:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82822834E4;
	Sat, 13 Sep 2025 00:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AcAf6xWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717EE833F9; Sat, 13 Sep 2025 00:16:38 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577CF833C0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 00:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-61bd4ba9fafso1119065eaf.0
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 15:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757715395; x=1758320195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCFaqOWskNOFsJq0l0MRzvHLSMC/cJ3IxcSx90zSue4=;
 b=AcAf6xWWSrHycx3ksF5DUdtaCm4jvurhyi4p9NZPZRSOuEdAUKtCBySZHeHIXonYry
 yIg2HsCXz1QkIiSILiU3r0IXrHDDnAnZHJw9HktGW7O4REE7/5cer+Qd9Y2dsm3Q5QW2
 kPC2lLVjv+kq7mwEbntw3cF9mDKg7vTY3feyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757715395; x=1758320195;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCFaqOWskNOFsJq0l0MRzvHLSMC/cJ3IxcSx90zSue4=;
 b=nffX+Kwr6TQyAaR7U6aHyIsgfipMbzCVNxwActUdk7051WocWy8bohKWZMBWeCZqsd
 hUmjpB8pHehsdaTHjITNOVZoOQ9/an9IK4I/xKziM08sRXj+rHvUTHQlSQ5MDm05hG83
 O7+nKIKZOS0mFbP/bEPPfm+PGsja8LcxNkwOl5y8MPIATOj36NLw2FMP6CTfoGV3jk/U
 8g0XTiQAKHI0U3C2uDyiAiZLbkfMNVrSANcJaf19y2IZeCtRL0pPCEGw58U35mex22E9
 vu9wNUrrUM4SyZOJpM5fbqQo5kL846DYqVKoQhWSXvuu+jlub9lSw5/KE4bC8SO1cMfH
 KHpQ==
X-Gm-Message-State: AOJu0YxEGZ/X0v8MGyoQYC/BSReK3AFMI36jmrk9i/HOYp3PE1Y0gPAa
 LcGwWal9iEDkHa1oPuuTT0HKHSfc/HY/ZGuvyoGAAEHstUA1NDvuy8yM/xchJnKCbXM=
X-Gm-Gg: ASbGnctitGCGgvaz0ke0jmdxfz3ChKvFeS+Nrd45kIKAb6Iah62eX90U0bmzw8kBZ51
 KgwnH04pFUTTrzLxl4xs4YA7zQZBemd8EASjjLDccOos21L4/7ghY7NUY+2T8D6V2k+fql18WgR
 oIeU0CnvSS8cPmMg3t3kOIMYLMTohoTxo15aDVqC7hBYYs9MIpkbUWLeGubOcuW2cjtvenvtCA+
 GCPsK+GNta1pWFxg3LNGFnIyEqD+Q1hT2b6K2UXfDiRbAxa6rlL9sF4H8/C9/2vJCDfxUmN6NzC
 XzF4oMUG2s8lBLxkks3Uu+r6OoeMZkAxMJ6icdL3rgkCvvhA1450IF5PwGVvo2uvgwb4k5db5HQ
 eCAfl4FoAkkoAOUDJonHvHJt97yyCfTJ61F/a6G6z8dfb8zJn3zuvgjbCJ+CSxPIHdQ==
X-Google-Smtp-Source: AGHT+IFSEc4qFowe6mzMC3Hul6GYsZk3z+5Tl8ghk+X11BVjLTGy5+6APAFVBXVK3sES3atJMRZmZg==
X-Received: by 2002:a05:6820:151a:b0:61f:f932:8d68 with SMTP id
 006d021491bc7-621bec78c19mr2262892eaf.1.1757715395037; 
 Fri, 12 Sep 2025 15:16:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7524b8a399fsm1268326a34.24.2025.09.12.15.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 15:16:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250902222411.152220-1-osama.abdelkader@gmail.com>
References: <20250902222411.152220-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] sandbox: replace deprecated getenv() with env_get()
Message-Id: <175771539420.4138777.2201574528971845129.b4-ty@konsulko.com>
Date: Fri, 12 Sep 2025 16:16:34 -0600
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

On Wed, 03 Sep 2025 00:24:11 +0200, Osama Abdelkader wrote:

> use env_get() instead of getenv() for consistency.
> 
> 

Applied to u-boot/next, thanks!

[1/1] sandbox: replace deprecated getenv() with env_get()
      commit: 4c822970d366415e717730606734e815993a70bb
-- 
Tom


