Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A918FC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 16:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABF387BD6;
	Thu,  1 Feb 2024 17:19:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="XNK4hBv8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8432F87BF4; Thu,  1 Feb 2024 17:19:18 +0100 (CET)
Received: from smtpcmd11116.aruba.it (smtpcmd11116.aruba.it [62.149.156.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67855875FA
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 17:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from [192.168.50.221] ([84.33.84.190])
 by Aruba Outgoing Smtp  with ESMTPSA
 id VZmVrLLPQZ3lVVZmVrbnU5; Thu, 01 Feb 2024 17:19:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1706804355; bh=9+t1YOQ0mx6GW9ZYrBdZ9RvwWJKQB3NLTCE+Q6AhKZE=;
 h=Date:MIME-Version:Subject:To:From:Content-Type;
 b=XNK4hBv8s/etSjGyZzarDKm9KaghoEqzYtZwn0GbkVu28+kFfaLBpG24nkRNYwkmx
 1D+pdFixozE+mfAB2tm3U4DH8vVnrsE/TUesgPln2fIr1RyLrOWa9oF1qc6Eggq/3O
 YNYuekSmzKHx+MUU5NtayOgwhHXq75twaE7rC5pvdUuBdTNHlzIRR/kt4XDOA5/8sf
 kl8Sd+sJcsGp7ajhp/d8pkRjjkxFSxs00y2x4zwD3sL0slUwLF1SdG3Z0YE0ynzMcI
 0Va3pTSvW7/NjtCRlnz7MQfVpgfooBKpt06n3MyvZGfloH0q/vCSavQzXXC8fAUUO1
 xX6A8xYLnNxHA==
Message-ID: <d3f9a32b-7516-4bd0-9b34-dffdae1f2e16@benettiengineering.com>
Date: Thu, 1 Feb 2024 17:19:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] doc: imx: imxrt1170: Document imxrt1170-evk board
Content-Language: en-US
To: Jesse Taube <mr.bossman075@gmail.com>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alon Bar-Lev <alon.barlev@gmail.com>
References: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20240201150004.1343366-1-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDlWu62M1VmHDUHXiLxs2BkNbaugWwElcnCL9Pm5vRyy/+4+ktHGLeuoMDRnwGMIG/KcKvVypXIm6bAxeIrjewtq2pc2CFwuShWqxEEvLaY/k5LAFVwl
 EhdaEJfwePBzZ3NeCtvxYrXQkRIyTUme9Y6D3F5GkUT647sILEB0Cbmhmuim7yg4XBAdyAHuCwbsiiUPzzIVJMdaATaxD/WLJaLIZo/PTnNBzLX43MSGXxRI
 5uq9cW3OQPNsjARqZpJaB3457/uwQRruT6tgBobT+ub+eaTh/6bhJTbL/dDqBv1jWW//+S36i4f2h9hiSVsvTYqWA6JbNJI1TG6q5zZUvPou2Ky8KlmRNmoR
 KP7E8XwjtLIQnKSNY7VKEztRk/GH6Q==
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

Hi Jesse,

On 01/02/24 16:00, Jesse Taube wrote:
> Add documentation for imxrt1170-evk.
> 
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

looks good to me

Reviewed-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Best regards
-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas

> ---
>   doc/board/nxp/imxrt1170-evk.rst | 42 +++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>   create mode 100644 doc/board/nxp/imxrt1170-evk.rst
> 
> diff --git a/doc/board/nxp/imxrt1170-evk.rst b/doc/board/nxp/imxrt1170-evk.rst
> new file mode 100644
> index 0000000000..4acccdcc93
> --- /dev/null
> +++ b/doc/board/nxp/imxrt1170-evk.rst
> @@ -0,0 +1,42 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +imxrt1170-evk
> +=============
> +
> +How to use U-Boot on NXP i.MXRT1170 EVK
> +---------------------------------------
> +
> +- Build U-Boot for i.MXRT1170 EVK:
> +
> +.. code-block:: bash
> +
> +   $ make mrproper
> +   $ make imxrt1170-evk_defconfig
> +   $ make
> +
> +This will generate the SPL image called SPL and the u-boot.img.
> +
> +- Flash the SPL image into the micro SD card:
> +
> +.. code-block:: bash
> +
> +   $sudo dd if=SPL of=/dev/sdX bs=1k seek=1 conv=notrunc; sync
> +
> +- Flash the u-boot.img image into the micro SD card:
> +
> +.. code-block:: bash
> +
> +   $sudo dd if=u-boot.img of=/dev/sdX bs=1k seek=128 conv=notrunc; sync
> +
> +- Jumper settings::
> +
> +   SW1: 1 0 1 0
> +   SW2: 0 0 0 0  0 0 0 0  1 0 0 0
> +
> +where 0 means bottom position and 1 means top position (from the
> +switch label numbers reference).
> +
> +- Connect the USB cable between the EVK and the PC for the console.
> +  The USB console connector is the one close the ethernet connector
> +
> +- Insert the micro SD card in the board, power it up and U-Boot messages should come up.

