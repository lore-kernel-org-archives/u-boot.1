Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB70C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 01:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28AB082BA7;
	Thu, 24 Jul 2025 03:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jc/IJ1GA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0D282B0F; Thu, 24 Jul 2025 03:37:34 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3972482B0F
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-61390809a36so159813eaf.1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753321051; x=1753925851; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpLMo+8HIFqJz/bhC9QddE2/2Jpnu+XzEllZHXqZtfo=;
 b=jc/IJ1GA885k1a470ezTr1VjGKoevSPmY3VLPNwRNHidpXL3bJEUf+OfVbZLCzwB6a
 LAJnQ/c7dFcdXL4/DLSssX1iYCxnU2Kq9HKo5paAFspeFJg0uO9PIBtSCc7nxbpzAvRg
 7CQP53YGzXStBinznEiekhg8YMJs/kXVSarsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321051; x=1753925851;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpLMo+8HIFqJz/bhC9QddE2/2Jpnu+XzEllZHXqZtfo=;
 b=m1VVy21ZmGRCT1py5833APPMyX9eUlKvUF3eF8G/C+zVtV4rfzVG8C68M4PL6ZLG3O
 cVa21+wH4RhBnJUF9gFp72O4BaqyqbsXcDWu7UdVSuYwIQ5NH9PDc5PafjJXamJD5P8y
 3xnuucVy6GscK9EGenEtI6WA3bIGEa3xuJTMblj0wffMyS4vSe56/kKuKVm7GkKzzeaN
 osojWHe3GmRo4LHcDB5i0UiiaRsR3dRBt9nmf81yre8FE5nADCnhTSKbiVGuSDN+ZhXB
 PEEGIhgl8eaenYBp0kFm9cyEyta1ttkFg58VwC70dp4nm75C3MePxu+GomHmiDO/uMx7
 loCQ==
X-Gm-Message-State: AOJu0YzKknUisCVOZ7JE2Lu0T1ePU7N6jYBGSMC6XKRrEPFkbXPfJKmh
 1zdTM8cDX+W80ozYjDjTs/W0p+RaI+E9g3qXDsPaHSCRlExbCgolvSK/ueRranuqWBc=
X-Gm-Gg: ASbGncsmNVtLYQ7PXza4oFUKDJr5Wdm5SkBLSaQw2Vf+5QdA9n7aBpETpf1PrBOZdI2
 83naIoRtpvj50+QNliUQIRYl16NjJIT8LnUc5fFQS1AcNKQANeWFl5Jjz9XNG9yKKN3d2i5QCqK
 nN8mPm1i/3w/Oj74EmflQouUM602YRrU2B3MBI1PsJVwpGNvkOF7sJ/u7dpXJCIgIE6UVs5h82X
 b3NZ6XFGQ1iAR+PnGSgD/88OHQ35L07Ro06AbfOjENJkuHJ+Yup3ZLYSeE9CDd4qBEOGn6j0vyH
 NGExP2oJ4e4MFxd5ydJpA+I7N/tRrG9ty48OHJratnhlkrTukz4aCjXbiyCzXzoJ67dcMu9mmYW
 zUt7+fzipXhb0DmZ3ypZrrNRguNqsbBx8DTl5LRpTdd1/rGNkhwx3kBw=
X-Google-Smtp-Source: AGHT+IFZDkvDcZsTX0QjTNj0M37c+qL50z0y5ryrcpQwlokV52VpCmcsO6Zhw5QdoI7x4p8+bogDkQ==
X-Received: by 2002:a4a:ee19:0:b0:615:e0e6:3d5e with SMTP id
 006d021491bc7-6187d8de76fmr3930438eaf.4.1753321050930; 
 Wed, 23 Jul 2025 18:37:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-618fb4431a3sm102604eaf.13.2025.07.23.18.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:37:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Sam Day <me@samcday.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <9233da992c6bdc0b77e63631da18178ec9d64a99.1752741690.git.michal.simek@amd.com>
References: <9233da992c6bdc0b77e63631da18178ec9d64a99.1752741690.git.michal.simek@amd.com>
Subject: Re: [PATCH] sysreset: psci: Fix SPL dependency
Message-Id: <175332104921.263924.7401304646896219029.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 19:37:29 -0600
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

On Thu, 17 Jul 2025 10:41:32 +0200, Michal Simek wrote:

> SYSRESET_PSCI should select SPL_ARM_PSCI_FW only when SPL_SYSRESET is
> enabled/required. This change saves 1.6kB on Xilinx ZynqMP Kria platform.
> 
> 

Applied to u-boot/master, thanks!

[1/1] sysreset: psci: Fix SPL dependency
      commit: cf13f33d3a684c12f1ef835793cd66193df00c47
-- 
Tom


