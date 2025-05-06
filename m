Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA29BC3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 22:03:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DEA98283E;
	Wed,  7 May 2025 00:03:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kFLRStyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 180588211F; Wed,  7 May 2025 00:03:04 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7CDB8210D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 00:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-73044329768so4598914a34.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 15:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746568980; x=1747173780; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knihDzJnwyGvaE9TirQYbMtLPzo8q12wRDgFxO60O+U=;
 b=kFLRStyCKT/gfm5w+ke+JVVzM0UbxQR8TnaN+yi5WGMsdC81hnzzyKqxIXsWTe50If
 L4LtYrgzizVcljSh3oN4roP0313nnxnzBqBkiFwLTchMo6vOUkxMivxkTCAYQPEgfzL8
 s8PMrd52dJka29meycVAm0IEb1c8ZAWLVXrPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746568980; x=1747173780;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knihDzJnwyGvaE9TirQYbMtLPzo8q12wRDgFxO60O+U=;
 b=N3xcH7PTc6Eeu+Q45871mxjjJwMrO91ncKkkgNf30jX5nE8THx1H2aNalHirsR8R0o
 bPzjd01Bwb+u1rBe8mjNh0ooWrDkdViGBbXOmEhbDDpXZcfOGs9F5n+9gH3mPgyEEgNj
 wbzlvrHn9V3o/wjr8QIUi9CkV+ESbhZfD+kB4EWmDBbb/FHpNEMPvqaZKKVLlDFQYzii
 8IjPOA88X0lZ4UHuQd6mLRZqnJTCTvE7XsGSYUAFktlUVKc/gXEeX3LfmpR2N2uIdTI5
 oAQnuox20IXFxmep06UzCqHhb79iGWC4s9BZcPfTkggtxtthjSQw+w8jMHls7hzqzhNF
 MwUA==
X-Gm-Message-State: AOJu0YwKEnHVPaICEaxUA4hciVc3YvQz1vYv7zs8UG96DAQ47FP3JXfX
 +1bP1PMkazIcBq3m9/legN+E3a7sbJwExu0L48q21AWEqRfWCTHsQZFUZ9hxmmNlJ1Im6pqUuYI
 f
X-Gm-Gg: ASbGncu3gGEfsLLWrAIBRchIw/lZLjRxk3wu+PxhvGXt2w/3B2WGByTIOMJGO6maEki
 IhvaMBSEC3ppD0CbojPuPb7vRdLqzZuKAc6tRAVXrfg/XeCpgAPebK69DM8fe3GgT07Id+aLICM
 Bo7qn0070PMjCqEUFGlAQziW2l4lDLTV6ZsZZbBPbew9Z22WhwbV43hK2GIqUdyBTwZ/7F+lV2c
 O+5IoP+TirUyh4jryxqrZ2W6nrDbTYcl0zBgzre/8MV7JjL2JkIUHbA/yMDwJOllFb57fcggHxL
 +d+ZYpVgMaNIALkL27siaEZhRTsVJFgAG2K9/4TdBuMbM7uuYZZdO/t/lwsGuCYs9PhKpnFKSK8
 w
X-Google-Smtp-Source: AGHT+IFcqDakz54KbdTMQ0/ZPqhyJ8+L+bZsJ4Ld6nVTBt0bMRu0hN+6/Yz5pv54yAvMq5XAV4GVTQ==
X-Received: by 2002:a05:6830:25c1:b0:72b:98f8:5c96 with SMTP id
 46e09a7af769-73210a8fa44mr685837a34.8.1746568980542; 
 Tue, 06 May 2025 15:03:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73210a1b343sm143796a34.39.2025.05.06.15.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 15:02:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250423144913.3918472-1-trini@konsulko.com>
References: <20250423144913.3918472-1-trini@konsulko.com>
Subject: Re: [PATCH] bootstd: Rework BLK dependency
Message-Id: <174656897969.280764.342058269499949898.b4-ty@konsulko.com>
Date: Tue, 06 May 2025 16:02:59 -0600
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

On Wed, 23 Apr 2025 08:49:13 -0600, Tom Rini wrote:

> The bootstd code itself does not have any dependency on BLK in order to
> build. However, in order to minimize size growth of non-migrated
> platforms, change this from being "default y" to "default y if BLK".
> This will make it easier to begin migration of platforms which do not
> have any BLK-class device but do want to use bootstd.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootstd: Rework BLK dependency
      commit: 3b6760ddeb4ef940226921017cd9088c89784b01
-- 
Tom


