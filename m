Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9D7C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 07:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2747F87CBA;
	Tue,  5 Mar 2024 08:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="QA8F3jaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA1787D06; Tue,  5 Mar 2024 08:34:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42BC787BA8
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 08:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709624067; x=1710228867; i=xypron.glpk@gmx.de;
 bh=EGf5D9HdSUjTaDP8ax7kkGahueQx18NPrggsP/Ga4yc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=QA8F3jaNam9/fm/JVSfSjzEt55sqACl6Qpv8r56loEqAESc6OQllbstUHScpiRkR
 e6ZyXvG7tSqmUlU+nwjabwfgJUNFnoKbANZOzo0MXkMZujpu+MeWI8NEuYdyspcS3
 u0ZunUzq5v3rtZgPB7zaM0/JZMcXzTKPtQrEKWbhVXi3/K6M5Ny6VkWf2kXl8kWV8
 TeEXklOUG0gNPDwyNA9QQJEM7po4MK80MQbkbPbn4vMa/v2IZ1yJKcMEMOXK5ZWEj
 xt7sUNnaComtrEIL/C06q4GmMu1fKzhV6u7LrBprJ1JXdN4V0f7oq5O+Uy9rYJrL0
 xfzKN8OpEolkCXoabA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.176.242]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1qjpcp1KVU-01216F; Tue, 05
 Mar 2024 08:34:27 +0100
Message-ID: <da2c1e6b-95c6-4326-a353-3ed32c524b40@gmx.de>
Date: Tue, 5 Mar 2024 08:34:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] riscv: cpu: improve multi-letter extension detection
 in supports_extension()
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Chanho Park <chanho61.park@samsung.com>, Bin Meng <bmeng.cn@gmail.com>,
 palmer@dabbelt.com, u-boot@lists.denx.de
References: <20240304232835.3076533-2-conor@kernel.org>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240304232835.3076533-2-conor@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P3RYrGBiB9Plq8KOsYwn1noTikxFJiJFQSWuirh7TLDqUI8CKzb
 map8uzLRnHdA8s7YKoAyUKdPNDTJ9c/XTciw2l/bJswW/El9yqVLV5lzGJS0T77LYmdmLsI
 RUFEBgMouubEy0a3aaEgsUyzKeh6rJaC7L6nHe7In/X5QhsN3pebHj5+kI3PZL3Pxi/1Tuu
 gz2uBCbyeVqvCa5ZSe/0A==
UI-OutboundReport: notjunk:1;M01:P0:JMAXTzzFreE=;ilWLdmRcLqGw7PHlOZkb/RQW9DI
 cNKpWLTTXzYt7r1xUtltLrb4IqS8MmmUfcXerTaU+qxsikZ7Gg1/P0fw/Qqri7+bKfYep9ZIp
 2DaatnCt+ePw1huTuWwXfu8kNMlNivH3R7IdgXyV6oCxua7NX5ff7cMF11VO9fTmgt56GJjOx
 0IVnsRqCQebeSMXX0LjZCV7fJ1slDSAMy3QqBIvEe10DWznJTEMQGBKT6GalwOWknTKF/lKRj
 K0/taHEUHPJixfOigusL3voG+aXNlpdJDWWdedgBPPh0IAGXoxrt1/il99bscnj3gOpUpP/UW
 9eyPGuBG/vHjz+qHhuoZuGHXvjjwUEpCc4GXvJjHW9/5+qEhJb/0lmWkiguRB0mCEVU7bmRYR
 jkYhrYRWDlT6R4lnwIqCxfFdGYdOIKTN47I7eSsu4YY0bDf+9jXG37UwfNaoFSmmAXqipWaU7
 3VKwqwCb2oMZbCI5Y5j3TGl92Tt0q92EAmwhAcpOkbvFALpS2Tm4OhFDLmdR1jXbBG5fnCQaH
 0HsZ8fUGLnjnbKGwbdm8w1tJi3644PgmBnFVTrjeHBOCWaaTH3yldK5fiF3v+antLZRgYzutj
 EKAxC7AxohcXjm4KoEvnBdYocnNS73/auvjLvfUCwICkDO6/Ih1ssF5ZQ4QO4C2w+cyfLcGSB
 cpp08TBHe7ooxlMEHEuhY9vLlDDFf3nFRewNj/MSJsVcX6vRweMaVZSOE8i6bUuhbKKmxaIsP
 sh3q45cA4cgLBmASRdJYtmryLLGuXpejUl+htN94hLTQsnwlrI/Ax+kiTVGz9FFBCIjzcl9Ko
 KWmeaWhntg+Ymr3+rI5t8pvyY86IN2lfKlfivhElv1o18=
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

On 3/5/24 00:28, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> The first multi-letter extension after the single-letter extensions does
> not have to be preceded by an underscore, which could cause the parser
> to mistakenly find a single-letter extension after the start of the
> multi-letter portion of the string.
> Three letters precede multi-letter extensions (s, x & z), none of which
> are valid single-letter extensions. The dt-binding also allows
> multi-letter extensions starting with h, but no such extension have been
> frozen or ratified, and the unprivileged spec no longer uses "h" as a
> prefix for multi-letter hypervisor extensions, having moved to "sh"
> instead. For that reason, modify the parser to stop at s, x & z to preve=
nt
> this overrun, ignoring h.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> The parser in U-Boot only supports single-letter extensions & the
> single-letter h has to be at the end of the single-letter section, so it
> would not be difficult to terminate parsing once a h is seen (you'd need
> to support the hypervisor extension to support additional hypervisor
> extensions after all) if in the future a multi-letter extension starting
> with h did come about. I've got no problem adding a special case for h,
> but I'm tempted to just remove the multi-letter h extensions from the
> binding, given there's actually not going to be any extensions ratified
> using that naming scheme.
>
> CC: Rick Chen <rick@andestech.com>
> CC: Leo <ycliang@andestech.com>
> CC: Tom Rini <trini@konsulko.com>
> CC: Simon Glass <sjg@chromium.org>
> CC: Chanho Park <chanho61.park@samsung.com>
> CC: Heinrich Schuchardt <xypron.glpk@gmx.de>
> CC: Bin Meng <bmeng.cn@gmail.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: palmer@dabbelt.com
> CC: u-boot@lists.denx.de
> ---
>   arch/riscv/cpu/cpu.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index 8445c5823e..ecfefa1a02 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -49,14 +49,24 @@ static inline bool supports_extension(char ext)
>   	}
>   	if (!cpu_get_desc(dev, desc, sizeof(desc))) {
>   		/*
> -		 * skip the first 4 characters (rv32|rv64) and
> -		 * check until underscore
> +		 * skip the first 4 characters (rv32|rv64)
>   		 */
>   		for (i =3D 4; i < sizeof(desc); i++) {
> -			if (desc[i] =3D=3D '_' || desc[i] =3D=3D '\0')
> -				break;
> -			if (desc[i] =3D=3D ext)
> -				return true;
> +			switch (desc[i]) {
> +			case 's':
> +			case 'x':
> +			case 'z':
> +			case '_':
> +			case '\0':
> +				/*
> +				 * Any of these characters mean the single
> +				 * letter extensions have all been consumed.
> +				 */
> +				return false;
> +			default:
> +				if (desc[i] =3D=3D ext)
> +					return true;
> +			}
>   		}
>   	}
>

According to
https://github.com/riscv/riscv-isa-manual/blob/main/src/naming.adoc the
ISA string is case insensitive. Why can we assume here that it is lower
case?

Best regards

Heinrich
