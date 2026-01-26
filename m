Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A148BC88E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 05:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DEB783E70;
	Mon, 26 Jan 2026 06:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="guvpq+SU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23CF283E7F; Mon, 26 Jan 2026 06:20:28 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3853983DDD
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 06:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D70CF10E454; Mon, 26 Jan 2026 06:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769404825;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7XYLBbS6KeuYxWoVANjdoknueS/uIz0dEcPKKoXZntg=;
 b=guvpq+SUSMMQW781FyQDKyNN8VFOt7zoTX6QOTJTIH7c+ZDQZbcqVcy1DwBLoNCg3YXRd8
 7fl2ycVHbY6l4xuulnx3lhcklVRrYqWdOuS0btT86MBwD+uitz3gK93ZpRM+X1Ex3tZHOL
 oD/9UDWZc8UGMwhFQILhpRu98Zi/mXUHSsBgUTyPA8xGcfk+0U/LWTkGSvLgs+GTz85TWU
 nC87PPiOS4J8Zf4jhgSlaLbsaX1L6Zp2E5xtFcQ6UCSb37TGbJfM3kV+eWB0eExX9VPcGi
 ZYy6WLpHuNWbgGYAVrUr8e+bcC2YXL6OB01yGMoJmxhU2q4WpdfLNe0jLvUijw==
Message-ID: <9b8c8f2f-86ad-44c6-1670-51e4b0e62fe8@nabladev.com>
Date: Mon, 26 Jan 2026 06:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 06/11] capricorn: config: add bootcounter command
Content-Language: en-US
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-7-hs@nabladev.com> <aXbBysE1PO7yhukL@shlinux89>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <aXbBysE1PO7yhukL@shlinux89>
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

Hello Peng,

On 26.01.26 02:22, Peng Fan wrote:
> Hi Heiko,
> 
> On Sat, Jan 24, 2026 at 06:54:47AM +0100, Heiko Schocher wrote:
>> enable
>> CONFIG_CMD_BOOTCOUNT=y
> 
> If my understanding is correct,
> Nitpick: Enable CMD_BOOTCOUNT to count the boot times

Indeed. Change to

Enable bootcount feature to count the boot times

Thanks!

bye,
Heiko

> Acked-by: Peng Fan <peng.fan@nxp.com>
> 
> Thanks,
> Peng
>>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> ---
>>
>> configs/imx8qxp_capricorn.config | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/imx8qxp_capricorn.config b/configs/imx8qxp_capricorn.config
>> index b5c9fdbc9b3..626634cb09c 100644
>> --- a/configs/imx8qxp_capricorn.config
>> +++ b/configs/imx8qxp_capricorn.config
>> @@ -74,6 +74,7 @@ CONFIG_CMD_CPU=y
>> # CONFIG_CMD_BIND is not set
>> CONFIG_CMD_WDT=y
>> CONFIG_CMD_WGET=y
>> +CONFIG_CMD_BOOTCOUNT=y
>> CONFIG_CMD_CLK=y
>> CONFIG_CMD_DM=y
>> CONFIG_CMD_FUSE=y
>> -- 
>> 2.20.1
>>

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
