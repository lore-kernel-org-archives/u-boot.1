Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD29E75436
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 09:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03CD286BEC;
	Tue,  3 Oct 2023 11:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fa57UsH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAD586D56; Tue,  3 Oct 2023 11:08:00 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7577786B18
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 11:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C23A3CE14E4;
 Tue,  3 Oct 2023 09:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DAAC433C7;
 Tue,  3 Oct 2023 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696324075;
 bh=CKfzy+CoZgV3851VGgG5XQfKcT5IurBdNO5GZAaZBvA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fa57UsH8Jc7sVho6p7Ndpa2WTGgFCsZSZDcxP5nbcyDZIM+FcvV55uI5ZrCxEJWp2
 ZtS5F0Xhvv1lVfDSGyiBQpX48iOy+8xZ1PcLxV7f2FU396lB0tMYzq3uN/O/PuK2xJ
 ysHwbnXtjPliPjcdotEU7nofbq/NIzrBr51ir2xjLMvBvhMbss+E4OYm3lQDGJ4QmB
 HHgF8jJ43gKtxjOhHfrOu1wSgS350DvhAaXYYxw+q34kYyqrjIClSF9Etx8Xbr+waC
 2LKDi4BgIYBsE+eFHKB/tyrjQIVKmFFH4K1UJtEgJVNz0RJ0cwKc4mPDZoAlho0K9E
 DtLFHUD9W8l3w==
Message-ID: <b1c62a7d-a90e-4212-8972-9b622e147975@kernel.org>
Date: Tue, 3 Oct 2023 12:07:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-am625-beagleplay: Fix Boot
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, trini@konsulko.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Robert Nelson <robertcnelson@gmail.com>
References: <20231002150053.2930710-1-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231002150053.2930710-1-nm@ti.com>
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



On 02/10/2023 18:00, Nishanth Menon wrote:
> Since commit [1] A53 u-boot proper is broken. This is because nodes
> marked as 'bootph-pre-ram' are not available at u-boot proper before
> relocation.
> 
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
> 
> [1]
> 9e644284ab812 ("dm: core: Report bootph-pre-ram/sram node as pre-reloc after relocation")
> 
> Reported-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

> ---
> 
> Based on Roger's series:
> https://lore.kernel.org/all/20230929134646.214781-1-rogerq@kernel.org/
> 
> Based on:
>   next                       e29b932aa07f Merge branch '2023-09-30-Kconfig-updates' into next
> 
> See discussion thread:
> https://lore.kernel.org/all/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/
> 

-- 
cheers,
-roger
