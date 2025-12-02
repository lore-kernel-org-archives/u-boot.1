Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FE2D12673
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 21:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFF883F1F;
	Tue,  2 Dec 2025 22:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z1eXz7sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBADD830A0; Tue,  2 Dec 2025 22:05:06 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C173A83942
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 22:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-450b8afe3e0so3091549b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764709503; x=1765314303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIkQAYR+HxZN5vU0KWvgv5vJ0HAOvT8L3S+bHTkbakU=;
 b=Z1eXz7saKFZN2/MOh6EFRGtkHhKNiuA1y77NKcostoo8wlhKCUw51JRBKlar8rEGrS
 Uv8Bu+Zi5/KzvnNPEpmRPi9MNgmBc3gVrtOEJjNIWpn8Sl3n+NomsRCvLjfWSa/LEgPc
 G7JbQhSMVZKRwhHxtomuyMaVxQ9veMxW7DtNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764709503; x=1765314303;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LIkQAYR+HxZN5vU0KWvgv5vJ0HAOvT8L3S+bHTkbakU=;
 b=KO0r8aeZXxabOevSKeab+FjtlBH/UKquzB9GSJ5DanbYj0tk06OxJ90DO1ISUKMSPZ
 A5/3wUtHVFoTR4x2Xkg9vXEZvJTi6uUthoVsFqFlC1R1FmZV84rjgkSdNrnfBIw3ZE8s
 +fX3vveTr1+heyy4XNIdPK/TIXyYp1vM0c34R4LkFW3i9qnPSfaFZLXlFkOPFdpAMutm
 iJb4nSDg5IEywBfy4h3qF/0MJKXPGr4D27Hl9VmTJU2qglgY6wXq32Knj0chXYfLnlPb
 jwSsE4tYPoBcfojwC95zG71IVNxSRbs9rEvAuzzmBWFovfYRaNu/InSCS575TlL8iH2B
 8ZGw==
X-Gm-Message-State: AOJu0YyRATrNRL6urFXGOKUdQW7psRk1p5FazqzJIY96bDxRHw7foiSd
 M1Xjj0ziy2U6yw/d2uXkVvR2IYMLO4sHo4buxEAZ6hwgwpZO7Fps70wpi8Vi5Y6WJdE=
X-Gm-Gg: ASbGncv8eZ/2OnDtZmSMhlM+M58/+e8HYFhpWGBW/WDhD6TVUJcegZPCWkl67Jgv9uB
 JguHEKWTHv2Tdv7HWZT+JGKVOX6qLhtn8HJYR5NWx30YVTu1ZkBb+mTh7FJj4yI669E/cV6EjNE
 NAGzMqd2ZzqMWQMuRg8v4VjrHXvBPESYIKYGUdIJMqDBsiLPV2RDz6V5TsSYNoP8apL6kTKGfgf
 +TRauvVq2LJRNEpvEky5E4VbBzb9TsYS7GPFt0dGga9juCN13gc7gZ74owg05qD7dudXJKKIGy1
 1QecUsznmxi+qXnMRVPNo0SYse0DiZNT1gChIhEz/MaM4W42nQJiVMRKVTn0psu3cIQqolLagC5
 ZnHi4DAFmwFSpBfgILHhJWjc0G9nCmbmp+gIiRZOvtxwgVJ0ElS/I4sAf6K2xpN/WgdL8AEBnVE
 91rvDG5Hjzf9LNaBGFeKsdysxAQmVBT1FatFXzsNImkmsndChVcVxznbmTsOk=
X-Google-Smtp-Source: AGHT+IHDIW5RY8aYHoz+RQDKyDXNQMxpZqm5OuSdzEgPy+3nohYO7j476zIO0osxWWupSUCMxzRS+Q==
X-Received: by 2002:a05:6808:3195:b0:450:c752:7a73 with SMTP id
 5614622812f47-451128e0ea9mr19849687b6e.16.1764709503494; 
 Tue, 02 Dec 2025 13:05:03 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170ce788sm6182478b6e.16.2025.12.02.13.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 13:05:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <46c9238a-869a-45d4-ad7c-8da3103c8c83@linaro.org>
References: <46c9238a-869a-45d4-ad7c-8da3103c8c83@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20251202
Message-Id: <176470950253.2689932.9514284606507653453.b4-ty@konsulko.com>
Date: Tue, 02 Dec 2025 15:05:02 -0600
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

On Tue, 02 Dec 2025 15:42:42 +0100, Neil Armstrong wrote:

> This is the second batch of UFS config renames from Marek.
> 
> Thanks,
> Neil
> 
> The following changes since commit 4a4871e3dc38f3f771d2713b805e79e6191b4297:
> 
>    Merge tag 'v2026.01-rc3' into next (2025-11-24 09:34:29 -0600)
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


