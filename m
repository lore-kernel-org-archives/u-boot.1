Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69BBC54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82BF878AA;
	Sun, 17 Mar 2024 10:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="keeyx/n7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB8E87C68; Sun, 17 Mar 2024 10:37:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8008775F
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710668266; x=1711273066; i=xypron.glpk@gmx.de;
 bh=jvuj46hsTjpJUyuTwlqhKjG4y3paKqID13MyRcJv1EE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=keeyx/n7wZFQM2QeId9IVgTKNK69k1jplZY65XK/aHU0kqEZzgV8L+NaBIdEbWe5
 i6ZtXzKIW1+FmjZUtO29rnBr3XSRko7+ddy9d5RraAFL+6AsIVzKYCJXI8dZIuAUc
 lnrQWrpWYtb0n0mIDcCThmF+ppl2DVP37UyxMjCRbmu4se0905K1SJxeqHFm/MKOE
 t7UEWAAOzIKBaZlN5eYX8f+a59SBTFqP1xmtrxjTXCNAwRAPvLgs+2/74jKUpvqJh
 w5DS5sf2CZFAvcSARv4QhEaEQFeUP4cz8FfkZIFNpSKcSEDTFpMj1O4vAMVKFsFqu
 UP012vunTs3gsvt6zA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Md6Qr-1rCBA133Ip-00aH3g; Sun, 17
 Mar 2024 10:37:46 +0100
Message-ID: <ec8b1e3b-5d8e-4a69-8e4a-4bbf81c4919f@gmx.de>
Date: Sun, 17 Mar 2024 10:37:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] efi_selftest: Add box drawing character selftest
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-5-4e8a3d349447@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-5-4e8a3d349447@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Us+bF/9Moa6644iTaASW92NQ2w/y21ZWnbc+aA3DYInAaL6V16
 MeVezO/0J1Wz2zGClsgk/gBocJMfTD7BFTSymx3pCywsLdCiv5xuc0ZtbL78kbf9vFlPwnl
 SqjaWV3093wHo0n33wPAtGA0L8dD0Pug/RxJQSlk+zfzP96Ikro43nV6d1kZ10hq4ITFHwe
 fLuab1Gp6W5QBnr/utwkQ==
UI-OutboundReport: notjunk:1;M01:P0:QyrSjA5uDLk=;OcXLsQUJ1Z8q2EufrAcBrQD/wxg
 3YJt5pQSf1PHpKOdMpqASLC0ChnG0byfT3cjHszcnoPWooWJ4q19kM2jftzfnud4u9w7X/ujG
 YT8DNAbGb/X88OKmQwrh0GQCSNvdLW+2sDROBSpkbibCtbM+I2+YNQ+p+ODJb19bBIZfowEBe
 3YgslLOBg5uA3M7SyuDoFdQ+9kJqQG6Q0O8QSieN0H6n1Ck5mbW48IEXOiU89Ik6EuDxShD8y
 y7wL11XesYGSSnIZ1y+ZDQThqm+5RnT77CXW3EeqesBmEjYyoWnx0P8F/cViHaLcdm7dfOOOE
 gqVVfHV3lCIsBJgNWfwrq9C0XzkJEdBxanId9YoV+BDNPb80jBfk7lqzyY3V69JIw/KEWTeX1
 cuMgQGE1peiMO9zhNxkKeni2fYpe2Di2YBFDa9Hg9gvz+JkSQgFhGlKwrDRvUy4X2B+Oo1ctY
 wUSEfbS7SWrFqMV4UvyQVLTKQ51heiIkRIA7X2YTz3Aw/rqbEUHFoGeakH0A7XQ9lnZezOyGT
 ghbit5oewGq4v2A8dm0rlqCWxEIF8Py5Nc6eT+guJoq6DMEtBsohYP7GjeOjs3nM5NIqilEmg
 5m6nPFXdP4WVR9vA2XgrG7WvymzCUuQQyzCoa7Fk+xoIhKZNw3g0O9U0MfPm/vJNdf0fCnztE
 S0qwIeGUWXsKsP8kRJ+6bEGbEF8q3+10QFmfxKQKQFaF1v7t6rP6TJjFKndRVuRz0/HY3uftb
 OTC4zixzXSY5ep0+Ij61nFW2fQ4uK4M7xMpXYAmzHr90DKthaNktEsIOoKFq4FD7d00UhBL9c
 Lc34UL1oU1JHjLoHxUEg4OvSTTPTL33M03B8za4xZE/WQ=
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

On 3/16/24 22:50, Janne Grunau via B4 Relay wrote:
> From: Andre Przywara <andre.przywara@arm.com>
>
> UEFI applications rely on Unicode output capability, and might use that
> for drawing pseudo-graphical interfaces using Unicode defined box
> drawing characters.
>
> Add a simple test to display the most basic box characters, which would
> need to be checked manually on the screen for correctness.
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
> index 917903473d..b56fd2ab76 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -46,6 +46,20 @@ u"U+03BB \u03BB - Greek small letter lambda\n"
>   u"U+03C2 \u03C2 - Greek small letter final sigma\n"
>   u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";
>
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

Please, indent the strings by two tabs.

Otherwise:

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
>   	for (foreground =3D 0; foreground < 0x10; ++foreground) {
> @@ -140,6 +154,12 @@ u"U+1F19 \u1F19 - Greek capital letter epsilon with=
 dasia\n";
>   		return EFI_ST_FAILURE;
>   	}
>   	efi_st_printf("\n");
> +	ret =3D con_out->output_string(con_out, boxes);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for box drawing chars\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	efi_st_printf("\n");
>
>   	return EFI_ST_SUCCESS;
>   }
>

