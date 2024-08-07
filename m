Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488B3C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 13:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B546888714;
	Wed,  7 Aug 2024 15:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723036323;
	bh=RSBC/abdPefxHUlxd+K4GtxyOk9Ws5rGD5KU8/cjYdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tH1Y0149CBMEuy3l8mWSVsyuOZixJzl7kI9M3s3uPmKO0PC1I4DXkzSPw8ehnxpyD
	 x6EGVEshHXg1yBRz+61PB/RNFLTHhXjruYPIIa8jDYwOs1/rFofHwWZGBvl1R+Aahd
	 qKNLivWcqFJrx+ue0UCkngjWdAtVlNwOVKZy5kX7ozRVw0p4Ly49FPapWgI7MFsgeH
	 aKgGoHmAmZWFr/EidebB9oR61ganyVvIV/L3XZK6DTViO5DUb7rfmeqr9mc8M40acy
	 K8OxPsHyL+A23Lga//GHJvuZ+E5PxBqBRBTPLqsqFos58jORdUcUd7cNnvvQFDcLbY
	 4+XOz6znTtAEA==
Received: from crub (p508b6395.dip0.t-ipconnect.de [80.139.99.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 92D6787C86;
 Wed,  7 Aug 2024 15:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723036322;
 bh=RSBC/abdPefxHUlxd+K4GtxyOk9Ws5rGD5KU8/cjYdE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ax5AW8bAykCBilyS/zPxGC/hKcr9aA/er/w/kSVqRnhFc2xynYwg/+vW/TxXyXGr7
 qfk21XAujnRnIKtqMF8Osih9xKOrImt8CQh8xq6CazPXdgw/AJa5azz6uCnVy3aQYI
 84uLKKeKsmkXP5QBFRrIsmFa5c+pITJyDNWt9RkB1V3sTh9OgItoLIa6a8/i8m0R0B
 WGRWMitPSOf6Esr/OtXHC5Yca6Wj62QIGtnFaVs8vAhhzXmAuf9Z6vE9km2xgcGod5
 nsOeP7pfVoFiXl1QLdKP2GIf3IG7lJEduSAhlYpzM3LS/RSYyjrC9hru2CsONQLs61
 jHz08BO8j91+Q==
Date: Wed, 7 Aug 2024 15:11:58 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Cc: u-boot@lists.denx.de, Nikita Kiryanov <nikita@compulab.co.il>, Fabio
 Estevam <festevam@denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 10/11] board: cm_fx6: convert to DM_I2C
Message-ID: <20240807151158.1d392095@crub>
In-Reply-To: <ae4dea57-f8b8-b82d-2b31-aeab70b4158c@denx.de>
References: <20240803161513.486062-1-agust@denx.de>
 <20240803161513.486062-10-agust@denx.de>
 <ae4dea57-f8b8-b82d-2b31-aeab70b4158c@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hello Heiko,

On Wed, 7 Aug 2024 13:16:21 +0200
Heiko Schocher hs@denx.de wrote:

> Hello Anatolij,
> 
> On 03.08.24 18:15, Anatolij Gustschin wrote:
> > Conversion to DM_I2C is mandatory, enable DM_I2C to fix board
> > removal warning. Convert EEPROM access to use DM_I2C API.
> > 
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > ---
> > Cc: Nikita Kiryanov <nikita@compulab.co.il>
> > Cc: Fabio Estevam <festevam@denx.de>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> >   board/compulab/cm_fx6/cm_fx6.c |  3 ++-
> >   board/compulab/common/Makefile |  2 +-
> >   board/compulab/common/eeprom.c | 14 +++++---------
> >   board/compulab/common/eeprom.h |  2 +-
> >   configs/cm_fx6_defconfig       |  2 +-
> >   5 files changed, 10 insertions(+), 13 deletions(-)  
> 
> This patch breaks world build ... could you take a look?
> 
> https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=logs&j=08d7dacc-cd40-5df3-6db5-bb431d28637a&t=8da0c77f-a38d-54ad-3682-1c9d5ed6f8aa&l=1228

I've sent a v2 patch to fix this. Thanks!

--
Anatolij
