Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA0606A320
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f4dshPr/;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=K87T3jeQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDC624069B;
	Sun, 22 Nov 2026 12:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4YkFGf2S6bF; Sun, 22 Nov 2026 12:56:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A15AF40674
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795352184;
	b=SaELqkzt+fSjJA3C64xXb6MYWzzT/xm7jhZ4agVjoNk+YY6+R3UOSOaZk1NQ+gvwb3pJ
	 KG96/k0c7u35K4OfG53La+z8YuIR3oMdHDAa1/u9Kp4v8NdRPCbB58wk7/xXHT+aow7+q
	 9pPsKRKZRqwAy9xQfOV+0fQ7QPx6cPqHkM7zJNKHtAWzcXiLrwWUaNLBJVWtITar1Svul
	 Vr+33KZ/UMHCAsPNHfz8Z5+l7j4sDBAJjt68XKlH+raCaNq3S2J7j0U6YqeZ5lbU4WNky
	 5sWNjrDWjjpPQMtKSPlbEvVKEdUFUoY/skxMCRQ2u7vvbXy5gEgaZdoMOffZYpJyNeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795352184;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9K5XtBrl10GhS54TpDdMsFOnmWqRAPaVqkZEqnJwcYA=;
	b=ZkB4rzMuM6v56NJmNvW8pqFuxQIjXXr6U+PnOm2fc+vcQlYRQXkCDyOeD1wYnti7R0c7
	 hlDW/uat5VcpY5uGrwYIwp0SVsceRW6zdd27/ttPg8bcrT4TXxli8OuddpYicnkDUZV02
	 g314ouwYMIsQgPu1sPDFRyxspbH34mOL5aNq/60X2tyY2J92BmhXlUuSW8Ma3reybYxg7
	 rFmMPOU7IbCefup03HWO+axIgDTN2XApgYQrvA4pMgd0nNbSO4BkiAgm7bk041pNbDdDB
	 RKlTkyj1naqQ+GK95znspsxwQlZL5aR2bqgX111w6M44sS04m1z7gdT+wqknayzfbTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795352184;
	bh=9K5XtBrl10GhS54TpDdMsFOnmWqRAPaVqkZEqnJwcYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f4dshPr/9LWmOr1DBl0LW7rdnfCU7G/PdnLPRIFqcx0VEIsGHPmpfsVwIUcet0zbw
	 kXZzAF6t8a6cBO2pJ4JlfNm3fzS9TL9iSzmeoV8si1ItG/zcNuc2Zs7ueU+yMwTh4e
	 dSuiqO6d9aI6d4pcuBl3mVlvFrJH8TUj/AGs4UZDwYdmBwzZQWSUo+DEjyaYhR+CPK
	 V9DNT2Xv3tEjQc2sheetoZHTrFPifsWeBUl9WSzYUSSmkwOBNfQxiTK09EbQ2h6KTI
	 iqSieH/wN6fTGLDE3ntH8JbEcwbz/hiGrSSiBdDRyXfnBlRSqFLU/V5f5eqIBGuB82
	 JwKryh35moDlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A15AF40674;
	Sun, 22 Nov 2026 12:56:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9108B499
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D1AD80DF5
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zq8i-xgn4RVa for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 12:56:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C47DC80E04
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.18;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=K87T3jeQ
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C47DC80E04
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:56:17 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795352172; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:rO+YCH/F+62Pof8Gd6j2XscEXHN3
 WfRCRQq/tTHbQcx3HNizofdjFUmu2ljJRBEwG1NXgGJCPe6Xr+mIdN7McRUCh2cqskblmTAOtQQ
 nngguMGW/PMRzSjkZ1JLmHFpesEX6HbDKr6rbmx0r8u+hQBlmvsc3ma9kd2HANDb4a12XtNswf1
 Lcv0e+84F/vEprILTz/nppUPTzINKVMCmljkUvXkD175cjtEz5W76vWtC5ef/oREyXFbN4quIr0
 9JFfcdAbMqeW2OEA5FN3CvtwJO4MbO40nw8uY9oyp4V8irpqAyhPWxRkk4ohiImF05yEZrGcjuy
 z0HjKuaxOGA7Aw==;
Message-Instance: m=1; h=sha256: OHZQDqUmpINIUZgkd+YO+si045pouFhML0uBlZK1VIw=:
 pPcXWztSKOlpkKDIcYHFKwLvATye82ZGp+/1gii/654=, sha512:
 GZv4HUoW0a7aHN+I6InnxbKdfs1Vi2CzdiuNdx2I9BJT/9zoEikR9oc5zvMHMYGrGGevNqBEK7yyWFa8X8XS0w==:
 8CgU8LttEGGXA/lLTHJza4e0rbnzX7dN33w6xEgNUzjebLaLoMILoNYneguCBtQ6dYffg24oCqJlSr2hHj4q/g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795352168; x=1795956968; i=xypron.glpk@gmx.de;
 bh=9K5XtBrl10GhS54TpDdMsFOnmWqRAPaVqkZEqnJwcYA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=K87T3jeQexedHgHydIiA2SikysgWYTdChRqElhpJeooJV/kuqgCJxQyznz5FQCzs
 A0gU2IwfmActgAZyexrf4FR7l7XzHM0SFEdBLUk3orhHxg9w4iZl5RlWtrpY7cCmS
 TInQabGTzoLxWHwRlHng7+O3QDnYahxw/htvaxbfSiXBeTYh0oNc3xzTt09SSlWlh
 om3T0/G5BUi6Z3D44q4ZteIkS8HGfZWuazf6jVenArAIP88nBgCw/b1EYcRd+wDTx
 WOYj0/YiLvHGIydyHlMBJsON0aKJfDVyhQFKzAUlRjgsD7yNO7n1A4rmg+zK5+s/4
 /v4IhDSbBarJ9mX7rw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1xVeoQ0nPq-007Bzo; Sun, 22
 Nov 2026 13:56:08 +0100
Message-ID: <19e4f8f4-7af6-4d55-bbbd-cb79e0157110@gmx.de>
Date: Sun, 22 Nov 2026 13:56:05 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] efi_loader: Extract FW version even on authentication
 failure
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
References: <20261114-efi-fw-version-auth-fail-v2-1-f6f098fa406b@oss.qualcomm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20261114-efi-fw-version-auth-fail-v2-1-f6f098fa406b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YezBOOJnwLK6+oUHCuqoEq2O8oPpJBsOeLGzOHfVsDY0JkvD26v
 uf9vCF7dqfYcnR145uXNRJn24Txuqt8eMShm6qkwBTuBnyWc0jx6XDLZIeuXaPOdTIJ2yk3
 wh/A4xuhftmCz/AzG9eR0Wa18Lb11lLD7qSGpe0VLnD0BxNWaTsBR+kF6+thHJ39VeITmgK
 eHMDUPcxNU22ZzzjeD3fg==
UI-OutboundReport: notjunk:1;M01:P0:xWXHJD5/Y74=;SIPnzsxjyuTpuVTMm2tqawkexOk
 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
 Fjy8HPCEg==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/14/26 10:18, Balaji Selvanathan wrote:
> efi_firmware_capsule_authenticate() does not return the payload pointer
> and size when authentication fails. Instead it returns the
> authentication wrapper header. So its caller is not able read the
> payload information.
>=20
> So update efi_firmware_capsule_authenticate to return the payload
> pointer and size if an authentication fails.
>=20
> With that in place, move the efi_firmware_get_fw_version() call in
> efi_firmware_verify_image() ahead of the error check so the version is
> read whether or not authentication passed. A rejected capsule then
> reports its real version in ESRT rather than a stale one.
>=20
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Split out of the "efi_loader: track capsule last attempt status for
>    ESRT, add efidebug capsule images" series. No functional change.
> - Link to v1: https://lore.kernel.org/all/20260813-efi-esrt-last-attempt=
-v1-3-3be172f47d9d@oss.qualcomm.com/
> ---
>   lib/efi_loader/efi_firmware.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware=
.c
> index b41969c70fd..4836d723d75 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -403,6 +403,13 @@ efi_status_t efi_firmware_capsule_authenticate(cons=
t void **p_image,
>  =20
>   		if (status =3D=3D EFI_SECURITY_VIOLATION) {
>   			printf("Capsule authentication check failed. Aborting update\n");
> +			/*
> +			 * Even though authentication failed, skip past the
> +			 * auth wrapper so the caller can read the FMP payload
> +			 * header for version information.
> +			 */
> +			*p_image =3D capsule_payload;
> +			*p_image_size =3D capsule_payload_size;
>   			return status;
>   		} else if (status !=3D EFI_SUCCESS) {
>   			return status;
> @@ -540,11 +547,10 @@ efi_status_t efi_firmware_verify_image(const void =
**p_image,
>   	efi_guid_t *image_type_id;
>  =20
>   	ret =3D efi_firmware_capsule_authenticate(p_image, p_image_size);
> +	efi_firmware_get_fw_version(p_image, p_image_size, state);
>   	if (ret !=3D EFI_SUCCESS)
>   		return ret;
>  =20
> -	efi_firmware_get_fw_version(p_image, p_image_size, state);
> -
>   	image_type_id =3D efi_firmware_get_image_type_id(image_index);
>   	if (!image_type_id)
>   		return EFI_INVALID_PARAMETER;
>=20
> ---
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
> change-id: 20261114-efi-fw-version-auth-fail-7dcc0b2a7f70
>=20
> Best regards,

Hello Balaji,

thank you for looking into capsule updates.

Below is an AI generated review. Could you, please, check it and adjust=20
your patch as needed.

Summary

The pointer change does what it says: after a failed signature check
the caller gets a pointer to the FMP payload and can read the version
from it. But the version is stored in a local variable that is
dropped when SetImage() returns. The FmpStateXXXX variable and the
ESRT are not changed in any way.

The real problem is that U-Boot never records a failed update
attempt, which the spec requires. This patch does not fix that, and
reading the version from a payload that failed authentication is not
the right way to fix it.

Below: (1) what the spec requires, (2) what U-Boot does today,
(3) what the patch changes, (4) what should change, (5) safety
problems of the patch, (6) minor points.


1. What the UEFI spec requires

(Chapter 23: EFI_SYSTEM_RESOURCE_ENTRY, and "Adding and Removing
Devices from the ESRT")

  - Each time UpdateCapsule() is attempted for an ESRT entry, system
    firmware is *required* to update LastAttemptVersion and
    LastAttemptStatus.

  - Both values must be non-volatile (preserved across reboots).

  - LastAttemptStatus describes the result of the last attempt. For
    an authentication failure the matching value is
    LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR (0x5).

  - LastAttemptVersion is "the last firmware version for which an
    update was attempted". If the attempted version is not recorded
    due to limitations in the update process, it shall be zero after
    a failed update.

  - FwVersion is "the current version of the firmware resource". A
    failed attempt must not change it.


2. What U-Boot does today (before the patch)

  - GetImageInfo(), via efi_firmware_fill_version_info(), hardcodes
    last_attempt_version =3D 0 and last_attempt_status =3D
    LAST_ATTEMPT_STATUS_SUCCESS. ESRT copies these values
    (efi_esrt_image_info_to_entry()). After any failed update (bad
    signature, version too low, failed DFU write), ESRT therefore
    still says "no failed attempt".

  - The FmpStateXXXX variable is written only by
    efi_firmware_set_fmp_state_var(). It has two callers, at the end
    of efi_firmware_fit_set_image() and efi_firmware_raw_set_image(),
    reached only after verification and the write both succeeded.
    Only fw_version is stored. struct fmp_state has fields for
    last_attempt_version and last_attempt_status, but they are marked
    "not used".

  - FwVersion in ESRT is the version read back from FmpStateXXXX.

  - efi_update_capsule() takes "goto out" when a capsule fails, which
    skips efi_esrt_populate(). So even if the data existed, ESRT
    would not be rebuilt after a failure. For on-disk capsules,
    efi_launch_capsules() has no direct call either, and the table is
    built in efi_esrt_register() before the capsules are launched. I
    did not check what else might rebuild it there.

So the spec requirement is not met today. Failed attempts are
recorded neither in ESRT nor in the FmpStateXXXX variable.


3. What the patch changes

  - Pointer: efi_firmware_capsule_authenticate() now sets *p_image and
    *p_image_size from the output of efi_capsule_authenticate() when
    the signature check fails. efi_firmware_verify_image() now calls
    efi_firmware_get_fw_version() before looking at the status. So
    the FMP payload header is read from the rejected capsule.

  - Result: the version is written to state->fw_version. "state" is
    a local struct fmp_state in the two SetImage() functions. When
    efi_firmware_verify_image() fails they return at once:

        status =3D efi_firmware_verify_image(&image, &image_size,
                                           image_index, &state);
        if (status !=3D EFI_SUCCESS)
            return EFI_EXIT(status);     /* state is dropped here */

    Nothing is written to FmpStateXXXX, GetImageInfo() returns the
    same data as before, and ESRT is identical. On the success path
    the same call is made with the same inputs, only earlier.

  - Wrong field: the value goes into fw_version. If someone later
    persisted "state", efi_firmware_set_fmp_state_var() would store
    it as the installed version, and ESRT would report it as
    FwVersion. That contradicts the spec (see 1).

  - So the patch does not fix the missing LastAttemptVersion /
    LastAttemptStatus reporting. The last sentence of the commit
    message ("A rejected capsule then reports its real version in
    ESRT") is not true.


4. What should change

edk2's FmpDxe SetTheImage() (FmpDevicePkg/FmpDxe/FmpDxe.c) shows the
expected behaviour. It keeps Version, Lsv, LastAttemptStatus and
LastAttemptVersion in one FmpState variable, which is the same
design as U-Boot's FmpStateXXXX:

  - At the start of SetImage() it sets LastAttemptVersion to 0 to
    clear the previous result.

  - It authenticates the image first. On failure it records
    LastAttemptStatus and jumps to cleanup. The version is NOT read
    from an unauthenticated image, and LastAttemptVersion stays 0.

  - Only after the image passed authentication does it read the
    incoming version and store it as LastAttemptVersion. This covers
    failures such as "version too low", unsatisfied dependencies,
    power or thermal checks, and a failed device write.

  - cleanup always writes LastAttemptStatus. The descriptor is
    repopulated after SetImage() so that GetImageInfo() reports the
    new values. Version is updated only on success.

For U-Boot I suggest:

  a) In efi_firmware_fit_set_image() and efi_firmware_raw_set_image(),
     record the attempt on every exit path after the argument checks:
     write last_attempt_status and last_attempt_version to
     FmpStateXXXX. Do not write fw_version on failure; keep the
     existing value.

  b) Authentication failure: last_attempt_status =3D
     LAST_ATTEMPT_STATUS_ERROR_AUTH_ERROR (0x5) and
     last_attempt_version =3D 0. Do not parse the unauthenticated
     payload. With this, the pointer change in this patch is not
     needed for this purpose.

  c) Failures after successful authentication: use the incoming
     version for last_attempt_version, and for the status
     LAST_ATTEMPT_STATUS_ERROR_INCORRECT_VERSION (0x3) when the
     version is below the lowest supported version, or
     LAST_ATTEMPT_STATUS_ERROR_UNSUCCESSFUL (0x1) when the DFU/FIT
     write fails. The version read by efi_firmware_get_fw_version()
     is useful here, once the image is authenticated.

  d) In efi_firmware_fill_version_info(), read last_attempt_version
     and last_attempt_status from the variable instead of hardcoding
     0 and LAST_ATTEMPT_STATUS_SUCCESS. If no variable exists yet,
     keep reporting 0 / SUCCESS as the spec asks. FwVersion stays as
     it is.

  e) Make sure the ESRT is rebuilt after a failed capsule too (see
     the "goto out" in efi_update_capsule(), and the on-disk path).

  f) Add a test. A capsule with a bad signature should leave
     FwVersion unchanged, set LastAttemptStatus to 5 and
     LastAttemptVersion to 0.


5. Safety: the patch parses data that failed authentication

efi_capsule_authenticate() returns only EFI_SUCCESS or
EFI_SECURITY_VIOLATION. With this patch, what *p_image and
*p_image_size contain after a violation depends on where it failed:

  a) capsule =3D=3D NULL or capsule_size =3D=3D 0: the function exits befo=
re
     setting *image. The caller initialised capsule_payload to NULL
     and the size to 0, so *p_image becomes NULL and
     efi_firmware_get_fw_version() reads header->signature through
     it. SetImage() only checks "!image", so image_size =3D=3D 0 reaches
     this.

  b) efi_remove_auth_hdr() fails (buffer shorter than the auth
     header, or dwLength too small): *p_image is the raw wrapper
     start, and efi_firmware_get_fw_version() parses the
     authentication header as an FMP payload header.

  c) efi_remove_auth_hdr() succeeds with a large dwLength: it never
     checks dwLength against the image size. *p_image points past the
     end of the buffer and *image_size underflows. Before the patch
     the caller never read these values after a failure. Now
     efi_firmware_get_fw_version() dereferences the pointer and does
     "*p_image_size -=3D header->header_size".

  d) efi_firmware_get_fw_version() has no bounds checks. It does not
     check that the size is at least sizeof(struct fmp_payload_header)
     or that header_size fits in the size. That gap was already
     there, but it was only reachable after a successful signature
     check. The patch exposes it to unauthenticated input.

Any version number read from a capsule that failed the signature
check is attacker-controlled. As in edk2, it should not be trusted
or recorded.


6. Minor points

  - The new comment says "skip past the auth wrapper". That is only
    true when efi_remove_auth_hdr() succeeded.

  - The kernel-doc of efi_firmware_capsule_authenticate() still says
    the image pointer and size are updated "in case of success".

  - If the pointer change is kept for some other reason, please say
    so in the commit message and drop the ESRT claim.

Reference: UEFI specification chapter 23 ("EFI_SYSTEM_RESOURCE_ENTRY",
"Adding and Removing Devices from the ESRT"); edk2
FmpDevicePkg/FmpDxe/FmpDxe.c (SetTheImage()) and VariableSupport.c.

CCing Vincent as he is looking into EFI issues, too.

Best regards,

Heinrich

