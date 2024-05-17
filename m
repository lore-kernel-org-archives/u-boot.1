Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78EDC25B74
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 01:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024DA88459;
	Fri, 17 May 2024 03:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="U0TbR1Oa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96E1688459; Fri, 17 May 2024 03:44:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97897883AE
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 03:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715910277; x=1716515077; i=xypron.glpk@gmx.de;
 bh=pM346XSOyOSSMPIsZrhsWFMyQQ4RHYUcifPuNat8cqQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=U0TbR1Oaus0zBQoOMJPz2J3ztnFXORIc1O0aD/Cet5xOxHGwRMu6YSZ9a4pFBLi7
 EUA6fcthXUYxFcCpIi4eUE/5J0N3wHm254TNRAggUkJIPe0YbpWWZlKyxwvzh1szy
 C1zxyl48bc9xKkAn30CE4ZUVYj5+EgBIuZV+twIKJunenVCGiv3qPr0sp+pe7+d1n
 kWJABUuqsTR3DfHOaBPa22dtKCU9tI2YTEzLpS4LK1BR3dxaVszEWxUNrmtWO8REP
 zosojbIhlbA49BNAZPh8mIOhAstMH4mcBCrLvXb9MhIY8jXSrt1Jn9+lii46Ab07o
 HjBtF4MlLiHPFLsFWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([149.11.192.251]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1sXWi72d9e-010PNg; Fri, 17
 May 2024 03:44:37 +0200
Date: Fri, 17 May 2024 03:44:35 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_2/2=5D_efi=3A_gop=3A_Mark_pixel=5F?=
 =?US-ASCII?Q?format_as_BLTONLY_if_we_have_sync_hook?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240517-virtio_gpu-v1-2-6353b87472c7@flygoat.com>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
 <20240517-virtio_gpu-v1-2-6353b87472c7@flygoat.com>
Message-ID: <2227C151-FA5E-4649-89D4-989B7DE32930@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oSKo1qqwpP9rObT5VZPn0ra9k7BzjDggIziyStjwekkMiIJ5y1t
 FkEIxPtBdy9JS4DVZageFS0st3ShWHnZS1QsEZ+NjcS9Ayz6kxyIvJ/KYr6UMm24UeuNYgF
 s++e9dRj4R3tbogmXJ7Iq2DnFWn4mdt+9MPfRTtUuNl6ER/u/H1e93LDBnoXWP3JC+X2F0X
 XBSJwnt4QmY+92dopyr4g==
UI-OutboundReport: notjunk:1;M01:P0:cHKWZg0SKN4=;pBAXs6uQ+DvG/Hnk4qALkDEI7F6
 ShqLvq5JxpR/4HR24rYzhqkMbKqRMfZW71Z4DFFmFH1t6Ns64CvVrcWzIo+jPNSHaDXW4Zb/u
 dLLDHRXVNt4AdruhpWrAC8En0GDMEAdL5eaAPGLGGW/D5U0NU/c701fAY7ibPzBvZsv603QKf
 JOtu29A95qUTegnHPBuCTELQjlG6vjfLxNwQJuSxDiJ7hdm+/iHfsmjZvqX0X+u0rDvCI5vNF
 mXP9NOFr7zyogUhYqSrMGAPxFc/Q6GstiqUIxofRIqmW5XPfjZWuqH0Ofi9Z9PUc66UoWoBrT
 mbkyPJOjDHeKqelw4xAbgL4rrYtFNLQywAzmyKLCfNY44sBXPib00IX3erAG5hqoiBq6HTY2w
 LEgflq0CAjz9Ctbz3Nwg7vGuhPo8xpdNmReTu9ne2/Ox5UkNhM25bD8Oo1R2HFqnSh+mq3d6t
 KCbB+Q5mbzXIj8G8vGxuTlzbo3b5QtWM86j/dFC+0ys6Ky/ZXSWsqB6fhtDpDmN93iYiU/9iG
 Bv0fdQeg1tNfbPlF3sub+zuzaRnZORR8tjqu4CxEXCv4mMLYg9JCbj3aiMta5RvHEBRWBRv4i
 Nji3gWO414SM2uwd9i2LTcaqjiEupFBlMN1UDkn3rpZ/optMepEldK0wZhwkE/o0llcVk4/T4
 am6evhbHKPuHM7XhrLk7RQgU3nKSnJ9j7BzEqYNWjE6pVTOZNvq7uy5Yo/30Ijtq7Ojrfm4tp
 oec2rX9W1ygxK/M1bWlRMi6cX6Z9Zq3xYcV0I9l6bQcv0wetCvLQx4V3ljbwitK+RqYhCKqUF
 eSj59uDguccv7u7BVGeiST6MBqzcLejeGNYMjjZFIInPk=
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



Am 17=2E Mai 2024 01:03:25 MESZ schrieb Jiaxun Yang <jiaxun=2Eyang@flygoat=
=2Ecom>:
>If a video device has a video_sync hook, it means some software
>intervene is required to scanout framebuffer up on change=2E
>
>That means EFI application can't just use it as raw framebuffer,
>it should call BLT operation to let U-Boot help with scanout=2E
>
>Mark pixel format as BLTONLY as per UEFI spec to reflect this
>nature=2E
>
>Signed-off-by: Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom>
>---
> include/efi_api=2Eh        | 1 +
> lib/efi_loader/efi_gop=2Ec | 9 ++++++++-
> 2 files changed, 9 insertions(+), 1 deletion(-)
>
>diff --git a/include/efi_api=2Eh b/include/efi_api=2Eh
>index ab40b1b5ddf6=2E=2E3eaefb322878 100644
>--- a/include/efi_api=2Eh
>+++ b/include/efi_api=2Eh
>@@ -1399,6 +1399,7 @@ struct efi_hii_config_access_protocol {
> #define EFI_GOT_RGBA8		0
> #define EFI_GOT_BGRA8		1
> #define EFI_GOT_BITMASK		2
>+#define EFI_GOT_BLTONLY		3
>=20
> struct efi_gop_mode_info {
> 	u32 version;
>diff --git a/lib/efi_loader/efi_gop=2Ec b/lib/efi_loader/efi_gop=2Ec
>index 41e12fa72460=2E=2E784d43d3d39b 100644
>--- a/lib/efi_loader/efi_gop=2Ec
>+++ b/lib/efi_loader/efi_gop=2Ec
>@@ -467,10 +467,12 @@ efi_status_t efi_gop_register(void)
> 	struct efi_gop_obj *gopobj;
> 	u32 bpix, format, col, row;
> 	u64 fb_base, fb_size;
>+	bool needs_sync;
> 	efi_status_t ret;
> 	struct udevice *vdev;
> 	struct video_priv *priv;
> 	struct video_uc_plat *plat;
>+	struct video_ops *ops;
>=20
> 	/* We only support a single video output device for now */
> 	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
>@@ -485,6 +487,7 @@ efi_status_t efi_gop_register(void)
> 	row =3D video_get_ysize(vdev);
>=20
> 	plat =3D dev_get_uclass_plat(vdev);
>+	ops =3D video_get_ops(vid);
> 	fb_base =3D IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->bas=
e;

Wasn't this line introduced to handle the video sync case by pointing the =
EFI application to target framebuffer?

Best regards

Heinrich

> 	fb_size =3D plat->size;
>=20
>@@ -529,7 +532,11 @@ efi_status_t efi_gop_register(void)
> 	gopobj->info=2Eversion =3D 0;
> 	gopobj->info=2Ewidth =3D col;
> 	gopobj->info=2Eheight =3D row;
>-	if (bpix =3D=3D VIDEO_BPP32)
>+
>+	if (ops && ops->video_sync) {
>+		/* Applications can't really use it as framebuffer */
>+		gopobj->info=2Epixel_format =3D EFI_GOT_BLTONLY;
>+	} else if (bpix =3D=3D VIDEO_BPP32)
> 	{
> 		if (format =3D=3D VIDEO_X2R10G10B10) {
> 			gopobj->info=2Epixel_format =3D EFI_GOT_BITMASK;
>
