Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4165C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 15:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190268785C;
	Thu, 21 Dec 2023 16:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="hLeGZ5TJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E0D876A6; Thu, 21 Dec 2023 16:40:08 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DABE87877
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 16:40:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1703173195; x=1703777995; i=wahrenst@gmx.net;
 bh=LDwqgSG2vjDMcRaiuVFdLweoISFhyEUNZLB0kIPTdAw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=hLeGZ5TJ5YiJp5OeQ9YwrqjD4JRZYt4O3vMWSK4PuacyY1IrPUQhGrQyML88POBI
 M07DT77nCTO6Je18A3mli4wDQcbQO19MuqdnMreNSvmuBx/ZwHRjWKXNa/F1W0eN4
 AfiPF0vRMrneAqvr3+mZQrzFUowxKFWZiG1AEbb9NQLDFgDIAbiaIK/19X18DeXGr
 I/uW5FSQ94jyQ27tvJ6QLEeS+eobbth5GEr3h9r8/ETMSwtHof3kzE4ACvwzYR4Kv
 2aElDeHanGJjflVyyWfcbxBu4RzhUKwHF+zVu21nF85tw3Rg//hMzipPK4o2Xp2aR
 odsuZbSZt+1a6ENhWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1r7MtA1p4h-011foG; Thu, 21
 Dec 2023 16:39:55 +0100
Message-ID: <db91a259-d504-4e8b-8178-dad3e5709b93@gmx.net>
Date: Thu, 21 Dec 2023 16:39:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] mmc: bcmstb: Add support for bcm2712 SD controller
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot@lists.denx.de
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-6-iivanov@suse.de>
 <fedeb96c-19db-442d-bab0-e87d6d8bba68@broadcom.com>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <fedeb96c-19db-442d-bab0-e87d6d8bba68@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vkVT7TDmWYOeGfq3L+/CJqrZQk8LfogTS/F03dMCgTpro2I11sA
 8Qchpe56gIaSCyhJWNFiSM8RE7906TbW5bv6iEXJRMWxl8t55jkOIuPrPIqmIACpBqHjVDJ
 Jdxq9mESpBxNrRYepaHTXltVLFoILJipYUaLTSTSjdZsO154nTkYVJvqToT8PwKeq94A4FK
 PNw9ddkUrkDwP8ife8J/g==
UI-OutboundReport: notjunk:1;M01:P0:wPcpK1SPwbY=;onIaTxUlTDp7cMrnrT3m2Q19jmR
 7n8zaDLqw0a31S1aNoTFOkyka9JBz3NvtP3av1SP3THYsk3UCxhErRVq01n3ndCE3/XRHvE8t
 li8sIpn3Ly2AWbXE3IFMoNunXIYh+C+JCIlPwN9HgZqKOoMO6BKZigIeosjygLIgki6kTRcgB
 U7Ji948vGv0sDUwGCOrQe4QbR7NaGYSnYYJG37GgnCkQvbg1PNgJL1r8h8BfM/GWQ7lAH7NLF
 ob1yqx6CXBa2Vu2dPqL3kXY4VrMbaQJ9dpCV4+ZyYgCp92dMSK3uC301rxsiuBNwtIVD/e0yt
 MdPYhbbAWC3MlfDO473JmW3/NY2sq0JTamZGu9gQ2lHz1CnjPImUDwUu6Yvj/lrSMvny8wf/y
 SJcLJ6PR6+LZIHpN1hN0hxbr5kRAp7P+kH5+J1DVrkgw6ccxEKg7vHVG16a6Ekz7sFQ93efKP
 BXFojlLnYswV5Qxm3kRitjPyrAAb1BgTbHWirC8TE4bIBM8g8gv9qTexkEiOCSYTTlNd3mhDm
 2IuQ4qfU8tPYkQ80WVj7/AjXi6U1704f2KYG3vuUJ4aZ24FYbJv7OABpiK7OBTkoF/WVqA4nD
 i13OLHtW0pQgC8JXPozK5cWYTPn4K7w0Ufv1/esnuEVK0ShoHm/F0Tj7t4Qc7YSk6D/cylDSw
 Iw1TgfBgN+tPI9WVRvEQg12rgM+AEL8YR6mLs09znusuh8tvdTYr/P+lGHGkgKuLMTvUH10iy
 VlH15xtKAiRJf1A/39lCjbe4M6cDWPir2jAarfeveusJFPqYgzjwPh1c9pJ14XG7q8VFAoXBa
 q+nIde7f7QtTCXpyXTsnaBf7GVCt40UtcyCCWPC/4KPIMQokj01pCTRWKQJEnTOj7tCG8jTsi
 P7Ff9FyC8qrY0o1Dqmac3KT47zru8GgJkJZo1DiU5IR/sd+ASldcQCpciPa/wdnhPS1zJAcJ5
 k+AJSNwxW6r/eHO5z2v7+nsUQko=
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

Hi,

Am 21.12.23 um 16:13 schrieb Florian Fainelli:
>
>
> On 12/18/2023 10:03 PM, Ivan T. Ivanov wrote:
>> Borrow SD quirks from vendor Linux driver.
>>
>> "BCM2712 unfortunately carries with it a perennial bug with the SD
>> controller register interface present on previous chips
>> (2711/2709/2708).
>> Accesses must be dword-sized and a read-modify-write cycle to the 32-bi=
t
>> registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
>> BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
>> BCM2712 does not seem to need the extreme delay between each write as o=
n
>> previous chips, just the serialisation of writes to these registers in =
a
>> single 32-bit operation."
>>
>> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
>
> This is diverging from the Linux sdhci-brcmstb.c driver where no such
> quirk needs to be carried out, rather the logic for such quirks has
> been present in sdhci-iproc.c...

it seems this patch based the downstream kernel changes [1]. I would
suggest to use an existing driver which already handle this bug
(iproc_sdhci or bcm2835_sdhci).

Does the Rpi 5 still works, if the compatible "brcm,bcm2712-sdhci" is
added to mmc/iproc_sdhci.c?

[1] -
https://github.com/raspberrypi/linux/commit/b627647c4500d39cb026924b608841=
fdf4d4d7e9
