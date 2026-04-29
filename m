Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D68FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A26A847B0;
	Wed, 29 Apr 2026 10:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ELrc8B/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DE16847B1; Wed, 29 Apr 2026 10:49:50 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79E33847AF
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so149622865e9.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452587; x=1778057387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vVBor77bgXqxUp4Nu4gczRHRkWYWFmANfcXQHrQXwyo=;
 b=ELrc8B/A5s8XtUsyoCEVN9D2UjsP5zKFsCtJbetZ3Kj17mkLvKTkRR9/rnnbYXge9L
 sQPI4ksB4SeGznam46lIOD3ahqGanOBrxuXm+Rmu9k2anRYYXbreKwgQvp6xLu8gIimo
 z4Lw4tFd0dArSod2iDvABsU0QB67F2WIkj0gog26hruBwYNxlVf73OPK2bs3HOFJRM1/
 CDzAqzeHwuME8bs02E4YVd+J7I05iitTsDxlEFQ7z+WvxhJFLrhMitK09g/dR5kVaSc1
 znIRtlHk8/gaJ6IDaTET5LB/2H9qoPWWAj8RIeYtN7dFdkTnnKL0dxlGyXwc/tyCMnwI
 nBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452587; x=1778057387;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vVBor77bgXqxUp4Nu4gczRHRkWYWFmANfcXQHrQXwyo=;
 b=LyvcwQgMqqvyjpZ7c+Dv0TzSqbuL4z8NYrQ+fX/awe9x5VSKZnWggSygxobU+CPTt4
 0PaPXj90lIXAZjx5V5xpARlYesMFKWZQdv6qwPnDhmLUCocJDOl1SC7zkFLXt9fErLEp
 Cy8F1WDeYPj9HKI3VqQS+H+6RJ0SgDwiWs2KpbG9tG9uOzJYg+qheGXlxkghQMY82yI3
 TV4mzmULLJpRFgpbyLe7HQICkzW3JLw6oUOCCYHZqferMW6VaiblcPL9LwBz4aT5iNip
 bRyacuiFoflzzTwkBSJ6ZSpBt6fK2bkICTc1qs7izx53GEEpZJHXLUa9XO+5Ll5BfxUO
 PoUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2wVGNGeSVITMGypcJb81lOZ4eKFfutTBpCB2WRNrRg23TLO4Bf/lbTEytoXUILuCMDrA1IK8=@lists.denx.de
X-Gm-Message-State: AOJu0YwlvT+IW9oWiUpjp2KhQji7GFXkSHdgSwTktxje2bOmu64UyVVZ
 mxT94jXNV+kpbe9VWSmwr6oiqJ9VfxpEY8/qjRewz7xo10IfbhvPFRKrukH/3rvxH2Y=
X-Gm-Gg: AeBDievqB3GWHkGJFyUEDnlW3HYme5tO/eI9rLuBngrVFLy59805xInu3infOxcBe5w
 GnXusCoUZY9bjwQ4TLZmoXs5GPQxyMYxl7byM1P5uwJ/k1ks1IT8sI9krd+0g/YnvmI8UTZBsVk
 MgA5fZIkY7kd9ihaBPorK05ce5CN6n+p0AOBNlDDrne9KA4bUQ2aKYQu7FN9cTnK8D62E/6BRaP
 3YZBe/SuITImNMT9Ie2TVDXGQKND9NitR/nfMNjb5WG53Uw0CUmwyLM3u93X8isNbH23L7VdOlG
 Ckp01iNqbsiqf9UwMk8wg7sqzS3uzWa8sVF/Sm1MLd9XWKRATqhBlVGMJqCFGPF61n6GkpF2XXP
 G3GtJvUwRE0N5T2v0Whpx3GP3xzReoGfWycmQ/h1l9PyS00z3QmsFOBeBwo2HbQ7WWKyY7QOxb5
 /VmKeycx+bydY+jHB8PAy+FuBevT0K6MgpQJqTrGmCdWCFqlK3jmf0WT2wmM4+gQ6RI8cMghROK
 YbnH4A=
X-Received: by 2002:a05:600c:6d8:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-48a77ae89ccmr58069435e9.12.1777452586741; 
 Wed, 29 Apr 2026 01:49:46 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc80454sm42715245e9.13.2026.04.29.01.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:49:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org, 
 me@samcday.com, aswin.murugan@oss.qualcomm.com, clamor95@gmail.com, 
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/5] Implement reset to EDL for qcs9100
Message-Id: <177745257538.126665.2656997891353052864.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:49:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3523;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=1qFovll+xhI4MoZdi1CN5FwxBFCkMubaSRrZeFGjvss=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPxzSrjhcfeZDbo2RrEa+w40HaKieRhHzvwjqxwC9f3
 O61SvB2lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlk3mL4nyiz8rlT3WHFBWqP
 HjxhkzfXnCT8gO+HM7Pv7gnn9/tpZjIyTH1j3LaJU2OHr0plpFvG7XjmMFWbEzn12/63chxn11t
 aDgA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Wed, 21 Jan 2026 12:09:15 +0530, Varadarajan Narayanan wrote:
> Implement reset to EDL for qcs9100
> 
> Using the 'reboot edl' command in Linux, the platform can reboot to the
> Emergency Download mode. Implement the same for U-Boot.
> 
> v6: * Add r-b Sumit
>     * Wrap the new code inside CONFIG_SYSRESET_CMD_RESET_ARGS
>     * Size change details
> ------------------------
> qcom_qcs9100
> ------------------------
> Building 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
> 07: qcom_defconfig: enable psci based sysreset
>     2    0    0 /2              qcom_qcs9100
> Completed: 2 total built, 2 newly), duration 0:00:25, rate 0.08
> /tmp/qcom_qcs9100/tot/boards.cfg is up to date. Nothing to do.
> Summary of 2 commits for 1 boards (1 thread, 16 jobs per thread)
> 01: Merge tag 'u-boot-imx-master-20260117' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx
> 07: qcom_defconfig: enable psci based sysreset
>    aarch64: (for 1/1 boards) all +145.0 data -40.0 rodata +89.0 text +96.0
>             qcom_qcs9100   : all +145 data -40 rodata +89 text +96
>                u-boot: add: 9/0, grow: 4/0 bytes: 656/0 (656)
>                  function                                   old     new   delta
>                  sysreset_walk_arg                            -     124    +124
>                  _u_boot_list_2_driver_2_qcom_psci_sysreset       -     120    +120
>                  qcom_psci_sysreset_request_arg               -      84     +84
>                  smc_call                                     -      68     +68
>                  do_reset                                   100     160     +60
>                  psci_system_reset2                           -      44     +44
>                  psci_features                                -      44     +44
>                  sysreset_request_arg                         -      32     +32
>                  qcom_psci_sysreset_ops                       -      32     +32
>                  psci_bind                                  188     212     +24
>                  qcom_pshold_ops                             24      32      +8
>                  qcom_psci_sysreset_get_status                -       8      +8
>                  psci_sysreset_ops                           24      32      +8
> (no errors to report)
> 
> [...]

Applied, thanks!

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/5] arm: psci: Add API to check for support of specific PSCI function
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a612b3e91439
[2/5] drivers: sysreset: Add sysreset op that can take arguments
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c74ea771aa53
[3/5] sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9562f10216a6
[4/5] cmd: boot: Add '-edl' option to reset command documentation
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9db72d4b767f
[5/5] qcom_defconfig: enable psci based sysreset
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/929d794c99bd

Best regards,
-- 
// Casey (she/they)


