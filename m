Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990B4C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 08:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03EEE80079;
	Mon, 24 Feb 2025 09:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S1hldZ9P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D36805C3; Mon, 24 Feb 2025 09:42:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C8980017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 09:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740386544; x=1740991344; i=xypron.glpk@gmx.de;
 bh=vUOUn27W+gcmczGORnKFqWW3I4f9WiGOWDaQQHghpD8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=S1hldZ9PQQqVD41L0a3EWVQL0U+ELFik4zxK7Sf7mSle+Tvy341BQ0d3DPDkaUiN
 xXVAtxHrl6aNg4UpYl/dZ7mQjOxVA8ml7/9A/G8kXBSgBSkpPRFOyqHbuKKtxieSI
 diNNjcPpApdQKbrs0zdwvlvz7s7NthURFMw3zsHTXr1PHLwVQi9K9GxwKTKIjPXMR
 VxUgjZO+xDveQ4w2KuUTbdz0eTFczCbacleeDAxtaKi/1+CLXCIQ/LL0WdOWMB8Eb
 CGEt/xOB7v507/wAFFERIpdphJMVBPBOv/9NLokcsJ7E8qpt7y/mEvBoGdLT0xJQ6
 3MZDk+CwVl0qRbkpJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1tHq5o2Bv6-00x6BN; Mon, 24
 Feb 2025 09:42:24 +0100
Message-ID: <38091cbd-d531-416c-9bdb-9f81f5c52f88@gmx.de>
Date: Mon, 24 Feb 2025 09:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] arm: Replace 'adrl' in EFI crt0
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-8-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250224055524.1334929-8-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KAVl4j/yYFlngywIUQKhhE4EMmrMs+cNCRFUPdrpTWNObOIFt+a
 nL/S9tyCT+1ynLxGnL06KSmaMz+psz6FL4U8HGJRlCqihLiC6WmrDvlQ+/sVy3GE8aeqjrD
 5kXtjL46Phr/6X0tpXzt55KqBllSaJ95LWOUjHoJf2nxYdCN3JAI+2iEvFA3C8VG5phYycO
 q/afmL+5P2y9W/ZU8z7oA==
UI-OutboundReport: notjunk:1;M01:P0:3iMrQ51d9GU=;8WJ/F9QdO4y5pj4mwlv/XLUYQXZ
 rGNIb1uTeFjEptiEmn4sSEJS8QiveTI3X2NHh0kbNGShd2m3ZPB8X6bWKRU6tzhvSh1t5A4pa
 iJ4lyFIHrX4FgsBbsotGlAAZJB3PbIhdlziMDwasCHUdt/nkbaD0siT41+r3UmXBhcq22JAh9
 77n5qA44RjeWRcWaayNYH3gVFjHCI3Bh+RAq6NvX/2xEEXlNy0Qb0IuB1y33YVh8fCKd5+7Pw
 tEqawmsWrhRvdks0DKiHQDms8c+UxV1mwgPTlLeZZ4+nTiIqGznhkIPnQXmimezhQSCWaGnbO
 9D0uoXVynBD5PcrEi6vjzgHOuSXtPeX3jqhBcu/0CYZYtciIzeDTFghpvD35Rvtdat9KVAgVp
 7GupUJGl6WfAtL97Ru+av0UQabRk3UWLPp17sraP/MzLRXaxBIN4pX7QUaajHbrS5CCP+Dcjz
 6eXh7bt4bbiRFSdStajg6W6OQgE53C4QrW0KTMAPImCpTA/SdJCCMzl3FV9tfqXRo9hWlJPck
 EK/aLeZ9lpurdlVAxUcYlEzquy9E7FZF14FBtChbTBL61A8ol/WroozUmlHhdXDuGg+MbCTUT
 oNJQByt4iHUh/hHoEPy9RF3cVotNo3aXa48svRYItH0BQ/IbhtaByYyBhW7lpUxaQGH8lD5Kp
 d3tjFiIobBd4NyA8VUycGoBgCjW+RNQyXwjtlw/FUCwagi5Jgj+2XRcYHt4HtVBUm2tffezKk
 XCE5JkSKiiuPrFv05prSUhrpmp9kAN21Y1EScaKOnpust4+HYG9wWQg2ezrqJjZKhsj8QBLEj
 3F1mt2CF7/jVFpY824NrwyWVli8zMeiKU4zA8ObioCcNPSsbPXwRwqNk+EmHT3hnKJ2I/N7/m
 pv4rjN3fxTtcJU9pM1gbCcjwzB8mGWLweRFyXWAFa7IgEkz0yIRjiU07DSrz+ygmyNfOzodT9
 ZldBJ5hNac+keCwLBcf986jWWC6vaT+X8+jYJ/98zQwi996ndyxMRNk/p1K/FcepylhXF13bm
 qkGNVX471tkVrwE2ObdHVCG+kMo8oYa0zWGlkqxX0utr1x01cjDN1VKh9BeVJoCxR+SuejLiF
 VYgWlXgWlhW3Myxmm1JA2zMoc9pI8M+0NBXhVPCsBjw4fHdpQXnhWIiD5233/AE9Sb1VA9y+N
 4HsWvL2+402u0SYtO5s++78HFONRmpIlo+f0PRb7NJ9bkoX1Vkrj1Nc34R2JyGwaO5G09cFZL
 wvLtc+MsTdunmnQLXLVos/UBG9jj5zqFP11nf8fdFMIA91kuAGFyjF2Vy9u+BPbUGSXu3LyYK
 AyDY2E2+PlIfDJRBU3WJD7QAgiLgy6UqR6rWf0ObhwsGy/LnEUTx8y7GPAhD6SJ/6VboupHT2
 uFdpiEzdVfPLCbrUgkZj9mrum7ElQzrNXIZzFN4NQIKeLZA9WFGPl83vZ4
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

On 2/24/25 06:55, Sam Edwards wrote:
> LLVM's IAS does not (and cannot easily) support the 'adrl'
> pseudoinstruction, and ARM developers generally do not consider it
> portable across assembler implementations either.
>
> Instead, expand it into the two subtract instructions it would emit
> anyway. An explanation of the math follows:
>
> The .+8 and .+4 refer to the same memory location; this is because the

Are we sure that we never generate thumb instructions here?

> .+4 expression occurs in a subsequent instruction, 4 bytes after the
> first. This memory location is the value of the PC register when it is
> read by the first sub instruction. Thus, both inner parenthesized
> expressions evaluate to the same result: PC's offset relative to
> image_base. The subtract instructions then remove one byte each
> (low, then high) of the total offset, thereby getting the absolute
> address of image_base loaded in r0.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>   arch/arm/lib/crt0_arm_efi.S | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 91b0fe12c51..235b3a0c48f 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -149,7 +149,8 @@ _start:
>   	adr		r1, .L_DYNAMIC
>   	ldr		r0, [r1]
>   	add		r1, r0, r1
> -	adrl		r0, image_base
> +	sub		r0, pc, #((.+8-image_base) & 0xff)
> +	sub		r0, r0, #((.+4-image_base) & 0xff00)

These are the instructions resulting from building qemu_arm_defconfig:

sub     r0, pc, #24
sub     r0, r0, #16, 24 @ 0x1000

The last instruction subtracts 0x1000000.

I can't see how your instructions would be doing the same.

Best regards

Heinrich

>   	bl		_relocate
>   	teq		r0, #0
>   	bne		0f

