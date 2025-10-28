Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C669CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 18:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CC683956;
	Tue, 28 Oct 2025 18:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bI3pdgz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C4683885; Tue, 28 Oct 2025 18:59:16 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D9F6838CE
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-44f6d7b586cso670711b6e.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674353; x=1762279153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByLR2LvqEJnDRKSWVwlRyA++ziUo5X0j9hkG3KlReFg=;
 b=bI3pdgz6N4PtMt2w2YKw2KxpIi1++pJiCYp6KVpeBUrENp4VL+W0QYm37FBsJ3ChUF
 6EGpgLncjn8OTKP2j39A8Yyh4ytJvB8+RuMMBGkGGBntjHQpeUw1FhbZN6QESUjgM4lm
 b0kaY6odqWK0J5l3L6eGTs42hB2DAF1rwbwGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674353; x=1762279153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ByLR2LvqEJnDRKSWVwlRyA++ziUo5X0j9hkG3KlReFg=;
 b=A5tsml4EM3PTvZNPc34kn5qCswTGrqVxB3xsElnWabZUgmnVWiIZun2Uy6HRAXqIx2
 be1zBmX588KRSQgZ9SRAyoeYEnXG3B1bV07anyKMb8m5FmbrGk+jsK3S9lB74rxZEcoL
 eKVDSSUSR4vm1RebiUbFJMlHBunbC2XawlimvlnAqde0NtDwx944xCgR2yuGOYvHchb9
 2BDj+ikW9cDh7hXqFMOaiHGpza4Wq2yoprs3TGqEf+ol0RtOf1TErFrS+m0rbVFzV3Aj
 pz2/Kv7pvwRbpCqNVilVRm3wOGBQH6dik85PH+VZwfWsCyFzNCNTuhQavoThJdGgPrrQ
 zN5w==
X-Gm-Message-State: AOJu0YyDH+yj660sB9Rboy56cYL/kIYIW8k1i6h1WtdNMKqrfGVUNROH
 u6i3/pSthNesxMN3JeMM4yW0qHpIfRmqAW45cV+ApFz6IiVbvgDKxOyVJ0VatZxVgSE=
X-Gm-Gg: ASbGnctTyFUKQ03s3a5Pj7SUg7TDFUJt26yG9WtDDkZDR93cKW+v8jWh0f/LWoXkBPi
 cXVmKcXcZDhcy0q2ohuTuHP36WOM4YeGMx1wFhCD1IwQ2hAlPVtrZ4NNSXf79McmLAmHQ+RJpVb
 XnNM7xKloIwvykkGLcmwOp1lbeHgpS5zqdUJuvSlxqtFV7phKW8MSe2o7QOikAUd4MCcbvKhNrT
 leA9pFcw+PlHRpRLWiDkOieUkRDTjTTuvga2W6AD90oemltrP5E+rtTJzxgeyELF/EMu/0tr2Ou
 UucwnqX3cKN7ZLfQFR+bTmE6fUIq/6mujGgpsqlqr5kSUNpyOUjc6d+bUjrBjYlez7UYbOMoHkW
 U5fELJU2ACKWiXWiX77DkRBS11WlfzaBjpxT3gYo4vScx+4gJtQV5dkA8AwfX8PfhSHzN1Klk6V
 ZUUhiNGQZa+P4iWTJhH0iVCprvVUa4zLu18HO3Dg==
X-Google-Smtp-Source: AGHT+IEZVNdMgTkIdk+V9NUK/JnsKDuav0oziJWEptts13M5uT3exb22HlFsAE/UtHIj6HqiQ/W7mg==
X-Received: by 2002:a05:6808:4f67:b0:44d:bc9e:3163 with SMTP id
 5614622812f47-44f7a3d0757mr178370b6e.7.1761674352568; 
 Tue, 28 Oct 2025 10:59:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250812-npcm_fiu_spi-v1-1-8713d9e2ea72@linaro.org>
References: <20250812-npcm_fiu_spi-v1-1-8713d9e2ea72@linaro.org>
Subject: Re: [PATCH] spi: npcm-fiu: Remove repeated test
Message-Id: <176167435178.2025892.11002109378360767342.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:11 -0600
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

On Tue, 12 Aug 2025 17:29:07 +0100, Andrew Goodbody wrote:

> In npcm_fiu_uma_operation to enter a code block nbytes must be non-zero.
> So testing for nbytes inside the code block is redundant and can be
> removed.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spi: npcm-fiu: Remove repeated test
      commit: 9a6411daed49300a4182a0494d5a5a3b9f446429
-- 
Tom


