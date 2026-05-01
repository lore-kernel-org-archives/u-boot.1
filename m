Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1113FFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F69F84099;
	Fri,  1 May 2026 09:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YipGYfXn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD2E841D7; Fri,  1 May 2026 09:01:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A833F80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ehristev@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 652AB60142;
 Fri,  1 May 2026 07:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB27C2BCB7;
 Fri,  1 May 2026 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777618860;
 bh=iDgBba0gNtNrcYS/X2hkfuXvzKNQYNsiYd5fVlYH5qU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YipGYfXnKWw3jXtwrb73/09bIgNjlso1M2mGHuQHWyzO/kUftjKqf6W+NZkhwatA/
 uwUby6l09kokMW4seMYas0XPE1TtTAYFDcbKk23Nk/+sOjUKLdGOLmMOIkIvJYTZ61
 zLeE8DCf6Vu7l5UvbDGPnCD5WVmdhbB20tEVzgQ2dctWP19W3MXrm2zk2RSbxBFrCe
 oxztQHj9DaLZmjldB7p40LQSqmXoDx3qJHM2aDHrtss8PsaTXOWB4rteuNw/n1dNc1
 1/KLe4uxPJn9tJiN5Ejqj8uuSmv5uLCx8nIfjEKPequxuq5ua/WX38TOiRXNF0dY6e
 PkxeEFs2QJzeg==
From: Eugen Hristev <ehristev@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
 Stelian Pop <stelian@popies.net>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Sandeep Sheriker M <sandeep.sheriker@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Ilko Iliev <iliev@ronetix.at>
In-Reply-To: <20260325190024.3428545-1-trini@konsulko.com>
References: <20260325190024.3428545-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: at91: Drop unnecessary BOARD_EARLY_INIT_F usage
Message-Id: <177761885759.359357.6960351969788230912.b4-ty@b4>
Date: Fri, 01 May 2026 10:00:57 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Wed, 25 Mar 2026 13:00:24 -0600, Tom Rini wrote:
> All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function.

Applied, thanks!

[1/1] arm: at91: Drop unnecessary BOARD_EARLY_INIT_F usage
      commit: 301bad079b15bdcdae1dc7c3f4f7b30cff15ba84

Best regards,
-- 
Eugen Hristev <ehristev@kernel.org>

