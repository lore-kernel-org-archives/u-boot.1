Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75227C369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 23:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E2E82A65;
	Sat, 26 Apr 2025 01:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FRGDQFYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA0182A71; Sat, 26 Apr 2025 01:43:15 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B1CA828BC
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 01:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-604f0d27c24so1374502eaf.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745624591; x=1746229391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAQM/pEL9JwS/9zcE4JSg4R/RnEA5LeYLdbHjmMdsuo=;
 b=FRGDQFYtlzy57/WqSQMwXqzInfx9gySNjE/XsvkjeGieGNwMqlhYv3jfY1TWJmHmZg
 Q+hrGV93V/+bfgTgfepxn4I6fxV7Nj9pBe3zyhkvoCoD8wvCD6e8mfiuiEmqtzOIMIu1
 ZP0c9NM3oiIM7jbpsilyyIKjcsEXnX6EVDPSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745624591; x=1746229391;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAQM/pEL9JwS/9zcE4JSg4R/RnEA5LeYLdbHjmMdsuo=;
 b=FOaNY7hab0ALQCvuvz97tpPaGn+GwGNAOGckSonM8CK1lwei4RPMldBgSId/3Smfqb
 ISfcnWDte6LXQqTGP0Cnue/hes0ntBJT8Gkeh1kj4fgaGr3xtB9gKUE/2vBgSrbizqZ4
 vWrmqGsSXSa1fKdH5NCZJJi2PiAmTQryBTv42lXzS+r7WgTGMoDnF0gTZH2qS0ElNeDD
 ARq8tNsrpZWAecZnQA7dDDC0fQY6PC4/OMQPlPyU1CzrQCquGnsZuvpEemvxPdyt7R3q
 n7CVf3Hii7T0qdXcvKZSUANzM0MFSZ+463y52Mr14Qeo/FK/FkZpidilwwaJE+nPh1bj
 ijYg==
X-Gm-Message-State: AOJu0YysCrgvdN4+UaHR1xsCmLXY5rD+BnXXJ4JbpNV3TnFnWLeOEMt9
 E/+xq95AolfSPp7bqj4kEhRPv2PhsAkv27l2AtOhARdn8Auat8iP9196ouwnhtY=
X-Gm-Gg: ASbGncu8OjMHlNebONYYa8XnbIUeih9c10ow/esgmUrBsTugl3kn9s7Y4MnM4KGoBqU
 lUoaDAg5/C6pTDE8zFoWHDWEpq2nvZEBueH3OKc7n5nFnZHTIKhEzts75C4/6iMsvs0chpbfF89
 b3KDc6koH+ec9Kec4g81i1s1fVndtF+qgDWeL8JxXZ5bQVKonMHxDK9VKF3wYVl0ZKEzAoX+ozZ
 AAQ32mSF4z7S9dmHh5kINC2nLy/aa4otFqBqv9MSdRChWJ7ZrVrOQpKWDK/JbsZRrrVK8ERiCa1
 cLorUaNn0+y2WCvBzUe+jLNVv8JP3Bn6KLH2O8jLMFEBtMiYkTR3ukRZW0rBUNFxBhaCaCbC8sn
 Y
X-Google-Smtp-Source: AGHT+IHwBNF9M3scXosbmc7fFbPn5igwleMkNfF80sMYJNM7rFtwwmO+hJ0YvcGw+vPrBwgbynqM4A==
X-Received: by 2002:a05:6820:1806:b0:606:107a:ebd8 with SMTP id
 006d021491bc7-60658f39103mr739110eaf.5.1745624591357; 
 Fri, 25 Apr 2025 16:43:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60646862ec5sm919304eaf.3.2025.04.25.16.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 16:43:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
In-Reply-To: <aAte-nS8ZhO_Odw1@swlinux02>
References: <aAte-nS8ZhO_Odw1@swlinux02>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-Id: <174562459055.746741.13011026537921584133.b4-ty@konsulko.com>
Date: Fri, 25 Apr 2025 17:43:10 -0600
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

On Fri, 25 Apr 2025 18:07:54 +0800, Leo Liang wrote:

> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
> 
>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


