Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA82DC282D1
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 14:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7749811B2;
	Mon,  3 Mar 2025 15:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="Xt5davG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFA6811B3; Mon,  3 Mar 2025 15:48:56 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E5DE80C93
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 15:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1741013308; x=1741618108; i=smoch@web.de;
 bh=eCRTDxpu+1g2bZDpE3o3zHSl790ed5yQF8L5ICQ0XHY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Xt5davG5EFH2nPTv0uC9a5i68L1M/3M+XdRFHV4YVksuzjsLtsA/aQBTGCk43VwS
 zdmoXLccVsALyyiHuPhdntAnexztjpYbDx/TCE7Q9R+mb4EmOcVxeZj8SMi/CzEuk
 PrKPTfO77YhAxP47zsdXoxsAvG170e4ThiO1o8ADD3yE2ouyxbKW14R+rqrDtK6+1
 EtVDe5nOC8WmG4UffcgLP1jabhx05ZmVfOFKrlLdI7x3QdfoHmsIRE63dBHX7Qkey
 kEWUShpJkleIYmWbLe84op43+60YzwUFblO6cLI7j35Sqv5TnZc51bnFF6Lic1KR4
 HmQiZvhA/BWWzTm2Rg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1tOKuj2Ald-00bobM; Mon, 03
 Mar 2025 15:48:28 +0100
Message-ID: <799cd467-9941-40e7-97d1-a6a10e4fb2e6@web.de>
Date: Mon, 3 Mar 2025 15:48:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common: console: Delete obsolete VIDCONSOLE_AS_{LCD, NAME}
 options
To: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
Cc: marex@denx.de, clamor95@gmail.com, alexander.sverdlin@siemens.com,
 kever.yang@rock-chips.com, mkorpershoek@baylibre.com,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jenneron@protonmail.com,
 jonasschwoebel@yahoo.de, Anatolij Gustschin <agust@denx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <bea64d2913c5c768989d7fcf5201449997187016.1740927024.git.dsimic@manjaro.org>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <bea64d2913c5c768989d7fcf5201449997187016.1740927024.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:uBQ01EpE6QjBvYgUvpW0dt6PrfnLk4irvgvBbqC7CHIdhIrX8Qf
 ADvR6nxqIkQCghvLkv9DRWO3rphgiTT3RkQE50SJpfDYAkpDZ+gjPmOJOSq36fAFsECpwbE
 //XiWE2iW37NhGld4MrDzKqiMeBaVRCu4wDaY6UI5MyWYp4WCaIBOgJOhWsoUYdwz9ucbBe
 F0s14Wahmbiuis7caVTbg==
UI-OutboundReport: notjunk:1;M01:P0:51ZkQKGzZPk=;dHREskqqFuHZNwOg43+jNsaoJj1
 /MKHVfNXWZmHCEhVwOpnD3vHzQvheW+HNuQlPX+BwRHqXjLrHpygXM12ae4cB3HvXclVT0Yfx
 QCTsKm3J0NQV1Hmvokqe9jBWq3PWvawAlk6lxYTDugUGw1evl5+FMHYy+Y/4EIA+w3nzrWDVf
 TWExykrHglHV+Z9z/eWm1pm+316Idz6jgJ6By2REoi+PActOeqOxnGuqNbcMar2cZYfW0KevB
 YDDdv1wPzcmVNjpuaSBE22R97sGzb3tWnyZcvh/4eZgsz9hdPYP7UWsM1mpK07KuYc899M9Av
 Jy7osfDbhIG1QhwVCCK42b0BVJ/+rbr2UrTowJorNk30kmvpcxz0UYF8nqLiaXde6cXE0VR0O
 e2zLtXaY4vcsomUAcV5vDCP8mUoMEgZydDSUs2BYyYVkFYCLKD3C1bvcGK/UOffeq7B3uLk+H
 sYf4GGymhvWPgtHHsJ6QMt3us8VFAgsgaEqHhQRKQYf9reHiLCA/prPgxwQLPEROCzVTZ7Mq4
 MluqKBPX+qHdSpV/6Lwnem042OglrO2KfMTXy/Stj1ccF04dXsjA2HCjheISl3QLbEdpXx7At
 MrPKHsA4YWBQsaR9lyUIw0F5D5ADISm04CH3EaVbifDT9oWdQrADgSW4hoBs3l4OdTwyBT/M2
 P/Pptv2AlxUWNSpZpHIOGqY2K1y0HhVwiAP3m0GuxRDzFHeybSU93/dvpL/IsvjQOSXJA9bia
 AhySRwqAj6s6B7gdTG5ShavBohAmxEI8UhnNDadekr5QlAr9MgTdxs7dClsN7mV+Q4wQdUXD3
 0tyZ1wPSeVt1Bs2qYWTg8Vu5O7QVzLl2/0j/3CiKVERVtj8zB0Hflzd1BY4b0CEiYtNptrkgG
 3VW9CM6yobWaYVMfyo0AO5s9FQGEUZcCoyj6piGAvyJIh0bvBqNyUR3Hi2bQO7MhwCv5+Z/GD
 cMpR3Ddkmtl5i8GJi8WCxRLWAh5wtF6sah+wfbIDauhJDWdBBQIAhUcCCLzxf+G5FfldY/V6w
 5exOzBDEVuatBM1svNFcM8k/W74+B0ppOa2FsDP9rpcr10g2W5nBuEFhzJDkeJG+LRtlPtCQD
 Ktk7jE/q3S1NAKem9Ei+wX8xatUPX2ekhh8OnF0wKwAO49NFmZeZiJzI1zrviNf/1apw4wXSY
 pFAYmZ/d0gRHSt/HVz+6Fc++IFS8x1rbV11LJsxBmzAO7pH1zyrBOj3Q/CcHpKeyNgSwj49iV
 StGZR42XIAqpKj9NijES6KMbixUJdZx6QAl6V/geNMMV67/mrVgiIhY4HTxIR0ec+2aTNCN0Z
 Sw8g70CCBWVLBlMYtJOTKjEQVENdBydzJxXj2jgieOYEqqsaAR8FlkErzaKWRGB7O9juSCLMb
 hkTlxDZP/naBAobkyLvfiAUUovrLNgH+R1Y74V6IREtAofAKjuA9Tb1DKV
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

On 02.03.25 15:52, Dragan Simic wrote:
> The configuration options CONFIG_VIDCONSOLE_AS_LCD and CONFIG_VIDCONSOLE_AS_
> NAME have been marked as obsolete and scheduled for deletion in late 2020.
>
> That's already long overdue and the last remaining consumers of these options
> have already migrated to using "vidconsole" in their "stdout" and "stderr"
> environment variables, so let's delete these two configuration options.
>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Soeren Moch <smoch@web.de>
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
For tbs2910:
Acked-by: Soeren Moch <smoch@web.de> Thanks, Soeren
