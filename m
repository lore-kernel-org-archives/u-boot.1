Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE70C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 17:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C7D832E6;
	Fri,  8 Aug 2025 19:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G7RIGHku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 571668476D; Fri,  8 Aug 2025 19:08:30 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E478211F
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 19:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-742f798bb20so1759199a34.1
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754672906; x=1755277706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Av0jFzMokX5WGrugs3hzwLifAYNfSZP1AyOVGCvV/AQ=;
 b=G7RIGHkuKai5T7kZjLZruwC27Es5mnUNMrgm+Nb1h9tGMTMpulwjaZAU6AW/QQ2h4f
 6q7PQ/VF7uA7nbkYO5qpeySN7LhVrigILdgVsGamBCNiLRZCYWLXpCTjN6iXOvvjbq1U
 BCndH4U085RSXaWjTmb3L8mI4hmYcFgyq4cfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754672906; x=1755277706;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Av0jFzMokX5WGrugs3hzwLifAYNfSZP1AyOVGCvV/AQ=;
 b=W+0Asfm/L7ucTscg3CILY1g6D2/vcpgxMTU3MosM+v/FikuEOOQqPpM1HpJAiiMQMM
 62M4KJmOpWG8Qh1T8zmihklPYY3KeFaMEyC3XIVXRVIc/1QeAkl31gElVnY5Ndhm3yom
 fcFM3dq2qLIlGMeY9Ev+CPH73Sr5ZKXb52uZaXpXlsW5To1/3/d/2xg5VqdInro9RCBp
 hHORjQlGk0nt44auWKyhqHwgEcmaKg5uTHrF/oIXS6SofCVRjOcveKsSHzP2n0fx+dQC
 fcBcWF8dfTtYWEXQDh/3DsvtVsARZVrSIJfwQ7py1bv/nPKAS6NVOQbEAbBJv3qL/M+9
 G+tw==
X-Gm-Message-State: AOJu0Yzd0B0+S14z+q+crETHiAo9w6FiBF2kyxIZ3vjKVKv1Bc4fts8u
 sYULcVNK1YL/O7D0TZx76RxOrj162zBLPNnMakgCeONQuQwdiFW5/TtLKm0n51reLey2XXLExBP
 uy6XLHag=
X-Gm-Gg: ASbGnctGs/SBrmazV9L9bo2sZEFTucAyUJEbPzdVt8lymnNFc9gjuc2sPUIQLwwmUiX
 GAM7GXSwpNstyIfRcBMs7scelX69aZVEH3ZbhgtqiMddQLukA9v9SOVBbiXH3wNte9uGM6mFtsd
 LSe93V6bfcDMvixNXpm4nk3lxA+qHdnDZZY0tx52vhqaalp6O/nnd6xdX12A771Sl8GWTK+nikj
 mQYvfp/XxU74clD+cUeOaRDDY9e+OSI7BB1JRLjUNbYoNQuW5cany4PpBkzUney9oIsPrzR6ggI
 CL/7dwL1yahwsRcy7Uzr5gHxRpCZAWJW6kScZl1FL6CBl/MJqHt2VNoDURiWC1ewaHHVm9EOvc2
 Q0sC1thRNfQdu22aTaY39/dlgJoL/KS2+Gwz9Xcj5PT48Sufqriy4I47I5fWuMEH9NA==
X-Google-Smtp-Source: AGHT+IEUi8OTolvBtRrwsnci8xsvtFeUdA8tlBpJY0xKMkwDgZ5Dd3m5KOt+1/IQ+gPke4ucXnaLJA==
X-Received: by 2002:a05:6830:6b0a:b0:743:48c:5b1 with SMTP id
 46e09a7af769-7432c8af911mr2688352a34.20.1754672906596; 
 Fri, 08 Aug 2025 10:08:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30bc9ede835sm2721061fac.32.2025.08.08.10.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 10:08:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250808125223.325211-1-festevam@gmail.com>
References: <20250808125223.325211-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20250808
Message-Id: <175467290592.1469283.1429766378351960268.b4-ty@konsulko.com>
Date: Fri, 08 Aug 2025 11:08:25 -0600
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

On Fri, 08 Aug 2025 09:52:23 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 3526f990b77fca1c933f1d8b24eb9385010a05bf:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-sh (2025-08-06 16:07:17 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


