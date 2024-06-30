Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C7FC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 12:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211C2885E1;
	Sun, 30 Jun 2024 14:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RyQb0tvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D885788621; Sun, 30 Jun 2024 14:55:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76DE88481
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 14:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719752105; x=1720356905; i=xypron.glpk@gmx.de;
 bh=ikaQcDDRxggWxEW89PbsOvwoB6YdNUf9AIIx/QxNmGQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RyQb0tvUfnU+o68Ui3PpWg55eE2LqlEYwth8lUcKIB457FnOhXVBXpHs4IG+oqiU
 yWPOxv7nRiFbWv4s5t+Udv/fS44FQuoabu2N+kXEL6cBOS4yfqG7/0iTe3SZkbwmH
 pvXMm5NNbP+cSr0d6tPYznsZn1Er0TOMmasIYK2o0U5icAqV/MDSb7uxcJitYlrHj
 j11gAIG7Ua902r4umUZlw9TSpFl7pOJQyGuw2VX23+l8QT1v7R5kiZulHWOWKsAD4
 dzbUnmgW2EfxP0m0oO/Xxu501lSElkbFTbL+6oa4bpniF8kKPJnoU+XoTaqBsOHwY
 UZW7yXvsntI2UhLxNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.41.25]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1rp7Qh3g3v-00bTJz; Sun, 30
 Jun 2024 14:55:04 +0200
Message-ID: <053cc180-266b-460b-aa68-0adf241c4934@gmx.de>
Date: Sun, 30 Jun 2024 14:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: add bootelf command documentation
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>, trini@konsulko.com,
 u-boot@lists.denx.de, sjg@chromium.org
References: <20240630103703.49318-1-Maxim.Moskalets@kaspersky.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240630103703.49318-1-Maxim.Moskalets@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SuT1cq29fyKebLsLKgeeUBwDj3mkaMidDKioVJnm6mA6lImN76j
 +Hj1MowQkxdt1FfDfs/AwwFd3oKFVQnb4C67ep7t/egF4tddJjt3MFXYO4Lsmte2sXh/crC
 tfLwGYMl8viPaEAODZ4qbl70HUQX6xkiWKJ3cUM5R5WzD0jUIqx5XW9HnsPRvjG7F/KdBFL
 TN9/2doW62K70bA0Xip6Q==
UI-OutboundReport: notjunk:1;M01:P0:ZJTrDGVUt7E=;mEOgpkgPXJS6ejBUwykSP18a8uS
 bw7QfQ95v1ZzwZkYVVckla6kzdWNba6caNNK5d6TfqFrnfSvGnbsZCHnQJ3NsQyF19S0HWIR/
 UUdcNeNIw4Fukeye/5Vr6In1YZZpd9sk8GOzF8WoB4DN0jXoDv3vJqvDvZovMa1PM5p72W8DA
 BunISEHaJQWvzt6zaZr1NQubFvjRh0D1D6lv99+gX0HZGcUAtuPwvc+P1sFRWht1EH3QuDnfV
 qnX3nw6N2duiLyYgbkijBMI+VEddg/t9aIsJHAgSrezMsUrpq4pfGJaSOzxZCfqrJ4NXr3YUP
 /mcByOoKikDTAFhCGYLndhodXHFNaPvhcPeZ9ZkUnLl29TsOCAtQ9CxPuj115MKcSi6bR1YFv
 pc3s+0/izya4fIIe3Aua4OT63B/FXFED7PmIH5bWCRzUzDcibQfNMcj+1AUKrCokU5KlwzM7q
 YYJCYxZmd0oyiQ5U8qLnCe6ZIR919JMRlAsCYyMhD8xDytJqf8yAE5fjrJ1Uo+BEbcHNSsGKq
 YizSjVP4i7ribklBC0DVR2EQ6gY3sFjU0uzeezugROVH0C4k9mwZc2ye358K71fuHIT1aSTdU
 a0RDQB/tewTIokRbHVGTyK+U+VJcKFjLxHoYQ+Tyy7GDG/MYzrC3LudmSTSND7nFjOFOnEVn5
 H1kwiaBuIvPgZDRNV37SOTI88WqGSvwTbHZvRmRQgTbUTAI5YmTjbXPVkcQKR/aoOp4raXRM6
 SqZLtcQIp9IyrVScPcM9Vwz+SrVJGkruL6/tqcZN1HHJ2PNzM+lcA88oQLaOHqJCUtsdHheCW
 HGyv3Uiuq2C8jTa9uIkgtUDIf8q8FDE6Dje+kfsBq6WTk=
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

On 6/30/24 12:37, Maxim Moskalets wrote:
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>   doc/usage/cmd/bootelf.rst | 52 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 doc/usage/cmd/bootelf.rst
>
> diff --git a/doc/usage/cmd/bootelf.rst b/doc/usage/cmd/bootelf.rst
> new file mode 100644
> index 0000000000..5472a90fe2
> --- /dev/null
> +++ b/doc/usage/cmd/bootelf.rst
> @@ -0,0 +1,52 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright 2024, Maxim Moskalets <maximmosk4@gmail.com>
> +
> +.. index::
> +   single: bootelf (command)
> +
> +bootelf command
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    bootelf [-p|-s] [-d <fdt_addr>] [<image_addr> [<arg>]...]
> +
> +Description
> +-----------
> +
> +The *bootelf* command is used to launch a ELF binary at *image_addr*. I=
f
> +*image_addr* is not specified, the bootelf command will try to find ima=
ge in
> +*image_load_addr* variable (*CONFIG\_SYS\_LOAD\_ADDR* by default).
> +
> +Args after *image_addr* will be passed to application in common *argc*,=
 *argv*
> +format.
> +
> +A command sequence to run a ELF image using FDT might look like
> +
> +::
> +
> +    load mmc 0:1 ${loadaddr} /kernel.elf
> +    load mmc 0:1 ${fdt_addr_r} /soc-board.dtb
> +    bootelf -d ${fdt_addr_r} ${loadaddr} ${loadaddr}

Thank you for providing this man-page.

Please, move the example to an Examples section. See other man-pages.

> +
> +image_addr
> +    Address of the ELF binary.
> +
> +fdt_addr
> +    Address of the device-tree. This argument in only needed if bootabl=
e
> +    application uses FDT that requires additional setup (like /memory n=
ode).
> +
> +arg
> +    Any text arguments for bootable application. This is usually the ad=
dress
> +    of the device-tree.
> +
> +Flags:
> +
> +-p|-s
> +    Load ELF image via program headers (-p) or via section headers (-s)=
.

Please, separate -p -s into different lines.

> +
> +-d
> +    Setup FDT by address. Available only if CONFIG_CMD_ELF_FDT_SETUP is=
 enabled.

Please, add a Configuration section like in the other man-pages
describing which configuration setting enables the command.

Best regards

Heinrich
