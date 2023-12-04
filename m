Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E850C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 15:06:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9531687496;
	Mon,  4 Dec 2023 16:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CExHiPdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB80C8700D; Mon,  4 Dec 2023 16:06:55 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FEDB875E3
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 16:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4F6i56025350;
 Mon, 4 Dec 2023 09:06:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701702404;
 bh=FsIegAQ9rVFVK09pV9dMT6MnqIesHXJCxIu/fDZDclo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CExHiPdybUYwJjVELE/w0vEfRMEqHLfEt+w7O9dAEuvN3RQ+DU/0cbjfYi0NxlOS+
 tBY2dWT4CBS/cJ1dQBKV3K38vMLEJkRBpw1Y7BxZvle3nLgznMQ6838NVsHmk7BXTF
 ShF27a0aY11ONyNxbctx2pKKvwOJmRPGOY9taGyA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4F6i2Q007428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 09:06:44 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 09:06:44 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 09:06:44 -0600
Received: from [10.249.36.163] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4F6hd0108679;
 Mon, 4 Dec 2023 09:06:43 -0600
Message-ID: <5e41ee08-a632-4cb4-a568-5f0cd65a299d@ti.com>
Date: Mon, 4 Dec 2023 09:06:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] doc: board: ti: k3: Mention TI_DM argument
To: Neha Malcom Francis <n-francis@ti.com>, <marcel.ziswiler@toradex.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <hs@denx.de>, <christophe.leroy@csgroup.eu>,
 <mr.bossman075@gmail.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>,
 <nm@ti.com>, <c-shilwant@ti.com>, <u-kumar1@ti.com>
References: <20231204112141.2036907-1-n-francis@ti.com>
 <20231204112141.2036907-4-n-francis@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231204112141.2036907-4-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 12/4/23 5:21 AM, Neha Malcom Francis wrote:
> Mention TI_DM argument can be used to fetch a custom DM binary in the
> A72 build instructions for K3 devices.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   doc/board/ti/k3.rst | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index a127215ce5..15916b088f 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -320,6 +320,13 @@ use the `lite` option.
>    make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
>           BL31=$TFA_PATH/build/k3/$TFA_BOARD/release/bl31.bin \
>           TEE=$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin
> +
> +.. note::
> +   It is also possible to pick up a custom DM binary by adding TI_DM argument
> +   pointing to the file. If not provided, it defaults to picking up the DM
> +   binary from ti-linux-firmware. This is only applicable to devices that

It would only be "ti-linux-firmware" if that is what you had set as BINMAN_INDIRS.

s/ti-linux-firmware/BINMAN_INDIRS

Otherwise whole series LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> +   utilize split firmware.
> +
>   .. k3_rst_include_end_build_steps_uboot
>   
>   At this point you should have every binary needed initialize both the
