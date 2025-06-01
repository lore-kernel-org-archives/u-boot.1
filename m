Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99046C54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 21:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1027F8296B;
	Sun,  1 Jun 2025 23:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rl6XRznX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C6E82991; Sun,  1 Jun 2025 23:32:10 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E548294C
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 23:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748813527; x=1749418327; i=xypron.glpk@gmx.de;
 bh=mnTypxN98x1Bi9qT2hJkokCAqikhSPaLHRlL6vLWAfY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rl6XRznXNkbpY0n3kxOTk+TD/uOaCdc7JXP+m4NthhgiUNl2QESaYhZO4yfNA0Ar
 RatO3Twkfo/ApTlkE3pCJVtuv0Os2c4ghu6ENm9D8K/ZjbMIgBDFks4pkqwqTP8Gy
 ynSXrFg1Tk6O+B7P/iNuAYmH5XITG6ejuuh67dCjWpsYoLsMiJjC+H/H6F1p1GUC2
 zIWde75oMPFlBNhN21NF5z7fifUvNo/RxOxMY6ZOULP29Omr7U3L0itdIwFgVJ+kz
 H+GB2ZzqRVDY3/SewXqhIURHfJGIQCbVUg5/5C+qNsqJhuyvSuiUpeIj4/3FX/qqh
 2Ce1qZledFzoo/gSBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeMA-1uTVFT1p6i-00Ulec; Sun, 01
 Jun 2025 23:32:07 +0200
Message-ID: <2ea82a25-9265-4f99-b6ac-83aff3a955d1@gmx.de>
Date: Sun, 1 Jun 2025 23:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] doc: efi_loader: Tidy up the bootefi-command docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250601120406.2106-1-sjg@chromium.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250601120406.2106-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u5mk6H34Q5hhg9DnfsbP1U5YBnEc7Ilg0M3Ls/NOPZeDIhTer+I
 CMdJXOOsRM5GcOxt7VKpeT90i1iBERFpUhszLPSKp+LUuuhwQwMyN+ok0FO2gwctRcZW/+s
 b4s6gPS2/MPACMra2GMAhPBKR0FKPNN/x4dHZKQlZMqSXeoJ8etUx5RIlb8ax0uMghSElIp
 oTHuo4tGRmGjqIlh7LUhA==
UI-OutboundReport: notjunk:1;M01:P0:U5hHOP/m9eU=;cRR/XFhuRDvakFLKZtGDzTKRizv
 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
 vFxna8uvH2GbyxRK
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

On 6/1/25 14:04, Simon Glass wrote:
> There are backslashes in some of the tags which seems to be unnecessary.
> Remove then.
>=20
> Change the word 'either' to 'any' since there are three options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>=20
>   doc/usage/cmd/bootefi.rst | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/doc/usage/cmd/bootefi.rst b/doc/usage/cmd/bootefi.rst
> index 3efe9e9df57..d6e4e62e383 100644
> --- a/doc/usage/cmd/bootefi.rst
> +++ b/doc/usage/cmd/bootefi.rst
> @@ -20,19 +20,19 @@ Synopsis
>   Description
>   -----------
>  =20
> -The *bootefi* command is used to launch a UEFI binary which can be eith=
er of
> +The *bootefi* command is used to launch a UEFI binary which can be any =
of
>  =20
>   * UEFI application
>   * UEFI boot services driver
>   * UEFI run-time services driver
>  =20
>   An operating system requires a hardware description which can either b=
e
> -presented as ACPI table (CONFIG\_GENERATE\_ACPI\_TABLE=3Dy) or as devic=
e-tree.
> -The load address of the device-tree may be provided as parameter *fdt\_=
addr*. If
> +presented as ACPI table (CONFIG_GENERATE_ACPI_TABLE=3Dy) or as device-t=
ree.
> +The load address of the device-tree may be provided as parameter *fdt_a=
ddr*. If
>   this address is not specified, the bootefi command will try to fall ba=
ck in
>   sequence to:
>  =20
> -* the device-tree specified by environment variable *fdt\_addr*
> +* the device-tree specified by environment variable *fdt_addr*
>   * the device-tree specified by environment variable *fdtcontroladdr*
>  =20
>   The load address of the binary is specified by parameter *image_addres=
s*. A
> @@ -110,7 +110,7 @@ U-Boot can be compiled with UEFI unit tests. These u=
nit tests are invoked using
>   the *bootefi selftest* sub-command.
>  =20
>   Which unit test is executed is controlled by the environment variable
> -*efi\_selftest*. If this variable is not set, all unit tests that are n=
ot marked
> +*efi_selftest*. If this variable is not set, all unit tests that are no=
t marked
>   as 'on request' are executed.
>  =20
>   To show a list of the available unit tests the value *list* can be use=
d
> @@ -126,7 +126,7 @@ To show a list of the available unit tests the value=
 *list* can be used
>       'configuration tables'
>       ...
>  =20
> -A single test is selected for execution by setting the *efi\_selftest*
> +A single test is selected for execution by setting the *efi_selftest*
>   environment variable to match one of the listed identifiers
>  =20
>   ::
> @@ -140,10 +140,10 @@ return to the command line but require a board res=
et.
>   Configuration
>   -------------
>  =20
> -To use the *bootefi* command you must specify CONFIG\_CMD\_BOOTEFI=3Dy.
> -The *bootefi bootmgr* sub-command requries CMD\_BOOTEFI\_BOOTMGR=3Dy.
> -The *bootefi hello* sub-command requries CMD\_BOOTEFI\_HELLO=3Dy.
> -The *bootefi selftest* sub-command depends on CMD\_BOOTEFI\_SELFTEST=3D=
y.
> +To use the *bootefi* command you must specify CONFIG_CMD_BOOTEFI=3Dy.
> +The *bootefi bootmgr* sub-command requries CMD_BOOTEFI_BOOTMGR=3Dy.
> +The *bootefi hello* sub-command requries CMD_BOOTEFI_HELLO=3Dy.
> +The *bootefi selftest* sub-command depends on CMD_BOOTEFI_SELFTEST=3Dy.
>  =20
>   See also
>   --------

