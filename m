Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F97C5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 06:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAEED4091F;
	Thu, 13 Aug 2026 06:28:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AS4GnQNob80e; Thu, 13 Aug 2026 06:28:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 867B14088B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786602515;
	bh=C2Sz+MAQu4RssbNjeOXV1mKhdj4VOb9cnQ2MXAToKcs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wfQxrLCld7xnlXoPDxfOyzv3ZiZyRJc8Yjlwv09mhPvDgaYOvPGWoj2Xky13vEydX
	 YyGazlPiO8Ns3KFwWCD+36/SUi4qiH0NWLYcFZSyKGnkazcZ0w6cOPW/yVZYtSOo7A
	 j5nf3Tg3VtOFpE4VqikY/Te8bfrSNWqnd8w/dk1ovUM7gJ60/ur7h0lJAc28V4gNz+
	 mJBP8aEaz1GBW2553HSYKCa1NF0Dd4qqjOx54Uh1ODcYlhb6SPtKHHrfM/md15Xq5Z
	 3G7WeTSltsjsYJvlvGLdbEI/8g7N4D5d3WX3Ps1HW6obELiZpaxih0jgvAtGbxUXG1
	 yGO8vnHdCqB9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 867B14088B;
	Thu, 13 Aug 2026 06:28:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D0F82109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C283E81184
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPUZ03MCecZa for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 06:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5A86C81183
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A86C81183
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A86C81183
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:28:31 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O6e-1wrepv1swo-005psL; Thu, 13
 Aug 2026 08:28:21 +0200
Date: Thu, 13 Aug 2026 08:28:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/4=5D_efi=5Floader=3A_firmware=3A_tra?=
 =?US-ASCII?Q?ck_last_attempt_status_for_ESRT_reporting?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260813-efi-esrt-last-attempt-v1-1-3be172f47d9d@oss.qualcomm.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
 <20260813-efi-esrt-last-attempt-v1-1-3be172f47d9d@oss.qualcomm.com>
Message-ID: <7644192B-CE1B-437D-8D87-0F0D22D75EEA@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L82qnxtDx8gz4jgNGpWTAVy2J9aikdKCmxlUjT1YeZpWl47RWYr
 urgrgphDeNjIhTeqxvFBg9+aisfxjOsK0XgxLWYW/R/SmGcuH1yem7qXIoccAsFWYyyN6EE
 5nplNbVBANkcGU9Q45u3O/RuBR/+4qCBOcxyYi5Axuc/sVGyPV1N19iaroFMY8pTJ9MYWCc
 6CFWreUHNxCbMlv5cqEtQ==
UI-OutboundReport: notjunk:1;M01:P0:8Kj5Hlykb6s=;CvQkoNgNBoe40OkFqMa9g7myXDy
 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
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1786602501; x=1787207301; i=xypron.glpk@gmx.de;
 bh=C2Sz+MAQu4RssbNjeOXV1mKhdj4VOb9cnQ2MXAToKcs=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CGEVe25QGACTDckeSoqqt117NTjVgzNdzswpo7nW6sn2LH9Q1qP7rBrc/lTkTDK8
 8IF8JhN5ek6nGlXmaKTwDSq4A/veAYMBrjqOaTQNL6xd11mQM6WvFVwlC5hjbbVxm
 k7Z+ai9i/qgtt1nR+nGmtkg1hCDlsCMO2FPsIncPB0UoT+LjwM1mZPbCcMO15pBHL
 h/g7nMS9wW7RAEopHMtpyij3wfhijlwFXT8JCqMgrFKi0u7IzZVYJpRqKAnOHQDr1
 NhwvCDmcMllYQnRiEaiP4H0iJOSCdF+Kpf8MHL+mjtwB69ZCGBOcgIZq+awPbnMj9
 fsv0aTr1AKWc4Bj65g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=CGEVe25Q
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Am 13=2E August 2026 07:50:17 MESZ schrieb Balaji Selvanathan <balaji=2Esel=
vanathan@oss=2Equalcomm=2Ecom>:
>The last_attempt_version and last_attempt_status fields in struct
>fmp_state were carried but never populated, so the ESRT last-attempt
>information exposed to the OS stayed at its boot-time defaults
>regardless of what happened during an update=2E
>
>Add the plumbing to maintain them: a helper to record the attempted
>version and status, a mapping from internal efi_status_t codes to the
>UEFI LAST_ATTEMPT_STATUS_* values, and reads/writes of the two fields
>in efi_firmware_fill_version_info() and efi_firmware_set_fmp_state_var()=
=2E
>fw_version is now only advanced on a successful update so a failed
>attempt no longer overwrites the recorded good version=2E
>
>Signed-off-by: Balaji Selvanathan <balaji=2Eselvanathan@oss=2Equalcomm=2E=
com>
>---
> lib/efi_loader/efi_firmware=2Ec | 74 +++++++++++++++++++++++++++++++++++=
++++----
> 1 file changed, 68 insertions(+), 6 deletions(-)
>
>diff --git a/lib/efi_loader/efi_firmware=2Ec b/lib/efi_loader/efi_firmwar=
e=2Ec
>index b41969c70fd=2E=2Ecbe8bcd7c64 100644
>--- a/lib/efi_loader/efi_firmware=2Ec
>+++ b/lib/efi_loader/efi_firmware=2Ec
>@@ -52,9 +52,9 @@ struct fmp_payload_header {
>  */
> struct fmp_state {
> 	u32 fw_version;
>-	u32 lowest_supported_version; /* not used */
>-	u32 last_attempt_version; /* not used */
>-	u32 last_attempt_status; /* not used */
>+	u32 lowest_supported_version; /* not used - read from DTB for security =
*/
>+	u32 last_attempt_version;     /* used for esrt tracking */

Thank you for improving the ESRT reporting=2E

Please, provide a description explaining which information is contained in=
 the field=2E

>+	u32 last_attempt_status;      /* used for esrt tracking */

ditto


> };
>=20
> /**
>@@ -190,6 +190,49 @@ static void efi_firmware_get_lsv_from_dtb(u8 image_i=
ndex,
> 	}
> }
>=20
>+/**
>+ * efi_firmware_set_last_attempt - set last attempt information
>+ * @state:		Pointer to fmp state
>+ * @attempt_version:	Version that was attempted

version of what?

How about:

Firmware version of the last attempted capsule update=2E

>+ * @attempt_status:	Status of the attempt

With type u32 and "Status" I would have no clue which values to expect and=
 what they might mean=2E

In the description you could refer to the enum containing LAST_ATTEMPT_STA=
TUS_SUCCESS et al=2E

Best regards

Heinrich

>+ *
>+ * Set the last attempt version and status in the fmp_state structure=2E
>+ */
>+static void efi_firmware_set_last_attempt(struct fmp_state *state,
>+					  u32 attempt_version,
>+					  u32 attempt_status)
>+{
>+	state->last_attempt_version =3D attempt_version;
>+	state->last_attempt_status =3D attempt_status;
>+}
>+
>+/**
>+ * efi_firmware_map_error_to_status - map internal errors to UEFI status=
 codes
>+ * @error:	Internal error code
>+ *
>+ * Map U-Boot internal error codes to UEFI-compliant last attempt status=
 codes=2E
>+ *
>+ * Return: UEFI last attempt status code
>+ */
>+static u32 efi_firmware_map_error_to_status(efi_status_t error)
>+{
>+	switch (error) {
>+	case EFI_SUCCESS:
>+		return LAST_ATTEMPT_STATUS_SUCCESS;
>+	case EFI_OUT_OF_RESOURCES:
>+		return LAST_ATTEMPT_STATUS_ERROR_INSUFFICIENT_RESOURCES;
>+	case EFI_INVALID_PARAMETER:
>+		return LAST_ATTEMPT_STATUS_ERROR_INCORRECT_VERSION;
>+	case EFI_SECURITY_VIOLATION:
>+		return LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR;
>+	case EFI_UNSUPPORTED:
>+		return LAST_ATTEMPT_STATUS_ERROR_INVALID_FORMAT;
>+	case EFI_DEVICE_ERROR:
>+	default:
>+		return LAST_ATTEMPT_STATUS_ERROR_UNSUCCESSFUL;
>+	}
>+}
>+
> /**
>  * efi_firmware_fill_version_info - fill the version information
>  * @image_info:		Image information
>@@ -237,8 +280,15 @@ void efi_firmware_fill_version_info(struct efi_firmw=
are_image_descriptor *image_
>=20
> 	ret =3D efi_get_variable_int(varname, &fw_array->image_type_id,
> 				   NULL, &size, var_state, NULL);
>-	if (ret =3D=3D EFI_SUCCESS && expected_size =3D=3D size)
>+	if (ret =3D=3D EFI_SUCCESS && expected_size =3D=3D size) {
> 		image_info->version =3D var_state[active_index]=2Efw_version;
>+		image_info->last_attempt_version =3D var_state[active_index]=2Elast_at=
tempt_version;
>+		image_info->last_attempt_status =3D var_state[active_index]=2Elast_att=
empt_status;
>+	} else {
>+		/* Default values if no previous state exists */
>+		image_info->last_attempt_version =3D 0;
>+		image_info->last_attempt_status =3D LAST_ATTEMPT_STATUS_SUCCESS;
>+	}
>=20
> 	free(var_state);
> }
>@@ -427,6 +477,10 @@ efi_status_t efi_firmware_capsule_authenticate(const=
 void **p_image,
>  * @image_index:	image index
>  *
>  * Update the FmpStateXXXX variable with the firmware update state=2E
>+ * On successful update (last_attempt_status =3D=3D LAST_ATTEMPT_STATUS_=
SUCCESS),
>+ * updates fw_version to the new version=2E
>+ * On failed update, preserves the old fw_version=2E
>+ * Always updates last_attempt_version and last_attempt_status=2E
>  *
>  * Return:		status code
>  */
>@@ -471,11 +525,19 @@ efi_status_t efi_firmware_set_fmp_state_var(struct =
fmp_state *state, u8 image_in
> 		memset(var_state, 0, num_banks * sizeof(*var_state));
>=20
> 	/*
>-	 * Only the fw_version is set here=2E
>+	 * Set fw_version and last attempt information=2E
> 	 * lowest_supported_version in FmpState variable is ignored since
> 	 * it can be tampered if the file based EFI variable storage is used=2E
>+	 *
>+	 * Only update fw_version if the update succeeded=2E
>+	 * On failure, preserve the old fw_version to maintain accurate ESRT st=
ate=2E
> 	 */
>-	var_state[update_bank]=2Efw_version =3D state->fw_version;
>+	if (state->last_attempt_status =3D=3D LAST_ATTEMPT_STATUS_SUCCESS)
>+		var_state[update_bank]=2Efw_version =3D state->fw_version;
>+	/* else: keep existing fw_version (don't update on failure) */
>+
>+	var_state[update_bank]=2Elast_attempt_version =3D state->last_attempt_v=
ersion;
>+	var_state[update_bank]=2Elast_attempt_status =3D state->last_attempt_st=
atus;
>=20
> 	size =3D num_banks * sizeof(*var_state);
> 	ret =3D efi_set_variable_int(varname, image_type_id,
>

