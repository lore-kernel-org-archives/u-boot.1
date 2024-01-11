Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A956FC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 22:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE2287250;
	Thu, 11 Jan 2024 23:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="B9Kh7k0E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC3C877C8; Thu, 11 Jan 2024 23:07:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6105186406
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 23:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1705010828; x=1705615628; i=wahrenst@gmx.net;
 bh=+CYAVkHYtwrioKpvrYsZALIO+P0XtaSPInVZZLjeuOQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=B9Kh7k0E+BvASWCL2daeDe+zyurm4NiGjZWE6eHytZ8QBIJANJ8iPZrxCqjHU2LS
 9hmd9rUZ4ILpyKFMBeWQsJ6wR19+9HrV6aM/vakjCbZvQaisBL4lpj3TF0LVItHWv
 BD2wiyDiYYDmYBmTSiDeHJWNNUupguwSRZWc/b27yR1ZEn+6uNYyQ/o4QTsDK5JA7
 EU2epZTkV1M5nLEqVgXJDz/9n7ad5rdxseoKWhOUDX4l/MFuOqVpRAUIQ/OcIM+WD
 0qbsgO5n6gK7FV4Xq1xfjQ5p3QK1j8dT997U/Gx9zu7//Hzb93sA6AaSIyLEGiJHe
 qsIfJrXu+BgPwJUkAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1rn1wV13gh-00P67K; Thu, 11
 Jan 2024 23:07:08 +0100
Message-ID: <ce4b4620-58ed-44c1-83bc-5c536e8fc015@gmx.net>
Date: Thu, 11 Jan 2024 23:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] mmc: bcmstb: Add support for bcm2712 SD controller
To: "Ivan T. Ivanov" <iivanov@suse.de>, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20240110122908.31612-1-iivanov@suse.de>
 <20240110122908.31612-6-iivanov@suse.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240110122908.31612-6-iivanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:c6qbI/kxS4B4w8T9KHr48A5rEueynNUG5/CBZwHuY77AqSfn9M1
 eYHPcBa/TfrxyOWg7r+dIwtnqvS9vWAGQL8gn3gxNsDADoggyqoR229jqYDMH7pOz7PtMEG
 y4BMOxJfKU8+uguQFsqHWP6F7SZF/jn2F87W7kM2kvdCf9xXrCMBMMXIgBx9ucIORUb/Zcs
 kARIQxE7cpNFe/dUSr52g==
UI-OutboundReport: notjunk:1;M01:P0:Zvj000ivC+Q=;mLj6K39LbsXrbilO6WZNuyhChdI
 6+S/ZVaw1WddgSjlyauIdtcBlhOxXzXOCzS/BZgIYjp10zPqjB1uz3Vq+bauUpJxTA9nJ5Hh+
 1XcsQVAhfmfa8b9oXzTKA/VkkDmqS3p4fZ0r/pOCTuW5X83P1KPb3TxH3RlTEh28EVFwiCaET
 pdQsmUxRbHr30PX2L4Nft28FN99i0mImVaZ+tfcggO/Mdbjg3KueUlRGprd+VnSl7lrEc+xon
 U1YG4UGr9ZTcBKJNrqvcHXN8TcCKM8SMiAemhpKUTRVr/SgzbGwbdLjgUHnov4qBdxYXRnTxu
 7EeYVUHGsO/ijD+Wn/cIbYK7Jb5S3wH7cy92dTtdSSbn8va+8soXH2HJEaNSJSz0fm8+izuUs
 6Qiq1F6XfoBnth4OFAuI9GjkJO8+fFHOdSb+CGweFXUnVgPRUAuPxzz3PhrdLcUPs76T8EBrE
 TjHzeUT7u+6ml71q32pctMsHbV2+Bkyw5HLedi79UxRDU8LMEZsergXi5tfWDm57JPFD4CDDL
 cX7SWaReWMVFppwz7csVymIGB2LSadjzq2ll/n0GNPWlwuBT3Zvuff4HHl3ejbX7Huz/kOUb1
 0YrUIYLEEI3LPK/sf4ep8fEJRqNDlXkQBWW9wp/XsDdb7WBWHrEvaLVb30kA2ijAjWBfPNzQ4
 OM243MVDINn42zprsvnse+8qPIHoBPrGfEBzKCs35Mu8wTOOkpYxAd0uxlEYsZLf5qIVndXk9
 ry3aS7Xc0VamzC0obD0GEY8LiN5WhIKMeUX9/lo/hcwBCbz2K1zxJNn0O/OXr2/5MlSUdohY8
 dr1qDz3DC+Zb37iDAHIjKiKY7DxH8wGt5YtNsRrsiiRSrNDgWJJ6TyPwAGYYGpC/z4tzICnAx
 4ttb5TrI0rOJbi0X9aH9EyDWoIvxrJh7o/FoTAIJlC+HnXJgC3SNbe3aFxKninzDA+rfn6vaJ
 +GY6HA==
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

Hi Ivan,

Am 10.01.24 um 13:29 schrieb Ivan T. Ivanov:
> Borrow SD quirks from vendor Linux driver.
>
> "BCM2712 unfortunately carries with it a perennial bug with the SD
> controller register interface present on previous chips (2711/2709/2708).
> Accesses must be dword-sized and a read-modify-write cycle to the 32-bit
> registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
> BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
> BCM2712 does not seem to need the extreme delay between each write as on
> previous chips, just the serialisation of writes to these registers in a
> single 32-bit operation."
>
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
did you noticed this commit/pull request?

https://github.com/raspberrypi/linux/pull/5842/commits/3c9d840dc933cfb13a77fd3c03356ee4adacc30b
