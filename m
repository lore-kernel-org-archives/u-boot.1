Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E38CE8D67
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D0F8910C;
	Thu, 19 Sep 2024 11:51:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R+WLWI9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833B08910C; Thu, 19 Sep 2024 11:51:39 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8189588B64
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 620D1A43BE9;
 Thu, 19 Sep 2024 09:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934B4C4CECD;
 Thu, 19 Sep 2024 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726739496;
 bh=LLo/FX/Rhqjt71BHA5B1wGbtjoT4QFspEwvgoLTzbYE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=R+WLWI9Gi/fO7Kl5iKkVLwqxo0k/XZqsIRxwV3MANTHroGtXUZmCcyzhs75Owi1pQ
 5XQgmD7neKZU4938nblhq2ZQlgBU8T+15OyRriKTuPXEa7VG79i8zS7NkT2ILw1UkT
 it2fR9CO/snHWPyTRCiOtVcBBiQn8sGSyIKI2HSKUt29VOx2dw+5BKzYRZrOfdrrnE
 ojkuiUYXY61+cl3CJ4Fp+mKlRvtGzqo7pdMJrnOnqU1jT00I7FGCbzyTuvF6mynAs5
 p7NZ2uAMyzseuff9orvG8hKsvomXlblZdL1t3FBPQArfRmLrs2E0kyykhTsDBN9Svv
 MzHO7hmAnmutA==
Message-ID: <69c1c731-4789-43af-ae62-042a571061da@kernel.org>
Date: Thu, 19 Sep 2024 12:51:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mux: mmio: support "reg-mux" compatible
To: Tom Rini <trini@konsulko.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240918-j721e-ums-v1-0-62f295dce6aa@kernel.org>
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



On 18/09/2024 16:49, Roger Quadros wrote:
> TI upstream has moved from "mmio-mux" to "reg-mux" that doesn't
> require the Mux device node's parent to be a syscon type.
> 
> Add support for "reg-mux" compatible.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

This fixes USB on J721e after moving to OF_UPSTREAM.
It should also fix issues on other platforms that are using reg-mux.

Maybe it could be pulled in the -rc cycle?

> ---
> Roger Quadros (2):
>       mux: mmio: Support "reg-mux" compatible
>       phy: cadence: sierra: Don't spam console
> 
>  drivers/mux/mmio.c                       | 7 ++++++-
>  drivers/phy/cadence/phy-cadence-sierra.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> ---
> base-commit: 9eb0d731d800b4fbc8e9ed0178fec0d6f201d911
> change-id: 20240913-j721e-ums-e37635f7c604
> 
> Best regards,

-- 
cheers,
-roger
