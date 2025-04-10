Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B7BC369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 17:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE0283DE9;
	Thu, 10 Apr 2025 19:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P9D+YrHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6058C83DB3; Thu, 10 Apr 2025 19:33:57 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA6883D9F
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 19:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f8ae3ed8f4so577561b6e.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744306434; x=1744911234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q3ZGVzqteezSDGJdipuB02gTRPOKETsTiDEm9bfREo=;
 b=P9D+YrHxbSEJbky8gJ9Evgw2PLvl63OhwzwOMGxGjrwswtznolsZrxCfbYAArmmT1H
 X3VMwlUYR1dbCWd5w/K4asyalt8ZBu3dyF0fHFmSEPbmHsl8I++hnv+o0kBB8jR5l/Eg
 mCG0G1nQDCVjq1r0/2TKBW30X+48fd3lmf2Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306434; x=1744911234;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9q3ZGVzqteezSDGJdipuB02gTRPOKETsTiDEm9bfREo=;
 b=tmzV0E/LPJ7qzzzvvCQdLvk/SaJPbEXngTTv0ou1bq4ErtsW8YtQ8yJFQuphSh0WuE
 BhMxEHUeQi+uHYWbDxbXayuGPCombE4PLetU67eLSAfbiDlkm6roXUbwd7gWNHLRyhnZ
 AckEiXacBq9bsAJWq0kcsI0gGDu+a0xrd+txuyJWBvn02V4iRlhaODEjhIFT0z8y+XX5
 AUUrOWcj0dpYnNYyMVcsJykcZn8hfdcGH1s/oKSPGP+PfVRJ2/McetuPOY7prvRH3mbT
 1XUVhp6NQ0+/hdq2zYfAJkB84upaO3+N/xNR/vMjqTSRIIoPUzAbZyGwv97VsgS0Poxc
 aYKg==
X-Gm-Message-State: AOJu0Yxr0f/dFSeZbgIYTKJ8yQjSuQzQRxQkXEhyRMusDzZDPyEB0cA9
 YJF9Iu5EXAmbOxLNfrgUDMgdhmHq2j3dKG491CrJ/zWUueyH1lNDGmmmvlmLAB7tQn0eMQL7hxv
 9nng=
X-Gm-Gg: ASbGncvFH1kb3utRmSW/wELP3cbmq/lpLpQy7cCG5i7+c8wcdIatMAaNJZBR9p4W7h3
 s3gZRIM50Mlf0zzLyacc+bxm5TzgRXR1LyBCvvsn/N5jbZqGwhExFesaqxuUxa/gO0Oq2+ii3HM
 WnUCro2oTPXYEFKYpVmrSjsfKPtkdm6ai7aeyhF7NZTDMsj5O2iIo73wOQ3SXs7hbK4Zw3cgDYg
 gPeDdiqa7JYz1UxJ/5zA+ZAh4wnO8QVPRFf7PWxSfDS08+beje9o5Pxg6kxXB3K2D74n9EgpMjN
 TbdmZg5zxZ9sDMFwcYE9cGwh8uoIQfxtMqZg/f45ssB36q9C2tUkEnfo/AjUh9wH3jUlhfiP1tX
 +
X-Google-Smtp-Source: AGHT+IFJ67KQcVQqxz8T3fD3RsJs0Hmnf9g7Kb+90EOzX8InBslk+eEMMZuzWdS7m5e2M/em+t1gxg==
X-Received: by 2002:a05:6808:1815:b0:3fa:7909:271f with SMTP id
 5614622812f47-4007bca1200mr2451176b6e.5.1744306434018; 
 Thu, 10 Apr 2025 10:33:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40082515ebesm75008b6e.11.2025.04.10.10.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 10:33:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leonard Anderweit <l.anderweit@phytec.de>
Cc: sjg@chromium.org, festevam@gmail.com, marex@denx.de, 
 upstream@lists.phytec.de
In-Reply-To: <20250401084642.216933-1-l.anderweit@phytec.de>
References: <20250401084642.216933-1-l.anderweit@phytec.de>
Subject: Re: (subset) [PATCH 1/2] Dockerfile: install byacc
Message-Id: <174430643327.2959201.1080010926031354755.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 11:33:53 -0600
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

On Tue, 01 Apr 2025 10:46:41 +0200, Leonard Anderweit wrote:

> Install byacc required to build cst from source.
> 
> 

Applied to u-boot/master, thanks!

[1/2] Dockerfile: install byacc
      commit: d592ebd6b805b37a127151eb8de9261cf799d438
-- 
Tom


