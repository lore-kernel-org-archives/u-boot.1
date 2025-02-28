Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2224EC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04BD81111;
	Fri, 28 Feb 2025 14:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="apLcVJ75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5A558118B; Fri, 28 Feb 2025 14:05:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C98F3810ED
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740747940; x=1741352740; i=xypron.glpk@gmx.de;
 bh=IehGVoo1uLIQbkqZQ+QucliuasetewPAlrsPk/UtYt4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=apLcVJ75hc0aRz9aCjyZN/o0yYZyWdwzWttDSaXwW4DIU6Is/l+NnIl5j3v/ad/C
 C9VF9OuUybNMW+nc0019in3ZvJ+tHi5teeqgakgx7CO4Oww7mE92Kxr9TTk/5NB8a
 7z2P5AY2PLdggZwH+xH4m3cPjY85AUYDRFIXhmOg6+pRXVSOBFLq068bprS694UX2
 lW6iiCWTSlvjpLIn5C/J1y2vDYOdgAwHFU4x0cQzMiCIlTLjT8uDlZLA+tCFNo5UQ
 M6SgyDSuC4uZDXJxPfaXqP2wBQVLrrzZ2+0GE39U5wn/wagqzsDLAnHii0AMqmjxj
 ugSHt9RZJitkM4MDkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1tpNEh1d5z-003ahl; Fri, 28
 Feb 2025 14:05:40 +0100
Message-ID: <2a3e72c0-30d3-4f52-84c2-81d34b2a4286@gmx.de>
Date: Fri, 28 Feb 2025 14:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gl/xSylyQ6IariMorStqMgoUSctaodVu/UCm1Rk6usrfy0Rs3nY
 5XdwjnRlMsRm08yAjoYbEP+Qu9HpeqKMzL12KoToT/jWC1HaEQvjBQYEeHk+nxOXWfWDp07
 3hOInqrsSgVuCvCHIEvDhpRplFSq4G4Lc509/t0ERTbaUiu40HIuoX6GsY91cQBgR6gOFfb
 3uEA0sLFASnA7l6CZeCHg==
UI-OutboundReport: notjunk:1;M01:P0:BYLR9z6yDtA=;Kf6sObr9pOx0chap6HVSJmSucA/
 WD/ielROK4hGkNKErelXiZYW8Uy8C21YcmQfb6m5hX9ByTMcGEQpg8A27r3hh5vQ9zH966G/t
 ONneUqZ+X4sLWHdM/HceB34ssB6iu+iddmAROqxF6/YYjWqT83ngrZTigw/dlf+fQv/d7O5LU
 25OCQ/PyvDX/93kslI4N+WXGaH8BDOR88JBNkJNc/dkAFRKeQSWHQlNG0Bsm4P3iMw4Vqc6i7
 3is0BT9iJY0fI3wvcBcU/cpcVjrxkuqTefixraCn9s562LzreyzqnO6sZbMLa34LVLoQp5EDh
 qr/a6sHnkpjJ/Y29iQUYuNjO9lqe768RjtrmEFIxJ7z1unlPnHqv1/QmhvUwP//OvvtFQarS/
 VUBtPw686MeuMZ5W9iyrQPxWvYQ1K/YznGf22qDcNs24t8SX57qt7rVtnK5wRlYfZ3TfvWQ7E
 hW4dtu2RXzud1Y4lxwA8WxLV86VDh4PEWiFw5ZuK6DsQL8CR87PNqpyRpqlFxDqTzp0mWqvr/
 rG2X0z1BgIFOTbwgI9K9RBHW6GuutqGCoSQBcc9ThuwAcovrcIcnv3zdzgHaUH/Bx5oDmX/Qh
 +P/pNKNSdb53VHr+ZwSnPL3ohiweHifO8UuKzKy/F3JKPIBO2IvZRz/zwh+r9D4V+JBGguclK
 IfzYl8aQ49z8EwCjXYXSlU0uCbp3V3S78LFtpT95g8pGDAsJaRzyp2FTlQJERqQUuTlxzco9/
 SXpTvvmzZk3A03f9RaRHAY0shY9uxYj7bnZYjYwcZeORBRC+W4ujaJ6cUXlFT6VQbd0JkrRxN
 n9EfWAmDWRkjsTTv5lTd9QRTeowPQevdpIQ9IDzXc8rTuwolEwfBUlU6+56jP0wHbLRC8n8ZS
 mmxwROKYrA6vRzWvq5JcJDa34ZDEjZ1I1LCaPILc9EFnplKo+b2aD/sCcDnVEFLy2A5UbtePG
 TyE5zlAKAce6NtRNDG9DjKV7c7PxQWBSo0/JOUeFh7/xSdQsEPhMgN3rafuzDvNdJyxNm+rHt
 oc4d9s+I2RTdb9NFzwc0ATNO2jggZqlGakJ7bieE1Q6w62vAiFdgGV+mjSX9Xgh/uWbLTI8F7
 5rZQFa2WTRfniRyic6+jXGOa5OuYI0R3OcNxZaOpDmC26zIV7d7LgEPUKdQr5K8zRJv42YfFu
 XISnl3oQPscbri7FhmNzq6CP7kgWZWr6SdQ34KmfLqTis3et2177mmMedtvTfnZutzBCQc5Bk
 VWQ471lgRuqqiNu5muq9YWU/k7QhAqaIxOVQUwp7e4gafqgKixzd91w6rBy+61FghtkKg8CE1
 66SoAzUlos8zTEaZgyL8CPOdNZ1YeVfxSGj2gwLZ1yYSB8dOru3qnoEcW/IvaROrL3JKGCcc2
 auR/ZCLTehpG+ULwc3Cn0pldug6Edia70tlbIq2CCo2wuXFVD3O4Zx5JBp
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

On 25.02.25 17:34, Jerome Forissier wrote:
> Implement initjmp() for Arm.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   arch/Kconfig                  |  1 +
>   arch/arm/include/asm/setjmp.h |  1 +
>   arch/arm/lib/setjmp.S         | 11 +++++++++++
>   arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
>   4 files changed, 22 insertions(+)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8d5b54031b3..57695fada8d 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -94,6 +94,7 @@ config ARC
>   config ARM
>   	bool "ARM architecture"
>   	select HAVE_SETJMP
> +	select HAVE_INITJMP
>   	select ARCH_SUPPORTS_LTO
>   	select CREATE_ARCH_SYMLINK
>   	select HAVE_PRIVATE_LIBGCC if !ARM64
> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp=
.h
> index 662bec86321..1ad5b500f2a 100644
> --- a/arch/arm/include/asm/setjmp.h
> +++ b/arch/arm/include/asm/setjmp.h
> @@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
>
>   int setjmp(jmp_buf jmp);
>   void longjmp(jmp_buf jmp, int ret);
> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top=
);

As this is not a standard function we cannot expect developers to know
what it does and how to use it.

Please, provide Sphinx style documentation with the necessary information.

Best regards

Heinrich

>
>   #endif /* _SETJMP_H_ */
> diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
> index 2f041aeef01..320ddea85f9 100644
> --- a/arch/arm/lib/setjmp.S
> +++ b/arch/arm/lib/setjmp.S
> @@ -34,3 +34,14 @@ ENTRY(longjmp)
>   	ret  lr
>   ENDPROC(longjmp)
>   .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +	stm  a1, {v1-v8}
> +	/* a2: entry point address, a3: stack top */
> +	str  a3, [a1, #32]  /* where setjmp would save sp */
> +	str  a2, [a1, #36]  /* where setjmp would save lr */
> +	mov  a1, #0
> +	ret  lr
> +ENDPROC(initjmp)
> +.popsection
> diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64=
.S
> index 1b8d000eb48..074320d25fb 100644
> --- a/arch/arm/lib/setjmp_aarch64.S
> +++ b/arch/arm/lib/setjmp_aarch64.S
> @@ -39,3 +39,12 @@ ENTRY(longjmp)
>   	ret
>   ENDPROC(longjmp)
>   .popsection
> +
> +.pushsection .text.initjmp, "ax"
> +ENTRY(initjmp)
> +	/* x1: entry point address, x2: stack top */
> +	stp x1, x2, [x0,#88]
> +	mov  x0, #0
> +	ret
> +ENDPROC(initjmp)
> +.popsection

