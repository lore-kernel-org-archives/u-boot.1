Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F85C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B83B88667;
	Wed,  8 May 2024 14:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fVgeu37J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D728844B; Wed,  8 May 2024 14:19:46 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B5B88725
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 14:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1B6E1CE179B;
 Wed,  8 May 2024 12:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCE2C113CC;
 Wed,  8 May 2024 12:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715170781;
 bh=PsVy3VZwUBlxxV/odQpHdsSTnzboiVScJ0ChXU5bWfU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fVgeu37Jv9PxySKL1fr6UrKPyn8rgtnRoKd3y8OrA3VPPbPgZsZe6WMCvj/WQ/DS6
 5fToxcMLUVkx2zcj4kz18XX8Y7BUAJ1tF2a3EARkxZcdkv8E2ndKHXGMTrdVFgSHEB
 T/0gRmotXoNr8tRnRe2rIYr18AwSjkNZ5uwY9vHZNBNd1SB4ZaZAcqoQNAjhXJ8Pe2
 bB3hbasoMGM9ZB+QVwu0g4k0rM0TIWWHiApsQimQT8J/kRoWl/omapNMNt1ed/UkQe
 psfVQiV3xMZ2yYdl/g72r8PUcraolwwTM/13WgMxNci61CZO78i2N5dP6CW95VLFlZ
 2HexAdik0jbdA==
Message-ID: <116c8a45-66bd-4953-ba8e-638e2bf43de7@kernel.org>
Date: Wed, 8 May 2024 15:19:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: ti: pruss: Add support for AM64x
To: MD Danish Anwar <danishanwar@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 r-gunasekaran@ti.com
References: <20240430104633.1445311-1-danishanwar@ti.com>
 <20240430104633.1445311-3-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240430104633.1445311-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 30/04/2024 13:46, MD Danish Anwar wrote:
> Add support for AM64x by adding it's compatible in pruss driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
