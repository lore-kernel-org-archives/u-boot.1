Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C930BCF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FED8397A;
	Wed, 19 Nov 2025 10:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="R00WflOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B1783BD2; Wed, 19 Nov 2025 10:50:29 +0100 (CET)
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net
 [46.105.63.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B49D83966
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.254.119])
 by mo560.mail-out.ovh.net (Postfix) with ESMTP id 4dBGtp5qCyzBQ0Q
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:50:26 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-p58s5 (unknown [10.108.54.199])
 by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6AE8382CC4;
 Wed, 19 Nov 2025 09:50:26 +0000 (UTC)
Received: from armadeus.com ([37.59.142.111])
 by ghost-submission-7d8d68f679-p58s5 with ESMTPSA
 id tZ6BCOKSHWlSUAEAUOD7PQ
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 19 Nov 2025 09:50:26 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-111S005eef26912-a8c1-449f-b2d5-485f32d728b1,
 682F2C8CDA7D6035280EB8A0F2C54154D0B8754E)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 90.11.244.6
Message-ID: <6e0aba1c-85cf-4a32-8d7c-b57e7742955e@armadeus.com>
Date: Wed, 19 Nov 2025 10:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] opos6uldev: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251118180344.590898-1-trini@konsulko.com>
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
In-Reply-To: <20251118180344.590898-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10584022074612378537
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFogKhxPDKLUY9jcnRwJw/8L/kbSjHE4OR2wE9i7gh8+V9jvHro+Ubf1DLeRLOQRDEqtx8qUhIj7FY6DzRstaUHuiZfILfhvZzWtHAYT1+6qBARmqx8kkEhJeQyaCVf+oAkt4GB8uQzB4ozpIk/O80J7DGTiAGJyF7VrfoJFyKs0pW6eKR8F0laB8oUQ06EAzONJvTOu4U8PRCNlS98SMmHVZ3jqD2krlNtltnjAZi0BdcQbI3KdeEmVJyS4KfFf6OkNTfBbjySXGdrvfIXIJ09aq0D8hG5ztSgbLNTDEM93nDNYojl/nWhN6ZAlUmo36lOjYHXrxSv6xfYbx3uCRzSFiwKtIlcswRBLFHBLahRQ2XvyN54K5AesMhPjIImyeihgf8Xfcd2dQRpbyiFPC82TB7vXl3YLpKA8HNwyJYhrTFYLOfFaCVXTUXdk5yAp38Z7iIAoZx4CP2zI6HOyTFnqTkgL2cbZ4D01gV9ZgjtwjT88ZugYt8bCXBDR/k6mfsqN1wo7AvCAAZLyaiyfpakG7c7TTyXHfoFyFGOi2b4Sf+obwrY84lJ1ul0WPWTHbyvZ3eSj1ltkuX8l7nd4BbtFMyYp9G6Y9pelcHLE5hqpnxB7njqYLg6XObCo9rdL83GK/T1JmsniFvlMXg6dDe05q0de06uZ7i6bDgc4isCxg
DKIM-Signature: a=rsa-sha256; bh=/BkC6LFFNOY7DAlm0JZ6N2X5hDNGkWnPeC4bsGB44bI=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1763545826; v=1;
 b=R00WflOD/jJYyi7zgsFLphaVg9GSL0M3LYmcZ/j0M5dfWTpME6jSXVDV1v3+wfJzcPG+W2t3
 hRgiu+qhl5OgkKqHyWo/V+6k0/+9SWf3qFYsU13IWDqFYy2n+O3/PBdVHH9o5jjDtN9wBbxpxFy
 oAQDLwOIoLLU6j8St91+B7rMT6UpWifh7quW6cCl8E6fHp3Yr5gmkPAz7T9n/noZWlfgy997Ovu
 bNlumKWIOyQj4exd4lRMxz+LpJcsndxHvejqn4GbugxD4yudE5GaUcc81VZFnUiiyuVOc+Iuzd6
 Iiz98W+Av8Tlg7j04vcKnQgBrW1pMN9EaWhKx5tywdZ/w==
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

Hello,

On 11/18/25 7:03 PM, Tom Rini wrote:
> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If there is some window of memory that must be used for where the device
> tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
> or bootm_mapsize are the correct way do this. Please see
> doc/usage/environment.rst for more details.
> 
> Cc: "Sébastien Szymanski" <sebastien.szymanski@armadeus.com>
> ---
>   board/armadeus/opos6uldev/opos6uldev.env | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Regards,

> 
> diff --git a/board/armadeus/opos6uldev/opos6uldev.env b/board/armadeus/opos6uldev/opos6uldev.env
> index 2e7b65968d1d..463d0984fbc9 100644
> --- a/board/armadeus/opos6uldev/opos6uldev.env
> +++ b/board/armadeus/opos6uldev/opos6uldev.env
> @@ -10,7 +10,6 @@ env_version=100
>   consoledev=ttymxc0
>   board_name=opos6ul
>   fdt_addr=0x88000000
> -fdt_high=0xffffffff
>   fdt_name=opos6uldev
>   initrd_high=0xffffffff
>   ip_dyn=yes


-- 
Sébastien Szymanski, Armadeus Systems
Software engineer
