Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954ECD3C548
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 04:02:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED63989169;
	Fri, 18 Oct 2024 06:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CoGPieHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A0389185; Fri, 18 Oct 2024 06:01:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F02D889141
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 06:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729224112; x=1729828912; i=xypron.glpk@gmx.de;
 bh=4FUGcBRunXwDPb/7iZcVz0REslAWfJPkRzx0oq23Msg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CoGPieHSqcRotIXln4tEMrKuJbloL2D3fSB/1dVDECAwXOm6UFY0wi3c3H9XlRhH
 icFuYxPD91aCkmHlc3tJqo9ctvAp391oS+0kgHRRlKFOjzP6e1CCB17VvEtA0V0BM
 O4QUzkjoLLIcJWdPKXDjsqrpBwGCOGeqE6z8zRgLw3RH7wLVnpUW3/HK/lP7bhqvq
 DQK04PieMQqUn4XhGoMwRmepQoFMakLJ3grLrXwfJ/qI6qg9qkElNIw2+/Eejiczn
 hBdl7XI2Wy4qG9EO//WwTNuywTGq8T3hJI52syeBFSaFVLYdkon8XUL51lHEupHzE
 V0Q1afl9ogObSKIE2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUs7-1tpjfF0O65-0159sw; Fri, 18
 Oct 2024 06:01:52 +0200
Date: Fri, 18 Oct 2024 06:01:50 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
User-Agent: K-9 Mail for Android
In-Reply-To: <20241017232413.724808-24-sjg@chromium.org>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
Message-ID: <0B48F871-BDD8-4810-ADA3-4F6C4E403B0C@gmx.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:DA2CAM6nkLCVqat5jHtJeHv8XYRAsnlZ3I2lnR886TfiBz1A7mT
 p9J39/ez6h+E+4TmSVryTTMSoyYH9onekeAssXxl6q57pPBhy7YrpFXyG4bpmcIiaw3b/V5
 JdGtIOsDrRk7RlYCDnOu6wYpYQr7YwHFc3J8ypX5C211BhuM8xcmUftv1ozLBIxXYnaTPie
 XhNaiqM9I6Qx1pEGTONvw==
UI-OutboundReport: notjunk:1;M01:P0:CXP6WINYADY=;5RhHE9FuA1CWqyK8sBMlQb9mIAx
 pu+kgj56Fao0t/QP7pXucC9dsTV33oBN5bWY1hybs/rVxBTfJIAIeRh2O95Eeyz78x0IV/sQy
 Chpl0Y978fgvOyXng14Oq/iXwojPwW1vZNJf2KUG5ILoVLFBkaqoOPS+/9d5I+WS/vzb3ogX1
 L+MnNcof15ZGHSW8SBGYwPkGb89OIIYFfpCqfGc96WoAMIHeyeLstGvc53NCe8fFkzexhSX3f
 J6XshdUsnwSaX8QSpCV/LAMDfX7hmxD+HDnfnVH/sd2C6lSEEST/nPwB6j1HMI1Mr3Ybmixtg
 cyJfRbjuxzNTXgYW0F706Y/HbdguiMwNLeqS0Ixgx8rDFZx4E5C6tPCVO2pOzO2CdOgAi5vqR
 94AwOrgzjkuEc7D3GFT2WD5gpQVTq4J8mYcAHCrfcPLEvH/P+8QxfZH70IBffPssHhNBeQs9c
 fw6Xfz2jA1oce8tiq+UiCN9wZoigZN6x8rPHjoAy2WM3IeIi597ROuHStsK94t7vQZjTLoPE/
 Vn44GVUxeO28xkBRuG1YtzD8gv62jSFuoykSpS1i9y/OvgVvbrCgu9EI7/RdMbiVh15+06JBE
 E1neLu+4Knwu9+1CY4oMc9EDSUhQpTQOKJTDOxy0ll79mFKMhsgtbopixu3MDh9J0ur0aI4S1
 4W9xKYZn9UJhdaEggR2S1uLcuTWem4rCKZZJgAWtUAOjR1+FFTPmFXj8Vz4yorz5TfMbffaBJ
 BRXvTW4SKwCPx9/kvV7JoY/sZGaQmfIRPjz4kv6Gf579TbnDKa7IeFHj+Cg4jmp5We79z1KIc
 fjupBrShs9xNxdWsZUXmW+OQ==
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



Am 18=2E Oktober 2024 01:24:02 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>We want to keep track of images which are loaded, or those which could
>perhaps be loaded=2E This will make it easier to manage memory allocation=
,
>as well as permit removal of the EFI set_efi_bootdev() hack=2E

Please, keep in mind that files can be loaded manually, e=2Eg=2E via the d=
hcp, the wget, and the loady commands=2E These are outside bootflows=2E

No matter how an EFI binary is loaded, we have to create the matching devi=
ce path=2E This requires knowledge of the source device and the  filepath o=
r URL=2E Please, ensure that you gather all necessary information=2E

Best regards

Heinrich

>
>Add a list of these, attached to the bootflow=2E For now the list is
>empty=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> boot/bootflow=2Ec    |  7 +++++++
> include/bootflow=2Eh | 21 +++++++++++++++++++++
> 2 files changed, 28 insertions(+)
>
>diff --git a/boot/bootflow=2Ec b/boot/bootflow=2Ec
>index 72b51ebd49b=2E=2E10bda8eac79 100644
>--- a/boot/bootflow=2Ec
>+++ b/boot/bootflow=2Ec
>@@ -455,10 +455,13 @@ void bootflow_init(struct bootflow *bflow, struct u=
device *bootdev,
> 	bflow->dev =3D bootdev;
> 	bflow->method =3D meth;
> 	bflow->state =3D BOOTFLOWST_BASE;
>+	alist_init_struct(&bflow->images, struct bootflow_img);
> }
>=20
> void bootflow_free(struct bootflow *bflow)
> {
>+	struct bootflow_img *img;
>+
> 	free(bflow->name);
> 	free(bflow->subdir);
> 	free(bflow->fname);
>@@ -467,6 +470,10 @@ void bootflow_free(struct bootflow *bflow)
> 	free(bflow->os_name);
> 	free(bflow->fdt_fname);
> 	free(bflow->bootmeth_priv);
>+
>+	alist_for_each(img, &bflow->images)
>+		free(img->fname);
>+	alist_empty(&bflow->images);
> }
>=20
> void bootflow_remove(struct bootflow *bflow)
>diff --git a/include/bootflow=2Eh b/include/bootflow=2Eh
>index 9b24fb5c3eb=2E=2E3d9a9e2025a 100644
>--- a/include/bootflow=2Eh
>+++ b/include/bootflow=2Eh
>@@ -7,7 +7,9 @@
> #ifndef __bootflow_h
> #define __bootflow_h
>=20
>+#include <alist=2Eh>
> #include <bootdev=2Eh>
>+#include <image=2Eh>
> #include <dm/ofnode_decl=2Eh>
> #include <linux/list=2Eh>
>=20
>@@ -85,6 +87,7 @@ enum bootflow_flags_t {
>  * @cmdline: OS command line, or NULL if not known (allocated)
>  * @x86_setup: Pointer to x86 setup block inside @buf, NULL if not prese=
nt
>  * @bootmeth_priv: Private data for the bootmeth
>+ * @images: List of loaded images (struct bootstd_img)
>  */
> struct bootflow {
> 	struct udevice *dev;
>@@ -109,6 +112,24 @@ struct bootflow {
> 	char *cmdline;
> 	void *x86_setup;
> 	void *bootmeth_priv;
>+	struct alist images;
>+};
>+
>+/**
>+ * struct bootflow_img - Information about an image which has been loade=
d
>+ *
>+ * This keeps track of a single, loaded image=2E
>+ *
>+ * @fname: Filename used to load the image (allocated)
>+ * @type: Image type (IH_TYPE_=2E=2E=2E)
>+ * @addr: Address to which the image was loaded, 0 if not yet loaded
>+ * @size: Size of the image
>+ */
>+struct bootflow_img {
>+	char *fname;
>+	enum image_type_t type;
>+	ulong addr;
>+	ulong size;
> };
>=20
> /**
