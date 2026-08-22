Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A47C5B572
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 15:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0BD64083B;
	Sat, 22 Aug 2026 15:21:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3tggkz-kUYdN; Sat, 22 Aug 2026 15:21:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787412114;
	bh=OhmVLEJ+BMNZm6siUqh2e5taiOcrpafC55Qd9I2hI9E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLr50Wl0ea0bn5A19aL6H7rP/vkXWLpjNZxTt3ubroKas+X6Zkkn+6VWvExMuIUNy
	 hfWFWWV0Q/IMyhxqVNxtGQR4hKh92zo3lMHNTVvmq3vsFqPACsptMUbEdUu6p9nOl+
	 Rfgquwf9Dv801mzv9My11rGyoXs89MJHJWFUdVOntBfG0y55VC7ZHb73ftPs+eFe+G
	 qe5Dp5nwVnEskBQgaZ9124p39VqxWq+oscMYFm2Vuokpb5AZdqPdfHD+4h/DTQqN9h
	 7LyF5WQzlnIeJVTy5OElNeGy8/d8XFHwTiFtdPhlW4vlMDNmCOpPQUr+W2bqA2s4UT
	 FXRgoum0HWH2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4892D408A2;
	Sat, 22 Aug 2026 15:21:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 27C34336
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19D114083E
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TJ7VAd8Z1R7Y for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 15:21:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=JBWKTnEL
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 48CD440825
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 15:21:48 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-495c49f8eccso1683261b6e.3
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787412108; x=1788016908;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OhmVLEJ+BMNZm6siUqh2e5taiOcrpafC55Qd9I2hI9E=;
 b=JBWKTnEL4mOvRlPNBxQJGDNvQSpMhvApoyYWFAJUGOLmjHxBJV2BQN8CsEop1Z3mHW
 szTSkNYDbzcUStF7Js/s7VKDIet5eeIOR/uQSnOJMmUmV+01sixk8j1uQsr5Ejg+CQpf
 GJy8ftJO5p/g06CkdJSMnCqrfmUURkPwXT0AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787412108; x=1788016908;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OhmVLEJ+BMNZm6siUqh2e5taiOcrpafC55Qd9I2hI9E=;
 b=bp+RUmu0kUCbnhcrU98EmETdoNxE/RXM3eeXhmv9WoR3dQqiABnftkH0HCOb87/uTp
 wzGmnuOLuu3nEKOb8MJVo2Q+Ip6ndfF7cMnwlFbPofep79ujAyvgoTyoV4cpx6quB4se
 d1IFukpdW20Q45krS2gjvkl0xh37G/HfW/MrPeBbMAUvxlwuNGEbyHrAPfVYtqD1GysG
 q1Olc4YWhS2srDbk+yIqwYgUWIlCJCqUc9NTh16cwft11WKXa/bwVV8QRNAZvByNqbiZ
 IGojPxaMvPyZnpTs4PWI4XcdcvzP8vfjCQgLd2YTQqOuVhYhXRQra0tsFrZ2a0tBV8TB
 WbfQ==
X-Gm-Message-State: AFuF++lfZotq2SLgmsJ6cdqzZGwFTDefUucrpC3vszIOLxp/iUSljaoS
 aR3H5pJ0MTAV1V4YZg/Acl4jcRRXfU4GAP2eY5rFQV/3Os72q6acQgb36wp9XF7VID0yRAL7PlC
 bG9ftElA9XLsW
X-Gm-Gg: AR+sD12Telj4Tv8832r1FiyT3nBGTyXc+bStp+B9cOPmFDp9KPB4QzCN99utSZL0DXV
 w9jSPGAm58KQNa2Lr0HvhS2PrTdb8zoT6+EKJeZP8eNtIe2pVeEpQlXf9RyQwmx3510wJ5tgqZJ
 tGn5aenyBi3xzBd1H2UVd8hBsaJ3gdl9pV1fnu7sQ3WbXh6IFlRsS5xG1ud3fvThxSUGCJVfmPI
 ifLv1PsJy0T1JkgKeZxSRgyzr+0ZZ6pc3URKO3UamqtYESNjfF8l2rw0U6EffzLn5qY8FRGYnMy
 ZZZZ2HjvBzk7JCqLS4FtqWGzzC2y8lUb6dj7y2mKD2TPDhEs0Y95wTZF8RQ16/fEATMbNUnbvNa
 aVrLn/xl2xUUMG1ZoTCcKJLMsIilCAipMAJKNANpGrlbHSo5C3+h4wdOMp7iC1JR0SmENjtjxjm
 bqTUM52FceADO9xofLOLNryjDtA2NhdvHAivb+mE5WsNG27+45xbf56ttd7PLQiaHgpWIgw2sqn
 5QJxTJOIItOUytV7dqSasMe2Sxl2IZ67ySaLOshkVdGYvTgoxWwFp14jRXq5R8qmari0jOkeIQe
 UbqHiNqJ
X-Received: by 2002:a05:6808:6d90:b0:4ab:230c:5faa with SMTP id
 5614622812f47-4b2ef3ff502mr15661758b6e.18.1787412107632; 
 Sat, 22 Aug 2026 08:21:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2d6cdd6cbsm7345983b6e.10.2026.08.22.08.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:21:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>, 
 Francois Berder <fberder@outlook.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260813155617.184928-1-aristo.chen@canonical.com>
References: <20260813155617.184928-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1 0/7] bootstd: Fix crashes and memory leaks on
 scan/boot error paths
Message-Id: <178741210639.4158046.8924686609120884055.b4-ty@konsulko.com>
Date: Sat, 22 Aug 2026 09:21:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Thu, 13 Aug 2026 15:56:10 +0000, Aristo Chen via U-Boot wrote:

> This series fixes a crash and several memory-safety problems in the
> bootstd scan and boot error paths, most of them in the RAUC bootmeth.
> 
> The starting point is a NULL pointer dereference in the RAUC bootmeth's
> get_slot(): its loop condition dereferences each slots[] entry before
> checking it against the NULL terminator, so a BOOT_ORDER environment
> variable naming a slot that is not configured in
> CONFIG_BOOTMETH_RAUC_PARTITIONS crashes U-Boot. BOOT_ORDER is written by
> the OS (RAUC) into an often disk-resident environment, so a stray or
> corrupted value must not crash the bootloader (patch 1).
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] bootstd: rauc: Fix NULL dereference in get_slot()
      commit: 7cf8ccaf7614e16aa4d57620e61179e73907ab6e
[2/7] bootstd: rauc: Clear bootmeth_priv after freeing it on error
      commit: 22100a6520671c357a28ffd25d5736abba77b427
[3/7] bootstd: rauc: Free string lists on error paths
      commit: d8b381ae3fe8804f6e90016684adc55d4244c3ff
[4/7] bootstd: cros: Clear bootmeth_priv after freeing it on error
      commit: 2fb0b1da6780bc0e6e24c600eb1e8738160aa049
[5/7] bootstd: rauc: Fix leak of the strsep() source buffers
      commit: 36381cef22bd9ef943821fb94b15f43bc287a513
[6/7] bootstd: Free abandoned bootflows while scanning
      commit: ad1fa724f82e201c870b90c0822fb5b90d8eec5b
[7/7] bootstd: rauc: Clear bootmeth_priv after freeing it when booting
      commit: f2bdbe5080a6da3222cc753e24e0c23c807ff9d3
-- 
Tom


