Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9FDC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE0E280B98;
	Fri, 14 Feb 2025 15:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="t/+Po1Dl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E7780C6F; Fri, 14 Feb 2025 15:36:09 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AFD80756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739543761; x=1740148561; i=xypron.glpk@gmx.de;
 bh=3HQ14xYW1M4vcMy+hPLT4nsQ25kzwjLxtgha2jC8pso=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=t/+Po1Dl+MhN9+s+XdSyMmjWXhqXLA1Hzeix2O8bdaAf2aviC02Z5QkA9Jd6wICy
 DhpNfDjblyIvTMzm6E2k4sZvrDmrKAJT+5NsREplG1azx9SDzjYnAGvEO9vwxM05z
 9QcEVjtO3rr4uxUiHfgkiQu5y5sqZvx36eE9P/e39FjXRHcKcPViBJl+7qQef2oUG
 UAVGhfTQgOiPkb6G1laW8IH2tOpcLDbZ3Zu8rBrbaZALg3eSfGQsBY83yopJ9ojdZ
 wyfEYIilIvpxFE7DQ+TKpjPDn9o/M1smmjtuHUjVjQs32QBd0QYSGTNInDdlUEuXG
 CuA9Mx0JlV4/8IE1zw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLiCo-1u0TeD20YK-00Opvw; Fri, 14
 Feb 2025 15:36:01 +0100
Message-ID: <67029ea6-5629-443d-928b-86578df8df6c@gmx.de>
Date: Fri, 14 Feb 2025 15:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/10] arm: add initjmp()
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
 <20250214140031.484344-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250214140031.484344-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:huCPgy5eT5H2hwV3kj0JH1tCsaDJs7B4e6CcYf82ULE0ijx1a19
 XnWrnuzxUiC+tKa5510Oo/4H7LIy6ITRLt+NqDDZ8yF+9EVTeaPQfdBpdnkaTkeJrjlLBS6
 Grq3RbwZMmt2/EgjaxNGzm01d6dFg9V4JCOc7t9xIIYEiHvzE8ugvKhNciwY3BpfmUHkH2Z
 c/dDwTF7D7jcIlKogHihw==
UI-OutboundReport: notjunk:1;M01:P0:qkY7dKwPKOI=;fNCAsdg7+K62Z0+YrgawP6B1s20
 QC28lLvMF71Thf3mSvLoBgD1ul8FOK1M/aBiHSnbzaf+l2jqORLyvD5BsEN2arHxAngwGH5xm
 xB/NxiKkfu7KeYEQ6VUHKgbevvbnr32S3/l+XUXjwGa0t9L+J57GbLFRD5Az9IwPXAcqb4pYu
 Lcai0n9k0wPYNTD587DhLto6NPfH0ouIBtKvwGtDAvmBvOgTA+W3ahHliA0E9gxyEjUMfGX7c
 1oxNCAo+c7n6IFRmxftdQVozpEJf/SMaMvr/9WwulUBrraCQBEbLHfE1GtWaV7106ROoRyeye
 pX0ePXoyw5FVvCsSQtY8fvglJSE2KbrtpHTcTKS5VkdiL/kkGAqDk+NW3B4kQQDlANZk+PaWd
 rRr61FCt8DgBnx/6dNgEateGwcL3i+ls7mjm5UqxICc/Las85CSab4Z6pkW9KYtJXvIYf5vKA
 yl+pM9agggVAfp3ogOXREKFS3NHlyQKzAri1NBfHiQr/7AlA+Whz0tsQhKa9wpw14bCcc6VhE
 pDdItmd6+NyuQFXn3sLl3SLQjkGJiY8tbWQ+dt9OelT33+bURGdXIwPUMouKjDVFNuwqpZk8e
 8DQNbom6w9+ZPn9ulnxtjVMm9qMlmHVh2Z4BwjOuEadre+h6gVq1yTWUOtU5Zv1EtvwPqO85O
 CMGtgUMIqdSG0Mse1G4X01mLfr+qEBdpXE/jiTNOtpLrZc+mp0eq0K+4PFDUmVrd9MQEj31uk
 dNH4zgJ/5Cz0IVijX9l6+9H0fVa1wNWIK2iUh3pfP6xbPEeIruR2WsiFJw9eS2xM/PoUtUlXZ
 OcLNhZoziZSaeSZEVQ80iD8LiM2LvbO50ax7qYyitOBfGDqRtVkSIwxpcaUBB+kcqtSGzVeqW
 ATsewZoZujOZXSupAKeePPV63F5lpeYHxDp34P+BiQgR2OMm4LMqdRwwDjaN6p5NvRHRjmn0E
 /ev+DGySP7lONxFGuoKStskK2DAhjFLq7+hSTk9kXuRJlPnJ27waLqfrhmf3ebGl05JbEcB/C
 zAJrSz0hExsVteELn4jNZ/cs7vgnsgbJ0VYbaeyQsWKxNDs/yAvuFD9fm9xZ9NlD2d8ZHYicx
 o/SqxTawAP0owNkJ/S1J25B/FBt2g47PvFofEIAEdtW4DXT0Iuq2+/fl32tIoz3vU6dXAkSpG
 JkEYnWGh5oSX9pporpEZyTRy9/sfjUENHuSyWFP/gI6WLl2GXf2X2mXEqQYP2pV24rHCO4NXw
 CXxbqfytvSc/AD2L4q5gxxCt2ossz7Wf80OQ24Og44FGeoJOocKRWWQLvD7Q3qGvQgXZovEIh
 dzrRwAjyW4Fm6oJEhBTdgypiAvcvfeEH4VHtVSgqsDMiDP0jKhvZpQp8zBe8bQZY3LfPMxyfr
 yoAJ+HIn5SsmwqKTA3g+CQ0FZe3C2eNoiEoZZ4Cq8ZxqrSnkrVrMb/tXsywkMqaDj9TpqQY+x
 jKpL3NWKZfx04tQg0OyPSnv7HWI8=
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

On 14.02.25 15:00, Jerome Forissier wrote:
> Implement initjmp() for Arm.

Could you, please, describe in the commit message what initjmp() good
for and why it is needed and why it would not be needed for any other
architectures but ARM.

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

Please, always provide a Sphinx description for any new function.

Best regards

Heinrich

> +int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top=
);
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

