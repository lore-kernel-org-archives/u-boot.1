Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D16C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA5B8380F;
	Fri, 11 Jul 2025 00:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qs6gkCsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F49383738; Fri, 11 Jul 2025 00:42:07 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BA1E835C9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-407aaace4daso614090b6e.2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187323; x=1752792123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dawx3Y4HtCfXWccM4WfwM09El3FDRukSU5z4tQH8PDc=;
 b=qs6gkCsBBVVyItaIc/pxtNEeR5Th7sU7jNfXj30uUQtNfrjivtvDiY/KBvEMXqDBe2
 Nlb4Y+mzMd8X1PfB+TwRsEIiuzFGv67rlEaqd87oMbC8dra+f4mePSS+wo0XZBULvRSM
 snlFtoHOlL4ZXdPgKX9XW/AmqT654WGFC1pK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187323; x=1752792123;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dawx3Y4HtCfXWccM4WfwM09El3FDRukSU5z4tQH8PDc=;
 b=Ox5mBuwdRZbF2vrA/LwLxOxMZAN0mmtP60j4Jl0xIIaElGtXPX536F6xiyijW2n0zK
 E+oHOURSNFrOjcZj2Hp+pSOJin0zW8pJLjNAwl+wieBgLqaC9Mx5uAq8cTrb6Td2Alh/
 EV1sMfPzSoXtD7ab+7w2PP8DToUBUhcswR3ZFEkrH4TAmD8CPLmg2ToSxisrQFhHFvLU
 WilA+G3VnwGhNexq4jc1Rc+Z46m4MJXxq7wZsuaiNCP+bVhKYytRXCo3xacofnwAZ2Fi
 V5mGjPDnjF7TayyYXFCgbOjLb3tRvfUBP3LcvBLzQdxRfiCvzrXqieH3sdNUFHeOhisY
 m1Kg==
X-Gm-Message-State: AOJu0YzHH5G/kWMf0CPktedvOCtQpDdUr3qQhbPmgb1G7P7+b5sWzH8G
 5fg0o35yQ+AR/sg/3PxC0EWfn0InsksW+SU+Gn71+q+DaIqPBBm2Xv+6tVstp44GT0BOwXUoGRe
 OClYhWfk=
X-Gm-Gg: ASbGncsjXh2JXoREHQWqsn4RqYsulXShZnR29OVX58T8agbgpJWsj/SGWpXM+ZlCkhq
 MR2j8JLg5cKONQfBcho4WAbyjtxMLNcy7KraOD8lkF1PfGDUtBqpk9bBkDQWXkQcMu9ytHEMxPb
 mgvCeYLs/h/9K7eTos6rqhV/b4R+lPp5aPOs6VHikXft1zSTsNpe2aCz+XCTVxibt3jKXxCThW/
 XLVaAsT6b+B1ShMrnFLdF1oD6IT2D4SX7i2D5G7WmjaLxEOCbeiVoz4mGpHY30kMZg6wBewU3Ar
 cGdqapMtH3wAQGxYpekew6iOUiFXC5ZP7AqfTThJfvhmPM0LjMFHcIhW6CFAY/vegG0T08vixJa
 5E9SxYeApvFdtPmXjM9XzcW1OuJdD56u9f9tlLr7PaQz7Q3gCKkE28EWGBvsatJ7FDQ==
X-Google-Smtp-Source: AGHT+IG46r0Ruc9XYAn3qg4n80c5dydaK2YZ1s5ifItbJ93LGfloRmDWBNH6N+9QcyJEj2G7b/63bg==
X-Received: by 2002:a05:6808:3190:b0:40b:a456:e73a with SMTP id
 5614622812f47-41539d95d73mr526104b6e.28.1752187322841; 
 Thu, 10 Jul 2025 15:42:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250702010429.18958-1-trini@konsulko.com>
References: <20250702010429.18958-1-trini@konsulko.com>
Subject: Re: [PATCH] ata: Correct two dependency issues
Message-Id: <175218732210.2073260.435739675561639414.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:02 -0600
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

On Tue, 01 Jul 2025 19:04:29 -0600, Tom Rini wrote:

> First, the SATA_MV driver can only build on kirkwood or mvebu platforms
> due to header requirements, so add that as a dependency here. Second,
> SYS_SATA_MAX_DEVICE is also used by the API code so allow it to be
> configured in that case.
> 
> 

Applied to u-boot/master, thanks!

[1/1] ata: Correct two dependency issues
      commit: a713fa1b5d4090fde3d84d25b7800de8f9feba62
-- 
Tom


