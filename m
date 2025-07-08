Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B693C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 18:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D219833D0;
	Tue,  8 Jul 2025 20:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d1Rr1k3J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50AC583303; Tue,  8 Jul 2025 20:31:41 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B7C483390
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 20:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so3634332fac.1
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751999498; x=1752604298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZALBruR5p0+OX/A6s2m60dhOvut8tuWgbCG818TvDE=;
 b=d1Rr1k3JeXPPgjAvgpswusKGEUmvIfu5kNEmHSAGb+zH5srnM8gMGgDpBp2vOY73kv
 6tHHsbCuoX8N4GXBv1m3J5omQprLvE5JldWYwuhP0lvluV+bRdrcIcF/FK66qyzNbBLA
 JIKDLYdyZMgNm5TUBCtfMNVekrwfT+X0/GYnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751999498; x=1752604298;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZALBruR5p0+OX/A6s2m60dhOvut8tuWgbCG818TvDE=;
 b=qaWJO49bprKmZHFc+txzzvTj9KTeCiiIJrrYxizRW9k3vOk5DeNkISQqCAE87HsTwU
 PCF401mHRoOfQVKlPOLIf41GwOwyDgpHhFjrC3XJwNrP+bX4E896Xk9iwz6SNOqcpBmb
 wN2bfyA6uZYMS82cmono+YjtUY71cqXy3oSEGKgXmhMxa80tWnvaOuy0CSTJg3r5+OgL
 WXU1lzkyYMyVIuacEI7cTuDeFru02YjKRM8qCI5m01M0vJdq158XdJL8DGj9irseg9lc
 p9eIN9KsrP7hYA73NGc4DbOgzRfLUFxgGQjikjksaNDQFC0UEaGd6aRjxCVMUMSvI4WS
 augA==
X-Gm-Message-State: AOJu0YxkRQwoTiXQL41X71IU0qtDYAi50KFfrzf26YG24mueCE2UQfwW
 k485niTVE5qrPP3cD2oZM8TDCa6YdCJJl7IPclc+fLcn9+nR1A/1crEkMGDf0tqmfu1psoCfXsk
 LCEFU71Q=
X-Gm-Gg: ASbGncshL0Ufg87sQxYi85Yh1ex8gTZoq678xcDGjKsb37q7AUa9wpVQ42+RB2PCAQB
 LGBAx1f+Vd8dW6gPrdFMi9fhBYQKUDcxDcU5MNWB5wK7p76/BbMnioqAdf3v9doARTpbvV2gZfr
 FpDtVgkABaoyX0mcuKdhzVLGFJcQ6I4hrDaVCfYt+5KH1AztiLSCc0K2ymrB2KHOg5h8+gQiAxU
 PwIUeNs3b41oyhIHYO8vpHPv9cEep03HgHHVQKbG1AxaOuz9MEKxbyY+4fFL2ewOV2lOKcOeIJj
 Jxr3edkGp9Lsy/RrcO1f7PPkrgHkottfSlc23Unpvp3XRKAQi5msOoXJH+L3Z1kh8UFIuzuH7Tr
 s0qzNiXeDnoM991d4hzE=
X-Google-Smtp-Source: AGHT+IFvKTJaHtRSwGtQ8rtuSU5U12sMK+0SsL6mSgAUyhob9/VQh3zyjscM2zlGak9MXMs0MxmxYw==
X-Received: by 2002:a05:6871:750b:b0:2ea:1e55:a596 with SMTP id
 586e51a60fabf-2fb6d3a2a68mr3587797fac.30.1751999497827; 
 Tue, 08 Jul 2025 11:31:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902ac03bsm2978971fac.45.2025.07.08.11.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 11:31:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <4fb58823-45e5-4cbb-b3cb-f648e42d9104@monstr.eu>
References: <4fb58823-45e5-4cbb-b3cb-f648e42d9104@monstr.eu>
Subject: Re: [GIT PULL] AMD/Xilinx changes for 2025-10-rc1
Message-Id: <175199949697.1283808.10542791229759638583.b4-ty@konsulko.com>
Date: Tue, 08 Jul 2025 12:31:36 -0600
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

On Tue, 08 Jul 2025 17:35:29 +0200, Michal Simek wrote:

> please pull these patches to your tree. Gitlab CI is not reporting any new
> issue. Most of the changes are related to mini configurations and then small
> cleanups which I have collected so far.
> 
> Thanks,
> Michal
> 
> The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


