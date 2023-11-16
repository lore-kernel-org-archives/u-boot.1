Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FA9C072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7575D86F31;
	Thu, 16 Nov 2023 02:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JY1CCRtp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A9C87045; Thu, 16 Nov 2023 02:07:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5FB8269F
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700096839; x=1700701639; i=xypron.glpk@gmx.de;
 bh=pe6PrPa2FzQ+GtXwJ/1iq1+Oim7TMNI3lHSJ5Yp3l+w=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=JY1CCRtp4KfsyYfUYEHXNthSB9/7PhUCFqxiVRe3dqc5F2JuqDyTEhtFCQlXl31t
 VDiv3zmtiFZgTUM8Sc/l4Jtak3LIyf3xUpejL8u9hOpVZGYY6/Q5c+j4TgDU9UMoA
 dqDurXTGguztM6fznGKPgzs43zqe7rBlIwLHWKBNkwh6G6S/TBt8x7OQtZ85e++SE
 eDYaivCDpxQ4MdmVTZPLQLc7GjraNU2KALP9MjJQ24NyaNf+d+BBDhGXLmC/U/A5b
 8zql9RiwiKJetiw/YFiuVG8BSIAlpm+LGIDMrykUB/7XwjJrVoLyn7fpPmpUHLxlQ
 nQdIfHORHoVS+oXbeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIMbU-1r6ieI479A-00EJvE; Thu, 16
 Nov 2023 02:07:19 +0100
Message-ID: <e1683a7a-45b5-4a0d-9871-bcb25b0fd601@gmx.de>
Date: Thu, 16 Nov 2023 02:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [BUG] usage of $kernel_addr_r in distro_efi_boot()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2tZrG+tESFIT2gAhd9Lg21gh5mOzXiupgvCaDD2odGuoHV8Np4d
 F6AKoqM5sF5JtMIaSZbMNHlPtcry7Fb5K726O6rTtloGK/N9eTSdHuLmXYSE/t1KOBgHa8h
 co6SYweR60lw/cRxtS7em/1t08nNr4RgrgPmdKNePKS2ZsmJoysM1QUHffyIjfxWapPkbKL
 IcClqaVEcVqgYCpHvdj6Q==
UI-OutboundReport: notjunk:1;M01:P0:rH6AeMwdh9Y=;Ox0WTPMV3oBP24aLvQmHkFiVHgB
 6A3kLaSN2rjg3ge6NGeMWPFmmPmcExFr1LvSEPZSm+sJWwFewrKUs5UBwztU77SmyRYGYV5Jj
 TFty1miFE61XvKT09bqzlSomOYqoDktkykyVpkgvyDRV8fjQnzckec9BVswd5c91zZza0Fiic
 4sPlXWOnNclw1SC7tSO/Pq7yWDT/JQWrnMiofkORAXVXol0kfcEbU+I0Pzg4TWra9sATT/KPc
 FZUfwqVH4ODPJLCAvB+IUAhp/SkpXQ980dCsUJKphEB5BOqmmm84PJDl0m4bMI2xXMNyDEjdH
 RwfehO/HIyMvlveoEib5hah0OhlXJQld2EBDC9tGkQe91cqfT2Du2KIprrsuTinWY4+gXJBUG
 HCjPziRsdLa/CeflI+NivVUzFNe2FPhHjKhPkt+VteJesQAglG7L9+GQlynD0/BBHh3vX9RZz
 xuBu2vG2NgCR+ed/12beZd0oNMu/SPDvI9gMDC6apLi1c97TVNzcNYBaP+/Flk6R/38S3a82q
 mGVJ784CNBIWNG5O3vqnblhm+t2SsMUcOfpjYrsweoYdZ61lqR2oR++cudNuvSpqoH87JSVbM
 tZ+10f8K0uflNhj35AdJy08Tj38yyAc13GqrJvso/iiAidMtfm0MBRl0hEHLOYrmaIfWHzwb5
 5exqfuupZL9gfRXB2zDpWuXEUb1vBcz5Bx+EeMATB+BVuSrLuOgwRE8T9EbwxNkQpZejYvpd5
 DuQoRbHDovWHNGJC98F4hwrj7exX84TFJZBGrSqN1UyeblluNRCHXTRyILc7ZAJWBra1cCXDO
 MDw/vv58leeQ6J/I9eK57zJRPRC/MrU2V3LWAa9kcYrp2/DL5y6B8oNw20yVNQUBDok4b9fEF
 XaxGhOHH+Z1AWFy3MJFhow/OV7qD4FThf2Z8y6Rhhe0JrIoWoknqH59HtfxC2+mrIAuFjMAls
 XVcNTxXSc1lYTqZJ7RQWRCyotwE=
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

If $kernel_addr_r cannot be read, distro_efi_boot() falls back to
address 0. This will lead to a segmentation fault on many systems.

distro_efi_read_bootflow_net() has a fallback to CONFIG_SYS_LOAD_ADDR
and may have loaded to that address.

Shouldn't we be consistent in what we program?

Please, use a field in the bflow variable to indicate if and where an
EFI binary has been loaded.

Best regards

Heinrich
