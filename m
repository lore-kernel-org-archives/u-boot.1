Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AD3CAC587
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 19:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ED83833AD;
	Thu, 11 Sep 2025 21:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gG0219ua";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93AEF83285; Thu, 11 Sep 2025 21:25:44 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8508083285
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 21:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-403a893fb99so6377255ab.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757618740; x=1758223540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93/rLof0qfeZF62bqsigclqPkXRPaeOyyrdTK2tjkbI=;
 b=gG0219uajLxCLf867QqfDh94+Nt2xYK6heqqAcvumIDfZjTJD1rPWteOmHEAD1vCUh
 CtwN6/xMeezRz9X0nT2Pqq0wcKIOKnkq5h598tX/YFx/B8DFx1ol4aGeyKv4bW+AZZg9
 sY2Lha9qGDmHHLeqWfx2N81iDAlnc5+Ht36mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757618740; x=1758223540;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93/rLof0qfeZF62bqsigclqPkXRPaeOyyrdTK2tjkbI=;
 b=PMSV5U7t1xKnr9WcsE2NcNQwd/pcTuhVze+a/n9fPT86r+f2/4Q+rCHv2RA+19YD+0
 Zqhw+zal0HL5Q3YZGJs2aCUOnMxZ2RdODtFkfErjGsZgnvQ7y1ih5ryBZOTA7XNA0Ks0
 qCN0RQM5QoBcySwchHz6KuT2NYswbUYFVwscc0QAbvddPsoIlWfQxJ+iwrYt75gorr5T
 aHwyL+qNqPmeWDDqqrlnJWFMj/4KmaHZ9shzfIySMGkqrVQvLjo4AzJoq9+Jdsj77L/K
 lsDekjR1JIfvMlI1VKPqzyVpSRZMNjN3F5TMiQCDPDxOmkaByFhJvBfUwewGzKBtkWIn
 mlyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDiUnViDSb+W2VFJ21z8zMfLGIAw7TslpNpPTV9j/0gg8fuwSJV6R8xTByKnTdYH7wF66vl5w=@lists.denx.de
X-Gm-Message-State: AOJu0YzdG8NzV2/lM64s5Q8YuYyUhdfEPs73y8e+xlzNLcfjnegOoDI/
 BxuqYYGcjAiU04d53Qmc0PmV8jNFmdM2aC7TP1YrEmfSnYyL8bYqkorO+7VkzXmSRiU=
X-Gm-Gg: ASbGnctzLj2utycVUDcxmMdZWS6KyazF1K6Z5xd+UIacQUyuTIX3WG0SAyY+1mMkcug
 kcLMftmB9oD1PdOwZeR1/ui/c14gbJSB+lwwrJ905a9JIa3jRboiuXh/6an+hdJT7it9GrOL5Dn
 7MyWUgl76nGB4g5leuQxexfHYZetUKobeiXvmeXrhmsUHrh7XT6XxMqm3uAvEH+x5uYdmA2qy7P
 M/XzC44xQqLvvb15UzAq5jHUq3S67POv516xraqnMNpc7iBIUJEUD/KJeVrrOYt9sZ8T6Sg6WSP
 vzmFCq7SeN95P8yLtAS8nhoBdiYLjHFSGbu+fXqpnrNUQvK4PMCTCfDHC+1/Vchs885QfNkrebF
 eCnsWCfDxfYEuc8l7jeZE2ORP7Xfg7wTL2oL436lZg73wZxByX7D3lxgLLTTjcDOyig==
X-Google-Smtp-Source: AGHT+IF8dC9NqFPszZM3HEnsmBgCm77kRARX9ZsMkOrIhl4KWscw+KSM5FQhZfvza4rtyH6xPcW/jQ==
X-Received: by 2002:a05:6e02:2281:b0:3f6:6ad8:6fbe with SMTP id
 e9e14a558f8ab-420a53af3c1mr10930255ab.27.1757618740201; 
 Thu, 11 Sep 2025 12:25:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-511f2f391a3sm854305173.25.2025.09.11.12.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 12:25:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 u-boot@lists.denx.de
In-Reply-To: <20250820215634.52880-1-jm@ti.com>
References: <20250820215634.52880-1-jm@ti.com>
Subject: Re: [PATCH v2] mach-k3: am62*: Fix backup from eMMC boot mode
Message-Id: <175761873919.3939245.17493761269025978449.b4-ty@konsulko.com>
Date: Thu, 11 Sep 2025 13:25:39 -0600
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

On Wed, 20 Aug 2025 16:56:34 -0500, Judith Mendez wrote:

> Currently logic in spl_mmc_boot_mode only lookes at main devstat
> to determine the bootmode to return. Thus, when using: 'eMMC boot'
> as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
> boot mode, 'eMMC boot' is always selected. Add check for bootindex
> to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
> which is the only supported backup bootmode with eMMC device.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mach-k3: am62*: Fix backup from eMMC boot mode
      commit: 6fd45dd488f9605e2f634c7e5da4ac2925c118c8
-- 
Tom


