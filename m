Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2109C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 16:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA9D80C6F;
	Sat, 15 Feb 2025 17:58:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RqKg6JIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394D780C77; Sat, 15 Feb 2025 17:58:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CE7B80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 17:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739638704; x=1740243504; i=xypron.glpk@gmx.de;
 bh=t5+KTyPi136jzsK3iXO/EUuH/JpslKgj4slkOagw7aU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RqKg6JIl7ZfBGNklX3H4vxE88yXhlEJoPR2hK3QLbZHErk1/icj/sWkK+5sNIzlB
 cSI+UmX0VyLsfkKtFuhyzEXvpa1ZoEK6unDPCdYdNRSMq1K4pwAO0YAdY3g4qZBYH
 OVtI956fLmXKN6TpdbugMQ0Fl+kGOpPuLwuROVkALWoPg2X0no32P5rjj3+B3vqC4
 PuhhiDz+QSsVT5E98LR+zafd3pPx3ME86iqcJ54RdFDczoHvsSkzPwexG6HxzYLV7
 yk4Dpf2FrlfoktO55D6CvtyXig/jkl60QXvpfXZfmHtBaJeky/H7Rt0BUaRAaexW0
 QKwtn9bFhm4dY6c2Gg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKDU-1tQShI2Plc-016xP3; Sat, 15
 Feb 2025 17:58:24 +0100
Message-ID: <a1484035-28d5-4dc8-8eff-d435d50572e7@gmx.de>
Date: Sat, 15 Feb 2025 17:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Clean up usage of structure jmp_buf_data
To: Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20250215155434.42749-2-ziyao@disroot.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250215155434.42749-2-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yv5SHxwGNpmqI4VU34i3GsBcwWTNy5bDx9/w8ZORi7zhZrdMp3e
 aT/fgP6KNxYhT0FOZFf4EVFLTwcA7YmcmT1SvQywzkREGptFh8ZeLbJNuQV9yzGWX6vH8By
 zuAGpj+3c0JI/l5HsW3qDg+djFkwEsbGmU6JBuqMUA5C13nOV7c9gV2AzepUrdCmKxk/QTV
 8pMEIc/r/6Dy8BrPirKFw==
UI-OutboundReport: notjunk:1;M01:P0:zXn4MAtwTDA=;p87rmgg1CfvNCjE1KLfLn2BJdll
 APz67DWv17Plv2H0qNy8osDb+jWxJgGhQ8aioxHI7s8XvmbewIFaUYSzfGAYtN6qOu62Qx7UM
 m4EVPL7dQchRxICX5msiqCjatulkNkWgn2Iw4wevno6jYK1H8GJbFw43VxoQ+cr0k7zHv9Zax
 mVwb+iCcgVl5VMebfHDc5WSwmEy519hOeMqqgF/89bWYn8q83cNaEUPz2QJ8X1/lOFQFbLntx
 tOyj5GYXcH6BjaYWGy95DQI94R/gyJwtKuNxQk6IqHrF0lvZGcYo1DbpAUGUNrPu7ZRDvib4i
 5ZJYJZG9nd86SqZYnfr7nq5cOSYBLfazpjtL6CI8QqZWxWDNvbdJ79hn3Pa96fqExo44PgoWp
 EdN4hP95YQ/XZHedgoK9dv//BBNlvDkqeRO9+npEGlL+iBwjgLYMD/auBwwCfWWX8mOYA2oZw
 U0ouhDI+vyFiqNLt+oZXL3JJa5K2TzTXoNlxznIG7rgB3vAZTjTlDi+B3GQttakoKDQcao2TX
 R5GXBb6aoraE6D2U968MGVhr/EaBRs1xCvijGNLGHsnBDd1l8QE9vfmokNS/i9VbPSeh5CvBl
 yYZSbrz6butyy30khBw9aBnrwyHOQdY6hM1H0dvx8GCrTEjsBRk+fek7dqu8xxEzufKj5ZJf7
 9vjU2pB0iJ4PKJf90egJMIY3kUQ6Gaz+6xuZEdxv04BJuVCpJj0q+PFNLKp9oDQy3jUHDOYAJ
 0vkmzkOiQdoRDT9KPngFwkzBoWFuc3q/qzSe4l/9tnnnwCRzKhz7s7yCGks57udjsvv7INE9O
 6wm+IGoXd2+oTCWrjignZTPAWxKxcW4JYb4wlRrEVsLKMNDIHL5te180UbaXXpOAHJmX/Yc9F
 bBmF1knPvNMeiXvUIKKCE8kmlpg7WkKLEZiwgNDLFyE1AmHiAgaqjVhnh1APrx3SRNKrmrTOs
 42uuZ8g9bfckY7B4Brc5Sxj1TGwLXYpCc/WtCpvI81eyA59impOEriwOzeYEKh651+6ZWypXB
 76zVSnKAEPTZVFQ9x1iBN24tQyociHWmXQukYe1zXIP0uMp/zGHg4WxIa7z6Ruy6gQis459PC
 jE46PMpMjKYcU++4Y4lzz7Z764T0Luz/AxYz2Z9kh51Umx5FVuHkCUhyVPFLDnyXoogK8hq14
 zn6Hby4P5s7WnGrXim4o4dRgN6A9m5wnIk3GjsHmt8ZmUKjxFy5pGHC3CKo0iNDR+8PlqCklT
 bMOUckhnx9oJwcVKctRz9qrjklbKnFeyupyr1Ydh/GE/NbTxrTWQPSIwN2ExOe5ay1hNo6y0F
 HC3tQtKdgNkIhq2xacgcJ3plm6SlZLWyk6Om7NJ/D0KW0/k588jbcGfyWUuiQRjOGsTFMvGKG
 ybcETlLi9jtPPVwDjWizxikBx7vdchuUSO8P4jHbNVDHu4BAp4m0FNbg8j
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

On 15.02.25 16:54, Yao Zi wrote:
> Structure jmp_buf_data provides the underlying format of jmp_buf, which
> we actually don't care about. Clean up existing code to use the standard
> jmp_buf type. This introduces no functional change.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>   include/efi_loader.h          | 4 ++--
>   lib/efi_loader/efi_boottime.c | 8 ++++----
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index dcae6a731a0..4afe8b9c859 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -15,13 +15,13 @@
>   #include <efi_api.h>
>   #include <image.h>
>   #include <pe.h>
> +#include <asm/setjmp.h>

Thanks for this suggestion.

lib/efi_loader/efi_boottime.c already has this include.
We don't need to include it globally.

The rest looks fine.

Best regards

Heinrich

>   #include <linux/list.h>
>   #include <linux/sizes.h>
>   #include <linux/oid_registry.h>
>
>   struct blk_desc;
>   struct bootflow;
> -struct jmp_buf_data;
>
>   #if CONFIG_IS_ENABLED(EFI_LOADER)
>
> @@ -485,7 +485,7 @@ struct efi_loaded_image_obj {
>   	efi_status_t *exit_status;
>   	efi_uintn_t *exit_data_size;
>   	u16 **exit_data;
> -	struct jmp_buf_data *exit_jmp;
> +	jmp_buf *exit_jmp;
>   	EFIAPI efi_status_t (*entry)(efi_handle_t image_handle,
>   				     struct efi_system_table *st);
>   	u16 image_type;
> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime=
.c
> index 5164cb15986..80c56b1ee46 100644
> --- a/lib/efi_loader/efi_boottime.c
> +++ b/lib/efi_loader/efi_boottime.c
> @@ -3199,7 +3199,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t i=
mage_handle,
>   	void *info;
>   	efi_handle_t parent_image =3D current_image;
>   	efi_status_t exit_status;
> -	struct jmp_buf_data exit_jmp;
> +	jmp_buf exit_jmp;
>
>   	EFI_ENTRY("%p, %p, %p", image_handle, exit_data_size, exit_data);
>
> @@ -3238,7 +3238,7 @@ efi_status_t EFIAPI efi_start_image(efi_handle_t i=
mage_handle,
>   	}
>
>   	/* call the image! */
> -	if (setjmp(&exit_jmp)) {
> +	if (setjmp(exit_jmp)) {
>   		/*
>   		 * We called the entry point of the child image with EFI_CALL
>   		 * in the lines below. The child image called the Exit() boot
> @@ -3444,7 +3444,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t i=
mage_handle,
>   	struct efi_loaded_image *loaded_image_protocol;
>   	struct efi_loaded_image_obj *image_obj =3D
>   		(struct efi_loaded_image_obj *)image_handle;
> -	struct jmp_buf_data *exit_jmp;
> +	jmp_buf *exit_jmp;
>
>   	EFI_ENTRY("%p, %ld, %zu, %p", image_handle, exit_status,
>   		  exit_data_size, exit_data);
> @@ -3511,7 +3511,7 @@ static efi_status_t EFIAPI efi_exit(efi_handle_t i=
mage_handle,
>   	 */
>   	efi_restore_gd();
>
> -	longjmp(exit_jmp, 1);
> +	longjmp(*exit_jmp, 1);
>
>   	panic("EFI application exited");
>   out:

