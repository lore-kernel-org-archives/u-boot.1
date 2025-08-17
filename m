Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F719CA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DEB83844;
	Sun, 17 Aug 2025 17:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ed+BCL//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FB9683B22; Sun, 17 Aug 2025 17:24:57 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A4383AE6
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso2697103fac.1
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444294; x=1756049094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOx/eHu+QQ5kcKLH7MqhJBBWgPAbvbmRRJI/9eqxfUI=;
 b=Ed+BCL//QrgbzDPuWyOQpzgwz71+tw178uTSJJo48X12FWBgiy3O+xDROOQOhmz4CR
 CfeNpP4q5SqlXicx+5zdyuwpXY8RJcTzeObcLp9/iQn3oNdg5eWy05lnTUIqJV2Fd7Rj
 bWhfbDe2gQAPlIPapOMbAl6XcHYcPkDzyQDuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444294; x=1756049094;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOx/eHu+QQ5kcKLH7MqhJBBWgPAbvbmRRJI/9eqxfUI=;
 b=RaU1YrdxgtS44gOaT6vJrYDNCzcmzbAaoBHQyhveSaTl083VBYOS1GO/nXTJ3lLogI
 HmjAuJ/kXmdhHigwaV7D0gyQQQqemsi5gHIklc/pCN9ZpeYZrdyqktDIMy8LNJfHBRks
 +vXWkJjaTuXIbXh2K74MKna9X8mhLMcEXN0J9thfZ89zDS+u8BMY9Dujr4TvCVZbcg1+
 lcVSL3qiH8cyzc2kENfYnR0Dki0qqOppFPtDqeZtghDmPp7AOIfrqKShNpp8F3tKhYMs
 1pVGNHRRFprVZOq63fowTdS8NnKNp/mQFTA1eyNOZiE7UG0kCJn2u+4x2dS+cm5w8V0T
 /90g==
X-Gm-Message-State: AOJu0YzycqXp6QhILwJohb6mmUzbzei/z5NyZOvTrqJwrKY7SmH3kpxB
 xAfgej2Mxwx/yXlgklXTPbdjMRgctuXqjXtpAO6lW5pVkLVLhYhvUrPN9B6y1eUNo2prXM/o2s9
 UGCInVjA=
X-Gm-Gg: ASbGnctGqyzP+6iHOYf6Dab+YiKV5FcifBgkwN33KDmlvHYwJzSBh8Vnq33jTDOqyNk
 KpavStJHa9XeWzFVzxIGQqwVr2lUwV/gnYc1UVLk2cwMF3pU5bb/XxAqbh3YdPxbGTZIR6R/rhX
 M+jh4P/OD57s/UcmY1HEMva03LOBXfluyI7DxsG6ycMovlYxBVlwiBhALD47VG0rHDXk+X3449l
 uzjfIexW19hw799uBnNQqnT16C4z7BXHg/bFXRgLHgWN40kQtpiWyHYm09grBlnaAIuyGJhZHgA
 7MZsflrEeM3Grmhh8fWVS3IyW19Z4gE1G7o0qPQzA5S9Ut14/Pa3vhPQO3t6dSrr1c4N5dgzaEq
 hCtT3ihD/66iviyNuMU3rAmSM3OnIDIvWIAZstYsULvoT7iVnoNZf2r2IAzqgd5TGZw==
X-Google-Smtp-Source: AGHT+IG62oduzrVHfIO11qGXu1kvAYt/Lepn3D0v/vNae00w2SFrGTYMms6W6npLqdEkkMDPLUjfgw==
X-Received: by 2002:a05:6870:440d:b0:30b:b37a:6bcd with SMTP id
 586e51a60fabf-310aab043f2mr5525640fac.6.1755444293892; 
 Sun, 17 Aug 2025 08:24:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250808-ram_k3-ddrss-v1-1-5f9ed1f5cdee@linaro.org>
References: <20250808-ram_k3-ddrss-v1-1-5f9ed1f5cdee@linaro.org>
Subject: Re: [PATCH] ram: k3-ddrss: Use logical and not bitwise
Message-Id: <175544429233.372553.11173105200093341341.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:52 -0600
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

On Fri, 08 Aug 2025 11:47:43 +0100, Andrew Goodbody wrote:

> The test for the interrupt LPDDR4_INTR_BIST_DONE is using a bitwise and
> but the test is simple logic so use the more appropriate logical and.
> 
> This issue was found by Smatch.
> 
> 

Applied to u-boot/next, thanks!

[1/1] ram: k3-ddrss: Use logical and not bitwise
      commit: 460db5b44dba0ec93bbfec3bdf537fba7a487714
-- 
Tom


