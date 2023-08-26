Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6320C83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 10:27:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 254E586A69;
	Sat, 26 Aug 2023 12:27:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="pv0c0jCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6592586A77; Sat, 26 Aug 2023 12:27:07 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB30869A6
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 12:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693045623; x=1693650423; i=xypron.glpk@gmx.de;
 bh=bQ3m5X9Vp+OPMkny5z2i7sxw7dAcFXwl4RJHm5krUZo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pv0c0jCMSYvvr1A4TCiylmIsfaBvWvCMeihVAswtzTebjl8fKCMh6V/6osO9IXRwwSpV32a
 Z6k/CxV6o6mQ3/v1CPSpM0xwAelBm+rReUU5IZKSg4wexWi4uLL/0g380EUJ1RQTQ+7Wxo+Lh
 WtbI55op64UtRdajt9ZW/KnLPq5jxUZcjcgBd4CVTmnsjskunRtwbxO25nQrVtkFMSLB9gQ/C
 go9rDWQ7jYC+1U29YKDhO4DpROUpoCXozBzhzUkxbEdDJIE2kPVUSRfBZ004x1K4xndG2tsln
 V8yva7VVKz88Z+ve8rzJinhV/5gv7EO5QJo0kVMDbX3SpzL6Ercw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNh1-1q44vB47F1-00hw3G; Sat, 26
 Aug 2023 12:27:03 +0200
Message-ID: <5c05f436-8c92-4b01-fcdf-ed9e0ec31d44@gmx.de>
Date: Sat, 26 Aug 2023 12:27:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 4/5] bootefi: Call the EVT_FT_FIXUP event handler
Content-Language: en-US, de-DE
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <20230826090633.239342-5-sughosh.ganu@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230826090633.239342-5-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iZjul+4VuLb2V3eDOJo0R2hTI0Xw1G+sLAgFnYkFRR1bthXaJq/
 X8NYmcjZmwYGfLYYf0ubc0ltTQIk7JVUa2FOTQAZgPcyMCdYAYavjBQl7X+yx6IfviFsXTh
 E5BB+6D822+0CownhzazmWoeyQqsEx7TbC6KC6vwq8GmatqJa4wn3yBY3TpVqErTmEBRHVp
 vd4OxJwv5DDrMKu2n2siw==
UI-OutboundReport: notjunk:1;M01:P0:wXhlVr7ECSU=;ZpBEojB8DBOdJk8AUZhLfs2y71n
 rhfMpRjLB1qB9VvpYpXwS6rFfQ/EVbFrGg91NYGIgUB0aO+u4tP1ttcluXR+p9KwyvzVFOUWb
 10uyQeuIN3GKRtTK/SRKyeyUYHMO5mGFYHsQrNmCIjpPuSS7q407DcmJpcj4xUmxKlHWyxHRq
 UD5SNiWRqn6x3+2VjgwVcxOylSD4MNgKIdK59ewHEjEJgtlYEMGAAy5k0UcE/3ZQX4UEDL2u2
 zJ0sdrLw8daLHJaB233SqAtvy02yWG+bcqQlEswq7kImvurAb+JVPmyOE4bWbqsuelzleZJf3
 YfpjQO/oySNa5v4lATTwYkHG356OpBl/RboQ8I1xLYWgTQqmF1iCUVrkue12s20JE+aM7zYjd
 6D/TUVVCiZHvrKV/rNHB636cIUNUWo3i/sA/l2WaKLgPZJDLZUu5CTJWDGfm1BPOdWD2zp3nQ
 NL/Z8zKhtN2EphNiFKrq3mXV7GD8EoJtH8XuzsXNrKR6qeUIFRGWAadWNjFAdm5eGv5PlbSDD
 Qqs+RsJ0z10Eoq+wxf2y9raF5RjaF+UTC5UgaOZjsUAcse7mKdSzK7CRE6vqSEoTM1OQxTFmv
 f7zSTxQyZd+N8Ie6U/rMse0s+BRs4phKN8Nq0QFWFW7hreq1He5xwfPMpC++6pwUxUJeo2jNf
 BpbJlwcsp1moOJ4POxj9IvkNlkRbjYF02LRXNKcvOBfVYGOidX4KZPnXNg1cc5kROuv+3OKm4
 mSk2f0pOpCduTJAiklZs7XYF5ilcDhblfWSlVMMkglay+jazudUv6VDjN4+Iv6Veu/yLib1Bv
 TcYJBpw5bCxbQIiqNukWZHbFDV/+HwCGF0Y6/lagcpyN+CjwQCgpDcxPGHccAxd8RHVFNm8H0
 /5tTe8Nc9GjnEeO4TTagZUsn3sr/jAXnFjmoj+OZoZufDeXqCCdX4bm3X3qKzt9PEb1cg1BMC
 v9Jt8YbezCPSoIV1gTDO9fPnYfQ=
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
> The bootefi command passes the devicetree to the kernel through the
> EFI config table. Call the event handlers for fixing the devicetree
> before jumping into the kernel. This removes any devicetree nodes
> and/or properties that are specific only to U-Boot, and are not to be
> passed to the OS.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>   cmd/bootefi.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> index f73d6eb0e2..c359a46ec4 100644
> --- a/cmd/bootefi.c
> +++ b/cmd/bootefi.c
> @@ -237,6 +237,23 @@ static void *get_config_table(const efi_guid_t *gui=
d)
>   	return NULL;
>   }
>
> +/**
> + * event_notify_dt_fixup() - call ft_fixup event
> + *
> + * @fdt:	address of the device tree to be passed to the kernel
> + *		through the configuration table
> + * Return:	None
> + */
> +static void event_notify_dt_fixup(void *fdt)
> +{
> +	int ret;
> +	struct event_ft_fixup fixup =3D {0};
> +
> +	fixup.tree.fdt =3D fdt;
> +	ret =3D event_notify(EVT_FT_FIXUP, &fixup, sizeof(fixup));
> +	if (ret)
> +		printf("Error: %d: FDT Fixup event failed\n", ret);
> +}
>   #endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
>
>   /**
> @@ -318,6 +335,7 @@ efi_status_t efi_install_fdt(void *fdt)
>   	efi_carve_out_dt_rsv(fdt);
>
>   	efi_try_purge_kaslr_seed(fdt);
> +	event_notify_dt_fixup(fdt);

The event is already triggered in image_setup_libfdt(). Don't trigger it
twice.

Best regards

Heinrich

>
>   	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
>   		ret =3D efi_tcg2_measure_dtb(fdt);

