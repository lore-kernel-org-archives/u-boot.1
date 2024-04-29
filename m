Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4D3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 14:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5188847E;
	Mon, 29 Apr 2024 16:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RdW7g26u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A94E88268; Mon, 29 Apr 2024 16:17:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E2FF880F4
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 06F7E60DCB;
 Mon, 29 Apr 2024 14:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC9C113CD;
 Mon, 29 Apr 2024 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714400266;
 bh=wA2XCV0DHMONqSC+OYibilk67S0mT56npc2g1omhIyc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RdW7g26uX6B2eRjEbzMIeWAnOyp5W41Z54vMFJofx7P64LEEPzkcRSO//sywO7VNP
 Eeis6UoSCYJXqwFPKAMWDktF6+npOpAjlXleBsV/A1QccACSr4s3fsRK9gOCfSkdZU
 Qt0EWUTdoUXh0/zXarA6sXwNsqt6Uv9uoylHmX7mHpJ1gVLJDW5yyiD3s27jg/oD4p
 yQWFZS0ff9bSrzrphW8PawzOcHR7RMlqekqmk0gQ4ctQJleRGBpw0uDC8K3wkWHVJQ
 XYhIWBKlryvgDFbDkpzm2ptSJHugA8fl6WhzOD3VAveQqJnJWAxhM55yTCp5e3w5k0
 V9vhPLWSCJ5Mg==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  d-gole@ti.com,  pratyush@kernel.org,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 1/6] mtd: ubi: Do not zero out EC and VID on ECC-ed
 NOR flashes
In-Reply-To: <b92b89d130f8075cebf74bc02eb6efe41afc6d75.1714020303.git.Takahiro.Kuwano@infineon.com>
 (tkuw's message of "Thu, 25 Apr 2024 13:52:11 +0900")
References: <cover.1714020303.git.Takahiro.Kuwano@infineon.com>
 <b92b89d130f8075cebf74bc02eb6efe41afc6d75.1714020303.git.Takahiro.Kuwano@infineon.com>
Date: Mon, 29 Apr 2024 16:17:44 +0200
Message-ID: <mafs0v840b6d3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 29 Apr 2024 16:32:37 +0200
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

On Thu, Apr 25 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

I wonder how authorship should work for such patches. Patches 1, 2, and
6 in this series are very close to what my patches did for Linux. So I
wonder who should get authorship in this case: the person porting the
patch or the person who wrote the original one. Same for patch 5 but
that is still a little more changed from its Linux counterpart.

>
> For NOR flashes EC and VID are zeroed out before an erase is issued to
> make sure UBI does not mistakenly treat the PEB as used and associate it
> with an LEB.
>
> But on some flashes, like the Infineon Semper NOR flash family,
> multi-pass page programming is not allowed on the default ECC scheme.
> This means zeroing out these magic numbers will result in the flash
> throwing a page programming error.
>
> Do not zero out EC and VID for such flashes. A writesize > 1 is an
> indication of an ECC-ed flash.
>
> This patch replicates the following upstream linux commit:
> f669e74be820 ("ubi: Do not zero out EC and VID on ECC-ed NOR flashes")
>
> Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Apart from my comment above,

Acked-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
