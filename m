Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD7C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921EF80F7B;
	Tue, 18 Feb 2025 20:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GsiuxRxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A915D80C98; Tue, 18 Feb 2025 20:35:16 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E56F80BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22100006bc8so63917785ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907313; x=1740512113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0ifdvDk6vrDaFuFk2JYnt6GDLJYz45OW87Y0I9tlTE=;
 b=GsiuxRxyO/WmQPR3+b6oU+WwO8le5AXrqqfgp3GqE/ah1KwPLF1TL3P8nFy2hcls4c
 HQed2Y0+PM0JScLkaPw81YUsBS7lFUbvIaMEpXi7Apcu7OZAdBca/Zmy2fX0xj6la0G6
 z3pFqlWww+W9gnVycKi4vlE53sM+5Jv49p7dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907313; x=1740512113;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z0ifdvDk6vrDaFuFk2JYnt6GDLJYz45OW87Y0I9tlTE=;
 b=DfPB+6BHj7mfQyEly814WWukEQxKDe1XJlm4c4t03iNjKygRbEy6wnmVIz5f7YC1xL
 tTAECZNQCvFQpesm4PnG8Z7r1IB5T8VTCp5yh91+4YQ42l3qtoSes32mM3p/ZKr3nse6
 8J1r/PVipAQiWnzhfPTn3tOPPDqZA9q+lWTW8VmefCTt9tbMOgzBv/rCVXAKqaKcwowW
 jcOxy7DZaaFFXs3RO68DVU6N1ztYdibn948nSnpe4Ht0+MyYIRYDOYpCisNM7LFcpD6c
 QBmJNZaRLQn57oqy+F9ecxtHCc/iE5qxcu7ZmEMqOTmtoAs5gZL2CahC6lwoPXlmFi02
 XHVA==
X-Gm-Message-State: AOJu0YxVDf9i6al+XYpoLlUyaE6c9SGsytkUP02w4bfaw4Hz8LHp0BPY
 qtMoJj4vCrULPdHa+gJbanK2KGSdhF+OmPDh+zGREGEgLH6RuwWYpDn4o5Hwz0Y=
X-Gm-Gg: ASbGncvwIzXBq1LSZZI9G8fIWIe1ID8FErSnD/4i/gZH9OkevpRj1HIBWnH7Cw8jN70
 TdkaoJuQJS1T5pF+TLAwS/jgLPoCZQh1XQQ3ojv3rBysC0mVnaTWB2B6FfAbH6EUNgrQM28iOBS
 GRbZY6SDZPYvop2v46a3eq0PPyoXCzJxmi6O2F10Gdca5bsk/t38Oq1hOBhPV9l0ot9OBcNgRQD
 z33f3xug+bghJKny/vYdCosluE322U3JbmnyZQN4vhBwymwymxwBKUnvGyeqB6pS+BhUXuUlxc+
 JAf4MI8GDq/h
X-Google-Smtp-Source: AGHT+IH4xZ9AmYZ88du1N27Yt/H1KXVXGq3doo7SDwcVAYyLMGw+0OZEGUFSmMJapCK2Do/Hkj1KuA==
X-Received: by 2002:a17:903:22c7:b0:215:5a53:edee with SMTP id
 d9443c01a7336-221040136afmr225404755ad.9.1739907312717; 
 Tue, 18 Feb 2025 11:35:12 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d52esm91875995ad.121.2025.02.18.11.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:35:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>
In-Reply-To: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
Message-Id: <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 13:35:11 -0600
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

On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:

> See the original report [1], otherwise len + 1 will be overflowed.
> 
> Note that EROFS archive can record arbitary symlink sizes in principle,
> so we don't assume a short number like 4096.
> 
> [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


