Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EB4C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D22DB87061;
	Mon, 12 Feb 2024 17:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ceh0pFip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52230875FC; Mon, 12 Feb 2024 17:07:28 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95F486BFA
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707754041; x=1708358841; i=xypron.glpk@gmx.de;
 bh=Q5DzgFV2ntOIBIUXUVyunNoDwXVI+XjCXhHcN9MQrEw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ceh0pFipCxoJTqLZ5LgFnhNBBgMyu+/jnZZmU+3psV7FHOCbUUskUIj+NdnqjWI/
 7xS++UuX8ajl0md2rZNHRkEzqRETdceI1kFxLNkailxTIFRHpyBCjQJ0UWMLORvWC
 vNlDfTL5XqPX+D/LNBkfE/vtHqe/mLyq7CzSzflX38iIxrnGj9Wsa/PvuGX4MIi1u
 vqZMWVxg0ylPo8eMaOX1jLIXDv9YLek/cKki+ObNdlEoy721HL673HWcOusZka/SR
 ihlKGNu7qQIDFbqbhHmf6MaGlKS45SYNTG60tPEIx16+iaIXagEN+91IHfQeX/CEN
 h4mO2oDCNW+Qcai9WA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7b6l-1rdAOr3oA1-0081CD; Mon, 12
 Feb 2024 17:07:20 +0100
Message-ID: <9f9c2e53-1639-48e6-b441-1c73abbe48b8@gmx.de>
Date: Mon, 12 Feb 2024 17:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] efi_selftest: Add box drawing character selftest
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-5-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-5-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NrVeTaRQBehA27WfmMZaFxQh9fyiqGumhyCTZTwI6+gQQ+ZyTCh
 uNf3pSrEoUwLFV0nbehsnrko+BDD05josRAceXESm9KqWtY2eRx2uzkcX5U8BDzKvQKb6Ic
 uzxS4b54vQrQOMZy/bQXmJT7WKqwlrQZILB+cWsudCSJiH3UhgKnQxFkB+vMg+I/apOlX2h
 A3ll8NVRPjuWIB4LY+Mlg==
UI-OutboundReport: notjunk:1;M01:P0:TCnegiPFiOM=;53Xmjie3/sO+9bFLoqRvaH8bSkc
 wU94wa+55KVJD/HHBJrbK/VVsuKnTIYe6EVD4feDUCuP4UlDF2bUJciJh3sfRTTgusWIPbAL9
 DBzkbaaY7EZN+a9afMXGVmsZaRib6KPVQaxCPBx3iV5o1igqCCTdAPKFEaly5GuAiyxkZ5fyF
 R1J8CKO2GMDMIdRZXrP/Vd6Psr6emlDLnKodF7SLwV53ynsHLhQ/xb536Bmc4PxhZRaqpYgPY
 ZHPQwrzYGhw0uOy9rZX+eU66au5yKWZJl6rNOnUynmkJ0UaddgHiFiI40JeCU3wBWo0UOEqsI
 fUGRNiRG7tuNWyQcKJZUKBWDjwsT/7cXkT9QOSVYD5VCflW9hr1jP3rvT6F63tzRa/VMyy05H
 sDOteX918QRtrmEz3NdECwsdF38Aj5iLFXPAxaaC3MAiYNpcbwLS9FYzWKDrPCoNrkm0aud+5
 cZxe999nq3sdBmNBos7GOvUp9gUPX3EW0n8jhGW5QRmrJoO0PVInolW5VlGejhrDFOZ9slpwE
 zAVtl4kXTZEyCe2p65wRW5MzoGmkkDg0pqeNH2SkRnWOxlsMtdCI4WvFY0o5dG4DW7Pe/u2Pf
 UXgGQCkn12vej0VLNjI59REnIfk+iZtmh0kpgKGlh735fVS5zQ2R2Fy1/lVLIvypRIlXKiWA/
 E64F6V72jJ6n4aTLGMnTe7RzM49fvx7WQl573aEkpGwBi1MTLYCUIxOA2UVUPEbtfw7OcfIkO
 mYAaD7EADsuByPdkK21HT9uafwBw/JsAKVI6yZPa4W354NMbuHIMGHEJ6OQvfM6R/HyQav7nV
 fGXxgGlfcX3JwrlhCAMN1qA+s5KWl+NHJybKzkl8bAHqw=
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
> UEFI applications rely on Unicode output capability, and might use that
> for drawing pseudo-graphical interfaces using Unicode defined box
> drawing characters.
>
> Add a simple test to display the most basic box characters, which would
> need to be checked manually on the screen for correctness.
> To facilitate this, add a three second delay after the output at this
> point.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_textoutput.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selfte=
st/efi_selftest_textoutput.c
> index 2aa81b0a80..cc11a22eee 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -33,6 +33,19 @@ static int execute(void)
>   	const u16 text[] =3D
>   u"\u00d6sterreich Edelwei\u00df Sm\u00f8rrebr\u00f8d Sm\u00f6rg"
>   u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u03ac\u03c2<\n";
> +	const u16 boxes[] =3D
> +u"This should render as four boxes with text\n"
> +u"\u250c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
> +u"\u2500\u2500\u2500\u252c\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510\n\u2502"
> +u" left top    \u2502 right top     \u2502\n\u251c\u2500"
> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
> +u"\u2500\u253c\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2524\n\u2502 "
> +u"left bottom \u2502 right bottom  \u2502\n\u2514\u2500\u2500\u2500"
> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2534"
> +u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
> +u"\u2500\u2500\u2500\u2500\u2518\n";
>
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
> @@ -126,6 +139,13 @@ u"\u00e5s Ni\u00f1o Ren\u00e9 >\u1f19\u03bb\u03bb\u=
03ac\u03c2<\n";
>   		efi_st_error("OutputString failed for international chars\n");
>   		return EFI_ST_FAILURE;
>   	}
> +	ret =3D con_out->output_string(con_out, boxes);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for box drawing chars\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	con_out->output_string(con_out, u"waiting for admiration...\n");
> +	EFI_CALL(systab.boottime->stall(3000000));

We don't want to add any unnecessary waiting times in the unit tests. If
somebody wants to see the output, he can scroll up.

Best regards

Heinrich

>   	efi_st_printf("\n");
>
>   	return EFI_ST_SUCCESS;
>

