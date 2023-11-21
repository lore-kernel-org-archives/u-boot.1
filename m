Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2299C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F239D871F0;
	Tue, 21 Nov 2023 02:20:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="G2V6ASff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA8B8757E; Tue, 21 Nov 2023 02:20:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D6E868AE
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700529599; x=1701134399; i=xypron.glpk@gmx.de;
 bh=U6hcF3sBl7KAdY5/EN9r5k9uqsEionmGnswTrJXoPh8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=G2V6ASffbBgGsDwgIgHFBXMP83coDPr9ZKfRIi00b5AUaQZ72UFfTudy76/tt3HV
 9lMTQ8Ftyb/2sM9GM+QFz93bXBfEE6gH7JS2pc+IbxegLR/JKs20ulCpnj0HdP7wV
 72CiUKGpwMjvC7gyboi0x0tX/XW5jywJ+5Ojd7/c/GAMsnojGTM1qyUv6mfEMh5Sd
 LViaXxHfQrgshfSqlqbJ3XM0VJATOCLtJmvUntXnH9F+pARKZOW3rFoUxpsu9cyfE
 RtE1YyY7F1n7w/gf5rAqHrkaM5HWcJOwFCam4sHxj+eY6pHjymAPF/wQo8XYZEy81
 fXCu+9oZWr+D7vS1Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1r4Pwx45Cf-001SkE; Tue, 21
 Nov 2023 02:19:59 +0100
Message-ID: <777a1d08-708c-481e-bf90-46d7a9667b67@gmx.de>
Date: Tue, 21 Nov 2023 02:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] smbios: Deal with tables beyond 4GB
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20231008213646.622002-1-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231008213646.622002-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FidfI8+K4/QtMSYrycgKSa917T63Pnd9BPf6cbaciHcrTlOjVDr
 3pE+wXHo7DeED5sCy8yeJGPguDlfjAUlfsJC/ZFEnaQDIkv2El0BFwRKUI1a7HtRJt6lkS0
 esOEkCxzDkfMMTQU1VM4Q9+23Aqf6IPFfCMrILHr0pwZgIgWeBe7TFNwJcCByzwbtXkGiEb
 eRjFaTSEFue1y3Eligwog==
UI-OutboundReport: notjunk:1;M01:P0:mXPH8KX9z1U=;DLd7truz6dZ3fsT/BeTzzCKcOS+
 +wUxDKaM/v3L/p+sFY/opkJT5iEO/QcQKv18h02AwmnvAwwiFtwhELddY8KqZyYDCBDViCHXm
 kks0JpM6rZf2FHEd4IgQ/44GeI44ytovZ9kzSsdD7Yuvyzf0wH1OS7jBelFzlFhcsYh3zO0PJ
 BaEurz3G2HhljwQHDLGqqkEOXUAqOG1EneHy73P03TBdP9Tp7lX6tgSxJO7T8Gsy8iEE+jNRo
 acnhcg7XvfHNBUgVDEDeFJsthVaBvHSFqE8+FiOqc3BHXdaCOlCZnOQjqNnJ+HbbBXK/HCiuJ
 CXOA0MHU680tY/3RKz7GUKd3kKdriWSsbVCaW9Hp4Xzl4FtVUnjkKQt0rSzgc12AFm/fnLUwZ
 lbnkEQFN+PYwnx7LRn8jleqrezmN7TN8TQcV5vFAdxRD1MA+yjViUBnfiIrsd6Bk62Tr6Ceob
 vSUG7cLgnuQOyl2IdMiZOG6jQUUISaB21PxhU8CPmR4e/e+odsi7qIUTzmugOnrdg0QBvWZIw
 n2dDcGAekceUSBNKe+6pyLOt5HwfOitDAEewhIv3x+TMuC2RVVZm+24/bdoaAEC8+DOvDBEkL
 Wj8Y9dViNUTBwNZcDdUanfefNINjj3OnziU+d6eZxynUwULKAxB3+H+JvVazcTO1U5N13dPQS
 pPvzWBbAzzMsAK3dl7KJH/PRyex+gDfxz147CJcp1LEGCid+KxLU3UJyPWOyj1bpReuUVb8wd
 sf9RW3PD0ppeKcBdH8wTxZc1mkG7eJdJl4T6A9TGiRRQFi6fnevbu14xfcSWemP+YfkoijwFr
 g/9ynMVp0+65ilUsAcfBK2Tra8hmOQBr3bOaydIPYMC6e9N4vvcrBkg1Cg9l4jEDm6pntzk1/
 lHEUcPQB0KbxzFINOO1ERHbKTfzWlIiJR+lpDbiH4osKnQXq4zgXZ8pvvXFACAbnZ8438IP4K
 HnoKkg==
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

On 10/8/23 23:36, Simon Glass wrote:
> When the malloc() region extends beyond 4GB on ARM we may end up with
> an SMBIOS table in that region.
>
> Add support for writing an SMBIOS3 table, which supports a 64-bit
> address.
>
> Note that this problem does not happen on x86 since it requires the
> tables to be placed just below 1MB in memory, unless
> CONFIG_BLOBLIST_TABLES is enabled.

With this series applied on qemu-riscv64_smode_defconfig with 8 GiB RAM
I get this output in Ubuntu 23.10:

$ sudo dmidecode
# dmidecode 3.5
# SMBIOS3 entry point at 0x27ef28000
Found SMBIOS entry point in EFI, reading table from /dev/mem.
# No SMBIOS nor DMI entry point found, sorry.

Best regards

Heinrich
