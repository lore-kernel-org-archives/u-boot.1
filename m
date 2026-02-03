Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9A0E8B361
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83CE83DFF;
	Tue,  3 Feb 2026 22:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Deok1/NN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E49883DF3; Tue,  3 Feb 2026 22:12:36 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECD683D77
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40974bf7781so165521fac.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770153153; x=1770757953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLQineA4SAcSVOpyRZTqo7nvAdi2GU2FuGQBnCVaMR4=;
 b=Deok1/NNuWIpe6liVLosDE8SrEMPxSCM5/p0Fiwlc4ghOjC3vFirbYKMczcne+IyNU
 G4GDoSB4OpXbD9lcL5YlmkaoTwmU98NS4J+ooJ/EXin3ltNvvC58DJgAs7/YS0fRdmIU
 wBE+jH4fd7wg9y86VdYrBOP4OaWCzXW+bnd6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770153153; x=1770757953;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mLQineA4SAcSVOpyRZTqo7nvAdi2GU2FuGQBnCVaMR4=;
 b=exJJBILW+BswCIvlYK7anyEIB9/Q/Ozbbw4wYYIeO3InkMOrtF1u47wASFspdj5Gc6
 dEOyroPP7WBHLbhvUquXy+5lMxMRXwKrBTk8VlcSW85yeWY5NmgdF6/P0ZjiauSS8p0m
 wjJjqBCncHkjLM2KsYJnmdM2CLM5ZGgUADKkJV4CUaVng8EhFKaaq3Cjv38baHiDCDmv
 2h9aP6OEGxhjvp9CxnN3Qa+mpy0WyLS58797mirJ+UZr/RF9xkj9/QKZId5XxOJ+ynDL
 938NUm1GuDYg4hD7wJ5LmHWL98GMfEMFLKUmF+NpHNlF/BMYkGS8cDOhA6bz+HLIOhrI
 Tfcg==
X-Gm-Message-State: AOJu0YxbXxhJspJOZfYfJyy9jbFeWEPvQMc+aB/C4CiviB1M0ezJsK2X
 tHH67JwB8DuZ0eXiawDHDs7+GImvk+Ik9iMEcWWkrfmuRcVnZYHeb8hfi+gy1dBFRGU=
X-Gm-Gg: AZuq6aIjgQRRVshBL1HuZjOto7kvK55W1Ieir3/6yxjgPC7vI6sfYh8uCAeOCSZ3C+I
 6R+dJeGIKhgQLwYSqlrs7mUX2w7gsuJBD9EmwO05pByRmSs7Xr2/Qh7lLg6+s34z3R6Q7pLIBTw
 iRwtaOoWgPqfX7y0q1C2tD4kYHoKlVVsn3fGMbraO2hwp4E3sF4cSlq/x7VNKTk4B685qMKKgXq
 eSbBLcgQ3qPXwt07d6MV8eWNnzPv40exz+2+IMy11Mpe6cdkmE12V8jvKKis8pA3o3uUYu9SGic
 W33eZsvNV44BTroY6XCgLDBaefADHLI9c+Mo7VzP9PBsSMOlRXw+h8dWJ2NVeO44StzcYDAMVo3
 w5iBIlY8T8uYB74wDpTSGehRIIrCjaoCakZQIIP2sQigdLdOBjsRQu34JaB9AR5FUme2NEBvG2v
 H2RQ0GRluAgdeDU4gQUZfsquMP8zTA2g3al4XKlcQVii2Ar7k8Q9hB45BJkZSFxkXxfOZQD41i6
 1gRQqcU4CbtpUQpc/MCmlT7bgL7djQnMp4He2fdvzVUpw34
X-Received: by 2002:a05:6820:f06:b0:661:154a:c289 with SMTP id
 006d021491bc7-66a357aa1b9mr461216eaf.31.1770153152975; 
 Tue, 03 Feb 2026 13:12:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a35f7a4besm324630eaf.17.2026.02.03.13.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:12:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
References: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
Subject: Re: [PATCH] x86: boot: fix unreachable else branch in boot_prep_linux
Message-Id: <177015315228.1503561.3567918463826407363.b4-ty@konsulko.com>
Date: Tue, 03 Feb 2026 15:12:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 11 Sep 2025 15:35:41 +0200, Guillaume Ranquet wrote:

> The else if branch uses the is_zimage boolean which is initialized to 0
> and never set before being tested here.
> 
> remove the test on is_zimage to make this code reachable.
> 
> 

Applied to u-boot/master, thanks!

[1/1] x86: boot: fix unreachable else branch in boot_prep_linux
      commit: 0cb8a88e7ab7824b7dc857fb6572705f3e19c456
-- 
Tom


