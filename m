Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB25C44520
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 13:44:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B2984E03;
	Fri, 17 Jul 2026 15:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S6fQQqBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABA6B84E14; Fri, 17 Jul 2026 15:44:09 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3C7D84DAA
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 15:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69a5ecbbfb2so7543649a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 06:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784295847; cv=none;
 d=google.com; s=arc-20260327;
 b=Jf54wwI/+jH2WbvGi6bxN7MD08G9ouIJJpObgyQVUXkbE6qTrE2IK46mJCKJIpky7d
 71QUGQkxtNDzatHfNRXcK706CKshpOm5LISQ9J0Ql9dSIv0F3Is3xf+mTBAoiPi1FUVp
 aYOJLuqEGOaYnhE6fMvhDnsGoj/UlIkKyadmjeFGk87O6H1MM6e7KS6ZEQ4LWu02zBe2
 7owJyJ/b2TfIgswIAiQOJiGp2K539TGMIZ3HHEOZkqWQO2ycSpBsP32EYbStmZf4H/lh
 D7aS1ao5agIyfyREtzuNu+sC7rDoBr4EBcjog475zY3X+RdIGPl0THaFUT0PtmdKKkek
 a6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kja7j/uUBpemjfj8GwEmlGQ/enMCe9taLE2wvRm7VTM=;
 fh=yvRhMYHcowrXK8ywRK1XjoXXosOJ1yaBlky3VWa2QBc=;
 b=I90rOW3VssC2CYqmHdKiGfMxw1LoGZolVYoCvQgysUG8pK7V4PakSGQj/oEyGWDOfO
 7yUBxFXNLIvwNLrUFglPL63Fnr4uRYajLa0exh0oQ8+RCE8mMGL98CbkxpntXD9+8nrW
 UBbjyauCVbsn4xiQ+CTNHTbNsM3yBYMNYNsyols+HN4quEwPQrqmnDGgcmN2vGchGJxD
 0erG8j0klyIP+I56zvucu43z/Hrmi3BuMbKg+uz2rRy3f7bsr7Xvr13IUymgHsrfA1Hu
 YRFy2Zk9xt4KBbMyjTapvEeD+mmcrLFdMDSUGLnfyH7v+2/QUDswHEQiun1JYigO4TN/
 mQcA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784295847; x=1784900647; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kja7j/uUBpemjfj8GwEmlGQ/enMCe9taLE2wvRm7VTM=;
 b=S6fQQqBdhdUxkvCNnWYXJzyhZCHTK3IuYoHNjdcelF3amrvTA/9AtnNCAvkxaJs9ii
 XNsMy3pyKkJ9QodIgtUl+z+obgQ5EN+6z81EtXBdBYMpMeQjgHsFeVPtbfr1QD4/2MLC
 qIaHNzAe/K1O5AiS3khWnvVPQd3XMu7t5piTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784295847; x=1784900647;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kja7j/uUBpemjfj8GwEmlGQ/enMCe9taLE2wvRm7VTM=;
 b=AN1ge4PcEPRBSKeLne5Uk/am0j1Hg6VGXp4X2AmmbbA85UFhrVmxPO9d74/LTjVasS
 l3hbbvBJwxzQngbRahOakQN+Hv6MFG6K6U5c29uM+m57jquucQU2jgdQn/eE05oT0Oqm
 3YKdvEMKmg8k9JwAsuO2NHJG+89ifmgALHfP1Vg09ef6G3J3VhOryC5mzyc2zDXPQeRH
 u6zrOJ5/4SK6ZYM1VzerQkFXhVkr/2Sw9PZFGrpOJ4NZCFH2s856MRnlgO8HmO0FCUMe
 uko517xeTzmBNckvRNkCXOD5tNsnw4cWZDEAgXMHsxP8NBrblxXdt97Qd7/4hnRxskQR
 7sCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2C6jMg6uA8w4A6S8zuoUhZCM34RxCMWhVvmYiMcgcNj/rfoqK+wuMHopof+lV1gYpRDC8mQY=@lists.denx.de
X-Gm-Message-State: AOJu0YyJmqkvtFLKWJ96GBbxSASFi9LvVLgstPNSXM+tSDWv07YfLzvJ
 oWEgtPIJS6wVK7wO0mPB2el2VwLOM1rFE0sif8MaDNoUOw+o/CCXbNHNMkg9J4Vx8FchUknqTIA
 PPDL0WLHJo5MJFjtCzq7woshug4jCnYwvYime0Wva
X-Gm-Gg: AfdE7cnqwJXWkbgWI9giYGt/mAhx1NB/zlsKPmjk8El1umKA/ZYJGcG5N4eJUC8e8+I
 lzwoG66kHUt9i15X9noum2zVOxOoZ+3jTBeKEHibmVWpWF6KlDE7qm5KQXxu8Wt9Q2xzQw/8mZ8
 JUfmN8eYuke9LABdDK0uQh+6Eld77LcQRaeGnbcIFT/WdkxV/NnTfb0g5qSqsMmYX6/50uTmuHe
 OsT2WnYzFHil58dOz/BbsyztMv72BG7dewZyz8NQKwStOEFYP8W5mTvUvUNtQFmCwZxDCs=
X-Received: by 2002:a05:6402:3805:b0:698:ad13:2a62 with SMTP id
 4fb4d7f45d1cf-69e6525c68bmr1051326a12.6.1784295847259; Fri, 17 Jul 2026
 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260711160808.2022242-1-jonas@kwiboo.se>
 <20260711160808.2022242-4-jonas@kwiboo.se>
In-Reply-To: <20260711160808.2022242-4-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Jul 2026 07:43:55 -0600
X-Gm-Features: AUfX_myphZ5Qz2C8Dz_Sriv1W6z-fXjm-fLxVxCgG8M93AUhZQSeYw64NDJsBGg
Message-ID: <CAFLszTjZpOrFfsEFbE7deNhYMpSVZjXRxGdeAs_c_2Ndo+P9vg@mail.gmail.com>
Subject: Re: [PATCH 3/8] usb: Sync linux/usb/cdc.h from Linux
To: jonas@kwiboo.se
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On 2026-07-11T16:07:58, Jonas Karlman <jonas@kwiboo.se> wrote:
> usb: Sync linux/usb/cdc.h from Linux
>
> CDC NCM constants and structures added in Linux commit 01154aa71424
> ("usb: cdc: ncm constants and structures added") are missing from
> U-Boot.
>
> Sync with Linux commit a67df6d1b939 ("uapi: cdc.h: cleanly provide for
> more interfaces and countries") from v6.19-rc1 to add any missing CDC
> related constants and structures.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> include/linux/usb/cdc.h | 233 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 232 insertions(+), 1 deletion(-)

The flex array stuff is dropped, fair enough.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
