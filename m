Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C183BC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2533280107;
	Mon, 17 Mar 2025 09:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hoqGaHSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CA18058A; Mon, 17 Mar 2025 09:43:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5983C800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1742201021; x=1742805821; i=xypron.glpk@gmx.de;
 bh=g9bPGaTD0tjCPI2p4JmngOjHUEw+Ff1Pub/QwLUZbmU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=hoqGaHSyZLJGJNAq7N4CzAQDcrO2EfdotmF9MGplUn1bMKOZygFbNQBIC2DQVFQ9
 PH7w7cT10FgXpAcrgQ8jMvLwxCPlY5oR624DlnOmXo/KsY5LcNLqBE0g3kGgDRukT
 bJvigwaE5qCvvwPs/mDl1EHavK3ekiw6LbToeQIA83OaFYwc1fimDrIosZbiYIGZb
 hHI8ufylGUSdVZ2a9tT7IwdGpEnAc7rduFe9Fc0IPk2qsYhQyZnadn9ZrDIlKKvo+
 2Av55fXOyPOB/13k9VlsIw1xj/GZLRjVsnu9nRzKMPU//lap2HzrQLuc8ydpMId8y
 EfMeYNoaK2YHfskgUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.26]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtfJX-1t3NvH2t8J-016ruV; Mon, 17
 Mar 2025 09:43:40 +0100
Message-ID: <294b2187-64c3-491a-b9ef-45ed7861240c@gmx.de>
Date: Mon, 17 Mar 2025 09:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/15] arm: riscv: efi: Export _start symbol from
 crt0_*_efi stubs
To: Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.denx.de
References: <20250315221813.1265193-1-CFSworks@gmail.com>
 <20250315221813.1265193-12-CFSworks@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250315221813.1265193-12-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZxtGceD5Lj7t78K6qnG22c4If621M09m/uTBxPXlW6bAhod5M8L
 52mZSNAcnZI7mTXW/U4BwLvXjLOwFfZAPn1mBGPh4JWHAbHVPA+hguHkt4EjKWewEOq3CC+
 iZdO4j8ds97erMUIUstdvIjBqQVysNUdRCv3yP4FEUBoo5aUaUwrrqk79UhLbaqoM1e3p9R
 QSgQ7CVA1xooLmeQxJLkQ==
UI-OutboundReport: notjunk:1;M01:P0:4ZTewhadabw=;wTFJut61Msep4f1GAgudjH9kscQ
 2E7iondFx4Qzdm9N3rU3bhb67fXUULj8aFKSzQ01xPdDVyLJAv7ZjdEHr0yEKiMCPgnWANZ3K
 1jBHblqf3c9DS+qE0JcdsHFaIgiYzamQmqP2gEia5WJGLkWye25Yye+PJtjMP+KMe1zba+X1I
 k5kjs/D6Onk1IsvoVdWUTXBUqYqTsqqRBSlLms6nYQv4mo+BIDkFunFjkB9WHmjWD6d5vgNU7
 c6le8ISu5hjlT1pjqIT23EC6/2eThDmIe/DMZa4DRptwx/QsA6m/9CBNq7p47uxGe3QazqIai
 zR3YcXoxUOuMr6taAMUBtDfIBzhNoJ2VlRRSFkeIAt60pTh/KBlIvZlOu3SPAnRxGfY2+nh/k
 cCvzzXrByS5DUPUfZ2zvw/lkmQ0N+7KN6j3t6zw1LowArsUJ9EVx4m5aJ+oBvYRAisxgcpfJo
 vsf3R0JTbX0hgEHByf5JfJKcL8kgkFQHEz8bP0VdfZ0fCd0hM4cpLRT9kxPM751bQ1+TBwAk6
 0ZMvCV7bOnqPXa5ju+pzr7K/cND88yS6QVLcJZHDqbVD2oTOK0lbDBdclyW4/AD+qVAq937/u
 la4hlqvn97D84vq6FxTpsvBJvCRIdsPUoQK7gDwyrLiHFDGOlsJteoDvfyBt4Xn02o5bdNE0A
 JlTLt6nOt4AWYXLHVnvSAB7JJ36mrN9rZ2kF0nXgYS7W9nQxPMSXUL8BgJSjh/t2WXlocD+55
 tr5B1M5IybJelALHrgoWpNnfID2wFiQmXQPzLjsQVCP3GPR9bwZgta9ELN/F+gOZwkpuriNNW
 Qq5VLzXUBJWka7lhzaLJgOpQOz9S96t9iWzFnYRRF5rLxQ7LIce5v3OrGaqtjvTfdjnm2dnYT
 TJ8OQ4haf+iTb8Qd3uGAerHwIGiM3ko3hsL2lV7V/aU/BaSK0+fAKvBKIBMmuDTMjseeAaoqA
 8zPbOPWDFpuP2PtXXHptYmdPHG5oTT5s5nqeAUyNLGyJMZSRDlJYiy4+t2n1AevEIfkwLdf/T
 29hI7TAt02fKpiMJ1uCl/GXPxdK6l3mntYPJTtdvQTXOCk/2kDKFF6Z1eVvYfxAk4WFnzgeH2
 t0g5WVLWOxHUpTmWqMC/0HRf/FQpK8r8NMfycVoM0e2+txnPC2jlHSwwazQwNoTdVk7zB/7+b
 BeJ+tlEwtenKvu34KTp76atjfoI+xKQRpdmShGpWSp+qo3uHM5s+87uN2VzxYgQZRffApeiQ3
 yzex7oVDaUn+AqoEEzJ2zEjt3pC6Oq0xhadMc32p/ho657+nVJR72fCZJlcPEToK/WrQ3a1ZL
 7hIJMKYKBF6OcX18GfQaMxzrFL6Tou+sZATDOCcZ3a4bLuSy3TYZ2phgZ8itO1Jkt+4TbKenR
 ts8Bawj4rkoooSVYaunoCMn9zL5U0n85v71aFHSLdcSIDebO5MWf3lTAwJQuIOoZdR9v887wA
 z+KKsHKWQuJfwZaujpXgkT+oiLmY=
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

On 3/15/25 23:18, Sam Edwards wrote:
> While the _start label is only intended for use locally to populate the
> (hand-written) PE header, the linker script includes ENTRY(_start) which
> designates it as the entry point in the output ELF, resulting in linker
> warnings under some linkers (e.g. LLVM's lld) due to _start not being a
> globally-visible symbol. Since  ELF is only an intermediary build
> format, and the aforementioned PE header correctly points to _start, the
> ENTRY(_start) directive could easily be removed to silence this warning.
>
> However, since some developers who are debugging EFI by analyzing the
> intermediary ELF may appreciate having correct entry-point information,
> this patch instead promotes the _start labels to global symbols,
> silencing the linker warning and making the intermediary ELF reflect the
> true entry point.
>
> This patch doesn't affect the final output binaries in any way.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   arch/arm/lib/crt0_aarch64_efi.S | 1 +
>   arch/arm/lib/crt0_arm_efi.S     | 1 +
>   arch/riscv/lib/crt0_riscv_efi.S | 1 +
>   3 files changed, 3 insertions(+)
>
> diff --git a/arch/arm/lib/crt0_aarch64_efi.S b/arch/arm/lib/crt0_aarch64=
_efi.S
> index e21b54fdbcb..003d5f83041 100644
> --- a/arch/arm/lib/crt0_aarch64_efi.S
> +++ b/arch/arm/lib/crt0_aarch64_efi.S
> @@ -144,6 +144,7 @@ section_table:
>   		 IMAGE_SCN_CNT_INITIALIZED_DATA)
>
>   	.align		12
> +	.globl		_start
>   _start:
>   	stp		x29, x30, [sp, #-32]!
>   	mov		x29, sp
> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
> index 235b3a0c48f..593ee1e194a 100644
> --- a/arch/arm/lib/crt0_arm_efi.S
> +++ b/arch/arm/lib/crt0_arm_efi.S
> @@ -143,6 +143,7 @@ section_table:
>   		 IMAGE_SCN_CNT_INITIALIZED_DATA)
>
>   	.align		12
> +	.globl		_start
>   _start:
>   	stmfd		sp!, {r0-r2, lr}
>
> diff --git a/arch/riscv/lib/crt0_riscv_efi.S b/arch/riscv/lib/crt0_riscv=
_efi.S
> index 9eacbe4a859..f170e4b26d6 100644
> --- a/arch/riscv/lib/crt0_riscv_efi.S
> +++ b/arch/riscv/lib/crt0_riscv_efi.S
> @@ -179,6 +179,7 @@ section_table:
>   		 IMAGE_SCN_CNT_INITIALIZED_DATA)
>
>   	.align		12
> +	.globl		_start
>   _start:
>   	addi		sp, sp, -(SIZE_LONG * 3)
>   	SAVE_LONG(a0, 0)

