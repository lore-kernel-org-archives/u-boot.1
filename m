Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37ADC83F13
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6FBA86AF8;
	Sat, 26 Aug 2023 12:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="HZEmri+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C860D86AF8; Sat, 26 Aug 2023 12:07:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3006D86ACC
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693044413; x=1693649213; i=xypron.glpk@gmx.de;
 bh=BwUQIzNs7PeubQW0+/XC/aMKSl38HqjvtrDAQ6QWtyw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HZEmri+RNzSPQQF3aD7A42+5bPc6ffMjnVFEVuHT5ytyzzTpSH0+69RGKVjthj68mdjuiyf
 FuDDtQJlnu5svUWl3abxHyzvfaLvpExhzwP80/6RRxJgY4K/1bbuHZanPkQbeMAm+rUOxjMqn
 VdfGNFUrZ2LW9aM2LB4XlEq2oVa8z2bZfYTf3ayerHx1cwnRm4mmwOfyRy8HsA76BRaCl4b49
 qFsJHay+gACIVR2gV9TabK0LvdyCsvBnL+Q+wW81778GRhQsGOZIFSfK5lCyH+jErw/nhQQxp
 uLlD6OEOL36DCNaF433FOd5KsSXbwnfdXpa9Bmgn5rUbMh6xQZJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHGCu-1qVUar3CL2-00DHPb; Sat, 26
 Aug 2023 12:06:53 +0200
Message-ID: <aca7e6fa-2dec-a7c5-e47e-84c5ffa6f9b7@gmx.de>
Date: Sat, 26 Aug 2023 12:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
Content-Language: en-US, de-DE
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x/onwNuVFLUYc9RmSST+9KrVP23C4LzZU44e9NJEKxmk8i0aiEA
 SjYm41/PGVyDR+/VeVQWIEsOa6kfifFtJ3EvT1hBQV+PPXQPftfxa33pViqzPqdIqo2wftg
 YmR3o5hbNch7w9YcqMULVzlQG/rL+9USY2F/q7PsiquI+Zzn0Zcef2L/PUm7aJLwFSGpQ+V
 ANf0n6KQhHcKtnmqB6R+g==
UI-OutboundReport: notjunk:1;M01:P0:9QYlZ5eyezk=;h5NMDJgfeYnajMFPGfUl9Mz0xYe
 EjBqItn2J0uAs2RhXMX8vGyYYnVQ+WDNSmXwX4OL9GZP/N+E9YBngjXbOBVwtz2fF27K4racz
 uus9BaovCI3o7+GbTUKkN41Xm1Bjmcd1RKZ/1qfGuPAzCZHBfWjB5D3S5vT7iiK9Dymt/K3XG
 ptWzp+Bm3MWD3RBHCZfWRxflbshsgYwe9/D/Qm8Cym7GtjgTiCM5dNv1pqw7AwH3cF64lfxtN
 tyEpgi3/hk/T8Y3vZbcCt9rIDhqviPT082UW2OA9AzGMnOE7Qrn0r9h9BtxaImIGnqIePzYn4
 5+UT65QUzSIirBzmfPg1scnyvgvuikKT+hH33Y2JjvLq7tkmifglPx2mteMJnpAYSvdT0KczC
 BBuNqL4XLdRHx0zmQgTon+xhXIWiADBEo8/CfGvMa+CuTXHSWNbpx+gRQpz47QmwLMeI/+3Kr
 69cKM5JVjb9qNuImfXHJMhHe8/VjzEGOgqkcyq9ypw6jukKRYG0HzYaC78QZ16bgxcyL2gqIR
 CFdYlijdG31HJcsdkubkm4WIHOxo/mDZ/2LU2DlFMuLPYzj6xBxpYnVMSSMdM7XtB1lQIo3BJ
 j6N21fSKleTFx28CvEAltG2u6A7RU+XofXmiP1nMg50WVbUQvXUQgQRijg8UejxjtVne7ySJO
 uKdcjIjLUcg9FcxIOu9qCcqOpTP6TcJPRc4B/Yi05V6SA1ddsSH3E0ouyuwc+mF+gktWfBt3/
 qSJWvuVM690tT9shWJHQ1MFSXO2kkoc9Wap0MDhkyjqhz8fjFkTzUO1DPld2IwMe5/aivQwwX
 a7VROHhq1jA6vp+9Roza5eIDdh6XyvXegMqXqjaAIAovmJAgOx8s730Ov9wLF7iLTo9TK9i9H
 IrO9a6D21thznjgjRxIoKFAqdeEzDwNTFK0VKtsnWKwJ0Q5+5AqaqL7u2PF4ojwY0FpRGYjHu
 fmOMkkKBCHE/szK5Jiv/83NKPMM=
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

On 8/26/23 11:06, Sughosh Ganu wrote:
>
> Provide a way for removing certain devicetree nodes and/or properties
> from the devicetree. This is needed to purge certain nodes and
> properties which may be relevant only in U-Boot. Such nodes and
> properties are then removed from the devicetree before it is passed to
> the kernel. This ensures that the devicetree passed to the OS does not
> contain any non-compliant nodes and properties.
>
> The removal of the nodes and properties is being done through an
> EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> behind any Kconfig symbol.
>
> I have only build tested this on sandbox, and tested on qemu arm64
> virt platform. This being a RFC, I have not put this through a CI run.

We should have a test for the new functionality. E.g. add some
superfluous properties and nodes to arch/sandbox/dts/test.dts, delete
them via the DT_PURGE macro, and check that the device-tree passed to an
EFI binary does not contain these properties and nodes.

Best regards

Heinrich

>
> Sughosh Ganu (5):
>    dt: Provide a way to remove non-compliant nodes and properties
>    fwu: Add the fwu-mdata node for removal from devicetree
>    capsule: Add the capsule-key property for removal from devicetree
>    bootefi: Call the EVT_FT_FIXUP event handler
>    doc: Add a document for non-compliant DT node/property removal
>
>   cmd/bootefi.c                                 | 18 +++++
>   .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
>   drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
>   include/dt-structs.h                          | 11 +++
>   lib/Makefile                                  |  1 +
>   lib/dt_purge.c                                | 73 +++++++++++++++++++
>   lib/efi_loader/efi_capsule.c                  |  7 ++
>   7 files changed, 179 insertions(+)
>   create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
>   create mode 100644 lib/dt_purge.c
>
