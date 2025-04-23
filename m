Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8727CC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 19:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD9948070C;
	Wed, 23 Apr 2025 21:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s9HU7TBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B3FC807AE; Wed, 23 Apr 2025 21:19:21 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42978805D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 21:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2d0920ce388so84202fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 12:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745435958; x=1746040758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+UIIJP7ae20e6Vv+Qw85mxQNYTRS6TROJmlz5zRfvM=;
 b=s9HU7TBS2JD8ucvExN4wsQooLHOglT7AZVmtUcHCrn6JIwirdDgLrjGvwcVe20/pQa
 bdS9glGFFhBYbdj6SdozdjLFgyIsYCwvF9oKdy1BQbfele7XvNxyKzpq384SxAlb2zuq
 eQRP1Ki606M2bPF98NFI8CWTMwsyitfKIwSXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745435958; x=1746040758;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+UIIJP7ae20e6Vv+Qw85mxQNYTRS6TROJmlz5zRfvM=;
 b=n0EdHUkq6uvhNf01EtTQW7WVkjfyPUE4HgyuwWMvw9bOKJB7//CAgL/I0HvTAbpYzv
 z/wGSLdgw1CkdfpwJmCDjWUTO748ypodUEzJTl6CmrB7DdDhgOrTGWNaldVTKHD4SKS+
 mhsZoLUZq+YiFTtRRtr3iyBoOCRaqoiseby7XWK/FZSfojcpF2GwfGPWf1ikPlGCMBcH
 FNDPMT2vN25J5KnubUnSMquB6S3SO0nk0QW/s4SMYsB2aP/leXxGjxul79OJXI9sCluq
 srlpJZvDQ67ahkx2SM+8XZTR/kodePABb/SolAHe3ZJf55xRfrtJyNFCp/0JW/P4s9Gp
 F+KA==
X-Gm-Message-State: AOJu0YzwmVOD7PzqQmO1emPaB0l7IQXzrewmkHtcXXWMAn7BCRRob2fI
 5o4kNyNcHlQqmUho43S3vYQiO0tbPiq3hXIJ/2y1JeYEgoT3JRnjc70EUbicA3vHMRzpmyMTLws
 ikx4=
X-Gm-Gg: ASbGnctTjHQBiTFTpehfxdgyZHopr6q9GtIKcLrNdKUiOhMbWFT5GUgkdl8iQIKB8MB
 8LKHqRztyOE6j1qmUcLtUkaLK2gvWCDJyxZiJyhB3I3paUxJ77wx9+cSuiesEDYcNYDVYfOgmHX
 mOQaMAunD18/hDfkk9Qq07VI5nFMWuHDX9fCwCfxX27+GnIDAxrIkImPoL51H9QU3L3DCl34B9k
 CmcSK7nXlURR0baQ9bGHNY7lGGZCJTJJI2s2W65YBzyY6s9vLvVublY+khd0tgZnceILdUPULk2
 LySAAonCZC/bu9b4SjjIUWDDJlFuYRHYDsUro/XVv1Dp0HhWY0um6gxgCimUsKUh2AHw8CUl/0g
 r
X-Google-Smtp-Source: AGHT+IGGGq+w/hRpfO1ZQkCiYLpjoCN4jPDAct9QqlEDNVvFFaUnRPn9yRTJR1lRzX3lJ+5030wIeA==
X-Received: by 2002:a05:6870:1589:b0:2bb:841a:4fd with SMTP id
 586e51a60fabf-2d95dd9023bmr555315fac.32.1745435958004; 
 Wed, 23 Apr 2025 12:19:18 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d576ee0bffsm2346216fac.49.2025.04.23.12.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 12:19:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250423154251.83237-1-kever.yang@rock-chips.com>
References: <20250423154251.83237-1-kever.yang@rock-chips.com>
Subject: Re: Pull request: u-boot-rockchip-20250423
Message-Id: <174543595732.3941862.1680487854815799714.b4-ty@konsulko.com>
Date: Wed, 23 Apr 2025 13:19:17 -0600
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

On Wed, 23 Apr 2025 23:42:51 +0800, Kever Yang wrote:

> Please pull the updates for rockchip platform:
> - New SoC support: RK3528, RK3576
> - New Board support: rk3528 Radxa E20C, rk3576 Firefly ROC-RK3576-PC;
> - Add generic board for rk3288 and rk3399;
> - rng driver binding update;
> - misc updates on board level or header files;
> 
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


