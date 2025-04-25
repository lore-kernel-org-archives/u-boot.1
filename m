Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECE5C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 23:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F91482918;
	Sat, 26 Apr 2025 01:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stv/zdve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AB8C828B3; Sat, 26 Apr 2025 01:43:14 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD52782A7F
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 01:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6060a70ba80so1588704eaf.2
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745624590; x=1746229390; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2wQ/ZuOgKwCyi+Vpn2IAq67Rp6i/84kFGrIBgmH3XI=;
 b=stv/zdvelJ6HAhyrfeD9Q1IQuo3g8Q5alq4nysw20wTT/wR9ESc/v+HU3efP95QC38
 otaRvS4hODGBPg1KspjNcwJjVfw6YrFomhypFi12VXe8n5qG5WMHq2HJAVyNuXlz+aHp
 vS7ZUvaA0nmiobTKsipJBJlsbT2UCsAQRCFD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745624590; x=1746229390;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2wQ/ZuOgKwCyi+Vpn2IAq67Rp6i/84kFGrIBgmH3XI=;
 b=F3+U3onU/5lZ319VfrqPIJ2khr+Z/b1Gm1DGafhjehRHQcKF8O81LF8nUaGuoi0yBQ
 jaK33a6Xj5FcBc1evzp4ym0fzxcnw/hcmDpQtXYrIgRiIdb/wF4h6ZuH2Lpa1+wtYCeQ
 gWg2cfWm+BTnphXDGZTN0fB3msvcpody6iHT0imOHfoRgFruZSKAWHpTjfcmMG42HBgP
 CDMVqW+XhIMVhnwbxGAiODYESbxjGzXrKI4Ics5eq40QED8q3cISqkKmlijz82Rbqa/Y
 xsq+7fNMMC2wnYDPuNZYETDYBPhwZn+fimrjGvOuDOOQWoxhMU1P+ED9H2T4/xwUvBVe
 LyYA==
X-Gm-Message-State: AOJu0YxiCBM10DrZkP6srse1DBJ5o8awzNckcytkamDTdI+ACjNG/Ad7
 6KYBKoN3DLiWB/U032b0x3qQFOSyp6INuAUUlBiJq/RIXJ5hE5sipe77zfFy6TOI6z3D3ZAavzc
 Yfoc=
X-Gm-Gg: ASbGncssNFxSJDTE3mi1ZKM99/1zRpIvqjzYQZ15NU9gsyiR1QG8EFuq4n+zVQy4P72
 C7+3DdganmtG03x4zUWbY2ejucOk6VeGCTcHHKBFPo8q5Yz/kA81QBXq7eziuiiDE72sJAAXzkd
 fFgHsP00NFp+e9gQyH2yKKfp4lXEQ6KCm7hQhTM7GCUqwFFnky36Yw0Unt+ze04Ylc6k4EHdR1T
 mxmlLU9xqyvYpsaBBzJeLKLzef/Zmsqgeywtm0bg1r5nMW4OiEAxRTAvGesLFuis7eJmKTig8rr
 p+ZWJXtpYAX4wbd8WUbxzszevgI+yEq71YfXUCH3VupZ3tZCW1NpfjgSsZRkP6wR2AI9ESburTb
 F
X-Google-Smtp-Source: AGHT+IHI3e2uzb6ydSGJq7Z65bVCxQDLB5rBlI7BS0qvYUCzxjczGUUBulviXy2T0MbrbpLLpE4jTw==
X-Received: by 2002:a05:6820:4b0e:b0:603:f973:1b6 with SMTP id
 006d021491bc7-60652baad2fmr2098131eaf.5.1745624590447; 
 Fri, 25 Apr 2025 16:43:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60646862ec5sm919304eaf.3.2025.04.25.16.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 16:43:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Hal Feng <hal.feng@starfivetech.com>, 
 Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>
In-Reply-To: <feeb0d44-78d9-4652-9fd3-63c130a22637@canonical.com>
References: <feeb0d44-78d9-4652-9fd3-63c130a22637@canonical.com>
Subject: Re: Pull request efi-2025-07-rc1-3
Message-Id: <174562458867.746741.14204164540153528110.b4-ty@konsulko.com>
Date: Fri, 25 Apr 2025 17:43:08 -0600
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

On Fri, 25 Apr 2025 20:58:50 +0200, Heinrich Schuchardt wrote:

> I have added some board related patches to the pull-request:
> 
> The patches for supporting the DeepComputing FML13V01 via
> starfive_visionfive2_defconfig were positively reviewed by four
> reviewers including the StarFive maintainer but I did not see any
> pull-request for RISC-V.
> 
> Enabling unit tests on big-endian Malta boards and raising the number of
> supported DRAM banks on QEMU RISC-V are more on the trivial side but
> were also reviewed by the respective maintainers.
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


