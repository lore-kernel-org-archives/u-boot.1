Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C07C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 22:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB5A809A4;
	Sat, 15 Feb 2025 23:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Cq/OgUl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5F880B98; Sat, 15 Feb 2025 23:40:38 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953B880141
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 23:40:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739659234; x=1740264034; i=xypron.glpk@gmx.de;
 bh=BUvdeL9TEru/VCxZvpEu8kH+dQOVIBzCD986Ji3RQI0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Cq/OgUl53J8t50DPn2qnRWTefysQxMry29XOIMVj5KaRfhPspUEZXVwXQy4FfmRn
 9S+YkfURNuzdCM2ikroHLhe3OKj5Vgdbo+pa1Gr9P+yeAjYrt5HurcMFqKteSzbJF
 scLmysIJkAi1ElEftXLrz4yJ0GLyu0NScuOu7VMQbl9hpygVAbE7YxBpB+RuNgkQN
 IqVYcETrBc+7hSZ6Y/Z4981UOvF6o5lhtFHAl07RLDb/Q4IwiABbMX08HxyJT7u01
 CsUh6XwJHQdC3zI2MLST6dAGnFNpG2MdRxsYcKF2qJ92B1tcJuXAemIYwo9DqISRA
 gKUmdNiadwqV/bl+VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.106.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzb8-1tssjY0Ffu-00IpW8; Sat, 15
 Feb 2025 23:40:34 +0100
Message-ID: <f14ea22a-9cf6-42fe-a47e-4f66721fdab0@gmx.de>
Date: Sat, 15 Feb 2025 23:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: lmb: conditionally include EFI loader notification
To: Liya Huang <1425075683@qq.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <tencent_13A8C17236A66023A0114CE9C9209FAC9E07@qq.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <tencent_13A8C17236A66023A0114CE9C9209FAC9E07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:taUXvOuyh38xqSotcS6a31pnVFTbCYaujBdxxPkK7HVwzzjXvxD
 Jxto1IepcYZjVvQJbqsPKQf95Zej/geINBgDkhWy71+FEGqkQ9pDPeSfORqi3AvBT4gIo74
 bQt92x3EXKGV/8WnjyxPtyNQE6bngxuoTxzNCxHbxTo8XKF4kszLucYboDSYL/zRLR7R2Wg
 +MCKT7LKn/q+YgIVSxxDQ==
UI-OutboundReport: notjunk:1;M01:P0:ZBLaxVxbKhI=;SAXYfV1TIpMQ1X0AhlB8PKNtI+p
 jO0g/AheBm+gvNn8vy5iaYjyuuLlFImwU//QxOt/+8ptYQPSr/c5Z+8RBEVyX/ts47fkd7+6i
 2f1GZaLbqeS9TVL94lFEIaGiLyaSHsTdTIDBAZcchdckcukl2WwkyXkkNaqtRiCkFtTnnG4Av
 5h8ISbzKFz+QZNcncmuJCr4dGCmG9IesKzd+xLRpNneN8IC7JDninJpcodFnrBE7bdERtFL/t
 09l9bhx3APXG9oW2NhePlQ1g0YPkc9koNdAy8frUg22VYk/qFjNs2w7NJm0Zf3eExcTM2qL6i
 g4dfL1WXCo+4JPvlUkdGoXMP+SrAUnwnhhQtF8rd2+195VbhJY00IdivJmwUTpvAcFZuYC+DK
 W360BXHFkbgN2xnokB20Q86LVtsa42UzwoQINyoHKnAtRjbJkxhz/RYXc0KZWxyhST/YNRlqM
 PYcQCH83YLFWZ/lwefIkFxA+mx6PDT1UwpvtVHTwYaX7K6FYAbeky1w9CdBV2WIqxsMOHD0Nl
 fagySnhj68fsVv0HgeZTJ/XWvSTXbuPtfS55EDA/0YJSquULFDG2xkWbLQekXZNdgC5csHhsK
 uMtiHzXr5sNcws6yNDUXAX+QADaGw4qRVz7KczRPmry/e3yYgnyf/nb8Qesq7M0aYbCkR1IzA
 dauRalzlvsJd+5RSM74WuDT47+wVlx24zywCL1xNIEJ8Wu3mjv3aTdCm0VRX5rRy8oX1mqos4
 LSElMANmJk2NYA4h3sArELo+BSfrsOJ6caxC7jtDTxKIuZUDfBnpwhBC3DCPX3qn8PCK7AoNf
 GbNB+n3A1P0JulsJ7BpKyQCzOkwTlyvW+a7uBxLTwxSF0IjuQpjTBnPuyKK1p20PUy9+o9nUA
 KMZZsrssVxLmOAwyhhZPsDIN24LPsr2z+qOSV9IX7pxAFT2bhlt0MfoavA7gPNSzs0QYBY9fK
 vvsVlK9b2Lv+fQP2mO2pWekNcawQDIm6YCWQC4mph2d+QWz55tIdihj040oMW4l32vvMZrkE3
 nrk0oWGKCE5uejrPb2/sKNcS/KdGxJfHFkEqkAzQ7yksXtAmfSK8lR9JA8igh4XLvumu6Meny
 cyfBGVkhKIrk6pRqg2Aue/r94+1TI228qppTS84oJgCpgCHvFWOkIy+denU7PU865FXzKh4Mg
 RUYqXTPbr+uoHPy4+ntycXphs+AuczE8FRKh38VyKXT1T+N1xHQv1G6f2+Yb/rNQzA7HE/J+6
 2r+keqNR+Dh1i4lTFK3CuXMFvsCaOyBNH1xWp9Agbcs+pEA69MUJ71uTcEHhaCPum4yYa6Sz+
 zD0LVxu9G9ayUUVkpmJq72O6STXeiK3mViS79x46x30uaCxdTwVMGYMQ+emQArc9XKYHUFCcF
 UI0orkUAwSB3cwdeU/uvsxT17n5NnJ7tud6Ndso5cBo4L1df0StCpAQTLpnQMIKJDFbCofOOd
 n/SY5Og==
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

On 2/15/25 04:11, 1425075683@qq.com wrote:
> From: Liya Huang <1425075683@qq.com>
>
> Compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy
> without CONFIG_EFI_LOADER enabled will result in an
> undefined reference to 'efi_add_memory_map_pg'.

Hello Liva,

Thank you for reporting the issue. It is reproducible with
qemu_arm64_defconfig.

We try to avoid #ifdef as far as possible.

I think the listener should be implemented on the EFI side of the code
to have a clear separation of duties.

I created a git branch implementing this idea:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/commits/lmb

Best regards

Heinrich

>
> The make command is as follows:
>      export CROSS_COMPILE=3Darm-none-eabi- ARCH=3Darm
>      make stm32h750-art-pi_defconfig
>      -> General setup -> Optimization level -> Optimize for debugging
>      make -j 12
> The error message is as follows:
>      arm-none-eabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify=
':
>      u-boot/lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg=
'
>      make: *** [Makefile:1824=EF=BC=9Au-boot] Error 1
>
> Using the CONFIG_CC_OPTIMIZE_FOR_SIZE configuration
> will not cause an error.My guess is that the compiler
> recognizes that this function will not be executed and optimizes it.
>
> As you can see from the lmb_should_notify function,
> EFI_LOADER will exit without calling efi_add_memory_map_pg().
> So splitting with the CONFIG_EFI_LOADER macro would be a fix.
>
>      ```c
>      static bool lmb_should_notify(u32 flags)
>      {
>          return !lmb.test && !(flags & LMB_NONOTIFY) &&
>              CONFIG_IS_ENABLED(EFI_LOADER);
>      }
>      static int lmb_map_update_notify()
>      {
>      #if defined(CONFIG_EFI_LOADER)
>          if (!lmb_should_notify(flags))
>              return 0;
>      #endif
>      }
>      ```
>
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
>
>   lib/lmb.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 7ca44591e1d..28d31308a79 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -430,27 +430,30 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t b=
ase, phys_size_t size)
>
>   static struct lmb lmb;
>
> +#if defined(CONFIG_EFI_LOADER)
>   static bool lmb_should_notify(u32 flags)
>   {
>   	return !lmb.test && !(flags & LMB_NONOTIFY) &&
>   		CONFIG_IS_ENABLED(EFI_LOADER);
>   }
> +#endif
>
>   static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u=
8 op,
>   				 u32 flags)
>   {
> -	u64 efi_addr;
> -	u64 pages;
> -	efi_status_t status;
> -
>   	if (op !=3D MAP_OP_RESERVE && op !=3D MAP_OP_FREE && op !=3D MAP_OP_A=
DD) {
>   		log_err("Invalid map update op received (%d)\n", op);
>   		return -1;
>   	}
>
> +#if defined(CONFIG_EFI_LOADER)
>   	if (!lmb_should_notify(flags))
>   		return 0;
>
> +	u64 efi_addr;
> +	u64 pages;
> +	efi_status_t status;
> +
>   	efi_addr =3D (uintptr_t)map_sysmem(addr, 0);
>   	pages =3D efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
>   	efi_addr &=3D ~EFI_PAGE_MASK;
> @@ -466,6 +469,7 @@ static int lmb_map_update_notify(phys_addr_t addr, p=
hys_size_t size, u8 op,
>   		return -1;
>   	}
>   	unmap_sysmem((void *)(uintptr_t)efi_addr);
> +#endif
>
>   	return 0;
>   }

