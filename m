Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0B0C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 10:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499BE88B19;
	Fri, 19 Jul 2024 12:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="VRiEpHDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A310F88B19; Fri, 19 Jul 2024 12:43:57 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE5F884C5
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 12:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mmkurbanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7C707100008;
 Fri, 19 Jul 2024 13:43:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7C707100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721385833;
 bh=XePHiUHhYBpZ+Dp3HCUOBxFOQZUn9UtDxOqpem15d6I=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=VRiEpHDFmQpMZtZ3B1qkhWSea19bAbAhSTC3rHHZ8ViUJ9FWhuwRko2QTtYowHg7I
 fjyv69smsyw+sXy2dfba1rsqlwt18gCYcvYmyUgBL4meury764UO35A1AYGvqQnzcP
 aHsKNdKJ2UQzVoug+xoKVROSQOSgJYQV3MoCaWcnOSH2KAZOADn+apdgByIvqryR98
 8k7S3zicZJbSgjzaF+e06ZXMZbSmaUjqZICDTYMGviNnFM3y3b9JCy1oqRSRhY4mue
 tCJLs8CH4eEx/khXe6a9oeXzw8pIQxHOgf5NkJtVGwjw5AQqT2pclNRC/xRl4yrXdE
 oqe7pkA/Hm4pA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 19 Jul 2024 13:43:53 +0300 (MSK)
Received: from [172.28.66.131] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jul 2024 13:43:53 +0300
Message-ID: <94c1d54b-24f1-43a1-b56c-7af73cc7596c@salutedevices.com>
Date: Fri, 19 Jul 2024 13:43:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] cmd: ubi: check 'updating' before calling
 ubi_more_update_data()
To: Tom Rini <trini@konsulko.com>, Dmitry Dunaev <dunaev@tecon.ru>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>
References: <20240616133426.123299-1-mmkurbanov@salutedevices.com>
Content-Language: en-US
From: Martin Kurbanov <mmkurbanov@salutedevices.com>
In-Reply-To: <20240616133426.123299-1-mmkurbanov@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186588 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: mmkurbanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f,
 {Tracking_from_domain_doesnt_match_to}, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/18 08:29:00 #26061289
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello. Please, ping

On 16.06.2024 16:34, Martin Kurbanov wrote:
> If 0 is passed to the 'bytes' parameter in the ubi_start_update(),
> there is no need to call the ubi_more_update_data(). Otherwise,
> there will be a double-free of 'vol->upd_buf'.
> 
> Also check that the ubi_start_update() was called before calling
> the ubi_more_update_data().
> 
> Martin Kurbanov (2):
>   cmd: ubi: remove redundant initializations
>   cmd: ubi: check 'updating' before calling ubi_more_update_data()
> 
>  cmd/ubi.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 

-- 
Best Regards,
Martin Kurbanov
