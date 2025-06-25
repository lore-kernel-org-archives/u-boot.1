Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414D9C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 23:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF82482E40;
	Thu, 26 Jun 2025 01:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="di6ma8/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8805182E27; Thu, 26 Jun 2025 01:52:25 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 453B382E05
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 01:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40a55314d06so143873b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750895537; x=1751500337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YSPi1jZ3Bv/4/YXfOJaWVWOu6tcW4tFhiUKBD11MD6w=;
 b=di6ma8/l/b3GpTCUQK83C5KsycyXrbtzNgK5hoYA9RqaBR3hp0zm5agvYpwSH1ONlx
 A3Et9V4X6KeaEOLXuYBo8PK+c0PBaDsy3zYUvoRTN94Sz8M+AH10CHpl3BT1pqdjOFfn
 y288kJHx2buG5NSKrMDWArA24EduH/fpjlAME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750895537; x=1751500337;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YSPi1jZ3Bv/4/YXfOJaWVWOu6tcW4tFhiUKBD11MD6w=;
 b=f05+EIbQNLPL7a2m8uVHiN2f6pEKZ0Z4hYebH9uOyaFmll1kPfmLVvRUcfqdH2aAoU
 s3qqhfj7fckE/GBYQnedJm8rHo5BsTTWfXLyf2FYI7MB6+L/moxeVi9wEIl5gHU8Hj/i
 Uh380UWxrVztJWPbRGiKALUbq2GGKcGNFFBjMsmCgkAcUl9ecHDpMUBvtgUi1C7vrngp
 qhc/B2j9LiYwdVoVYzShuF+mkxKBiM5HBMOBi7HRle+6UEtRiBmufEhghfxV35HrL8RB
 W42nwgyThinEEESjauiyj8XG0PYpqQA5UUH5Sv+XvkkYphAoMAMTKL18/RKvzzwP1K3f
 6gPw==
X-Gm-Message-State: AOJu0YzWa5yDLBUijwVG6mD4U1fEg2a026DbtPyu3Gffi7S8vIbPYhFs
 LkLHRS8R9fdxk1W8+tiq5aSLfHeEO3NmryE85LYCmXwIBZbxHieG8Rje9G67GM3EiRI=
X-Gm-Gg: ASbGncu4NVnUy/Ccf0hzY2qAH1G8NV91B9RPoTfIR5qO6Gczu0j6GMaglEX3gcy1uWi
 ncHSYxzVefUldCQ11YNIciv0H9+xzOaFV6QO2szaqbMmUz9HtSef1y0jKc/tb0HlkJtZxeNcjUa
 pf1wtWgyqH3+8OXUUeqXLi+Z42yPqlZAdyqpgmo1fwF8ENZdCOwSv+/2eP4E9HL/7vUBM5I77o+
 HX8b5NgFVrEKmVsU/ECCTP8SUX30105j5h1Rx1y5PXeQyb8TmtkLxtRxPUK7Vj/CULfG6IQP4Pz
 G3rbjlRfisLdVht2hOaH9Ti4zSxqh2moHG6IV7wPNWdwscoRMz0qmfBnxBgqPCD8B/pqHa377pD
 C7tsNI0hqFiURkQ1FxKOxkGnYgof3PTEu
X-Google-Smtp-Source: AGHT+IFOOUl+rc/mzxZGb47HkujILE7eguU3a+euKBGdKCFAHoepOho2fvlwRB6SEePXRq469eFFKg==
X-Received: by 2002:a05:6808:830c:b0:40b:121b:7485 with SMTP id
 5614622812f47-40b121b7894mr2293179b6e.3.1750895537023; 
 Wed, 25 Jun 2025 16:52:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6b3052sm1751134eaf.10.2025.06.25.16.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 16:52:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250609161011.674524-1-trini@konsulko.com>
References: <20250609161011.674524-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Allow running sandbox test.py jobs on more hosts
Message-Id: <175089553557.1525333.11543756309528212518.b4-ty@konsulko.com>
Date: Wed, 25 Jun 2025 17:52:15 -0600
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

On Mon, 09 Jun 2025 10:10:11 -0600, Tom Rini wrote:

> With a test investigation of how long each of our current build machines
> can take to run the sandbox test.py job, we can see that the longest
> running hosts are any of the arm64 machines. In some cases this may be a
> matter of overall system load, but in others it's hard to say. The
> challenge with these tests is that the run itself is single threaded and
> covers a large number of tests. There may be gains made in looking in to
> optimizing some individual tests. For now however we will likely gain
> the most by removing potential bottle necks here and allow any amd64 or
> arm64 host to run the test instead of trying to ensure they only run on
> one of the few "fast" machines.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Gitlab: Allow running sandbox test.py jobs on more hosts
      commit: 40e083353a1610276f12fdbe613bf12004452656
-- 
Tom


