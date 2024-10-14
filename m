Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B97D1813C
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2133588CA1;
	Mon, 14 Oct 2024 20:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931329;
	bh=VXsRoySq9ApVvyDaWMSBSnnagXidGqZwTp87wLLgKpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdPcnT6g8Ic1sWsbznpu1ckiMFXxTRLu9+ZXMD1STlWTF7cuaEMMxtGtWobduFgeH
	 5LLcL5aYl9p+lHHWeqFrDmEMxxCZABgQJjb6DmGww1GXhe9k4yADSpCXa0S6SNqcLR
	 sc2vqEsZMLGJFl2dQttPZSw+XBBhgggL9UpcpJn67HnG0w7/WTfnDvRMzfNOIfGeLR
	 NB7cwQP6wpoZxVod7xkYgVAsf8F+XF1SkXAPPSByt5ME30iXB/XGqZ6F2/i0wskKy+
	 Mg9WnUK9QDIA23eK/u/88yS921wLFpZd2l9Cw6c3vEGVJ9QByXwaWVxJVSwZ0Fckf8
	 Ty2wIaC/g+Zww==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7F02688F91;
 Mon, 14 Oct 2024 20:42:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931326;
 bh=VXsRoySq9ApVvyDaWMSBSnnagXidGqZwTp87wLLgKpc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TnINI0rTLQyklqVTYxHb0qFsChWAVipcw30TTDckbqDq65sTZJLDuD+RfYLbtO0zw
 6AK1dIdlIDZr5tgyoP5EUWfFzB6jYPcESDquSbQNAuCeoBrtKx9CZh4dURPcmghL50
 7nA4J7aGiqG8OU5DtvhlGhvm4OsU4CLyd1U2UHflyVyKYKyOMM7lmiKxedeLa06aAq
 g520GKzSBXTgko7MYtm/kHZH31vCDU6wYhtpItqqBXFeVGDWVgzONx2qEXB4SD14+Y
 vL05Hs31EdqzdInliUC5Q7XLytMpMo/jjuct0ZnrT83Ez+aVHS+5wXMXuGYe6+IrGU
 ikOXSlD5atMmA==
Message-ID: <1783bb51-88aa-4d7a-b655-73df1cc6ff63@denx.de>
Date: Mon, 14 Oct 2024 19:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] ARM: socfpga: add Mercury+ AA1 extra env settings
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-6-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-6-l.rubusch@gmail.com>
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

On 10/13/24 4:32 PM, Lothar Rubusch wrote:
> Provide an initial environment for boot scripts to operate.
> 
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>   include/configs/socfpga_mercury_aa1.h | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/include/configs/socfpga_mercury_aa1.h b/include/configs/socfpga_mercury_aa1.h
> index a5b63336e8..d9d169f6dd 100644
> --- a/include/configs/socfpga_mercury_aa1.h
> +++ b/include/configs/socfpga_mercury_aa1.h
> @@ -16,18 +16,8 @@
>   /* Memory configurations  */
>   #define PHYS_SDRAM_1_SIZE		0x80000000
>   
> -/*
> - * Serial / UART configurations
> - */
> -#define CFG_SYS_BAUDRATE_TABLE {4800, 9600, 19200, 38400, 57600, 115200}

This was added in 2/10 and now it is removed here, please only add code 
once and don't add code only to remove it later.
