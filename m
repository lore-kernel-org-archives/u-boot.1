Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C125C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 23:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD84B8818C;
	Sun, 21 Apr 2024 01:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713654785;
	bh=460p05lnPOCUvqT1K1coWnn5jQ+Tx+rzWiwIB4Ns3/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gkMXsGh8U5ueVVQzGvVec/iZMK4Tg9K0gysW/8xiJP+xNYJcDD6UiXJmIxXgM9Q76
	 VY9abuKlfCcBygJ9fZkvOIvLsDomw1WaARpAzGzSCnL/lCcxC2p7/flXlrFXJzjPeX
	 tEilpY05DGonXa2V24XFcFQUIz8h6WoAeTN4ZoRr6V7RFWhdx/sG8EVlSnfyT8aifY
	 y2aNjrwlSZv8trrwXZBAvDZhmKH5NUbA5e5d3AHwBL65McfXgj4ulltRwnbr05MJP6
	 jJ2Rib0Dkbij+5T0E8rNEjCatn+67jSO5S8DwXzvfbgZj3enq13wkg9NelkrnnqR4I
	 GBhcNN9/hzQdA==
Received: from crub (p508b6ab0.dip0.t-ipconnect.de [80.139.106.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: agust@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E629B88003;
 Sun, 21 Apr 2024 01:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713654784;
 bh=460p05lnPOCUvqT1K1coWnn5jQ+Tx+rzWiwIB4Ns3/g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fT2qsrhQ6Z3s9fsxF1tLFhiP6XKv//iBcdV9tWZwbzOEyDDePhzMvYHaC+QHMwOG2
 BlzRE7CEztyyKAL6oDWrKPnZtGwaJCm1FDN0JT7bwALkk516PND9rQ8BsuMyuGiRBG
 YyHOVwDW8689r3ysLTsoU4QHq8HDsMl8X9RZteJ6vMEKmYnGqt8qF9UOlKl6EOxa84
 qsokEb5Ay2mIebq8xT5caeIzH4FnI98uL/kxu6vzY/6jifCdyBGjBefKqyPYUatJTN
 RqeuiUIAdbpFWoG0eV8SmUIuePjXlXR9uuMTmMpQSSUI7Yb2yryys67LqisRi4r2Na
 iGIuMup2FIOYw==
Date: Sun, 21 Apr 2024 01:12:43 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rob Clark <robdclark@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] video: simplefb: modernise DT parsing
Message-ID: <20240421011243.4ea466fd@crub>
In-Reply-To: <20240216183840.879482-1-caleb.connolly@linaro.org>
References: <20240216183840.879482-1-caleb.connolly@linaro.org>
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

On Fri, 16 Feb 2024 18:38:06 +0000
Caleb Connolly caleb.connolly@linaro.org wrote:

> simplefb was using old style FDT parsing which doesn't behave well in
> combination with livetree. Update it to use ofnode instead and add a
> missing null check for the "format" property.
> 
> Standardise the error logging while we're here.
> 
> Fixes: 971d7e64245d ("video: simplefb")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/video/simplefb.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

applied to u-boot-video.

--
Anatolij
