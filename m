Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90089C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:43:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7A54876E4;
	Tue, 19 Dec 2023 12:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="t+TeNHuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 601B0871AA; Tue, 19 Dec 2023 12:40:46 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D8787720
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 12:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231219114041epoutp01655a668d1bd1a3bf50fb2b5c28c6bc6e~iOMgbgHvh0497904979epoutp01K
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231219114041epoutp01655a668d1bd1a3bf50fb2b5c28c6bc6e~iOMgbgHvh0497904979epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702986041;
 bh=+kcRciN0He0XKzL5gJerLyNrcFJxil5/XH6LtE7qpug=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=t+TeNHuc61mbnPAyuOUrPbDgKy/WwlyfLxRaHyR8VUlqW15cC7H9eo+jIGgFQAxkR
 LDCMoVkjnrjukpuDo7eQge8k2O9fcFgH75vwO7+JvyfLOlP3y0XE7qG5tD+hspVJ2R
 ehefawWGzZICBDlwTDV4qznEPFEOYB+PVjUKR064=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231219114040epcas2p4bfcc6741d3dbada10638e9889ba9d158~iOMf5Kaxu1158111581epcas2p43;
 Tue, 19 Dec 2023 11:40:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SvZWX0dzQz4x9Pv; Tue, 19 Dec
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 94.48.10022.73181856; Tue, 19 Dec 2023 20:40:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231219114039epcas2p1d8cda6a426ca94b6cf74f0ef298f40e4~iOMe9oc0E2634826348epcas2p1L;
 Tue, 19 Dec 2023 11:40:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231219114039epsmtrp2a7c8dd52e3ba01a9e189608743c9bdfe~iOMe85UiT2345623456epsmtrp2O;
 Tue, 19 Dec 2023 11:40:39 +0000 (GMT)
X-AuditID: b6c32a47-9a3ff70000002726-4b-658181370948
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.E6.08817.73181856; Tue, 19 Dec 2023 20:40:39 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231219114039epsmtip268bfd5f8cb77a2b0d63bfbc8d3586ccd~iOMewcQgy2846128461epsmtip2q;
 Tue, 19 Dec 2023 11:40:39 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Sam Protsenko'" <semen.protsenko@linaro.org>, "'Minkyu Kang'"
 <mk7.kang@samsung.com>, "'Tom Rini'" <trini@konsulko.com>, "'Lukasz
 Majewski'" <lukma@denx.de>, "'Sean Anderson'" <seanga2@gmail.com>
Cc: "'Simon Glass'" <sjg@chromium.org>, "'Heinrich Schuchardt'"
 <xypron.glpk@gmx.de>, <u-boot@lists.denx.de>
In-Reply-To: <20231213031646.28828-5-semen.protsenko@linaro.org>
Subject: RE: [PATCH 04/13] soc: samsung: Add Exynos USI driver
Date: Tue, 19 Dec 2023 20:40:39 +0900
Message-ID: <007001da3270$30acfc20$9206f460$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
X-Drm-Type: PERSONAL
X-Msg-Type: PERSONAL
Thread-Index: AQJxF1WUQWvk8XWc6dZlUfJtoqni1wHpYgmjA0mXK6yvWRnckA==
x-delete-securityphrase: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmha55Y2OqwYyPNhbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
 LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
 F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnHHjWxlSwWLhi5emn7A2MN/m7GDk5JARMJBa/3cPY
 xcjFISSwg1HizPR5rBDOJ0aJ5etfsEA43xglLky7xALT8unvDGaIxF5GibMbrzFBOC8YJf59
 384EUsUmoC/xsmMb2CwRgbNAg2+dYgdJMAvkSczYPwPM5hRwkLhwaAZYg7CAncTU/9fBVrAI
 qEpMXfMTrIZXwFJi35kWVghbUOLkzCcsEHPkJba/ncMMcZKCxM+ny1gh4uISL48eYYeIi0g8
 XP0Rzm69dxasXkTASeJTwyRWiLiUxOzXL9lBDpUQeMMhceDhFqg/XSSWTbzNBGELS7w6voUd
 puHzu71sEHaxRFfbJRaI5gZGidPtV6CK7CV+3JwCtIED6CJNifW79CGO45PoOPyXHSQsIcAr
 0dEmNIFRZRaS12YheW0WkndmIQxawMiyilEstaA4Nz212KjAGB7fyfm5mxjBCVfLfQfjjLcf
 9A4xMnEwHmKU4GBWEuF1WVSfKsSbklhZlVqUH19UmpNafIjRFBjYE5mlRJPzgSk/ryTe0MTS
 wMTMzNDcyNTAXEmc917r3BQhgfTEktTs1NSC1CKYPiYOTqkGJiOdvfN2nc9x3pSSKf+Kx+XE
 31Sbjb0TrmwIy+2Pfc64y8c05dKvx+6qKSfZWn71ek7arPpUdPoLo6eSAZeOOJnKvK61il7g
 cvhJXsn+WwrFAj2SvfFsM0teTpokcEJRPtXL+2WKWtPyiPub3N9cPv68IKxhTr91UvkBdWdG
 R4P7vGmPs3q1BK7VaRTsLwiM1T3beLGraVbN1//PMr7/15p30XT1tIkKadurmULcGlsZLsiE
 KPakyWfvW/vsy0SG5MP/104+E2TJ/3F/1AWNdZxdX7clm5yXiz1a5R35wk6X9ZXqsvlNrr0P
 eN5f8lrocHGP0/fbJSG9c44wr9r4qyph0/0PIj+vO/nsOV4spsRSnJFoqMVcVJwIAJprlsxB
 BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSvK55Y2OqwbE/ihbP311msug40sJo
 sfXeBCaL5337mCy+bdnGaDF10mZ2i7d7O9ktDk/9wOjA4TG74SKLx7xZJ1g8ds66y+7x4WOc
 x6sDq9g97lzbw+Zx9s4ORo++LasYAziiuGxSUnMyy1KL9O0SuDIOPGtjKlgsXLHy9FP2Bsab
 /F2MnBwSAiYSn/7OYO5i5OIQEtjNKLFtzScWiISsxLN3O9ghbGGJ+y1HWCGKnjFKTPn5iw0k
 wSagL/GyYxtYQkTgIqPEmoadjCAJZoECiYvzr7FBdBxllGh7+5kZJMEp4CBx4dAMJhBbWMBO
 Yur/62DrWARUJaau+Qm2jlfAUmLfmRZWCFtQ4uTMJ0A1HEBD9STaNkLNl5fY/nYOM8R1ChI/
 ny5jhbn6z9G5bBA14hIvjx6B+kBE4uHqj3DfvDq+BS7eeu8s2BwRASeJTw2ToOaIScycdhlq
 vpTE7Ncv2ScwSs5CctEshItmIbloFpLNCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn
 525iBKcBLa0djHtWfdA7xMjEwXiIUYKDWUmE12VRfaoQb0piZVVqUX58UWlOavEhRmkOFiVx
 3m+ve1OEBNITS1KzU1MLUotgskwcnFINTPlTsy8Jhf+fIHnZeKJcBOslk34uB+MWN9E+l8ov
 Ux7GuhYt6Yi6Gr9rPsfC45VXGHpPztQ58uOJh77FkeZTmxarMq1bzVYp3Jbc75qXvOrknocd
 5zYE2agrpga+lOQweq8ty5P4+dHlXoWaX4p9OY8qEsT/+icrvhfqzFA9b6y7YUdO5rGozVFn
 F92fcfMUS8++rIhG/lsTWJK3i22w1tCenKGnV96gKBJ65+hHlZD7ZQvb1q49IXOufvWlzp9H
 2/fErp+qe8lIOeelcr3vLTG1viMhd48tEzoruJ7xluyr3oKdl5lNb9it2/G+Jbvd8UhuUNKB
 TA9GoxquEBZ2g9aoosf/Ytb7OPPo/XNUYinOSDTUYi4qTgQAVhet7HIDAAA=
X-CMS-MailID: 20231219114039epcas2p1d8cda6a426ca94b6cf74f0ef298f40e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213031753epcas2p3eef2d867e3b96237014830ee5311b3bf
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <CGME20231213031753epcas2p3eef2d867e3b96237014830ee5311b3bf@epcas2p3.samsung.com>
 <20231213031646.28828-5-semen.protsenko@linaro.org>
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

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Sam Protsenko
> Sent: Wednesday, December 13, 2023 12:17 PM
> To: Minkyu Kang <mk7.kang@samsung.com>; Tom Rini <trini@konsulko.com>;
> Lukasz Majewski <lukma@denx.de>; Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>; Heinrich Schuchardt
> <xypron.glpk@gmx.de>; u-boot@lists.denx.de
> Subject: [PATCH 04/13] soc: samsung: Add Exynos USI driver
> 
> USIv2 IP-core is found on modern ARM64 Exynos SoCs (like Exynos850) and
> provides selectable serial protocol (one of: UART, SPI, I2C). USIv2
> registers usually reside in the same register map as a particular
> underlying protocol it implements, but have some particular offset. E.g.
> on Exynos850 the USI_UART has 0x13820000 base address, where UART
> registers have 0x00..0x40 offsets, and USI registers have 0xc0..0xdc
> offsets. Desired protocol can be chosen via SW_CONF register from System
> Register block of the same domain as USI.
> 
> Before starting to use a particular protocol, USIv2 must be configured
> properly:
>   1. Select protocol to be used via System Register
>   2. Clear "reset" flag in USI_CON
>   3. Configure HWACG behavior (e.g. for UART Rx the HWACG must be
>      disabled, so that the IP clock is not gated automatically); this is
>      done using USI_OPTION register
>   4. Keep both USI clocks (PCLK and IPCLK) running during USI registers
>      modification
> 
> This driver implements the above behavior. Of course, USIv2 driver
> should be probed before UART/I2C/SPI drivers. It can be achieved by
> embedding UART/I2C/SPI nodes inside of the USI node (in Device Tree);
> driver then walks underlying nodes and instantiates those. Driver also
> handles USI configuration on PM resume, as register contents can be lost
> during CPU suspend.
> 
> This driver is designed with different USI versions in mind. So it
> should be relatively easy to add new USI revisions to it later.
> 
> Driver's code was copied over from Linux kernel [1] and adapted
> correspondingly for U-Boot API. UCLASS_MISC is used, and although no
> misc operations are implemented, it makes it easier to probe the driver
> this way (as compared to UCLASS_NOP) and keep the code compact.
> 
> [1] drivers/soc/samsung/exynos-usi.c
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Chanho Park <chanho61.park@samsung.com>

