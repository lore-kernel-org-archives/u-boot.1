Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2AAC369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB0382D2A;
	Tue,  8 Apr 2025 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UPuWUVRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D785882D2E; Tue,  8 Apr 2025 16:14:32 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E64982D06
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744121665; x=1744726465; i=xypron.glpk@gmx.de;
 bh=+pt4xvSKBoyMfEHI5GYi4LgC2JGWKmryPr10UrR3NY0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UPuWUVRn1tnERQy8X8AmTUed//kMzwog0iycwDiUG0rLQXXpR93xojVTUwNpbgOY
 uEEPDSYcMJJ8Cg4MPeGLIvEPa5PQbMWU8vAV1+mdPayZaEC4BR5l1mT+GZ5gc3Jjm
 TpLWTZ9XJpOzIzRcelAzZOnUtMEhO2SqrR4rDptA/A1MYW3oWgNqe3o4gvSaHft3U
 mrd/VfbZWtYUbjWOJ2B26SbFDlVTP9/KmukDn0RYBgElSNrIDVissPux0UGqS4bJz
 WtveNHln2Ye8vCmrp5ufdZRHWxRQGfpmREhO9jYFOsI0sETV0oov0X0unQdYPffZt
 znyziDRW7kFjG+Q3KA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3lYB-1u2QZG0Uy3-00354O; Tue, 08
 Apr 2025 16:14:25 +0200
Message-ID: <c13c5226-60cf-4860-bdff-62eb9bae09f4@gmx.de>
Date: Tue, 8 Apr 2025 16:14:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: fwu: Dump custom fields from mdata structure
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <1254c3c538facb1a124865aede861f399cf524df.1742552744.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2vJp3mR3LefzKeeXQAggrJzV7Z8C1HokuJZ2g3MASjqFTdNztxI
 tfwZJhS5yIkGavnFRgYnusRpci+ptHcJw6ACBQSjmpQQljbtNNXO7xIerAbBTUrbcnjNmCw
 eTClzuDK/zBQoU6NFtI9an0cOfiAQOr21zQbAVJyUuKndaBUoX1NdRiAGmQW91HIhPHAS2L
 5uYZqghR7rbgeqk70s2mA==
UI-OutboundReport: notjunk:1;M01:P0:S+bVyuIJw5A=;3MWPL3JmwtyYdxjnT2kW3o1uGv1
 xB9br7SRD8gtcK5FCRQsnfuOFmesAigro6qnuetLB7oNTZOH/UEuEvg5XfXVREJNAWYFKvoAr
 YQbhhof3jLS2t/TBKoWpsnI/Ng2aqkZXgp5vzVmzB8qiqr5IDGCuxdfqZUVP36u4ngglDIXFD
 WD0JktjYtXMil/aDjQbDEJW/KD+gQNZc7+oNT1xHSdASe6PmbF+KRrrJY06+e17OAMOFI9yLC
 eyVsatdcFvn7Pbu9uP+D4bBgwYMQYu28LfuJ82+zJyUrERbdXPhCi69g5hR8B+RSZb5RNEIIT
 pFaAgmAlL9GjOFdlPgyvrvwS82L41byUvkaRbRt42VQyenEYgxlXq896eGwxvgNZ4LLwaT0mA
 HVS2YJ9Mz814keIH7BfuvRPAljRukhtXl3NmpEV+GjhdVaEAkQ/Kiit7GDu9NoUscTg5pECai
 qk/bnZOj9w5L7si7dOey6ZV63Vcr58TkcIkCIFUxwZBJH7xKD2u9zw6DvJQTxClaFJFFu3Neg
 gPsGMzUPmit5PjlW2ftC69EgllGQEGlH9vzdvG0HannsPoBd5SXPSPumeKLJYFN2D+ol7/sP+
 Mx9X56Sf5bnasmOxnWbYBhvwik8LeMmstSIoNvuEHEMVdvxh/WTRk8EMs8U517KYoIccMsCJR
 +znlGE2/NZe/cfELbqn7x5yIORhdfSBYAcQxpSvNL402DI7VQ3AQzzEPBbF8PmXWytPRrimt1
 4c/gsO9CeR4PezVEiz4fIKF5jBlKKNFhQO0zpr5E/hQojFotcG8BhpiGMgDImOUoTDDBkkmAU
 +avSBbZDF4Fi7qZBwIH6Hj1en1JwB8+G4A7+562d3cttIdlKYlsGhI2J/U1Unvm1bym2gVFcc
 0L7XgD4pxJoZUurcBXNZ1Q0xj+WmNsHgf9jpQ7THkJCjfO3uurpg2NcfITsnCzHiIK0PI+qz0
 q3wwB5sS3G3KZGg/+0ZNNvHSBHWQECNTng9xFZ3F70Zzn6i+UPRKQqMgNr5Y0PtS2Wwqt8DNY
 o/onVsdq20qxVKiOgmaIHBjxcWPQdP3m36BJclQC5G4wEYtglouApwDyYnrVAHQEYTBCROXYe
 r1TtTnDVt3lMZQulNIGEv6ddeKdjODYr5MVRD6Hhegh+AcV06mprS3BKEN+ismT370H0QMiVs
 jwxwOjgCj4BA5L0kc0e1nplyCaDZeMRScYe/YA4qHJ6bhYWZdgT5f9YsjKDr4uyCZ/rn1kyWa
 7s5ABnoI++NzWKD55sJPJK+xDDdeRawFydf9iAyLNDocJLO43+arRe4a47TJ3FhmOGJA05GHE
 3U5hVQ+xhLS2z//qNV3lITedw7Z4vVZxuW8vPkQ/QeRs3J/4n6myo6AF5UhbCTjLHq4lY9az/
 zDEqnbFdHjGl4WLKw6F3DRLJaNbxOJc+9XZ8HDAk5txnfD7uAdvDoFpJUo0dK94miivs488bY
 +Md/GFEAiWvfUrEhfZXYoTXvIaBM=
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

On 21.03.25 11:25, Michal Simek wrote:
> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> data to the FWU metadata") added support for adding vendor data to mdata
> structure but it is not visible anywhere that's why extend fwu command t=
o
> dump it.
>
> Tested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
> Changes in v2:
> - Extend print message
> - Cover hexdump dependencies
>
> RFC:
> https://lore.kernel.org/r/75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.17175=
99342.git.michal.simek@amd.com
>
> ---
>   cmd/Kconfig     |  1 +
>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 642cc1116e87..1f8aa2521a8e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -185,6 +185,7 @@ config CMD_UFETCH
>   config CMD_FWU_METADATA
>   	bool "fwu metadata read"
>   	depends on FWU_MULTI_BANK_UPDATE
> +	imply HEXDUMP if FWU_MDATA_V2
>   	help
>   	  Command to read the metadata and dump it's contents
>
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 9c048d69a131..5b5a2e4d1cda 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -7,6 +7,7 @@
>   #include <dm.h>
>   #include <fwu.h>
>   #include <fwu_mdata.h>
> +#include <hexdump.h>
>   #include <log.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>   			       img_info->accepted =3D=3D 0x1 ? "yes" : "no");
>   		}
>   	}
> +
> +	if (data->version =3D=3D 2) {

Should this be >=3D 2 ? Or do we intend to drop custom field support in
future?

> +		struct fwu_mdata *mdata =3D data->fwu_mdata;
> +		struct fwu_fw_store_desc *desc;
> +		void *end;
> +		u32 diff;
> +
> +		/*
> +		 * fwu_mdata defines only header that's why taking it as array
> +		 * which exactly point to image description location
> +		 */
> +		desc =3D (struct fwu_fw_store_desc *)&mdata[1];
> +
> +		/* Number of entries is taken from for loop - variable i */
> +		end =3D &desc->img_entry[i];
> +		debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> +
> +		diff =3D data->metadata_size - ((void *)end - (void *)mdata);
> +		if (diff) {
> +			printf("Custom fields covered by CRC len: 0x%x\n", diff);

The print label is a bit hard to understand. Do you mean:

"Length of custom fields in bytes: 0x%x\n"

Wouldn't print_hex_dump_bytes() already provide an address column
conveying that information?

Best regards

Heinrich

> +			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> +					     end, diff);
> +		}
> +	}
>   }
>
>   int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,

