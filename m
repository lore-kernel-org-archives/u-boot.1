Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E865C67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88A8887E13;
	Tue,  9 Apr 2024 14:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pc5dTsYq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2A387BF4; Tue,  9 Apr 2024 12:03:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D1B6879A0
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 12:03:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pratyush@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 46D27613E9;
 Tue,  9 Apr 2024 10:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD52C433C7;
 Tue,  9 Apr 2024 10:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712656994;
 bh=IeE+m8lIHCxDq0ZGZLiUWKDSSmCINwj3/GXHWyeFzEs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Pc5dTsYqVYlrc19ZSKKqZfSbSRxj2F4xSSR/bN2ZO5qWNYYDP6YtjgyvRxqFU+3bU
 WwM4ypdQFD85LHKqL4aOOSqJTvMWdPfSJ43m63bIVYBCU6YV8vbg67LaryxPlxJwuk
 yR3JiB36WEucsOoWj3D6hkv4rpZfCHEzJyElijamEVAsv6Tes/UCueDW1dJrXsSu2f
 bBpNEB+UqmpmNJw8W7RNoCEp+l29BPmh4wYO9IawO/Vid9vEm14cN+bYxPJTehzq2C
 /P2R/PVHEyamxp/IHj/3tCPrDvSA/bTckyTm+M7Xgvlt651EL3NlQzzb4/rwLjL9CW
 ije1XYCTuAUWQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de,  jagan@amarulasolutions.com,  vigneshr@ti.com,
 tudor.ambarus@linaro.org,  pratyush@kernel.org,  d-gole@ti.com,
 Bacem.Daassi@infineon.com,  Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor-id: Use INFO6 macro for S25FL-S
In-Reply-To: <a988761256bdfd8a55a009d127b8b44b3f9aac92.1712638210.git.Takahiro.Kuwano@infineon.com>
 (tkuw's message of "Tue, 9 Apr 2024 15:20:21 +0900")
References: <cover.1712638210.git.Takahiro.Kuwano@infineon.com>
 <a988761256bdfd8a55a009d127b8b44b3f9aac92.1712638210.git.Takahiro.Kuwano@infineon.com>
Date: Tue, 09 Apr 2024 12:03:12 +0200
Message-ID: <mafs0il0q97kv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 09 Apr 2024 14:57:26 +0200
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

On Tue, Apr 09 2024, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> The 6th ID byte is needed to distiguish S25FL-S and S25FS-S families.
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
