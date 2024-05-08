Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A79FC04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 23:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE948822D;
	Thu,  9 May 2024 01:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ALvHJcgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7E288292; Thu,  9 May 2024 01:17:41 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 166CA881EB
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 01:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-69b7d2de292so1388666d6.2
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715210258; x=1715815058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GCKPzxfTT/Rng03Q4JFkn1aXQzyiSPyR/6d5UgWK/JQ=;
 b=ALvHJcgfdJPkEXzGqRpPHLOtVQoJJjsm3rBRM93pLLY2NdcmDS26J1IrTXCBmXFyJi
 S6GS86RywUgRzt1NvxYa9+ledIRLI4CRRRVZB385TleNtNfzj49Cppd3o0IyjeuJHc3I
 tSo3iAIj3oMgrUvSXkxcdKWxRBQJevlbUUu4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715210258; x=1715815058;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCKPzxfTT/Rng03Q4JFkn1aXQzyiSPyR/6d5UgWK/JQ=;
 b=VVvLPuwBHYVbfl/hsBzcshMRlXbTkr4LkoC6RmR6KlOf7y5u7l6jkRpOwWQOlBQ+cM
 ZfqAHmmNsDprioAeYV28voVKLvSy+MR+NQWTSFzFxdPqei7vz/u30ALk5Js0ejQflQQm
 OQQnbOSimSt9QOZjz0fOlDR68guPunrunE2Cy/zx8tuJJdgr7oVxGChWXz6yezQCecDW
 yBlAE0Px9P/6qthhEs7su1xdakiCAeuiR3Vtppxbx08cC6TEUAvz3pGU/SKNqLUs0GYN
 vSSJVONqJpXZ1hRB9qKOWurzE6+oTYIYbkup/zOn0yYjySIeyGj8IUxYRhSozcBhrPsx
 ugSQ==
X-Gm-Message-State: AOJu0YziHHEpobme62TVuCWSeLBKreHZvS9XD5p3G/8Sv8QgIuYMc0Dd
 0a/gqeTGEQdQoAwPYLZJRIg/Vmhozdr/Xp4WDtQ/wFv7I4Na4I0mNcPxcpiuPfQ=
X-Google-Smtp-Source: AGHT+IEikSBYmxgC4FouJwkHljoLx5SjAfAaSocE+o3OCcnhd+UswRv35Y0cumXyv/7Xv2v+lNunhg==
X-Received: by 2002:a05:6214:2a8b:b0:69b:542e:6adb with SMTP id
 6a1803df08f44-6a15140f1aemr43045226d6.0.1715210257915; 
 Wed, 08 May 2024 16:17:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f194d2esm803106d6.68.2024.05.08.16.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 16:17:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240424224537.1614937-1-trini@konsulko.com>
References: <20240424224537.1614937-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py: Make the number of SPL banners seen a
 variable
Message-Id: <171521025710.3157089.5386675417640932585.b4-ty@konsulko.com>
Date: Wed, 08 May 2024 17:17:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 24 Apr 2024 16:45:37 -0600, Tom Rini wrote:

> Currently we have the option to tell the console code that we should
> ignore the SPL banner. We also have an option to say that we can see it
> a second time, and ignore it. However, some platforms such as TI AM64x
> will have us see the SPL banner three times. Rather than add an
> "spl3_skipped" option, rework the code. By default we expect to see the
> banner once, but boards can specify seeing it as many times as they
> expect to.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


