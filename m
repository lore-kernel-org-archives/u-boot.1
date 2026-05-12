Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B61CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C78CC8460E;
	Tue, 12 May 2026 21:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lkY4Vxfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9889845C8; Tue, 12 May 2026 21:31:53 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F398341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7de7c57b52cso4752116a34.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614310; x=1779219110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TUicZHqeXdF3JiPv8VFRr0WG/GLpw9DsRaytz1KsUk=;
 b=lkY4VxfiEssM7dmAxteymdyb9PJNIdxj1soUw4WJ+oEsdkASSMlistfkaF/wJd39KL
 s/WEK7shn6Wx3rnv8XyLaazUT1j0wf1AMe07kfb/PZSQsbbCwoUkMqxgQ+NDnIKTk1+J
 pSa+qu9fpvrCCPFdgxz7ra2N5/8+n1gCH0tGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614310; x=1779219110;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2TUicZHqeXdF3JiPv8VFRr0WG/GLpw9DsRaytz1KsUk=;
 b=ltX8m6uUBhpRMtH6c0OvOW3B+/Elryj0JDwttbcwchK1Bq6BM37ttvwEOxGiNwatvU
 S0JyRw3dW8ye3b0xG6JbompS7lKCNXPv04fjANZiTz8fSrJRrm73yAqmtwSDiIUBb/2a
 ypMWB1aC+6gk2UrhVrTng6xlyn3/p2lsSG/EnENi4+dl6d9AGXpSvtM8HYV21b9CElPi
 3WfE6BOcmyywMYhINl95fTQW1YcxnXX6wufz+wP8n3OYhGSqLGKxMyQ7XuGc3TQF2pdn
 7lCnx11aLiUQdVjWMxkuEe8xKzLXLcm21PHCecS5ABmsEV6ENUBQG/o2UlrtZuO4XnDa
 nIug==
X-Gm-Message-State: AOJu0YwKGFBV65VvodYaw3XM1f3gjXaR7fiWyjL2p9hNmh7VB+6WNevC
 gK5oUqbjQJ5WBAIeacSc+p6ctEJAEG7208OXL5a/AvEtPWRIRdAPifgQvvYPyUpFong=
X-Gm-Gg: Acq92OGpNhqTi7MhIx5LMM3IiQM7xfQaQzTZhFTZ/FJB7A2YBBGpqLORMb3y4CiS8Oi
 4cbLf8h646Jy7E9ZOsNAAApriTHHNCCFPWCycgqFXPw7NDxphcsplxGsIXe1IfhVsrPsX6Ttwc+
 OLSGH0tEsyCna1KoRL3/CFPka8CXu7Ha9+4Ub69/0KeN6uKL2f9swa4cfBbCGYzMEQ8HoZ4/ZY7
 tVYnVZv4Bw14st9Zxd79DHzB+lTEiOi3g3QxoKkamLJTyHI5JZImeokkTKktWMQBwlPDk3u+u4b
 v5Nt9AnYdv+qe1tXU5F65/PeJ/j9vb0ZgKrKBF/FJzoc7VOzEWyQyR/t55k+0ELXV8NHJYEHHf/
 RdwqNUt8ceHb3yuM5InL6G8XbvMojmIfN2/cM6eLGNIbZvV21qvxoWKpGyuuUnqDeU+PTY2eNKz
 iwdyRYHlUW3dvx3rJ4KFvDKwI+95s6Cwk/6rEY2vl1A5ajK+uoqTbnjydVU1r3DJ9vdk2av1Nxg
 YVeGSBiEqwc/mRhhE9BxOKkmakPn5CfBFfEP6HczPM/sAbSDvhRlAQvbFKM
X-Received: by 2002:a05:6830:d0d:b0:7dc:db3c:1d63 with SMTP id
 46e09a7af769-7e3da4b6534mr30191a34.24.1778614310182; 
 Tue, 12 May 2026 12:31:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
References: <20260430-maintainers-apple-v1-0-43382ca4d780@jannau.net>
Subject: Re: [PATCH 0/2] Apple M1 / silicon MAINTAINERS update
Message-Id: <177861430891.3279584.10301256599378205309.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:48 -0600
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

On Thu, 30 Apr 2026 23:59:35 +0200, Janne Grunau wrote:

> While sending the trivial compatible additions for Apple silicon drivers
> I noticed that a couple files were missing from the APPLE M1 SOC SUPPORT
> entry.
> In addition add myself as reviewer. I'm co-maintainer for arch-apple
> support in the Linux kernel and have contributed Apple silicon related
> changes to u-boot and plan to continue doing so.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] MAINTAINERS: Add missing Apple M1 specific files
      commit: 60c6065df1b2101c3f5dc94b2679a2c4c81adec8
[2/2] MAINTAINERS: Add Janne Grunau as reviewer for Apple M1 SoC support
      commit: 1b5500cefee4b27915ea1581731ea40a19d6bb0d
-- 
Tom


