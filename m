Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAE3CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 17:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7759A881A9;
	Wed, 10 Apr 2024 19:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hpkdbtFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79881881CF; Wed, 10 Apr 2024 19:43:24 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CBA881AF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 19:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-78d543db3a4so292452785a.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712771001; x=1713375801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZM6TIvkLaPTSWqfMfiIsYKYzqJBr8F+WsnCbsvsM2Y=;
 b=hpkdbtFft8MGQ8w8Vjqk5/zPMay7/x9k96H/HXQPaloB9PbbXl2K5PRO389f2Qhj4k
 nY3WWTDe8UB6tmowf1qhUt1i/1GISYOH5JzpgGnDYF3zHp2/tBpK+E+wDAuXCnWlQlPU
 fkAwLj9quV1B+Y5yiyLXgzcHnONk3/bcD7W8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712771001; x=1713375801;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZM6TIvkLaPTSWqfMfiIsYKYzqJBr8F+WsnCbsvsM2Y=;
 b=HXGWtLBd41wnu8cUCk/n2UBHO/BtxNfQHZKStM35fDsnhkMCxMPRe/3lFs9zW6/LSF
 lZuFPnQ7zgzyU11BSz34HGiO9uuqE+KgeWDcd5xIf6EbtYM8d4lLbouQuKBl1ybtbPMm
 0lCQgb6kTt9bjQ6KHlbsMJpQ6oDl5niCMSnReLHA8icXzBYwwHslKVzJYLIHGAJ5+sRF
 0cLqjIy2eZ71apWCdk4yY9dufPLgiF1EuYgWKYaAr6eS0caQarE3Kg6w8N48x1UXU4xI
 Xx2UtqeDP7qvUfvNQK+q4nEpnRHseKhxYtmsos4QaCof1iTCPd2CmnSqjSjJcHLBXJby
 tuyw==
X-Gm-Message-State: AOJu0Yz3R962T0nd31hEgxfCo0JjHZgp415hk8Rwx5Vwla0F0G99DYVJ
 2xeilIgefY09NVvD+FKMoOJU8GorIXeBTZsZ3XiP8Y2LsVPoKyQWXBN/IMt3+sQOfc36zG9qcxo
 ZG+c2Qw==
X-Google-Smtp-Source: AGHT+IHLmOWZAl+VhImQ5Le7iwHOB3oFStBaF+iz4h6FD3gCHl2MpLYME8ei0FZTG34qT3DCtnUinA==
X-Received: by 2002:a05:620a:20ca:b0:78d:5ea3:e750 with SMTP id
 f10-20020a05620a20ca00b0078d5ea3e750mr3409613qka.58.1712771000902; 
 Wed, 10 Apr 2024 10:43:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0078d6b676b9csm2308177qkn.17.2024.04.10.10.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 10:43:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <greg.malysa@timesys.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Shengyu Qu <wiagn233@outlook.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240320021607.9518-1-greg.malysa@timesys.com>
References: <20240320021607.9518-1-greg.malysa@timesys.com>
Subject: Re: [PATCH v2] build: Revive and update LDR format support
Message-Id: <171277099930.98421.14647698347484285172.b4-ty@konsulko.com>
Date: Wed, 10 Apr 2024 11:43:19 -0600
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

On Tue, 19 Mar 2024 22:16:07 -0400, Greg Malysa wrote:

> LDR format files are used primarily by Analog Devices processors but may
> be of interest to other vendors. Previously support existed for this
> format as part of the U-Boot build, but it has been unmaintained and
> unused for a long time. In preparation for adding support for modern ADI
> processors that use LDR, modernize the LDR support:
> 
> - Introduce CONFIG_LDR_CPU as the CPU string recognized by the LDR tool
>   may not be the same as CONFIG_CPU
> - Add an SPL target that repackages u-boot-spl inside an LDR file
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


