Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AF3C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 15:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1DB38761B;
	Sat,  9 Dec 2023 16:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GilVLunj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D4687660; Sat,  9 Dec 2023 16:09:50 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD7C874CA
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 16:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702134588; x=1702739388; i=xypron.glpk@gmx.de;
 bh=bvTeyRlyYCuX7mBKdiB0AxfAXSIJAZnzjSdEDec/SVs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=GilVLunj0H3r5ol+Uz/gZTPSJG7j/u8fbFkSatVP342fDGDviTO83DtAk3fkrh9v
 MpBufAPwf5zAKbn2HHvSp1jwc1DgXgZT5eAj5vKjzPZ+2Fvv00YWCc7JF/2CXd3S0
 dNUSZO3EsAp35ahtcgVrNaL6yyNFGT/N1P9LIlcB7ctB7m9+hSnapf1qsXqvHZbbK
 +9nbKFj/5bhwSDS+YSz2jHZOTkdSqJYcgL3yoJQHfgpbhWml+rXeXBAC2+8tqX1JJ
 bPbO+IsMMSdpx9/A7FeewUdhtcxNvIJQuGBKYs42r3UIlj4cEVGacNMwP2lS4PG9p
 pAxa7DMjkZAu3dWooA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtwYu-1rUcsB3GF2-00uM12; Sat, 09
 Dec 2023 16:09:47 +0100
Message-ID: <45ff39a5-0234-4fae-a174-732725e6c359@gmx.de>
Date: Sat, 9 Dec 2023 16:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] efi_loader: support FMP versioning for FWU multi bank
 update
Content-Language: en-US, de-DE
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
 <20231114092508.3955838-3-masahisa.kojima@linaro.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231114092508.3955838-3-masahisa.kojima@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fbphTSLU3s8i2BDdFm92OAMTT/T6WxbNhld4FvoZ8M9qQNjU7+2
 aW/FSCFIwl6rseZIHy5zwjrCX6IS5yr+/+OYyUbC92eSy2vUxaBnKDidKGYD1AL18n5sE8C
 LCPCooSLazR6KNcfonhoZfuGXtchdeqgpHRAmwWf7P8NUHmvowaQYSFoOywv/PW3SxB3kaU
 uLhre25HXP6f1H78go3BA==
UI-OutboundReport: notjunk:1;M01:P0:LjGW5k3oXQ8=;vKgBOZ4y2KrsOD2AJMH36mezprb
 czw9bBzUy5I/o66+c/HsvYRnuJ7aep/IsHfY94W3YXUkbmeI5W/rlH9KTWQwl4nSAUGirGhVi
 SExcraGDp4c4eVKhBW1COoEtWnrx/JDNjRCyCkb7rjvlWU8hH0j1iOBaNcvoZ02Z+tCBnLo3E
 C+ZS/FPU+4zQKaSkny+HWjByXCvpUD7tmbSvQLRjzqVqxaERhMgEF+tHt2Hens4t8MCa8MhmG
 ZOeMuDW/4220R5oW/xdeItTUTmNUyB2pHPH7oN+6A56EsWrHokG61oYpbXb3Oco9U6WGrZjWp
 PuEmrlaHLLa4mxeeDQXIHj2WAJTeXZ0Vqun734UpVq5EnvaySb3uZvJ1hjaB1Ib9aSv85LQYx
 oug8dMyiAnpeB5XkZjhcO6dqNHnlmwnFmnNxBXPX+PKyhhbJRJXCyNR761mfsc9Uh332Wv6Ho
 E6qI6YqfTKDfVoLwS3c+owiZ+lkJMD+DJrqvQfGz3Z90mpaCxBUZOIQLMweKG+GkbGZxmYaNB
 G8TluyN2hA837e92uWobAhcvo2oQB80Bq7sOqvSjv6Hst+mrE+2FAV83YZVmYnqbuE+KS/Jb6
 WRM0h5/Nxj0F1OIw75da0/lLp1TUidWDykbrsLhuEZw+M9qnMe1QOQit2psdkeo1+cq+VVegb
 VDIjcVUKfRWFsi8XIUeRa0yc3AxWE3iksBDobQwtsfdb/WLa5wUVygQ+gQB+JtYUr7VAY6tsJ
 2btCqoETqKaDye1WaTxHxfggeWq6hEESJCe5pR1PnqRY5dwHsCrjB03oaoVGXe2wuMXwi0vEB
 rGTifvp9Ov8/EL3V6Vg87GKdhxaMYMy3iXeIgDurssUK5Gykdhv5AWJ8Gb06rfm3lA6hBUjSt
 GllNx7hL91F2erd1JQYj0uPdcRHvcH2Tm+Bok39yKs2EzIwqqHWxMBrxrG1QVsNxb2sAn5QYm
 W6sZwg==
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

On 11/14/23 10:25, Masahisa Kojima wrote:
> Current FMP versioning uses the FMPStateXXXX UEFI variables

Do you mean FmpState####?

> that XXXX indicates image_index. When CONFIG_FWU_MULTI_BANK_UPDATE
> is enabled, U-Boot instances installed in different banks
> read the same FMPStateXXXX variable and it ends up with reading
> wrong fw_version.
>
> This commit includes the bank_index in the FMPStateXXYY variable.
> XX indicates a bank_index, YY indicates an image_index.
> With this, it keeps backward compatibility for the case that
> CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, bank_index is
> always 0 for this case.
>
> The bank index size is defined 4 bytes in FWU-PSA-A_DEN0118_1.0ALP3.pdf,
> but 1-255 range is practically enough big. This commit adds the range
> for FWU_NUM_BANKS since above XX(bank_index) has 1 byte.

Who would need more than 16 banks (i.e. more than one digit)?

What happens when the image number reaches 256 (or 4096 for 3 digits)?
What happens with devices out in the field that already have reached
image number 256?

Why don't we store the fmp_state of all banks in the same FmpState####
variable as an array? This should have a better chance of backwards
compatibility.

Best regards

Heinrich

>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> ---
>   lib/efi_loader/efi_firmware.c | 63 ++++++++++++++++++++++++++---------
>   lib/fwu_updates/Kconfig       |  1 +
>   2 files changed, 48 insertions(+), 16 deletions(-)
>
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index 9c1a273926..6d3620a649 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -205,13 +205,33 @@ static
>   void efi_firmware_fill_version_info(struct efi_firmware_image_descript=
or *image_info,
>   				    struct efi_fw_image *fw_array)
>   {
> -	u16 varname[13]; /* u"FmpStateXXXX" */
> +	int err;
> +	u16 varname[13]; /* u"FmpStateXXYY" */
>   	efi_status_t ret;
>   	efi_uintn_t size;
> +	uint active_bank =3D 0, var_index;
>   	struct fmp_state var_state =3D { 0 };
>
> +	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> +				      &fw_array->image_type_id,
> +				      &image_info->lowest_supported_image_version);
> +
> +	image_info->version_name =3D NULL; /* not supported */
> +	image_info->last_attempt_version =3D 0;
> +	image_info->last_attempt_status =3D LAST_ATTEMPT_STATUS_SUCCESS;
> +
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		err =3D fwu_get_active_index(&active_bank);
> +		if (err) {
> +			log_debug("Unable to get active index\n");
> +			image_info->version =3D 0;
> +			return;
> +		}
> +	}
> +
> +	var_index =3D ((active_bank & 0xFF) << 8 | (fw_array->image_index & 0x=
FF));
>   	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> -				fw_array->image_index);
> +				var_index);
>   	size =3D sizeof(var_state);
>   	ret =3D efi_get_variable_int(varname, &fw_array->image_type_id,
>   				   NULL, &size, &var_state, NULL);
> @@ -219,14 +239,6 @@ void efi_firmware_fill_version_info(struct efi_firm=
ware_image_descriptor *image_
>   		image_info->version =3D var_state.fw_version;
>   	else
>   		image_info->version =3D 0;
> -
> -	efi_firmware_get_lsv_from_dtb(fw_array->image_index,
> -				      &fw_array->image_type_id,
> -				      &image_info->lowest_supported_image_version);
> -
> -	image_info->version_name =3D NULL; /* not supported */
> -	image_info->last_attempt_version =3D 0;
> -	image_info->last_attempt_status =3D LAST_ATTEMPT_STATUS_SUCCESS;
>   }
>
>   /**
> @@ -353,15 +365,20 @@ efi_status_t efi_firmware_capsule_authenticate(con=
st void **p_image,
>    * @state:		Pointer to fmp state
>    * @image_index:	image index
>    *
> - * Update the FmpStateXXXX variable with the firmware update state.
> + * Update the FmpStateXXYY variable with the firmware update state.
> + * XX is a bank index, YY is an image_index
> + * When CONFIG_FWU_MULTI_BANK_UPDATE is not enabled, update_bank is alw=
ays 0.
>    *
>    * Return:		status code
>    */
>   static
>   efi_status_t efi_firmware_set_fmp_state_var(struct fmp_state *state, u=
8 image_index)
>   {
> -	u16 varname[13]; /* u"FmpStateXXXX" */
> +	int err;
> +	u16 varname[13]; /* u"FmpStateXXYY" */
>   	efi_status_t ret;
> +	uint update_bank =3D 0;
> +	unsigned int var_index;
>   	efi_guid_t *image_type_id;
>   	struct fmp_state var_state =3D { 0 };
>
> @@ -369,9 +386,15 @@ efi_status_t efi_firmware_set_fmp_state_var(struct =
fmp_state *state, u8 image_in
>   	if (!image_type_id)
>   		return EFI_INVALID_PARAMETER;
>
> -	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> -				image_index);
> +	if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
> +		err =3D fwu_plat_get_update_index(&update_bank);
> +		if (err)
> +			return EFI_INVALID_PARAMETER;
> +	}
>
> +	var_index =3D ((update_bank & 0xFF) << 8 | (image_index & 0xFF));
> +	efi_create_indexed_name(varname, sizeof(varname), "FmpState",
> +				var_index);
>   	/*
>   	 * Only the fw_version is set here.
>   	 * lowest_supported_version in FmpState variable is ignored since
> @@ -563,7 +586,11 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
>   	if (fit_update(image))
>   		return EFI_EXIT(EFI_DEVICE_ERROR);
>
> -	efi_firmware_set_fmp_state_var(&state, image_index);
> +	status =3D efi_firmware_set_fmp_state_var(&state, image_index);
> +	if (status !=3D EFI_SUCCESS) {
> +		log_err("Set FmpState variable failed\n");
> +		return EFI_EXIT(status);
> +	}
>
>   	return EFI_EXIT(EFI_SUCCESS);
>   }
> @@ -643,7 +670,11 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>   			     NULL, NULL))
>   		return EFI_EXIT(EFI_DEVICE_ERROR);
>
> -	efi_firmware_set_fmp_state_var(&state, original_image_index);
> +	status =3D efi_firmware_set_fmp_state_var(&state, original_image_index=
);
> +	if (status !=3D EFI_SUCCESS) {
> +		log_err("Set FmpState variable failed\n");
> +		return EFI_EXIT(status);
> +	}
>
>   	return EFI_EXIT(EFI_SUCCESS);
>   }
> diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
> index d35247d0e5..eb42f25fc0 100644
> --- a/lib/fwu_updates/Kconfig
> +++ b/lib/fwu_updates/Kconfig
> @@ -14,6 +14,7 @@ if FWU_MULTI_BANK_UPDATE
>
>   config FWU_NUM_BANKS
>   	int "Number of Banks defined by the platform"
> +	range 1 255
>   	help
>   	  Define the number of banks of firmware images on a platform
>

