Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48FFCF3957
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 16:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070B283F20;
	Wed, 19 Nov 2025 17:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UAOrG3eN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F372183FA5; Wed, 19 Nov 2025 17:33:34 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200E583EF9
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 17:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ec46e3c65bso2437060fac.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763570008; x=1764174808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5LjO2m+ommCWqJevtnWaZ2PU8fUC4Oa9qbx/DhlAos=;
 b=UAOrG3eNPee213/EH9ZopCpbxpaFnXXXVIn+YCkrcA5V4sDXHuxb3BOrfxLJaxdf8q
 LhdCMRHGibFT1xhnBBtdMX44nAT9VT6WJPG5+e0vGwVym1Uv3CCGgas5qnh/P6Xvq12R
 65xnATp4bEfY9FDHzYNwcXmiwNUd9gnnocBAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763570008; x=1764174808;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E5LjO2m+ommCWqJevtnWaZ2PU8fUC4Oa9qbx/DhlAos=;
 b=iPAC0I/s2BYfFUFGtK8bArwuMZN1rerR2Oo3YPUJh7A23sb3grYgrMCXtR/BsOAk7v
 vxKO92ftJz3lzSkl/rWhmFpF/0phiLwXetNM6qoCFPYRmIAeqJ2w1Oe1mF6eFu5rbOu2
 L6Hg0Xu5YMREUd5kAHhe1evyv/Ore5BtxtrQxJe80veDE2LOAEIQOSO8BWleJOIRs7Cs
 pzzq9RjpdgLsLgKDN+ZJv4el9WZ0HxqjOFLayQWLYMcN3dM8Yu3LHtVnO8GnCbKcOqQu
 jpsb1U2QwYzyeRN4vI9sCxoPJi93WbuZvwLkJbQqBxRRK7vb9ujaXr6WdtWL26CjkmSQ
 7edQ==
X-Gm-Message-State: AOJu0YwlPuyTSvKJdTcVqYsnC9OBdO5n1MrelJYQ9IoAp49Y38AAJgH5
 JzbGJdBimTK8ry0JKFN9vhNSDCBZz4EGSnZT3Tivyjhmg/rStOTeIpWoMyKzni2pZL9RxxFWnnu
 zC59jvqc=
X-Gm-Gg: ASbGnctEghyN+KjJO8QfZCNzxjoNjB3wM5uKaiTXguc9cpVbdNxFU+E9us3SjOUna1V
 vjVlgs1NOv5v0Q1Rztd5k5+prp4UJR1onhvSqOmoOOffN1lp9VTLLNHLOnJdXiVZUBQ/Yh5ml5R
 sEND9iseYCMpVQrFozk79E42TBHBIkHgdJht70ljwfXNwZlfQ0UckZG7D5sYk4ufKELXSZPYByb
 8zRovrf3KsPNH0d5oEgKNvMv8yncUPafqTENHkc4yj+RSBlcO03SaVdN98Q+g1dAniZBj3TWdpQ
 OI7U0sPDrXr5JqIYGojUdliVYYOWGCyKijPjNZ7F/uSiHxxsdAZA3kSj1sOysZeO8JtwoMzm/Zj
 ubJcVqFzvBTP6kE1Pg7Shh2ahin2jDereIn905hkOSztZ3hCBSGEBWlfYJXZVaciQaXmPDSfvQg
 8c6TXadPj65YaiZgPWKk+M4K9Zsgi2i87mTcqr3untfrmSxY887dGTdHNHmAU=
X-Google-Smtp-Source: AGHT+IHl1mF2L+Vii6hajgIwskejQj7NoiwUBmMptw9xI7PLAtT+SEO8BYk+M4H9H/7AAC2qAdnRQw==
X-Received: by 2002:a05:6870:63a2:b0:3e2:f463:d783 with SMTP id
 586e51a60fabf-3e869172370mr10594347fac.31.1763570007937; 
 Wed, 19 Nov 2025 08:33:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec5962e508sm2781557fac.4.2025.11.19.08.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 08:33:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <11b6ec24-6cdd-488c-8a96-ca4a6396d288@linaro.org>
References: <11b6ec24-6cdd-488c-8a96-ca4a6396d288@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20251119
Message-Id: <176357000724.862654.4001750488640896942.b4-ty@konsulko.com>
Date: Wed, 19 Nov 2025 10:33:27 -0600
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

On Wed, 19 Nov 2025 16:02:51 +0100, Neil Armstrong wrote:

> This is small set of final UFS fixes for the current relase.
> 
> Thanks,
> Neil
> 
> The following changes since commit 69cc92d6869b8ff4591e5b8850872da34934bab9:
> 
>    Merge tag 'efi-2026-01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-11-15 08:05:45 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


