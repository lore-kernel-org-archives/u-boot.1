Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D95CCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 12:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1C4C83621;
	Fri, 24 Oct 2025 14:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Su7JtXOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9AD8362A; Fri, 24 Oct 2025 14:26:17 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 900528334F
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 14:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1761308769; x=1761913569; i=xypron.glpk@gmx.de;
 bh=PpVkyuiB3/eRNCoXzqyCbg5geDI+rdXmetWyo5CRMu8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Su7JtXOvpqz4pu6eqlgw/XvjTo9YEuKbAX1dhs5swlDwXlMjEFBjhIDVFeVz81e0
 8bRQVIaRyJFu5t93Ims6G5YMaKf9NlsHuYoKvGQBqgpfUzQCYJ2iNCOvq796FqAKN
 hnuR5CpJ3VbQtPcKL2+IRJinpcBJ8J5Mi96fjZ44/66299Ms7idKUCCh+ZzvshmZc
 UVyWHPrZHTCLzHHwR+bEsu2kaMI2U8hAE+jfOHe6NuRfGnSq4E+aJcOKrVcIe1Mtf
 uSE/inJL8ehD5iX43spOmnjzbf4uB9N5+OUC8FXpPS2BPBmhPRfOs873cyiXZrTO+
 OKjB89m2BRrztTIQVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.104.3.212] ([109.144.144.191]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdebB-1ucwBU0Wrh-00aWZg; Fri, 24
 Oct 2025 14:26:09 +0200
Message-ID: <e56e47fb-ec9a-47f4-b656-ab983e6928bc@gmx.de>
Date: Fri, 24 Oct 2025 13:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: efi_console: jump to prev/next word with
 ctrl+arrow
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Weijie Gao <weijie.gao@mediatek.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
References: <20251023-eficonfig-ux-improvements-v1-0-f5fc93b126ed@linaro.org>
 <20251023-eficonfig-ux-improvements-v1-2-f5fc93b126ed@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251023-eficonfig-ux-improvements-v1-2-f5fc93b126ed@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/wctfvm8wRNoqveCJf+c6dEs6lQ37WHa5vAWVVeM1WFxy21VKwN
 QJIeMJb3orCrEz+npZ1uEhIuJgvOYHenmh8VBnCBLc53IkCbDfVP4bIaLzN4dh8jdcCxZt0
 0w43OvmxvCnpdGgO1jRDsrDtgxLJ4sm4OBsr5gxiCZfq3EkyjZo+Zi/gajyWtbKqD2liU9O
 S7J0w3tc+YPYorUsb4x+w==
UI-OutboundReport: notjunk:1;M01:P0:+3yQALUJLqA=;vpJxFBrPCnU/e8NXmAG5igtGqD+
 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
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

On 10/23/25 15:26, Casey Connolly wrote:
> Extend the previous improvements to efi_console_get_u16_string() by also
> implementing support for jumping to the previous/next word by holding
> ctrl when pressing left/right arrow.
>=20
> This unfortunately can't be handled with only the basic text input
> protocol, so for now hackily look at the internal state of the efi
> console to read the modifier keys.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Thank you Casey for looking into the usability of the U-Boot console.

The key combinations don't  exist at the U-Boot prompt. Therefore I=20
would never have tried CTRL+LEFT/RIGHT inside eficonfig.

Introducing key combinations here that don't exist on the U-Boot prompt=20
doesn't make much sense to me. Either we should introduce the key=20
combination there too or drop the patch.

The one thing I am really missing is support for the HOME key. That is a=
=20
key is supported at the U-Boot prompt and is missing in efidebug.

Tested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_console.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> index 7bfd18233feb..87de38a26569 100644
> --- a/lib/efi_loader/efi_console.c
> +++ b/lib/efi_loader/efi_console.c
> @@ -1387,8 +1387,9 @@ efi_status_t efi_console_get_u16_string(struct efi=
_simple_text_input_protocol *c
>   	efi_uintn_t len;
>   	efi_uintn_t cursor;
>   	efi_uintn_t i;
>   	struct efi_input_key key;
> +	struct efi_key_state key_state;
>  =20
>   	printf(ANSI_CURSOR_POSITION
>   	       ANSI_CLEAR_LINE_TO_END
>   	       ANSI_CURSOR_SHOW, row, col);
> @@ -1401,10 +1402,18 @@ efi_status_t efi_console_get_u16_string(struct e=
fi_simple_text_input_protocol *c
>   		printf(ANSI_CURSOR_POSITION "%ls"
>   		       ANSI_CLEAR_LINE_TO_END ANSI_CURSOR_POSITION,
>   		       row, col, buf, row, col + (int)cursor);
>   		do {
> +			/*
> +			 * FIXME: we would ideally just use the proper extension protocol bu=
t we
> +			 * can't easily get a handle to it... Since this is only called
> +			 * internally we can be cheeky and access the internal state.
> +			 */
>   			ret =3D EFI_CALL(cin->read_key_stroke(cin, &key));
> -			mdelay(10);
> +			if (ret =3D=3D EFI_SUCCESS)
> +				key_state =3D next_key.key_state;
> +			else
> +				mdelay(10);
>   		} while (ret =3D=3D EFI_NOT_READY);
>  =20
>   		if (key.unicode_char =3D=3D u'\b') {
>   			if (cursor > 0) {
> @@ -1429,11 +1438,17 @@ efi_status_t efi_console_get_u16_string(struct e=
fi_simple_text_input_protocol *c
>   		} else if (key.unicode_char =3D=3D 0x3 || key.scan_code =3D=3D 23) {
>   			return EFI_ABORTED;
>   		} else if (key.scan_code =3D=3D 3) { /* Right arrow */
>   			cursor +=3D (cursor < len) ? 1 : 0;
> +			while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
> +			       cursor < len && buf[cursor] !=3D u' ' && buf[cursor] !=3D u'.=
')
> +				cursor++;
>   			continue;
>   		} else if (key.scan_code =3D=3D 4) { /* Left arrow */
>   			cursor -=3D (cursor > 0) ? 1 : 0;
> +			while (key_state.key_shift_state & EFI_LEFT_CONTROL_PRESSED &&
> +			       cursor > 0 && buf[cursor - 1] !=3D u' ' && buf[cursor - 1] !=
=3D u'.')
> +				cursor--;
>   			continue;
>   		} else if (key.scan_code =3D=3D 6) { /* End */
>   			cursor =3D len;
>   			continue;
>=20

