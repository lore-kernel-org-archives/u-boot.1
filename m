Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF53C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCB887BC3;
	Mon, 12 Feb 2024 14:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gfpxH2qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6AC87EBD; Mon, 12 Feb 2024 14:02:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0964187B63
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707742952; x=1708347752; i=xypron.glpk@gmx.de;
 bh=5sqnQOkQQoKnRi8QcD3EY1DMlw7LADtvZa6WcSWek8U=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=gfpxH2qgv6NnNC3/Kodm1awiHwRanCtHcwZoGaZXA+3Zr0YgOZEhNHmawOonGi3Y
 LPBu5MTN9q69i5CGo6xbiqO9WFPBgDPSbkxpb8x68nN5xqoWLf/xOjf9OJVxn50bJ
 apjtixaoPShJlDX6HYhkNIzuT3UcVeyfCVu4G3oQkFnj3/+SdnWllenfeXNDbQJgw
 pNTjwkpZBetd+zxq2yvZjKIcle3qMLzapWUgg5RBO7QquJWOuS4Y2xyBRNppnef+/
 NtZEkJ5mRkjd+pfWW9BvCB2SogdnOMJ0uTk7ZIX6MU6jM2UU/k7augf9ug8o+fp+S
 ymUstOUbkGO6Vu7ewg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXyP-1rTpQt185n-00Z01W; Mon, 12
 Feb 2024 14:02:32 +0100
Message-ID: <baff3515-65ba-4f1e-8272-9bc90185faff@gmx.de>
Date: Mon, 12 Feb 2024 14:02:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] efi_selftest: Add international characters test
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-4-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-4-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qjMElWAn4yYZq7ws70lf2ugaW1q3GZ45R+ke4DtW6js5mQ2+j1t
 nd8XSZbvuNw4HWelyrwGmogYcuon+p2n1KVnF3ZOfYrdhKDztNUEZL/RXgC+V0l0MszWxqY
 eCtL3Y+4+IIvlYZWnOxYAwJ7vXDgsfYyc/hO69jR/OpyV3q9Adph1VwZYojuJsZ2ROn6isi
 r6A7SXrVL+TUHY2N1IENg==
UI-OutboundReport: notjunk:1;M01:P0:eMPx3XRlZkM=;7fbCCK7gUwZhP4iwSOJOrYoO2Iq
 gb2ACtJxDHNQ105fMmvBndoVfC5Zj0Izmk4QZFnleMr0N0GMOGcuyG+M4UZranCRfa4OGsyvX
 TsN1Wfe3BWBIAS92owbGUQESHZxkdKK7wQirVLpxhFe4Jzuwwl4PgeVUXpbXWziWSsahGVi5R
 0895B0hbG82iAxggaLbfcWj0l+bJ0TbcDSgGXMPuXzx/bQnUK91r521SsiHWNttLvdZagfArs
 AgkzaxWeK4h0lj7NssCaYbtUW2xElcoyWYR037+MMpedlma2FElk2ybKnqbQr4KCmSYvKOfkw
 YjsurRv1f+kw/KGeYbKLZ3zJVChtRrvjku6tzlWVlD80LMLSQ4/a62n8s7EfplqaKyfbGxOde
 dapcjrrYL4y21xTIBr3QDlz46uXYpe18Jn6tHmKNqS4/09X32smjy3Yd1iusQ/BMiNmrSUTTN
 fDvrJ8u+6mTuzvJERR5lnMBqLnyXq5iZNUGXIoZFR4kKpcSW0PTvov8F5OCU7iPsVU1jb0/D1
 EVhWwLExk5G8LiQE8V4vInVwPGaq0sUulxUo2XVASd/U/9dAAAZCVcctLuAZ+qA4deyJYn2TY
 PVKOfdtUWpor+zlNjQOcU1mFNMgCTnER/1dREzAHLadBoTBdf15hoMs9FdtGWIwicXYokb/2x
 ZBvuBsuyKX1jsTGtj45pWdML/VapVjCkkL5A42BJPSXwax4ThPCYZ3d1/xqCpbhPXy4isVm5f
 +1rKc2Rm5uWDn2Re+XoeVRg7iKPuOL37XY8LbvOPtNw4Fp8giBt8olAuCTnyWlpEjkNs4epCG
 dpaav/dFWFIMCfSIvExIuLyf39aqnkY/+LhKdf/lStDhQ=
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
> From: Andre Przywara <andre.przywara@arm.com>
>
> UEFI relies entirely on unicode output, which actual fonts displayed on
> the screen might not be ready for.
>
> Add a test displaying some international characters, to reveal missing
> glyphs, especially in our builtin fonts.
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

A person not speaking German, Danish, French, Spanish, and Greek would
not know which characters to look for.

How about printing

U+00D6 =C3=96 - Latin capital O with diaresis
U+00DF =C3=9F - Latin small letter sharp s
U+00E5 =C3=A5 - Latin small a with ring above
U+00E5 =C3=A9 - Latin small e with acute
U+00F1 =C3=B1 - Latin small n with tilde
U+00F6 =C3=B6 - Latin small o with diaresis
U+00F8 =C3=B8 - Latin small letter o with stroke
U+03AC =CE=AC - Greek small letter alpha with tonus
U+03BB =CE=BB - Greek small letter lambda
U+03C2 =CF=82 - Greek small letter final sigma
U+1F19 =E1=BC=99 - Greek capital letter epsilon with dasia

Best regards

Heinrich

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

