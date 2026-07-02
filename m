Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB1AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 04:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C638084C68;
	Thu,  2 Jul 2026 06:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="NK5Gj9rL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CA284C6B; Thu,  2 Jul 2026 06:30:23 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473CB84C67
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 06:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5122B11882E; Thu,  2 Jul 2026 06:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782966620;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=02QUk4y/BLeHbCddrKpSDkOdu0c/ui5nFz4QK8DInQQ=;
 b=NK5Gj9rL5nPLYuOVKhK/3VeQJj7qdjz47PDHxJUDLQe9aHB023CKpX2uLjO+iMI1ImdGo4
 UJLbCH7uUKEP94pNrtSjWt0+9ZeQvuU9XwwTiphHWMDSxVjqOSXEpl0AWgq3olxBU2kCbt
 zscQvaq/NriBZhqqVKqxPJqP+H3qltLnxrOnA1oHa7RZNURKyDv6kk6WK1ZDgOX1x7RK5x
 xXC1k/5Wksrhagv23suY49VuGDrgAWizZ7KHPnrzRJFXkqo3FASHounkx+HSS8m8FFFOYP
 qfCF70t2sGfubVGWnUVpfro2itoPrFDQkSnWOG+7lKv5dR2AnNFhFC67BhlKEg==
Message-ID: <534ff837-08ca-9d95-c53b-64466fcc8aa0@nabladev.com>
Date: Thu, 2 Jul 2026 06:29:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cmd: kconfig: i2c: add DM_I2C dependency
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Julien Stephan <jstephan@baylibre.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20260701-cmd-i2-add-dm-i2c-dependency-v1-1-19ebda3a80f8@baylibre.com>
 <20260701161838.GJ749385@bill-the-cat>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260701161838.GJ749385@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Tom,

On 01.07.26 18:18, Tom Rini wrote:
> On Wed, Jul 01, 2026 at 05:55:14PM +0200, Julien Stephan wrote:
> 
>> CMD_I2C depends on the DM I2C API but currently does not enforce
>> DM_I2C in Kconfig.
>>
>> This can lead to link errors caused by unresolved i2c_* symbols when
>> CMD_I2C is enabled without DM_I2C.
>>
>> Add the missing dependency to prevent unsupported configurations.
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>   cmd/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 032e55e8127..636891ed493 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1392,6 +1392,7 @@ config CMD_IOTRACE
>>   
>>   config CMD_I2C
>>   	bool "i2c"
>> +	depends on DM_I2C
>>   	help
>>   	  I2C support.
>>   
> 
> This removes the command from the handful of still legacy I2C boards:
> $ ./tools/qconfig.py -f CMD_I2C ~DM_I2C
> 15 matches
> MPC837XERDB cl-som-imx7 d2net_v2 db-88f6720 db-88f6820-gp inetspace_v2 ls2080aqds_nand ls2080aqds_qspi ls2080ardb_nand net2big_v2 netspace_lite_v2 netspace_max_v2 netspace_mini_v2 netspace_v2 work_92105
> 
> So the depends on needs an "|| ..." in there, for the I2C but not DM_I2C
> case. Thanks.

Thanks for checking this!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
