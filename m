Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A887C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 16:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195CF838E3;
	Thu, 24 Jul 2025 18:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ubuefmNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726B0838C7; Thu, 24 Jul 2025 18:33:45 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59400838DC
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 18:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-41b8e837427so349078b6e.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753374822; x=1753979622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xCgUcJrWdOqe6MDJICmx11s3VWg21mVBUeiuZFvVm6w=;
 b=ubuefmNa2xWUJXUEi/wZqSuHerC10DeiG0IBP0LygEV5ezKR78mr91TIEQdaHMPTqR
 +P9brsnwryrZe2unXUH/OBnYpDwfeQ+7tSw4sy9Hf+2cS+G2C5z8auSOFZRU3TlkQsqU
 fZXHZVsezdZF4ElO8LAuXv5hU+FyZkOiwIACQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753374822; x=1753979622;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xCgUcJrWdOqe6MDJICmx11s3VWg21mVBUeiuZFvVm6w=;
 b=Y113Dun/LessyOIkfy/U3g1JX0QvfmV6Dr7oc52i387a0xUUmnoFMrNWHZe8t9zomS
 nXiZGtK+O3HAUmQA2HYk33qfMj7XCiUq5e5wBwKhVPFxCLHq/TgkALLMXp8M9NAtJzB5
 hTezNKCud0QSdJ8XRB7FGgtNOjQYAWiCYEX7ULbSnXkjyzoI1qF7/+5qJwbVseZuVjUD
 1vCYiE//QxYJn6YwU0Gvok6MnruWdkdjY3v/+IZBP7muSe2OlSqDOahqAiRt6GOm6gMC
 g+Y6TxQth3X6/B1RiGBVgArED2QyKV6tGpzqIkMkwSoyQ0qEHQN0/9JKTDWqviz1xy1h
 qkxQ==
X-Gm-Message-State: AOJu0Yxi0mSvWLbGDZYE4l0jRBaulErdfywj/JZMY/kxhjcWUyqaU5uM
 3VA6JZnc0t0Qw3EczTzf1B/l7RJok0KR5QmIBTiAD8wp9w/mBFdxRzrtZEO8XjBvTCrytQz3yq/
 d5A4gbow=
X-Gm-Gg: ASbGncuuqmY+JevtWDpCnHhLzKDHpFqPHO1yp+Yq1VWYNYe9A36TBIXpv9TZLaCL85X
 ifXJC58g2saO7RzH1pQZdCwE4Qcj9yyEQWc/YbCP7fqAJnK6++nQ0fWYRsQEWJud8HBDTcoTbVN
 X+cFnrkoxxL5N1yj/6LXK5ul8/A2337IfsU1Epn51cKw/ksW1iu/CIHJhg2mTZn/y3EcG4+jScw
 lV2hWl7TYYBHdsiIc7dZc41fGr0uCX/7Z4n/rGNMKS2qzSNHehwog8Ek2PMaB2cYDNCFKnGPJOF
 pc3u47u30VHWFFXzwJAmFPNswB+LAP0ZYt4F1BmrgE7vVg3rWAvpmBFjhYjNfg66Uoo1XER0iih
 Fcv0esWfU/lKsozzuNWI8K/Rr1Jx0D2FRANJxiotNBEfFzH4KVgADSQs=
X-Google-Smtp-Source: AGHT+IHi4mD20hpiwxlyKs7rohDwObCZGRtoNAhAubKxh+yQPBIvI2t1NSLGeNp2xjgEgvf1dbDvdg==
X-Received: by 2002:a05:6808:2182:b0:41b:eb59:7c63 with SMTP id
 5614622812f47-426c43f3db3mr6662804b6e.1.1753374821818; 
 Thu, 24 Jul 2025 09:33:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a33092eb8sm294351b6e.33.2025.07.24.09.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 09:33:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <fec4bd62-0883-40c5-a1a6-cb672e489075@amd.com>
References: <fec4bd62-0883-40c5-a1a6-cb672e489075@amd.com>
Subject: Re: [GIT PULL] AMD/Xilinx/FPGA changes for 2025-10-rc1-v
Message-Id: <175337482119.467777.9896983563142440007.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 10:33:41 -0600
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

On Thu, 24 Jul 2025 14:10:05 +0200, Michal Simek wrote:

> I am sending you another series of patches for rc1. Gitlab CI is not showing any
> issue. The biggest is FPGA series and there is on patch revert in spi which
> should get to tree.
> I have some other patches pending but I want to give others more time for review
> that's why will apply them in future.
> 
> Thanks,
> Michal
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


