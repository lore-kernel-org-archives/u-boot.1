Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB8EC3ABC3
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 20:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBEB8091A;
	Sun, 11 May 2025 22:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746996921;
	bh=2cndyaCMIandLTuwOsIY994J0fYZ04D4FFav6/jKyRo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xKw7R5fhO8m6pn5wvY1asWeds0QEsozVbCOL3dFz2thJFnhszbzFzSI/JKbcl7/kv
	 evWHzUw1UC0aFRSVPXRyaPMx9On6kxz0LkHvje7FuNBQRCGU7/aNyAy9Mo1MfgyAoy
	 ZHfuRs2wsVhrOETgzLg/Oc/gpLdveErElbHQpwRLb2wWaHJH3Dig+uPqujEA/A8EtC
	 kRBNJGQe7JA8DvhiDBKA+Bk02utaYa9TX39FSxWQosDnyUiOfbWw2q34S0c1Jrljdb
	 yH0sWuuuYBhtOW6TQGNHVGMtub+KNJuAQefYTprO0jfCO/AAL6M9v/i42NcPfaTAd4
	 e/AOmKqSTuW5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16B4180C83; Sun, 11 May 2025 22:55:21 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A13A805D7
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 22:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="QAnfeLMT"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6184E1048C2EC; 
 Sun, 11 May 2025 22:55:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746996917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2cndyaCMIandLTuwOsIY994J0fYZ04D4FFav6/jKyRo=;
 b=QAnfeLMT+ehZc1myBHVjT22QPy27MXEoodQzry6f3CSO7Bn1uhETVSADVRBYkp5EBMwuAB
 RTW/Ii6bEJSfWyvmBB5WmpNsqGNK1qcD57yy1eKJGuR7upvO7u/tA1SZgFPEHLNZRfHm1I
 9HRy07n6dAqlZ3k6dwPV1Gawz2ACHCg5CmlWnl+/590y1ZUHpOsk+53M5iuidyeY3JGq3u
 +tgtq5rciAHzuQy4cwwDKUS8ARr4rjB3w3W+wUDr8BackAS2iMR15nHYkRv2jctpZRfovC
 An4gj/tSnM+cDR5zbUI7pBJl9hcG6C8nK+1Y+MQMDAWtBnLm/yXa29iKnN1tzQ==
Message-ID: <6352a642-f8a3-4e40-932a-0d5a4be8e8d9@denx.de>
Date: Sun, 11 May 2025 22:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
To: Heiko Thiery <heiko.thiery@gmail.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Michael Walle <mwalle@kernel.org>,
 Thomas Schaefer <thomas.schaefer@kontron.com>
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250428095945.1432389-1-heiko.thiery@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/28/25 11:59 AM, Heiko Thiery wrote:
> From: Thomas Schaefer <thomas.schaefer@kontron.com>
> 
> With commit cc4e8af2c552, fsl_enetc register accessors have been split to
> handle different register offsets on different SoCs. However, for
> internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was fixed
> without adding the SoC specific MAC register offset.
> 
> As a result, the network support for the Kontron SMARC-sAL28 and
> probably other boards based on the LS1028A CPU is broken.
> 
> Add the SoC specific MAC register offset to calculation of imdio.priv to
> fix this.
> 
> Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
