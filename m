Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4356CDD560
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78BF789031;
	Thu, 19 Sep 2024 02:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="chMDgKvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DDAE8903F; Thu, 19 Sep 2024 02:01:58 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B29089031
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7a9a7bea3cfso19602685a.1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726704115; x=1727308915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uhhch9eyFR2PF8pF7TfZWceaVQeC6p6Vg0tXzIgh8X0=;
 b=chMDgKvnPB2yVhFi4yr5Pk4RW6+ybsZANk4JeZk+Q+o26P2iwvtrp07lMKnDYDAOSc
 WMybQPz24ONdVoZesAF63V89ueyLZCbfcR2KN3pgTQSsI/r1GraBm9q/lhbtXBoFgkwk
 dUYTxQhkQtdQWSJmvEV5Kr3izgIEH4FvcSl1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726704115; x=1727308915;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uhhch9eyFR2PF8pF7TfZWceaVQeC6p6Vg0tXzIgh8X0=;
 b=SmfnmbFKuvHNOeFeWGjU8LXZk8JJ0+M+5E61YI346M+qaHDPevChJ91XTzMsPjXWje
 nJJddFsyFItrof/gMA2MtijLehWJ0HCW0CbM3ZYhYNw3sVXiADASRA6Dz390S4/D/XRe
 QLkEnNsnboNWodG5+A9OXFZKFBWK8KElsaqGkO7fYKL9/B0mu4+1p3jo/zcGfzl1+VSH
 n175pOKYv27Tu/xBJOHNKOsuiALHFgwIBJhJDMblfO26cTZ28wZyj4tb6nVy22H1pHNr
 vnNWZVx9btAnGcQ7i3aYuUSYZf55M84X+/y+7v1axakUrN9A6vIxtTHbtbO3uF0Yt8IY
 EyyQ==
X-Gm-Message-State: AOJu0YyKrUDP/5QtuFPXrO8EmS19E5vY33XTDGRuXdoiyXjosf2NyyiJ
 mSdzvk+7pWghF8KU6oXVrTcm/vYbMIcIlDtE6jIxAuV455KZt214wQc6Djhd0wk=
X-Google-Smtp-Source: AGHT+IHTPg9XtO9GSv5DGoq6FqMSOqX+4RjDiTp/84SAhzNlkTTx+JOyb3hZKPcglzjtYYMvBhfwfg==
X-Received: by 2002:a05:620a:400b:b0:79f:1720:f1ee with SMTP id
 af79cd13be357-7a9e5f7b8aemr3888858985a.57.1726704115323; 
 Wed, 18 Sep 2024 17:01:55 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08eb9ffsm20387485a.128.2024.09.18.17.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 17:01:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@denx.de>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/23] Fix various bugs
Message-Id: <172670411267.2233369.9536391639775822117.b4-ty@konsulko.com>
Date: Wed, 18 Sep 2024 18:01:52 -0600
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

On Sun, 01 Sep 2024 16:26:11 -0600, Simon Glass wrote:

> This series includes the patches needed to make make the EFI 'boot' test
> work. That test has now been split off into a separate series along with
> the EFI patches.
> 
> This series fixes these problems:
> - sandbox memory-mapping conflict with PCI
> - the fix for that causes the mbr test to crash as it sets up pointers
>   instead of addresses for its 'mmc' commands
> - the mmc and read commands which cast addresses to pointers
> - a tricky bug to do with USB keyboard and stdio
> - a few other minor things
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


