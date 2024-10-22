Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB56D1CDD5
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 10:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EE1D88FA7;
	Tue, 22 Oct 2024 12:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="pzN87KSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E07BC88D8D; Tue, 22 Oct 2024 12:54:27 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe30.freemail.hu [46.107.16.235])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D15588D5A
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 12:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XXpw03kzpzGpM;
 Tue, 22 Oct 2024 12:54:24 +0200 (CEST)
Message-ID: <ab46ecca-15df-4a01-bbc2-41b50ac668fe@freemail.hu>
Date: Tue, 22 Oct 2024 12:52:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
To: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
Content-Language: hu
In-Reply-To: <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1729594465; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=1795; bh=geiPv7otegyla2px5LTd7qjvTboXCLJwzhvZWyvLqTc=;
 b=pzN87KSUTeMDpcRHGevpOCYJ1Oc2XXWAo/RxIsV7znHTHHyJ3a7/exRUXSbfyBuC
 f8nk9S/Py7w33+CmKCXlb0HKgFvYRfz2GG7ERodjr4uTopuJ9rttx5hMnV3A3cKz5SF
 pO+rJjcYXzYquEYALrwChSIj6zSgdp534bzSErcKU3d1rRHMh1Ic50jf+m5FA/gROWt
 TN4Y4sLmSINCQCF+PXIARQV9kyLgywNwS7O20mGLLkhTQd/dfI6hLz/GEyMV/R3O7wR
 sr1x3EipoVcatGauKaxhyKfnFqa3TNtKk09oMx0mslAhO0Axywq+w3UnhUgjMJRK8/0
 RSSXVcKadA==
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

2024. 10. 16. 21:41 keltezéssel, Szőke Benjamin írta:
> 2024. 10. 16. 20:28 keltezéssel, Fabio Estevam írta:
>> Benjamin,
>>
>> On Sun, Oct 13, 2024 at 9:39 PM Peng Fan <peng.fan@nxp.com> wrote:
>>
>>> Would you please give more background on this, I not got
>>> the point on why doing this?
>>
>> I also do not understand the reason for this change. It is not clear
>> by reading the commit log.
>>
>> Please describe what exactly fails to work before the patch and what
>> works after your change.
>>
>>>> +#ifndef CONFIG_SYS_MMC_ENV_DEV
>>>> +#define CONFIG_SYS_MMC_ENV_DEV 0
>>>> +#endif
>>
>> I don't understand the need for this.
>>
>> env/Kconfig has a default 0 for SYS_MMC_ENV_DEV.
> 
> 
> You can use only one of config from CONFIG_ENV_IS_IN_MMC=y and 
> CONFIG_ENV_IS_NOWHERE=y in U-boot config in same time.
> 
> If you like to use CONFIG_ENV_IS_NOWHERE=y, these codes in the patched source 
> files will be not part of the build, and the autodetection of the boot mode will 
> never work. At the moment it works only if you use CONFIG_ENV_IS_IN_MMC=y in U- 
> boot config but it should work also in case of use CONFIG_ENV_IS_NOWHERE=y 
> option also.
> 
> Other poblem is that CONFIG_SYS_MMC_ENV_DEV can be defined only if 
> CONFIG_ENV_IS_IN_MMC=y is active in config of U-boot. It means, it needs to be 
> manually defined in case when CONFIG_ENV_IS_NOWHERE=y is used, because the codes 
> in the patched sources like to use it as a return value in some error/default 
> cases.
> 

Did you get what is the problem?

https://github.com/u-boot/u-boot/commit/636c95f82b9a184a9b45a8965488cea2dedcd78e
The implementation of mmc_get_env_dev() in arch/arm/mach-imx/imx9/soc.c is not 
able to support CONFIG_ENV_IS_NOWHERE=y using. It was fixed in my patch.
