Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D67C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 025C0879E2;
	Sun, 17 Mar 2024 10:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fGZ8lfyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FAF787D87; Sun, 17 Mar 2024 10:44:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8323F878AA
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710668662; x=1711273462; i=xypron.glpk@gmx.de;
 bh=j4Ao9gy4apNuYmlPtJyrLFTT3GD9Z1k4mucJ2GMDbeE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=fGZ8lfyFK1V2FLgP/g4QrW2N4WbgmJ5RMSQfuP0+aZm1B+T0t5zmcKNs2oG9eO5a
 l2VoNPtsjrucsG0HtC4bobqahb66avnaWIZh+aWCUx21obLdrkdghJeYx2XtWCMt6
 aeH/+ioLUVXnyXOHfaRtcOE+j4e88TnhSZNSY6/f0Fm1dmhYWx1JNbI1sy/4Hag+w
 yKuWuWEL0on/Beixy22xFy8iQ4m9Pb15xRXYPNJsC8MdGSNKdvpb8yVOc3Iy4JRr8
 oSQ4KdMSMzgytCgXh19mwUrarmnaJ700hDo+cPKD+l2mer8r+cIyzFc90f1tvJ+dV
 a3fqIoocAIH6ZA4iOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1rnQh227nW-002lcY; Sun, 17
 Mar 2024 10:44:22 +0100
Message-ID: <ed9b6975-250e-4eab-9315-06e6f32affce@gmx.de>
Date: Sun, 17 Mar 2024 10:44:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] efi_selftest: Update StrToFat() unit test after
 CP473 map extension
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-7-4e8a3d349447@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-7-4e8a3d349447@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o8OPqisMIF7mroQJkS1zDDNnPe1nc1VTwIurNVV895MSQZpB9ru
 4S7YqaxNIHHColTXSUt4DuCqVDsicQxyXJx0AmuTuBbPBERYWGDKZev8/vEejLIesKaqNbs
 tdtdYU7tKB193G0SfJjKsvs/v6qUhnxh9VoDKbHtnXffCzXdwDNuDXQetJAmTVLRc3HNtnr
 LYRugxmBodaRuzd7rYUWg==
UI-OutboundReport: notjunk:1;M01:P0:NEREs/QXrl4=;31RH6RZp4UNIO39fUWTBZ8CFydW
 KSctREBQW4WGoIhCqihahnjnOf9+oeZ615yolD6Xx5MDrhmjgSBE3rcWGWupse3EMSja3gG/5
 CG+UpTec6dM5WTRVakW7lyQmcaBlIaPeKgUcIUz98XQ9aJs0Co4I+jo4eM6jtNYQfz42l8u97
 9QwpHNiOWVfsdSLq07w5m/JmYCikv5U60XxmCI6F39xr97RAQoyNt2hyKBbsRhe79fMqb1Z0a
 eOmKbaxdLZMegJmG0PeMMuDwlP5PyUpnc9FZoliAyFics2+dboylRF1FiY/08G7lkYcVdycBn
 WM5r/thOIwSW26sHhPaWBz4tGrdLzuGVvNfF0K0X9xQMXOWQp2GAO2/VQv9CePkFGEk6g2bLy
 nodHHkxF48ivk+uF68ClcekFs7fZb/WeWVOs9LJTx9KYWcy3PLfcMykvYt2MYyEPdmiWbYcnt
 8YhOrVxuj9lalbJQ8Wm/mEi4wcvG/R/uTnFEysyYy+q9o+ysdc48B1zD+g3zih78MWvKp9GtG
 wWT2IYwrOktAamME2vRixYBHXXvAN6ylJNxFrqTZTHlpwGU1E7MEWKnO+63KuS9t/uxxC3X9S
 w80Xyig46y4WkM9NdyFMiVEss1wsXxL+ApmU3RyWz7/tC53vVbHSdWLaykUQuo629nqrTQERZ
 kN2G/ghLb8pilmjFi0dLrVtfqK0S8d9TgZaR9v40b078RJCbQVrYqKuotvIf3452egFnHS5T9
 +Cn6oifOIwq1P2mFjfKnKj8oYz9Oqz26OIQ1jL+6A1K24W0Gceok+uIXegi9tsRpIISZtiPdW
 4elHYpwP65Qw2GPWv78doG7Y5wO4ya37zjDIRb0gRXcv8=
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
> From: Janne Grunau <j@jannau.net>
>
> Test that Unicode code points which map to CP437 code points 1-31 are
> converted to '_'. This ensures no FAT file names do not contain chars
> which are control characters in other code pages (CP 1250 for example).
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_unicode_collation.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_unicode_collation.c b/lib/efi=
_selftest/efi_selftest_unicode_collation.c
> index 32c99caf35..ad7dfa9fb9 100644
> --- a/lib/efi_selftest/efi_selftest_unicode_collation.c
> +++ b/lib/efi_selftest/efi_selftest_unicode_collation.c
> @@ -220,6 +220,18 @@ static int test_str_to_fat(void)
>   		return EFI_ST_FAILURE;
>   	}
>
> +	/*
> +	 * Test unicode code points which map to CP 437 0x01 - 0x1f are
> +	 * converted to '_'.
> +	 */
> +	boottime->set_mem(fat, 16, 0);
> +	ret =3D unicode_collation_protocol->str_to_fat(unicode_collation_proto=
col,
> +		u"\u263a\u2666\u2022\u25d8\u2642\u2194\u00b6\u203c", 8, fat);
> +	if (!ret || efi_st_strcmp_16_8(u"________", fat)) {
> +		efi_st_error("str_to_fat returned %u, \"%s\"\n", ret, fat);
> +		return EFI_ST_FAILURE;
> +	}
> +

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   	return EFI_ST_SUCCESS;
>   }
>
>

