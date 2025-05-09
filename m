Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19034C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:50:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7431A829A1;
	Sat, 10 May 2025 00:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="guX/0iv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38CE882905; Sat, 10 May 2025 00:49:53 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFBC82905
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3f94b7bd964so2348420b6e.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830990; x=1747435790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgVeXYBDKfm59vPOiVZMHA2tONH311tp7wUyH/OOaUw=;
 b=guX/0iv4l1AeYmQFx12rqIEVbYU21oKUJYYVwaF9AZVPRVTnZKZNQUy+c0bKfXOqPj
 fnzZ1I8u388635Xiz0kMUJQEP+tEZNkpse1FlLOKwvH/qQ2hE44MiIHkkzyPclitDrPo
 ZVLCkaNe/dmMjO3BRZjAxjZ0UkV4AlZfsq7cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830990; x=1747435790;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgVeXYBDKfm59vPOiVZMHA2tONH311tp7wUyH/OOaUw=;
 b=GfmrCeZfK272TNS2fwzSEAvH+vBdBFiCIhJ9apimiWWlPIIAmHzvBWe0Gbw054Gc0G
 0dL12wkCkfFswjAJqrrRAectGRUT0BlRjW97NRC9jJnkpPr6nRi8GFEbxSHaMAjCV7gY
 5Q1ac8g1UIoMZFbhYcALKGwdUI8W421acVUKzDQIBvP9jI7yaNBNxO9aFVu95pCFbV/J
 bxJ93GThEKvYmj7A8XCEqEfqEQIw/pi1XBIZ9FDytkv1uaAKkEnnUpctBg6WU/qmcfA7
 bwYLk6CPw8ldwprx16xbvwIl541xLO/KvF7ZnjPqOujT7eUYcJRxfsvR0TJRA5Q0pCRo
 JZDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS64sVCM9ydu2QuT+pCKy0qpwm69WkwDMxnvD7F3HMZZPChQejJPNXzjo3FtAk3/cRMES3R0Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi7Mz3gC/e0t4GGbN5ZUO3YTWzbgAXrFJ45iTPST2b0VJE4cMd
 Jzmh6lArifen+dLoTWQPekstO8okL8UfoUigiFQohFIl/Cc0PaKwK45iVPuUdzU=
X-Gm-Gg: ASbGncsa+goZaPfMeaLiPNwtAZO3f4loXk3Bc3vEj5+c1PD/ruv1p5KQZ3M9uiz8LtT
 FYL5m0ovFTheZXPYxAMVF4yvSHtO1C3yxKLoLMl6roZNavaYejScWKnA5l0d8atw4amYPY9ZS10
 q/CkEVLyQRmjZIsX+rJHs7+7aQ82lVJy5KZ4wAcGx6fqyXQdJz8Hh0quUSAYgq8y6JdEX6Hu2Ah
 vtK75417K9rR6WrUB9rmKwOqc7JGURx2+Dsbw70mvHEXL5DKWzrVUI0mry2FJL8MgW/NbSzbqg5
 Nkck2fAcOhVsoPVxq+qVNB3W7iqN2+M4vCqgZYrLgH17Y/3ipNHbCAnSce80PlHUnSlc5Bai1do
 Dl7HDOSIkIB/qsts2Zi6jug==
X-Google-Smtp-Source: AGHT+IFpKKr+IkZJcFO2Q0atSt/PVGCxAnMblHgtq/ndGtJ1fqWVrXo0RVhZQkYcClgjYB1wKaaNVg==
X-Received: by 2002:a05:6871:112:b0:2bc:7811:5bb8 with SMTP id
 586e51a60fabf-2dba435516amr3071256fac.18.1746830989804; 
 Fri, 09 May 2025 15:49:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: No generic patch CC mail please <noreply@example.com>
Cc: twarren@nvidia.com, sjg@chromium.org, u-boot@lists.denx.de, 
 No generic patch CC mail please <noreply@example.com>
In-Reply-To: <20250314181031.7978-1-swarren@wwwdotorg.org>
References: <20250314181031.7978-1-swarren@wwwdotorg.org>
Subject: Re: [PATCH] disable mail for swarren
Message-Id: <174683098829.770062.5183823135588651438.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:48 -0600
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

On Fri, 14 Mar 2025 12:10:31 -0600, Stephen Warren wrote:

> I haven't been involved in U-Boot development for quite a while, so
> CCing me on patches isn't currently useful. Add a .mailmap entry that I
> believe will turn off patch CCs. This can always be removed if I become
> active again! Remove myself from a few MAINTAINERS failed and the git
> mailrc file too.
> 

Applied to u-boot/master, thanks!

[1/1] disable mail for swarren
      commit: e4e564e0d6f0f69dc0d8652aec6a04c4c6d9d44a
-- 
Tom


