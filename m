Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E89C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 11:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A32381119;
	Mon, 27 Jan 2025 12:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jiAotCn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6F08111F; Mon, 27 Jan 2025 12:21:21 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E7D81115
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 12:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737976875; x=1738581675; i=xypron.glpk@gmx.de;
 bh=ULwVG4HaEVArVH88LIknOPrDC20ANleP4KEKHrTJ6hQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jiAotCn4EulgHMTARZTMCaEzVe8nndgJiXePI5yNDyw/3+AVbFuuPUtfvSOJu8GR
 hiwo6WV6oPBNTWymBiEAFPRJYm1ARkiCNi28vRiJ/Frttw4obBYXt3oD4osrg+c90
 TfJViBp9MCOwlodQO08oFdBnFhHl4TtwYfwfJAxdg9SsPxdsmKs9bOXjgY/CWPgpV
 A1Ij46qiRHijGfA4EjfjPseR4ADty1dEUUA0ETzbesdcgJArN2aeH/ab61HpP+yzl
 rPyw4rCMQ5IldZ75J03t7/hACm/KqFUzRi3ULbs93wRs2cxPMwOM3xUQO+3k3zi7a
 VTGFSr8FqTo9hvXywg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([46.114.105.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McYCb-1t47t806IP-00q54g; Mon, 27
 Jan 2025 12:21:15 +0100
Message-ID: <a8fb34b4-58a1-4de2-bf18-63acf8657259@gmx.de>
Date: Mon, 27 Jan 2025 12:21:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkje+8mltQQVRDSCAxLzFdIGV4YW1wbGVzL2FwaTogaW1w?=
 =?UTF-8?Q?rove_determination_of_LOAD=5FADDR?=
To: =?UTF-8?B?6buE5Yip5Lqa?= <1425075683@qq.com>
Cc: u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20250127064936.43539-1-heinrich.schuchardt@canonical.com>
 <tencent_F40E3EB2650593002161864C46F8BCF4D00A@qq.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <tencent_F40E3EB2650593002161864C46F8BCF4D00A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:grvn2yMytMAeJbdRVrbagfSzirfcsVeCMp0BRwTE9QuBqNb6OfJ
 xGUPNHXFlWRuJ6QicaSRHSuem68kJ6Cv1pVsYdP8PsU1VGV0MplyRXfWFzgANSrI8iAAh5P
 Shn2A228GtT93Xf0BE0ruJOLNHJ+E7Ym8xljFaCOLLy7Hue4o69ZuGOAih9ST8TUSjRuiA4
 Tu9++O1Al5V5Gklpp1esA==
UI-OutboundReport: notjunk:1;M01:P0:cQ9xMur03P4=;FeEys8YR8q303Pv+/r3R6/W63ZT
 F7JSweEDkBEY5TS0a8wg9BRBP+VbwFUdOYlIs/hB5ku3rta8c5Bmg2wAQkEOMsi1MuTUhEiLv
 9AJKeyU61gfY8P7b0CyWkMEVYCdDc8GNe+cBBEZbSfDT/qdczpPggujOHjphVNvo4jqHai8zg
 Y/4bFxNEeCBclV/Ft7FbhOpw3EFOpLKd2yfLazK5DF85vuuvDpD1w9xWQ4ElkZ7Hd6zG1nMJD
 ++LKltwLnTsMqgPoV5rZGgh1EDXwhSKDlUU7/fJlXV69BsSmXfi0sYl2RCJpnTfQjR2l+6qfb
 3MPyUbm71QVHVyKBRDh6xt5PXC7TxwPBdCBSVxZt/V5m2LRCTpxVF5IM1ZWLDJvdaelRo7U7n
 HZCnF06r7GeMAq3dkjQvz0ovX0MhlSIkWn9NlxiaDRoNIf+8r9MOpPbmqj4qL4W0xwkWsd+lJ
 YSSqT0/YcLieSJRVKLlv77ux3Q2Q+umiMscsFTfyYELvDIFgzaTkP61vrVPx1hRDRNi23DV4i
 Yj028NZRAUii4kp/eT7HB19/07Fg6RjLkJ7YwHC2Mf/1Npus8e2nbXisf0cxRkGCg2Qi/hhlx
 ukEZqGRDqXkJMaXu3nyRmHeDkI4qlC3b+PxIRB3pyZ1jq3zKtuECOeaDlX2KNwnLLxUqbmIIA
 tdsijajFxXuLXNHFAXNi6szgulM9DJt2gGLm35URzSEvw73ia9mEGVboAiMjy8yVE6GVSSYd4
 jP35+gvrnLiLjG9rDzmehuumoVYogytzNWBUuISKyUIV6hMVtW5Jn8CtJlpJ9AEMcFoCOcbQR
 um8pLielUOSfNAoOtRfyPeHnax0ayy1iJQMH55tWTUyqEBNTFyqJHXTDa3mcICCNHWimmfhYX
 BUiQlmKLnbyCMCTHMx/KVz8W4MyPUbBLQsxhrpYkcAzx+GGQ4iZHxkkOoO3CZfcTLuWy083Vu
 8efYiQZ1pmyQ1YohJkJU2dINJCZ1qj52SdjXrg53MFt24Rd7BxEnXTpE4XM0y0sqGfCDZihh9
 4cmFrsaRd9HwQ5zyjxxKjiQCk1t96K1PfCQ3RnOTWANKGauPZIqV5F0zLtMT7sBXQ6bKREjHC
 W1+PqdSQthBGKvzZfN+73KjXIrOXRSSZT4VL40EQmK7Ue+xWVYXqkq/4RFAqzGQwuC/OCTQRn
 T9QOkYRit7oFBFEemJnf1GTfbOY7w4dGF+ipWMjs5cw==
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

On 27.01.25 11:09, =E9=BB=84=E5=88=A9=E4=BA=9A wrote:
> Hello=C2=A0Heinrich
>
> I modified the code for arm32 architecture. You may be using an ARM64
> architecture. Take a look at the architecture used.
>
> version of U-Boot (commit in git):
>  =C2=A0 =C2=A0 d8a7100d658eb201fa0e955667fdff298db31945
>
> operating system and architecture:
>  =C2=A0 =C2=A0 5.15.0-130-generic x86_64
>
> installed version of gcc and binutils
>  =C2=A0 =C2=A0=C2=A0gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.3)
>  =C2=A0 =C2=A0 GNU ld (GNU Binutils for Ubuntu) 2.34
>
> used defconfig
>  =C2=A0 =C2=A0=C2=A0stm32h750-art-pi_defconfig
> used commands for building
>  =C2=A0 =C2=A0=C2=A0make CROSS_COMPILE=3Darm-none-eabi- ARCH=3Darm stm32=
h750-art-pi_defconfig
>  =C2=A0 =C2=A0 make CROSS_COMPILE=3Darm-none-eabi- ARCH=3Darm menuconfig=
 # to add

Hello LiYa,

That additional information helps.

The stm32h uses the ARMv7-M architecture. With that architecture the
compilation problem is reproducible. Could you, please, add this
information to your commit message.

It would be preferable not to use registers that may be needed for
argument passing in future. Please, choose local variable registers R4-R11=
.

Environment variable ARCH is not used by U-Boot. You can safely remove
it from your command line.

Best regards

Heinrich

> CONFIG_API=3Dy, CONFIG_EXAMPLES=3Dy
>  =C2=A0 =C2=A0=C2=A0make CROSS_COMPILE=3Darm-none-eabi- ARCH=3Darm -j 12
>
> https://developer.arm.com/documentation/den0013/d/Application-Binary-
> Interfaces/Procedure-Call-Standard <https://developer.arm.com/
> documentation/den0013/d/Application-Binary-Interfaces/Procedure-Call-
> Standard>
> lists IP, SP, PC as aliases for registers R12, R13, R15.
> ------------------------------------------------------------
> I have tried using R12, R13, R15 and the error message is as follows:
>  =C2=A0 =C2=A0=C2=A0examples/api/crt0.S:32: Error: lo register required =
-- `ldr
> r12,=3Dsearch_hint'
>  =C2=A0 =C2=A0 examples/api/crt0.S:34: Error: lo register required -- `s=
tr R13,[r12]'
>  =C2=A0 =C2=A0 examples/api/crt0.S:40: Error: lo register required -- `l=
dr
> r12,=3Dsyscall_ptr'
>  =C2=A0 =C2=A0 examples/api/crt0.S:41: Error: lo register required -- `l=
dr r15,[r12]'
>
> As the error message suggests, you need to use a low register (lo
> register), and r12 and similar registers belong to the high register (hi
> register) category.
>
> Best regards
>
> LiYa
