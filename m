Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C816BC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 11:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42B8F88729;
	Wed,  7 Aug 2024 13:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723029426;
	bh=Hdh1GzXaXIbmoWLdK63ALVv0b642GtnNP+TuId+8DGE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Gnz1lpeD20X5ROKzw1/Ce6wiMaiHa3vX+EyqGJbCAd/ZT5/eJ5dbXTdOHpNvDf2FK
	 IiC5qtbLDY8bXSd1ttJCuRW2M1H/LACDSUMEb8TcMEvdJBlpxASATBPIzQMOfc4fD/
	 gcXO6/EbMst8jgcR4o8XLEfzqRSd1F+Tjmm0AeaQQAS23UOV2EwXwCZ5SZ8ziQXvFs
	 25S64Jl/zCxIncQHNWcfM7xogJzZAr0l4n+jdpnN3TC922qsVcwsgdIPsyYCqMUkpw
	 zGXUjAlyPMAOfgbWG+TuhV47cLwfHJZUfyzpE+0ofCQoXs8BC1SmFEUDbZMEwG7fvS
	 fpru84rWZtlyA==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9CBDF880F9;
 Wed,  7 Aug 2024 13:17:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723029424;
 bh=Hdh1GzXaXIbmoWLdK63ALVv0b642GtnNP+TuId+8DGE=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=vVWhuDxmvzFF7YDr0zlaBF5Z5/1qRKBNlqmTr0nYlg+8F96gyqdo95nnvoh51xyWY
 bf7SVXKMmZrDH5t/eegEOcZcnfGLKuYI23eOpR780tDygw6TjWEcjP3RyCJPc19u4P
 lGgXSFfCCFFE6653G9eVmNxaRNtPjbab5eE9mknqpEdFQR1aKB3knwbFCacW0UOUr9
 obyBNKBNARwB0kSJKSbCcstYQ3fDCN1vLQdBwsAlNndjAgJXxI4UnDMOniNL90hLRN
 g7FrGBd3Up9BdvoR5CE+8+8BY1eaNMtHFDVjXfnxnyAqjCEetxsm1Sce+dU/NL95fm
 I0taaMYUEJsEQ==
Message-ID: <ae4dea57-f8b8-b82d-2b31-aeab70b4158c@denx.de>
Date: Wed, 7 Aug 2024 13:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 10/11] board: cm_fx6: convert to DM_I2C
Content-Language: en-US
To: Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Cc: Nikita Kiryanov <nikita@compulab.co.il>, Fabio Estevam
 <festevam@denx.de>, Tom Rini <trini@konsulko.com>
References: <20240803161513.486062-1-agust@denx.de>
 <20240803161513.486062-10-agust@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240803161513.486062-10-agust@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Anatolij,

On 03.08.24 18:15, Anatolij Gustschin wrote:
> Conversion to DM_I2C is mandatory, enable DM_I2C to fix board
> removal warning. Convert EEPROM access to use DM_I2C API.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> Cc: Nikita Kiryanov <nikita@compulab.co.il>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   board/compulab/cm_fx6/cm_fx6.c |  3 ++-
>   board/compulab/common/Makefile |  2 +-
>   board/compulab/common/eeprom.c | 14 +++++---------
>   board/compulab/common/eeprom.h |  2 +-
>   configs/cm_fx6_defconfig       |  2 +-
>   5 files changed, 10 insertions(+), 13 deletions(-)

This patch breaks world build ... could you take a look?

https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=logs&j=08d7dacc-cd40-5df3-6db5-bb431d28637a&t=8da0c77f-a38d-54ad-3682-1c9d5ed6f8aa&l=1228

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
