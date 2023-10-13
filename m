Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6188DCDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 14:06:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B162786EA3;
	Fri, 13 Oct 2023 16:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697205958;
	bh=4EMQv5oSMt4ylcU0eR+ZeaHAQR2lZn8x7sP5s7KuGTc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=lE3WyGDeFVCp707ZTXgqDmp4h/W6AuIoO+Ks/PS17PhsE2mhP2FoXEzOm1KKYkub2
	 eep/PNfA5xSWGzqxLWg6F/n7xWrEEhbCGqHPTf7GEx7qWOO8/9gv3FXsWHlWpRb8yo
	 AIkKn89+25EJrxSlLnUD7uO8APlXcvyFJIw1z+jo9xwdBVgHD/p0r5Ubg2anXgoAMF
	 s0QLcel7BCnx1qRAcIg4qFF4ub6zxoWrNb/DvBQFRlzgQxtD5UeU3STytW9tM0uJ0R
	 sYJVA+/fiW/ycvQLYR58IbpT7FhCY46XFAuR+pEghAtvzOAtXNmn8UXky+nTAaqTNe
	 eUEU+pSMHxuJA==
Received: from [192.168.1.107] (91-82-26-209.pool.digikabel.hu [91.82.26.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F2AB486E39;
 Fri, 13 Oct 2023 16:05:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697205938;
 bh=4EMQv5oSMt4ylcU0eR+ZeaHAQR2lZn8x7sP5s7KuGTc=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=X8VUINYqrKuyQXNxum+Af2Q4UDXfnhfEPu+Zr7eAVv3BdV/Bptl78gfsNZFUdutMH
 mG7Q5k+3OPSIeHq1+ZobOKBqkWOYGAJUgSp9NlvkZvb1du1jrZrObN8u9wu+N3eByz
 JbVa3Na+8Wz3JPkKKMQWySGUWX4tlLnfmau7j2Ij5NF4rfuAstZ4+ZRaFVZdQZbcEB
 tey4otnPAfMShAlb6Zz7coje47l6Nl2miEGSAS7VYPUX4iY8pVmkwu3abzxvRRSOZT
 geGUUjnYy+f0JA8NPXDxx7+l9MhShSAqav/61moSfySkqHfI0FABRTQZ3+A/SPaJ23
 2yIUQvBYF6PgQ==
Subject: Re: [PATCH v2] i2c: designware_i2c: adjust timing calculation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231013130939.19803-1-heinrich.schuchardt@canonical.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <9f5ef4e5-f5c3-7ee9-e80a-a7dd62ead631@denx.de>
Date: Fri, 13 Oct 2023 16:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231013130939.19803-1-heinrich.schuchardt@canonical.com>
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

Hello Heinrich,

On 13.10.23 15:09, Heinrich Schuchardt wrote:
> In SPL probing of the designware_i2c device on the StarFive VisionFive 2
> board fails with
> 
>     dw_i2c: mode 0, ic_clk 1000000, speed 100000,
>     period 10 rise 1 fall 1 tlow 5 thigh 4 spk 0
>     dw_i2c: bad counts. hcnt = -4 lcnt = 4
>     device_probe: i2c@12050000 failed to probe -22
> 
> When changing the offset for the high phase from 7 to 3 the device is
> probed correctly. This now matches the value from the Linux driver.
> 
> Without this fix the memory size of the StarFive VisionFive 2 board cannot
> be read from EEPROM.
> 
> Fixes: e71b6f6622d6 ("i2c: designware_i2c: Rewrite timing calculation")
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	use the same timing offset at Linux
> 	provide a descriptive comment for the constant
> ---
>  drivers/i2c/designware_i2c.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Many thanks for this update!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
