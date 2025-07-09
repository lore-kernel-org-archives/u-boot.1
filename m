Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BDAC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D06C83479;
	Wed,  9 Jul 2025 16:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RRaJO9ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B843834BC; Wed,  9 Jul 2025 16:22:01 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC358331D
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-735ae68cc78so3657690a34.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070917; x=1752675717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dz4nCAHA5Ejg4T64ZX1z2axbT7rTKw/hk2rQv9s2xGI=;
 b=RRaJO9eyUGpVNQeFlUU/03kwqMj91GNxWJBM6Mw4YXuBLbax3XDC1Gz6ycDZJP9XDn
 Np+nq7I9rYHHwkwBDUYvge10spEjR2eGrG2U8Z/tzEmfFTgbuEimPxdIMi+pqX2MIQiq
 DsxY9BjipVv6ZoJU8H0mCaeJNmWiP6gGxTqwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070917; x=1752675717;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dz4nCAHA5Ejg4T64ZX1z2axbT7rTKw/hk2rQv9s2xGI=;
 b=UBB77xb+yep3wOjythb84AYQM5XlqG0sa2v6pRMof2ZOzze7VoY0K+nNdkwh+g1oaf
 D7cAslz/ks4PPNVbMlpq8u7jZqd2/IeSmJ0CTQ24IE6d+8DK/jHwBS4hUAE7vpR4hhSL
 FCsBCLB+BdcDmiWCZ0/wryYU3mwvF1WIygNkek60uPG+M/v4KeL7T+rsMShadk0iL4np
 6fTobwke1BcL2gkzHB8cM1JGZU8g/SXQf9wS3xuQ01yzE9m3EioxlyXa/dn+T3Q+DhEL
 7pbw9NIPsaXfXacAy/bJW7goOjHLBDWqLGjasaBEuYmHx+mMU7jgubgwnBPdV5dOD/O7
 5fTw==
X-Gm-Message-State: AOJu0YwR9eBscXSd3kPV+BEcow0Nk51nrNs4/UOyM91cE3HRpmPfiHC3
 E2BaJ/vsFKBMYIkfUyPgZfcJ4cYYmwQCTuf/3yOlfft5Z/VfsEmYfKmQ0WbrPiAJFnU=
X-Gm-Gg: ASbGncsTgnVpXMu2aj/sPILyYLkHat50iUyRWGVGDqOrO03R9GH5UBPPJUDUppBY74L
 aLmDfKa3hMvElQ9nKGwAZX5Tw86ZUnKIn3ZfMcyrQclzr5hh5r0rxyDAtw3bBDDs71bikGuoQeN
 9tZ/fKC94rhzqEuLFrzMRMZg4GBDCUYOKJ6xZUyhZiDdvMHlq4XaO70s7Yn18y+iOHqc1wgfT35
 w2w2kMoUeLUn6hUBaK2Ha/aI7VTqIK1OSl3dXofhwuWDaI/p7cFDM1Z+nNizzsJkmhqr+7YCtPy
 OMIRoLslqi254uMTr9nZ20AiDueXjW+YXDHJU9uyKmmWrG9ddWFQNm9XUnvdkHr8V4nZ8hXqBa8
 SBcWfW9JyimfkyRWmoyo2aL/Sb5zfzw==
X-Google-Smtp-Source: AGHT+IGMrIHs8iMdEP/9p5zWcU8iyzcQgEzOiVs8q7QkNwgE4Pf8tdQlwdtA4pAoZpbSixvJaZWL3g==
X-Received: by 2002:a05:6808:1247:b0:40b:a456:e71d with SMTP id
 5614622812f47-412bd4a4054mr1426486b6e.35.1752070917409; 
 Wed, 09 Jul 2025 07:21:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:21:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250624-readline_fix-v1-1-8585ffeae429@linaro.org>
References: <20250624-readline_fix-v1-1-8585ffeae429@linaro.org>
Subject: Re: [PATCH] common: readline: Fix always true test
Message-Id: <175207091643.1813324.16828000711616470950.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:21:56 -0600
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

On Wed, 25 Jun 2025 10:50:30 +0100, Andrew Goodbody wrote:

> The variable base is unsigned so >= 0 is always true. Fix this test
> so that it is actually useful. The fix prevents the code from causing
> a segfault in the case where Ctrl-w is pressed on a line consisting
> only of spaces.
> 
> 

Applied to u-boot/master, thanks!

[1/1] common: readline: Fix always true test
      commit: ebb2c9e5500939cff5e812f54819174bbe6703df
-- 
Tom


