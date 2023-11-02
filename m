Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A56DC4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D29877BC;
	Thu,  2 Nov 2023 15:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698934031;
	bh=8tKYQ7vUIx9hNysnSHoP/ayQw1TUC1WP563m6DKRZXE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=g7zIwBesoK0K0nse/+BmzonqUe7bssH6VqLifPnIexWmDBL6w4BUASXjkfF0d7GAl
	 b+8+zX89bPDKnJrKv96JCUBJX/j6cSAdGvN2ZqpIDXMVodosdE5Wg1AflBZCb4JfjI
	 DacYC9/fy0+3dGvE4ePOz3lVOdRJ7aDeUeq/FQRYojqsqnXEJFUDlWt1N5/3MVSHUx
	 ipvdD98FdyzhN0ifI6t9tOWjRoUApDNnUIrbH/6RRwRNECY0NCP9UtH8SrnJ6JOffL
	 YZIyVSwCmCWy0Yt1qblkBXWOVhD5vl/zgzO+z0e3JXL1N4Wi5Hka8oFICv79CM8RWX
	 Q5EVP/oLRD9+g==
Received: from [192.168.1.107] (82-131-157-32.pool.digikabel.hu
 [82.131.157.32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D78388701E;
 Thu,  2 Nov 2023 15:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698934030;
 bh=8tKYQ7vUIx9hNysnSHoP/ayQw1TUC1WP563m6DKRZXE=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Mk4/2tRy0U6XqPPNTx0xWWUF/tiCcHwdU3y3CnZAVZAJKIvtPro70+5L70CoduXX9
 3POTb0Om+ns8RVw7dzPtu0sgirkcWQmfi1GyqOIPpGdLov0E8SH/tyFVcxGd7ewQ0n
 +KeeoGU6nuZBsEUTjwIQ5H5ju4CjVUKtijNlLt3ITcJenjmMeWK8aop5zNcVkZWCa9
 4et8FfxH9W4XaFkX7XibaFUzfWs5dBSEi4GDUQXQmodvcKCsIoefjDLfb7zNHCFAEj
 NV6wIYADbT7KiXaTQe94EAjIo7E3C+xHRP+LWQE9Vtj1ohJVWY12ZPM6TDUu6g5+AL
 CiY89motT9JUQ==
Subject: Re: [PATCH v2] i2c: designware_i2c: adjust timing calculation
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20231013130939.19803-1-heinrich.schuchardt@canonical.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <ae3fd217-7ff3-9726-d5bc-92fe22c0052b@denx.de>
Date: Thu, 2 Nov 2023 15:06:58 +0100
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

Applied to u-boot-i2c.git master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
