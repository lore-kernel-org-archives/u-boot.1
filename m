Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E3D2A555
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 19:42:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194D688DCC;
	Wed, 16 Oct 2024 21:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="SBhSwGfJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1574188DE6; Wed, 16 Oct 2024 21:42:47 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe28.freemail.hu [46.107.16.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2425288DCC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 21:42:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XTLwM6nZGzVNc;
 Wed, 16 Oct 2024 21:42:43 +0200 (CEST)
Message-ID: <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
Date: Wed, 16 Oct 2024 21:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1729107764; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=1411; bh=KbJbRGH6sTXJF9EpWJN1vAiZcQyH8/hFY0bEefUra7I=;
 b=SBhSwGfJxOGEL1Yw60c6zBNqSFkLwuKIXz+wKs3W+GtB5g1PsjOLiyxYLF0dqzzD
 Q3jkXKfmeGwDfqNnbh1HKjrZKDVGygrxe+SGpPPx0243WyqrW9p6hxdiXVSRHjpKdyo
 LePNQqWMfhZpuhlCb04VsrzCqQ/5r5gQEkNG/4OtyErXSClbYHkNTKDx8I7FFzXRvvZ
 /7+fMA1hGsipUJb+3DttnU3gI/t5w4zAELLQsNI1cP2YuZkZUkKI3gUVmgt5Ta3plUT
 CbvnKetqpom2xOAC5MLxLqeUSRWrwHQ1CLyrfNQ7cgP5tyq6cS3izdOFD8LRCl+Tib2
 7daTQ09Jqg==
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

2024. 10. 16. 20:28 keltezéssel, Fabio Estevam írta:
> Benjamin,
> 
> On Sun, Oct 13, 2024 at 9:39 PM Peng Fan <peng.fan@nxp.com> wrote:
> 
>> Would you please give more background on this, I not got
>> the point on why doing this?
> 
> I also do not understand the reason for this change. It is not clear
> by reading the commit log.
> 
> Please describe what exactly fails to work before the patch and what
> works after your change.
> 
>>> +#ifndef CONFIG_SYS_MMC_ENV_DEV
>>> +#define CONFIG_SYS_MMC_ENV_DEV 0
>>> +#endif
> 
> I don't understand the need for this.
> 
> env/Kconfig has a default 0 for SYS_MMC_ENV_DEV.


You can use only one of config from CONFIG_ENV_IS_IN_MMC=y and 
CONFIG_ENV_IS_NOWHERE=y in U-boot config in same time.

If you like to use CONFIG_ENV_IS_NOWHERE=y, these codes in the patched source 
files will be not part of the build, and the autodetection of the boot mode will 
never work. At the moment it works only if you use CONFIG_ENV_IS_IN_MMC=y in 
U-boot config but it should work also in case of use CONFIG_ENV_IS_NOWHERE=y 
option also.

Other poblem is that CONFIG_SYS_MMC_ENV_DEV can be defined only if 
CONFIG_ENV_IS_IN_MMC=y is active in config of U-boot. It means, it needs to be 
manually defined in case when CONFIG_ENV_IS_NOWHERE=y is used, because the codes 
in the patched sources like to use it as a return value in some error/default cases.

