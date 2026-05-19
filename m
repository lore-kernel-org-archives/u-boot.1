Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B940BCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:16:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B05D843B6;
	Tue, 19 May 2026 14:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qjW1jzuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C41846C6; Tue, 19 May 2026 14:16:49 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087BA80433
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 14:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=n6tSScPgto58apFTHyo+QYt8BbdaH9axN+mED1l6dKs=; b=qjW1jzuXk0IZhVb2Fz/IAF9Ep2
 vsHOmRm5Tq/PTmd85IUcK9vjycmEcRu2a6eO6jtgBODvU0rAiL/keO6y1LJ+svKBZsDuUsDtDGnPM
 HzxTxA+yxF12Qe9m6UfhGjXBWe6Ti07NXuc8FKpoOT4uSKbrUkrmojE1P7euqngH9gRjBBBC2XHSf
 49aAW+F8zHHdcRbDAFheLd1h+idtj2qJ/NtHj8yG7YELglwmQMAQEjAvIXKwvX4HejPqe6SU+ytsX
 JFawUTSvT+5F5QkJh0VPVSCFMlSuHz1Szb3n2vAS+V4SPs+3DvewT5kQ6quOPZ4UxyFPT61w8EhvF
 Ky9WdfJQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1wPJNN-0007JY-2W; Tue, 19 May 2026 14:16:46 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <max.merchel@ew.tq-group.com>)
 id 1wPJNN-00082e-0W; Tue, 19 May 2026 14:16:45 +0200
Message-ID: <0ae46c88-36a2-4081-ae52-69dae5acb8b9@ew.tq-group.com>
Date: Tue, 19 May 2026 14:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add support for TQMa6UL[L]x on MBA6ULx
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
 <CAOMZO5DruUe7YY0+HiviP2OgsdBPgvJrhEBf0d0kt=J1K_Jbdw@mail.gmail.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <CAOMZO5DruUe7YY0+HiviP2OgsdBPgvJrhEBf0d0kt=J1K_Jbdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/16/26 03:07, Fabio Estevam wrote:
> On Fri, May 8, 2026 at 8:53 AM Max Merchel <Max.Merchel@ew.tq-group.com> wrote:
>> Adds support for TQMa6UL[L]x. It has 256M and 512M RAM variants which
>> are detected by the SPL by initializing them in descending order.
>> It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an
>> additional prepended NXP header image which is currently unsupported
>> in u-boot.
>>
>> Pipeline: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13172&view=results
> Interesting that it passed Azure's pipeline. It failed on Gitlab's CI:
>
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1451666
>
> The trick is that the error is not explicit. Tom helped me to debug
> this error offline.
>
>  From Tom:
>
> "And so in another terminal:
> $ ps uxwww | grep O=
> trini     834394  0.0  0.0   3068  2176 pts/1    S+   14:07   0:00
> make O=/tmp/tmptj4mqomn KCONFIG_IGNORE_DUPLICATES=1
> include/config/auto.conf
> trini    1069113  0.0  0.0   3068  2176 pts/1    S+   14:08   0:00
> make O=/tmp/tmpqg2bkydk KCONFIG_IGNORE_DUPLICATES=1
> include/config/auto.conf
> trini    1481999  0.0  0.0   3068  2176 pts/1    S+   14:10   0:00
> make O=/tmp/tmpwgav3dki KCONFIG_IGNORE_DUPLICATES=1
> include/config/auto.conf
> trini    1879754  0.0  0.0   3068  2176 pts/1    S+   14:11   0:00
> make O=/tmp/tmp7xt1epoi KCONFIG_IGNORE_DUPLICATES=1
> include/config/auto.conf
> trini    2190009  0.0  0.0   9148  2176 pts/3    S+   14:18   0:00
> grep --color=auto O=
> And so:
> $ grep SYS_CONFIG_NAME /tmp/tmptj4mqomn/.config
> /tmp/tmpqg2bkydk/.config /tmp/tmpwgav3dki/.config
> /tmp/tmp7xt1epoi/.config
> /tmp/tmptj4mqomn/.config:CONFIG_SYS_CONFIG_NAME="tqma6ul_mba6ul"
> /tmp/tmpqg2bkydk/.config:CONFIG_SYS_CONFIG_NAME="tqma6ul_mba6ul"
> /tmp/tmpwgav3dki/.config:CONFIG_SYS_CONFIG_NAME="tqma6ul_mba6ul"
> /tmp/tmp7xt1epoi/.config:CONFIG_SYS_CONFIG_NAME="tqma6ul_mba6ul"
> And that is set in board/tq/tqma6ul/Kconfig and so that leads me to:
> configs/tqma6ulx_mba6ul_qspi_defconfig
> configs/tqma6ulxl_mba6ul_qspi_defconfig
> configs/tqma6ullxl_mba6ul_qspi_defconfig
> configs/tqma6ullx_mba6ul_qspi_defconfig
>
> And I see at least the first two don't define ENV_SECT_SIZE which is
> probably a migration error on their part. Which also means these weren't
> build tested by them before posting."

Hello Fabio,

Thank you for pointing out that I was missing `ENV_SECT_SIZE`.
After adding this, the pipeline no longer reports the error.

I tested the patches (V1) before posting them.
There were no issues during the build process.
Likewise, there were no problems during booting or during direct
testing on the hardware with the four TQMa6UL[L]x[L] variants.

I am sending the corrected series as V2.

Best regards,
Max

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

