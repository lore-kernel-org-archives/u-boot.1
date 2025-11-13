Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7067CD6E44
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC58B83DDD;
	Thu, 13 Nov 2025 13:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gonkNINc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FE4783DE0; Thu, 13 Nov 2025 13:38:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3BA83D77
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1763037508; x=1763642308; i=xypron.glpk@gmx.de;
 bh=jlMTi5rwnj5oADL1wgG5cqeRRLrsjRv7Rq7I9T47d+U=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gonkNINc6OhWFD2kYSlLkzOPCU/ntVUs9nhVhp20AtFaptBJH64M6B6OmCQGt07u
 R04uHKdMsvmGuyw8LeTlzXkMBGSzvEWMVI6Axg4NrlQtSyrfpPOO+ZlDJNzqRPf8Z
 WMaqyYgl9konk3Fg9b+juiGUh1dfDW+47Bq9T0rEImnB94YPW1AKnV1vhQ3m3XIHo
 nyefaH9O85HFr36e5+aoJd9/rdqpEejJPvTvzPvcv9o4DihOKDYYhV/wElOlgwRIt
 1dZ5iNLeWRC12XLYvj6i/nGqVPi7TRrW2D9ek+5CZ0XeEzc+OgGT2d0rl6OHPU14+
 A1yVmp5+ne6Lgx2P4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.111.104]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmlT2-1w0sMv3M5m-00bYhi; Thu, 13 Nov 2025 13:38:28 +0100
Date: Thu, 13 Nov 2025 13:38:23 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Wadim Egorov <w.egorov@phytec.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_efi=5Floader=3A_Assure_fitImage_from?=
 =?US-ASCII?Q?_capsule_is_used_from_8-byte_aligned_address?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
References: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
Message-ID: <696DEFD8-38D9-467D-A044-20305DD3CC05@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j1Xpa/732Rl5EgihsGsQXbhi5gJNis9NYl6VGRSQUb0dGBhw95L
 MN/i3WR9wfVHrUv3dY8MqstlSMutSRiVgRMFjtCzxHcemkavgWI0hHserFIBpVUdnkdVw5B
 hiZhWX8WcKnzxGCqocqx4VBbz1R7nCCjI1LPVpT8MGONKZv8DCHPBXA5QDVSDK5ZglrZJUM
 mOCPoVnfAM1X6p74JGyUw==
UI-OutboundReport: notjunk:1;M01:P0:wU4wQp5OffM=;KjnLVEBSzKcd037H7UBJgl6mqK3
 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
 hg5kqQcw+4UEi5QnCNwsntd8qMyYh
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

Am 13=2E November 2025 12:55:49 MEZ schrieb Marek Vasut <marek=2Evasut+rene=
sas@mailbox=2Eorg>:
>The fitImage may be stored in EFI update capsule at address that
>is not aligned to 8 bytes=2E Since fitImage is a DT, new version of
>libfdt 1=2E7=2E2 rejects such an unaligned DT=2E Patch the code and copy
>the fitImage into aligned buffer in case it is not aligned=2E This
>does increase overhead for unaligned fitImages in EFI capsules, but
>tries to keep the overhead low for aligned ones=2E
>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>---
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Jonathan Humphreys <j-humphreys@ti=2Ecom>
>Cc: Mattijs Korpershoek <mkorpershoek@kernel=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: Wadim Egorov <w=2Eegorov@phytec=2Ede>
>Cc: u-boot@lists=2Edenx=2Ede
>---
> lib/efi_loader/efi_firmware=2Ec | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/lib/efi_loader/efi_firmware=2Ec b/lib/efi_loader/efi_firmwar=
e=2Ec
>index 216df83de67=2E=2E953a310190b 100644
>--- a/lib/efi_loader/efi_firmware=2Ec
>+++ b/lib/efi_loader/efi_firmware=2Ec
>@@ -651,6 +651,7 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
> 	efi_status_t status;
> 	struct fmp_state state =3D { 0 };
> 	char *orig_dfu_env;
>+	void *img;
>=20
> 	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
> 		  image_size, vendor_code, progress, abort_reason);
>@@ -677,7 +678,20 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
> 		return EFI_EXIT(EFI_DEVICE_ERROR);
> 	}
>=20
>-	ret =3D fit_update(image);
>+	/* Make sure the update fitImage is properly aligned to 8-bytes */
>+	if ((uintptr_t)image & 7) {
>+		img =3D memalign(8, image_size);
>+		if (!img)
>+			return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
>+		memcpy(img, image, image_size);
>+	} else {
>+		img =3D (void *)image;
>+	}
>+
>+	ret =3D fit_update(img);
>+
>+	if ((uintptr_t)image & 7)
>+		free(img);
>=20
> 	if (env_set("dfu_alt_info", orig_dfu_env))
> 		log_warning("Unable to restore env variable \"dfu_alt_info\"=2E  Furth=
er DFU operations may fail!\n");

