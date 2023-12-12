Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE4CC4167D
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 10:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 618DB8718A;
	Tue, 12 Dec 2023 11:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U+11zzq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08E0877E3; Tue, 12 Dec 2023 11:13:23 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6552A87103
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 11:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702375996; x=1702980796; i=xypron.glpk@gmx.de;
 bh=Koo7oYHvZOpHNw2UaNX5EmacRuLvnGFnbEOUo6l6pq8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=U+11zzq5mLUextNeZ0OIqNj2xsMU1aG1CsUw9FaBw7Mwm7x5epc7KiZnNvPEDZ++
 f5JfPa6mHHwe1D8A1E6ULCvoxjVU/3MB56D+BfPWq7DEO4vs8SwQ/R3t9xHqX+XlO
 hYIT0pKdN9N/XeOuWxbM9vpjup1tYUk5vJkI0AgTw8fUvLjsqqD9sYUpWQVkqAXZT
 dxNsn+WiZ23DPx6ItWY6Rwl6ReSm+q06iXCPjnd6Kr5udmTUXEC1CaxDmAZbOqRUQ
 QgzhnZ4vLDoPz+nckPhB1Z6ZDuVlrIQ27Mm4M6nIB2uqAxn41A2BKatquJQNrayI3
 MNyQebfXyUQ7niObMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1qgqZj1P4d-00Xwzk; Tue, 12
 Dec 2023 11:13:16 +0100
Message-ID: <7e505616-9053-48f6-a282-c6ce8a09a531@gmx.de>
Date: Tue, 12 Dec 2023 11:13:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enable setexpr command to print cpu-list like
 bitmaps
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Roland Gaudig <roland.gaudig@weidmueller.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lQVNqwBoQei6mGEwBea5tnXjVSSfai1EvS1q36luAgrr1VDo1ND
 /786G7CL6/Vw+/0BoyRVh+QmAMw4D5WzGOrTX0x+QJd8rzqCQOqYqMuJi+79TUpVCrnAtB0
 cUSv2BQjREAbS/QoCH/LkQuY+NzMo2O2MehJI2GoxaSSpk9fMD/sgjztnwhOxTm+GxiURs+
 RBVZkAcSDf17gv7EoMUUw==
UI-OutboundReport: notjunk:1;M01:P0:lzJSLn/kdMY=;OL3p9lezKMDWfC0zVwgSFjxDod3
 cQYSiXYA5Lr79hYVtK6AUP0cM7MAj/zkiP1+IyI+Jq6HH5UT0mMPLR8w4BqKbndG+pa+tpjcN
 FwiQu3tfBZifYryRRjrGt0R074qxYhTfY1VukpZ3EjzC/RlZo5lxOI0Kxd9uoXrbBuLVP7ylF
 Lo7Jsz75CpbgRDtStgC9VtbpFmkBESmoUcU2RKn1KyuZRtZYosTrjTrFa3VBxgf2aglbp5cec
 blNe7Oni5h82XMS6gtHRv+l0JlbKBqz9OKoe56N+LdzqmIw3Q0Ase/DmvaSt52nIaZT7rO0p4
 OZ4CtgXDZGiKcTVWN3OcQtP+5XuGwjQZM2g35vZnH5uZY5l4xgj0SqSDovO6yZ1SYIhaV8N0a
 ax8RlsxC4yp5Yh0n0eTTqQGlpHBdFfVUcxf/IDNOp6IKOEjZO2mwJC0OeWX8aZcRcV1YwV+Iu
 mxC4cxRRtwNWpvPxRoEgqVzA2HI0h2M7msehqJYH7RrlLrHE/GJBg2G/Y2DVzwpe77b2CrEWz
 saHgQj0gSYUCu9rVbityAhtxxHSTkfyxq0gIl1UNUPyinrY1MatojED56wOJ1MQtJB3g0ERTG
 piste5jvQetbJWUK9s2OZEUD6XFJ/gA+ZfBfeCcYjfhixKvJ21dZNRMMX4Gk9NUi2KhWmfibk
 cDwDC4NhkJeeJQPt3de9RZH+eB7BJ2txtyAEYM1K4uwLZiIJrki61gwLIUFrhlSqErFfYSwfm
 /0vxOonQZFFlVELjm9YtWTSYaYaDPSOFJmtcNQW2YgNZmVZ2AtI1eZ/dBcrfAZA8zLG6hKNWI
 9uXpcwg0HRDrWOkvDk6fVnC6bX5R0cfzkXHVKpergCPU0Pyo1ib80AtKMBDpDeAb1Tm0xpPiQ
 VSOqxDuYYcCxOxwfo1mKTnUp67kdY2p4MP6elcMoRigWZ83S8+NuCMb8neCahgq6Pd0SBC0fZ
 KRpd9w==
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

On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
>
> This series enables the 'setexpr' command to print "cpu list"-like
> bitmaps based on the printk format specifier [1].
>
> One use-case is to pass cpu list [2] based kernel parameter like
> 'isolcpu', 'nohz_full', irq affinity or RCU related CPU parameter to
> the kernel via a separate firmware variable without exposing the
> 'bootargs' variable to directly.
>
> Example:
>
> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation

I applied your patches on top of origin/next but your example simply
does not work:

=3D> setenv myCPUisolation 123456789abcdef0
=3D> setexpr isolcpu_bootarg=3D%32pbl $myCPUisolation
## Error: illegal character '=3D'in variable name "isolcpu_bootarg=3D%32pb=
l"

This produces some output:

=3D> setexpr a fmt '%32pbl' 64; echo $a
6

But the result is completely unexpected. Number arguments in U-Boot are
always hexadecimal. So the output should be

2,5-6

Best regards

Heinrich

> && env set bootargs "$isolcpu_bootarg"
> && bootm
>
> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
> [2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters=
.html
>
>
> Changes in v2:
> - Add bitmap format specifier to documentation
>
> Lukas Funke (6):
>    sandbox: add generic find_next_zero_bit implementation
>    linux: bitmap.h: add 'for_each_set_bitrange' iteration macro
>    test: cmd: setexptr: Add tests for bitmap string format
>    doc: printf() codes: Add bitmap format specifier
>    lib: vsprintf: enable '%*pb[l]' format specifier
>    cmd: printf: forward '%p' format string specifier
>
>   arch/sandbox/include/asm/bitops.h | 16 ++++++-
>   cmd/printf.c                      | 29 ++++++++++++
>   doc/develop/printf.rst            |  6 +++
>   include/linux/bitmap.h            |  7 +++
>   lib/vsprintf.c                    | 75 +++++++++++++++++++++++++++++++
>   test/cmd/setexpr.c                |  9 ++++
>   6 files changed, 140 insertions(+), 2 deletions(-)
>

