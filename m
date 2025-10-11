Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424E5CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 17:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579488393E;
	Sat, 11 Oct 2025 19:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/3eE7sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3CCA8393E; Sat, 11 Oct 2025 19:07:26 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CF28386D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 19:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3544c64380eso3776549fac.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 10:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760202443; x=1760807243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nE9OpbWkPDh7ZFzCA8+gPTSkmKz3VthYCnVNp3aaB3I=;
 b=D/3eE7sv8pH8XXE8hnDh9skLpq5V5sKmg0X4scOuWo03g1OiUP59OULg//JQTuHL+9
 0OE+u20293WdSla06EYWfiA2eh7cUcC0mJPj5sYIe5tY0TPmm5bjOF8rFxHXiMhLcYJj
 rdY18nIiynteW/u6E/F1iKTToVkdEjBJK3CFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760202443; x=1760807243;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nE9OpbWkPDh7ZFzCA8+gPTSkmKz3VthYCnVNp3aaB3I=;
 b=oB/B9V6VBFIuSzKLJhzqX653yRBdnzWsnqhmJAftHFqZ9eh6qWuXaxTEqjk8gvCn+A
 +fHBeVjp5z8lGSu058pIB69Bazs4YlauDm2QT8MdTWBg+yzdeL8ZdLujwUGcjG2AG85n
 a7j7SGyf37XgRYRALWMlEB4KNSKb+FFTVGVcwlY9lXOfGxHmSKI0PxYgTmMHrkkexVcb
 KPdDe4So908zgGTZQ3sVYnaKjVxHlrj+QFLSoEmy9ZxXpSFZlSiI0ujqJOlzqjztO3g1
 iQLk39uKpYjyFOg0olOttLp4YmvYQNQ8f9L2VeaIXmh0kK8oGZ/oXbP/rSQhlsXt2YuF
 JZtQ==
X-Gm-Message-State: AOJu0YydvKPZubdoWfNnXeR/ibEO/xCUuJZ3IeP79hcKtnNWyycfy14E
 lAqgtNh62rroedEyIoJplydRWiWKZdKT2OFQep1QzmiXR08DfOtJw4m+mgafBQizHK6wiACXRkB
 HfHkOhuQ=
X-Gm-Gg: ASbGncvfE+9PyRDJn3cnuLTPbSEnKmfM033t5M19dsVeGvbMZ3MmSp29sVr48byiPq+
 vnM0gNivvCHrChSR6ou19jBlhHw+Rxq1Hhcf6bwsGjGxRKA676uS0E0t76O5+JB7kPdCBOqzOZg
 DbXyK9nUv+r47i4Jx2tJkvnGwrrcu43XApOxj2vcZ9h4K9jrbGMU8tVqUIZA+OccUnrp7p4oNLP
 Alg6tdAtoZxCIAKJT/OqPLB0Bld2bHCgws8nufy9UNYT1SWdG15+namJO/z6vrMkYy178DQWUwd
 7JSfX0fpOSv/4Fc4ai3Opnt0b4x97Q9PR2pczGV3XqCMBARmf3tRnRYu5h+GYCf7PcMszm5v9Rh
 T/J0JAX71ywQCRUHj98S9QEeJxp1I0XKBIui/PaMxHVP0mRze9N/DEv4rJoVPtauW+IuZgDqiWs
 HReD9zWzIj8SDxKw==
X-Google-Smtp-Source: AGHT+IGMO7eHIQovaqX7Qmj3X7ik0jmChPN6/okajzlp6cBA9ZHVEOUwQfI5qU/kfcksi8fMNuNILQ==
X-Received: by 2002:a05:6870:c1d4:b0:367:6cdd:8c52 with SMTP id
 586e51a60fabf-3c0f68eb26bmr7358998fac.14.1760202443433; 
 Sat, 11 Oct 2025 10:07:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8adcdfesm1970991fac.1.2025.10.11.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 10:07:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Lars Feyaerts <lars@bitbiz.be>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250923-mkimage-2-runs-data-size-v1-0-ef3fa57e9645@cherry.de>
References: <20250923-mkimage-2-runs-data-size-v1-0-ef3fa57e9645@cherry.de>
Subject: Re: [PATCH 0/3] mkimage: fit: various fixes in
 fit_{import,extract}_data
Message-Id: <176020244245.1312138.10091418401804099789.b4-ty@konsulko.com>
Date: Sat, 11 Oct 2025 11:07:22 -0600
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

On Tue, 23 Sep 2025 12:27:19 +0200, Quentin Schulz wrote:

> I had to hunt down a difference between the FIT after running mkimage
> once and after running it twice. The use-case is typically U-Boot
> generating an unsigned FIT and then calling mkimage manually to sign it
> outside any build system.
> 
> The issue can be reproduced with the following
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] mkimage: fit: do not overwrite fdt_setprop return value
      commit: 6209ce58c3711a5ccdcd080651e604ba8fd3a067
[2/3] mkimage: fit: do not ignore fdt_setprop return code
      commit: abab733fc24158f0195967e5b6fc69a0de4658a3
[3/3] mkimage: fit: erase data-size property when importing data
      commit: b3ab77345e3d1e7f40f1991e5072daf0f2d972dc
-- 
Tom


