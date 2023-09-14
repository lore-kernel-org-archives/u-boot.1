Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C3EDE9A5
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 11:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 338CC86A78;
	Thu, 14 Sep 2023 13:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IRKqTFmh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B6486AE9; Thu, 14 Sep 2023 13:19:46 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC62986758
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1694690349; x=1695295149; i=xypron.glpk@gmx.de;
 bh=Ykd13pLcwhWFUfaYFItGacxg7+K8WXHh3oalyyEcw4o=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=IRKqTFmhHbERNds+HavSv94RzbTIVraKuz4LmHlY4B0jxP3q3AQxCrbB+rytC3oAptS+VmH7qtQ
 xsQ/WO5AjDqrxU2Uoob0dvSS3ePxAGuDML5AGE25Ga0nCX3Cip9NcGPF2X29PZ4PDGHsNgywz+Kia
 CPBDC/yJokyvKi3i06WV2SZxiTYu+aIEuDM1eeplEQQSsEEWND4Xpwrnk9GL03sADDTF6/68QBk4u
 EEWE8s8MmwskGrc1FWrWFZCrM1E4AUFR70sJ6kZz4NALfYcgiA61wmqp1OW9RXEnFLsGTKxc9M+pX
 Ft/0UPZzphYndIIZR9aIhdAiMnl44Fg2PykA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmKX-1r0kEO211N-00KBVC; Thu, 14
 Sep 2023 13:19:09 +0200
Message-ID: <4c1587c6-4bb6-4f41-9871-ba8a142be40d@gmx.de>
Date: Thu, 14 Sep 2023 13:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: rick@andestech.com, ycliang@andestech.com, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, pali@kernel.org,
 andrei.warkentin@intel.com, sunilvl@ventanamicro.com,
 Anup Patel <apatel@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
 <60f816cc-8372-0628-fb1a-0073dfd87361@intel.com>
 <fbac1b44-f2fe-42c1-af62-7a882e4737be@gmx.de>
Content-Language: en-US, de-DE
In-Reply-To: <fbac1b44-f2fe-42c1-af62-7a882e4737be@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZGToTtvCVY6HYZlilAdg9m3rYUjmw15f80zyzOA8n5AoRE5GAzs
 rcRErzOosUcNnWLV9sQvNmfuHp0ur1DSSozp8jWTmmLsgvOEA0+lhtRwnYxFb54ZwcYDf+n
 LIcrbUichdAZtVLRyuXej1J5Ym9fRzx6GHxcRcir80hL4oN4IjYCehXLEntBVuoB6Mismbk
 hH4Vj6ZWXlIrr0S5gKIsw==
UI-OutboundReport: notjunk:1;M01:P0:JhwQY998fjc=;OX7N+AWCk/dPW80b8sUh0/ieZX3
 NZOEBMCLMwtoxGv8WGV4fSVeYl8oSzRbr2Xh7Jd6LzGo/UCquLxx0teM4wOQkYuhf04FOPLuq
 U6im29E4wG2u6GYZfj4J/hZL6p1quaSrVOTrNA+L+HsQKPS0OBtsaSULEYVq6KSfmgy5GHcUo
 O8zX4GANSMjBcAnlVwuWfUsKiSw6mwVxiOmzG2JK476hWx98/8v6X8fZnYki3tedRSe5ILIsM
 HRxjab47dn+2Cg6aD1Jb6+8KjTrxRbsGQKTihtsR5Zv70Dt1FAZzzh66nBgO/aM+RZiYpKmp+
 ZoB7jq7k1IBkSGRgvyWZfLhnA15PPy9Z8t2p/2KzOACuDBuIjHeJVKskvpaJu/27U7/j7hfjD
 H+MJW1OmoZuN0c/fupimwW5YI8re3yu9p46P/aR+W9+jW1Au/nv/wIZCiebFF4QkvdAlB8chJ
 sMp73ek+cxLeGdrDM8pluR7B6VO07GDQu29gat903Of4m8ri6aZdNDckZb/qnfFKVR7DBuM0E
 iVEZVd6NJqQi9PFK1yHyiyvlAdl6j1wcaddcgUGWnL5a3wDJ92fwLC2dQWvthLFWGNplH9uUS
 URJIojxJKgPzgwlAWU/OSfj60TJmjUZNbUnFHlSYcUvnDuR6b5G4DyTQ+WC2Ex4hfq44+LpQO
 3c7pQ9J+vseoX+6/OWl2LBWOfh8kd1cB0s933/dhfFIdbt1UEAnJCBn2dL6Iz9IlPNDqndt47
 kkv6VnwxO42UAbTyqB1tRnDXlOI0/wZ9HfF4GeHVO2x3pY8SHbuCJjvZtj5djH9KhrqB11Lwa
 c0o7uX6hgs+4M/3yLw0TRpHyKmOKahfVJnVFpra2ljmJI4sShrXVjvH2xZvoFqVrp6JXrxMVd
 XAgQVX3xnq7fonE9llNBdfmv2mKj37uUqaFuszlOvadUIhxzoFOoKQBeM9Mw47z1aGQaDKRE5
 3CMsRfoT1Qfytt4lg6bKbj7Pjmw=
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

On 9/14/23 12:21, Heinrich Schuchardt wrote:
> On 9/14/23 09:42, Wu, Fei wrote:
>> On 9/14/2023 3:20 PM, Heinrich Schuchardt wrote:
<snip />
>>>
>>> With which version of QEMU were you able to use PCI pass through?
>>>
>> Please try this:
>>
>> base: ccb86f079a9e
>> patch:
>> https://lore.kernel.org/all/CAKmqyKMtAzt5saCUMd4vXYfgAQibpzQJAhtTSuSb+y=
eKhcYpfw@mail.gmail.com/T/
>
> @Fei
>
> With that patch I see the two memory banks in QEMU but when I attach a
> vfio-pci device my whole system crashes and becomes unresponsive but
> that is not a U-Boot issue.

This problem seems to be specific to my SATA controller. Passing through
USB or Ethernet works fine.

Best regards

Heinrich
