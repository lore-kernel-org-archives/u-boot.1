Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E483C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 17:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B352583939;
	Fri, 25 Jul 2025 19:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RR/wBoG0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909FC8396F; Fri, 25 Jul 2025 19:56:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8371083710
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 19:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1753466200; x=1754071000; i=xypron.glpk@gmx.de;
 bh=r+uryOWdzhMJQFRzWQifJXfgvCFOI3KjtrI2/U2ACZE=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RR/wBoG0ZO2Mk2emiCIiex7lThoAwdYM8Fcpge3Y0GwHm2ZsLZK+tUxxJ5DbczWU
 Nd03P3DUMv38Nm5FKPS5IoHRrPxJtmwvgl0RdClAHe8L62dZHOMdRcgoxFTrDL59l
 rRvsNl8IQkceTCgu3OcZp+Px/vCz+PksT0l8xEtOis/znYYCfqtHYnD10+nut9zGG
 gF5Walylxeg7Nl0iER0VSxGfc4JBYBbhpPRVK3wqgh9ytaSYN0UVUCLVbYtZ57I7Z
 SLP9Rm07Pp/R9IOb4S2uBBqxQE/0biTOsH7GmvUE2DiFfnZHhdKHuDkTJxGSW9N6L
 bvthRkmUhFfk2MOi/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0G1n-1uSFSB0TQN-00sYj5; Fri, 25
 Jul 2025 19:56:40 +0200
Date: Fri, 25 Jul 2025 19:56:39 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] efi_loader: Add support for .wic files in URI boot path
User-Agent: Thunderbird for Android
In-Reply-To: <20250725173534.247188-1-javier.tia@linaro.org>
References: <20250725173534.247188-1-javier.tia@linaro.org>
Message-ID: <46A97A81-B04A-4BCC-A5EF-2639593DD86F@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vt6CHpgpte6rdFbyNWPN6Rwto02QkwVG5dr+cbhSya5s+VWrG5m
 v2gaCImKWkwR6hL1PRiFvv9y56Ee5nxET4edTgHJqjLWoStmVJnSnLk0RSATrgaxygtuQxT
 dnjHAtgFmTYzGM8sYBbkEdA58Hg9jVoFOpV55y41MBmxNpQOCcKj5SnlapkDsTpzK5b5z1j
 /fcb43G+PbZqYC8BxmWYg==
UI-OutboundReport: notjunk:1;M01:P0:r+X27PH9mkI=;SUWFbVPMq4skIVqD7OEorq9wbSN
 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
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

Am 25=2E Juli 2025 19:35:33 MESZ schrieb Javier Tia <javier=2Etia@linaro=2E=
org>:
>Together with current '=2Eiso' and '=2Eimg', the try_load_from_uri_path
>function now allows files with the '=2Ewic' extension as viable bootable
>images=2E

Why wouldn't you simply name your files *=2Eimg?

Shouldn't we get away from the DOS age routine of relying on filename exte=
nsions?

Just check if the fileheader is a PE header or if it is a known partitonin=
g scheme=2E

Best regards

Heinrich=20


>
>Very frequent in the Yocto project, the WIC files are disk image files,
>which should be handled similarly to other disk images: mounted as RAM
>disks and subsequently searched for the EFI boot file=2E
>
>This improvement enables the EFI boot manager of U-Boot to boot from WIC
>images downloaded via HTTP, therefore extending the supported image
>formats for network-based booting situations=2E
>
>Signed-off-by: Javier Tia <javier=2Etia@linaro=2Eorg>
>---
> lib/efi_loader/efi_bootmgr=2Ec | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/lib/efi_loader/efi_bootmgr=2Ec b/lib/efi_loader/efi_bootmgr=
=2Ec
>index 662993fb809=2E=2E587efee3169 100644
>--- a/lib/efi_loader/efi_bootmgr=2Ec
>+++ b/lib/efi_loader/efi_bootmgr=2Ec
>@@ -407,7 +407,7 @@ static efi_status_t efi_bootmgr_release_uridp(struct =
uridp_context *ctx)
> 	if (!ctx)
> 		return ret;
>=20
>-	/* cleanup for iso or img image */
>+	/* cleanup for iso, img, or wic image */
> 	if (ctx->ramdisk_blk_dev) {
> 		ret =3D efi_add_memory_map(ctx->image_addr, ctx->image_size,
> 					 EFI_CONVENTIONAL_MEMORY);
>@@ -516,13 +516,14 @@ static efi_status_t try_load_from_uri_path(struct e=
fi_device_path_uri *uridp,
> 	image_size =3D ALIGN(image_size, SZ_2M);
>=20
> 	/*
>-	 * If the file extension is "=2Eiso" or "=2Eimg", mount it and try to l=
oad
>+	 * If the file extension is "=2Eiso", "=2Eimg", or "=2Ewic", mount it a=
nd try to load
> 	 * the default file=2E
> 	 * If the file is PE-COFF image, load the downloaded file=2E
> 	 */
> 	uri_len =3D strlen(uridp->uri);
> 	if (!strncmp(&uridp->uri[uri_len - 4], "=2Eiso", 4) ||
>-	    !strncmp(&uridp->uri[uri_len - 4], "=2Eimg", 4)) {
>+	    !strncmp(&uridp->uri[uri_len - 4], "=2Eimg", 4) ||
>+	    !strncmp(&uridp->uri[uri_len - 4], "=2Ewic", 4)) {
> 		ret =3D prepare_loaded_image(lo_label, image_addr, image_size,
> 					   &loaded_dp, &blk);
> 		if (ret !=3D EFI_SUCCESS)

