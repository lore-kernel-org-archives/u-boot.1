Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DBBC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 16:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DC0876E4;
	Thu, 30 Nov 2023 17:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="n8lnVsf5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69EA876E2; Thu, 30 Nov 2023 17:38:39 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE8B87631
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 17:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 35A44100004;
 Thu, 30 Nov 2023 19:38:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 35A44100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1701362312;
 bh=faLJc34R7BSwlAHOiHZInKrPzUYkFGR9VihOXqUciRM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=n8lnVsf5kQrXDC/spz48S6VDlzoTrS36R2qH1bSxAy0LoAHJya6OFSAEI5FpdGUq6
 P4dcQTeyKJ/A+hF2fY2uAISH5spBgP2Ft1MAmQlGDLqCG8fDBIzOqjhTmXfxUD7QOl
 ETudkw7x04XsTQNByC94/CkJHwbHcLjdCBwj0rRE/T5wcsNuJ+UQurwILhdALNUXAe
 f/r8ZwDziw16JdCViskn+28zfc5L4sFEQEvEnjycw8acj2nIEXYe1wTwBFxV2p3fLk
 MjmNsoghSgYDFC0N+hlWqswoFvmtddlHCD6A25rUs+JV+KXdcp+3VBRShiFtROTs6p
 1W/pnQVu9iI3g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 30 Nov 2023 19:38:30 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 19:38:30 +0300
Message-ID: <844cac45-c28f-bd1e-5dd9-cf316ebb878d@salutedevices.com>
Date: Thu, 30 Nov 2023 19:30:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] cmd: mtd: OTP access support
Content-Language: en-US
To: Michael Walle <michael@walle.cc>
CC: Simon Glass <sjg@chromium.org>, Alexey Romanov <avromanov@sberdevices.ru>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nikhil M Jain <n-jain1@ti.com>, 
 Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Sean Edmond <seanedmond@microsoft.com>, Tobias
 Waldekranz <tobias@waldekranz.com>, Stephen Carlson
 <stcarlso@linux.microsoft.com>, Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, Michael Trimarchi
 <michael@amarulasolutions.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20231130112817.98827-1-avkrasnov@salutedevices.com>
 <060f979ddfd1e257bbb3fe225d9af0c5@walle.cc>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <060f979ddfd1e257bbb3fe225d9af0c5@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181744 [Nov 30 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5
 98d108ddd984cca1d7e65e595eac546a62b0144b, {Tracking_arrow_text},
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/30 13:53:00 #22585260
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



On 30.11.2023 16:35, Michael Walle wrote:
>> +static int do_mtd_otp_write(struct cmd_tbl *cmdtp, int flag, int argc,
>> +                char *const argv[])
>> +{
> ..
> 
>> +    printf("Caution! OTP data bits can't be erased! Continue (y/n)?\n");
> 
> Please note, that with current SPI-NOR flashes this is not true and
> there is usually some kind of erase command for the OTP bits. Only
> the region lock is permanent and with that set, no more write or erase
> is possible.

I see, so may be just rephrase this message, like just "Continue? (y/n)?"

Thanks, Arseniy

> 
> -michael
