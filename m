Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D60C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FEDB878B8;
	Tue, 26 Dec 2023 16:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Kif1TWvV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA16878D3; Tue, 26 Dec 2023 16:27:52 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD7687835
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703604470; x=1704209270; i=xypron.glpk@gmx.de;
 bh=hNOYDO5ncxnQaYnxK6nGzEU8tSvKr/xyeSkXqJ/SbVk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Kif1TWvVQb1cLAqVW9Vig++oE2LsDCqJZY7GhSXj9asdWCPtB2EjcoWvEXks4oJn
 5mMR4PoVSw+tVeO7BsrPrDWrr9kVxBHvELvWV71mMcf36M5Pz2CawqsbIilBaDDpe
 QKj8abHQ7tLyHtvk0tbwBkL0+L6jScQu9/HSKfMk28V5z5hwmnCx7HbELyrolGEtL
 b4Ksps1+4aXN9Hv9lqLp01J/NVm/Wag17GLjApsz/SgqOlOAhZY0UnOerFZnURrq1
 TFzJG6t7FmqU+llSRTPjfUG0td/Up2d7sXuOdCH5xudsOt4EvpT9vdF5ejicqc5jk
 1pu7heQARTtkxQmXsw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.152] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1rTyoa0Vqh-00HRbh; Tue, 26
 Dec 2023 13:38:31 +0100
Message-ID: <e72f6d4c-0214-454e-b400-a3d06d0b7230@gmx.de>
Date: Tue, 26 Dec 2023 13:38:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] efi: Use the correct GUID for the SMBIOS table
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-6-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231015024511.3995580-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aIW6RnXSPtKOtppguGvPUXsSjwn9/1x2DY/9RNa/3jgATbpllMD
 Fr+QbSayOAKRqT0OcPGgWZjFu3PbfXbCC4J4aqo/KWg0plz6JggAMOcnA7wH5yjmNey+XhZ
 6Kw5Pa6wJaJQxKBj5ui/tpKd9XbQfSqxWF9Vi6ZFle3dSkSHTltFBm/6fxbQucm5MR1fbzD
 MRRoWzD4d7Updv+8TuoJQ==
UI-OutboundReport: notjunk:1;M01:P0:MvHtLjD/vOw=;z1yxbHa8gNIlrnafj/Io7019ep2
 Ml2hNIT/297IJuPAToYEB4hR8ks/ZkbRaYvM7Ks4NuYW1dER0O4XjtQooR70q746UW8LjedEW
 lt36P3QqUJhQYIolq0odM390T2lGS4KibIZamXGqQonoeO3X4gO8EYe1iKQafXwhEWiEldhgM
 tT0wgSkyL6zNveqnDjhbjPoKbDgQykmnBL89HqyesBmCZO89RhDGsG5dvMySa/YHIkBZYKksI
 rGqIeETDiZXbuH6P02cxG5/93rTWgHTDWeiG47Gmg+CEvZWM3f3mgHQ8cm3Q6rD/CSn2Fttae
 py5m4PqBcZQPu5VuU6ZXYLqPtQV/POaAV9FFiGr32oOV5XWzEwKvZgZi/cSy62nT1Bp7aNc0T
 WV+kChSWsDsUvWi1x0frDMbmafHpKghE6+0PcXKuBCnhJYPZ+p6ERj/9rPY7agcAFZbaJ+kSj
 rRCkQWUlaicFnJuo8sEOgOjVDxuUDFJE2P6KMru1TMdgndLkOxn9oMP6TUKOZ836ZuRTwfNin
 /omHXpDIWsqCdthItI/p7eqKjS9o5Ohwi1/IRJrtqlgmdKbJNyvDNwrH0LyLfp/e5sNzORl0o
 AzUQRwmGSsjdjdma0a3LpCMwb0Nu3MPGj51BIMOpTEG28U/tR+B+CHJ77Xl7QhLKMnp6IxZAl
 TPfoCc9st2OptRP94E6mhlk0tpHWjI/qiE6KsIwMZLen1mPFDiB3slADDdXhih6rQndW9agky
 FibFcLSvWxuCpT8PYd+e37z3YUnUryCVNwc5Sr9t10azYIZzNfXKDBLs1TjNEpVOWTn3lU+Vf
 rrBiMLcjuGs1rrwdZXK43raXd8F7MdyZ2m45m9RCJay7or20Z32dDYI+LGTrgl+BwibkHWndD
 yFAJnJzJhhs/La67X4gwp5ttT0BK10P07BwSfkX4accx3JHip9oV79cyeu9tOrYV6jsmJp4fN
 H0JoS2XGNkEnzYvYCwaomcbCqYs=
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

On 10/15/23 04:45, Simon Glass wrote:
> EFI does not use the 'anchor string' to determine the SMBIOS table
> version, instead preferring to have two separate GUIDs. Use the correct
> one, depending on the table version.
>
> Call unmap_system() to balance to the use of map_sysmem()
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v2:
> - Add a note about why unmap_system() is called
>
>   include/efi_api.h           |  4 ++++
>   lib/efi_loader/efi_smbios.c | 12 ++++++++++--
>   2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/efi_api.h b/include/efi_api.h
> index 8f5ef5f680f3..1abac2ed7563 100644
> --- a/include/efi_api.h
> +++ b/include/efi_api.h
> @@ -430,6 +430,10 @@ struct efi_runtime_services {
>   	EFI_GUID(0xeb9d2d31, 0x2d88, 0x11d3,  \
>   		 0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
>
> +#define SMBIOS3_TABLE_GUID \
> +	EFI_GUID(0xf2fd1544, 0x9794, 0x4a2c, \
> +		 0x99, 0x2e, 0xe5, 0xbb, 0xcf, 0x20, 0xe3, 0x94)
> +
>   #define EFI_LOAD_FILE_PROTOCOL_GUID \
>   	EFI_GUID(0x56ec3091, 0x954c, 0x11d2, \
>   		 0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 4ae4e4a7c236..80f38d78d877 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -15,6 +15,8 @@
>   #include <smbios.h>
>   #include <linux/sizes.h>
>
> +const efi_guid_t smbios3_guid =3D SMBIOS3_TABLE_GUID;
> +
>   enum {
>   	TABLE_SIZE	=3D SZ_4K,
>   };
> @@ -26,8 +28,10 @@ enum {
>    */
>   efi_status_t efi_smbios_register(void)
>   {
> +	const efi_guid_t *guid;
>   	ulong addr;
>   	efi_status_t ret;
> +	void *buf;
>
>   	addr =3D gd_smbios_start();
>   	if (!addr) {
> @@ -43,8 +47,12 @@ efi_status_t efi_smbios_register(void)
>   	log_debug("EFI using SMBIOS tables at %lx\n", addr);
>
>   	/* Install SMBIOS information as configuration table */
> -	return efi_install_configuration_table(&smbios_guid,
> -					       map_sysmem(addr, 0));
> +	buf =3D map_sysmem(addr, 0);
> +	guid =3D !memcmp(buf, "_SM_", 4) ? &smbios_guid : &smbios3_guid;
> +	ret =3D efi_install_configuration_table(guid, buf);
> +	unmap_sysmem(buf);
> +
> +	return ret;
>   }
>
>   static int install_smbios_table(void)

