Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6002CCA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 21:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ED882BA7;
	Thu, 21 Aug 2025 23:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kZVp/PdN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52FAB82998; Thu, 21 Aug 2025 23:00:36 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BAAA82B07
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 23:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74382048b8cso861642a34.3
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755810031; x=1756414831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWtTs+s4itAxme/VlZu3dc39geC2sfQrQwzWiS/PRGo=;
 b=kZVp/PdNbZvp1uKZb8SlxicIhNBEDEKbUwVurg8fIEpyVkSCfe+02iAEOLcxy5OmDk
 cym7PnLneQy0GvsjepNqXylctUeKMiHIYcL/anQlWq7+xG6DK6GOWpHiz8YpRkat1gB0
 LhvvEgNfbakTduLW6HNQ9aR2mo78EUPfOi2cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755810031; x=1756414831;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWtTs+s4itAxme/VlZu3dc39geC2sfQrQwzWiS/PRGo=;
 b=HGfCLD9OKfaAvcHmw6PTUVTkYE08C9dk7j3PP3FTHMjL3ulQiEx6BsmU06ANpBsn+k
 5PCJQF4lDy8TFcBGQzZ6No1Sx2YVlkomvXu2RNTdVnQ5p2DrKoBqYUnyeL2lY3nh1IDk
 TNxZahoZU7ZLhOww3Q9nU2GtwrKFNwc7dSO7MfmAyb9WcgrbZ/X+1V8AFe5FmvzB8BIk
 Kn3eKb9A8xp4/BxERrFzmc0DO9ioE54mLA72+0FAek9rFqAXSKpKXksvtBmeropHZCTL
 v+/6f44gXxaf/CsdC7JJi+wL6FVvRzIi6G2FEWP3CwVBNf7kZ9xflFbTargGgjI4R0OG
 lwwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIDQ9vDOBb2nFk8HhYlfdtuECP9NBGZggRHTdj1E4EEIknXHNdUBfrVOtcEBdA53Huc5LDBdM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr7fg6IOjo4zrw3dEFqjxNJNCMwgETaH5u1Y1iPdBDK8w2uIc+
 VECIioaB7+kT7KwVdZIcBkgS6hfoN/IK1m4eldTd12efXE2MvU4G9KI53DVup8bNa2s=
X-Gm-Gg: ASbGnctmKtYcDRtiFG1EysXKoitQVkThp2BdCgNPvcR2hxTJJ21txOGi4taTty+REzF
 DuBggqWjSTjEbse9Hj/2+mlBqE22y/eGfPRH7i8PaMVQns4HE02ZPkx7T5hxEqryVEJIohdeivq
 +AHi++pkI8VjU8irCP2KzfYU7E/AEG6hOpwfsJoZzp/g96P1Sa6tOVvGiZPYP5fpcGp26Nmw3F0
 HXOzLtiMUImi5j+vLFbGnKSA30NwO7mSncSWxuB5RnEHY2CuEDZhPf9Zbx7v3gHn6fxJ9Y+eEIM
 gKYYzhtRcx/4j95oObf67gL44Otmv3ii93YZigiEzPBgFxXoFFX18EUpBblW5MvAj26m/eJ/kDn
 xHeRPhVORiLSdcf4wcTnqjaZorCdt+5nmcaY3/ncQxiHNnudfzdevCi8=
X-Google-Smtp-Source: AGHT+IETMC0TeXOof6C/wkNaxhBObhSANf8kzjC+oBEYNrvrMrqY3jXnDu03iQXqiCpKY17MwpTU8Q==
X-Received: by 2002:a05:6830:6011:b0:73e:9293:556e with SMTP id
 46e09a7af769-74500905585mr580013a34.6.1755810031013; 
 Thu, 21 Aug 2025 14:00:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-744e06a845esm1631957a34.20.2025.08.21.14.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 14:00:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, jan.kiszka@siemens.com, u-boot@lists.denx.de, 
 mark.kettenis@xs4all.nl, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250814181436.1598067-1-festevam@gmail.com>
References: <20250814181436.1598067-1-festevam@gmail.com>
Subject: Re: [PATCH v2 1/2] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
Message-Id: <175581003019.928164.8759574554881375454.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 15:00:30 -0600
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

On Thu, 14 Aug 2025 15:14:35 -0300, Fabio Estevam wrote:

> The CONFIG_SYS_EARLY_PCI_INIT symbol is currently not supported
> by Kconfig.
> 
> Make it a Kconfig symbol so that users could select it via defconfig.
> 
> 

Applied to u-boot/next, thanks!

[1/2] Kconfig: Convert SYS_EARLY_PCI_INIT to Kconfig
      commit: 0b0641470b3037e7e212b40c7101c1269653f86e
[2/2] qemu_arm: Select CONFIG_SYS_EARLY_PCI_INIT
      commit: 51214ffcc543dde83ad687c35cb2de61a34e0602
-- 
Tom


