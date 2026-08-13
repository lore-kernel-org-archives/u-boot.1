Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B0AC5CFEB
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 06:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60CE940953;
	Thu, 13 Aug 2026 06:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hc4Z6P2r9X3G; Thu, 13 Aug 2026 06:32:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFDCC40921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786602758;
	bh=Zxo9tzD98RDs1/CNHCYEQuMx5jPDn8uXg84D2rzjSKU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f8CBxBVpmjCfKFRiiGSv00GYr1fhnhF7zPmmIrJkmlUSaa40si5OjF9i4742TZJLu
	 oGGqwmpUsfLWWe8/3XHGTn8usTteFMcmqRCvSWtH4/uzQS6WGlnz/Knr5LyWX6GznA
	 2636Yn9wArd/ZhDqiukXIYuw9mIXXGFDQmGk/d+TJCwI7oAQ0tgFu0k8qm4V1WAwWA
	 K7mZSlf2/1IaLZE+arTU5dDHuhdrSqvwq4BUAAky0dPnTjdk3tQQMh4iBJcu6Pz/eL
	 CNjH2/IVqR7huwY7dIZpGburi7i0rW8Ieb6XaBAkZ4gkpgPY3xTDbcCJLPaQn09Z+g
	 XiVsrdaNy7exw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EFDCC40921;
	Thu, 13 Aug 2026 06:32:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 10765109
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAC9B608F0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bFucxfgAcLe for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 06:32:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9C28B608D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C28B608D6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C28B608D6
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:32:34 +0000 (UTC)
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1x7xrE1egF-00tF5T; Thu, 13
 Aug 2026 08:32:27 +0200
Date: Thu, 13 Aug 2026 08:32:24 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/4=5D_efi=5Floader=3A_firmware=3A_ad?=
 =?US-ASCII?Q?d_last_attempt_tracking_for_RAW_capsules?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260813-efi-esrt-last-attempt-v1-2-3be172f47d9d@oss.qualcomm.com>
References: <20260813-efi-esrt-last-attempt-v1-0-3be172f47d9d@oss.qualcomm.com>
 <20260813-efi-esrt-last-attempt-v1-2-3be172f47d9d@oss.qualcomm.com>
Message-ID: <7771DEF8-C35B-4004-98E0-41A30338B633@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rd4QK5ej7PL3DJxBfKKVvOT34EMsnOXsVjsezCviDgodFMIKt+2
 k+WO360btDuUOHD5Ga2AN1Z4FNpAFdu8mzqL417b/6hb4ch6R5kkoImJN8pHr6bxpPL3aiN
 1w6z2qTQ2ErN+eOYjurbkvN7BlKDmYrIpVqiFQkhVquaJqU2+teI2W2HktnZo1Df8lFeQxq
 e/IMiEbBC0y6oK1UUSn8Q==
UI-OutboundReport: notjunk:1;M01:P0:2K5Vv20+5PE=;F5a7VKhMM3hDTM0CeFQ9FgF6iMz
 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
 mfaM6qA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmx.de; 
 s=s31663417; t=1786602747; x=1787207547; i=xypron.glpk@gmx.de;
 bh=Zxo9tzD98RDs1/CNHCYEQuMx5jPDn8uXg84D2rzjSKU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=BbG1ePoSbgBVM6WEQTEkvnB9PPM0+JZiRdbkLv12EElZb8ZRzH+60uGjoCJg6Gyr
 Q3IkHhxjMwaguM2DVS7BEKGr49HriA3s3+2zwqEKdZjxgJSQAedufXRZnQ2jXwmzS
 05JhJrqdaBy4WY4klXoX/3sR+0zClUHruA7cKyZk8+Coj2nzQHKoac6YjfArinPTx
 z4PgMPv/87JlOEg7mz87Po6+susjkLy0imkSlBE3g4onCBJa+GSiIgK53zfQ/bbHG
 a5m2PyQqxvG/Ys8Ws9qfREQ5UHy3d1rFYVYWb11awlZRE9xLtwqmaU90JXyL+/wJ+
 IP31hzEdj+ZxyJDNww==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=gmx.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=BbG1ePoS
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

Am 13=2E August 2026 07:50:18 MESZ schrieb Balaji Selvanathan <balaji=2Esel=
vanathan@oss=2Equalcomm=2Ecom>:
>Now that the tracking helpers exist, call them from the RAW capsule

Why only RAW capsules and not FIT capsules too?

>path=2E efi_firmware_raw_set_image() records the attempted version and
>the mapped status at each point it can bail out (verification failure,
>strdup/env_set errors, and a failed dfu_write_by_alt), and records
>success once the write completes=2E
>
>Either way it then writes the FMP state variable, so a query of ESRT
>reflects the outcome of the last attempt instead of stale boot-time
>values=2E
>
>Signed-off-by: Balaji Selvanathan <balaji=2Eselvanathan@oss=2Equalcomm=2E=
com>
>---
> lib/efi_loader/efi_firmware=2Ec | 35 ++++++++++++++++++++++++++++++-----
> 1 file changed, 30 insertions(+), 5 deletions(-)
>
>diff --git a/lib/efi_loader/efi_firmware=2Ec b/lib/efi_loader/efi_firmwar=
e=2Ec
>index cbe8bcd7c64=2E=2E455d79a19ca 100644
>--- a/lib/efi_loader/efi_firmware=2Ec
>+++ b/lib/efi_loader/efi_firmware=2Ec
>@@ -824,8 +824,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>=20
> 	status =3D efi_firmware_verify_image(&image, &image_size, image_index,
> 					   &state);
>-	if (status !=3D EFI_SUCCESS)
>+	if (status !=3D EFI_SUCCESS) {
>+		/* Set last attempt information for failed verification */
>+		efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+					      efi_firmware_map_error_to_status(status));
>+		efi_firmware_set_fmp_state_var(&state, image_index);
> 		return EFI_EXIT(status);
>+	}
>+
>+	/* Set last attempt version before starting the update */
>+	efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+				      LAST_ATTEMPT_STATUS_SUCCESS);
>=20
> 	/*
> 	 * dfu_alt_num is assigned from 0 while image_index starts from 1=2E
>@@ -850,13 +859,21 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
> 		orig_dfu_env =3D strdup(orig_dfu_env);
> 		if (!orig_dfu_env) {
> 			log_err("strdup() failed!\n");
>-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>+			status =3D EFI_OUT_OF_RESOURCES;
>+			efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+						      efi_firmware_map_error_to_status(status));
>+			efi_firmware_set_fmp_state_var(&state, image_index);
>+			return EFI_EXIT(status);
> 		}
> 	}
> 	if (env_set("dfu_alt_info", update_info=2Edfu_string)) {
> 		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
> 		free(orig_dfu_env);
>-		return EFI_EXIT(EFI_DEVICE_ERROR);
>+		status =3D EFI_DEVICE_ERROR;
>+		efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+					      efi_firmware_map_error_to_status(status));
>+		efi_firmware_set_fmp_state_var(&state, image_index);
>+		return EFI_EXIT(status);
> 	}
>=20
> 	ret =3D dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
>@@ -867,9 +884,17 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
>=20
> 	free(orig_dfu_env);
>=20
>-	if (ret)
>-		return EFI_EXIT(EFI_DEVICE_ERROR);
>+	if (ret) {
>+		status =3D EFI_DEVICE_ERROR;
>+		efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+					      efi_firmware_map_error_to_status(status));
>+		efi_firmware_set_fmp_state_var(&state, image_index);
>+		return EFI_EXIT(status);
>+	}
>=20
>+	/* Update successful - set success status */
>+	efi_firmware_set_last_attempt(&state, state=2Efw_version,
>+				      LAST_ATTEMPT_STATUS_SUCCESS);
> 	efi_firmware_set_fmp_state_var(&state, image_index);
>=20
> 	return EFI_EXIT(EFI_SUCCESS);
>

