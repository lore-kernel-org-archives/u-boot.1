Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910F4C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 18:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D0C883A9;
	Tue, 18 Jun 2024 20:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k3W5N0fU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D420B8838E; Tue, 18 Jun 2024 20:57:53 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74B18824C
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d513eb6e56so531325b6e.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718737070; x=1719341870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbGPn7v3CcNBX2xttqbVe6gEDZNf3mSxegKMDIGNau0=;
 b=k3W5N0fUTWAm3jmRkmeCdYZzWLHYd6Dr+ZHareEr7Hjnl+wqhM4WbdqpUthhagCdCY
 7lYZg7Xm7sXtylmF/YBaK31/+52Xp7CkhL7YsofblYxbO2+prgudIpsLOAR+qT4cMxKx
 bKD1wqqznrCF4lBlyKstF1H8I+5dx6pFkPQT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737070; x=1719341870;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbGPn7v3CcNBX2xttqbVe6gEDZNf3mSxegKMDIGNau0=;
 b=AGt5H+Q217W8HlrPK+PNgRw2VSLnzzHh9YIOLFszbhtC6fS/UUEj0MFwV0VIC5IjQ4
 K5iX+Rp99h/i4eZmL604vHZki+Q9CkXURJrYO3PWapdJ/gkwk/pVjaknwnBLaUWXwALs
 m2lEDxmlwTIeRh+kfi9vJ3uTyzh8R4hEu6clRz4yUhxHoTlgziwCoLKOSsnC7BNb17ih
 4n+K7yHnfvLJhpHu16o8YgdZhWrIGZR/dItAHGh7jfOPfSbwHCpcqYZZYXf9aqhXBECs
 ixtAm7t/KM16JvnrR87auV49q97kC1VD9ppcSxW8/ULDkhqUDL1XCKyc1xOVx4pMR9cd
 J/UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAqqApbMnOVK4gi7+YPjlu0iGYlRI1RNXxxXg0x47WFXsB4/97K3SHWO/voe1lGCEKKbE9FSzzjB7fmXHm3XBfMDoeKw==
X-Gm-Message-State: AOJu0YypQBlSD2d32pu+ixH6SVAVxPjoJtQhqL5Yrf7R8t2amopUGyuR
 YT1zrK2FXhL02RE33lWrKBVzQmCNpBuU9VoBObKzLPWeaxrD7QquOxYp/RIdFS0=
X-Google-Smtp-Source: AGHT+IF3nSN6ztqWEnbC3cnjPcK++Z2QijL7m1T57fUyxc1qINoDI7mRT0+KBpylRf0QYVcd0RTr2A==
X-Received: by 2002:a05:6808:23c9:b0:3d2:1cfe:c2b3 with SMTP id
 5614622812f47-3d51b9957ffmr607563b6e.15.1718737070418; 
 Tue, 18 Jun 2024 11:57:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e31cbsm1875120b6e.50.2024.06.18.11.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 11:57:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.phytec.de, upstream@lists.phytec.de, u-boot@lists.denx.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: d.schultz@phytec.de, nmorrisson@phytec.com
In-Reply-To: <20240610133352.2473414-1-w.egorov@phytec.de>
References: <20240610133352.2473414-1-w.egorov@phytec.de>
Subject: Re: [PATCH 00/13] *** Various fixes & improvements for
 phycore-AM6* SoMs ***
Message-Id: <171873706946.3326390.2128092991598631936.b4-ty@konsulko.com>
Date: Tue, 18 Jun 2024 12:57:49 -0600
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

On Mon, 10 Jun 2024 15:33:39 +0200, Wadim Egorov wrote:

> This patch set is for u-boot/next.
> It includes various fixes and improvements for phyCORE-AM62x and
> phyCORE-AM64x SoMs. Notable is the last patch which prepares for use
> with future ECC memory fixups.
> 
> Nathan Morrisson (2):
>   arch: arm: dts: k3-am625-phyboard-lyra: Add fixed partitions
>   arch: arm: dts: k3-am642-phyboard-electra: Add fixed partitions
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


