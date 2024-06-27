Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FCEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 19:28:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29060884FD;
	Thu, 27 Jun 2024 21:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="DxhzBU7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A7188435; Thu, 27 Jun 2024 21:28:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2B2884FD
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 21:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1719516485; x=1720121285; i=xypron.glpk@gmx.de;
 bh=kKOGQMceVscNsTfE0y7Cxjyo1t8nxzp0gomPTgbaHG8=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DxhzBU7NocdIPi/XXuHWi6MPBEmvRgf4/vBbSH77C9Fz2hM4b1M4noM2sKj47xzr
 gwH5KkWnXem6I8ueE6742JpqYhDln2EHkLuDk90sUWfPdOfcTHDIxOOotW9TXsx7s
 y0QEcWbdGzm9WMwH1MbYZ4Tlg8zJHqy2xwuBBpUV8N20WwphQ9AGOWFwkYOwe/pmI
 OgyewRMmLYaWtyPy3jyPuoAMhBMrFAy+q451OIOumlRnX+Dyv7Hx+7JF7I8aokwvp
 ye+H36PEgKhfq+q8G8n8aaklNbuCl2Qgub6lqya4N4JlrfHXvi9Zlkd6OX5EIXaPj
 x0+5myCXI/7rpApQzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([213.179.142.81]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1shtg21abv-00cxDG; Thu, 27
 Jun 2024 21:28:05 +0200
Date: Thu, 27 Jun 2024 21:28:04 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>,
 u-boot@lists.denx.de
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] bootstd: cros: store partition type in an efi_guid_t
User-Agent: K-9 Mail for Android
In-Reply-To: <20240627170629.2696427-1-vincent.stehle@arm.com>
References: <20240627170629.2696427-1-vincent.stehle@arm.com>
Message-ID: <13D2D563-69DD-4BD3-8A97-37B39A0B5D52@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vEt0h5v7Nvs0OOP0kEMGOTqno3Xz0/abFaO0qtXn5KPK6mJkfDz
 tQq5pxUE3DXSzNduJARpBnxSWPoOnaVzirHTBRSLzqSkx7YYm2gVXgE/2VpHI2x3o1LQZW8
 5XSePK8PFJW51eIDsrmPHxY4J3vayrwk7ItBqRpMql2qzN0HnqrycdEaVexvZuUEqQAzE9R
 njqwm/7qpZcJiaCVL+LhQ==
UI-OutboundReport: notjunk:1;M01:P0:NANbDOqCeOc=;Qi2S6+PFDQg1bj5w5asl0cMHrBZ
 9dmiH7lgdCffDwfW05VzwWLtnItfAJ7aUcE4aFw2xeqMreXpd+RQJ0eJ0F0oHN0ZH+RuG8XcM
 vgS20B1bnFwCrAApjyMm+2nHdORjJ7JvWHBCqFwsTcXXt2OcZWW6E8H5OjCLgh0jPCsqZod6I
 dMURsZ/aF4ZSgWbjQVaPgGTLH8j5A5lh83domCYue82loy7RU67bj1kXMxHTwXuQUVPO+NKv4
 Pcbwj9tMqr0zBl8UHSUJoZZteWfiV/7u5G2BxH81o5Ur8EQCcxXWOpn5pBzid6GZlcX4hIk00
 cMuQIZClJnYSve17V9dmJhDPgJ2S5cgVCAsXh9BWYxHq9tNAB/dKgxcHt3HjFU5Rg3cigCy8P
 yx/+HIdr4VlyG++WbYSrGb+76Tv3lHLIyZzooMUqgBNOrMOzsLfw25o/fgVZgGVduDU98KtPA
 Z9uZBsTSVw+Bxk9HTj5toiM0a9rf8LDdJUAi/62qGkOOuj/61g14fKed+/v9IB9KhcILoYsM1
 rkqgakckRObHSsT2nkljEsA/1c6ACf4Fx6/vu8mMQH9pMFh6lBvvWmdht7wZNixRmnMDSiE7W
 9oyJdrOvFV3m7ajnMGWc2I9FISAX3UF7wRJ4uockXvU/pB/CdxA7NmoffXo47eOylhWKL/9G5
 0ev+/LzPujRdiig1mZPkecyTfs46QnbZmjXdbI2NBbLhNydX1l5pHCSIJosiQ3kw9hTaApT6L
 Qa93CfA7FimIKy4MGFCdlinEdgJehMJXM4OUpUdmsPAVuWq9meXgMXkzM5mH079aJIog6ImeR
 MviCGGbEwbCHTxhXIu/bgkCwfzxteQPnj2O7P2Bz1ZcIs=
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



Am 27=2E Juni 2024 19:06:29 MESZ schrieb "Vincent Stehl=C3=A9" <vincent=2E=
stehle@arm=2Ecom>:
>The scan_part() function uses a struct uuid to store the little-endian
>partition type GUID, but this structure should be used only to contain a
>big-endian UUID=2E Use an efi_guid_t instead=2E
>
>Signed-off-by: Vincent Stehl=C3=A9 <vincent=2Estehle@arm=2Ecom>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>---
> boot/bootmeth_cros=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/boot/bootmeth_cros=2Ec b/boot/bootmeth_cros=2Ec
>index f015f2e1c75=2E=2E1f83c14aeab 100644
>--- a/boot/bootmeth_cros=2Ec
>+++ b/boot/bootmeth_cros=2Ec
>@@ -148,7 +148,7 @@ static int scan_part(struct udevice *blk, int partnum=
,
> {
> 	struct blk_desc *desc =3D dev_get_uclass_plat(blk);
> 	struct vb2_keyblock *hdr;
>-	struct uuid type;
>+	efi_guid_t type;

Does Chrome OS only support GPT partitioning?

> 	ulong num_blks;
> 	int ret;
>=20
>@@ -161,7 +161,7 @@ static int scan_part(struct udevice *blk, int partnum=
,
>=20
> 	/* Check for kernel partition type */
> 	log_debug("part %x: type=3D%s\n", partnum, info->type_guid);
>-	if (uuid_str_to_bin(info->type_guid, (u8 *)&type, UUID_STR_FORMAT_GUID)=
)
>+	if (uuid_str_to_bin(info->type_guid, type=2Eb, UUID_STR_FORMAT_GUID))
> 		return log_msg_ret("typ", -EINVAL);

struct disk_partition containing a string which is only needed in the CLI =
instead of the 16 byte GUID was a bad idea to start with=2E Shouldn't we re=
place it or add least add a GUID field instead of first converting to strin=
g and than back to GUID?

>=20
> 	if (memcmp(&cros_kern_type, &type, sizeof(type)))

You could use the guidcmp() macro here=2E

Best regards

Heinrich

