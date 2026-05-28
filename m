Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3ECD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 16:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76B0846B4;
	Thu, 28 May 2026 18:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="fu/NlbM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CFB846CA; Thu, 28 May 2026 18:28:41 +0200 (CEST)
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net
 [46.105.78.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52C55839A8
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 18:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director1.ghost.mail-out.ovh.net (unknown [10.109.249.114])
 by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4gRBkY687rz5y6V
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 16:28:37 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-t9l7s (unknown [10.111.182.101])
 by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0B38EC0EAC;
 Thu, 28 May 2026 16:28:37 +0000 (UTC)
Received: from armadeus.com ([37.59.142.112])
 by ghost-submission-7d8d68f679-t9l7s with ESMTPSA
 id mItDMTRtGGqpQB4AP1XAxA
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Thu, 28 May 2026 16:28:36 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S0068dd346c3-ad2e-4408-a703-68475037b4c7,
 6EFC05AAA153AB5D2A4F3C959A063608AD99B318)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 92.148.202.169
Message-ID: <dbadda18-a2fb-47e6-b9f3-d27879e24833@armadeus.com>
Date: Thu, 28 May 2026 18:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] serial: lpuart: Fix RX FIFO Enable bitmask
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@oss.nxp.com>
References: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Autocrypt: addr=sebastien.szymanski@armadeus.com; keydata=
 xsBNBFNfZLEBCACv1lqSePHJNpRgcnER+3emy+Arjz84zFax3XkogjY/e3ZneihIgWrVKe5M
 ql16pX4KTkzNgMUKz4bG/XwT3kjcrXshxFLlg7KrHMl287C+W+QOUjnjVeRi/su+SPmjz8VD
 yr11h+ZkVLAWhS+uQJ93jy1NwG8M4t1kBLAVHHD5Vw4FJ+3ouaVYIp1X1Cr8bVKQw33Q1aTd
 ro0kMBb96B9vNu7ciJZ3gvlaBzUEKOgNnq9KaywuLnqrqr4HUIn5JuxZjCjJzt9kTAKcTfp2
 cJM8qpp+2FF5qtbkse9fZ6M64qozgOPr9Tk4Amf9fZEUQ6UNw14mmBZuXSzoHe75gI7TABEB
 AAHNN1PDqWJhc3RpZW4gU1pZTUFOU0tJIDxzZWJhc3RpZW4uc3p5bWFuc2tpQGFybWFkZXVz
 LmNvbT7CwJAEEwEIADoCGyMHCwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgBYhBJwGygpYm/1C
 /GCmwbCaKeiBMmTiBQJdhIHLAAoJELCaKeiBMmTixXIH/2W3kbzRG0UF81jtRRnp0H83rjDT
 v0H+8fgFMRL/7HCJ1QPArkfRJlM2wlJkN+ChP09CCarYfUEHfRCHlTb7At6Yyrz1jziD7ZwX
 8IWHYRXnZkY5eZc5DsiUgq6JH49kt+GPzK8UVP9MTa6zkBpPCUf7LzZ4pD3FihdkT52BU3gI
 d9P49fSI0TYySlb/VKn815aOhvwEr7+Dh3mZUjSh7saofbRmVUOr7p+R3MvvGI19/IJZjeOE
 ZWliODDOt6HnBOtoGSXMcNIFF6snH52D5N5gY88njZjTwhgGGUBix1bsgf/EY0v4R5itZBXB
 B/Ze4Tm++YHaB75hZK6PQu/YRv7OwE0EU19ksQEIALo7jhXddrXBTRu5SAjelV53jyHBJTX/
 vN4nL/VbbW/saca+NJjDSxx5DBmotZbQdWIyZiSIjU/xnTREvtDrl6ZeSsKWd7ZqiuiY4fSR
 zwuQp9rd0yqRuxesrWeyJB1zCSdEvLyKASERt+nxkOA+IzJ4y1qLtvnWr+SL1AXgTMw+Tkyw
 KIDCRWHTIYas11ldGj82gOIpYeXnapeNLHfT4EQwg0NeWYHynJxAQWiX5aPlw0uSpAQSsBXQ
 FIe3fpoveMSnXK+PG2BBOzexYv7r4S70a6sF9sgTTPpfKqUaqqC+u1+bUX6alTAKhGKJywaF
 6ViqLlgY8PfwohSyAlqlTRMAEQEAAcLAdgQYAQgAIAIbDBYhBJwGygpYm/1C/GCmwbCaKeiB
 MmTiBQJdhIHSAAoJELCaKeiBMmTitU8IAK7NQM3fEwaF5XaKtepYWsVka44CD8A9e4r7NVK9
 ugirKvXirIxBSDmN/Db862NmVpITsZ6ERNSNZLm/7k55N+TexKYiFZeU7G92TEfAM6qPElvx
 DLEcrkNMq9r08YZeUloacsq31AL5fK4LW+xdvXudkdiKRMJsdTpmff3x5kIziGOHjwFP9wve
 ZgEH52gpbRsP8Whx/Z2lNX/BBRmFM8OnEXFsjjqDzYThdxTq85wGPpkgvvUGyPNRD7TpbB1C
 pajOUUkPxgj5LKt77HD1afeZNudWhgcdkbtT5PMQTT0WY6wvMEj9S1+bGPeXRGWLYB7gHQ+L
 JNoSD7Kz6Y9qnKo=
In-Reply-To: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 7869195927578728001
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFx5tNvnyMW2rM0xSGG/jEwClSGcI1prkVRXW8Bee4SOEKssdJeeskTmoxpUrbJIOQyNtYOKvnGiOV7xIjREkX9bpHRUNVPasiRa7WRfcL6qZegRpTr+o2KLyznL8/zOXTenBqTDQVOOsjZsrpGEIJX9YGG/sVXlCKGK8DRC9umMvjOUKJsiGV6RVM4TbER3/C9v+GrVgwfMlcdo8eNWhf/IShiGOX0pPiSrtTMjZr/W7zY2BbclFZxrZ/pHVtyFmol2JTboe4CjuXtWlIym9LgGSymy406CwB7J2NNGicok4kptsyR0oSD2/FKiw+/+t1f1HLJBj+x4MR4BJQPUxh8Unx7x3T061Zei067UM/3FjFcD/nO5JrXUmJrjfSc+hzSF1JOvbXweMLeBDRpdLyedodVLETteB2yzNCx8JmOYIOtAMi0Q5snKMVOgg3UBH2jvvGfiGHvBnIkyYveNwMmISqrAbTihwU7ld1+EfbPxDcqNrjz4cnlB2o+zHC8oMRWpOWwWBBKQODIbBhKwJ6AMZVoFsFKJj2pG4XgeWRnsfoQhnVWRVeEwlFfz199Rf86h6gwTweU1uS/YlV7DYnY9V3EwxM7kAF5QEdrwBzDFYul3I6qnQNUrNDr4RzqQmhPxcfwcBo7qWorh+S/51/Lwc2Lgr5E5IPT+mW91/eT3A
DKIM-Signature: a=rsa-sha256; bh=JzOdntE+6s1gIWL4Gb4dLR78bTGvCv0SlTGAgr8jzSo=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1779985717; v=1;
 b=fu/NlbM08AIKt6MaR9unE9uWwq1e3cVov8S9VO4z1w8m27hhF3GZLaQILidPnya5j1aJuK8j
 BQf79u02RGLnnct3FaI5RCIYYs+amHLsbPlWJZOBXeUP2gEv/IGInjnA+sj+J3Vi9Jzv6ZFjp0W
 b7BmDb7vbNbAoLM0fBakzkpGQHlAlki4FS3v9V7bU/F8i4x47Cm5GOdaHfsm1yAHc1fuRFaJFzz
 +6s5r2yfZTlMKMKv0V+caKDCzQEH0oaO7CvVtnU42fZ9unXcnRvm9EsCmN/1WfHfP2lH86zHEyq
 LnEqINGJvawqno5Gfbe4oXTR6Sx6mElx7X9YeSgfy48rA==
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

On 5/28/26 3:49 PM, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The Receive FIFO Enable (RXFE) field in the LPUART FIFO register is
> bit 3 on all supported architectures. The define has been wrong since
> it was introduced: for non-i.MX8/i.MXRT it set bit 6, which on LS102xA
> is read-only-as-zero, so the bug went unnoticed.
> 
> NXP confirmed bit 3 is correct everywhere, so drop the ARCH-based
> selection.
> 
> Link: https://github.com/nxp-imx/uboot-imx/commit/9498bcc514737269bb0ca436f775460741ab8199
> Link: https://lore.kernel.org/u-boot/dc163ea7-9063-4dfb-a39a-e643c0bcccf1@oss.nxp.com/
> Fixes: 6209e14cb026 ("serial: lpuart: add 32-bit registers lpuart support")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

-- 
Sébastien Szymanski, Armadeus Systems
Software engineer
