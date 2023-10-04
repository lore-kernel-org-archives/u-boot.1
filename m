Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD50E7B5E1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 10:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0551B874CC;
	Wed,  4 Oct 2023 12:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/Hs4w9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72325874A5; Wed,  4 Oct 2023 12:01:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F146874A5
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 12:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2FF56614A5;
 Wed,  4 Oct 2023 10:01:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A78AC433C8;
 Wed,  4 Oct 2023 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696413708;
 bh=Q0BF6o3IUMxTDTjaDeyNr+UunsCrIHjZbctpAxrMVkI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I/Hs4w9+PoxcP/I3xnjbnH7dctpoOFyfj9rUPl4NbYyzMb6BQ2wm82MVras8LbH3y
 UJhzQ06uVub6VTv7L1k5xZQ1scE0SMhGEAPcr3iUyMcZaFuPXgH0re9Qq2wM9pDJaW
 jqL7h0eXvOClx4j6GqoXZ3yHEjihi316ZSoPM814R4kFNnEQh0Am6JU1jY/oMI0Fdg
 3DS2D0dvLFJaKVlKKqcFjb0qznJDudw4ttWuKkE4p8coFetW6HUi7metbHBBEWT9Rb
 JRPDl2BEJR3E222+uRQSQjB9PJ/hzsoOe3hkloiUSWm47l5RDoqIn2J2acUPhpKVrP
 2vzWqEl4CS0SQ==
Message-ID: <f6c748d7-f091-4198-b603-ef9a83251b65@kernel.org>
Date: Wed, 4 Oct 2023 13:01:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix boot
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, trini@konsulko.com, nm@ti.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
References: <20230929134646.214781-1-rogerq@kernel.org>
 <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c430c549-6c6d-4d32-a51b-e2bfa597bd4a@siemens.com>
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

Hi Jan,

On 03/10/2023 23:26, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
> 
> To fix this we mark all nodes as 'bootph-all'.
> 
> [1] 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Nishanth already send a fix earlier
https://lore.kernel.org/all/20231002150053.2930710-1-nm@ti.com/

> ---
> 
> This may overshoot, but at least the board boots again. Could it be that 
> [1] broke even more boards?
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 70 ++++++++++----------
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 12 ++--
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 

-- 
cheers,
-roger
