Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C897DC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F866881F4;
	Fri, 12 Apr 2024 04:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DCbYaeUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371AE881ED; Fri, 12 Apr 2024 04:12:42 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B8587F77
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78d723c0d9fso27793585a.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887959; x=1713492759; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uybte0pVt4AzznOloEULmmbKwLmddfXg2wXYz53oYQY=;
 b=DCbYaeUScLyHw4+Zl3qWYV5hil0SRXeY0zKfrO+sXAyNoH0whS3BEzddM0VFcHVMOO
 l1keP8YLBHWLsKDnuuRVJj1KsbaFFzAQKN3QPZwF3tOX+vlo30pCbZ1blJ5KCmQUIuK6
 IDe8p0lvNTxTQ4jn9loP0YFqJVl0mxAaRsPDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887959; x=1713492759;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uybte0pVt4AzznOloEULmmbKwLmddfXg2wXYz53oYQY=;
 b=cvGdnPvlsc42snSz2bYj+s2YAtJzJzMz4PaSWS8e6lvdyhDEMOHgawV3jpCt+MGail
 Ykd3JiyaNyzbniE352muHQiV95WrV9VbRP8PpvXojWhS+ur5scDGmIDTJoLwpHr9i4iC
 OTkvSZjlmNnUNqrlBBqOzF049DRkxNL1J+R53wTN7jQxx7VlB3qQm8RSLalPNT6d10+Y
 zJVIoPYJoaXJXM0jxTuKV4/7DUYVpfAQBvuJ9rF1unKjXVDqUfxEZ9zRbrLqCzVFZY0b
 h67HDL1DKuTjVjWa4hC7rGW5EcAM/NvHMwEYgiZLKL/3XfftSJzOJByIEF0oe57Iof+j
 DUnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Lh5K2yBWcV1z98f3cL4EyK6JOZ+orDFtXt2XYoTrG8Cp2erewQ3jnZoa7Itb9q44k04BHzkgq4vCrN0ZNiOk9QEEcA==
X-Gm-Message-State: AOJu0Yz3M3vUXD0e+poIS1sQ/YqK5JS7RFeVIMeOTxHXIsrd50fLOTg7
 7P+Osy7qfOb/5dqv4/mnF3/3dD/29X93McAMA1FKPz2DQtq3jARuZqyqmvLGDt8=
X-Google-Smtp-Source: AGHT+IGhGPQ7Ij/Q1ZsYLRPK4nQYP1hQS2LS61QPCIWmPlHJjtAL96NRRrbzV2sppfOW7yjnfTSt6Q==
X-Received: by 2002:a05:620a:46a2:b0:78e:cda3:5611 with SMTP id
 bq34-20020a05620a46a200b0078ecda35611mr79918qkb.63.1712887958955; 
 Thu, 11 Apr 2024 19:12:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Nishanth Menon <nm@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Bryan Brattlof <bb@ti.com>, 
 Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240319184343.504949-1-jm@ti.com>
References: <20240319184343.504949-1-jm@ti.com>
Subject: Re: [PATCH] configs: am6*_evm_a53_defconfig: Enable config to
 support mmc rescan
Message-Id: <171288795720.897536.10824674380192915068.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:37 -0600
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

On Tue, 19 Mar 2024 13:43:43 -0500, Judith Mendez wrote:

> Enable MMC_SPEED_MODE_SET config option in defconfig to enable
> mmc rescan for various Sitara devices.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


