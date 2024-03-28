Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C50CC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FD36880D5;
	Thu, 28 Mar 2024 10:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711618837;
	bh=LsgZlIaP42m1QyYX7v5ce4vTiKtjVopO9+nO28pwfho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LqbFtFXom4kM2D85zdyIL1VojqaSgO7zVyGsgxQ/Q3zUIOUm9hGpMJ9bQC6GGqpZ2
	 AXqOoIn1B9lfZ6r6zfqzhB7qjHg49zFs3VM5knZmwTcmxC5ZaNxNDdIlSY9c6jP/D8
	 WOt8b2NMl6DLaqXoDP12ekXWSQSPf3a4upbqcKxJqMeKBhLHkarUjgqX1Bh229k4If
	 Iamqmsou5pTAXSG2ZD0a3a25cIPyfld1K/r6rxSVkvWCLl2IcfJPv8ExC0yoNTfWE4
	 Au8vFffkc5CUf4QsGkD2ghdOtC71N0AbLQLnjz4mTR4uS0+sVs2+xV3Kap2jp/U0zH
	 bXFaAmvplyofw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 36CCC880DE;
 Thu, 28 Mar 2024 10:40:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711618835;
 bh=LsgZlIaP42m1QyYX7v5ce4vTiKtjVopO9+nO28pwfho=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cLIOskxtlyb2foZE46JFqjlXjPFPrfpuXnQJcJx1tfSLFrp4xJfP5ymrl8eL5iU+B
 D9CZoHhFIB6R854OkwmaRIMIdA5VB9aJxpvIBT6BAxjieaOGNr7si4nT1bDFzzhsfW
 9nmciZOuFxfSdqHAtLGIGidhqpyAdcJyJPZ4N80Iosp0GN1b4a/AFUx01t3zHsnjRW
 kIMC/t1XtLOyWcsC+hwUzpckiDCfWmbjJN0jM4fJH7YRH5WU0pTmk2MfPN/micepwT
 2HvH7XsYutPvsPXbzrBcExINViFrD+Vu9uVfZVVkKTUP3nEqtPSHY27ZnI7idcACMj
 TR37BVJN2LDkA==
Message-ID: <343af186-17b5-4945-ac76-9bd4527f1da7@denx.de>
Date: Thu, 28 Mar 2024 10:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thoughts about U-boot binary size increase
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>
References: <20240328102049.10108d5b@wsk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240328102049.10108d5b@wsk>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/28/24 10:20 AM, Lukasz Majewski wrote:
> Dear Community,
> 
> I'd like to share with you some thoughts about growth of u-boot's
> binary size for SPL and u-boot proper.
> 
> Board: XEA
> SoC  : imx287 (still in active production)
> Problem: SPL size constrained to ~55 KiB (This cannot be exceeded).
> 	 Board design constraints u-boot proper size to less than ~448
> 	 KiB
> 
> 
> When XEA was added (2019.07):
> 	- u-boot.sb (SPL): 37 KiB
> 	- u-boot.img 	 : 401 KiB
> 
> Now (2024.04):
> 	- u-boot.sb (SPL): 40 KiB

Do you know which symbol(s) grew in here ?

> 	- u-boot.img 	 : 427 KiB
> 
> (With a _lot_ of effort put to reduce the size)
> 
> Hence, the question - would it be possible to take more concern about
> the binary size growth?
> 
> Maybe CI could catch patches, which enable by default some features and
> the size is unintentionally increased?

Try and set CONFIG_BOARD_SIZE_LIMIT and CONFIG_SPL_SIZE_LIMIT for this 
board, that would trip build error if the size grows too large.
