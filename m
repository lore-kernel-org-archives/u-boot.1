Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A15F531DE
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 23:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37D5841A2;
	Tue, 14 Apr 2026 01:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PFQ/9tj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C803184148; Tue, 14 Apr 2026 01:35:56 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B064D839D5
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 01:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-409de4132b5so3209210fac.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776123353; x=1776728153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbgq9fRgddMfvgOo4VEHoK9D8DwILnV3RbqOmc2F+3w=;
 b=PFQ/9tj3UGaIoKilTg2MCUtv4FM43eMRWon4BJIYhJAQaDswB4J+Bzl3lk8hPXHRR6
 5yvqGXPqIOjD1Mw/7qtAPAfkkV3L8nQ+OUWZJ1mnj4Y3G4iPcttY5ahja0y3i7lSL0Mj
 7Bk7N5HvDRGdpJX3T6BWJVyeUl0Bd245Xj+Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123353; x=1776728153;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kbgq9fRgddMfvgOo4VEHoK9D8DwILnV3RbqOmc2F+3w=;
 b=OKtAcK++ZViFRfe7dcYn+a1wruDAKA3jouMxnvtXD1kRo7BodQEQ9pCdzOL4rHP2p2
 7tiZTPlmRhEeH8e4T8vqm8xy3PtUEyjn2hH2I5DXWoMysRVU+Jexh58LgOBvVbZh1U8u
 nmOHtmr3NP8E8uLnuv3pHckhCZOfadOCzmFwsU7JkhKdsAMTd5ixXzynokIt0y8S9BuO
 xfWt70oI7bbu2u7ccXukbeg+iJlIAu8IxVVTX+au4DjUusC8lTMIfBG4c/dL1pK+kRUq
 60dk9mFjADX30ph1cSaLW9MV+fTmcKnt4Quez+6JbY6TT577f0o5CHv3MGmwkUHObvdd
 QWJA==
X-Gm-Message-State: AOJu0YwVOaAflnFvrzB8gRsTCJho1YzFPIybdaWG4PXZOnd8ok6DzZ73
 lmw3ylJ2D+NObSJGnQ1+5ixCTWiNrSmmEXpqGrhND8tdCr+8rbSuxCn2s4DDeolHDz8=
X-Gm-Gg: AeBDieuziHaC7DNWf+BWQQiA4939gj7IOB7X/89ODHz5eWXDcz2LYlnkJw/NWhhz7em
 5hwGtmBQadKa/whNAcnT6Dw7584jdJVxZv0XjZ8BOcKD0FchFzXxz+HKCt6Wcdztur7woreVass
 aULXd4QJJkVzFRoDJWEkZYaEl1XmwCI02xahJLhOrU1eFsLYNIDMSwcKyUHTp3dlhvfV/nBb2z6
 PrzgLxwMQDAP+67+TD/jHKYUy5FfLWjr9KWzvFx1ZyxOQlJtSfv3kvhtUaKLfSMFf/5paxYuaQn
 Y8znDdBrrlWYtpYF3zWUHZEiTK8JMYubw52/55ULPvlIbpJ8W88FAXgUR4eNV4dMLwlibF45Dle
 acVl5o51sE+wDnNQS0dB8ykOWNFZ6IEFvmm3O1BJBFQVbNE9ocVzfqHXmUyZvEoSeK4XcgQmrSa
 t6ge1bZHX5nAoo7afve6CkFPF/z0tgdAXDWVodbG1PwYeqg4VJJdIgxADzHv+EjhWe0GG46sy9C
 Dv3Xyl6DK9J+GJ8PoHlCdpHE2OTJ1Bph+Gnl5aFvmAzJc8SZQ==
X-Received: by 2002:a05:6808:c1b8:b0:467:bfa:bdae with SMTP id
 5614622812f47-4789d343285mr8242684b6e.20.1776123353387; 
 Mon, 13 Apr 2026 16:35:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm10227910fac.2.2026.04.13.16.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:35:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ngo Luong Thanh Tra <ngotra27101996@gmail.com>
Cc: Ngo Luong Thanh Tra <S4210155@student.rmit.edu.au>, 
 Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20260328051552.29343-1-S4210155@student.rmit.edu.au>
References: <20260328051552.29343-1-S4210155@student.rmit.edu.au>
Subject: Re: [PATCH] board: nanopi2: fix bd_update_env() cmdline buffer
 overflow
Message-Id: <177612335264.2487918.9843219949804589449.b4-ty@konsulko.com>
Date: Mon, 13 Apr 2026 17:35:52 -0600
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

On Sat, 28 Mar 2026 12:15:48 +0700, Ngo Luong Thanh Tra wrote:

> Replace unbounded strcpy()/sprintf() calls with snprintf() and
> check the return value against remaining buffer capacity at each
> append step. The previous size guard did not account for
> subsequent dpi suffix, remaining bootargs tail, and bootdev
> token appends, allowing overflow when those later writes exceed
> the remaining space.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: nanopi2: fix bd_update_env() cmdline buffer overflow
      commit: 163d939b2839e156e58c234f07bf987228b91137
-- 
Tom


