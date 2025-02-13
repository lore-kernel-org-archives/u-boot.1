Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAA1C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 22:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F11C80F7C;
	Thu, 13 Feb 2025 23:59:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ajrp34a+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08D1080F77; Thu, 13 Feb 2025 23:59:22 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E4BB80F77
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 23:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6f7031ea11cso13904757b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739487558; x=1740092358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OKuuxL86eRhczUXeKNixVpa2DqnbLPfk0/3R8Vg+Zs=;
 b=Ajrp34a+R+pDEPtZFEzkBty39HxRDCTS6Vtbf8peJwLeT6j6aeIyxEGcRga76uqg0F
 5qO8pf1QxhLESxl9+zLc1NUKIHmf/o1M4Hi/FMtG5sTCU5JO4x2Oqh17m0y9qWvjhJDE
 RAbRPtmwrzFBJDaCh0kcY6LHb5mUcfKLI2two=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739487558; x=1740092358;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OKuuxL86eRhczUXeKNixVpa2DqnbLPfk0/3R8Vg+Zs=;
 b=c6IXNtWxhaPjgLI9i3jCOh8yuhigakxMSZwIgFwuTxHQEgF7//l/qRO5gauqcSxqUM
 trkrEDcqdLlQ6RIkn79VVrb6MmiNj36Z70mCIZPQ7dg7dY1oYJ7PNaZsPt5k365fFVez
 1VPu1Dh7u8KMrK8o3+l7vB8cpp8uLwObBgW9NBTmgmPiN01AFkncR8jit8oG/lw0NIQJ
 lyJZMIMNwqdtz8VCxelMCVd31PlGITbsB556qp6o+/cHQZ9k1Z0SlhzTIWkCzHHB6Sxc
 uYbNufwozo9DYAZJRPZi9gPUUkJG1g0k9FTzshfptQgJvajLxRUoR38CEah6f0FGpGWj
 0llw==
X-Gm-Message-State: AOJu0Yw5rAOT19wJSgz/g/DAqEXmHzOr5li6FcLorsvn86eAOTKe0ouf
 TaN/XiRWO9MdFH5+vRijyEJNS4xuFf1OvNtNmTqSerM/IrRQsSE/GUeeIJeW0nQOH+vuZNZb9lh
 I
X-Gm-Gg: ASbGnctgjgNDTNf7rBEEO/nxMDFZyT2RRVtIuLiMif36ai+9hgwzG3YSzq/KzOh2jJ0
 lmdKlntwcToTZjuQeSQVdwSuouwICcz5LzomtWynKUcsn571gOZFXVytagVDPnQbItWpV8Muwyv
 nIWK51C38wqRC73jS6eu1mqqYs4Ys4t43D47FmkJY6WMZweNEuF19XgIOrNTghJFD06TkbDgUI/
 udcEvVHQuOToOEt+vGA18Q3Y2LqkoOL3RHuXVmT5X3EfDuhzphCVSQpzrOMHycZwhkyx0aK83ZK
 DztEJI6fJihZjA==
X-Google-Smtp-Source: AGHT+IFx3jMMB8t4tvezjtlzSvE6u2rNwLmJyXJKWD1smfTiM6wjMgs9GBdb5r8Kxgph3+CBcL8WbA==
X-Received: by 2002:a05:690c:6811:b0:6f9:82a8:e5dd with SMTP id
 00721157ae682-6fb1f26ab16mr95326577b3.29.1739487558410; 
 Thu, 13 Feb 2025 14:59:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb3619cb14sm5155097b3.80.2025.02.13.14.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:59:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250213173850.176602-1-clamor95@gmail.com>
References: <20250213173850.176602-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra misc
Message-Id: <173948755740.2912919.18111157490508282275.b4-ty@konsulko.com>
Date: Thu, 13 Feb 2025 16:59:17 -0600
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

On Thu, 13 Feb 2025 19:38:50 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit 3da1864b1f2fc3cf2b4eaa1849bcafa669ff674c:
> 
>   configs: Resync with savedefconfig (2025-02-11 09:57:33 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git misc
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


