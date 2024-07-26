Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61879C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 09:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4EB88418;
	Fri, 26 Jul 2024 11:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Y0koFSHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CE288496; Fri, 26 Jul 2024 11:29:24 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E4088365
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 11:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 9BA0812001D;
 Fri, 26 Jul 2024 12:29:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9BA0812001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1721986159;
 bh=Cdfur3kJq+5v61f9m8HKu1JvvB11hV5sYicq/hvHkx0=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=Y0koFSHvvvgAcnYJRGLQQ0NjMRfSQdmqyZxekVn7xNBP2OwSEa9YryIO+v8nD8+Mv
 qlqFYeTg8WBUkFsAhcpqS0nYLUYbT0EdhrcxwGiHgXYzFKEKn9FoFTlPE9Tbq6Fq+X
 0nAYWQDGL6YPVUUXEMD9MLyxyc/HZPZCJjEtxlFSdwgxaJXPMRpV06UszHFysDpZw4
 XSSPJRJMHivl4XdbKDUE/WakQk+A1fMImRJp4GDlHwP+Frg28vPQYW+3J8nwqOb4zm
 7vQZaj7momom0Zk0LVWFJo+q/e0c2gKa2ny93PwSkWkyajSDtOHJXYwoZ8wkvHfRHG
 OkUyfGWu4xDvA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 26 Jul 2024 12:29:19 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m02.sberdevices.ru
 (172.16.192.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jul
 2024 12:29:19 +0300
Date: Fri, 26 Jul 2024 12:29:13 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <igor.opaniuk@gmail.com>, <mkorpershoek@baylibre.com>,
 <semen.protsenko@linaro.org>, <trini@konsulko.com>,
 <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>
CC: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v1 0/4] android_ab: fix slot_suffix issue and introduce
 ab_dump command
Message-ID: <20240726092913.ilx4kkal73xtrdnm@CAB-WSD-L081021>
References: <20240725194716.32232-1-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725194716.32232-1-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186730 [Jul 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24
 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:7.1.1,5.0.1; 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; salutedevices.com:7.1.1;
 github.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/26 09:01:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/26 09:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/07/26 00:24:00 #26151929
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

Azure pipeline is successfully DONE

https://github.com/u-boot/u-boot/pull/625/checks

On Thu, Jul 25, 2024 at 10:47:00PM +0300, Dmitry Rokosov wrote:
> The patch series include changes:
>     - fix indentation problems for --no-dec parameter in the ab_select
>       command
>     - introduce the ab_dump command to print the content of the BCB
>       block; it's seful for debugging A/B logic on supported boards
>     - add a test for the ab_dump command to verify the accuracy of each
>       field within the ABC data displayed.
>     - fix the slot suffix format in the ABC block to align with official
>       Android BCB specifications
> 
> Dmitry Rokosov (4):
>   cmd: ab_select: fix indentation problems for --no-dec parameter
>   cmd: ab: introduce 'ab_dump' command to print BCB block content
>   test/py: introduce test for ab_dump command
>   common: android_ab: fix slot suffix for abc block
> 
>  boot/android_ab.c                     | 73 ++++++++++++++++++++++++++-
>  cmd/ab_select.c                       | 34 ++++++++++++-
>  include/android_ab.h                  |  9 ++++
>  test/py/tests/test_android/test_ab.py | 23 +++++++++
>  4 files changed, 135 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
Thank you,
Dmitry
