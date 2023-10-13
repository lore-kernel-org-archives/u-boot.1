Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E952BCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 11:21:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6DA86D62;
	Fri, 13 Oct 2023 13:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697196116;
	bh=Gyyw3bAHanhvUp4QJSg1EHS5a9WNGZr6AoZ9g7x1B0Q=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=IfJTX79cddGR//+OObP1f+KFyosx2yQEj7iNJ65Im5bIrWxRazemRt4PV1m2lisBu
	 IS98xRqzWHr85ren0QKIuwPd/jFr1yPZVwEV3y7ivovtZHPCTyceXmCYbssn101kLt
	 VV52KrqjE/nH9imlendWyVsx+jX3pIzajrWF+sp4AuC+/uyGW4zjO3DhQHy18M4Wev
	 wTmBZ1WN7fPl53G3UE1+j1q9fcMv8CLwfQCmfyFTqrP0qUmfpSpkAqmR8APfUthKis
	 P0KwuNDUlxZpL+3qjDHCCNCrIDKzloBBI/gB2MPFxYPfiYKqQyznaS/H0uROl69H6j
	 M/cVuszHmRPzQ==
Received: from [192.168.1.107] (91-82-26-209.pool.digikabel.hu [91.82.26.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6D4E986D62;
 Fri, 13 Oct 2023 13:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697196114;
 bh=Gyyw3bAHanhvUp4QJSg1EHS5a9WNGZr6AoZ9g7x1B0Q=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=IZEPs/uNqGg+xi2RY9n9U4h0+JVt9loA0je2sTzJUj3P9CCHqSxWjXPDYZS6D64Nj
 ShQiiepN+QKfaZZh6yqeLlARW4twGysA7b7OZ/FDoGWMH+rNllAugv6QAZZmlN6eir
 g5M/Cg79V2cqCTN3iWiHkwJgRtVttcwf66kdvLaSAg1TvzQMJmcaorhYefdW5J162e
 YchbDJJuBPYeuwZ3Ef61R1TW6o2gOVXW5xAvg2b6rsSh+0Mw8CvadPOOFhuGC4NGrj
 wb6AcIFi6uhpm+VeHrnSlLzWZCasWPci6HneargH2ZlxSvrYWxqEmEvT1nY6Utdj67
 IhXQ7xDvHMCDg==
Subject: Re: [PATCH 1/2] bootcount: Remove legacy I2C driver
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-2-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <bf6e57d4-2dd7-5515-6ba0-c7e49447a579@denx.de>
Date: Fri, 13 Oct 2023 13:21:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231013094302.28944-2-pro@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Philip,

On 13.10.23 11:43, Philip Richard Oberfichtner wrote:
> The legacy I2C bootcounter will hereby be removed and eventually
> be replaced by a driver model implementation in the follow-up commit.
> 
> The legacy driver has the following drawbacks:
> 	- It's not adhering to the driver model
> 	- Settings are grabbed from Kconfig rather than device tree
> 	- i2c_{read,write} are being used instead of dm_i2c_{read,write}
> 
> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
> ---
>  drivers/bootcount/Kconfig         | 24 +++--------------
>  drivers/bootcount/Makefile        |  1 -
>  drivers/bootcount/bootcount_i2c.c | 43 -------------------------------
>  3 files changed, 3 insertions(+), 65 deletions(-)
>  delete mode 100644 drivers/bootcount/bootcount_i2c.c

Hmm.. I find some boards in mainline which still use this driver:

u-boot  [master] $ grep -lr BOOTCOUNT_I2C .
./configs/sandbox_defconfig
./configs/mx53ppd_defconfig
./configs/ge_bx50v3_defconfig
[...]

So your remove patch will break them ... okay sandbox should be
easy to convert to your DM approach patch from this series.

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
