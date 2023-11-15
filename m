Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB38C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D9E86F18;
	Wed, 15 Nov 2023 11:02:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="dAMY5TCl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F5786F31; Wed, 15 Nov 2023 11:02:44 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266F786DB8
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1700042550; x=1700647350; i=xypron.glpk@gmx.de;
 bh=STQKLHVI/OrwtyiE4OwoXBPRc7wf+uJDbZSt3X84ur4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=dAMY5TClk8nnJq0mzeHjLghTNiP8ntTMoLVHpFzAWtRlizUKd4lX4+okxKVV/HQ8
 MdoohM4+bE5xvfANxik4SGY0ntysNCJIBPJcXsz4nojEHo9cfOYDAsIGJHC5wQhQG
 T/FmZbi/APday/zELklFgp/IU6XrPGgiRxQQziOS4YNxRbDgbfvPurPOKDAiKv2iO
 K5uRCXY47sxCtyzzTE4bn7GLkebbpRdfig7RH1K10/StfE5/8owUvE+UNsM3vr6FV
 iH19WcRYGER06N6FhE2sPirW/HnD1QdLiGhkw3imqmVWDaEgnYuY70IxS23sTblJl
 M8IUXB3WWgpnouMdkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1rfZru0ejk-00ng15; Wed, 15
 Nov 2023 11:02:30 +0100
Message-ID: <f5201167-c4a3-4867-ae9f-6110f685652d@gmx.de>
Date: Wed, 15 Nov 2023 11:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/29] mmc: env: Unify the U_BOOT_ENV_LOCATION conditions
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Peng Fan <peng.fan@nxp.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-3-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231112000923.73568-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fu3mrBrgj9pDYotbM/CY4N7hyGNVn9T/0Hhdz1EFQwFqbFLhPJx
 MBOP3BAFCMukDTZRNMd/iVNow/V4eSV5SdwpnTgxb5hcEB/kbkXdqFGVWEHoEzB9wFzI+wB
 6BCQkuDGMiOqAjAQL6PO/+h22M8P+5SUvP5DDywN13A9Hi/ZIoCdzQTMl+7o3zP9SBO5vnX
 EOxlxiTxYPocuL1T/6Rvg==
UI-OutboundReport: notjunk:1;M01:P0:gPPMdkNhlOM=;vgOVUWzLV0XNoKgtd5DgyXu7PlQ
 TPiO/LIG6fgyXPb5kC09bx5Ftr7oDkPgB7fPmIA0s2udgafG68nP3DsdAbcXPpbVtt4qrcEeq
 Pk6AOvsndHkhVhtgtFUSKFQU++chvH8pyt1h7YTSiuyK7X7N09LrBuis+n2Mciz7BR30LMY2r
 SkEpKzpq31EKcTfMsF4yEaMAVcZs+oX3EIG4YdQcabRUCO0TKTMPCxlalFAfJjEA2O9i5kJtS
 +VD6MhD39Dl2BMil/Uk91IK8d8a28XU+l4fzwXb5D9dXcz7iZPYrD535WG8zsq6GVRbkStA2l
 3HMipguS9zeJBpar8dpfUNNgMPQmy7ouyCILEx+YMFFQUgovewJ8bXoZg7DVaMAnHZt+bWorM
 DJytLx67jSN5xvouoqbVYelTth+49aABsrz1NaZwfzkvJONTs3larOxEwV5VzDQkPim1mTyqC
 npCpWjXTuqjqJtzmN9mkVtdfkZOiVg5YubSJPNgDCJuPxokaNzd6IikwkQ/BG9t/rlmxYuHnD
 LtrYlyecQPhNSRo5KUzv/O1YQ7no8682jUdy9iwKqOng2VCcyuqU9MgF0PDKUUihI4WtnH+06
 zXkIoW5RF99roJinkyheTUy0+TuXql2ZpY9WA+zdx4eenrOdVox/niZw6W+fLJ4q+5zOBRMqO
 41sxn356lNDC0rc7QqH/gmYamEitMy27S72QlBvTdpyHYyRdQz8EJ5avvuwVlgTv+0lU37V/3
 Gs4bF/uYXig/aXo4zpN/Yic/8BgXEx+5ixyrhRDY9aSPwHd5sEdwhlWxURowmHtaZ7biOlvQR
 +a
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

On 11/12/23 01:08, Simon Glass wrote:
> The declaration of U_BOOT_ENV_LOCATION() uses a different #ifdef
> condition from the code it calls. Use the same condition to avoid a
> build warning if CONFIG_CMD_SAVEENV is disabled.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   env/mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/env/mmc.c b/env/mmc.c
> index cb14bbb58f13..da84cddd74f0 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -495,7 +495,7 @@ U_BOOT_ENV_LOCATION(mmc) =3D {
>   	.location	=3D ENVL_MMC,
>   	ENV_NAME("MMC")
>   	.load		=3D env_mmc_load,
> -#ifndef CONFIG_SPL_BUILD
> +#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)

According to README CONFIG_SPL_BUILD is not defined for TPL builds.

I assume that we don't want to have below fields in TPL either. Please, us=
e

#if CONFIG_IS_ENABLED(CMD_SAVEENV)

Best regards

Heinrich

>   	.save		=3D env_save_ptr(env_mmc_save),
>   	.erase		=3D ENV_ERASE_PTR(env_mmc_erase)
>   #endif

