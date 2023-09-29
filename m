Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8442E743D5
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 00:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B8F86E61;
	Fri, 29 Sep 2023 02:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mmqWrnSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0823486E61; Fri, 29 Sep 2023 02:57:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C88DA86E57
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 02:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695949053; x=1696553853; i=xypron.glpk@gmx.de;
 bh=Adzx16/4D6HpqJGglwJkDNaY7Po7HtbFxWTxUmjujRI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mmqWrnSsMDo6qtRHHxDu9r+bNTAo+U8jBFafP9A7Kejxl68mO3rgcP7u1qNmXf92IEWCywwMRwy
 5dTxygv3UgIbL7WruYLyMhbyQ6zxi/KVZ6PNvXJ0XG42WT1ONUTGFfJfD4J9dk/UCa6G9If8dpIKN
 8JqLxiLoiWFLE4FNXYHZ+6E/hfqwhFzLxCFSpyqTEGOV6TkeUJd4R+72HMzWMWGraLMzFYTYrW79E
 EYCDUd983ui+j/Qt+sv+KFf2QCgbmdXd3wc/9pfkqDEnRmjES5mCZ7mWpGYbVue0mdQB2d8CiAQHg
 mUi7ct6/3dcfBVOJUO3Z7tSdo3DPRz8NdhJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbkM-1r4oBk3muK-00L1Lr; Fri, 29
 Sep 2023 02:57:32 +0200
Message-ID: <b99750c4-973f-48f4-9c3b-166f0e5e832c@gmx.de>
Date: Fri, 29 Sep 2023 02:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: Jump to image at end of board_init_r
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Chanho Park <chanho61.park@samsung.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20230927214415.2224768-1-jonas@kwiboo.se>
Content-Language: en-US, de-DE
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230927214415.2224768-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7yz5y2ltG4e2yPoWezTfTGfPKwr0Fx1rA9pBai6AJwbRN5r04f+
 SeavZUCjZc7ljWBaCD1u7GTSDUqfthzJY2KUtknBm5dq1HfxjvVNPepVm1k2HdfNQMCdWdx
 qTnBqUX9/Wv35bt69kRsdfReJQFWb3AikCsESlOMQh77w8Dh1GIZK4hYENmTeTwQ+UsEl/N
 V02jO1qjB1GQexwmH9qcw==
UI-OutboundReport: notjunk:1;M01:P0:dqHpsLHfUfQ=;zRrB39C8wqTTYb1cTz+nnQ+jVgL
 XNROroSyYV7sY3DW4UTBXu2lmkpb6WWPEs/nUZV5xsjysdtX5tU5rWWlmOb0O5shogT98I58k
 ytmgSY9LgqnuZ48UTuvuWmKDuN72dlZ8RIYpM8zShh3ONAEQSA5FEApeVF1altW0McwwbrK3D
 pP2LfloQNgPl2qgHZnS39mfTSWp+30IbkyLX0XPNp9vbReL43wK0rqd0d68rRJ032G/qaUAmM
 4RRDMkjfL+XQCbAwxExOUcYSIlMZlgiYuh+TdXvJCK40W2ohek0G67gGMKaCRXxPHFAjo/uJq
 V/vxE7ikd0w1i7/g7dlUamXxqu9wYiTANPOnwc/ZLRMPOwMAn06JE6ZBuItPXrP1NU+FFEMmd
 8qlpQ6vg6RiJETEK7EqIAIRBt83MqWCPFztbElCJBvChWQYVO4dcaMQLfPDaix60Z0zhGUwHp
 Mah55aO12QzFnO2gra+OMbskH3klgbXTia7e6K+sEUYzc3fRu+bwntv0P0V4h+/fstW1DMTsB
 pWgRjBqjOWuElR6PdPTTUg1FEcO3YRSssRC5uvBRGQ9+8+9JHBw7qjwnNBsAd4KZmyHNuef63
 4Wdu5/Hjsfr8N/g0/paZfkzNMxBx6O1P32lqqSfoolqOX56jXOF71DYFbeITGiMjIWWpjtDcu
 63N9KcCXAn7Fd8sYoOTeZ3DiJn6ERxur9dmpR+ZQhK5Vul3JV6vMl8sqfbuzlhXqvvI7DhV4p
 F4pggRK98EcFeHVf0K300iLjieNhbqCw6+D0jOck9PA240Hne57ZelQ9pWGmT38QK+6E0wAVM
 2BwUga0LFzeom7rHTtr/Kf+wfNp4XhCVtQVyTCKoS0ivKf1H38AIBugmaDNDWz+1yFrw91jFS
 xrY4YMwfuTZ8gCi89VCrTb/PfqY0YrMjKWaiLn5mX8zd8Fqknn2DRjM+06fyehG8+OrsF02FC
 3QTkvRV6CdxmkBh09mRg+Guz6V8=
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

On 9/27/23 23:44, Jonas Karlman wrote:
> spl_board_prepare_for_boot() is not called before jumping/invoking atf,
> optee, opensbi or linux images.
>
> Jump to image at the end of board_init_r() to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> This patch have dependencies on the following patches:
>
> spl: add __noreturn attribute to spl_invoke_opensbi function
> https://patchwork.ozlabs.org/patch/1827057/
>
> spl: add __noreturn attribute to spl_invoke_atf function
> https://patchwork.ozlabs.org/patch/1831366/
>
> spl: Drop the switch() statement for OS selection
> from the "spl: Preparation for Universal Payload" series
> https://patchwork.ozlabs.org/patch/1839731/
> ---
>   common/spl/spl.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index f7608f14e365..79c39820262a 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -647,6 +647,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>   		BOOT_DEVICE_NONE,
>   		BOOT_DEVICE_NONE,
>   	};
> +	typedef void __noreturn (*jump_to_image_t)(struct spl_image_info *);
> +	jump_to_image_t jump_to_image =3D &jump_to_image_no_args;
>   	struct spl_image_info spl_image;
>   	int ret, os;
>
> @@ -735,20 +737,20 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>   	} else if (CONFIG_IS_ENABLED(ATF) && os =3D=3D IH_OS_ARM_TRUSTED_FIRM=
WARE) {
>   		debug("Jumping to U-Boot via ARM Trusted Firmware\n");
>   		spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
> -		spl_invoke_atf(&spl_image);
> +		jump_to_image =3D &spl_invoke_atf;
>   	} else if (CONFIG_IS_ENABLED(OPTEE_IMAGE) && os =3D=3D IH_OS_TEE) {
>   		debug("Jumping to U-Boot via OP-TEE\n");
>   		spl_board_prepare_for_optee(spl_image_fdt_addr(&spl_image));
> -		jump_to_image_optee(&spl_image);
> +		jump_to_image =3D &jump_to_image_optee;
>   	} else if (CONFIG_IS_ENABLED(OPENSBI) && os =3D=3D IH_OS_OPENSBI) {
>   		debug("Jumping to U-Boot via RISC-V OpenSBI\n");
> -		spl_invoke_opensbi(&spl_image);
> +		jump_to_image =3D &spl_invoke_opensbi;
>   	} else if (CONFIG_IS_ENABLED(OS_BOOT) && os =3D=3D IH_OS_LINUX) {
>   		debug("Jumping to Linux\n");
>   		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
>   			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
>   		spl_board_prepare_for_linux();
> -		jump_to_image_linux(&spl_image);
> +		jump_to_image =3D &jump_to_image_linux;
>   	} else {
>   		debug("Unsupported OS image.. Jumping nevertheless..\n");
>   	}
> @@ -788,7 +790,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>   	}
>
>   	spl_board_prepare_for_boot();
> -	jump_to_image_no_args(&spl_image);
> +	jump_to_image(&spl_image);
>   }
>
>   /*

In SPL we are fighting for every byte of binary size.

What is the impact of this change on the code size?

I would expect that your increasing it; especially if only one of the
CONFIG_OPTIONS is enabled.

If so, NAK to this patch despite all elegance.

Best regards

Heinrich
