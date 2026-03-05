Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CC8F33A78
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DC8A83F2D;
	Thu,  5 Mar 2026 15:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LGOohIMP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8CE83F9B; Thu,  5 Mar 2026 15:49:49 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF49981E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40ee8b4f925so2243043fac.3
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772722186; x=1773326986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gg7dFrCFcpOrCmadlNYZRJPVPMuk9Rg+5mtBJJ/JWQ=;
 b=LGOohIMP3gpDAr5LMvb9eonLik9LPKtFjjtVOswVLfnhKOnVswdgqr8AKSmMCtcGxc
 Y5WI1c24yDdNnhqqbavD1hDpOMlZBFPkPWirBreM+zTCd5bppdOVHrr2mUUtpaPBmqFV
 19tnoZXK93wELDxyg7Hu9pwVUNu2djzTfLfIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772722186; x=1773326986;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Gg7dFrCFcpOrCmadlNYZRJPVPMuk9Rg+5mtBJJ/JWQ=;
 b=PlHzP3yXuJkY8HRE5Ba2NX42agpumZnn1wonwmMdyPMty5Gwj/9bddA2nsBhToC6Yu
 OEpEChiogL55bdU6hXookf8+dd7NQOvQGzCc1dnyeM2MOEIe3GkP8jr5aM+FrWAkSHIf
 JVECAGj6+9R6TxH2EZBm87Cznc0QWrHBQj+wm8CuVND45QpsLDyM9bIGfUXJjeuGtzI6
 k1zoeOIKxYbDieRb/M/AUG7zZLsoOtAyFeEiSC+xwik+UArUz7E7tOKryi4RGO7qaoyE
 i5atUubM5AWDruvGcGS93rYtzJvsybaoYcD2O+CudVfC1CACn+kwwCe1Cx/pbcyBk66o
 xxMw==
X-Gm-Message-State: AOJu0Yw/iKCsAFvTztEZzxAMlovp0Nte4mOArvXsNhP8HQ2oERZPnwF3
 CpENocV/BtXpEgsHIoEMyayOwJ2qdVLK8qUGqu3MtnnyBEJ+7KGItoNQ4Nk68b7TW9Y=
X-Gm-Gg: ATEYQzzG0t8p9cZqv6wAemFKhaUZjQDmE2klEvHZMmXvVrDzZdZgu/eMPy90u/KyH/7
 hMvh5nLWoYMuVmbA3Ew2fksZlFgGgqSQMz+XN4XNUSJEZRFuTQgmY8y8Bo/zsVNUArBnuI3BvBO
 1C1DsbQ7mj6gvS10LQiToAQx0tovERr/ytxHQdxiOazVhGMzyiGf9E7Pjst5nCyQWpbyj1YsyRq
 KL7hrkEQIqAMiAs4ukoys1GZvxzEpfFdPPKs3G9JEqZHPRNORtrUEmnOlBOWn+2/pmU0p7XDX4W
 Le/IOINX8QY/6M4hoBHJQ24+sPPEuTRwniusa4PuMgBqTnKf3UvEw5ju7blSNj2jawf2k4wmrMV
 Du21HFrrCkovGdzvcVUVwN+531uUmiyZ6Qj62vFQMBTW8FTlMKCTxmVkBtpg7Gj7ELhpNvoPHaT
 lm+1dTUavaj+lVSJXRBsOJ77apjdHZ7Txj+OCUJ23oHa5gQJYGlwSsrj58dySBfSKSQLzOyMLbb
 /DkNbx4xAduOHmKETc4ipqDfsynJA/FeOiKG+Llzky6GQ/cdw==
X-Received: by 2002:a05:6870:7a1b:b0:413:cd34:5b37 with SMTP id
 586e51a60fabf-416aba8b21bmr3838005fac.37.1772722186314; 
 Thu, 05 Mar 2026 06:49:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf2572bsm19246871fac.2.2026.03.05.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:49:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Angelo Dureghello <angelo.dureghello@timesys.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 E Shattow <e@freeshell.de>, Greg Malysa <malysagreg@gmail.com>, 
 Heiko Schocher <hs@nabladev.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
In-Reply-To: <20260226111136.354009-1-philip@philipmolloy.com>
References: <20260226111136.354009-1-philip@philipmolloy.com>
Subject: Re: [PATCH 0/2] MAINTAINERS: Update ADI ADSP platform maintainers
Message-Id: <177272218462.529370.9918595967621876273.b4-ty@konsulko.com>
Date: Thu, 05 Mar 2026 08:49:44 -0600
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

On Thu, 26 Feb 2026 11:11:42 +0000, Philip Molloy wrote:

> This series updates the maintainers for the ADI ADSP platform. It
> follows Greg's series adding support for ADI ADSP SoCs.[1]
> 
> Timesys spent years developing and maintaining Linux support for ADI
> ADSP SoCs. The maintenance contract has ended and ADI has brought
> that effort in-house. Additionally, Timesys was acquired by another
> company.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] MAINTAINERS: Update ARM SC5xx
      commit: bdc5f6531a40cc54c0e017843fd09d15e3e5aa07
[2/2] treewide: Remove Timesys from ADI ADSP maintenance
      commit: 15e2bacc308d1ea2f50c53f8116fd15ba6c4af6e
-- 
Tom


