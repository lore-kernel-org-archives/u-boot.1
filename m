Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF6E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207EC80295;
	Fri,  3 Jan 2025 16:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="AC8GBsQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73D13802EF; Fri,  3 Jan 2025 16:43:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60939801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735919022; x=1736523822; i=xypron.glpk@gmx.de;
 bh=36kFWMDMNpKDt5i8Z3iWl10Tb0coQHkgjKgJ6H7xiWk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=AC8GBsQXESyhYBchNrpKzN0wnsc2irHiNPBTpC+6BrhabJKy0axKsfzTrDt7PCsV
 VJarDxfNEPY7qNE0CKSLU42el3Y7Z+7Ln/r88uXOm3SXP6OKi2WtduxNeGpL/0GGc
 5VwxI9EngqttPUwEKmVWHTIYPl7N3kuAVxQPRaCEa+RsaGib9MzBwu/A4Ag/Y214T
 j7CkSZ583PUe3/JI/83UnX4NQK4TNbwWwmfruEINKNsCawdPg3cKbQA/U7DSlkppY
 c6ezsOdnbcqoJmACR0Dh6+l2ryH5ePzZcCtT7hZus0FaHpS68m50xcNiFn1fu1rQm
 xw7UkXO7BDp/HaaUGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.106] ([46.114.109.94]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1txKE910yR-00fzTD; Fri, 03
 Jan 2025 16:43:42 +0100
Message-ID: <bd3b49c9-55b0-4707-baf9-ae6bb97e2d01@gmx.de>
Date: Fri, 3 Jan 2025 16:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] efi_stub: Sync the debug UART definition like other
 platform
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241128114737.1.I9eac706713ffc05dccc51ad3d60833a179c9e83d@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GhGlaTHaMOqCOoOuvGqK17Pq1+wuu9dR6L0LjJbrYyTW2Qu3q2r
 uwAxKIdy01c/85+caVCS/nNMzav6qmqxegGneXpITsNYD7l9q3W1Jlgv5UdA6TeAPFCj9ho
 HUmwJPv739jelnIKJw0R4g97jroPj/fIcSPEH1b/CFTEh7kyC1s7FTIGbu8kRmBqzAh3sJu
 uf/QcMvqFKjKAPX8nLJ8Q==
UI-OutboundReport: notjunk:1;M01:P0:1GkJc+UkOAQ=;EPIud5pgcCqS/tMSEOtgOyzTtem
 A9OZ3Hlv0HQ5Hz6roydrb+S1WEAqgWiB23ryj3HUSpjvYIk7y1h2I57/AwH6AmO8NWJCHoz2Y
 YaKbRgqvvoYO/5NBnxKtM3TSnojkua7AiFlbUBVaQpQlfgIIPSxh5qjnLzzgC1FZNhdwAgW9e
 WhJIRfEmyyv4P+Nsee7jtgw7it7a/mNFlqYXWhoDzmD38QeW+h8psI+aWOZg0eVqUYTepIzhk
 eNKz+QpuZPgsIkYu++kAXLx8gTvurq8gPYMYU0Z8z2YgCrOhWR1eQUZRBreyIvsYjHtxvNVep
 9Uk2UQpbUUlD0ENMv03QG8NGsbaV5sJmdZ4wJPLnJ2D9coSaYfFrB6BjOxs9hGGwIWYVPqe67
 9uMJg9fXH++HJNH1FN+zC7q+mkJ7PdwpbSPFwFQjQbuhuR4/re3q4CbwsKzPBr4cOCy+w2YTi
 yBgIE4APAYXydNGeqFO8i/5JtE2Noif47SuJ4a1rkWxN5y5pLL9g2QGhgDJsbPD01ut5YR+6b
 OONmOH2sZrxpJFF2J0oa4OoNP9GJLAjfO7sXEVPYh4Q3D9k7iPf0Um0M9/EXkLqwo8bNIeEXs
 FbB7EferT+vmY3T3hwnx6U4UZcgZfNp/b4k4pw4AsrRUZCRnnv3gdW4FRVoVm/Ai6ohMdnW/Q
 LfEr30lK/EsxpaqnUs/CHfxTdC9Sz4plfCBqWsBICAVZ3Ewh+hh+QEIQELAh3NG27PXTRUIex
 i/DQZ7f0cHIOh8zbWhM0gq0Z66wuHJkhOlw3NvWPPRFW257jLHIhJlNN+zuy+vcDR3uommbC9
 z6Jedv8Cu0uA65eEY4hqdf1HC0hNvgsnvHbF+g0g4YKwO4cqbqRczyB/Iwidk+5sfGSyhRDbF
 o91uSrAOLsY8Tf1CKKKzC+YltNimunupJfrPlnOEeBHmZU3t3qiSFF7mUmnB1nsha0ZhZDHyX
 U3NZpsS5XqU4A7qbu48EioHrSPLxAR7MvWTV2FdLFR5ASbl1qVfZvNWVyZbxqfpkGyxV0bFw9
 FxCMjSYOOynP20MhaQIRXwtQosedS/969NOsMhLui3Eq+eBjMcjOMfQI5xGwWUmyqt4WM/xlC
 2Jb98O+WhNVqZZgZ3YZt/jvt4woh8A
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

On 28.11.24 04:47, Kever Yang wrote:
> The debug UART interface is available when CONFIG_DEBUG_UART is defined,
> sync with the other platforms to use the same definition.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
>   lib/efi/efi_stub.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
> index 40fc29d9adf..5179c5b2c09 100644
> --- a/lib/efi/efi_stub.c
> +++ b/lib/efi/efi_stub.c
> @@ -9,7 +9,6 @@
>    * EFI application. It can be built either in 32-bit or 64-bit mode.
>    */
>
> -#include <debug_uart.h>
>   #include <efi.h>
>   #include <efi_api.h>
>   #include <errno.h>
> @@ -55,10 +54,6 @@ struct __packed desctab_info {
>    * considering if we start needing more U-Boot functionality. Note tha=
t we
>    * could then move get_codeseg32() to arch/x86/cpu/cpu.c.
>    */
> -void _debug_uart_init(void)
> -{
> -}
> -
>   void putc(const char ch)
>   {
>   	struct efi_priv *priv =3D efi_get_priv();
> @@ -83,12 +78,21 @@ void puts(const char *str)
>   		putc(*str++);
>   }
>
> -static void _debug_uart_putc(int ch)
> +#ifdef CONFIG_DEBUG_UART

Why do we need this #ifdef? In other places we leave it to the linker to
remove unused functions.

> +
> +#include <debug_uart.h>

You cannot consume function _debug_uart_putc() before defining it.

So either the #include statement must follow the implementations or you
have to define the function prototypes in the include.

I would prefer adding the missing definitions to the include and leaving
it at the top of the code.

Best regards

Heinrich

> +
> +void _debug_uart_init(void)
> +{
> +}
> +
> +static inline void _debug_uart_putc(int ch)
>   {
>   	putc(ch);
>   }
>
>   DEBUG_UART_FUNCS
> +#endif
>
>   void *memcpy(void *dest, const void *src, size_t size)
>   {

