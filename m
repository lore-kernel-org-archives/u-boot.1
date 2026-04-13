Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2F8F531DE
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 23:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EDF783936;
	Tue, 14 Apr 2026 01:35:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s2RNxP4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B924A80517; Tue, 14 Apr 2026 01:35:54 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9B580517
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 01:35:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so4487393a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776123351; x=1776728151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pQTZd4SgP7CXi96lwE/gI8o//QbSHuOUKSuqAp50jSU=;
 b=s2RNxP4assJbi340qwBlKB8+O9CRqspZ8HecYSmrVetdgdspCt085TZV568luzrOXF
 tipQr/1dIQzQhCALkhHeZJrkrgLyOMqXMNVwMMqFjH6kCqi/+lV4hq/LNoWkSgMZqgD6
 aMNA2qBNBytE1QIIUuXnxTZPwHJ2edU7CyCtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123351; x=1776728151;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pQTZd4SgP7CXi96lwE/gI8o//QbSHuOUKSuqAp50jSU=;
 b=XKUNgaZc79Bibk7irxcdC+5xygiGWYpKHvr5UNuTrPEcgWKO0ixaBWMoVaNpvkns2b
 gx67BOlEXxTgWaCuCtdQi6dS6ZydNh59V86y0EjZSGm+P989jNe9X76mFDWCLqHDfyft
 /L4zpgcHSdoN5odH5zlv7QvmTV1EVLgLgpXkgQc9L/ijfufvS88TqW+xuwaBvNqOJRez
 VCdkFy19AwKxGm9UgmXMM9YsdQzhEEA5jTBBDeVBvszYs/KzCdYU+z6CMACgTjGlD4mk
 9IbKRRF1kibUKFyqFStNMkDZaVJC+vA4oPGcry4OHrDTYMoO5cE6A+otKFF1xKcKH9K/
 Veww==
X-Gm-Message-State: AOJu0YwZ800yIoBG92FA0N6aDC1FDWU4kprm2BEpBnzQYoRGZARAvKeg
 RlO8JhraR6/hp76PypLREQ3C4c/9vKn8NjA7/teL1d0xZ5RQSQBdOp/yZCP+QeCETygQhMbR1sN
 KXrSTAd4=
X-Gm-Gg: AeBDietEfJQJMPWVK2q8ffG5Gklpsh7nPQxSLHB00i1yh9V5TAwH2iXCzw4PqyOL77R
 F9lWBb7C8chNtGn/Usqm52SPAUjb9cdL77o28NHb9VV3ttSUc2FXzD5Blxp19v1vLj7DAX4/9pC
 O6+FNp7OI8Cvfn+4sxJunPM34ZqpH44usA8dp7McrgsAxykoNyZAwQwdL/kFsG1wHInG1SBi+Z9
 jK8wGzmaQodB96OCsAMmVSIa6TRzmoxyQ4fo0R5CF3ealu7QzX6LRCwD0SuCnq4pnEezfV07hny
 3HvO1wqJhIy1ONakB0tpYYnxogKTVgFYfckWqx656St21eEEGMvfzgxLQBm7szhrR/FUyqD++pf
 Eb4UeySRf185ndVWaNv2naFMHdup45eC+Qx2EWAmsmY+xL8Q0ivDjduoX11OI6grMvRwXVnjSSf
 FU81gJ7VPBtTY+xcm4+LxMjDumGzxSx0umDTarluFPOVlC2SS47m90vDlYJNbEwcYa+Ve7ExUFS
 RrUEHXOlnTTnFolPYCya0acIiXZJNZidr9g2yeJCXK8fsQsg5RCpY7G+89S
X-Received: by 2002:a05:6820:4b92:b0:685:2a2d:ccb3 with SMTP id
 006d021491bc7-68be652db41mr7508214eaf.20.1776123351377; 
 Mon, 13 Apr 2026 16:35:51 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm10227910fac.2.2026.04.13.16.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:35:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Javier Viguera <javier.viguera@digi.com>
In-Reply-To: <20260310122033.2037427-1-javier.viguera@digi.com>
References: <20260310122033.2037427-1-javier.viguera@digi.com>
Subject: Re: [PATCH] rtc: rv3028: fix PORF flag not being cleared
Message-Id: <177612334999.2487918.337379853654819607.b4-ty@konsulko.com>
Date: Mon, 13 Apr 2026 17:35:49 -0600
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

On Tue, 10 Mar 2026 13:20:07 +0100, Javier Viguera wrote:

> The current code sets RV3028_STATUS_PORF instead of clearing it, so the
> flag remains asserted. Use dm_i2c_reg_clrset() to clear the bit.
> 
> 

Applied to u-boot/master, thanks!

[1/1] rtc: rv3028: fix PORF flag not being cleared
      commit: c8afe949d3dd5b2a2adb0e4f476372f2df8512de
-- 
Tom


