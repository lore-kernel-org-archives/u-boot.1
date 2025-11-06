Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6253CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 17:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A9083BEB;
	Thu,  6 Nov 2025 17:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iaa8oLf9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2980583C19; Thu,  6 Nov 2025 17:59:52 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082C183B9B
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 17:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7c6e815310aso389114a34.0
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762448389; x=1763053189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TW3oy1bvQaCcOMOQss04UYDaJVRSdYCEBmnFKkZCNoo=;
 b=Iaa8oLf90r8Yc8erctUW9y/zWky5nCrC4NLcWXN8wxCo5xXbChWsX9ZxC7wdZgRXXZ
 kY4E2vkFG004whCE2uKl/cd9T8PV7GhM8bc+d+vcOY9OY8N1DT/qPJZMm4YKYiuUX9JV
 reMVF3XAYEXpGmMp91lWmAWNzS9clFSKuVUlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762448389; x=1763053189;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TW3oy1bvQaCcOMOQss04UYDaJVRSdYCEBmnFKkZCNoo=;
 b=LjJ6lVSbh7yYUwOMH0sYDNUm0eFug3OBX+vWcscoDDGm5h9sYUPyy0hy9MrMLwBI0X
 O7MC+g2CWe42UcFIOKVF5B2MDP44FD4C7kg9k9v55/JrvhTy2ZKm0Gpq7mWJ7C6D0vt9
 eiV05FVbkpme5ajTVNxIZXLN6f/d/97qEveCCmX24WqHrdSquXZupxZHKnTYTPaqw+/f
 KujapI5bWAldOx6ZwBJcQarBNKF/na9Hsi+JiLXzxmctdCsTK4fRgjijb0p9oeOEHp3W
 7oj6AK45bTue1eb9VFoJEzTXKwDmoGNn6LyThtzHaycy7CaQArTxBp+/dphvsl0pdgMf
 KXag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEfYI3Mbq2fVi3Y9GF92zjYWIkgKntHBnkHjHp9G01bUeg9DjKfG1jZIJY7dLOTtBIn8W0G5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxGElauNJP/ktItGLnvAkxwijwM8z2pAZ0nNWgqtygGpU5TSXxT
 Cis2PRKjntSEmJpa1qR7aJ3WLFVA+VL2yiSRXdUfp9iGGqrsuoPUSqpS21J5Y7QfgUwEwdQ9+8d
 3yRJ1FzMPLA==
X-Gm-Gg: ASbGncsDovO/ukMkrDx1p8ljrc9Nh2q/UBEImKioXYr8+0+foUe8QK1gnbccUtDcr17
 d18k9mzcdZrEd/38B/Bnds6MY4j1BIlOVlC1Pq1U/9oKiE57jvR2ZjmIoj0llCG8RAwPasBWg+Z
 rjzBlyH5o0Ef4C7RAuJFfkytd6zNQIupo1PgZRbXcmMy1YATtmM6W6gKWt//5QdtjwFbtJyVPga
 quZHZ+ZU2cf7jQUl7TSjDji8OYFnQ1SA1CfIGh3T7njeunsbPrTQQclpZDBxKoho+jADof6xsHJ
 JcFUrMRu8Ez8ZKQNvS+5Qzh0MPp+YwL6CQ3BoGeoftKNH9I0YLdKLTMiM9i7ZXYA8jDfCqLxlry
 YIYsOqqtqfA3kr+t1QqgoKtc54H9fQeEl3H3h4OzQpVIpTnFR7MxwOR5CW1k8GnA97k7mfX8Ogi
 UgpBQKmojzVoS0yygq4x/amAjbRQapH4TuMqBlbtNtjVvZBJGO
X-Google-Smtp-Source: AGHT+IEntW9TMVptlNvSOQcsRT4wHRilUC7HLP2pPB5l1hJS+uO1SCRBh54gjBEIUQ2Qf7cVv7wB4A==
X-Received: by 2002:a05:6830:44a3:b0:7c5:38de:2047 with SMTP id
 46e09a7af769-7c6efdda1b2mr185801a34.6.1762448388710; 
 Thu, 06 Nov 2025 08:59:48 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6f11323absm24819a34.23.2025.11.06.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:59:48 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Michael Walle <mwalle@kernel.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
In-Reply-To: <20251031131425.1473448-1-mwalle@kernel.org>
References: <20251031131425.1473448-1-mwalle@kernel.org>
Subject: Re: [PATCH v2] common/spl: fix endless loop in
 spl_fit_append_fdt()
Message-Id: <176244838798.3056677.3117682589910954412.b4-ty@konsulko.com>
Date: Thu, 06 Nov 2025 10:59:47 -0600
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

On Fri, 31 Oct 2025 14:13:52 +0100, Michael Walle wrote:

> Technically, commit 24bf44cf88e7 ("spl: fit: Do not fail immediately if
> an overlay is not available") introduced that regression as the code
> will never advance if spl_fit_get_image_name() will return an error. But
> at that time, spl_fit_get_image_node() was used in spl_fit_append_fdt()
> which calls fdt_subnode_offset() to get the image node. And I presume
> the commit was about the latter failing gracefully and trying the next
> one.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] common/spl: fix endless loop in spl_fit_append_fdt()
      commit: 52442205d30eec4571a466c78dee0047677be56c
-- 
Tom


