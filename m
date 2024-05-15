Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16523C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 15:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7DB8824C;
	Wed, 15 May 2024 17:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715787293;
	bh=qpDDMZnH4oh16JFkL5vC8XgjNaFyOtdyPIqtGSul/2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wtctoNMfh0VD6spOf8tkq38SqXBMfpQ48E+aXdSoLervyPLNB9qIZ3fwfXRF/c4CD
	 xnuQr5vVwpl+Vbs+m8nPqI9tpFracEay4+j6vch9ng8qk5dODtjUue/TAoI5FSCWhO
	 kw0hasfnbcYpTyPjC6x2Q0IP+sBh/iUwTV9M50rwpJRUw/WIIGb+72CRqGvRLdDN1S
	 4CzXLdcIpsoMpJ2N390Bf7eBMJ1r3W1V3RQ8XS11ei5kFntqn1bwQsshqypdiJ8rIw
	 OZVfpF9/7qbE319V7nBqQV2MkqUa02MynK2UjCjAVSIqAUOW6yEG/V5lMuD2HYUlYe
	 Ii+6Gq+yukrpQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 827AB8826C;
 Wed, 15 May 2024 17:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715787291;
 bh=qpDDMZnH4oh16JFkL5vC8XgjNaFyOtdyPIqtGSul/2U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z1JM2eE0Er10itepZxwytSeH4lmJlWwYzfvoXRxzOMHP6J2E4JXXfGn4zNSculB3B
 N0LNRK94cLSu1M+ri0xV1uX2zq54yuXoRojrlZgd8gQeof2vhFGXFygb/rfbaIyX6d
 9p3el+DfGUISrmjSkwFLf83cumWGixPIxkIPZZ1ohNr8hVb1O2we2fKSG2SAkQeV27
 GtW8folVsllhleExA5cqGothnC/CbbdspPagNCFf8hAn0g7JNjx5HhU2YxKMiQxrVl
 jVkxkQEZgiimZb7w6spDy4DQPWBRvZFWRZjv2iDQIRkCPvYXN4iMy6ItTBjq8HXIvl
 0/uL7H8wHos3g==
Message-ID: <515848c8-65e3-41de-8a2c-af1c9e5351f1@denx.de>
Date: Wed, 15 May 2024 16:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
To: Michael Walle <michael@walle.cc>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org
References: <20240304161607.82759-1-marex@denx.de>
 <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
 <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
 <CZLTVKVR3AG1.BZIQQU2PYSU6@walle.cc>
 <a28b0543-67ee-4e33-91c1-86ae36eb44d5@denx.de>
 <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
 <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
 <CZLZ391C9O5F.38A18T9S51BNT@walle.cc>
 <d522ac8e-8664-4798-9069-947691c6cd43@denx.de>
 <CZM55T7YDKCR.3AIA4OQT2VG0S@walle.cc>
 <ba2831d1-9ba1-4cd3-89c5-f4b9e8a4b94f@denx.de>
 <CZMOLX07WDHJ.36M7NNZK94F99@walle.cc>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CZMOLX07WDHJ.36M7NNZK94F99@walle.cc>
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

On 3/6/24 1:55 PM, Michael Walle wrote:
> Hi,
> 
> On Wed Mar 6, 2024 at 3:56 AM CET, Marek Vasut wrote:
>>> I'd argue if one wants to use the locking at all, you have to set
>>> UNLOCK_ALL=n. Otherwise, the bootloader might come alone and just
>>> clear your locking bits again. Clearing the WPS bit there is just
>>> one more thing which IMHO doesn't make much sense.
>>
>> On the other hand, if UNLOCK_ALL=y is supposed to work and reset
>> locking, then the SR3 WPS bit has to be configured to select the
>> standard SPI NOR locking scheme, so the locking can actually be reset
>> using that scheme.
> 
> Yes, that's what I've meant with "the unlock all works as
> advertised" and your patch is fine.

Can this be applied ?
