Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37119C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8886288DFC;
	Wed, 24 Apr 2024 10:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dYbfMi4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E6B88DFD; Wed, 24 Apr 2024 10:23:16 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42B388DFB
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713946993; x=1714551793; i=xypron.glpk@gmx.de;
 bh=pn5KAbzYpDFBJgm81bov4diWNbK05orPHOW3Z7oHNp0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dYbfMi4JDKEx2BEUrkxyrRus32W2SGDqKsx5vceGyDKyEFZD0wQN3cSI6L/nkk3o
 eTyDMz0UKBIVjVHI0cEu33UU7U24lCPSL1KG2mvr9ZJat73Ce52pfErFl8uUA9ZqZ
 wDGelZ7RHAenRq0mYvjoU0Ur9HwkMCurO/pUibUg7Srcpa5ce6ciGHX+DXUak37d1
 UdZmbGfRsJQGSHkPfHgey2uSlAtwKoiJJ2H3oK85z1DdxLqDYlxrixEu+w1/2ean8
 7NzaVRBlc1jaIt8Sy/M8sGju3sbu82aXb9DMQt1pp/VHiMZg/y8OvZHhoTAmS1CBP
 Zw3xDdUpwCXsW+J2BQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1s5cRj1o1O-004ucl; Wed, 24
 Apr 2024 10:23:13 +0200
Message-ID: <4e613d0f-dfa5-427f-8f95-8a055a33d86c@gmx.de>
Date: Wed, 24 Apr 2024 10:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EFI payload in 64 bit mode?
To: Philip Oberfichtner <pro@denx.de>
References: <Zii63ehQPa3WAAj0@eryximachos>
Content-Language: en-US
Cc: u-boot@lists.denx.de, sjg@chromium.org, bmeng.cn@gmail.com
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <Zii63ehQPa3WAAj0@eryximachos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lat07NtAMZDippjMuVwXjZFGN2RatUZVFvFrTk2sp7l1aoiVmca
 Cx0cQC6bIIOi45tJ42cIqAHPzvOdM0fn7pwfPe6EpWiDLvUBPtOWcW1nYmodBmN75lUwXEy
 kU8YgmoIcRx1jyLaS8JG7xRZfmzpSIGi/M8jJm6kE1LkZDuEaytITeXy30LljKw8k6IhHLN
 +rMfRcGseWsrPIjvy1k5w==
UI-OutboundReport: notjunk:1;M01:P0:HoQcD9a8xzY=;A16nFKg0MiBnU7jqq7ST1eYS3Bq
 W+j919Fhq8K4/ytqmeqPt93YwygCQ0hF423+G0KnkKgktwNKcBwtXQ/mhLLJoPjOuX3pUF1J/
 +d0mdYkyGJz6mOjixMzKEsFAKoXlMPzekuiqLTnT145ht0Ov/L2kutJ788AF5wAHW07Uwg5ad
 dzvwjbftLXoI53lOqKfCouHLMj1z2P+Ne43+R95J7l35iUPNQSn1r6s/zOOR02bmEiCZvRlWw
 coetXT4rt5iPhE5wOd/6L/EkTT303BwfA1IJrUmYQ7fgs0iHhUA8CYpey37TXb5UdsvlJNiOQ
 yiCBdQ2rDMhhcjMo9X9hMWU4JJxGqku4l1XWGzvu95xT4Yli62HsB9NKRMle0bZKQE1fPdUeq
 cnrvWF1gvS2A4fy66q3SQpXIQDTMLIHwTS/N0bUkMuWnNHZ3guRXGsHd8KtZ9OeEr7MgHW9di
 k/LwG/NqmDMWEID4dPIzZplbRl8czpByZizPNampFK6KJJ6AaC30XZWNbr6zEtEXA78PN9qpQ
 XXSk7Uw8u/ABDjs+LLFAaI/+TRfSxhf1DiMiRROyqa8wQbG4WGkiAgbAV6I4r4xHoRWdU5ApH
 aKHyDKuHZCPntfFJ/smsGzYoooLDn1xjOqp+kxEoOE9nga+Mne0YHVyycgzC5adlABqBR3hSr
 GLbL71UNG9xo89D4LTz83l7t/uNeYhx1M2ZHpi489nYoz6F1Iir5hfYt+iYGJLyxlomH0GAsj
 mFWrQ32AqhNdQklSx2pRDCuyrIB3ytN4TKEW5UzDhMhqRrWCJFJR0lnOvjC0ppeYzNWCkL5rU
 G6frD7o6tgReSUjl2pUvkOnLKbOMF6CLvRxvg4O1j61uk=
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

On 24.04.24 09:55, Philip Oberfichtner wrote:
> Hi,
>
> I'm wondering if it is currently possible to have U-Boot run in 64-bit
> mode as EFI payload.
>
> TARGET_EFI_APP64 selects X86_64 to achieve this. TARGET_EFI_PAYLOAD does
> currently always switch 32-bit mode. Any hints what would have to be
> done to get it to run in 64-bit mode?
>
> Thanks in advance,
> Philip
>
>

There are two defconfigs:

efi-x86_payload64_defconfig
efi-x86_payload32_defconfig

efi-x86_payload64_defconfig builds a 64bit EFI binary.
efi-x86_payload32_defconfig builds a 32bit EFI binary.

The essential difference is that one selects CONFIG_EFI_STUB_32BIT and
the other CONFIG_EFI_STUB_64BIT.

U-Boot itself always runs at 32bit because CONFIG_X86_RUN_32BIT=3Dy.

To allow running at 64bit you would need at least need to change:

* jump_to_uboot() needs to execute a 64bit call to main U-Boot
* CONFIG_X86_RUN_64BIT should not select SPL if TARGET_EFI_PAYLOAD
* the definition of the global data pointer needs to be adjusted

Best regards

Heinrich
