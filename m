Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5BBC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F0C87F7B;
	Tue, 27 Feb 2024 14:18:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="BgHEcID2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 510348751B; Tue, 27 Feb 2024 14:18:40 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5751587FAA
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709039902; x=1709644702; i=xypron.glpk@gmx.de;
 bh=cUkKjakjJ31US787xwPmR976p4+3JFDp9pclaGZNaz4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=BgHEcID2V1Us2jdlL/5BdiGkJKr6rxQIBu3t7+FsEmecM5KxgUKl2m9EnMV0JUnz
 kdU/oE9WOSro81/45H7s0r8MqJEMIu2XFyYuzGcwD3HdVPeTt+W0E1cqiP4oGfrln
 w0wMBT0n9gPZPgTAu0+Gy5r15oaeJRAwEL7kRz/O8/ET0fUt7IBsrdfdhCV4anKcg
 MvuN88bjRJ40udhCFr2en7knfnIezQma6jvkWWYCEY+W1+pO1cli+SXOHlBP19V7E
 ORCnBl8i9VBIDVVMuYREGUdDGisI0583OwxZHvCpJSF9dn5LbHMRexabK2mx18ng2
 UVgMWWF7NypvcQcTag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([95.222.37.56]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCbEf-1rnzuI3UW3-009gHB; Tue, 27
 Feb 2024 14:18:21 +0100
Message-ID: <e9a4ff30-d854-4f34-bc40-95a9e385e9d2@gmx.de>
Date: Tue, 27 Feb 2024 14:18:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] efi: block: compile only if CONFIG_EFI_PARTITION
 enabled
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: kernel@salutedevices.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 bmeng@tinylab.org, tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com, michal.simek@amd.com,
 mikhail.kshevetskiy@iopsys.eu, patrice.chotard@foss.st.com
References: <20240227100441.1811047-1-avromanov@salutedevices.com>
 <20240227100441.1811047-5-avromanov@salutedevices.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240227100441.1811047-5-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kupa6IWgOntHqEE16yUIkQ+aBKe9jHKAZ2vgHnz8/Yuu9F0ByJQ
 JsAyl6CD6EnyyCy2QGHN8RtBRuCKvaoesUvlaNVUs6YSjFYvmLfFwez2fClDP5AGzjTzUaN
 tkwYdk85LgQduRuaJ52FD7DDWVzn/GFujCeFBTAuPnjv/+ZtqWyvemHaScmEazIEaFRnL7B
 rODzkd6386VjnWZiF8G7w==
UI-OutboundReport: notjunk:1;M01:P0:ZkIMvrNbzj4=;f3SuuqqPq6Q1J8LiwnUQadznmYN
 iPQ2CveeE1BJoy9xmXxnMNIRnI8M8O+kl2t0SvwiHQovR0WmYydN2Xsz+nVM8ICBE+O2KbgxR
 9RCvuJ+zpzKinewC/8f8zpcCiP0BRqr4vYqYikQppXYB5Ve3PhbsHIvQ5csV7uqPE8pb2gcmD
 lgB4J5w0fAz9YEcHwdHum/BzwCkHHTSW11q61SFZnS9zI7nbb/dubyvZBmpqTxaK9f5u7uj2P
 ooHbbBroU448NXawMuJ7HRWMo51Y64x7WokPlYzyrte/YGNIgHwEKYSUG3jQqJz1QfOFBX7Dc
 KvXiogyzVmvpSzd7VUFugHAZoQFy19W6uXn/N1IZ69G9ht5sYUGzfX4+h6VDmcUBmyTbiiIbg
 4D6dqc71BUnZgHaC7K72xZTU6Sola8BTt6uL/gUBwlJWynqiSrFSwp2bS+3fOY4uZP29mQaW1
 7z4rje4oRnzUXXpN7ZX93zwWx9Zl4NORUtkF9y1xjWy4B3JyIfjOAD0EdCtvXL9SCrvCg6Nfu
 h90yIpQLTXDa6En6DBEJ30mG4oFmXw5DJbT9TyDl0qR5peHAIsbUQM7NGo18O+p+vU2kT+Rxy
 XWTzih8Thiv2XL8yuihKcTFI7+nkMV39/fDmB2YlG6yvLqU0XDElOZ/JGU/2DQNsbbOUw+2kc
 0GO5U5r/pk/Yc5OblwSZulEAkE3AV9JnlDBosAWAMsa0uYw/jiXQLeb7F3tCgxDW/RRRMHZsZ
 f+L9Rn+dfsKg778CuhhPyshiP0I3jbUez5dDSCXLKCAcPtyt4/vcSSUIROyZrckMXk5TL501Q
 L0Qwd1nJ+No/mxKa+d+ImDtZuGL18nCyEr/ZJ55Hg0wJI=
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

On 27.02.24 11:04, Alexey Romanov wrote:
> We have to compile efi_block abstraction only if option
> EFI_PARTITION is enabled. For example, if the user
> only enabled MTD_PARTITIONS, we would still compile
> efi_block. This is incorrect.
>
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   lib/efi_driver/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_driver/Makefile b/lib/efi_driver/Makefile
> index f2b6c05cc2..1fc85ce6f9 100644
> --- a/lib/efi_driver/Makefile
> +++ b/lib/efi_driver/Makefile
> @@ -6,6 +6,6 @@
>   # object inclusion implicitly depends on it
>
>   obj-y +=3D efi_uclass.o
> -ifeq ($(CONFIG_PARTITIONS),y)
> +ifeq ($(CONFIG_EFI_PARTITION),y)

The symbol CONFIG_EFI_PARTITION is not related to UEFI. It provides
support for GPT partition tables.

efi_block_device.c provides support for block devices provided by EFI
applications. This should not depend on GPT partition table support
(EFI_PARTITION) as it well usable with other partition tables too.

I would not know why iPXE loaded from an MTD block device should not be
able allowed to provide an iSCSI drive.

Please, drop this patch.

Best regards

Heinrich

>   obj-y +=3D efi_block_device.o
>   endif

