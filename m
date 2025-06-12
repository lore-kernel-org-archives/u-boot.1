Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824E5C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 22:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD6882C30;
	Fri, 13 Jun 2025 00:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cgpiwaxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5A8582C87; Fri, 13 Jun 2025 00:15:28 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C11082AA7
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 00:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72ecb4d9a10so1405427a34.3
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749766525; x=1750371325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFEcXY3GipPqLp1xteGfmvXDCCQpEdurshcHgkk9X5s=;
 b=cgpiwaxufxZVC2Tg4u+vBdsc5PBehXajPHdFVCkzCfRsZBOvMpan3s9hryzA6UCVRU
 NpzvuxVJpDwE7n5CsF8Cmm4XDPmjVgI7AywOCY1vg/65PAKDVVeoLak1NmohUx5KO+Ed
 jXzc5Jfk8H404Gz6kqquTaI9Y1mpu3GljStXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749766525; x=1750371325;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFEcXY3GipPqLp1xteGfmvXDCCQpEdurshcHgkk9X5s=;
 b=g5ybc5MFiA18zTJNaMALab4832DNRLDNZUhFkg6rRcLCQwXM4zN4U59qDyJBSzMqhS
 WeaFjqAe6JWHznuZEmKXnw4vCqBm3sjpxJp7x9V108N5dtHYBkL4LYCzJGuowRk9Pvao
 +dcrdbGTTZd7UCtPPsh2tDeFWTTjmsUvQX1rg6wWRslisbrolj04y1k0VVUE5g6OY622
 D7nbHzeyDUHl/ah9MeEtaPwKYydmIeQ1hplNn9mivSCxZ8+wGSHFsoszF7G239SDGa7D
 bv4eCP8rMu7OImG3GCGqAmwRIJcEVhWFuzxsXODW+w0bi5qn8n+E0DSx0fQj2Ou7A1HL
 n5iw==
X-Gm-Message-State: AOJu0Yz50skL3VqzjwCdNsInSfbbiTUqBBqyzcSlJJMr2+RCBTlM0O4/
 HY0Xt8n8vEqAuB6KRB4cDWBas4f4n5ftJj2Ku+ebs2XXKibgNusCUn6jATXE+ViNmmw=
X-Gm-Gg: ASbGnct0lAtm3wzUePvXIfROLo9VQuKv13xYLbFe3jpUbIvItnaYQJkyJjQb3hZaVV9
 72UXJH0SqYXhc2vTcMvvkMB+s4EUemnUUSHT/om3YtAQR4CbMOgObYL03UmcCWYkIGl7S8BwvZz
 nOSrYCuycacBf4p0Qd+ej157eazq9xGymx8a4jQzvT5TKBkNh7g9g+ElRIUHAYJJqK5PhCYV2Ni
 ibevBCjoFogfOpzoAnEu6mXJ47WG8tlt3ByoirzgB+5uyuOiTQQufFi28Xrn1O845gBsNkl+/3F
 zjwpJ7p0eDi2Bx9wnjwb4hKXXzIoBBYa9IT5AFmuiZ0el0rThyuYm06O3RTGSKOQw1YX9xt6+/E
 DJW+oAMSkd1gjwi+P7XWPuQ==
X-Google-Smtp-Source: AGHT+IEX/Nx6VcMZNglTkareOa3EK7lErpxzI3t054yIcnMOs/ZO1XGoT1nOBsmn4T2zC9t0Vg25pw==
X-Received: by 2002:a05:6830:3c83:b0:72b:8ec6:e533 with SMTP id
 46e09a7af769-73a270cecf9mr358352a34.7.1749766525371; 
 Thu, 12 Jun 2025 15:15:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a283e3198sm7145a34.10.2025.06.12.15.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 15:15:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250528194839.1206-1-mibodhi@gmail.com>
References: <20250528194839.1206-1-mibodhi@gmail.com>
Subject: Re: [PATCH] ext4fs: Fix: Read outside partition error (take 2)
Message-Id: <174976652424.365589.1196549697218904051.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 16:15:24 -0600
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

On Wed, 28 May 2025 12:48:39 -0700, Tony Dinh wrote:

> Use lbaint_t for blknr to avoid overflow in ext4fs_read_file().
> 
> Background:
> 
> blknr (block number) used in ext4fs_read_file() could be increased to a
> very large value and causes a wrap around at 32 bit signed integer max,
> thus becomes negative. This results in an out-of-normal range for sector
> number (during the assignment delayed_start = blknr) where delayed_start
> sector is typed uint64 lbaint_t. This causes the "Read outside partition"
> error.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] ext4fs: Fix: Read outside partition error (take 2)
      commit: 53cc4332b3b37218a7cdab8bdb953da57eec2668
-- 
Tom


