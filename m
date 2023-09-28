Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79182CE7B0F
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB5B86E45;
	Thu, 28 Sep 2023 11:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R7SERvwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9870C86E46; Thu, 28 Sep 2023 11:10:29 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7097B86E44
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d20548adso11131097f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695892227; x=1696497027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAMydH/tQ51DRsUCVRz38C46XiLnit1vjjpp185ESRk=;
 b=R7SERvwPcB0nbfBsitxPUCvVJQVH9Jd2sSNvFHZN2iGi4FBMvbGd65Z65FTEX8bC8w
 9XYxOvSXl2wR3LwjEZlAMCwhxx0ejy7vIxsgUaIhbmkVSwJXkhD2fPUn+1yMMfyiypQ+
 i6+l8CGNRBlrwdp9LENtRfR1QmBFAnLDo7rpIDD2/X6/V3skPXNVHwE1/HjWr0vqWP0g
 KLOCtyokWM07q/3v1rXG8gcsLFIS5+NbDz09U8vaJY48cpBJkYOZtCJFSE1P3e17nhAr
 vYUS2aiXndaGEMiXCqVq+xZVxjbocfVwFSaaIrH+1L/HiAYjEqVYg5V8hLpePHzLM9jy
 6wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695892227; x=1696497027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAMydH/tQ51DRsUCVRz38C46XiLnit1vjjpp185ESRk=;
 b=Ho4xndqoVOgvRSx1zMGns1zvBbziY3tEpWb0OA/w6naieg8OdugcqfZd+FsxEvKGPV
 YGhqyIk2aGjy1cQhw1o4YIU1AWkccfarFkTUU03E3lRZs4jeetxZYeCYs2HQTldT20OL
 VDh9yjkXb8ZqWfQZCGQSwZugfAeTj8S5A70V73u8LnYGPCgm/3HwWBB+M1ZO8GJfnBYE
 oSPy3+ojhiyCxlPtKZeZGQDpbiAYNxeIk3aY9NTWaDD7G1V50gulyUBMz+IR7Gzz+lub
 lsYp2BgWNpHbVu8DIfaPCp1OO9Kc6qpsqvSK+q1iGir7uWu/EAtaY7Rhm0MrYQwT3f21
 KEdg==
X-Gm-Message-State: AOJu0Yy3i84Wn5hCFkpA9bCBgGtJWwocfroP/eKdSEjgTB3+Zd3oRyAV
 nMjsoMCqrR0Fh7C6952kmwk0b+YO+oYS03xe+SWWlzZs
X-Google-Smtp-Source: AGHT+IGagLiJKKCZZi/JbpoSH3ad3sGEiAYCZZAmrJ0aoN1Q4zAmvNKIDHuopmQ2r/jBgDHNU4bBGQ==
X-Received: by 2002:a5d:4049:0:b0:319:7787:54a9 with SMTP id
 w9-20020a5d4049000000b00319778754a9mr743048wrp.24.1695892226766; 
 Thu, 28 Sep 2023 02:10:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ay2-20020a05600c1e0200b003feea62440bsm16109447wmb.43.2023.09.28.02.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 02:10:26 -0700 (PDT)
From: neil.armstrong@linaro.org
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Date: Thu, 28 Sep 2023 11:10:22 +0200
Message-Id: <169589209464.3562671.339060253310710013.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
References: <20230915160130.352099-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Fri, 15 Sep 2023 18:01:28 +0200, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-test)

[1/2] mmc: meson-gx: clean up and align on Linux settings
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/1f505e80e20918bcd388ccff6b33d749fbf31945
[2/2] mmc: meson-gx: set 270 core phase during the identification
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/100f9e63762e02a65a441d7dd6a2923b62824c8a

This triggered the following build https://gitlab.com/superna9999/amlogic-u-boot-autotest/-/pipelines/1019397571
which will produce ready-to-boot binaries on most of the supported platforms
in https://github.com/LibreELEC/amlogic-boot-fip FIP repo.

-- 
Neil
