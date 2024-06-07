Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E189CC27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB56884BE;
	Sat,  8 Jun 2024 00:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cH8OyLb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B1E88489; Sat,  8 Jun 2024 00:03:44 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6584088485
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6f906f52a4aso1439298a34.3
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797821; x=1718402621; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSiyWIGW2ydEjsYjIAdMQk1PMzTwq1HQswMCrUUv//E=;
 b=cH8OyLb5HkwQ0K9SCCw7CJAuLsTWiLD6DrFp9cVsPlDg6+Zk7I3+pgNQJfS6lLaVoW
 1iOaoVj5mnsp9eD1GL/gWCqWGPOAZUga80GSxQmMI2RroMtTeWuATZvRo1ktkoXQpcvB
 tOiYZLPMQaf6Q5/mlRHZvSKd7dheof5k6ZlYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797821; x=1718402621;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSiyWIGW2ydEjsYjIAdMQk1PMzTwq1HQswMCrUUv//E=;
 b=L0cM162hH+0ZSTP4CfqHvoyWcrOkauVXgOGVIye7VSzGo1EPBslRQDvTtVpVsG8yro
 HLOBR3lPQhJ90EhnWma7FAp1k6ZMV5z6zFSyrdjuiQWxdFqTcutoid+q//Kzet50cQMF
 PXFHpvjKdN1ibHbT0cg5ZrJrfuBKXeNnB08+aaBJqywc+feV4E98vokvsiIXthY/LB85
 MIBxlMRqD4uhdQcgLcPKmzCCJjWWH3TRa6v+1WhrCQvTo5H3eT0FNk62l+9heFF5/Sex
 tpvw8DpKvu3oWLJvLNglTM7dZdd9YzIhEC4+9R5BpVJKJv46J0QRiaAgFjSugcXW1xfA
 qoyQ==
X-Gm-Message-State: AOJu0Yz1D2ZcOYCTnA5CSN/ZwExHIzmBcuBvkt8rlcV9RaEl235+8HKV
 VMWja7fVaP5xoQeE+m0W+pmC6usSkfX9/+7JepT5JbfbzVcqpdXupefjnCzpkuQ=
X-Google-Smtp-Source: AGHT+IEqX/oqOmOHpSozx/rKI+9IgqZJMASSFgi6NQ3PEgEwEvSw8vtpXZKVkX1pYn60mudd0lIGnQ==
X-Received: by 2002:a05:6870:4151:b0:24f:f8b7:502a with SMTP id
 586e51a60fabf-2546441a179mr3778924fac.13.1717797821037; 
 Fri, 07 Jun 2024 15:03:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, sjg@chromium.org, alpernebiyasak@gmail.com, 
 bb@ti.com, nm@ti.com, sumit.garg@linaro.org, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: michal.simek@amd.com, marex@denx.de, neil.armstrong@linaro.org, 
 afd@ti.com, vigneshr@ti.com, kamlesh@ti.com, m-chawdhry@ti.com, 
 u-kumar1@ti.com
In-Reply-To: <20240520095916.1809962-1-n-francis@ti.com>
References: <20240520095916.1809962-1-n-francis@ti.com>
Subject: Re: [PATCH 0/3] k3-j721e: Enable OF_UPSTREAM for J721E
Message-Id: <171779781959.4156831.3870944998247776816.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 20 May 2024 15:29:13 +0530, Neha Malcom Francis wrote:

> This series was plucked out from the larger series [1] that did some
> templating reformatting and also enabled OF_UPSTREAM for J721E. The
> former has been kept aside till all the platforms affected have moved to
> using OF_UPSTREAM to have less conflicts while merging.
> 
> Patches split J721E EVM and J721E SK to using separate builds, as well
> as enable OF_UPSTREAM for both the platforms.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


