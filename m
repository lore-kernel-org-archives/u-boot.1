Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B37E92FF9
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 09:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAF686D11;
	Fri,  6 Oct 2023 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jW/N16Yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EA586D19; Fri,  6 Oct 2023 11:14:39 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092CD86CE5
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 11:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8603CB827ED;
 Fri,  6 Oct 2023 09:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D34DC433C8;
 Fri,  6 Oct 2023 09:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696583675;
 bh=UhaEwMS0SgXZ1yBIMM1J8AvKtOeI/VDO4Eomn2Ql8wc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jW/N16YqLd1h+pMCaZk87eZKP/4xSEX8s+aj1f0Wc7FLL79OhWBbzslJQ40rChjvV
 bRDUWoIaudJhEErj4/hjxukOH8yTalimxyI+wXiCnPDX1+xMDQTDlGtx1uzFQAhqYn
 JtY6gQAYbsron6N4n1jKrKUdKiRFtBrAuM5TpOX7/mkCGS9NnibfGBoGhZ3FhaDIGT
 hyAMWbpfFanLvqiEL7il2GijJR8dgEc6INxfSZurowjPcTdOa3BniJXOpVvwR2rPbY
 pgO5blLfpwC2f0B14LNp+dLVYeURRoTo0JC7FwkPDzJgjwxUGUdt85fBxaFqnInF3k
 hq5KrKfgdxaAA==
Message-ID: <89ee30f9-67c9-4afb-a558-91ae1b0ed17c@kernel.org>
Date: Fri, 6 Oct 2023 12:14:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: k3-j721e-sk/common-proc-board: Fix boot
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, trini@konsulko.com
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Neha Francis <n-francis@ti.com>
References: <20231005181514.4054241-1-nm@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231005181514.4054241-1-nm@ti.com>
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



On 05/10/2023 21:15, Nishanth Menon wrote:
> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node
> as pre-reloc after relocation") A53 u-boot proper is broken. This is
> because nodes marked as 'bootph-pre-ram' are not available at u-boot
> proper before relocation.
> 
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
> 
> Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
> Cc: Neha Francis <n-francis@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
