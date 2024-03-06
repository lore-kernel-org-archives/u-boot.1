Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9B1C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 16:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3953287C92;
	Wed,  6 Mar 2024 17:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F2jVP2Bh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B3587513; Wed,  6 Mar 2024 17:53:22 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786298785E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 17:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-472997f6747so994340137.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 08:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709743999; x=1710348799; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRQw2UJp1L7FjqaGTzKi40m+PoZWKeV6W7HVhaFEIFM=;
 b=F2jVP2BhLPa5JArmLR450sd0M3A2tUz7/39bJRmvngK+FoOMMC74WMuO6T4uTW6dgg
 CVoukK/3ey0QS1ohKXXThnas5FMnBJnkeWG7RnpNq5tm3judo8fi+KXisewgyhAb7hff
 DXjTsEpVxvP/OjC7cW7opgS4R2LKHR5ka0VxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709743999; x=1710348799;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRQw2UJp1L7FjqaGTzKi40m+PoZWKeV6W7HVhaFEIFM=;
 b=AKV70Sj3GhDJIBWvp0CEe6j4I0jsn9rDvH/xRY0uIyZ/41NWP0j5XvaN/vdWakP/+O
 /YA962M9pcQSG8wMkBtNooYP2CXAK/Ml2nDdS3vKkQ20dwfFuNC4MpIM9U8gvCuDP9Yz
 6RzgpbBvWUcAXM2sA1FP/9BHXEax9uSvUpIDGobM6Xv7CFvJP9I3NRCHy2jPM3XDBr+r
 CrL22entzK/Ii8RV3XBELA5DRqckWHROBJGbyRTflo+05YIIF+xAhu2lbqaH5hgGq6Um
 utbMmsKg8UI6ecoXwDhaLhUeI7ZE95MzWs2bf4rC0z4YNsNvFX1UCqTShh5cApqRfu7s
 yOuw==
X-Gm-Message-State: AOJu0Yyn/5h22yaH0Ekj1SqZG0dBZmbG0SGFEzuEZptBNTDHcYE0E2Ww
 KB8UYhd+PUHukX/QUV2ApO8TxrpDKKL9osmPIshXiZruAzV80MXJHqERCB+2VlE=
X-Google-Smtp-Source: AGHT+IE/fVjBxKW5sQ8u5cZf4nzVp6Lw2Kc3fF/8eF/+4RcqRkDSPYWJeSYTDgTpdAlASlOi9IxPwA==
X-Received: by 2002:a67:efc7:0:b0:471:e1ad:39f5 with SMTP id
 s7-20020a67efc7000000b00471e1ad39f5mr4958361vsp.25.1709743998886; 
 Wed, 06 Mar 2024 08:53:18 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 or33-20020a05621446a100b0068f455083fbsm7571090qvb.63.2024.03.06.08.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 08:53:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240214163009.983034-1-afd@ti.com>
References: <20240214163009.983034-1-afd@ti.com>
Subject: Re: [PATCH 0/6] Move DRAM address of ATF
Message-Id: <170974399814.1291324.3096504473294356711.b4-ty@konsulko.com>
Date: Wed, 06 Mar 2024 11:53:18 -0500
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

On Wed, 14 Feb 2024 10:30:03 -0600, Andrew Davis wrote:

> Explanation for this series is mostly in [4/6]. First 3
> patches should be safe to take independent of the last 3.
> 
> Thanks,
> Andrew
> 
> Andrew Davis (6):
>   arm: mach-k3: Add default ATF location for AM62/AM62a
>   arm: mach-k3: Add config option for setting OP-TEE address
>   arm: mach-k3: am62: Enable OF_SYSTEM_SETUP for all boards
>   arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT
>   arm: mach-k3: am62a: Fixup TF-A/OP-TEE reserved-memory node in FDT
>   arm: mach-k3: Move DRAM address of ATF for AM62/AM62a
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


