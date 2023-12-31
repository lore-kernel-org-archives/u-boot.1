Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD480C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 16:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5029887910;
	Sun, 31 Dec 2023 17:17:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IEHhqKZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C30387918; Sun, 31 Dec 2023 17:17:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BDE8785F
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 17:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704039448; x=1704644248; i=xypron.glpk@gmx.de;
 bh=Cw+WoOB3GdIMHJUsrn99+VXgzeihjpYlQq5UIixAiYg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=IEHhqKZlkNgKKG1e+DdVPNCQRHkUWE58fsVT8sB3v4iRt2gX9RIWWkN1xOxSSECZ
 8NV7eLV18xkMMjz72aFjbfFmNZrpYzqh4C4OjddwGLEFofz/m5tPWWTMr57++7TOw
 hwiHm4WNiUHUUn4rwDZZXb+qFi3bgCX81xeSsTsg5pFbnQg4BL7Hw8bKvkmvqbsNs
 uoM8CD4JRZ4zfQ4ac82sA+IiQgTqH2wbxZfKRUlxmIlFvpGLfwVNPV7i6tE0x7DBt
 fr2rCttw/D7Hqr+VZEfCoVMaRIfClVp0IrH6og1bp6m5o+ouZnYFhcELJfCaVmOj/
 TbYHPGAtMGrTlQUDFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1r1TPT1SpT-00zW5E; Sun, 31
 Dec 2023 17:17:28 +0100
Message-ID: <71e8c2e3-00c3-40e2-9da6-bdf43ba9cc0d@gmx.de>
Date: Sun, 31 Dec 2023 17:17:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] efi: smbios: Drop support for SMBIOS2 tables
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-10-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231231152555.464874-10-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/A7bWvS0vtscYq0D+yd9jD4Vg9Xzt4TUnvunr3sxBQk25VeFbA4
 PCOh4XITXSfQDCGewr1NL/JzUl1C/2ZZ3mm9/q2F3AqerePyggXRGfx2mxeiz/GD7NRLNiQ
 ue3EoYMG3wiGJQc3aCLYFTj+od9Ng5b6IQj5xA2cds2FSUm1N0DZ170HPNzQVBKsUwYpjrS
 6ga9DvqeRVlGunScumPAw==
UI-OutboundReport: notjunk:1;M01:P0:J2+CZ0npohk=;zVJFeGJUmwQ2OYzF3FYitivBlf3
 1JpejImyGbu/c91uvSf8ps7ZTCgwYbdDVQ5lrDUdmIXlh8CWT/L1gTINi0ew8AwnTMv3626aX
 hXMnLbiQoTUjwdXFD1itxbFl+0jJDxP3GW6Rcxxpxu/SawWYr4XzIvux76c0uB0Y5o1Mq7fEu
 ktZGxCtCPK36G74uHJeATmyBho6lj0LLRH3aMm1CHHFaVuxWc0Lq/NFk4kcR1HA1ILkbRuYUu
 lye3aBk7ocxCg1XTDOvz5LEadU0V4Gp6eVzI7pRaavikrHeYkulRQTDzQ/9iodp32kq9mmtoE
 W7MG0k6xHCHho3/gp39ymIICakXDO0FeM3yWiblXBIHWI+Yu0+9R2Ban1nY4z8NGuklqRzzIT
 G850aKd8OuHpNcRYJvcnpaOBfWT6sqcPBwXWdZmqpwf8UZ5X1J/sXeIzbp1PegD8TD+SLt3ZB
 FW6iUigOuMHuxPEqG+lFrCUzXeiVMauHSRrXGevOGgKsvDEvvHphY+z2V1Ni2h9bk1nkZAOrr
 hpbbLKF2LXXDP/u2nuFfz50MFJe0jl2G0exCKELrZC/m6a5hvNpxQGPGby0S/8lYHoQGgC0UB
 4oTdd2NVApIa94Siei+CSkzXAYIt9AWNSqsLar1zllpTzd3JijhlaUOf17ZLrW+8bLjIUEEL4
 Z8p60ufqKSaqv7YjD/dI32NRREM7tWAgVlRI4OTJZVDLDZ7PbqThvZEcuaH5KJ8ubi2l7+vdd
 IrgkFRymKJDVbRpHwmaPHoy6QSxU7w9+a97w+DM+rFRQttDxgrLB3gqYv4RR8GAswJT3PamSz
 UVyzb8b2KGP29PM+nuE5iT1ciG/LbPPwSyYIqXbOMMc4NjQO7OgyOr20zylb/TWixBY5C4zZl
 piPdi3Dq6CAiDeDvZme7ql1gk+vtIUzjha7S12LDybIfZXXsCeVxOYwC7s+dz1PhbyexI8rZS
 qYLYpku7Paon0u5zSxLhXwHjQQA=
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

On 12/31/23 16:25, Simon Glass wrote:
> Only the v3 table is supported now, so always use this when installing
> the EFI table.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v5:
> - Add new patch to drop support for SMBIOS2 tables with EFI
>
>   lib/efi_loader/efi_smbios.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 5cbce6dc4eb..5db342ee0d7 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -27,7 +27,6 @@ enum {
>    */
>   efi_status_t efi_smbios_register(void)
>   {
> -	const efi_guid_t *guid;
>   	ulong addr;
>   	efi_status_t ret;
>   	void *buf;
> @@ -47,8 +46,7 @@ efi_status_t efi_smbios_register(void)
>
>   	/* Install SMBIOS information as configuration table */
>   	buf =3D map_sysmem(addr, 0);
> -	guid =3D !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
> -	ret =3D efi_install_configuration_table(guid, buf);
> +	ret =3D efi_install_configuration_table(&smbios3_guid, buf);
>   	unmap_sysmem(buf);
>
>   	return ret;

