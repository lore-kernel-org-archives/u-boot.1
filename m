Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF91C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 18:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5DC87BB3;
	Thu, 18 Jan 2024 19:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="O0yWZ6Eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98A5487BC1; Thu, 18 Jan 2024 19:48:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5850E87BAD
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 19:48:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705603712; x=1706208512; i=xypron.glpk@gmx.de;
 bh=bWJTZCN+W9008WVAIuxfIvsAz84XN2zcx8RhEGlL5oI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=O0yWZ6Eu3I/meLM4WIh8ch85rJBTZj5oAD3L0IN6ZMyUzY5RZIw8Ng69/QRj9ebC
 l20UqF21n+kE0rs8AZgwlNLCV4Yn0oB1o8J4hcoYbXYGHzRgCI5DKuvOF5MRzehVb
 XXGo+kmUEqiI2xZG8jld3AkkZkHoozBkDCl3NWetfNImyNYz6+8yNRXJS1J0GkAbz
 LPpSERDcNJrPO06m6Rl3zo+Ml7+ZQYxXLXDQ3xZeqffY+fG4lt65dn6sGG1sztvOI
 QOrfm8yn6ImBNUw3aSraK1P4YKh7PSGWbrK+GHwnIybsdqYOSF090r6BKy+FeliMk
 sxBWwv4+5l82J02oAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1rXakE2wEk-00TAwy; Thu, 18
 Jan 2024 19:48:32 +0100
Message-ID: <e49eb6ec-fbca-492a-aa7b-7f8cf8b0c1cb@gmx.de>
Date: Thu, 18 Jan 2024 19:48:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/6] efi_selftest: Add international characters test
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-4-539f7ce74fb9@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-4-539f7ce74fb9@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JgSQerRkP4sRwqSJCGeVc5Dstz8ny21mFveKxqnCQsX8INw9Nnb
 Ctk0/pMKI0lbSrOclvgMKnMV+eL+QLQGo/kEZJKLT8Djbkjnw2joLfxwhezyNvubJoy5kb8
 uiAfDdewRk3U8TwsCwkUCozuxvK0GCVrSjHnlq9NpttG+YVbT2uVzGit5AvVnJsB1SHxzYb
 dLAMvJnZWJM6DzjNWYjgg==
UI-OutboundReport: notjunk:1;M01:P0:9Z1MKN+5nDI=;DpehLCVJ764kCcdSpQ+Uoi07DTf
 +C9O8yMDZwbmzMCosqfTMDx3mBCC8q0ByfFpuLr7FFkxg3vUIUKKx6u/ib+8u5FA+fvqbD1PJ
 +7eg2xbNvQKBn0dRMuUOMpBKdqUIPhG4NrLSm8xfn/IYKdr3G8xrtJqNqySln3MTwC/CcQ3XN
 2/nLnzodkEHW7p5ACe3rZnk4vRjVm8tP+QwZiEr5sYkrOgaWvI58OFnHFw+QnW1w5oKo7Te3e
 xHL9M3+Ie14wOHClc3pBwA1F2XtaPjOvXlfVCWTmu4RlCpvY89GQl468H36on8LzIJovCOcx4
 RSrhg0NQ/mGMKJ2aVsMx/qPYeNaM9ygorAssT8FVvNNimWcZOLLOp3Jt/KAwjyIq/DWXdTKep
 ZoNTM4V4xiV05C5HLlv9UfUhPiq8/znIaCKfVR8k5Aec1icxBMsp320blqONrJrIbnXHdtuBV
 UxDqYtcLmWq8/EpI0nz8NrOtxg5or6OlcqEv4eou7m9fto7+e6Yu0z7kFEAkUkvWYR2IvLbf2
 0AyBGwavHbNoyLtyQiMJjZ6EELrjkub0ckv5hMLsbC/2btVLoITc9yaYFrRjkx1AuBkQWmF+u
 SYfbp3oFl6V2AR73/xhpDQoSF/aS0/UCc3udJGKIsvDH/MVrL5bjHdy7wFoUX+l20RKNCa0mA
 n3rup+3fQXpwevHn3fbhgRH8pvHAw3JPfnivvXTOes+P+O3QoUmDf2wfJNxivlVmxNT1nAvYf
 uAMtvztu6/nskvULGCnGlAIrFTr7XrOC2z75H1DNE63W8Qxr5M5LaDRvICcvyLcqk1rkxTQgq
 2mNwFutvqM4kLf54HsjjBA+d2q3dTHLOZnWyrmy2Ycvry7Hz/P2TA3YAoCDScmEgsCSID3D19
 LkLzi0gDZVIi51Xwr+bYUg4DKe24ZeXcI1YXqdZx+RHJALtuQTTLqVK/yix3L0cmAYhncegbN
 dkk0IHQPqvcWugrlTv5uxRKZUKY=
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

On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
> From: Andre Przywara <andre.przywara@arm.com>
>
> UEFI relies entirely on unicode output, which actual fonts displayed on
> the screen might not be ready for.
>
> Add a test displaying some international characters, to reveal missing
> glyphs, especially in our builtin fonts.

How would I detect missing Bengali and Gujarati glyphs with this test?

What might help would be an output of the Unicode entries in the font in
parallel with the glyph.

     U+0040, @
     U+0041, A
     U+0A85. =E0=AA=85
     U+0A86. =E0=AA=86
     U+0A87. =E0=AA=87
     U+0A88. =E0=AA=88
     U+0A89. =E0=AA=89

This would require some new command but not an EFI test.

Best regards

Heinrich

> This would be needed to be manually checked on the screen for
> correctness.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_textoutput.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selfte=
st/efi_selftest_textoutput.c
> index cc44b38bc2..2aa81b0a80 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -30,6 +30,9 @@ static int execute(void)
>   		0xD804, 0xDC05,
>   		0xD804, 0xDC22,
>   		0};
> +	const u16 text[] =3D
> +u"\u00d6sterreich Edelwei\u00df Sm\u00f8rrebr\u00f8d Sm\u00f6rg"
> +u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
>
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
> @@ -118,6 +121,11 @@ static int execute(void)
>   		efi_st_printf("Unicode not handled properly\n");
>   		return EFI_ST_FAILURE;
>   	}
> +	ret =3D con_out->output_string(con_out, text);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for international chars\n");
> +		return EFI_ST_FAILURE;
> +	}
>   	efi_st_printf("\n");
>
>   	return EFI_ST_SUCCESS;
>

