Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D27C47DAF
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 16:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EAD78718F;
	Thu, 18 Jan 2024 17:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oitS9exN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3B987B6E; Thu, 18 Jan 2024 17:47:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B3C86FB2
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 17:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705596455; x=1706201255; i=xypron.glpk@gmx.de;
 bh=ryOoOSOuG3dxQuJtgQ3y1X0LsHo5axTo3qWgM6yj06c=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=oitS9exNoMqVyKC4+Nd0C02LcoN7e/X5VIexu7MTzCGvYG3jrnCJbkJgjJjv/90O
 1KtnJT+EL/ozTnrvvNjm6NKnzxathQ+/QCyqdi8BMOOi843Us9s8mz2zG3sq0yiBy
 hFJbatNJLmODdmFzZF14j4ol1c6dX7MwJEU/EJqUmABL51K1e/DzYkmZJANoCfnSo
 3Cp5YiPoU8Xrxs4aj4XvgTYGjzSK1o1SFVXZygjC2XRhwGiYwvVVE7eeicgwuwCdd
 It5rc9qC/WngIwtzo2/upIgeiKjeeeGzlnaDKX0Nrm4ocXw4VTCMsJlAqZOdJV2G0
 g2EqaAUPe8ru/UC2fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N49lJ-1qzwJC3DRx-0101jJ; Thu, 18
 Jan 2024 17:47:35 +0100
Message-ID: <4ce6fe84-0897-4eeb-9b0a-34add92de8b8@gmx.de>
Date: Thu, 18 Jan 2024 17:47:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] video: Add UTF-8 support for UEFI applications
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OuS6iWnHvfMWF4EiNVleksOwuQ2wD6uBhc5r8uR7C/+9FXtCpvu
 2EdXjXYTdJQJcvwQ7jTkFeqevVdFDkSQxDAC1nHy4OrRzD3WsbYAzSqKoE1FsQ83buGhO5q
 iLgTycKWbol9eh2pYmm2CJJ5JTdL3yzBQDWOKEXsHW5+v7HHvr1s/huPJRUYalAwmGOxvWo
 YzaAhKpERipdy+TKohFbg==
UI-OutboundReport: notjunk:1;M01:P0:UU5ulOcK5Bc=;i+ylNlbAMS9J+ZOwoc1d0wrrr6R
 DofJOb/BDESb35dI33rML89WmJ/QNR6GWwLO2cy5FE7vTy0+LZVSaDMpJqtEYu7NosrPZensa
 5/PvYGHQ9fPpCuJDltQrDh1jQUiaomvT5tDRgBt+JXlM024AUd5LeNIWhjkYN1UclEaldcIun
 pIux/16GPYQVqtqDtH9dqXn6gfg3VFRpXjzkeaS82Q1/xYFlmvWrBzTpc0StCoZp7woUwQwcX
 KYIXGREQha3o5jGfDvmxyz1+ND7zWJFWZD+bTQtA+p9E0nq3u9f37lxT6R/CVsurSh0UYgtLv
 sXfpEEi3UoIZafyvuaiSNU0KFBCShJ6PfMBPAMJ2TaPFy6Fe7XSLPZR0JLwIzr5qm36EmlIBy
 73X7x2CWNXW3NePG66hsgwk+RvikWLKm1BnB5y7AaDcJRbAGnvoPAwn9vOhi2LX+6uk5Vtp9y
 f8six2RL8trvV6jbV4cm3HzSlJX2xmH7msgEM3o3V6jimyxRswiqPTh1peS3wI+iwoeJHult6
 5GoQwMfGx0WxS9LdkaqbgqhEYTOiocTUJ0qJUOY+tUN2IVcjTFDC9oBLi0rXwo9qRUUFaaUEy
 DIXkz7dBjlbSJDCUp8dP7/qEqQ0ZTFuAd5LQSCG55+AFsFJZlKfD18gOrCZJCi+gWEeub6htU
 +T8DpUnZHuKU/1j0yCtNK0e5AMITd8qx6vZzuxhl22VP3vspIu7C79NZqssQdZHs/+59c4SBl
 WOss1TTftuiH3KChSmYKR1393BSuhi1odQOB8sWPEf9tlAFlGpipXunCSLPSqBRAu1Rka9mdU
 n8W6DT0MvZzKp84Rqv7xYNqgKn2/Qj1U8RniF0hsA0S/EDFCa2B1oljk2+9Ta5XoPeEBDaXRZ
 /0rMPjNEXk81jFznDrM5DjkZNxLUu079AFmSjK6Aaq9D+KjckqeDDt4DQa3S8+wkQbEpFcw35
 Obe+eFdvb3WGXXvxAxypZxUXk+8=
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

On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
> Andre submitted 2 years ago DM_VIDEO improvements for UEFI applications
> using UEFI's EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL but did not follow with
> suggested changes. This series takes care of the UTF-8 support which
> required to draw symbol and box drawing characters used by UEFI
> applications like grub2 and sd-boot correctly.
>
> Compared to Andre's version this version has the following changes:
> - use and extend existing conversion functions from lib/charset.c
> - convert first to UTF-32 to support the truetype console as well
> - conversion is conditional on CONFIG_EFI_LOADER
> - use escape sequences in tests as proposed by Heinrich

Hello Janne,

to correctly render GRUB I think you need the following:

* Use truetype
* Add a mono-spaced Truetype font which has all the needed characters.
* A bunch of code fixed.

This is the font I once suggested.

[PATCH v2 1/1] video: add DejaVu Mono font
https://lore.kernel.org/u-boot/20210301181534.7618-1-xypron.glpk@gmx.de/

Which font have you been using for testing?

At the time these additional patches were needed.

[PATCH 0/6] efi_loader: Unicode output in UEFI applications
https://lore.kernel.org/u-boot/20210227130840.166193-1-xypron.glpk@gmx.de/=
#r

Best regards

Heinrich

>
> Link: https://lore.kernel.org/u-boot/20220110005638.21599-1-andre.przywa=
ra@arm.com/
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Andre Przywara (2):
>        efi_selftest: Add international characters test
>        efi_selftest: Add box drawing character selftest
>
> Janne Grunau (4):
>        lib: charset: Fix utf8_to_utf32_stream() return value doc string
>        video: console: Parse UTF-8 character sequences
>        lib/charset: Map cp437 low chars (0x01 - 0x1f) from unicode
>        efi_selftest: Add symbol character selftest
>
>   drivers/video/console_normal.c             |  6 +++--
>   drivers/video/console_rotate.c             | 16 +++++++++-----
>   drivers/video/console_truetype.c           |  8 +++----
>   drivers/video/vidconsole-uclass.c          | 18 ++++++++++-----
>   drivers/video/vidconsole_internal.h        | 15 +++++++++++++
>   include/charset.h                          |  4 ++--
>   include/cp1250.h                           | 12 ++++++++--
>   include/cp437.h                            | 12 ++++++++--
>   include/video_console.h                    | 10 +++++----
>   lib/charset.c                              |  9 +++++---
>   lib/efi_loader/efi_unicode_collation.c     |  2 +-
>   lib/efi_selftest/efi_selftest_textoutput.c | 35 ++++++++++++++++++++++=
++++++++
>   12 files changed, 116 insertions(+), 31 deletions(-)
> ---
> base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
> change-id: 20240117-vidconsole-utf8-uefi-fa23b4ac65d6
>
> Best regards,

