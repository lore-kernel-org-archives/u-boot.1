Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8A0C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 19:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F0A84C5D;
	Wed,  1 Jul 2026 21:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M8pd0DhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987A184C54; Wed,  1 Jul 2026 21:32:14 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8BB84C3A
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 21:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-448b69cfc6dso585371fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782934331; x=1783539131; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o7T/wYkyaPr4xpIB0gv6d2SZUzhxmHRX4aaHaX2FOAA=;
 b=M8pd0DhRKPSOOSMbxluErGR+x5M24TkF4doeft38B8MArI5iak06x8PLWMufouiicI
 u1joj+O0Yu7Cv6HbZODnXpqofC5S0zfCEJXJgaDxqedoi6xwocOxVC6F75Dstd5eX1Uc
 6Ilnh6cJks+VP4ghfYStHjAi21HZQNAxPydjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782934331; x=1783539131;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o7T/wYkyaPr4xpIB0gv6d2SZUzhxmHRX4aaHaX2FOAA=;
 b=HYdjcKZbQDxzT0GQ9ATExt0KEq2ePfL1cf2B0tfqZ5+rGhxhANYgQMFIn9OZfngfZn
 NpNFkADtgcRVq0DpxsdPPfZyCgtp4iCbRmgelJ+qOrEyAMNftFkc8mKccq1IooTJmEmF
 9/46kbH9sK+HXwH2XbfHfxrE1TXOXcu0/95r1xDgOvGPJPXHNvIGNZpiroowyVChXERo
 UpBUeBhk2XBBwjrv+qy/7AgwOWmUi3Jx3nB3VXERz8XVQ8mlJy6uXiUPl/8mSSC0T5LY
 x4o0HS7A+Ocg7w/XQT6MZGeZYmVWYczNUOBqYa1gttSjp8aoN4FMLA5UUTK90Sqg1HOw
 +l/w==
X-Gm-Message-State: AOJu0YxepJo+VkQY2HHs9yeSpdIjpWodPJipAHRRFFN5oqvPYpoxWOiU
 KZyaHn1YPSPfbGNKGYdxAbuGaB8CZcme2AEztnYTWeIpKgp+9DfaN1UpqTXKiGjXuL0u1ISdPWG
 2jh+Eb39R2A==
X-Gm-Gg: AfdE7cllSITtam4iE08aCop9EmVhQG6fL6hVmkEtBbWOw9ABKOE3eqW0UCDXE7dNdCk
 c+3mJ7hnvBGSH0fgsQM7ddVnuLUEpMzsiHFQJxmPkBXoBNIUhnKhM7PuwrkIdcwGisLbVdWF8lq
 xSG/Y8t+KKJlR3b/1L3rEMgZu1Y69sOcuU97Dxro2JE7+EhLGs6tzGNsX36t24SP0UQZqX39rCF
 GB1NoH0rYG1DELSk+3iylo9Uq/8dZVSDQROkguJhR06+E9bwp6Y7Ad0HgpiTXiGJOUdYrJF3NxG
 ZO7CUQX6jTMTnHRGTt079J7nFGnHitX6oi8EjPiNXD+DAf4kp+QyqBD8al0ZattFq/+nT0PcXrz
 /igtZw/KfVifIYHtAz+9vurIs1q+owcDisB5LhILUfG06ZiQhVj6c3Pki8rUoqJOVDa2yPLk5k/
 d/36koCEQwnfWwbdRo03a5hNVowYzhbHhhiISm2jbGCmJmVptplybJwcOw1taWim2vP23bueKFK
 NwOrXn9p6JsrZxoOM1a4gzjOfrBOKKrwo1L6IghK9XPZbI=
X-Received: by 2002:a05:6870:21e9:b0:43a:5cd0:db00 with SMTP id
 586e51a60fabf-44cb45c3c5bmr1309023fac.23.1782934331259; 
 Wed, 01 Jul 2026 12:32:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbe84f609sm712763fac.1.2026.07.01.12.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 12:32:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>
In-Reply-To: <20260701171829.2576414-1-trini@konsulko.com>
References: <20260701171829.2576414-1-trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: Remove merge garbage
Message-Id: <178293433059.2600701.11212188746387004575.b4-ty@konsulko.com>
Date: Wed, 01 Jul 2026 13:32:10 -0600
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

On Wed, 01 Jul 2026 11:18:29 -0600, Tom Rini wrote:

> When I merged the changes in commit 0d8e33717d7e ("Merge patch series
> "arm: aspeed: add initial AST2700 SoC support"") I didn't fully remove
> the before/after changes. Finish this merge now.
> 
> 

Applied to u-boot/next, thanks!

[1/1] MAINTAINERS: Remove merge garbage
      commit: 204eefab537f8f662abdbbce09eb6b5884ae699d
-- 
Tom


