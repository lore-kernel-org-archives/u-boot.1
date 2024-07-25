Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5700DC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 16:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CAE879AF;
	Thu, 25 Jul 2024 18:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lBHv9rsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37420879AF; Thu, 25 Jul 2024 18:31:58 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E1486463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 18:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721925114; x=1722529914; i=xypron.glpk@gmx.de;
 bh=Ob2UHPMrNOtNH4LlkCjciskiK80Q5vQHV3aEOZWSHVA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=lBHv9rsu/qHcO9lqBvKdxSGb2TInHFQmj+VX6HThB2jHpXXihTm9r2sbi5wc5FPd
 4826LEVgODbrrSAJL6c30kDDOqNmRJfsDvQ90+vpvYJn2M1W2/daKFuuCHLdYzqsS
 mJGmJ/ZlGE0LSQCcis/XSN+qWAWO2dsBEQwfII45Zt8kITh1aPIhkYg1AHw1OYZ+f
 0fJHS4JQkltlpGEGmu9VpofTg1sHjpWj2ND7OP4HGVrdzIyKMb3Jua/lAifCQjxhs
 zNJfVoIfKtOOT/z2Y+aJnY8+vrjZGpwqyibftyWD+3WPcycpCYSys2r55gZictgH6
 r3XqGyi0peWT8X/3sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.93.80]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1rr2mY3wWR-00nkyn; Thu, 25
 Jul 2024 18:31:54 +0200
Message-ID: <e4e7e085-aacc-4c2e-99dc-924a1ef22c46@gmx.de>
Date: Thu, 25 Jul 2024 18:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] efi: Show the location of the bounce buffer
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240725135629.3505072-1-sjg@chromium.org>
 <20240725135629.3505072-7-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240725135629.3505072-7-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+EuSaHnYCJG13TbFkExUQEs3oUO0QX9ea+1bH7eezB+neyCia3A
 IMGcNTRZSj6HT+Spv/nI6jgcg27yLT+0iRt2KkWY/yKPLy+EfKqEg4HdkRcEPSkhZe1ruVy
 0QoJRy1KvwQ8YT6Av9NMSWDUasnquzk62S9dlK+wq88OEYL09X9xhpPY+VP5yaRvmaMlqJC
 ka93024Czka21hiqCQiiA==
UI-OutboundReport: notjunk:1;M01:P0:N/c4c6VlzC4=;E3o3MyY6t3mMqxnI9Ebc3aRxMec
 g6r0zmsPS0+OWhqqtU2n83ibr1f84k7vuQio7JeBpGdmeT7kIrrWL+NNsfsu9xizRTITOKfmS
 7y7qY+SUE9mI4asBsa/S1XJ6wp/JZ/Ppv7Lns+8cA0p+qpH6VrftipGMUE5EfHPRrw1+9jJ4B
 5AnNZmdqgN/R0LXSJgam3wdWq5K7IWbxh4nR8j7C/d2W3g1eksClQsYIhQc/VISWS6NseQgQV
 BILYmEIsVf10tofVdqY3xZFkYQaxR6P/2O3AYn15alFTnm74NZ+Rwp1Ry+L4114Jxk2HubNql
 /daX8obbvuk2unuPR9EuyrSiGVkOUPSkkqS0inZoUbJaDd2wtGKZC6TWPoyN+KA7bqlIrwCEl
 +T/ECC6QvwrQ43+PLhwll05kR/ZoUwwjGWMNPTY05HzlehBtf3oq8uBDE4Zv8Ka/V1yx7kBPI
 5rSUxbm/VhspH3wSqK/dcn6IG62za9paLtbv5Pjybr7zRR+zOZ1Hl2D4UllTjp4q5KX/qM/cS
 4c3vKGFUl7ZuRwUOO4akfUpiF/8KhT7lr8KH96o34kHgKEKdtsw/54VCUdrX2/AW9tjr9HGGT
 06YLrDhBwagPXrHBi4tgMWPXPU2wY7QKg4mUeYmCKZ4mIUVM79UlxgTBpPhMmXdam04ADW7jb
 dge7zPnZ10gDBLgI/4AI1Ov9FetvZJf0WUzzKnjnGVFvkNfy7cU7N4hQUBQNdu9luggkjf5g+
 e6LZ3oZHajg8izQ06p4Km39BJBHfga6M3I4cySHz3u2xCJJXF8oZkwslAw4n8er6hcJxptEjv
 G5ZTl7N+NPJZAamOFNoHXk8g==
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

On 25.07.24 15:56, Simon Glass wrote:
> The EFI_LOADER_BOUNCE_BUFFER feature was added many years ago. It is not
> clear whether it is still needed, but 24 boards (lx2160ardb_tfa_stmm,
> lx2162aqds_tfa_SECURE_BOOT and the like) use it.
>
> This feature uses EFI page allocation to create a 64MB buffer 'in space'
> without any knowledge of where boards intend to load their images. This
> may result in image corruption or other problems.

This is what Sughosh's LMB series in addressing.

With CONFIG_SYS_MALLOC_LEN=3D0x202000 for lx2160ardb_tfa_stmm we cannot
move the buffer to malloc(). I don't understand why
CONFIG_SYS_MALLOC_LEN is so small.

>
> For example, if the feature is enabled on qemu_arm64 it puts the EFI
> bounce buffer at 1045MB, with the kernel at 1028MB and the ramdisk at
> 1088MB. The kernel is probably smaller than 27MB but the buffer does
> overlap the ramdisk.
>
> The solution is probably to use BOUNCE_BUFFER instead, with the EFI
> version being dropped. For now, show the address of the EFI bounce
> buffer so people have a better chance to detect the problem.
>
> Note: I avoided converting this #ifdef to use IS_ENABLED() since I hope
> that the feature may be removed.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   lib/efi_loader/efi_bootbin.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
> index 07c8fca68cc..53e5e429d2e 100644
> --- a/lib/efi_loader/efi_bootbin.c
> +++ b/lib/efi_loader/efi_bootbin.c
> @@ -211,6 +211,14 @@ efi_status_t efi_binary_run(void *image, size_t siz=
e, void *fdt)
>   		return -1;
>   	}
>
> +#ifdef CONFIG_EFI_LOADER_BOUNCE_BUFFER
> +	/*
> +	 * Add a warning about this buffer, since it may conflict with other
> +	 * things
> +	 */
> +	printf("EFI bounce buffer at %p\n", efi_bounce_buffer);
> +#endif

Does this sound like a warning to you?

There is nothing that a user can reasonably do when seeing this message
while the board is booting via one of the boot methods. So we should not
write it.

Best regards

Heinrich


> +
>   	ret =3D efi_install_fdt(fdt);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;

