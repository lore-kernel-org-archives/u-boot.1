Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA55CA0ED3
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 01:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188A087FCD;
	Tue,  3 Sep 2024 03:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IuKZDCCO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB86788327; Mon,  2 Sep 2024 17:39:02 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB9E88BEF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 17:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A94C2A42705;
 Mon,  2 Sep 2024 15:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4023CC4CEC2;
 Mon,  2 Sep 2024 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725291539;
 bh=NGhFJDHhNOe0x1iMzXGJOfEXK5l91bngGo9k6AbEx1Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=IuKZDCCOQq5mFgbl9LC39ZTFul6HyDhBpeCpODc8cSnuQAj/TGFwnMkFxIEaED3Zr
 ipVscjd1UP+W9+trcTiRjzmItbVq3IJP5LvwZQR1gsp6OMIR2jtqTq25lbK/nD9VQm
 gl7BRcVSE1BqeSJdnTvM3qK8EVG6U3ZvV6yaNAagQJH2yK9aE2cSSZvttG1wSfFKNi
 UwyoCxIUoibkVjQ7R9Exc8TN7W6lY54qdtnxUaAf24C944ugnKCgJcW1RpYiB1iKCX
 AdU3XD4AsWIg64TijYuhpE9zDgwwL7TMDDcfqwXLsk6yzgSlX4RipWMzo/Gp4rxgBr
 zqWUGDl5orvng==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  pratyush@kernel.org,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spi-nor-ids: Add support for S28HS256T
In-Reply-To: <20240830050012.28870-1-Takahiro.Kuwano@infineon.com> (tkuw's
 message of "Fri, 30 Aug 2024 14:00:12 +0900")
References: <20240830050012.28870-1-Takahiro.Kuwano@infineon.com>
Date: Mon, 02 Sep 2024 17:38:57 +0200
Message-ID: <mafs0bk16xdym.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 03 Sep 2024 03:27:18 +0200
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

On Fri, Aug 30 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> Infineon S28HS256T is 256Mb Octal SPI device which has same
> functionalities with 512Mb and 1Gb parts.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
