Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA4C5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 12:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63AF687E02;
	Fri,  1 Mar 2024 13:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ew9ENzJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA05087E02; Fri,  1 Mar 2024 13:57:24 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DDFD87EAF
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 13:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-608e3530941so22703797b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 04:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709297840; x=1709902640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfyMlUMzx3VQsS3R7T2GSZESD8+Lnpcy3TEyzInipfc=;
 b=ew9ENzJvMekPN3Vja4EwGDbPIkUQ0sxP/mhoMcJyjldy0wxLPoYI6Kafv/4EF3lltc
 5iC9m+wb4HhRwY/pB15SIwQgGY9+ziip1S9EHlLI5Cs75Pw8QsjY/KDdMwJ0pNlXWh+v
 LZlIhNLy3n7u60RbURPRqhsoSd9gbuEh+4iIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709297840; x=1709902640;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfyMlUMzx3VQsS3R7T2GSZESD8+Lnpcy3TEyzInipfc=;
 b=Ve4iQmFggU8k/tz+VwTxx6AEsqdKiZaNmbql+MXuDIeWfuFAS+wWhLzLHZXVrWJhyL
 /KJhKmGbMUQVZNbXWDcmvsdas2j9sfDepOxmSBJZAuFSL2vz/+aqtloIt9CXSF9iEefs
 TKX3lVJCBvSiyHtp25b4CUcYrk63fP6y/MsVA6gfp4pSzoCirZmJkdoIDA7DKvHZnAJK
 L7e6UKtguDzsGrCyrAFB2Rq81iJTyeLacTN3cFDneUWoBa3afS1d9Sfhzah7ihUJGIiw
 xyeLll0NylJXGGP+glPZ0+bgEOwmM+rBtugJ/u1+wFlHc8pPQGiHRGrTLM7pbOyJpuJC
 rvyQ==
X-Gm-Message-State: AOJu0Yy/4ftSgckCb6iHEn04sB6OANTDerKGQOBqC4xxhug16eP90WmG
 igaBX4Dd0Q5cPMqMiSUR7BOzZf8kXel0wYJqwUbiCc6g6y6KUoqnrNta6iArwJw=
X-Google-Smtp-Source: AGHT+IE36fYDLRMwuBncyAlDNJME588hBikKsruL2lYhp4q3b15W/ENqtUFEHz1leqG8GNPy2YaFNw==
X-Received: by 2002:a81:4ad4:0:b0:608:7f87:fceb with SMTP id
 x203-20020a814ad4000000b006087f87fcebmr1323914ywa.38.1709297840040; 
 Fri, 01 Mar 2024 04:57:20 -0800 (PST)
Received: from [127.0.1.1] (065-184-194-195.res.spectrum.com. [65.184.194.195])
 by smtp.gmail.com with ESMTPSA id
 u125-20020a0deb83000000b00604ad97f2d9sm941660ywe.110.2024.03.01.04.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 04:57:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Cc: sjg@chromium.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 conor@kernel.org, neil.armstrong@linaro.org, caleb.connolly@linaro.org, 
 ff@shokubai.tech, daniel.thompson@linaro.org, dgilmore@fedoraproject.org, 
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com, bb@ti.com, 
 mark.kettenis@xs4all.nl, festevam@gmail.com, nm@ti.com, 
 andre.przywara@arm.com, ijc@hellion.org.uk, paul.barker.ct@bp.renesas.com
In-Reply-To: <20240222093607.3085545-1-sumit.garg@linaro.org>
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-Id: <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
Date: Fri, 01 Mar 2024 07:57:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Fri, 01 Mar 2024 13:57:59 +0100
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

On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:

> Changes in v6:
> --------------
> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> - Patch #3: Incorporate fix for sandbox CI failure.
> - Patch #6: Incorporate shell script comments from Marek.
> - Patch #8: Incorporate documentation review comments from Paul.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


