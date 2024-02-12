Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230BC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0989A87B63;
	Mon, 12 Feb 2024 14:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GzyniFOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F34187ECE; Mon, 12 Feb 2024 14:20:25 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E188718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707744019; x=1708348819; i=xypron.glpk@gmx.de;
 bh=wKaZWg4Ka/KHOOIErSMZWO7Vgk5zAqvLBNnhC4fL3jg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=GzyniFOBWRuhh4FGSLhIO5ApK+dU3UVtuvX8yX/5s4Ag7Flg2KOoot4HtqcbQW3m
 +QRZM491U3yDY9Esh9PNPAIUlN3VA0kWvKGog8iNH6iaZapVNCkuuvM5NWnAlMinu
 qEgPVQl+etFk6Hr40QtPceaSkath4P4Qs78O0uZ12ku9O8qvPaw/mNVExDdS47G4F
 xKjElAOYWVLgqhMi6a6NmLRRs+kEtdil6nJ22AflAZW6Dv2/Plavv+B1l+T1OsWT6
 WSBMaTsn/RqXCA/oeCmb5SABBq8O8yffYMi0mA2etEJL0jE2ycbb7cIWduFHgK1fm
 9nroV8NBXsC1EqsmmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6qM-1r8Bm30lOW-00lUex; Mon, 12
 Feb 2024 14:20:19 +0100
Message-ID: <f9e16975-2051-4c17-93f9-674e6da2009e@gmx.de>
Date: Mon, 12 Feb 2024 14:20:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] efi_selftest: Add symbol character selftest
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-6-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-6-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i2z+X2m/EIrbVx6lU/nOVz2iSfXs8TDPx4cVIIPGfB7EGMdO47B
 p9MtYokx753MNlPVAGYilWx/bAGv3223H4iqkYp2IMHwqKDpQ/SjujdQGkC+rzw6fsb7C49
 CVuP8OuwYslqo+jURcPPMpvSc5U0l1VKFl+Ui/v7HMgwt7t20FNC324xWpygc8rnfKmr7Vr
 mOMmIJj/m1WiXnhdYjclw==
UI-OutboundReport: notjunk:1;M01:P0:PzdVyQ5h1hY=;qCvL06y3flBpjlbcvcawM3I/BNJ
 lrieXgi/f91MNpY3r3UfYoizWMDmPMkZ1hFsuz9Y6oRz3VULAf6GyDGgc6nWpvKX/+BgT/0mw
 zRoRLSw8vqX5cIT13rVkuzIRNk0tErVXcGde2Z9lPqhitsOue3i/0fjnN2hlJ2x85svChfxIS
 CuODT4LqOVGFfNQ7HndZLjxiOj6D9FV3cd2fbw21GoKlh/9kSspmfxES3HjCNlz48+A8jBSZy
 K8a22FvH8ovFiKP++8a6ZCNaA0AZwg+QyOmnLHFdRVXqu8EAqYb8aXUY86NMqaGXF8TF7TrvF
 v16bx/ea4wNJU0Yh26wAYrWrpR1WGoQMF+AqdWO9JcnAM/XwCH8tILlKq/lDHkoif0EJLNOMD
 YRzwUbvyyBGso+7kLmLLlJ3+tWJ9eAWdxxH4/NOc555HMFtgEDg+ULgIVuRC8bxWw6AY+wmnC
 J9Hj/ea7SaZ2kqvJe1eEBNgLrvPNBXGtV+9EatMFX8d5LflUhJpJLoZGEp3vlXs2IWT3PGo96
 /hl834ZG8Asejki2jrJdrcrVR2VyioiGUSkTXVlU0JkvTLFQDD8qSUUZQeGyfxeDQ1JP3dOj4
 pKm4Rja0bxgjVnIW1vGI45uro0oIyFYSZxs2YYRkMgpgEvddWYlugOX1wQtHvLWTFw0E+AOmQ
 Svke1RyOxF71LqnOSNYO0HPdS6Pj06Iw6UmXIyyxyxDfOShS7PX1Hc4wnF938zfoQ7mftqhNA
 qa0BaIqdOAebgJVTpfZxeelhmLQ52zHAMZpe0oiCmZENHik++iHvuq5c1cqPv0sAD/u4Votqa
 Rbu4LpjMi+OLWjFS3PQZ7py5IpI55JtxjpyKbLwyjVFOQ=
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

On 10.02.24 13:46, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Draw symbols from code page 437 code points 0x01 - 01f used by UEFI
> applications to draw user interfaces using
> EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.
>
> Add a simple test to displaying the Konami code using symbols used by

The Unicode standards calls page 25A0 "Geometric shapes".

Konami is an unrelated brand of 'Konami Digital Entertainment".

> grub2. The output has to be checked manually on the screen for
> correctness.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_textoutput.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selfte=
st/efi_selftest_textoutput.c
> index cc11a22eee..9e5d944fa0 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -46,6 +46,8 @@ u"left bottom \u2502 right bottom  \u2502\n\u2514\u250=
0\u2500\u2500"
>   u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
>   u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>   u"\u2500\u2500\u2500\u2500\u2518\n";
> +	const u16 konami[] =3D
> +u"Konami code: \u25b2 \u25b2 \u25bc \u25bc \u25c4 \u25ba \u25c4 \u25ba =
B A\n";

If you want a human to check the output visually, how about:

Geometric shapes:
U+25B2 =E2=96=B2 - Black up-pointing triangle
U+25BA =E2=96=BA - Black right-pointing pointer
U+25BC =E2=96=BC - Black down-pointing triangle
U+25C4 =E2=97=84 - Black left-pointing pointer

Best regards

Heinrich

>
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
> @@ -144,6 +146,11 @@ u"\u2500\u2500\u2500\u2500\u2518\n";
>   		efi_st_error("OutputString failed for box drawing chars\n");
>   		return EFI_ST_FAILURE;
>   	}
> +	ret =3D con_out->output_string(con_out, konami);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for symbol chars\n");
> +		return EFI_ST_FAILURE;
> +	}
>   	con_out->output_string(con_out, u"waiting for admiration...\n");
>   	EFI_CALL(systab.boottime->stall(3000000));
>   	efi_st_printf("\n");
>

